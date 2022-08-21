Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2EC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiHUN6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiHUN6f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4E11145
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k17so4375249wmr.2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hjdESJGog2T5WAlUFII3ek6mzY9CaXBVt2zJijzNBa0=;
        b=eY1ztPZ0ex+MT74+G98zIouMQT5NztdW5hS2/n9nSdPO9V1a3/Gutw5GIWECSMCgaM
         bmq93h3YE9GaCFMo+HggprVpSH2UQsCWBx+hF4327nkriyhc1GF8qUJuvAF/SSu/bFEU
         jWPHIzVS0k+5xR9SWVuwXpsKHoj47IFmi9Wy4a5b+r4LFBuwoc9AdbqY/7RYy1bBui48
         jd+mMKW6s2BjMcQ5PetA81UCit/iLS7W3iPmtAHX8HJMhgcfog4x+ku6Pq6yLQfSc8wu
         8Xplui1TA4Q+IfeDHMq8BeNhDwWzENcoklODce/gTMz2pf3xF+knP3HX+i0bX1DaHNGP
         NnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hjdESJGog2T5WAlUFII3ek6mzY9CaXBVt2zJijzNBa0=;
        b=mDJIrLVCSYQxcA5cxTU2w3+XRRUWousmgZOfOBlEQMbFnHWWZ2VC0QLMh1Mz00IecH
         IlE0ZdPH6oX6ncWwTmLTzNgXxahrac8WBfAtHYGVzzGQpa45v4BcWk73GWmIMtTcvOtT
         6JUWQuQaalhPA6fNPFvwjh3G1BmtkiqsFfCfAmKFGIzP0+U8+lFu214ZAfqA0WuQLSrf
         g7wnn+Ietr8Hc9ooNczf6G9gy3XV48cRQhoyCM2A/LEKR3jVfQkJjmCu+WW5qskUEj8z
         Y8ICTVewbuBEwXKDZNI/NSc4w8xwwtUnmkfXdaBj+Lkw1QpDMBUyhDQGRR1Ya3XTzZM6
         RU8w==
X-Gm-Message-State: ACgBeo3kOcggG8HHbmC3nBnlmFJlz3LCXo8cx61p0Wg7ldUR22RAKbsJ
        J6rNtzOMvnCbiuvm1SslyLdg/RByy1JR8Or9
X-Google-Smtp-Source: AA6agR5XY+Hk20YhAvPmTmTQD/1WQiB5kmKqA20cicX2xFOE2KwPkvru7PqcnLTTxw4UjRu2yWmZgQ==
X-Received: by 2002:a05:600c:1988:b0:3a5:f47c:abce with SMTP id t8-20020a05600c198800b003a5f47cabcemr9827451wmq.121.1661090312473;
        Sun, 21 Aug 2022 06:58:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/32] submodule--helper: move "check-name" to a test-tool
Date:   Sun, 21 Aug 2022 15:57:16 +0200
Message-Id: <patch-v3-07.32-9c644460b1d-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
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
2.37.2.1279.g64dec4e13cf

