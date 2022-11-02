Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2272BC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKBHyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKBHyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C44F2529B
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y14so43099774ejd.9
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lsBjQ6ihJRxepmyr7aP59FTVBpgU/x7SnVh8AdxSrQ=;
        b=m58hXgpQ+tlJOvblYDGFCgpVhtrdnrR2baincV26vPmDC4ht8IvscMVch2YyCx+yAq
         y4bDNqNhydJNPl/2CIcdj5f9rswf5t3y0/ybmcfwoJDTq5L7H2xEmBcicszo8uc9Ugwf
         vhPtdgy73MYHt2JQxmlq22pRVW1uD0U7y4GkPiDiiMNVAOSPNE2p9bbjMdUXy9HoIaEg
         ZSYE8i4cywiUVei1LSUE0686DHR2v/t9NkWgClgp/pt/7vMTNt8iCbHYqVfhMTKb7vtm
         W0Qi0KXY8UMY3IMFR+aAZBWnCgtE+PcfDkMaFUklRwvdIewChi9IE5jpRSe7BagHyjhL
         zywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lsBjQ6ihJRxepmyr7aP59FTVBpgU/x7SnVh8AdxSrQ=;
        b=f52a4ylj/Pc2VoM9sVyVMjMgwF1PrMPpF86BBCvVJzSeCp/0hHGpySwZnjTi3o/Dq4
         uVklSNIgF3EhGWcMuCw6b735Ux+5hGbI01Nvn3gJIvzUepKzvmJ4uayu45zmp1F9c7Uh
         AyLXmiwsKFhNjVXZ/XxqlMSYB0zGa83j8HGh1ibOdaLzm0Oa/ZRApCMGIhdyR/OzmKf1
         s12nKC9piBfz7z+zJwGTJMNEDB4uDWL2C6kqIrH5bJrCjJzUrG7OmJaMVm04rVAtn327
         l2BPNjXUFm481+UfirY5/UNJ39n/FgKXIU5ydNLEHsCqvG3y5AqhGOp1BXYWHNNpnNnr
         6iMQ==
X-Gm-Message-State: ACrzQf2ou/qT3gkFvYpXvtBDuDsnGyG4ovjpaiIzaxBZnuBemtCXm8/D
        vWbbbVYutV2VARdckutuR5p+ZkfADojnmw==
X-Google-Smtp-Source: AMsMyM7QNVsMCpbc40BIMIqBPVczRzPecou+YHivs5THcLBuUqPfEDrkHuCuP+u5rXxgQPgf5MaYCA==
X-Received: by 2002:a17:906:bceb:b0:7ae:75e:3929 with SMTP id op11-20020a170906bceb00b007ae075e3929mr1020264ejb.400.1667375648913;
        Wed, 02 Nov 2022 00:54:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] submodule--helper: move "config" to a test-tool
Date:   Wed,  2 Nov 2022 08:53:58 +0100
Message-Id: <patch-1.8-b2649f96715-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with other moves to "test-tool" in f322e9f51b5 (Merge branch
'ab/submodule-helper-prep', 2022-09-13) the "config" sub-command was
only used by our own tests.

Let's move it over, and while doing so make it easier to reason about
by splitting up the various uses for it into separate sub-commands, so
that we don't need to count arguments to see what it does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c            | 46 --------------
 t/helper/test-submodule.c              | 84 ++++++++++++++++++++++++++
 t/t7411-submodule-config.sh            | 28 ++++-----
 t/t7418-submodule-sparse-gitmodules.sh |  4 +-
 4 files changed, 100 insertions(+), 62 deletions(-)

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
index b7d117cd557..c7cb463a583 100644
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
+			die(_("please make sure that the .gitmodules file is in the working tree"));
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
+			die(_("please make sure that the .gitmodules file is in the working tree"));
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
index c583c4e373a..2f57ecd177a 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -140,15 +140,15 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
 test_expect_success 'reading submodules config from the working tree with "submodule--helper config"' '
 	(cd super &&
 		echo "../submodule" >expect &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
 
 test_expect_success 'unsetting submodules config from the working tree with "submodule--helper config --unset"' '
 	(cd super &&
-		git submodule--helper config --unset submodule.submodule.url &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-unset submodule.submodule.url &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_must_be_empty actual
 	)
 '
@@ -157,8 +157,8 @@ test_expect_success 'unsetting submodules config from the working tree with "sub
 test_expect_success 'writing submodules config with "submodule--helper config"' '
 	(cd super &&
 		echo "new_url" >expect &&
-		git submodule--helper config submodule.submodule.url "new_url" &&
-		git submodule--helper config submodule.submodule.url >actual &&
+		test-tool submodule config-set submodule.submodule.url "new_url" &&
+		test-tool submodule config-list submodule.submodule.url >actual &&
 		test_cmp expect actual
 	)
 '
@@ -167,14 +167,14 @@ test_expect_success 'overwriting unstaged submodules config with "submodule--hel
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
2.38.0.1280.g8136eb6fab2

