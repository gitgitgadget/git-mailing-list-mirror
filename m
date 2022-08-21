Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63EBC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiHUN64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiHUN6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC713FB4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso6447414wmc.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5uUC0k+hOpJ9QDYTWREhJiAkTxyAIb7Z7qrtsQjBO8A=;
        b=f5ovtG4wl3kTHgmS4fdvR/XTmywEauVzvMvyxXPWvhgLvoFClj8Iyun7KOWYP81kzP
         5K57h0xzA0dilri5wkBgoNrB7zzBIz8olV9PABBQrZMGObKjCsroK6Lyg5ak4pqfxP3Y
         A+A8sWtaTwzEktlkU2+dy5mNo8CmiNHYCwoeDxBN9l3NsQ7KFKu7fRwqKlhKeMOyF1Ol
         lB+uHJY3jkFE0d7nkUCKb1pmL93dbVjzdS/EcpNzPMN5IcEU5NRZ3FYEhxnPtcg6KTiJ
         PhzZjW1uxOyJrZNAXMrhMl5qhJoB9l13sV8trxwZnzSV0dwR1hkd4vqqO8egq7n2R7iY
         K7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5uUC0k+hOpJ9QDYTWREhJiAkTxyAIb7Z7qrtsQjBO8A=;
        b=ZdaYd+xYwI8hGOeGwUVXyDRSuWB5fcrtgFLjJbrB23/kIN2e3O9YTfoXkyML5UoW+k
         zdDldTfdHum0ouCJDXSDn+94HNiQ6CQMi5kVpr/Y6R4SQiyqH3rrRrRRd7e0VcSg09gF
         Qd2+LmC1kFUEJMa531cipuQUCasvNcjkCfVz1ilia1bkV2vamJ4uu0tpN8BqI9sSHZiM
         HZa7hwselh6tuqfBh/u7GgqQ81++hJUDFzCZZwrTszF5+enlW1nHOaptTzI9usR/5aF5
         rixNU/KhdVUn0bOLr08T/ykMRnllA4EiB5bllHOJbcYcuffMIzEaUuG6qtpRhKO3cPG0
         bbJg==
X-Gm-Message-State: ACgBeo39nNkGbP71Jis+5stv4GaSOYXobtyGegW9lTAe8C9EjErjRun0
        X3AKDqG/L3dA7tX9V8tJRC70UZUgytg+Y7gR
X-Google-Smtp-Source: AA6agR7bZAVoCwVBg+Lv1stlp21y5XfDgn9qXBG5/4ix4q3iLofG+6bVIRnL1KqrnTxH7yFV8ufQyg==
X-Received: by 2002:a05:600c:4fd4:b0:3a6:2694:e3bc with SMTP id o20-20020a05600c4fd400b003a62694e3bcmr9086623wmq.60.1661090314719;
        Sun, 21 Aug 2022 06:58:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/32] submodule--helper style: don't separate declared variables with \n\n
Date:   Sun, 21 Aug 2022 15:57:18 +0200
Message-Id: <patch-v3-09.32-b1eaa6a796b-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usual style in the codebase is to separate declared variables with
a single newline, not two, let's adjust this code to conform to
that. This makes the eventual addition of various "int ret" variables
more consistent.

In doing this the comment added in 2964d6e5e1e (submodule: port
subcommand 'set-branch' from shell to C, 2020-06-02) might become
ambiguous to some, although it should be clear what it's referring to,
let's move it above the 'OPT_NOOP_NOARG('q', "quiet")' to make that
clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7e2986902dd..02552410679 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -368,14 +368,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
-
 	struct option module_foreach_options[] = {
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("recurse into nested submodules")),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
@@ -504,12 +502,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-
 	struct option module_init_options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for initializing a submodule")),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule init [<options>] [<path>]"),
 		NULL
@@ -682,14 +678,12 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
-
 	struct option module_status_options[] = {
 		OPT__QUIET(&quiet, N_("suppress submodule status output")),
 		OPT_BIT(0, "cached", &info.flags, N_("use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
 		OPT_BIT(0, "recursive", &info.flags, N_("recurse into nested submodules"), OPT_RECURSIVE),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
 		NULL
@@ -1085,7 +1079,6 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	enum diff_cmd diff_cmd = DIFF_INDEX;
 	struct object_id head_oid;
 	int ret;
-
 	struct option module_summary_options[] = {
 		OPT_BOOL(0, "cached", &cached,
 			 N_("use the commit stored in the index instead of the submodule HEAD")),
@@ -1097,7 +1090,6 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 			     N_("limit the summary size")),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
@@ -1254,14 +1246,12 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
-
 	struct option module_sync_options[] = {
 		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
 		OPT_BOOL(0, "recursive", &recursive,
 			N_("recurse into nested submodules")),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
@@ -1393,14 +1383,12 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int force = 0;
 	int all = 0;
-
 	struct option module_deinit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress submodule status output")),
 		OPT__FORCE(&force, N_("remove submodule working trees even if they contain local changes"), 0),
 		OPT_BOOL(0, "all", &all, N_("unregister all submodules")),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
 		NULL
@@ -1669,7 +1657,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
-
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
@@ -1701,7 +1688,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
@@ -2489,7 +2475,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
-
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
@@ -2533,7 +2518,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule [--quiet] update"
 		" [--init [--filter=<filter-spec>]] [--remote]"
@@ -2682,7 +2666,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
-
 	struct option embed_gitdir_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
@@ -2691,7 +2674,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 			ABSORB_GITDIR_RECURSE_SUBMODULES),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
@@ -2715,7 +2697,6 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		CHECK_WRITEABLE = 1,
 		DO_UNSET = 2
 	} command = 0;
-
 	struct option module_config_options[] = {
 		OPT_CMDMODE(0, "check-writeable", &command,
 			    N_("check if it is safe to write to the .gitmodules file"),
@@ -2761,7 +2742,6 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	const char *newurl;
 	const char *path;
 	char *config_name;
-
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for setting url of a submodule")),
 		OPT_END()
@@ -2792,13 +2772,13 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	const char *opt_branch = NULL;
 	const char *path;
 	char *config_name;
-
-	/*
-	 * We accept the `quiet` option for uniformity across subcommands,
-	 * though there is nothing to make less verbose in this subcommand.
-	 */
 	struct option options[] = {
+		/*
+		 * We accept the `quiet` option for uniformity across subcommands,
+		 * though there is nothing to make less verbose in this subcommand.
+		 */
 		OPT_NOOP_NOARG('q', "quiet"),
+
 		OPT_BOOL('d', "default", &opt_default,
 			N_("set the default tracking branch to master")),
 		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
@@ -2833,7 +2813,6 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 {
 	enum branch_track track;
 	int quiet = 0, force = 0, reflog = 0, dry_run = 0;
-
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("print only error messages")),
 		OPT__FORCE(&force, N_("force creation"), 0),
@@ -3132,7 +3111,6 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	char *to_free = NULL;
-
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3149,7 +3127,6 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "depth", &add_data.depth, N_("depth for shallow clones")),
 		OPT_END()
 	};
-
 	const char *const usage[] = {
 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
-- 
2.37.2.1279.g64dec4e13cf

