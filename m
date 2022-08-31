Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB13EECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiHaXSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiHaXSb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C7CB2845
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b5so20122133wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=juIkbLCCQIuQRLGpayn4CeVsN6vEIcGJVwNQXFqLM+Q=;
        b=qUfKkFKIBG9+dayWkKUOQttO4PQPlgZd8Uuo/l9R1mYnMnlIdutIWVk5m8bInQoZ/+
         Y9R3OWe5mZ2WiuhAwRIfUehdCB24iCMT17K0fqnp9lCVBNFPPl7gAXfvEa/8O17sjmt3
         fMauR5JIpTJbgEmWVQafbLDh4vCzDdOM8d1qHClH5J9U9ZeY98Qu2dcTGa+RqShHyJy5
         XZEhQlWLWvmpVvO/6W+MdNdhKCGSY/NY/ekrkw364+GYjegzI+F9TFtaztZ3NjRFDDM4
         /ghJViqKYteI3cIQzykRYlzTeIhbSqSeBci+vZQ+Ih2akGCPUmcwUkK+HeA4o83W7j/A
         ltgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=juIkbLCCQIuQRLGpayn4CeVsN6vEIcGJVwNQXFqLM+Q=;
        b=jRx/DMN1rcgKcNUiU4DdXnzVjVjvu7xSzRJpNvX0Q6dD3+ySN5n98VD0TR0YbHk3wt
         Q1jx+eaIan33NQn0WN1YpJSYkVLYbnqQoffjJeWZ83fqugaQOFg+GMQ8M5X2Rlv/9oj9
         QqZ/mINZRoVsDkEudHai/liat/KbwHyOmI0uJ5d3gdWA9GcKZjYt0NCiVl/Y4fpoVuB4
         pQdI85IedpNMCfrQKpNaBJNHIvQX4DWG/oVANG4Xf08F15AtWpOPzrJ35YljlsAvk2sR
         +h6kKXNg3QppZrN+Zf97AIJXsVv/Nh7RUg2fR47vwfKRf9Jym68EZf/IdwmjT5YgzZ2y
         Avgg==
X-Gm-Message-State: ACgBeo2syei69QJ+AMUOOP9C6tFWXORpe+htk6sf1Vac6ff5W2O0cVjv
        HF0XnyMLsIgcK1CDygNc4+Q4MAXdRa3C6A==
X-Google-Smtp-Source: AA6agR5z+vnHafKIyGiLfh0rcvkVvjy9bLJhI34omIvpoIWMbsUnw9aTLWp0BDALbkPgpY5kgK+mFw==
X-Received: by 2002:a5d:5983:0:b0:221:7cbd:df50 with SMTP id n3-20020a5d5983000000b002217cbddf50mr12761753wri.420.1661987907733;
        Wed, 31 Aug 2022 16:18:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/33] submodule--helper style: don't separate declared variables with \n\n
Date:   Thu,  1 Sep 2022 01:17:51 +0200
Message-Id: <patch-v4-09.33-76b55b9105f-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
2.37.3.1420.g76f8a3d556c

