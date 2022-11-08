Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04B7C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiKHOKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiKHOKw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:10:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B0C18385
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a67so22621780edf.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpzMc0UPmK407d877d9an1BGuZTWuZH98mv/TUVkm2Q=;
        b=PXmd44CdwOLA5m9/SgjP0iax7nbm0e2yzPgeQkL/1AK6kUna0QfzhUOJucx4KmzXR5
         9yxhwG8uh/epL2FVyhbqN/KZpk9WGlxnBECIo5RqMI4f41LBXVs61Fo+s7D7LTEcyNmn
         KrXOQbSE1/xTySMXXSsTMnNwwzYLN6gBnkDdPqi2QJ+nSlSeouiIruNmqt/TYbD9pJhH
         vKABDr/CPj/OydC/v6e0SDJ93Qg3x9ivVcVt438GMD2kLfAi0Nlm+yLWANgF1ibjTvwo
         5R3wDxVtwE8gzJfXIwHTBQyaVTh7OPRiemU1Hu7fluVmgi9PfKSWzhqwBkf6vQvN4ha/
         Ut4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpzMc0UPmK407d877d9an1BGuZTWuZH98mv/TUVkm2Q=;
        b=IEjeuuMrbNaRilDUVv7312lTxNIRzRag64pQFDfqHPREyMLRPlYOb1/QENz+WYETpj
         9HKGgBWM0mk7zPmsZK9XMjR6i4DRtltEgsAzQ3/rXhmjRV8R6qJgugIpW4pMGJi0WyKF
         3XrrnJ+/OQTjN28odP0SYFjhZH+Wi7HoYpkZyGRSLf/elT7vpzjuXI7uTxMvdFHLCboa
         olfaPBn5Ih+mHZ7SmgZ2GBuzWqgRnmHovybrkNi0SgvO8J1MXFe8ZnhHpoXUhcrtTck+
         61s7FjDwwoFJg+sJ0P3QYi/kR6HGYudVBcg8ZBmuWNAqpJpIH0sC16n0nCoyfuBe6pEx
         PNKg==
X-Gm-Message-State: ACrzQf0BomqzAMMLc3Yb68YlFFmhCiNfaDok1BSp11vkV6c7FQLRP9b2
        4e3RmKuiQDZGGCYbaTCbc1aT+SYR0KZpRQ==
X-Google-Smtp-Source: AMsMyM57WmaGqPHN6/+HHmF3+L0H8NrE/RGQGJgcUbKVw3SFGgLp8RB7Fut9Q16c9W6zME32HKMcNg==
X-Received: by 2002:a05:6402:f24:b0:461:7c77:98c4 with SMTP id i36-20020a0564020f2400b004617c7798c4mr54207611eda.80.1667916649307;
        Tue, 08 Nov 2022 06:10:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] submodule--helper: move "config" to a test-tool
Date:   Tue,  8 Nov 2022 15:10:32 +0100
Message-Id: <patch-v2-1.9-ca8f8b4bf63-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with other moves to "test-tool" in f322e9f51b5 (Merge branch
'ab/submodule-helper-prep', 2022-09-13) the "config" sub-command was
only used by our own tests.

It was last used by "git submodule" itself in code that went away with
a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
2021-08-10).

Let's move it over, and while doing so make it easier to reason about
by splitting up the various uses for it into separate sub-commands, so
that we don't need to count arguments to see what it does.

This also has the advantage that we stop wasting future translator
time on this command, currently the usage information for this
internal-only tool has been translated into several languages. The use
of the "_" function has also been removed from the "please make
sure..." message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c            | 46 --------------
 t/helper/test-submodule.c              | 84 ++++++++++++++++++++++++++
 t/t7411-submodule-config.sh            | 36 +++++------
 t/t7418-submodule-sparse-gitmodules.sh |  4 +-
 4 files changed, 104 insertions(+), 66 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a7683d35299..6250b95a6f7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2861,51 +2861,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int module_config(int argc, const char **argv, const char *prefix)
