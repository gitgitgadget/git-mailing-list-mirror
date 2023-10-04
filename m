Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E17E7C4CE
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 15:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjJDPWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbjJDPVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 11:21:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C56BF
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 08:21:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c364fb8a4cso19124295ad.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696432910; x=1697037710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haSykPK1Q0SBrB0XQrzMn/b6dVSkUGq2BgAaA/DLOcs=;
        b=MTN8TKvkfS8+K2umN8T+linIOipFlOT01eulG2Ew+zBsCyQ5IqAIxYzxaEN3vRXD77
         ygoUy3YUY265sI+0m8TXnm+FvtzuRrF0vxSlHt7H7r/t5GJQOK348BaQJWhRfJ8OCkUo
         Vf8VbkCwAzI3e3ol6yM2ldFJLtBnwFffOithX07K5kNpDtfGcq/OAVMdCljSlg5DkjEc
         1GOUwmxnjRWaVQ4+SGyOKXvxM4PrAftJ8xvKQiGlxabDd3/GVWYUluzOzOIoKxN90ZgG
         meFBZA5+gAn3QvmD273JzlXp0jvkypRYa67RBlDlAKnrN/d7mw69KgP5vz9tRizguo1Z
         ib1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432910; x=1697037710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haSykPK1Q0SBrB0XQrzMn/b6dVSkUGq2BgAaA/DLOcs=;
        b=Av27O+wwhc0gi3LgvZ6epPS+ne22leffNi/ajE+pgFed7vA8Ds25/q6Sx6cIjXF2AH
         eq9+sVqivd7Gip0p/J32X7ylTHzHyhMZF9Wq0gxHtf31oexBwrpLetWod5HYeaePU/wb
         AtIz0TaK03upOb3lKfgNDCVjRb3maBHgzD+zi0saGv6FDozXbctEgM4EVzj+iHRdZqxD
         SyIJ9j3KSk4GZIA1+IP6z2JKAoCUCuWXeRuFyxwFEu82QX2hcuhlcn/O65+D7NJMGuuR
         eYBwaMV9ttjxJAXuSyRqLxTTR/364notMOWn5dd254z3MskgnFNNbeQVFxKmBG5Vkzhe
         ve7g==
X-Gm-Message-State: AOJu0YyDD4eeDaWCS1vaR6jzhHOcuTlJ/3WUAecBWPrOeVt8lhOogZVO
        rteOJxEOYr1EvhZHj6CKEvea1xsTEgQ=
X-Google-Smtp-Source: AGHT+IFz5L5PqYIPNxIJJD+fSJMJcH+MonkmwwUFFItVoQFth8bEVMtEb7BBKD87zf6nqjRoiu9KLw==
X-Received: by 2002:a17:903:182:b0:1bd:d6b5:a54f with SMTP id z2-20020a170903018200b001bdd6b5a54fmr2659676plg.55.1696432910037;
        Wed, 04 Oct 2023 08:21:50 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b001c5f0fe64c2sm3838199plh.56.2023.10.04.08.21.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:21:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 4/4] archive: support remote archive from stateless transport
Date:   Wed,  4 Oct 2023 23:21:43 +0800
Message-Id: <a38ac182d6895f83fd6b92995ea08c5473ca24bb.1696432594.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
References: <xmqqil7yq6ms.fsf@gitster.g> <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
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

 2. Use the URL ".../info/refs?service=git-upload-pack" to detect the
    protocol version, instead of use the "git-upload-archive" service.

 3. "git-archive" does not expect to see protocol version and
    capabilities when connecting to remote-helper, so do not send them
    in "remote-curl.c" for the "git-upload-archive" service.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 http-backend.c         | 15 +++++++++++----
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 30 ++++++++++++++++++++++++++++++
 transport-helper.c     |  3 ++-
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ff07b87e64..6a2c919839 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -38,6 +38,7 @@ struct rpc_service {
 static struct rpc_service rpc_service[] = {
 	{ "upload-pack", "uploadpack", 1, 1 },
 	{ "receive-pack", "receivepack", 0, -1 },
+	{ "upload-archive", "uploadarchive", 0, -1 },
 };
 
 static struct string_list *get_parameters(void)
@@ -639,10 +640,15 @@ static void check_content_type(struct strbuf *hdr, const char *accepted_type)
 
 static void service_rpc(struct strbuf *hdr, char *service_name)
 {
-	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
+	struct strvec argv = STRVEC_INIT;
 	struct rpc_service *svc = select_service(hdr, service_name);
 	struct strbuf buf = STRBUF_INIT;
 
+	strvec_push(&argv, svc->name);
+	if (strcmp(service_name, "git-upload-archive"))
+		strvec_push(&argv, "--stateless-rpc");
+	strvec_push(&argv, ".");
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(hdr, buf.buf);
@@ -655,9 +661,9 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
 
 	end_headers(hdr);
 
-	argv[0] = svc->name;
-	run_service(argv, svc->buffer_input);
+	run_service(argv.v, svc->buffer_input);
 	strbuf_release(&buf);
+	strvec_clear(&argv);
 }
 
 static int dead;
@@ -723,7 +729,8 @@ static struct service_cmd {
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
index 3b036ae1ca..566f7473df 100644
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
-- 
2.40.1.50.gf560bcc116.dirty

