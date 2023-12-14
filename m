Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBoDqtv9"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FCF9C
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so5182826b3a.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563231; x=1703168031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5buL3oD1qUEiKjt8Q2ZKcp2Nr+bw2svcEJVPZusC2g=;
        b=FBoDqtv9eyjweC5JPuyjg3LsoscmMZU4dq5IR3MEI5KwgDm9FTlGV4KGBiLzCqiGZZ
         ioHgDqAF0jcGrkOXucPtDCmhO4D9L2zF2GS3JayrAgUbMGJSMsd4EDmEDCytRPHHy4h4
         g1IRXRFP+mQbl1k2er0stXPab/meObq+7X9+LgrVdj6gF2/4zWsMxuG4Pgk5FyxQAM/G
         fv/MJ2ZCKriG3C0nFtRUG2Mr/sxde7Rj2ELdw8JtPEgVnk78CfGiCi3Zhs+IBw0o8xvq
         GCZvCnYqFeYS9fTEHnZM4QVzmvLirE3QcsagfXMA9+XLuL8135sjccytn0+oz9Vf3+dG
         Ctjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563231; x=1703168031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5buL3oD1qUEiKjt8Q2ZKcp2Nr+bw2svcEJVPZusC2g=;
        b=PLErYkbJPMN0UwVZAKBpHmtH/fD6WWi7SB2Mi2wTppV05zmSZFqEHUK/X/FUq+Z66b
         fkbRuGqdlO/LgOzHt9ggpD1u4Eu2/GkD15S1UzH1eLuXnKNbNyznADN3JYYG2sWyMgo0
         KdZ+gShYg+mZ3f05EcZdirFjuPHRz1fvyyhk3EPfZc5GFML3vy/9DO1CNNLYdo+tgErn
         q8ighbyfBUkuFn20um8Onzt+DYRe9GzTuUqyhneibSo4BxdHaMQYDb4U8GuWfTJtDE+X
         qUPMj9HnJ7bT1OQjAFm0NAAofTgn5eAxZPZgjlHKhdgLSbpsNgGf4V6csiZ1ZLXObt+y
         l5Vw==
X-Gm-Message-State: AOJu0YyqbZqAWXtPAEk+x06YpwJJx5GgjSV3wjx1aIf/13gRbIUiBYDf
	iew76c5pOJ6DeU4HRblzTWBikBI2OC0=
X-Google-Smtp-Source: AGHT+IFJKDGtUPttmdrP4juV5iHveS5i/MvwVIQzqLIm8D4Nm0Bjp4z2XQeI+AeLwXG94a12u2wWMQ==
X-Received: by 2002:a05:6a00:230a:b0:6ce:f78e:1054 with SMTP id h10-20020a056a00230a00b006cef78e1054mr5572364pfh.14.1702563231465;
        Thu, 14 Dec 2023 06:13:51 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006ce921da705sm11806232pfl.136.2023.12.14.06.13.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:13:51 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 4/4] archive: support remote archive from stateless transport
Date: Thu, 14 Dec 2023 22:13:45 +0800
Message-Id: <18b9a11d3be9d804e8d22d054ea881b8336d170c.1702562879.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com> <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 transport-helper.c     |  3 ++-
 4 files changed, 58 insertions(+), 8 deletions(-)

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
index fc499cdff0..961c6aac25 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -239,4 +239,38 @@ check_zip with_untracked2
 check_added with_untracked2 untracked one/untracked
 check_added with_untracked2 untracked two/untracked
 
+# Test remote archive over HTTP protocol.
+#
+# Note: this should be the last part of this test suite, because
+# by including lib-httpd.sh, the test may end early if httpd tests
+# should not be run.
+#
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
+	test_must_fail git -c protocol.version=1 archive \
+		--remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=remote-http.zip HEAD >actual 2>&1 &&
+	cat >expect <<-EOF &&
+	fatal: can${SQ}t connect to subservice git-upload-archive
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'archive remote http repository' '
+	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=remote-http.zip HEAD &&
+	test_cmp_bin d.zip remote-http.zip
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
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

