Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569CCD3440
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjISGmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISGmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 02:42:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D0A100
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 23:42:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4437425a12.1
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 23:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695105723; x=1695710523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BXhRYb50q5PR2vAG8xUseIFQs6tj/zGgDXYWS2VnmY=;
        b=jQSf2rWYXWQAeZZHKUVG48cUv/MqQyX2MQS9O8LsQjLHZFHZ8iNsa7gj9GZTaeKlQl
         1d1O3NUyu2GpvB0npAGPFm8cP6gi8NV0sb8m3sW0eiFeBI1sQaoh++Wsg5egydkwXtkU
         32VOIwg4J3LrR9I1OqJEjBRIM3qc9CH6x6mso/zyrIIB3ipiwkOKtmTPP2TXjoWaIcFu
         oWuBkhyBdDT9McRy4PT4/w6ZRWYuBPZjnuuJfm5C8EJuYvF9OD8EP8yYogYTzp9y7Y51
         dFQ7Hdzs2udja6Ku+OiLDj69kVz9mi7xbqbxzuDiiEbWExHbJcz2WJXRfdVtHsDFye/E
         rJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695105723; x=1695710523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BXhRYb50q5PR2vAG8xUseIFQs6tj/zGgDXYWS2VnmY=;
        b=gzKcM3lYy2ke3yqAE0mCgW/YdDVrqTvTX3SX5QkqLZQoV4ZpQPhasd1XZkDVLyVVL1
         slLi5L4KSldbtSnIyFVAAqNfSyuw7c7C3SOn5xMgcOJhZ3tkAgl0xwx/BM6pIycGcOhp
         K7OTwdwYkaQlDBG8Kfcjp5wbLxfPbh7XsHDgPU7AFXGAoKP7tDBwbzg/Yd0yHxdfjB1K
         lvX11qdcibs3tQzrR2446WKFvEMJ70NGjeQq2QMhBw0+2D5mEdaonJqbKV61B/2DqgKI
         HW6+n9oflfc4dbCvJnUdOzXvAg18oJHD5P+upr12KHfMPDo04JtDaxZDNpfGp/QvtwRp
         2Z6Q==
X-Gm-Message-State: AOJu0YwU+mLh9+FS9SxdSaZ0WzUcQS1N2Rvfv4oJhCoqXeqUSC5dhS8e
        hF6cFXUTLFMwn8gxUZGX7qfUEiDQFIQ=
X-Google-Smtp-Source: AGHT+IFgV324Z+sJhR4UC3a2tbENaQla6POuM4sLcAp18uws3/sFx8cmH2BXWQydSgXMl029A+ObkQ==
X-Received: by 2002:a05:6300:8002:b0:14c:d5e9:21b8 with SMTP id an2-20020a056300800200b0014cd5e921b8mr10232376pzc.30.1695105722851;
        Mon, 18 Sep 2023 23:42:02 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902cec700b001b89891bfc4sm5286495plg.199.2023.09.18.23.42.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 23:42:02 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/2] archive: support remote archive from stateless transport
