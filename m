Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD9C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiG1QRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiG1QRY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1447170E52
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d8so2848736wrp.6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QHFm9gdKeeINR5O3DcoBWfFMYWUYI+Mv86kav0HfeWc=;
        b=KnZAMayO25KTOyflfhJSAfiwo1FjEbd6XjQrnIBKi+yptzcXv4a4S0gIub7PHI9W34
         ts91AYm2TRx9ggZhomjOsfiEIAm9gMf4hBGd0uhcOVZhGnL/zuLtBXXwsq1OGTZYa5kT
         zV2VYUhezSFQqes4lsMvFvWNaLss8kMvJOelAD8pHNb503e/XTglvIdZpDrWXEnrg18A
         8wUJm+Htywx5hB07L5U+rHLJYEXnF7RLBPgx25JEIhZiWWtXRappb3m9YeZRmn9ftpgj
         EqWhy1QJ+RnWpvs1o8R+TtZOcnTYb2kjSYObttKCnljD9dlQFHewUjd/GgdnV2Yi0pUx
         sBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QHFm9gdKeeINR5O3DcoBWfFMYWUYI+Mv86kav0HfeWc=;
        b=y+bMy/JpgbeaTDVFKHdwnvkUC48CbRI99b+9a3iCX7msKTt9afRIpAZm+8tDaeFzlR
         vSjFdlkGSBBL0OzNOgohvtc9HFHL1Xhgf3mD6O9sqAWhul2AtMcVyZSnCvaZzF17B9Kh
         +Q23Ytqvqq92XWoLvv4PYdWBoyjRyOK/Qw3ui9/rFSiLqkGpROHpeKgZtSORY2bfkYvf
         Jp8pjUApyRAZaQ61sc2L0fDsWCTDdwA0iknR5U5R39sROu3F8Tmu2IwrADHYUUglFUix
         vVcKv6brGil/Bf8OyxjqYET186wUNoERqvskSP+o1v8JpSic4wQOFRdSP9cMD9Yys8Br
         b4WQ==
X-Gm-Message-State: AJIora8zf7cVIDMExdf9UX7n38bYvyOIa8BBso3LQMjpUU6YeFifyXVb
        mibxL/kCSDCVmVCuk+OGTqEclY51FnWiLw==
X-Google-Smtp-Source: AGRyM1ucYF1UPJQ7fbLrYQTD9Qx7iRwFoFpAhaMRf5HaXc5oEDF6LXdd6tm7PQ2D+KEgGjqoMol9pA==
X-Received: by 2002:a5d:5a82:0:b0:21e:2899:60bd with SMTP id bp2-20020a5d5a82000000b0021e289960bdmr17506177wrb.80.1659025038310;
        Thu, 28 Jul 2022 09:17:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/20] submodule--helper: move "is-active" to a test-tool
Date:   Thu, 28 Jul 2022 18:16:51 +0200
Message-Id: <patch-06.20-8e4d2b09d56-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
 t/t7413-submodule-is-active.sh | 32 +++++++++----------
 7 files changed, 87 insertions(+), 30 deletions(-)
 create mode 100644 t/helper/test-submodule.c
 create mode 100644 t/helper/test-tool-utils.h

diff --git a/Makefile b/Makefile
index 1624471badc..ad7fbd36885 100644
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
index 47ed24c6a60..b2fc732b5d8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2728,14 +2728,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
@@ -3313,7 +3305,6 @@ static struct cmd_struct commands[] = {
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
index c8e7e983317..9ead083371a 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 
-test_description='Test submodule--helper is-active
+test_description='Test with test-tool submodule is-active
 
-This test verifies that `git submodue--helper is-active` correctly identifies
+This test verifies that `test-tool submodule is-active` correctly identifies
 submodules which are "active" and interesting to the user.
 '
 
@@ -25,13 +25,13 @@ test_expect_success 'setup' '
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
@@ -39,11 +39,11 @@ test_expect_success 'is-active works with submodule.<name>.active config' '
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
@@ -53,17 +53,17 @@ test_expect_success 'is-active works with basic submodule.active config' '
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
@@ -72,8 +72,8 @@ test_expect_success 'is-active works with exclusions in submodule.active config'
 	git -C super config --add submodule.active "." &&
 	git -C super config --add submodule.active ":(exclude)sub1" &&
 
-	test_must_fail git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2
+	test_must_fail test-tool -C super submodule is-active sub1 &&
+	test-tool -C super submodule is-active sub2
 '
 
 test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
@@ -85,8 +85,8 @@ test_expect_success 'is-active with submodule.active and submodule.<name>.active
 	git -C super config --bool submodule.sub1.active "false" &&
 	git -C super config --bool submodule.sub2.active "true" &&
 
-	test_must_fail git -C super submodule--helper is-active sub1 &&
-	git -C super submodule--helper is-active sub2
+	test_must_fail test-tool -C super submodule is-active sub1 &&
+	test-tool -C super submodule is-active sub2
 '
 
 test_expect_success 'is-active, submodule.active and submodule add' '
-- 
2.37.1.1167.g38fda70d8c4

