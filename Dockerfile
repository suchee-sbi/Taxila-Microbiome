# Create image: docker build -t taxila-microbiome:0.0.1 -f Dockerfile .
# Create container: docker create --name taxila-microbiome -p 13853:13853 taxila-microbiome:0.0.1
FROM python:3.8
WORKDIR /taxila-microbiome
COPY . ./
RUN pip install -r binder/requirements.txt
RUN pip install appmode
RUN jupyter nbextension enable --py --sys-prefix appmode
RUN jupyter serverextension enable --py --sys-prefix appmode
EXPOSE 13853
CMD ["jupyter", "notebook", "--port=13853", "--allow-root", "--ip='*'", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.disable_check_xsrf=True",  "--NotebookApp.allow_origin='*'", "--NotebookApp.tornado_settings={'headers':{'Content-Security-Policy': 'frame-ancestors * self'}}"]