Date:   Tue, 19 Sep 2023 14:41:56 +0800
Message-Id: <20230919064156.13892-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20230919064156.13892-1-worldhello.net@gmail.com>
References: <20230919064156.13892-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Even though we can establish a stateless connection, we still cannot
archive the remote repository using a stateless HTTP protocol. Try the
following steps to make it work.

 1. Add support for "git-upload-archive" service in "http-backend".

 2. Unable to access the URL ".../info/refs?service=git-upload-archive"
    to detect the protocol version, use the "git-upload-pack" service
    instead.

 3. "git-archive" does not resolve the protocol version and capabilities
    when connecting to remote-helper, so the remote-helper should not
    send them.

 4. "git-archive" may not be able to disconnect the stateless
    connection. Run "do_take_over()" to take_over the transfer for
    a graceful disconnect function.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 http-backend.c         | 15 +++++++++++++--
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 30 ++++++++++++++++++++++++++++++
 transport-helper.c     |  5 ++++-
 4 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ff07b87e64..ed3bed965a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -38,6 +38,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "upload-archive", "uploadarchive", 0, -1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -639,10 +640,19 @@ static void check_content_type(struct strbuf *hdr, const char *accepted_type)
 
 static void service_rpc(struct strbuf *hdr, char *service_name)
 {
-	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
+	const char *argv[4];
 	struct rpc_service *svc = select_service(hdr, service_name);
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!strcmp(service_name, "git-upload-archive")) {
+		argv[1] = ".";
+		argv[2] = NULL;
+	} else {
+		argv[1] = "--stateless-rpc";
+		argv[2] = ".";
+		argv[3] = NULL;
+	}
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(hdr, buf.buf);
@@ -723,7 +733,8 @@ static struct service_cmd {
 	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.idx$", get_idx_file},
 
 	{"POST", "/git-upload-pack$", service_rpc},
-	{"POST", "/git-receive-pack$", service_rpc}
+	{"POST", "/git-receive-pack$", service_rpc},
+	{"POST", "/git-upload-archive$", service_rpc}
 };
 
 static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..ce6cb8ac05 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1447,8 +1447,14 @@ static int stateless_connect(const char *service_name)
 	 * establish a stateless connection, otherwise we need to tell the
 	 * client to fallback to using other transport helper functions to
 	 * complete their request.
+	 *
+	 * The "git-upload-archive" service is a read-only operation. Fallback
+	 * to use "git-upload-pack" service to discover protocol version.
 	 */
-	discover = discover_refs(service_name, 0);
+	if (!strcmp(service_name, "git-upload-archive"))
+		discover = discover_refs("git-upload-pack", 0);
+	else
+		discover = discover_refs(service_name, 0);
 	if (discover->version != protocol_v2) {
 		printf("fallback\n");
 		fflush(stdout);
@@ -1486,9 +1492,11 @@ static int stateless_connect(const char *service_name)
 
 	/*
 	 * Dump the capability listing that we got from the server earlier
-	 * during the info/refs request.
+	 * during the info/refs request. This does not work with the
+	 * "git-upload-archive" service.
 	 */
-	write_or_die(rpc.in, discover->buf, discover->len);
+	if (strcmp(service_name, "git-upload-archive"))
+		write_or_die(rpc.in, discover->buf, discover->len);
 
 	/* Until we see EOF keep sending POSTs */
 	while (1) {
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index fc499cdff0..80123c1e06 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -239,4 +239,34 @@ check_zip with_untracked2
 check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success "setup for HTTP protocol" '
+	cp -R bare.git "$HTTPD_DOCUMENT_ROOT_PATH/bare.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bare.git" \
+		config http.uploadpack true &&
+	set_askpass user@host pass@host
+'
+
+setup_askpass_helper
+
+test_expect_success 'remote archive does not work with protocol v1' '
+	test_when_finished "rm -f d5.zip" &&
+	test_must_fail git -c protocol.version=1 archive \
+		--remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=d5.zip HEAD >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	fatal: can${SQ}t connect to subservice git-upload-archive
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'archive remote http repository' '
+	test_when_finished "rm -f d5.zip" &&
+	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=d5.zip HEAD &&
+	test_cmp_bin d.zip d5.zip
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 2e127d24a5..91381be622 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -628,7 +628,8 @@ static int process_connect_service(struct transport *transport,
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
 		   (get_protocol_version_config() == protocol_v2) &&
-		   !strcmp("git-upload-pack", name)) {
+		   (!strcmp("git-upload-pack", name) ||
+		    !strcmp("git-upload-archive", name))) {
 		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
 		if (ret)
@@ -668,6 +669,8 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
+
+	do_take_over(transport);
 	return 0;
 }
 
-- 
2.40.1.49.g40e13c3520.dirty

