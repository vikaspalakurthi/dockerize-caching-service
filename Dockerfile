FROM centos:latest
ENV PORT $PORT
ENV REDIS_URL localhost
RUN yum install -y epel-release \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y python2-pip python36 python36-pip redis supervisor
COPY ./cache-service/ /cache-service
RUN pip3 install flask==1.0.2 redis==3.0.1
WORKDIR /cache-service
RUN mkdir -p /etc/supervisor \
    && cp caching-service-supervisor.conf /etc/supervisor/supervisord.conf \
    && touch /tmp/supervisord.log
EXPOSE 5000
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

