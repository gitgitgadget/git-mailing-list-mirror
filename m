Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB2ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiHaXSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHaXS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D6AB028D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so17400858wrm.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5k8eYK9zyJeTYgUgdzpGQxnycG1vPL2+jeZWUCaYE9o=;
        b=QmFNSumtqW2KO+zbqZdWf0YdTjgEZIENq4FE5ESJ/ucCqKtFMQoChPaZZkCpoNpjhR
         97G3pDtKdcLJE58PuoF9Qy296LHjvyHRK85ywQLowvIxtEHF04O0NRdHCkeiLdD5mMdW
         wLLs5f/hOi44uOoGKw71D/zozMiDdCMyxGVRsT+gJPhuCSJ1lFl2JBN6UZw+unXrDpJA
         94/Ea5jSSSkN0rrt90tt/oxl4jf5dGpRh5MaewyllsLWStbNs4VWg1MWYHq+rAbPNUmm
         u1H29GILFr5vbQELiyF5M4kVz3/SnIyg2Z/SU1lYoXV7BR/0AOhDj3OHalRtCVwJxOdu
         awrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5k8eYK9zyJeTYgUgdzpGQxnycG1vPL2+jeZWUCaYE9o=;
        b=XVt/OkITdPdPLwCIa48IGORddScEJyxsr9mIqT4nJ1aUvk9YSPCbyJjHv4bKMlfVAT
         P2Ct1LzEJu6ww41rl5G3DYn1w0Hu4x1H6hCcyVE8F3MyquWtw8bji4MICU7C+eMj5W1n
         ajO/4xg8xv7S/WOAD1U1wtNS/Tf7wIK23L7se9ISGIzJrsN6rBwS7gyv03H92KcYlicj
         dKVKPHoN6RGRq8oggimu2eOPshaWj18QrXH7md5LcqeHaInjDKnclGxM+6AJvx5DUe2J
         dfkvSDsuKAr9TgGnf5doztR4CxCI7MXTAJEJaLYQlnlR41O7gHnerfx6xiCsS06FPYOl
         U9fA==
X-Gm-Message-State: ACgBeo0YN6FH53adpujlXQ+GwZ8sbh7+OODlTsP7LmVwl9tCnrxkYko0
        dxkP2oj2zCygdhSRDrFojpUbA1ji/Rjl+A==
X-Google-Smtp-Source: AA6agR7vN1/HZ1arDiqb/5DLIoYsHDe0kz8/eNUlZ3YOkx6y9gEqy9i91NIxsYuZ9rmkS/XLTevoJw==
X-Received: by 2002:adf:ee52:0:b0:226:f190:44d0 with SMTP id w18-20020adfee52000000b00226f19044d0mr1191216wro.503.1661987906017;
        Wed, 31 Aug 2022 16:18:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/33] submodule--helper: move "check-name" to a test-tool
Date:   Thu,  1 Sep 2022 01:17:49 +0200
Message-Id: <patch-v4-07.33-3258b5a609d-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "check-name" helper to a test-tool, since
a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
2021-08-10) it has only been used by this test, not git-submodule.sh.

As noted with its introduction in 0383bbb9015 (submodule-config:
verify submodule names as paths, 2018-04-30) the intent of
t7450-bad-git-dotfiles.sh has always been to unit test the
check_submodule_name() function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 24 -------------------
 t/helper/test-submodule.c   | 46 +++++++++++++++++++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh |  2 +-
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e10c3ac7550..e8458567976 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2731,29 +2731,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-/*
- * Exit non-zero if any of the submodule names given on the command line is
- * invalid. If no names are given, filter stdin to print only valid names
- * (which is primarily intended for testing).
- */
-static int check_name(int argc, const char **argv, const char *prefix)
-{
-	if (argc > 1) {
-		while (*++argv) {
-			if (check_submodule_name(*argv) < 0)
-				return 1;
-		}
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		while (strbuf_getline(&buf, stdin) != EOF) {
-			if (!check_submodule_name(buf.buf))
-				printf("%s\n", buf.buf);
-		}
-		strbuf_release(&buf);
-	}
-	return 0;
-}
-
 static int module_config(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -3308,7 +3285,6 @@ static struct cmd_struct commands[] = {
 	{"summary", module_summary, 0},
 	{"push-check", push_check, 0},
 	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
-	{"check-name", check_name, 0},
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
 	{"set-branch", module_set_branch, 0},
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 494c6558d9f..9f0eb440192 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -2,8 +2,16 @@
 #include "test-tool-utils.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "submodule-config.h"
 #include "submodule.h"
 
+#define TEST_TOOL_CHECK_NAME_USAGE \
+	"test-tool submodule check-name <name>"
+static const char *submodule_check_name_usage[] = {
+	TEST_TOOL_CHECK_NAME_USAGE,
+	NULL
+};
+
 #define TEST_TOOL_IS_ACTIVE_USAGE \
 	"test-tool submodule is-active <name>"
 static const char *submodule_is_active_usage[] = {
@@ -12,10 +20,47 @@ static const char *submodule_is_active_usage[] = {
 };
 
 static const char *submodule_usage[] = {
+	TEST_TOOL_CHECK_NAME_USAGE,
 	TEST_TOOL_IS_ACTIVE_USAGE,
 	NULL
 };
 
+/*
+ * Exit non-zero if any of the submodule names given on the command line is
+ * invalid. If no names are given, filter stdin to print only valid names
+ * (which is primarily intended for testing).
+ */
+static int check_name(int argc, const char **argv)
+{
+	if (argc > 1) {
+		while (*++argv) {
+			if (check_submodule_name(*argv) < 0)
+				return 1;
+		}
+	} else {
+		struct strbuf buf = STRBUF_INIT;
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			if (!check_submodule_name(buf.buf))
+				printf("%s\n", buf.buf);
+		}
+		strbuf_release(&buf);
+	}
+	return 0;
+}
+
+static int cmd__submodule_check_name(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, "test-tools", options,
+			     submodule_check_name_usage, 0);
+	if (argc)
+		usage_with_options(submodule_check_name_usage, options);
+
+	return check_name(argc, argv);
+}
+
 static int cmd__submodule_is_active(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -32,6 +77,7 @@ static int cmd__submodule_is_active(int argc, const char **argv)
 }
 
 static struct test_cmd cmds[] = {
+	{ "check-name", cmd__submodule_check_name },
 	{ "is-active", cmd__submodule_is_active },
 };
 
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 41706c1c9ff..2c24f120da3 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -21,7 +21,7 @@ test_expect_success 'check names' '
 	valid/with/paths
 	EOF
 
-	git submodule--helper check-name >actual <<-\EOF &&
+	test-tool submodule check-name >actual <<-\EOF &&
 	valid
 	valid/with/paths
 
-- 
2.37.3.1420.g76f8a3d556c

