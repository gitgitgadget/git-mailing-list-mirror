Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59FC28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiHUN6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiHUN6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BD11C39
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u5so2473038wrt.11
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ErSh/Y6/2IZ/pTwc3r3i2qexQwGSKLkGR89ovseodwQ=;
        b=Jm0bMsudh8B052ZYZROHvB4hN6FbnFd/tka6Hm17Dj2DpLJAjJC9d9xz+/Tu/9uQza
         pKu+4IfjR+C2fgXWvsdXThb8ZHUMrWFHZ9PIpKkiaNhRj8ZaESaJRc0DaRDIS43vu+0P
         1Kuk+eIjGqi2GSxw7taBz4ynI6PEk7Dl5rgeh+DKE+JWO/xJY7mFrhlw7xy4FH90P0CU
         DLyiBqqP2m58yXLLIRZ7ddeoaCE/YNu57+jvCtmN0W5OJEsZ+qOf70PzwkvAe6b9epm3
         TWSljm5xQ3Ia6yhboJlw7dZRy4xSpTee5I0XOYLvVAN1yZHIcLKnsYrpTQRXBXo/Z3uL
         dVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ErSh/Y6/2IZ/pTwc3r3i2qexQwGSKLkGR89ovseodwQ=;
        b=HTl90fn2ifhxENP6Y/upzjBR5HmOKR540V0bz8gS//JMe7u7UcfF2bfstL03u6jBik
         XGi8yXxv1T4m5RIvR+F4n4DGZix/K9StF4CE6AX7JrHynjVpEghPzeL2O4+wL+pKtcOz
         3haDDK8dSkPWvb9J9xz63nifhCGJty+zaxvMC8QccgvkYVD2uW8X+CblcFS79KTviL33
         yRw0D2ZrrNWwK8KuMzEPDiAN96xVTNyJt4IOWgaNSEtfU0JiQB0srkRgVcg0ABmUMqv4
         OxIxfeIeIifXqLfqVIyIxHnR8SZl+0N9MHlGi04eJprbmwb8c3NPiSM1tY1+VNZAYtAP
         2l3Q==
X-Gm-Message-State: ACgBeo0wLPvPOxRPMZ16Je6xo+h4coTmDWnjdWpkOp5PgtonSj2swpkG
        PQOs8H1WFLZbU6bxs6MtKdaaxLHhojY2g164
X-Google-Smtp-Source: AA6agR7l4CAO396O1urPtyHYmEGisPnit86y6u9kWKz/Ynos3m4vL6mpDzUOUIAk2zfWzp6YUOD9uw==
X-Received: by 2002:a5d:6da9:0:b0:225:59e4:1497 with SMTP id u9-20020a5d6da9000000b0022559e41497mr642288wrs.262.1661090311071;
        Sun, 21 Aug 2022 06:58:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/32] submodule--helper: move "is-active" to a test-tool
Date:   Sun, 21 Aug 2022 15:57:15 +0200
Message-Id: <patch-v3-06.32-4727fbb4b64-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "test-tool submodule" and move the "is-active" subcommand
over to it. It was added in 5c2bd8b77ae (submodule--helper: add
is-active subcommand, 2017-03-16), since
a452128a36c (submodule--helper: introduce add-config subcommand,
2021-08-06) it hasn't been used by git-submodule.sh.

Since we're creating a command dispatch similar to test-tool.c itself
let's split out the "struct test_cmd" into a new test-tool-utils.h,
which both this new code and test-tool.c itself can use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                       |  1 +
 builtin/submodule--helper.c    |  9 ------
 t/helper/test-submodule.c      | 58 ++++++++++++++++++++++++++++++++++
 t/helper/test-tool-utils.h     |  9 ++++++
 t/helper/test-tool.c           |  7 ++--
 t/helper/test-tool.h           |  1 +
 t/t7413-submodule-is-active.sh | 35 ++++++++++----------
 7 files changed, 90 insertions(+), 30 deletions(-)
 create mode 100644 t/helper/test-submodule.c
 create mode 100644 t/helper/test-tool-utils.h

