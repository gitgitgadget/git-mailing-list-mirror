Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16F4C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiHBPqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiHBPq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2F1582F
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so18344449wrh.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SKXb+HV+WXf3P4kshAJidJGM5JintZzmRQPcBJ37QH0=;
        b=S9fhfn0EiAkdWLi/sY/X0+sl2tEnRaY/zuPk4/2NlE0t1asoRVkuPRahnGJiItOtx3
         IcUSQRp0FQZ+qq7Dwsv3Mtbh53wfWO3rDA3qN6SQa1cNt8RJ9lOc/8u4gconFjEvqm3I
         ndzTBD28Qsb6dUd5eBlzjcLO2DP7f7XqSELQu8xqa8jmLmEgJkwzuyoRjrYqy0gY7WlK
         35fXnvlEzvsYGteTdokfivVotrS6IUl0MftA+cLiNqW20z9n6gReSNY7jxQS1DUG7rcp
         OimjEJPvwDpvQHFUke0RuzNHaJZlzkPRmpTFr1zmuo8p1dqs95rhKz12E2bZfllJ8gjw
         xMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SKXb+HV+WXf3P4kshAJidJGM5JintZzmRQPcBJ37QH0=;
        b=BYvKe/5GOnDTqdxhPiqr+KR9ie9qGcZeSl14RXIsCpP91c9HfL7NwGJV3DuTXwtvAd
         9p1F6ADPDYy2pS4S08uFKZwG1eMwaGYm9KJ6yta5b/kpX6FJCnXyDCBL4LReMkK7cz3J
         6SvdvY7wNAo5FjOqkxTHbZJWQpiBVpmHLLgTJ10ZiTe4DFBPRwJSgfSsQyVl8tC+h7NA
         /gx7oJRS4TuE1bxGeW3pE2D/uwyHbN1S30dZxPkdmYbX5tPXLaLgzn0xMzR7N2pHHL5v
         5x2MQ6rBDd11dHfqQ0pudq+QoWM56A8BN2sevL7j7JVwjmzqOlFiF+Kfeu609cu84G7v
         KeAA==
X-Gm-Message-State: ACgBeo0q9AvsafDC9CDltL31XRdXPus3q7fbqFcgCYzcDbG3VWIC5vce
        FIO0S+wLkUZ0taQHly7bz8JKnALuhRcfxg==
X-Google-Smtp-Source: AA6agR44gtN4O0KCx1SP4ROp/jQqwILTFnTroBGsuGruwgewK+O4pIfE2morzXrg8x9N7u7O5e+2xQ==
X-Received: by 2002:a05:6000:18a3:b0:21f:d6a4:1aec with SMTP id b3-20020a05600018a300b0021fd6a41aecmr10129043wri.468.1659455182786;
        Tue, 02 Aug 2022 08:46:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/28] submodule--helper: move "is-active" to a test-tool
Date:   Tue,  2 Aug 2022 17:45:50 +0200
Message-Id: <patch-v2-06.28-e2a8bb0a28e-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
2.37.1.1233.ge8b09efaedc

