Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280011F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeACATX (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:23 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:33276 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeACATV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:21 -0500
Received: by mail-it0-f68.google.com with SMTP id o130so12559314itg.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Jb5ng7fWLSNOLDWIN1y4rklFYMK45/zE1VhlUFDNJo=;
        b=KfWehTYYSd0b05aGOCfOX0liKbUajl2OWlI9MxsBNAr/E2su0ipIBVAT6M55tMsTeX
         SrCeEflUnriSZMeRP5jdeCEQM1TRQqttYs4Tco9ZYYJat5z6uyHbfETeIhXP+DjQGg/S
         yg4trjjR7btUzKOk5F1zf1pcV5GcA07VcV4OlNRyjR8WYiz4hD1GbkOcd6MU05vACh6b
         TK3uV4MjC56SxoUiWWJucS2dbVz94SY9sTxJGosBEWxm+EjPt3Var7VAhO1ZXabRquT8
         w/QlCbbPiEEdABnijGTItGwAMro+kYLC8r1jWVPJ9+M72pB7fOHA2CYgd2RRazEm61AD
         YTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Jb5ng7fWLSNOLDWIN1y4rklFYMK45/zE1VhlUFDNJo=;
        b=JIttAKHMvIJDmTKjcKUIeHLrETnqxR4xkD7tWg998Mzac8VfAf6S6HtR/K3kh21WOj
         KVK3bc4nweqNKRR2mooud2Xd+jRwKfAbAStbLYNBCwLj85/uGe79RuBhb1wyiFY+aCyt
         8TGTSbS7q1KrDFGpzun6to8mDvnYX/LrQ3MgeKsSmadhQRX8H4yr1eEqBcZY6xw8AU6I
         5QcYVB4XVigVOG7pJmVoAGzEctTdCGdglUUiaFxZI8hZElCXvusR4l1+IuU3j984vf8F
         /fCKzqwaJCsyoYlMdWUGSZoDDJ9uCSh3qpKjCA3mIo1PdFnwMgTcyQK6+ifF+J8b9e7T
         EDyA==
X-Gm-Message-State: AKGB3mJo/718X4YjxO/XwBW02ZvWn4L4ANLpf3DOynH60XdperQVbNrU
        OAcxnTP/0nbzySse2BlztKFdcUyLTLQ=
X-Google-Smtp-Source: ACJfBosMWkGlPrchBtb3NFA2RoaxlSRuSW0Hx5ti6phRs2FDVq+aw+ucli3wx0Q4BJIwrdpYikwwqA==
X-Received: by 10.36.172.73 with SMTP id m9mr13868iti.120.1514938759902;
        Tue, 02 Jan 2018 16:19:19 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:19 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 26/26] remote-curl: implement connect-half-duplex command
