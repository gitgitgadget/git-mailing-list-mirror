Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22077C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F233F20758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/oh6kQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgERPro (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgERPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:47:42 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E89C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:41 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id dh1so1046438qvb.13
        for <git@vger.kernel.org>; Mon, 18 May 2020 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGrW45YWMf7gQ4hYteUreyzMdi7RXw7Plla6a/9qun0=;
        b=J/oh6kQsVRyrqx6oDb9xl8kZtCSPLdwL5/Vn/C/UeMYcIfqQEfz5LtkJNLUt2ApTMN
         RVy5vs8tRpHDpnn6wRCudlgxBDp6WKHgGtjVF261lv1JaNN15Kzyojo5ixOIggRHnAiq
         ElbHAOMK/cd4AEGapQWZlAuVTOqKVXj/JWGrqgvqP4e62LBdZmH6I1TQyc1I/ZDogXgf
         elXSx35Ym9YUPglW3cnhFMtiYYExJIvD9777AQ7hYCCUMlUTHZZmciBAP765Jl0VcPzO
         fGhDQ6JANeVZfjMET7juX039N448fFTXOIilM9m23NBboPfX1doAGL3jrwLgipFObj3d
         /5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGrW45YWMf7gQ4hYteUreyzMdi7RXw7Plla6a/9qun0=;
        b=FggWgt55oq/c6NIF7G1sHL8Vj22zRTfDr9/73cZ7ye7F+PhzbN8LGuGlvSlYCe56Bc
         K1bAjlFY9hJ+nqut1pvffaFh9SZqPb5hNUEU9chynbBuJNsol0HTiTQ5WSi8ZXwH8Vud
         GT0O4EJEoX/b/MO+DnZrYV40wPHghSlwheFPUe72SaLxiBf8y5N2gK4h5vbvibvSVFue
         sY8J20TEk3HOOJNJQQ4GAovXf/I26Hczm4yEhfHA/y3ybZdYJd+c5iNoPfd9S85wvOF/
         P49jRPJq4zP4tN/xgOE/W9HwItqWBsc+m7REvY7VuwUDsgluSeQzK3R08sEBZ26jRiGK
         gwcQ==
X-Gm-Message-State: AOAM532RWqNcBwfee3VpFK4gkDVpE6cSdvxhP9z1QwAzLe63maWp+wAP
        DPjKnXusQe8H98QiYDxv8fc8BKxW
X-Google-Smtp-Source: ABdhPJwdhRc6eNH8gOFF4xZayD6xSxIScQKI7cU8n8sHFMou9WlbvfdwrDjjjDJZUoBaNE5DOr0OSQ==
X-Received: by 2002:a0c:fc45:: with SMTP id w5mr16445039qvp.75.1589816860510;
        Mon, 18 May 2020 08:47:40 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z201sm5146913qkb.2.2020.05.18.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:47:39 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/7] remote-curl: error on incomplete packet
Date:   Mon, 18 May 2020 11:47:22 -0400
Message-Id: <52ce5fdffd6741eeee8d69b804403383da0d879d.1589816719.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589816718.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com> <cover.1589816718.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, remote-curl acts as a proxy and blindly forwards packets
between an HTTP server and fetch-pack. In the case of a stateless RPC
connection where the connection is terminated with a partially written
packet, remote-curl will blindly send the partially written packet
before waiting on more input from fetch-pack. Meanwhile, fetch-pack will
read the partial packet and continue reading, expecting more input. This
results in a deadlock between the two processes.

For a stateless connection, inspect packets before sending them and
error out if a a packet line packet is incomplete.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c                                 | 59 ++++++++++++++++++-
 t/lib-httpd.sh                                |  2 +
 t/lib-httpd/apache.conf                       |  8 +++
 .../incomplete-body-upload-pack-v2-http.sh    |  3 +
 .../incomplete-length-upload-pack-v2-http.sh  |  3 +
 t/t5702-protocol-v2.sh                        | 34 +++++++++++
 6 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
 create mode 100644 t/lib-httpd/incomplete-length-upload-pack-v2-http.sh

diff --git a/remote-curl.c b/remote-curl.c
index da3e07184a..e020140092 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -679,9 +679,53 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 }
 #endif
 
+struct check_pktline_state {
+	char len_buf[4];
+	int len_filled;
+	int remaining;
+};
+
+static void check_pktline(struct check_pktline_state *state, const char *ptr, size_t size)
+{
+	while (size) {
+		if (!state->remaining) {
+			int digits_remaining = 4 - state->len_filled;
+			if (digits_remaining > size)
+				digits_remaining = size;
+			memcpy(&state->len_buf[state->len_filled], ptr, digits_remaining);
+			state->len_filled += digits_remaining;
+			ptr += digits_remaining;
+			size -= digits_remaining;
+
+			if (state->len_filled == 4) {
+				state->remaining = packet_length(state->len_buf);
+				if (state->remaining < 0) {
+					die(_("remote-curl: bad line length character: %.4s"), state->len_buf);
+				} else if (state->remaining < 4) {
+					state->remaining = 0;
+				} else {
+					state->remaining -= 4;
+				}
+				state->len_filled = 0;
+			}
+		}
+
+		if (state->remaining) {
+			int remaining = state->remaining;
+			if (remaining > size)
+				remaining = size;
+			ptr += remaining;
+			size -= remaining;
+			state->remaining -= remaining;
+		}
+	}
+}
+
 struct rpc_in_data {
 	struct rpc_state *rpc;
 	struct active_request_slot *slot;
+	int check_pktline;
+	struct check_pktline_state pktline_state;
 };
 
 /*
@@ -702,6 +746,8 @@ static size_t rpc_in(char *ptr, size_t eltsize,
 		return size;
 	if (size)
 		data->rpc->any_written = 1;
+	if (data->check_pktline)
+		check_pktline(&data->pktline_state, ptr, size);
 	write_or_die(data->rpc->in, ptr, size);
 	return size;
 }
@@ -778,7 +824,7 @@ static curl_off_t xcurl_off_t(size_t len)
  * If flush_received is true, do not attempt to read any more; just use what's
  * in rpc->buf.
  */
