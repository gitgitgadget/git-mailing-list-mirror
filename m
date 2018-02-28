Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E921F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964929AbeB1XZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:25:00 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:47701 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964965AbeB1XYt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:49 -0500
Received: by mail-yw0-f202.google.com with SMTP id r185so2368735ywh.14
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Q0g3kVwyfDhvfdNfEQkPrFw1u2sT4ajgwYs3GbhM4QI=;
        b=HViqEaJmoMqsLdbCQ/s84GAb9qD8aYfUjAtyrS4ViNIzPi2LTaWL0lPtkpSxFajyGh
         qE31d560Xtbd044ja3h2CtTiApAenSLxfCuRtNNrDQtI3rIapcIjaS5SBkFNVUHsEUm5
         twZtplpnQhmAonPobeBuXLFJin3Ar4ewHqBikMTs+nX1cKQdmAIJwk5dUvK5MMEzpIhi
         ptLL50h7eMG9NNFfVt9vJEsiI2CKltZvoXEvLcKoz13UtUKh3fUGo1RkpkIcerBH9wbm
         FYvg6r6Ox6zwHieQdrTSd5efTy9C/BG7jBQ1AFBNggfi6vzzCVuOBcK71GZ39FSNJtRG
         SS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Q0g3kVwyfDhvfdNfEQkPrFw1u2sT4ajgwYs3GbhM4QI=;
        b=TVOShwHI9kkvlN+u4Ex1XDAoYIPnwJQgrmg/gQOcYVEp46FEk1KQZrQGOD63SD1tpH
         7iHmLN28RsqJU3ZGORk6mZMKQxdKi+vag1lEZTWux6ikuU1qupI4NvExv3VXKMoNeNh4
         nKBjsmgaK4T6nppzo0WhCp4+hwNBhzWRMevIPSJeHxo8o6ZXHURF965QZBQ7lP2mL5Yy
         yLfF/RTiwM9hTZxEtlZxb+hK9vCxw9beA4iJ5SxHv9owwyyqnlIH/10IC8hZ/Oy8gtrl
         D4boEtgaD1JXEc+UW3v9WjzSQLIYIw3gP7GAz+Yz27CDwRA1Y3p1gtIjhyFe7u2Pv7AS
         +uHw==
X-Gm-Message-State: APf1xPAJhO32E7OYBTyA6xPsY7lbAIjdNnOetGQeT23BjBqkfztosaD5
        VukrYE4KlZmSOak4n4BuHRx1um2FUB5HFa+Pdehife2Q9xvqeVqhWEJ+oA1TlnFV735t5DEqgie
        kTwSQJBu7rSfxONvrrHdx/O6hkapKnRh7RJ0wKDbwiMFJXZcEfCst8nsvXA==
X-Google-Smtp-Source: AG47ELu9PxhTuWemgxzjKeKdmVOTm1zSxDUt6mpgc2avkjdzt1YV5QReifBYp5KOQLNwGDS9rugpvxSmP7A=
MIME-Version: 1.0
X-Received: by 10.129.53.138 with SMTP id c132mr10172219ywa.237.1519860288933;
 Wed, 28 Feb 2018 15:24:48 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:51 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-35-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 34/35] remote-curl: implement stateless-connect command
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
 remote-curl.c          | 205 ++++++++++++++++++++++++++++++++++++++++-
 t/t5702-protocol-v2.sh |  45 +++++++++
 2 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 66a53f74b..3f882d766 100644
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
@@ -1085,6 +1090,200 @@ static void parse_push(struct strbuf *buf)
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
+		BUG("curl read callback called with size = %zu != 1", eltsize);
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
+		BUG("curl read callback called with size = %zu != 1", eltsize);
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
@@ -1153,12 +1352,16 @@ int cmd_main(int argc, const char **argv)
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
index e3a7c09d4..124063c2c 100755
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
2.16.2.395.g2e18187dfd-goog