Date:   Tue,  2 Jan 2018 16:18:28 -0800
Message-Id: <20180103001828.205012-27-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach remote-curl the 'connect-half-duplex' command which is used to
establish a half-duplex connection with servers which support protocol
version 2.  This allows remote-curl to act as a proxy, allowing the git
client to communicate natively with a remote end, simply using
remote-curl as a pass through to convert requests to http.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c          | 185 ++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5701-protocol-v2.sh |  41 +++++++++++
 2 files changed, 224 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4086aa733..b63b06398 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -171,6 +171,7 @@ struct discovery {
 	size_t len;
 	struct ref *refs;
 	struct oid_array shallow;
+	enum protocol_version version;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -184,9 +185,13 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	heads->version = discover_version(&reader);
+	switch (heads->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		/*
+		 * Do nothing.  Client should run 'connect-half-duplex' and
+		 * request the refs themselves.
+		 */
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -1047,6 +1052,178 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
+struct proxy_state {
+	char *service_name;
+	char *service_url;
+	char *hdr_content_type;
+	char *hdr_accept;
+	struct strbuf request_buffer;
+	int in;
+	int out;
+	struct packet_reader reader;
+	size_t pos;
+	int seen_flush;
+};
+
+static void proxy_state_init(struct proxy_state *p, const char *service_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	memset(p, 0, sizeof(*p));
+	p->service_name = xstrdup(service_name);
+
+	p->in = 0;
+	p->out = 1;
+	strbuf_init(&p->request_buffer, 0);
+
+	strbuf_addf(&buf, "%s%s", url.buf, p->service_name);
+	p->service_url = strbuf_detach(&buf, NULL);
+
+	strbuf_addf(&buf, "Content-Type: application/x-%s-request", p->service_name);
+	p->hdr_content_type = strbuf_detach(&buf, NULL);
+
+	strbuf_addf(&buf, "Accept: application/x-%s-result", p->service_name);
+	p->hdr_accept = strbuf_detach(&buf, NULL);
+
+	packet_reader_init(&p->reader, p->in, NULL, 0,
+			   PACKET_READ_GENTLE_ON_EOF);
+}
+
+static void proxy_state_clear(struct proxy_state *p)
+{
+	free(p->service_name);
+	free(p->service_url);
+	free(p->hdr_content_type);
+	free(p->hdr_accept);
+	strbuf_release(&p->request_buffer);
+}
+
+static size_t proxy_in(void *ptr, size_t eltsize,
+		       size_t nmemb, void *buffer_)
+{
+	size_t max = eltsize * nmemb;
+	struct proxy_state *p = buffer_;
+	size_t avail = p->request_buffer.len - p->pos;
+
+	if (!avail) {
+		if (p->seen_flush) {
+			p->seen_flush = 0;
+			return 0;
+		}
+
+		strbuf_reset(&p->request_buffer);
+		switch (packet_reader_read(&p->reader)) {
+		case PACKET_READ_EOF:
+			die("error reading request from parent process");
+		case PACKET_READ_NORMAL:
+			packet_buf_write_len(&p->request_buffer, p->reader.line,
+					     p->reader.pktlen);
+			break;
+		case PACKET_READ_DELIM:
+			packet_buf_delim(&p->request_buffer);
+			break;
+		case PACKET_READ_FLUSH:
+			packet_buf_flush(&p->request_buffer);
+			p->seen_flush = 1;
+			break;
+		}
+		p->pos = 0;
+		avail = p->request_buffer.len;
+	}
+
+	if (max < avail)
+		avail = max;
+	memcpy(ptr, p->request_buffer.buf + p->pos, avail);
+	p->pos += avail;
+	return avail;
+}
+static size_t proxy_out(char *ptr, size_t eltsize,
+			size_t nmemb, void *buffer_)
+{
+	size_t size = eltsize * nmemb;
+	struct proxy_state *p = buffer_;
+
+	write_or_die(p->out, ptr, size);
+	return size;
+}
+
+static int proxy_post(struct proxy_state *p)
+{
+	struct active_request_slot *slot;
+	struct curl_slist *headers = http_copy_default_headers();
+	int err;
+
+	headers = curl_slist_append(headers, p->hdr_content_type);
+	headers = curl_slist_append(headers, p->hdr_accept);
+	headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+
+	slot = get_active_slot();
+
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
+
+	/* Setup function to read request from client */
+	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, proxy_in);
+	curl_easy_setopt(slot->curl, CURLOPT_READDATA, p);
+
+	/* Setup function to write server response to client */
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
+
+	err = run_slot(slot, NULL);
+
+	if (err != HTTP_OK)
+		err = -1;
+
+	curl_slist_free_all(headers);
+	return err;
+}
+
+static int connect_half_duplex(const char *service_name)
+{
+	struct discovery *discover;
+	struct proxy_state p;
+
+	/*
+	 * Run the info/refs request and see if the server supports protocol
+	 * v2.  If and only if the server supports v2 can we successfully
+	 * establish a half-duplex connection, otherwise we need to tell the
+	 * client to fallback to using other transport helper functions to
+	 * complete their request.
+	 */
+	discover = discover_refs(service_name, 0);
+	if (discover->version != protocol_v2) {
+		printf("fallback\n");
+		fflush(stdout);
+		return -1;
+	} else {
+		/* Half-Duplex Connection established */
+		printf("\n");
+		fflush(stdout);
+	}
+
+	proxy_state_init(&p, service_name);
+
+	/*
+	 * Dump the capability listing that we got from the server earlier
+	 * during the info/refs request.
+	 */
+	write_or_die(p.out, discover->buf, discover->len);
+
+	/* Peek the next packet line.  Until we see EOF keep sending POSTs */
+	while (packet_reader_peek(&p.reader) != PACKET_READ_EOF) {
+		if (proxy_post(&p)) {
+			/* We would have an err here */
+			break;
+		}
+	}
+
+	proxy_state_clear(&p);
+	return 0;
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1115,12 +1292,16 @@ int cmd_main(int argc, const char **argv)
 			fflush(stdout);
 
 		} else if (!strcmp(buf.buf, "capabilities")) {
+			printf("connect-half-duplex\n");
 			printf("fetch\n");
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
 			printf("\n");
 			fflush(stdout);
+		} else if (skip_prefix(buf.buf, "connect-half-duplex ", &arg)) {
+			if (!connect_half_duplex(arg))
+				break;
 		} else {
 			error("remote-curl: unknown command '%s' from git", buf.buf);
 			return 1;
diff --git a/t/t5701-protocol-v2.sh b/t/t5701-protocol-v2.sh
index 3e411e178..ada69ac09 100755
--- a/t/t5701-protocol-v2.sh
+++ b/t/t5701-protocol-v2.sh
@@ -73,4 +73,45 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	! grep "refs/tags/" log
 '
 
+# Test protocol v2 with 'http://' transport
+#
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create repo to be served by http:// transport' '
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one
+'
+
+test_expect_success 'clone with http:// using protocol v2' '
+	GIT_TRACE_PACKET=1 GIT_TRACE_CURL=1 git -c protocol.version=2 \
+		clone "$HTTPD_URL/smart/http_parent" http_child 2>log &&
+
+	git -C http_child log -1 --format=%s >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log
+'
+
+test_expect_success 'fetch with http:// using protocol v2' '
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two &&
+
+	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=2 \
+		fetch 2>log &&
+
+	git -C http_child log -1 --format=%s origin/master >actual &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" log -1 --format=%s >expect &&
+	test_cmp expect actual &&
+
+	# Server responded using protocol v2
+	grep "git< version 2" log
+'
+
+stop_httpd
+
 test_done
-- 
2.15.1.620.gb9897f4670-goog

