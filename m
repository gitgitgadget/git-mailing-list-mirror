Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912581F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeAYX7u (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:50 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:44490 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeAYX7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:47 -0500
Received: by mail-yb0-f201.google.com with SMTP id c81so5831211ybb.11
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=gjayF27JGS59t6CN+sXnOHylt1vcHg1mMk5LZWs25LU=;
        b=IzXhFU29IIlf30MFguxLLmP2obsFjaGWfxveAtZ2m5Shs0GnH7MrOMEGdQFuCm1neG
         dqtDgjsmvdDs3vyK7ZkaTuCzcwjIKL9DyfxYES6vI1Fspas9arnsDpK3r6Hlh6JbhISL
         mUwoKgQ/A4z2bcPuWtCHnZ7/QCNBOHGzjwcWlBV19Eq4VUEFZefAyxQkK87hT8haPbcu
         C4xw9kdmkq6L45pPmg4FqjfLZgsa9RYa3o0s0V286wUnJogR7RKH5PLOvB+JwMlL8Fzf
         rgjrcFyqkh7ASJicnLWadID/W3TfwBprXglSRSBHVWyO+/BaAmn17ZvQNuMMRmnEF+hD
         HUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=gjayF27JGS59t6CN+sXnOHylt1vcHg1mMk5LZWs25LU=;
        b=CBZ+pAs1CjaKcpiOu9rjpYSaHSjKLbdGC1asvcvqosYEwxQpvGDL8Lacu5ffEOrsOR
         PT+XbVng4TxBsJcHqu9D2jyFeKRUTEcNPz5lEGgCeA/18PhEAtI2/p9VM0x10YpNpO1y
         5H/ZnQUGxt8Zwm7x4QhqAYCG7TWdHzve8HZ85Ix8nU638JtwJPCwu44unIXBcXVplPR9
         yJHsbldM1DtiHLaYzYq5cgImgCCn0ye5z+cqvMoOZu6s/1rNqDTQ6Lg/R2gArpJxM5MG
         FEHWPYtc+rzAs4twpMokvnwKyQ18Q6ngM3W+z6pysk4yYDcKZeKV+AfastISTrdNDdkA
         TQ8w==
X-Gm-Message-State: AKwxyterHLlovM+eIZdQ1+1NvFwIAKf+tzSpM8ncYwRCVXGrZf1KRCkx
        0U8xUpIZS8Hl4BROnzw2PRvjYQQuKowiE+UDHGA9Qa/CO0EsNq9iMnX/walcXTGd4VcEY/KEjBi
        Q4OU3cRbBMj4DT8sBsmAKiEaT9ufTA+C/UGu7jJFIqtrTCcxAneYyM3jAZw==
X-Google-Smtp-Source: AH8x2268Nyb8oCk6k8BK78bPFeR/vS1ej9k5AXEP9eS8c8guGfP9AMGIDjbsix8+9xM6/e8i7Fv7daotTW0=
MIME-Version: 1.0
X-Received: by 10.129.106.139 with SMTP id f133mr5635392ywc.63.1516924786751;
 Thu, 25 Jan 2018 15:59:46 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:38 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-28-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 27/27] remote-curl: implement stateless-connect command
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
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
 remote-curl.c          | 185 ++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5702-protocol-v2.sh |  41 +++++++++++
 2 files changed, 224 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4086aa733..a17c7e228 100644
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
+		 * Do nothing.  Client should run 'stateless-connect' and
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
+	struct curl_slist *headers;
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
+	p->headers = http_copy_default_headers();
+
+	strbuf_addf(&buf, "Content-Type: application/x-%s-request", p->service_name);
+	p->headers = curl_slist_append(p->headers, buf.buf);
+	strbuf_reset(&buf);
+
+	strbuf_addf(&buf, "Accept: application/x-%s-result", p->service_name);
+	p->headers = curl_slist_append(p->headers, buf.buf);
+
+	p->headers = curl_slist_append(p->headers, "Transfer-Encoding: chunked");
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
+static size_t proxy_in(char *buffer, size_t eltsize,
+		       size_t nmemb, void *userdata)
+{
+	size_t max = eltsize * nmemb;
+	struct proxy_state *p = userdata;
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
+	size_t size = eltsize * nmemb;
+	struct proxy_state *p = userdata;
+
+	write_or_die(p->out, buffer, size);
+	return size;
+}
+
+static int proxy_post(struct proxy_state *p)
+{
+	struct active_request_slot *slot;
+	int err;
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
+	err = run_slot(slot, NULL);
+
+	if (err != HTTP_OK)
+		err = -1;
+
+	return err;
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
index 3e411e178..ada69ac09 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
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
2.16.0.rc1.238.g530d649a79-goog

