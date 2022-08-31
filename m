Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0319ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiHaXSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiHaXS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322CB08BB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e20so20097133wri.13
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pML3uT81R2gzSfEf6NOny1nK+miWtvP9JGYOnsbF1us=;
        b=afdySUtIVo+1ZwxuGXTjyhYZ2nbEFq/8bZPRJpGlKhEGMoIw7A8goPB0Yl4XRV4+5c
         pIfTpVd5+/iggbAYHsop7LiKyxj+p872m3TbgAxZz8UntJy3rtWwDuxkAwc/rmXhhK5C
         EuPo/Gwl12NCrXdDgAyfXSuEoBZMJ0jrKhrlby4rX2uvzfLIZC3q7VK/n5ZxNi9xGDCt
         fkLbveE3LaFRMFoTk1hCyjDbWn22JtIQrcykkSjr/yy9FkVAVJusYK/uojr+9xM80NXg
         QpVBaSqAzD9CefK5tBIdNWLXhqNdkZm5bBmwjOgt7tXvOIQQLntRgr++Vp3TKKjGvs0B
         w9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pML3uT81R2gzSfEf6NOny1nK+miWtvP9JGYOnsbF1us=;
        b=1n9JgKG9fiKT816QyqEV9jwXvEpQkMQf9nM1XjxV7wIPYfnmley4Im1SGgpdpPFWbR
         zxZ59YpemA2pz8yIPVf5WYyn+A64n//6pNlcd6gPRbB2ytD67FHnPlzjonapvILaYvjf
         jJGOaUq3KGgCBs0GLcO42YWlIPlDyo9Zr5MEIrerMldVYHBxHHYjGpYrJbKFziMQbnMM
         lSWmcEWG6Lz2WrP1JfqwZ7icNIrM0RR89+0xCDF1S6kmPupWCEwUXgoBUvPqUsxHHsyj
         ji6k25hepGTWvV+bUkBebGZmS+XVu8XAmV0yCKljUh3lHr/wrIx+Ji6qh2w3BTRSY4kQ
         QPVg==
X-Gm-Message-State: ACgBeo28aBvSjCIoOrAsi4WzCh1jwmJjhLKuWHsKV54sQsx5q3muI4gQ
        t6TsPpb8isFTkPoP2etG5Hhjgb5cawO2lg==
X-Google-Smtp-Source: AA6agR7p2+ug0NV36sCUFDlHmx52tukJaGvED9ofu53hUKAb+STnuWZhPaWYjIYPg+hFTtmdlPGXCw==
X-Received: by 2002:a05:6000:682:b0:226:e78d:2d7a with SMTP id bo2-20020a056000068200b00226e78d2d7amr4524382wrb.103.1661987906953;
        Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/33] submodule--helper: move "resolve-relative-url-test" to a test-tool
Date:   Thu,  1 Sep 2022 01:17:50 +0200
Message-Id: <patch-v4-08.33-4e6929f05ec-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As its name suggests the "resolve-relative-url-test" has never been
used outside of the test suite, see 63e95beb085 (submodule: port
resolve_relative_url from shell to C, 2016-04-15) for its original
addition.

Perhaps it would make sense to drop this code entirely, as we feel
that we've got enough indirect test coverage, but let's leave that
question to a possible follow-up change. For now let's keep the test
coverage this gives us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 23 --------------------
 t/helper/test-submodule.c   | 42 +++++++++++++++++++++++++++++++++++++
 t/t0060-path-utils.sh       |  2 +-
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e8458567976..7e2986902dd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -96,28 +96,6 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	return resolved_url;
 }
 
-static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
-{
-	char *remoteurl, *res;
-	const char *up_path, *url;
-
-	if (argc != 4)
-		die("resolve-relative-url-test only accepts three arguments: <up_path> <remoteurl> <url>");
-
-	up_path = argv[1];
-	remoteurl = xstrdup(argv[2]);
-	url = argv[3];
-
-	if (!strcmp(up_path, "(null)"))
-		up_path = NULL;
-
-	res = relative_url(remoteurl, url, up_path);
-	puts(res);
-	free(res);
-	free(remoteurl);
-	return 0;
-}
-
 /* the result should be freed by the caller. */
 static char *get_submodule_displaypath(const char *path, const char *prefix)
 {
@@ -3276,7 +3254,6 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
 	{"update", module_update, SUPPORT_SUPER_PREFIX},
-	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, 0},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 9f0eb440192..e0e0c53d386 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -2,6 +2,7 @@
 #include "test-tool-utils.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "remote.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
@@ -19,9 +20,17 @@ static const char *submodule_is_active_usage[] = {
 	NULL
 };
 
+#define TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE \
+	"test-tool submodule resolve-relative-url <up_path> <remoteurl> <url>"
+static const char *submodule_resolve_relative_url_usage[] = {
+	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
+	NULL,
+};
+
 static const char *submodule_usage[] = {
 	TEST_TOOL_CHECK_NAME_USAGE,
 	TEST_TOOL_IS_ACTIVE_USAGE,
+	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
 	NULL
 };
 
@@ -76,9 +85,42 @@ static int cmd__submodule_is_active(int argc, const char **argv)
 	return !is_submodule_active(the_repository, argv[0]);
 }
 
+static int resolve_relative_url(int argc, const char **argv)
+{
+	char *remoteurl, *res;
+	const char *up_path, *url;
+
+	up_path = argv[0];
+	remoteurl = xstrdup(argv[1]);
+	url = argv[2];
+
+	if (!strcmp(up_path, "(null)"))
+		up_path = NULL;
+
+	res = relative_url(remoteurl, url, up_path);
+	puts(res);
+	free(res);
+	free(remoteurl);
+	return 0;
+}
+
+static int cmd__submodule_resolve_relative_url(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "test-tools", options,
+			     submodule_resolve_relative_url_usage, 0);
+	if (argc != 3)
+		usage_with_options(submodule_resolve_relative_url_usage, options);
+
+	return resolve_relative_url(argc, argv);
+}
+
 static struct test_cmd cmds[] = {
 	{ "check-name", cmd__submodule_check_name },
 	{ "is-active", cmd__submodule_is_active },
+	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
 };
 
 int cmd__submodule(int argc, const char **argv)
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 1f2007e62b7..68e29c904a6 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -22,7 +22,7 @@ relative_path() {
 
 test_submodule_relative_url() {
 	test_expect_success "test_submodule_relative_url: $1 $2 $3 => $4" "
-		actual=\$(git submodule--helper resolve-relative-url-test '$1' '$2' '$3') &&
+		actual=\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &&
 		test \"\$actual\" = '$4'
 	"
 }
-- 
2.37.3.1420.g76f8a3d556c

