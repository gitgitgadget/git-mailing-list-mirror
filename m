Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC4C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFB560238
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhIPKex (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbhIPKet (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219EC0613CF
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t20so4213156pju.5
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYquWGyZRPHSafHkbR6FxYdBZ/uFzYBJOR7cohIQe+Q=;
        b=Bcu60z44UEOiNMMKsScBjUSQtyoJK8jBccTUaIvQ3PSHabvlfkJa56Fh3bdSdSOsbo
         ZWPv4ShFNWu8fmnkU1uDGWyB37iCMzU6I9CDm+A7txs/wXQjqaOS7HCc2s/FVFGU0dDR
         IBR6mF2cZt9I3qPufuNSK082wtrexrPnpfCoOZtxsTlB38IvMZy+Qn0RIDt9eWZpYtfP
         axYi4gVIpP1MGRJoR4eMHy4BCKnUG+tLOgKH+sUT0anUwCPJIXUQSwzhfVaCnenk2GKW
         F9MeJv5a8Qi+Zt5x3f6lK9AynKNfUFwNIf+5s3fQ8rjeUTpeV2uxgxgqUdAwsUfvgfCA
         9bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYquWGyZRPHSafHkbR6FxYdBZ/uFzYBJOR7cohIQe+Q=;
        b=C5+AM3vBjH2YhEq6E7hHB41IMgAWKbqj6n1ZpYOOKR2V3ijxDvvEz6ZrXnkwkQKaiT
         BKEwb2GKtVlRPV/YlTlnQPZysj16LkOD5QZ6sqeWPDv3JI4AHS4MzeMMPfu7PlJAihCx
         GHnHODLXcsgoeEdXYO3ivbyqEJo2Lv/AQokN0u2z6SKhKAOiZLmk06e2Cl5x14Bn8JB9
         G7P6O+Jc7aOlATC81b0sFjYwYEvFoDdt8BkyK91uzsrD218r648yDFeZIPJjXoNGTovh
         gzuQaKfE9Z4w087IJ9TdfD2gLneZxwoSzXHyTOjxmLo6RIfC1LddAzSq7z0lVidWNHio
         K/gg==
X-Gm-Message-State: AOAM531fnqsSMeCySNu+J0ekTmqYBItbQiD3H9uOM8leiwzfmA/um1QF
        63pYgdyfYkc4DkAJbOx+d90=
X-Google-Smtp-Source: ABdhPJwkaL5TnHOn+uOwGLlwyKcUsOUR6nlLo1ANYx5ZrgmyzNvmSSFR+54nrl04No0bE7mRQr6ttg==
X-Received: by 2002:a17:90b:314c:: with SMTP id ip12mr14300473pjb.32.1631788408559;
        Thu, 16 Sep 2021 03:33:28 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:28 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 7/8] submodule--helper: remove unused helpers
Date:   Thu, 16 Sep 2021 16:02:40 +0530
Message-Id: <20210916103241.62376-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These helpers were useful back when 'submodule update' had most of its
logic in shell. Now that they will never be invoked, let us remove them.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 135 ------------------------------------
 1 file changed, 135 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c1ce3981ad..0910af9c71 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -73,21 +73,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository, refname);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -1993,29 +1978,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	free(key);
 }
 
-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
-{
-	const char *path, *update = NULL;
-	int just_cloned;
-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
-
-	if (argc < 3 || argc > 4)
-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
-
-	just_cloned = git_config_int("just_cloned", argv[1]);
-	path = argv[2];
-
-	if (argc == 4)
-		update = argv[3];
-
-	determine_submodule_update_strategy(the_repository,
-					    just_cloned, path, update,
-					    &update_strategy);
-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
-
-	return 0;
-}
-
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -2552,85 +2514,6 @@ static int do_run_update_procedure(struct update_data *ud, struct string_list *e
 	return run_update_command(ud, subforce, err);
 }
 
-static int run_update_procedure(int argc, const char **argv, const char *prefix)
-{
-	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
-	char *prefixed_path, *update = NULL;
-	struct update_data update_data = UPDATE_DATA_INIT;
-	struct string_list err = STRING_LIST_INIT_DUP;
-
-	struct option options[] = {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
-			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
-			 N_("overrides update mode in case the repository is a fresh clone")),
-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
-		OPT_END()
-	};
-
-	const char *const usage[] = {
-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
-		NULL
-	};
-
-	argc = parse_options(argc, argv, prefix, options, usage, 0);
-
-	if (argc != 1)
-		usage_with_options(usage, options);
-
-	update_data.force = !!force;
-	update_data.quiet = !!quiet;
-	update_data.nofetch = !!nofetch;
-	update_data.just_cloned = !!just_cloned;
-	update_data.sm_path = argv[0];
-
-	if (update_data.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
-	else
-		prefixed_path = xstrdup(update_data.sm_path);
-
-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
-					    update_data.sm_path, update,
-					    &update_data.update_strategy);
-
-	free(prefixed_path);
-
-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
-		return do_run_update_procedure(&update_data, &err);
-
-	return 3;
-}
-
-static int resolve_relative_path(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 3)
-		die("submodule--helper relative-path takes exactly 2 arguments, got %d", argc);
-
-	printf("%s", relative_path(argv[1], argv[2], &sb));
-	strbuf_release(&sb);
-	return 0;
-}
-
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
@@ -2794,19 +2677,6 @@ static void do_ensure_core_worktree(const char *path)
 	}
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
-{
-	const char *path;
-
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-	do_ensure_core_worktree(path);
-
-	return 0;
-}
-
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -3466,16 +3336,11 @@ static struct cmd_struct commands[] = {
 	{"clone", module_clone, 0},
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
-	{"update-module-mode", module_update_module_mode, 0},
-	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
-	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

