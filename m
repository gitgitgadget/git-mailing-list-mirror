Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47761F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeCORdM (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:12 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:50120 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeCORdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:33:09 -0400
Received: by mail-yw0-f201.google.com with SMTP id x204so7630795ywd.16
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=r9gRMCkQ5hU5WTI0p6N7Td4ELETvxACFIky1F58TpfM=;
        b=a+wbCSv/f4A5dokQzZ1+D0BnGwvmQwvKfCAMqUG69Cr9ng3ovJPNxqTMwD1XkCKYKr
         BbfAyW8NsRqn0s5GzPxndX3mHo7keYQS2Jar9AGwk+jQCcYBBD9j6x85P7JxhgoveyP0
         JR3SxiTcyy40ci1xsSb3dN+b6CmG2V5qf6BI6gR27tYWjpI940IASEUlr4ffMR2ECIY2
         BfSRInHAr0pRDfXPPeBLTP7rxyMkk1ZAn8EuAei8Y3o1AcrJhWpIGpb1HMcE4kUcfRac
         /8Pv9u8KtYFW1R1lh/DQfDDhXBR1UDtOlygBednKSrh4CKojNdMdhpEaIBGZCFYAH9XC
         +FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=r9gRMCkQ5hU5WTI0p6N7Td4ELETvxACFIky1F58TpfM=;
        b=UklquBY75VydH67L/Tvf+vRodai+KZqNtp+AxcS0Wbl0/KkELU3poOzzXX2JVtxESn
         i2sfNn9f/KGMpw8ZfU1zA78f/jgraMp66iegKBofR64o4xk12H5Gq9Kx+oM+sgu5IGtJ
         XYt8+qMwEoRpNRmCphtVum8EdMgxjSoltQ6rgeFb/JPsP5zkOuwDyQJq3xl70PlVRVz+
         j6z4MGs+sqRLxwKhFFXyiJ/agQF8JZrU818zz0q9Nd+GVQGgULtZTjcwOdfQ5aTvGiuF
         QK2zBl1T+9RCYsaG+DDX9/rJlVjR33OYuMl2L5x7opBfwc0NnMAlKArfCLSMoekdgEBO
         3WEQ==
X-Gm-Message-State: AElRT7GwxZtzvsyGgp2PU1fiFIZiTHQq4jE/tI77FhIKFhvwvh+QJN8I
        IDERunre6/YPJbkzYa0d9sWExzLZZ2YTa4j6sG8fT4+FXlqfe31Q8mtj4FXsz8jc85c593MZsiE
        7qocwa4zO06n4EEVx1eHhoqcxyP2Yez2FVe9kFYxStc2wppdwboopGQWbXw==
X-Google-Smtp-Source: AG47ELuIDXry7AoeayLw2ABvnD3c5jEyaEHmYU5mC2uHELX4KACkeIGGpGly6bYsx354VCrkiN4hP1lJGzg=
MIME-Version: 1.0
X-Received: by 10.13.226.203 with SMTP id l194mr2482470ywe.198.1521135188989;
 Thu, 15 Mar 2018 10:33:08 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:41 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-35-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 34/35] remote-curl: implement stateless-connect command
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach remote-curl the 'stateless-connect' command which is used to
establish a stateless connection with servers which support protocol
version 2.  This allows remote-curl to act as a proxy, allowing the git
client to communicate natively with a remote end, simply using
remote-curl as a pass through to convert requests to http.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c          | 207 ++++++++++++++++++++++++++++++++++++++++-
 t/t5702-protocol-v2.sh |  45 +++++++++
 2 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 66a53f74bb..87f5b77b29 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -188,7 +188,12 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	heads->version = discover_version(&reader);
 	switch (heads->version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		/*
+		 * Do nothing.  This isn't a list of refs but rather a
+		 * capability advertisement.  Client would have run
+		 * 'stateless-connect' so we'll dump this capability listing
+		 * and let them request the refs themselves.
+		 */
 		break;
 	case protocol_v1:
 	case protocol_v0:
@@ -1085,6 +1090,202 @@ static void parse_push(struct strbuf *buf)
 	free(specs);
 }
 
