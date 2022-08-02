Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B6C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiHBPqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiHBPq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B919A15FF1
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso7142246wmq.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bPQgxu6eeLdv8E/NpssVQzROEiUxCAW1M4qDI651Ias=;
        b=C/LNKgdzqflzM+8I27vHIItK+9Y3BilCSToeC2HGYPVxAjW37loYMIMs6R9ca3wDz2
         5Vs7Lng4bBHM3PrF6e2VZKypDCf3FME/5wuOWa7XHMYp99I0xFF4Sk/IWKOTCSqx4vPB
         OS+JIb7kMSdOKrYnftJSKjWaI37NgoUqf9xCgtOowZdYSXYkocAyKfMyLMhv3ToVMu2U
         OaZ64xyv9eSY0TSskn4ihkT+bnKa1JonpHApwR7g9kya7mg7Y2Js/CViFEB+AqxS12zO
         fzEEKO1kaWfh3thKcQTN3S7VzgcVDetl72pXdXS8WULLq7dbwLUPy78mawn/K0of6e2h
         jQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bPQgxu6eeLdv8E/NpssVQzROEiUxCAW1M4qDI651Ias=;
        b=KHP7925l01kk9fa3NMuZbGHMZ+cxnOXoryw9NEjHHnaMHFGT1ZcKgPfcYDFIweiRRI
         6OjZLh3/LIRwikvDytUOk+nE/fO+gwQsr23RIQr3KnwH8rRz5hULXtu1c5wrq4x0eV6Y
         dpVEvns077lzBEnGj+l2oAuCsUbku8iaN+2lCwUocKLrW9TZjv0od+1XS0zEetCdfUkp
         Cnah+UtbVsL+MqbbJqw7jhiEnagWNhzBQuQiK5JBeuEBeLBDEJmoy5fjsOTBas+kB08b
         p/dtuLroynaSZvkqSA8tFfaqWMsr8pkAN0aG/+zwwJIJub1pAkfUhDN1VTXdKC22EnHo
         aX5A==
X-Gm-Message-State: ACgBeo1HL54065p9/3Eelr7Pn8nZAHcr8TatGlHEoRs/5MYhXmyxcGLJ
        jtzGnDQvabvaQfxrFOQIxbNmrPLp8WqQjg==
X-Google-Smtp-Source: AA6agR5tS9IP9Z1klj6GczH4CooTcT9q4+/bkB/mXLHPJplpBCras9aCAL1lPJny7XZJVXfDdQURZg==
X-Received: by 2002:a05:600c:1c96:b0:3a3:10b6:e84f with SMTP id k22-20020a05600c1c9600b003a310b6e84fmr41389wms.175.1659455183744;
        Tue, 02 Aug 2022 08:46:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/28] submodule--helper: move "check-name" to a test-tool
Date:   Tue,  2 Aug 2022 17:45:51 +0200
Message-Id: <patch-v2-07.28-b209532eb17-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
2.37.1.1233.ge8b09efaedc

