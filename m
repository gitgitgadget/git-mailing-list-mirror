Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B7C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiG1QRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiG1QRY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4870E7B
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i10-20020a1c3b0a000000b003a2fa488efdso587251wma.4
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sjFhHPSxclsqDjrWXFDbUXgPrbxzgWAIO6bJF6Fm7zU=;
        b=BA92VGZJ9Rylj4EJIhHBYRvYPvlUSTzwuM2Kg7glzysbe+J9CNya73gsRdUqgERZFb
         qvoHQFY8PcOVdNbhjWErHMqWzj1oArZk47Rv/+NGfZQHl3u7uR9D9Qv+bRcnkq/WawIi
         m9WUiU/yFepRR3+xplKFBmmCdR3ywTyUGTIPIstu+E8yDC3qj//1vaxPy+LOxPnC48IN
         YnbO5PiF9TcyuFfPcWAqqyz0BaEwei1/H70oTU8pPqy8TxgewLZcZs+ssWLAZM5Rqj+d
         JzveCCODiqnjne0nt0BoROKjXHqCwtwcwqgz5QG1bziRhZaZcnLsMdpAM27oWOfU12Qc
         eL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sjFhHPSxclsqDjrWXFDbUXgPrbxzgWAIO6bJF6Fm7zU=;
        b=sZ8OxgqpAQx7VYtiQY3hbSAmDApwSrw0SJBsd4aO+OgHpIsxYtGK10yYC88AK31yT9
         3cloHwAMlY6O0ytNLD5ooyNtR7XK9ITxQNJ67P1/DSEgQy84SKHFeNdjWuJcDPVJU29S
         EqNYYpANP/LmroiQQarePqDf15PnaYR4Paf/X/O5Q9giH9cFPqrtPd2Xp8qfIWsiSd+S
         CcDn5j6u0qz1MLkCuKlK0WruwBjvviDoRI/M+CUrZDPwXnV6tiGRIuXeQc7z6ibvylC9
         +EmClC80hyPKcFeo6g2o6jGYxHS6RFQw16ggRCCvfEqeQ6x7Qam0LJ3FvXlBwBkMZLpR
         UwFw==
X-Gm-Message-State: AJIora/Qhb8tUnEP9Ou6fqfX8lSREHJeYu7gEwXdqRstEJDVU4E5n5tc
        zTefEDldIsMomvRWj/du0SoCLqdE7EwfAA==
X-Google-Smtp-Source: AGRyM1sNNasJ4pFI3y5S1rfmKpjgSHeOS5MTTM+DRIbdZaXWzkxjNzLN3oTHUjg/Rt6T1sA4qVwqcg==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr96153wmj.113.1659025040040;
        Thu, 28 Jul 2022 09:17:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/20] submodule--helper: move "check-name" to a test-tool
Date:   Thu, 28 Jul 2022 18:16:52 +0200
Message-Id: <patch-07.20-a2f3d812815-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "check-name" helper to a test-tool, since
a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
2021-08-10) it has only been used by this test, not git-submodule.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 24 -------------------
 t/helper/test-submodule.c   | 46 +++++++++++++++++++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh |  2 +-
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b2fc732b5d8..06307886080 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2728,29 +2728,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
@@ -3305,7 +3282,6 @@ static struct cmd_struct commands[] = {
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
2.37.1.1167.g38fda70d8c4