+/*
+ * Used to represent the state of a connection to an HTTP server when
+ * communicating using git's wire-protocol version 2.
+ */
+struct proxy_state {
+	char *service_name;
+	char *service_url;
+	struct curl_slist *headers;
+	struct strbuf request_buffer;
+	int in;
+	int out;
+	struct packet_reader reader;
+	size_t pos;
+	int seen_flush;
+};
+
+static void proxy_state_init(struct proxy_state *p, const char *service_name,
+			     enum protocol_version version)
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
+	p->headers = http_copy_default_headers();
+
+	strbuf_addf(&buf, "Content-Type: application/x-%s-request", p->service_name);
+	p->headers = curl_slist_append(p->headers, buf.buf);
+	strbuf_reset(&buf);
+
+	strbuf_addf(&buf, "Accept: application/x-%s-result", p->service_name);
+	p->headers = curl_slist_append(p->headers, buf.buf);
+	strbuf_reset(&buf);
+
+	p->headers = curl_slist_append(p->headers, "Transfer-Encoding: chunked");
+
+	/* Add the Git-Protocol header */
+	if (get_protocol_http_header(version, &buf))
+		p->headers = curl_slist_append(p->headers, buf.buf);
+
+	packet_reader_init(&p->reader, p->in, NULL, 0,
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	strbuf_release(&buf);
+}
+
+static void proxy_state_clear(struct proxy_state *p)
+{
+	free(p->service_name);
+	free(p->service_url);
+	curl_slist_free_all(p->headers);
+	strbuf_release(&p->request_buffer);
+}
+
+/*
+ * CURLOPT_READFUNCTION callback function.
+ * Attempts to copy over a single packet-line at a time into the
+ * curl provided buffer.
+ */
+static size_t proxy_in(char *buffer, size_t eltsize,
+		       size_t nmemb, void *userdata)
+{
+	size_t max;
+	struct proxy_state *p = userdata;
+	size_t avail = p->request_buffer.len - p->pos;
+
+
+	if (eltsize != 1)
+		BUG("curl read callback called with size = %"PRIuMAX" != 1",
+		    (uintmax_t)eltsize);
+	max = nmemb;
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
+			die("unexpected EOF when reading from parent process");
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
+	memcpy(buffer, p->request_buffer.buf + p->pos, avail);
+	p->pos += avail;
+	return avail;
+}
+
+static size_t proxy_out(char *buffer, size_t eltsize,
+			size_t nmemb, void *userdata)
+{
+	size_t size;
+	struct proxy_state *p = userdata;
+
+	if (eltsize != 1)
+		BUG("curl read callback called with size = %"PRIuMAX" != 1",
+		    (uintmax_t)eltsize);
+	size = nmemb;
+
+	write_or_die(p->out, buffer, size);
+	return size;
+}
+
+/* Issues a request to the HTTP server configured in `p` */
+static int proxy_request(struct proxy_state *p)
+{
+	struct active_request_slot *slot;
+
+	slot = get_active_slot();
+
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
+	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, p->headers);
+
+	/* Setup function to read request from client */
+	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, proxy_in);
+	curl_easy_setopt(slot->curl, CURLOPT_READDATA, p);
+
+	/* Setup function to write server response to client */
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
+
+	if (run_slot(slot, NULL) != HTTP_OK)
+		return -1;
+
+	return 0;
+}
+
+static int stateless_connect(const char *service_name)
+{
+	struct discovery *discover;
+	struct proxy_state p;
+
+	/*
+	 * Run the info/refs request and see if the server supports protocol
+	 * v2.  If and only if the server supports v2 can we successfully
+	 * establish a stateless connection, otherwise we need to tell the
+	 * client to fallback to using other transport helper functions to
+	 * complete their request.
+	 */
+	discover = discover_refs(service_name, 0);
+	if (discover->version != protocol_v2) {
+		printf("fallback\n");
+		fflush(stdout);
+		return -1;
+	} else {
+		/* Stateless Connection established */
+		printf("\n");
+		fflush(stdout);
+	}
+
+	proxy_state_init(&p, service_name, discover->version);
+
+	/*
+	 * Dump the capability listing that we got from the server earlier
+	 * during the info/refs request.
+	 */
+	write_or_die(p.out, discover->buf, discover->len);
+
+	/* Peek the next packet line.  Until we see EOF keep sending POSTs */
+	while (packet_reader_peek(&p.reader) != PACKET_READ_EOF) {
+		if (proxy_request(&p)) {
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
@@ -1153,12 +1354,16 @@ int cmd_main(int argc, const char **argv)
 			fflush(stdout);
 
 		} else if (!strcmp(buf.buf, "capabilities")) {
+			printf("stateless-connect\n");
 			printf("fetch\n");
 			printf("option\n");
 			printf("push\n");
 			printf("check-connectivity\n");
 			printf("\n");
 			fflush(stdout);
+		} else if (skip_prefix(buf.buf, "stateless-connect ", &arg)) {
+			if (!stateless_connect(arg))
+				break;
 		} else {
 			error("remote-curl: unknown command '%s' from git", buf.buf);
 			return 1;
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e3a7c09d4a..124063c2c4 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -201,4 +201,49 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
 	! grep "refs/tags/three" log
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
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git -c protocol.version=2 \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
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
+	test_when_finished "rm -f log" &&
+
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
+		fetch &&
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
2.16.2.804.g6dcf76e118-goog