-{
-	enum {
-		CHECK_WRITEABLE = 1,
-		DO_UNSET = 2
-	} command = 0;
-	struct option module_config_options[] = {
-		OPT_CMDMODE(0, "check-writeable", &command,
-			    N_("check if it is safe to write to the .gitmodules file"),
-			    CHECK_WRITEABLE),
-		OPT_CMDMODE(0, "unset", &command,
-			    N_("unset the config in the .gitmodules file"),
-			    DO_UNSET),
-		OPT_END()
-	};
-	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper config <name> [<value>]"),
-		N_("git submodule--helper config --unset <name>"),
-		"git submodule--helper config --check-writeable",
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, module_config_options,
-			     git_submodule_helper_usage, PARSE_OPT_KEEP_ARGV0);
-
-	if (argc == 1 && command == CHECK_WRITEABLE)
-		return is_writing_gitmodules_ok() ? 0 : -1;
-
-	/* Equivalent to ACTION_GET in builtin/config.c */
-	if (argc == 2 && command != DO_UNSET)
-		return print_config_from_gitmodules(the_repository, argv[1]);
-
-	/* Equivalent to ACTION_SET in builtin/config.c */
-	if (argc == 3 || (argc == 2 && command == DO_UNSET)) {
-		const char *value = (argc == 3) ? argv[2] : NULL;
-
-		if (!is_writing_gitmodules_ok())
-			die(_("please make sure that the .gitmodules file is in the working tree"));
-
-		return config_set_in_gitmodules_file_gently(argv[1], value);
-	}
-
-	usage_with_options(git_submodule_helper_usage, module_config_options);
-}
-
 static int module_set_url(int argc, const char **argv, const char *prefix)
 {
 	int quiet = 0;
@@ -3424,7 +3379,6 @@ static struct cmd_struct commands[] = {
 	{"summary", module_summary, 0},
 	{"push-check", push_check, 0},
 	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
-	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
 	{"set-branch", module_set_branch, 0},
 	{"create-branch", module_create_branch, 0},
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index b7d117cd557..e060cc62268 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -111,10 +111,94 @@ static int cmd__submodule_resolve_relative_url(int argc, const char **argv)
 	return 0;
 }
 
+static int cmd__submodule_config_list(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *const usage[] = {
+		"test-tool submodule config-list <key>",
+		NULL
+	};
+	argc = parse_options(argc, argv, "test-tools", options, usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	setup_git_directory();
+
+	if (argc == 2)
+		return print_config_from_gitmodules(the_repository, argv[1]);
+	usage_with_options(usage, options);
+}
+
+static int cmd__submodule_config_set(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *const usage[] = {
+		"test-tool submodule config-set <key> <value>",
+		NULL
+	};
+	argc = parse_options(argc, argv, "test-tools", options, usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	setup_git_directory();
+
+	/* Equivalent to ACTION_SET in builtin/config.c */
+	if (argc == 3) {
+		if (!is_writing_gitmodules_ok())
+			die("please make sure that the .gitmodules file is in the working tree");
+
+		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
+	}
+	usage_with_options(usage, options);
+}
+
+static int cmd__submodule_config_unset(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *const usage[] = {
+		"test-tool submodule config-unset <key>",
+		NULL
+	};
+
+	setup_git_directory();
+
+	if (argc == 2) {
+		if (!is_writing_gitmodules_ok())
+			die("please make sure that the .gitmodules file is in the working tree");
+		return config_set_in_gitmodules_file_gently(argv[1], NULL);
+	}
+	usage_with_options(usage, options);
+}
+
+static int cmd__submodule_config_writeable(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *const usage[] = {
+		"test-tool submodule config-writeable",
+		NULL
+	};
+	setup_git_directory();
+
+	if (argc == 1)
+		return is_writing_gitmodules_ok() ? 0 : -1;
+
+	usage_with_options(usage, options);
+}
+
 static struct test_cmd cmds[] = {
 	{ "check-name", cmd__submodule_check_name },
 	{ "is-active", cmd__submodule_is_active },
 	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
+	{ "config-list", cmd__submodule_config_list },
+	{ "config-set", cmd__submodule_config_set },
+	{ "config-unset", cmd__submodule_config_unset },
+	{ "config-writeable", cmd__submodule_config_writeable },
 };
 
 int cmd__submodule(int argc, const char **argv)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index c583c4e373a..c0167944abd 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -137,44 +137,44 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 	)
 '
 
-test_expect_success 'reading submodules config from the working tree with "submodule--helper config"' '
+test_expect_success 'reading submodules config from the working tree' '
 	(cd super &&
 		echo "../submodule" >expect &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
 
-test_expect_success 'unsetting submodules config from the working tree with "submodule--helper config --unset"' '
+test_expect_success 'unsetting submodules config from the working tree' '
 	(cd super &&
-		git submodule--helper config --unset submodule.submodule.url &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-unset submodule.submodule.url &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_must_be_empty actual
 	)
 '
 
 
-test_expect_success 'writing submodules config with "submodule--helper config"' '
+test_expect_success 'writing submodules config' '
 	(cd super &&
 		echo "new_url" >expect &&
-		git submodule--helper config submodule.submodule.url "new_url" &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-set submodule.submodule.url "new_url" &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
 
-test_expect_success 'overwriting unstaged submodules config with "submodule--helper config"' '
+test_expect_success 'overwriting unstaged submodules config' '
 	test_when_finished "git -C super checkout .gitmodules" &&
 	(cd super &&
 		echo "newer_url" >expect &&
-		git submodule--helper config submodule.submodule.url "newer_url" &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-set submodule.submodule.url "newer_url" &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'writeable .gitmodules when it is in the working tree' '
-	git -C super submodule--helper config --check-writeable
+	test-tool -C super submodule config-writeable
 '
 
 test_expect_success 'writeable .gitmodules when it is nowhere in the repository' '
@@ -183,7 +183,7 @@ test_expect_success 'writeable .gitmodules when it is nowhere in the repository'
 	(cd super &&
 		git rm .gitmodules &&
 		git commit -m "remove .gitmodules from the current branch" &&
-		git submodule--helper config --check-writeable
+		test-tool submodule config-writeable
 	)
 '
 
@@ -191,7 +191,7 @@ test_expect_success 'non-writeable .gitmodules when it is in the index but not i
 	test_when_finished "git -C super checkout .gitmodules" &&
 	(cd super &&
 		rm -f .gitmodules &&
-		test_must_fail git submodule--helper config --check-writeable
+		test_must_fail test-tool submodule config-writeable
 	)
 '
 
@@ -200,7 +200,7 @@ test_expect_success 'non-writeable .gitmodules when it is in the current branch
 	test_when_finished "git -C super reset --hard $ORIG" &&
 	(cd super &&
 		git rm .gitmodules &&
-		test_must_fail git submodule--helper config --check-writeable
+		test_must_fail test-tool submodule config-writeable
 	)
 '
 
@@ -208,11 +208,11 @@ test_expect_success 'reading submodules config from the index when .gitmodules i
 	ORIG=$(git -C super rev-parse HEAD) &&
 	test_when_finished "git -C super reset --hard $ORIG" &&
 	(cd super &&
-		git submodule--helper config submodule.submodule.url "staged_url" &&
+		test-tool submodule config-set submodule.submodule.url "staged_url" &&
 		git add .gitmodules &&
 		rm -f .gitmodules &&
 		echo "staged_url" >expect &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
@@ -223,7 +223,7 @@ test_expect_success 'reading submodules config from the current branch when .git
 	(cd super &&
 		git rm .gitmodules &&
 		echo "../submodule" >expect &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index d5874200fdc..dde11ecce80 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -50,12 +50,12 @@ test_expect_success 'sparse checkout setup which hides .gitmodules' '
 
 test_expect_success 'reading gitmodules config file when it is not checked out' '
 	echo "../submodule" >expect &&
-	git -C super submodule--helper config submodule.submodule.url >actual &&
+	test-tool -C super submodule config-list submodule.submodule.url >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'not writing gitmodules config file when it is not checked out' '
-	test_must_fail git -C super submodule--helper config submodule.submodule.url newurl &&
+	test_must_fail test-tool -C super submodule config-set submodule.submodule.url newurl &&
 	test_path_is_missing super/.gitmodules
 '
 
-- 
2.38.0.1464.gea6794aacbc