diff --git a/Makefile b/Makefile
index e8adeb09f1c..b6acd560e75 100644
--- a/Makefile
+++ b/Makefile
@@ -785,6 +785,7 @@ TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
+TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 24a305151d1..e10c3ac7550 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2731,14 +2731,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int is_active(int argc, const char **argv, const char *prefix)
-{
-	if (argc != 2)
-		die("submodule--helper is-active takes exactly 1 argument");
-
-	return !is_submodule_active(the_repository, argv[1]);
-}
-
 /*
  * Exit non-zero if any of the submodule names given on the command line is
  * invalid. If no names are given, filter stdin to print only valid names
@@ -3316,7 +3308,6 @@ static struct cmd_struct commands[] = {
 	{"summary", module_summary, 0},
 	{"push-check", push_check, 0},
 	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
-	{"is-active", is_active, 0},
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
new file mode 100644
index 00000000000..494c6558d9f
--- /dev/null
+++ b/t/helper/test-submodule.c
@@ -0,0 +1,58 @@
+#include "test-tool.h"
+#include "test-tool-utils.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "submodule.h"
+
+#define TEST_TOOL_IS_ACTIVE_USAGE \
+	"test-tool submodule is-active <name>"
+static const char *submodule_is_active_usage[] = {
+	TEST_TOOL_IS_ACTIVE_USAGE,
+	NULL
+};
+
+static const char *submodule_usage[] = {
+	TEST_TOOL_IS_ACTIVE_USAGE,
+	NULL
+};
+
+static int cmd__submodule_is_active(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "test-tools", options,
+			     submodule_is_active_usage, 0);
+	if (argc != 1)
+		usage_with_options(submodule_is_active_usage, options);
+
+	setup_git_directory();
+
+	return !is_submodule_active(the_repository, argv[0]);
+}
+
+static struct test_cmd cmds[] = {
+	{ "is-active", cmd__submodule_is_active },
+};
+
+int cmd__submodule(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	size_t i;
+
+	argc = parse_options(argc, argv, "test-tools", options, submodule_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc < 1)
+		usage_with_options(submodule_usage, options);
+
+	for (i = 0; i < ARRAY_SIZE(cmds); i++)
+		if (!strcmp(cmds[i].name, argv[0]))
+			return cmds[i].fn(argc, argv);
+
+	usage_msg_optf("unknown subcommand '%s'", submodule_usage, options,
+		       argv[0]);
+
+	return 0;
+}
diff --git a/t/helper/test-tool-utils.h b/t/helper/test-tool-utils.h
new file mode 100644
index 00000000000..6a0e5e0074f
--- /dev/null
+++ b/t/helper/test-tool-utils.h
@@ -0,0 +1,9 @@
+#ifndef TEST_TOOL_UTILS_H
+#define TEST_TOOL_UTILS_H
+
+struct test_cmd {
+	const char *name;
+	int (*fn)(int argc, const char **argv);
+};
+
+#endif
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c3..7a6a8b88a91 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
+#include "test-tool-utils.h"
 #include "trace2.h"
 #include "parse-options.h"
 
@@ -8,11 +9,6 @@ static const char * const test_tool_usage[] = {
 	NULL
 };
 
-struct test_cmd {
-	const char *name;
-	int (*fn)(int argc, const char **argv);
-};
-
 static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
 	{ "bitmap", cmd__bitmap },
@@ -78,6 +74,7 @@ static struct test_cmd cmds[] = {
 	{ "simple-ipc", cmd__simple_ipc },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
+	{ "submodule", cmd__submodule },
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb799271631..5f4f69dee81 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -68,6 +68,7 @@ int cmd__sigchain(int argc, const char **argv);
 int cmd__simple_ipc(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
+int cmd__submodule(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index c8e7e983317..ede6f02dbd5 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -1,9 +1,12 @@
 #!/bin/sh
 
-test_description='Test submodule--helper is-active
+test_description='Test with test-tool submodule is-active
 
-This test verifies that `git submodue--helper is-active` correctly identifies
+This test verifies that `test-tool submodule is-active` correctly identifies
 submodules which are "active" and interesting to the user.
+
+This is a unit test of the submodule.c is_submodule_active() function,
+which is also indirectly tested elsewhere.
 '
 
 . ./test-lib.sh
@@ -25,13 +28,13 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'is-active works with urls' '
-	git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2 &&
+	test-tool -C super submodule is-active sub1 &&
+	test-tool -C super submodule is-active sub2 &&
 
 	git -C super config --unset submodule.sub1.URL &&
-	test_must_fail git -C super submodule--helper is-active sub1 &&
+	test_must_fail test-tool -C super submodule is-active sub1 &&
 	git -C super config submodule.sub1.URL ../sub &&
-	git -C super submodule--helper is-active sub1
+	test-tool -C super submodule is-active sub1
 '
 
 test_expect_success 'is-active works with submodule.<name>.active config' '
@@ -39,11 +42,11 @@ test_expect_success 'is-active works with submodule.<name>.active config' '
 	test_when_finished "git -C super config submodule.sub1.URL ../sub" &&
 
 	git -C super config --bool submodule.sub1.active "false" &&
-	test_must_fail git -C super submodule--helper is-active sub1 &&
+	test_must_fail test-tool -C super submodule is-active sub1 &&
 
 	git -C super config --bool submodule.sub1.active "true" &&
 	git -C super config --unset submodule.sub1.URL &&
-	git -C super submodule--helper is-active sub1
+	test-tool -C super submodule is-active sub1
 '
 
 test_expect_success 'is-active works with basic submodule.active config' '
@@ -53,17 +56,17 @@ test_expect_success 'is-active works with basic submodule.active config' '
 	git -C super config --add submodule.active "." &&
 	git -C super config --unset submodule.sub1.URL &&
 
-	git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2
+	test-tool -C super submodule is-active sub1 &&
+	test-tool -C super submodule is-active sub2
 '
 
 test_expect_success 'is-active correctly works with paths that are not submodules' '
 	test_when_finished "git -C super config --unset-all submodule.active" &&
 
-	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+	test_must_fail test-tool -C super submodule is-active not-a-submodule &&
 
 	git -C super config --add submodule.active "." &&
-	test_must_fail git -C super submodule--helper is-active not-a-submodule
+	test_must_fail test-tool -C super submodule is-active not-a-submodule
 '
 
 test_expect_success 'is-active works with exclusions in submodule.active config' '
@@ -72,8 +75,8 @@ test_expect_success 'is-active works with exclusions in submodule.active config'
 	git -C super config --add submodule.active "." &&
 	git -C super config --add submodule.active ":(exclude)sub1" &&
 
-	test_must_fail git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2
+	test_must_fail test-tool -C super submodule is-active sub1 &&
+	test-tool -C super submodule is-active sub2
 '
 
 test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
@@ -85,8 +88,8 @@ test_expect_success 'is-active with submodule.active and submodule.<name>.active
 	git -C super config --bool submodule.sub1.active "false" &&
 	git -C super config --bool submodule.sub2.active "true" &&
 
-	test_must_fail git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2
+	test_must_fail test-tool -C super submodule is-active sub1 &&
+	test-tool -C super submodule is-active sub2
 '
 
 test_expect_success 'is-active, submodule.active and submodule add' '
-- 
2.37.2.1279.g64dec4e13cf

