Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDAB211BB
	for <e@80x24.org>; Fri, 28 Dec 2018 01:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbeL1Bro (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 20:47:44 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:48363 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeL1Brn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 20:47:43 -0500
Received: by mail-yb1-f201.google.com with SMTP id t2-v6so14628803ybg.15
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f+SEpc9R45MA5Go9N/Z280G/UAOyfGaQSJXzsFj7kCM=;
        b=IN5EcdqTQ4yemCt74ZDM8DHDRevIh0peOS4HseGicN4ldhU+ab3pQcFPxfqfSoBIcy
         ORDjoXvgalZSuHxalqkoz2f9HpG0ApPjb40JpuPPwJQPG8DrqnX4pAsECk5Cdtn3i40T
         S1fl3YMGWEgYvJm+Gdiafj7oy9vewdSka5ABiOPr9f6QqDjISeM2KpqiUpWwnEQNpXZp
         FWoDEER0rQi/n9MxWm+Xk+KBBrWi6tWV1FWBAaX0eo+u3ua9yfrZfoLIJCtZU3PjcAgl
         Mb/wk3+KWf83gnIuuR3Dl7TQz5W1VWeye/pkwwBK30FS28xfK7wqgsLMZxW0GUa6z2Ei
         jrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f+SEpc9R45MA5Go9N/Z280G/UAOyfGaQSJXzsFj7kCM=;
        b=pjXjTFYtCWV9AL6YrW3f/KNS/l7TVBJrI2aNpoexq1kV5ZvK9Cg6A6hgkdJTv4B677
         3kDTxy8vPL+CkWIT6eoCCx5/n8Z0zSKCVCt1ov8PeBR84IFPFIExblTlTCSeOs9g/xOZ
         Z6+WLxene6v8nOCOuFMN2bJEKCsm4UINwoUV2E+oNGVKCRaINDN6SiBKRyNa6uHSIJ+7
         Ei+LH9YfBjifYytU8O9Sg9zah+YHpLfosl7HoikYGuE1IQTTVzibAq0eB1NFBuXZzvIJ
         a2ocd5XPTc+GR+eqqfeVBySOBKFU74BZagWJ6mAk09nZuny0Nj6XnE8unwa6IIK1Gtim
         Wrzg==
X-Gm-Message-State: AA+aEWY1PGo5uwQNVIYySnwzGxENTk+gpNL76+ktdQmtMVphPG5JcbVf
        rPxM4pEBpq95/NfgFx9kKYDm8XtAXOjiGhTRiozRDNS7YpcWIeTPzmc3GB9QSh5UUoN0imosMHw
        gb4aXUDEwiAzBHxMk+P1zLxYp7xCDvz1g9gANNK3p6qO1LgyuB2SloRia57VRFddi/VI8HHTF7w
        ==
X-Google-Smtp-Source: ALg8bN6KsBiyS8ChVGlqLuMmISoLzkLQBwtmZKbA952CU7ORCWLZ4OMKQbyLZPK+OguZvEHgLIBtMXzxKJRoraufmOA=
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr12891342ybg.16.1545961662368;
 Thu, 27 Dec 2018 17:47:42 -0800 (PST)
Date:   Thu, 27 Dec 2018 17:47:19 -0800
Message-Id: <20181228014720.206443-1-masayasuzuki@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH 1/2] Change how HTTP response body is returned
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes the way HTTP response body is returned in
http_request_reauth and post_rpc.

1. http_request_reauth makes up to two requests; one without a
   credential and one with a credential. The first request can fail if
   it needs a credential. When the keep_error option is specified, the
   response to the first request can be written to the HTTP response
   body destination. If the response body destination is a string
   buffer, it erases the buffer before making the second request. By
   introducing http_response_dest, it can handle the case that the
   destination is a file handle.
2. post_rpc makes an HTTP request and the response body is directly
   written to a file descriptor. This makes it check the HTTP status
   code before writing it, and do not write the response body if it's an
   error response. It's ok without this check now because post_rpc makes
   a request with CURLOPT_FAILONERROR, and libcurl won't call the
   callback if the response has an error status code.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 http.c        | 99 +++++++++++++++++++++++++++++----------------------
 remote-curl.c | 29 ++++++++++++---
 2 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/http.c b/http.c
index eacc2a75e..d23417670 100644
--- a/http.c
+++ b/http.c
@@ -165,6 +165,19 @@ static int http_schannel_check_revoke = 1;
  */
 static int http_schannel_use_ssl_cainfo;
 
+/*
+ * Where to store the result of http_request.
+ *
+ * At most one of buffer or file can be non-NULL. The buffer and file are not
+ * allocated by http_request, and the caller is responsible for releasing them.
+ */
+struct http_response_dest {
+	struct strbuf *buffer;
+
+	FILE *file;
+	const char *filename;
+};
+
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
@@ -1794,12 +1807,8 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
 	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
 }
 
