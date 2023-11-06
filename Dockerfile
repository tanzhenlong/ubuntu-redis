FROM ubuntu:latest
MAINTAINER devops@citicsinfo.com
ENV REDIS_VERSION 5.0.14
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-5.0.14.tar.gz

RUN  groupadd -r -g 999 redis && useradd -r -g redis -u 999 redis &&  apt-get update && apt-get  install -y wget gcc make   &&  apt-get upgrade -y  && wget -O redis.tar.gz  "$REDIS_DOWNLOAD_URL"  &&  mkdir -p /usr/src/redis && tar -xvf redis.tar.gz -C /usr/src/redis  --strip-components=1 && rm -rf redis.tar.gz  && make -C /usr/src/redis  install  && mkdir /data && chown redis:redis /data  && rm -rf /var/lib/apt/lists/*
VOLUME /data 
WORKDIR /data
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 6379
CMD ["redis-server"]
