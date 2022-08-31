Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73420ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiHaXTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHaXS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3AE9F1B8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m16so20104343wru.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8WzJKAjKTZZJg2AloaeMOYJFB0/nh3T5sJd8jI3W/5Y=;
        b=na14QfeuqBDtWV3ODX+5N6oYqlaYakb+SL3LDqjpiHgtN89xhWJtDKx49el0knurQQ
         YmM5FUyzcXPils5zNGIUKNoB1H0F7UMSk86bNxpMCg8ezs6lH2bY9nyC5MgMO12O4V9Q
         4hDuLkUl/IXxy/fBR1jpTEOU8QrAOwyFcb5GnNRvlQ5hnc2jKJrpD55SQkamN9y4jeNu
         mkdqNNeedH57ZOQeCergB284Yc0g1CG41lxeVzFoig2q2oitvyn683uaEpAsRfV9osKh
         +rCEt02bdQijB9z/ASP3ML28aclT6pikxx3z8GZOC0jESkPm4xVMZq+1aND/C90RqZWa
         tdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8WzJKAjKTZZJg2AloaeMOYJFB0/nh3T5sJd8jI3W/5Y=;
        b=zF5Vq+gDw+8zYKChHsWnVWyJiBSpTr1qH0FTMqpYcQI6iRCbeZKdlb62P+HaaP9Tdf
         zeSSmVQi8v3qBf31n/gBOhZsRBMh4JmDG0w7S6PxcvkEh98eLDCNSA7Fh2Y7cUJT8OYw
         Til68KT8FWzzyE5rRwzcj1K2qAGrrail2NYy4AcazuaE5fh6vRvA3vkfSr3kupHQ2d7j
         3UyFWLEHLn+rSlmbT9OVftZB4ABz7PE/SMwo7L2oHw8COrbV7aZpE18/8QgtlDZmQXzA
         UbLSLWm4YfK16x4oLEpHz8p7ib5cxDQX/0CkQQ/dwZqSFDw2USeqICvN4j4DmpBoV0Q1
         avnw==
X-Gm-Message-State: ACgBeo1+qCuag8V6ZutPKLCkUjy9wessjPOolG/5Llg4RHfBKe4dXP9F
        mrsb8/dM/TqpF0Qx9dc+cpxOndAzq+hbqw==
X-Google-Smtp-Source: AA6agR73TjLwl6O+ys4g2DJsnjBJXvmaKATfkoiFq9AFIwD94lsVkDJHQPD14AE5Ye9wrg51iRgj0g==
X-Received: by 2002:a05:6000:168d:b0:226:da6a:6d78 with SMTP id y13-20020a056000168d00b00226da6a6d78mr9351823wrd.180.1661987905204;
        Wed, 31 Aug 2022 16:18:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/33] submodule--helper: move "is-active" to a test-tool
Date:   Thu,  1 Sep 2022 01:17:48 +0200
Message-Id: <patch-v4-06.33-51d2d946b4f-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
index eac30126e29..e0daec07306 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ TEST_BUILTINS_OBJS += test-strcmp-offset.o
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
index d6a560f8325..50a6ae38a7d 100644
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
@@ -79,6 +75,7 @@ static struct test_cmd cmds[] = {
 	{ "simple-ipc", cmd__simple_ipc },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
+	{ "submodule", cmd__submodule },
 	{ "submodule-config", cmd__submodule_config },
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 21a91b10195..6921a6fc2c5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -69,6 +69,7 @@ int cmd__sigchain(int argc, const char **argv);
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
2.37.3.1420.g76f8a3d556c

