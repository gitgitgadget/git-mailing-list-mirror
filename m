Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BD1BDDC
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxxgswzW"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9b267007fso5628046b3a.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412376; x=1706017176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoNFgjU2uuAwx1uE3fJGx4ANiWcUafSa0KGE2hPV8Zg=;
        b=FxxgswzW7l7RtcUDhyZrRDWg/isGDkrzcgiEud6tDQZhixRQf82q6zMH+msGYtX0kR
         dxaQvzknLCkmiUEZ+CJNx38e7E1gE/AI6eXVmQOxLN3ShTUZ8tTGiiYec42TUAgKsYGZ
         xU+0zSLEzALYcjcJx4Eoyg6pJKej/jafKcDZrEgPciLlVrBEl+8a9CmF/Sh8IjzPK5P4
         hdfmlTnhz0KkLzlS8l4GMeZmF7+EdZCxkK9SkIYfeAPfyFKcxJ/CwSIH1dPrOgr0VSzE
         DP9gPOcTRPgLpH7gGxudN3+tW7z1dRUYCgz3uyZHCpatKt/JpTmc0Jm1WJTwsKP9qq5S
         XUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412376; x=1706017176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoNFgjU2uuAwx1uE3fJGx4ANiWcUafSa0KGE2hPV8Zg=;
        b=uFcN3jfY6q97bUYH4X+0p2VLFcQgpMZ0hc0mr8ZEoLp9KdQxPZOzZZQ6LFVqnMB6Gp
         RrHOJOVH4ZJI9zqQ8zaNzeFCY5aAzGQykMeEqvbQhqU0PY/EluSo6LkNIilzfIU0tayJ
         c3cIlnxQRkHnWtP4vFYX43IizO4ZpdPGLKogJxPRL2zwUzwwXRt++CW2YjtgvUrIy5op
         wACCNeyzUY3gP4kWyMNVYYtSN0jXMVknbIBpyaQuU7O4M/GNKpNjbemovLRzevJUrgM9
         XZ3AEnDnhFLFZycJnDJHoizhAktrKXlpCNsquJ3nvZ5QX+fubkwKNxk3fPdf3xASRZ41
         dIIA==
X-Gm-Message-State: AOJu0Yxl78nPRb+Yo7Whrs1Y1zNRh1/DSrBBcPB6ARNuSUnJJrdqHCdY
	aW0S2kd5LBEoDyXKmNHkVDVajFBAi2aTTQ==
X-Google-Smtp-Source: AGHT+IFigsRzZovtE+FsGjFOpfR/K5MWWBVj+Oetu/jmudK16AvR+bc5PXDsaw+9DwWbIfQUqg391A==
X-Received: by 2002:a05:6a20:9f86:b0:19a:fad2:5051 with SMTP id mm6-20020a056a209f8600b0019afad25051mr2240543pzb.43.1705412376613;
        Tue, 16 Jan 2024 05:39:36 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:36 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 4/6] http-backend: new rpc-service for git-upload-archive
Date: Tue, 16 Jan 2024 21:39:28 +0800
Message-Id: <fdab4abb43d4601006ff40f0f5ed89014f811b85.1705411391.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new rpc-service "upload-archive" in http-backend to add server side
support for remote archive over HTTP/HTTPS protocols.

Also add new test cases in t5003. In the test case "archive remote http
repository", git-archive exits with a non-0 exit code even though we
create the archive correctly. It will be fixed in a later commit.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 http-backend.c         | 13 ++++++++++---
 t/t5003-archive-zip.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ff07b87e64..1ed1e29d07 100644
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
@@ -723,6 +729,7 @@ static struct service_cmd {
 	{"GET", "/objects/pack/pack-[0-9a-f]{64}\\.idx$", get_idx_file},
 
 	{"POST", "/git-upload-pack$", service_rpc},
+	{"POST", "/git-upload-archive$", service_rpc},
 	{"POST", "/git-receive-pack$", service_rpc}
 };
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index fc499cdff0..6f85bd3463 100755
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
+	test_must_fail git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
+		--output=remote-http.zip HEAD &&
+	test_cmp_bin d.zip remote-http.zip
+'
+
 test_done
-- 
2.43.0