-static int post_rpc(struct rpc_state *rpc, int flush_received)
+static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
 {
 	struct active_request_slot *slot;
 	struct curl_slist *headers = http_copy_default_headers();
@@ -920,6 +966,8 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	rpc_in_data.rpc = rpc;
 	rpc_in_data.slot = slot;
+	rpc_in_data.check_pktline = stateless_connect;
+	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
@@ -936,6 +984,11 @@ static int post_rpc(struct rpc_state *rpc, int flush_received)
 	if (!rpc->any_written)
 		err = -1;
 
+	if (rpc_in_data.pktline_state.len_filled)
+		err = error(_("%d bytes of length header were received"), rpc_in_data.pktline_state.len_filled);
+	if (rpc_in_data.pktline_state.remaining)
+		err = error(_("%d bytes of body are still expected"), rpc_in_data.pktline_state.remaining);
+
 	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
@@ -985,7 +1038,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
 			break;
 		rpc->pos = 0;
 		rpc->len = n;
-		err |= post_rpc(rpc, 0);
+		err |= post_rpc(rpc, 0, 0);
 	}
 
 	close(client.in);
@@ -1342,7 +1395,7 @@ static int stateless_connect(const char *service_name)
 			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
 		if (status == PACKET_READ_EOF)
 			break;
-		if (post_rpc(&rpc, status == PACKET_READ_FLUSH))
+		if (post_rpc(&rpc, 1, status == PACKET_READ_FLUSH))
 			/* We would have an err here */
 			break;
 		/* Reset the buffer for next request */
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 1449ee95e9..d2edfa4c50 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -129,6 +129,8 @@ install_script () {
 prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
+	install_script incomplete-length-upload-pack-v2-http.sh
+	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script broken-smart-http.sh
 	install_script error-smart-http.sh
 	install_script error.sh
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 994e5290d6..afa91e38b0 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -117,6 +117,8 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
+ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
 ScriptAliasMatch /error_git_upload_pack/(.*)/git-upload-pack error.sh/
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
@@ -126,6 +128,12 @@ ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
+<Files incomplete-length-upload-pack-v2-http.sh>
+	Options ExecCGI
+</Files>
+<Files incomplete-body-upload-pack-v2-http.sh>
+	Options ExecCGI
+</Files>
 <Files broken-smart-http.sh>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh b/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
new file mode 100644
index 0000000000..2f5ed9fcf6
--- /dev/null
+++ b/t/lib-httpd/incomplete-body-upload-pack-v2-http.sh
@@ -0,0 +1,3 @@
+printf "Content-Type: text/%s\n" "application/x-git-upload-pack-result"
+echo
+printf "%s%s\n" "0079" "45"
diff --git a/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh b/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh
new file mode 100644
index 0000000000..86c6e648c9
--- /dev/null
+++ b/t/lib-httpd/incomplete-length-upload-pack-v2-http.sh
@@ -0,0 +1,3 @@
+printf "Content-Type: text/%s\n" "application/x-git-upload-pack-result"
+echo
+printf "%s\n" "00"
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..4eb81ba2d4 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -586,6 +586,40 @@ test_expect_success 'clone with http:// using protocol v2' '
 	! grep "Send header: Transfer-Encoding: chunked" log
 '
 
+test_expect_success 'clone repository with http:// using protocol v2 with incomplete pktline length' '
+	test_when_finished "rm -f log" &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/incomplete_length" &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/incomplete_length" file &&
+
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git -c protocol.version=2 \
+		clone "$HTTPD_URL/smart/incomplete_length" incomplete_length_child 2>err &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log &&
+	# Client reported appropriate failure
+	test_i18ngrep "bytes of length header were received" err
+'
+
+test_expect_success 'clone repository with http:// using protocol v2 with incomplete pktline body' '
+	test_when_finished "rm -f log" &&
+
+	git init "$HTTPD_DOCUMENT_ROOT_PATH/incomplete_body" &&
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/incomplete_body" file &&
+
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" GIT_TRACE_CURL="$(pwd)/log" git -c protocol.version=2 \
+		clone "$HTTPD_URL/smart/incomplete_body" incomplete_body_child 2>err &&
+
+	# Client requested to use protocol v2
+	grep "Git-Protocol: version=2" log &&
+	# Server responded using protocol v2
+	grep "git< version 2" log &&
+	# Client reported appropriate failure
+	test_i18ngrep "bytes of body are still expected" err
+'
+
 test_expect_success 'clone big repository with http:// using protocol v2' '
 	test_when_finished "rm -f log" &&
 
-- 
2.26.2.706.g87896c9627