-/* http_request() targets */
-#define HTTP_REQUEST_STRBUF	0
-#define HTTP_REQUEST_FILE	1
-
 static int http_request(const char *url,
-			void *result, int target,
+			struct http_response_dest *dest,
 			const struct http_get_options *options)
 {
 	struct active_request_slot *slot;
@@ -1812,21 +1821,23 @@ static int http_request(const char *url,
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
-	if (result == NULL) {
-		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
-	} else {
+	if (dest->file) {
+		off_t posn = ftello(dest->file);
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
-		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
-
-		if (target == HTTP_REQUEST_FILE) {
-			off_t posn = ftello(result);
-			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite);
-			if (posn > 0)
-				http_opt_request_remainder(slot->curl, posn);
-		} else
-			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
-					 fwrite_buffer);
+		curl_easy_setopt(slot->curl, CURLOPT_FILE,
+				 dest->file);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+				 fwrite);
+		if (posn > 0)
+			http_opt_request_remainder(slot->curl, posn);
+	} else if (dest->buffer) {
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+		curl_easy_setopt(slot->curl, CURLOPT_FILE,
+				 dest->buffer);
+		curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
+				 fwrite_buffer);
+	} else {
+		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
 	}
 
 	accept_language = get_accept_language();
@@ -1930,10 +1941,10 @@ static int update_url_from_redirect(struct strbuf *base,
 }
 
 static int http_request_reauth(const char *url,
-			       void *result, int target,
+			       struct http_response_dest *dest,
 			       struct http_get_options *options)
 {
-	int ret = http_request(url, result, target, options);
+	int ret = http_request(url, dest, options);
 
 	if (ret != HTTP_OK && ret != HTTP_REAUTH)
 		return ret;
@@ -1949,32 +1960,34 @@ static int http_request_reauth(const char *url,
 	if (ret != HTTP_REAUTH)
 		return ret;
 
-	/*
-	 * If we are using KEEP_ERROR, the previous request may have
-	 * put cruft into our output stream; we should clear it out before
-	 * making our next request. We only know how to do this for
-	 * the strbuf case, but that is enough to satisfy current callers.
-	 */
-	if (options && options->keep_error) {
-		switch (target) {
-		case HTTP_REQUEST_STRBUF:
-			strbuf_reset(result);
-			break;
-		default:
-			BUG("HTTP_KEEP_ERROR is only supported with strbufs");
+	if (dest->file) {
+		/*
+		 * At this point, the file contains the response body of the
+		 * previous request. We need to truncate the file.
+		 */
+		FILE *new_file = freopen(dest->filename, "w", dest->file);
+		if (new_file == NULL) {
+			error("Unable to open local file %s", dest->filename);
+			return HTTP_ERROR;
 		}
+		dest->file = new_file;
+	} else if (dest->buffer) {
+		strbuf_reset(dest->buffer);
 	}
 
 	credential_fill(&http_auth);
 
-	return http_request(url, result, target, options);
+	return http_request(url, dest, options);
 }
 
 int http_get_strbuf(const char *url,
-		    struct strbuf *result,
+		    struct strbuf *dest_buffer,
 		    struct http_get_options *options)
 {
-	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
+	struct http_response_dest dest;
+	dest.file = NULL;
+	dest.buffer = dest_buffer;
+	return http_request_reauth(url, &dest, options);
 }
 
 /*
@@ -1988,18 +2001,20 @@ static int http_get_file(const char *url, const char *filename,
 {
 	int ret;
 	struct strbuf tmpfile = STRBUF_INIT;
-	FILE *result;
+	struct http_response_dest dest;
 
 	strbuf_addf(&tmpfile, "%s.temp", filename);
-	result = fopen(tmpfile.buf, "a");
-	if (!result) {
+	dest.buffer = NULL;
+	dest.file = fopen(tmpfile.buf, "a");
+	if (!dest.file) {
 		error("Unable to open local file %s", tmpfile.buf);
 		ret = HTTP_ERROR;
 		goto cleanup;
 	}
+	dest.filename = tmpfile.buf;
 
-	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
-	fclose(result);
+	ret = http_request_reauth(url, &dest, options);
+	fclose(dest.file);
 
 	if (ret == HTTP_OK && finalize_object_file(tmpfile.buf, filename))
 		ret = HTTP_ERROR;
diff --git a/remote-curl.c b/remote-curl.c
index 1220dffcd..48656bf18 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -546,14 +546,31 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
+struct rpc_in_data {
+	struct rpc_state *rpc;
+	struct active_request_slot *slot;
+};
+
+/*
+ * A callback for CURLOPT_WRITEFUNCTION. The return value is the bytes consumed
+ * from ptr.
+ */
 static size_t rpc_in(char *ptr, size_t eltsize,
 		size_t nmemb, void *buffer_)
 {
 	size_t size = eltsize * nmemb;
-	struct rpc_state *rpc = buffer_;
+	struct rpc_in_data *data = buffer_;
+	long response_code;
+
+	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
+			      &response_code) != CURLE_OK)
+		return size;
+	if (response_code != 200)
+		return size;
+
 	if (size)
-		rpc->any_written = 1;
-	write_or_die(rpc->in, ptr, size);
+		data->rpc->any_written = 1;
+	write_or_die(data->rpc->in, ptr, size);
 	return size;
 }
 
@@ -633,6 +650,7 @@ static int post_rpc(struct rpc_state *rpc)
 	size_t gzip_size = 0;
 	int err, large_request = 0;
 	int needs_100_continue = 0;
+	struct rpc_in_data rpc_in_data;
 
 	/* Try to load the entire request, if we can fit it into the
 	 * allocated buffer space we can use HTTP/1.0 and avoid the
@@ -765,8 +783,9 @@ static int post_rpc(struct rpc_state *rpc)
 
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
-	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
-
+	rpc_in_data.rpc = rpc;
+	rpc_in_data.slot = slot;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
 
 	rpc->any_written = 0;
 	err = run_slot(slot, NULL);
-- 
2.20.1.415.g653613c723-goog

