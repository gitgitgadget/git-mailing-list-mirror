Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8EC32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiHUN6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiHUN6h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805FF13D69
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6447399wmc.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8Rz1uVDQWz4U0y4cf4XURYAetYXhFpBSzZfUy6MXW2E=;
        b=BwOG2boKdfyQC+iDIslCmtk4KvoNlxVwayqRW7Ktk9/EjeIbsb0+8mZ3e8gRKHgVea
         vwH6KaJgLh528dCxeTEmpTeEJLkXdfUyvOJOrF5ogtxycpjqAbRp/Ps8Ih54ZPQ9C6rO
         bsrrramblCyHKh10Dn/5psTRe6y52vpX9d1G9fbnHYOms30UjYTBciG0EIozn4gVXiZi
         wiA3cNcKBnDyMdT7pkza+IfPWhEWDJq+GK3bEsD6+UFJrhzHbTGKmQPxTIoHWWIKPRQT
         6VbbtaYTPI/WreyXrIPOdTeUAeiJlj+VDsuQSRvzRhunzdasWQiBv/PoYLF0jnSx5Fm4
         F4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8Rz1uVDQWz4U0y4cf4XURYAetYXhFpBSzZfUy6MXW2E=;
        b=dofhTWNgIAhYlShYazMFY6doXE+khRW86BYdm9smYQprxxnasgtSSkAC+gQvY1GzkW
         W7KiqUVR1Yh8mq23ZSrppwi7enJIrFmNxLJhyRgcLcUzVF2+lOhts/BojMa33AihTJqK
         95lENMfE+Yu8RZK3/9YhpF+F4vdKRxiFUjT+nqQyktw15LcnWvMVm/eq+mzSD9OvEJVK
         l1dRtqsDSRc3L6CAsxLw7z+AmlJe3Levpn4ah/Npqk3tuF5w31fCQm1fUYP5BgcS9DLX
         1QAQOWegHDKWKDLSPwVeaEw8LhvD1bAWslT5YIu1tiD75lfSH9TdkjLPoUDqZChe1k74
         +JpA==
X-Gm-Message-State: ACgBeo2NzvgiISxm+iCrfrGx6PT3OT8mlcxWiAvROL0F8JZcGK7/JDHa
        mg96Gg1J1prShr0kLJfdQTmSdpHCb696QSYi
X-Google-Smtp-Source: AA6agR5oDAlhX4ybw4WGKKdxTm6VIbnN8NwSxoOJ1jzrZfq89RYj/+2n/KE/1/etkdOS1qSDOCNiaA==
X-Received: by 2002:a05:600c:2315:b0:3a5:c2cc:1bee with SMTP id 21-20020a05600c231500b003a5c2cc1beemr9330758wmo.55.1661090313763;
        Sun, 21 Aug 2022 06:58:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/32] submodule--helper: move "resolve-relative-url-test" to a test-tool
Date:   Sun, 21 Aug 2022 15:57:17 +0200
Message-Id: <patch-v3-08.32-03c8383b8e7-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
2.37.2.1279.g64dec4e13cf

