Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE449CE7A8C
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 15:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjIWPWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjIWPWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 11:22:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6E194
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692a9bc32bcso1815410b3a.2
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695482530; x=1696087330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK/D/T5DO/W2XZheweq1EZneMJF3uHEOi82SS1uh5Uc=;
        b=PhBLGyy6HhGJTRPv4OmuzP0Oiyp5aKhrpieG2gvlONcBXDofFukqVBkGAhoLuYcym1
         pPauBTExxiJYH2fMYVhWEGHl6dysCBJQ1vQzAE+w2rHeoOKTXxki2+9lPQegbfycBXtd
         RjuKzGnOoWjo65Ntrgl9CQyZrSs72aGVb1um/2z+IQmYZhSx5v3m4ewa9b48vxh7XCEn
         /qPENO3SmzJvTCh/pWtlRUQV3twC7M5aG3iSMYydWQ1Bmpv/8pbEZPuw/SxMbLY311/T
         0OtBK1uZFyjsflof2qlv7k39Gzs0HKNPCJSQoZZh2oiH4BHAz5aCU5BQXuPyDM4J9Ojh
         iDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695482530; x=1696087330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK/D/T5DO/W2XZheweq1EZneMJF3uHEOi82SS1uh5Uc=;
        b=xKeEZIb826hw7N9GC3bwsDlgmKlyxMrLz6pUqn414jSpajDjwn0xNUcVg2HjLZB49B
         pZo/O31qoSq2BrZVNFGOAwSUF0Fnl36SOXncsBmlhFoqJqb1c5DjMBaYUy6NbTeHxKVY
         aUP78JwIBv18jB83pZp1ZM31hbx/Y/cxh/w5pcuZF6dIEo/n8R3B1emmuON5D2YPyO6v
         A71ncjnF3hawQkdwBgf4ZDkXFgpZtPIYqevZHl+q62l8+s+TWrkaUwLbbw9b81CZar5w
         8alNtU2qwZO6NCs3a4tQ8mnJzlmaNZM7GifRmOB09h9SnqYtx/O4+SAXMOViG73KDwCe
         hxEA==
X-Gm-Message-State: AOJu0Yw6nJChkp+rrP2FQARHsYJPXppr8tf0g9YMy8BK6KWkp/rlGJwz
        p0sHuHlOJwFCHxOsdz3p91DV4TYOLbA=
X-Google-Smtp-Source: AGHT+IEh5gzn3HZdoXxUdf2FoqN+6bF3PaaO+anexr16LfFNE/O9Pxna/kdrUnf5Zj4xhTiWIomQxg==
X-Received: by 2002:a05:6a00:1581:b0:690:4362:7011 with SMTP id u1-20020a056a00158100b0069043627011mr2032650pfk.24.1695482529789;
        Sat, 23 Sep 2023 08:22:09 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a001d1400b00692acfc4b3csm3084310pfx.136.2023.09.23.08.22.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Sep 2023 08:22:09 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 3/3] archive: support remote archive from stateless transport
Date:   Sat, 23 Sep 2023 23:22:01 +0800
Message-Id: <20230923152201.14741-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <xmqqy1h2f5dv.fsf@gitster.g>
References: <xmqqy1h2f5dv.fsf@gitster.g>
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

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 http-backend.c         | 15 +++++++++++++--
 remote-curl.c          | 14 +++++++++++---
 t/t5003-archive-zip.sh | 30 ++++++++++++++++++++++++++++++
 transport-helper.c     |  3 ++-
 4 files changed, 56 insertions(+), 6 deletions(-)

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
index 3c8802b7a3..91381be622 100644
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

