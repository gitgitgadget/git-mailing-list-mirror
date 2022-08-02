Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5902C19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiHBPqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiHBPqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093D175A2
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso762765wmq.1
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eaVtMQlkekBX6/mxnh+3jJjg/o/gh0wdCTUxJxh8yl4=;
        b=aPitNvqOnwy3rR2gREMVaYSnDPNAFrTs/FaSnW6jUUS/A/mBxo+u7x5w7oabSYshEr
         hjh+89xKc0fa5+bgFbZWw2mLg8uj2CgU444ZkuiAn3qiM08riNliz2+jerFN0sFd+TX0
         QgH9FA61v6lI+1MVYhO4kzM8XUXulc8L3DXCIaTME+xAo+wAfDt1mVqsjMPoPfOooWhc
         mVv57qB8YD6cWHWNsUB6Q7SBnLOScczEqLXLDXL0omVV3BsFDoBI9lBhXn8/4COGZfpa
         FQMsyeZPTHvR1Nx8KsbydVRk4yJlQnjn0zgO41bD4HEsbIZZL4bN/u2j9ea/vr2Wk07E
         VF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eaVtMQlkekBX6/mxnh+3jJjg/o/gh0wdCTUxJxh8yl4=;
        b=IniGwYOpbMcxKkiNMxUw1QhZUbjuhvVjpUyehCiKy4CIazFbVXsilhxKir4eSCVgqG
         LgVeybe1L10GKJP2umO32uPHT7HDXljIu6dbaklbthc6Jzf11W1ssiPM0ETSsrEEv/Oj
         jDH5MWIaVfsOq/VqSDMlhVFZdrQSuW+xZNmkyaxqduMmoq2Kaz22brp470xRoeISP8U5
         l9wxyffnih3NvR4EGiqW0GS1VOSmZUTIzIjMT/cj5CcYT4xn14LsZTgQrRjf1FHexAwY
         fn6gPb6/SrnCXBZyosq2ExGe8Tf5GSTu80MfOKvFfO3Qx2Wu79jJWg2G5pX14fDPIldZ
         F4cQ==
X-Gm-Message-State: ACgBeo3LYuDMAhdJu4U7PxTXvg1nPApf6/ROgoaW41/xYD64U0RADlgT
        14p0GXLmjZPb+fG6SHDgLsYB4Rc//7RdhA==
X-Google-Smtp-Source: AA6agR6lIV4kSdjNV8N0uBbbpIzJXdOTpdtooL/R+X9d8/g5uontvrsusncwbAbj5MjqeCoxrZi4YA==
X-Received: by 2002:a05:600c:2211:b0:3a3:2149:88e1 with SMTP id z17-20020a05600c221100b003a3214988e1mr78515wml.8.1659455185974;
        Tue, 02 Aug 2022 08:46:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/28] submodule--helper style: don't separate declared variables with \n\n
Date:   Tue,  2 Aug 2022 17:45:53 +0200
Message-Id: <patch-v2-09.28-b0238f699ce-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 246457ec2e9..53b9e14767d 100644
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
@@ -1082,7 +1076,6 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	enum diff_cmd diff_cmd = DIFF_INDEX;
 	struct object_id head_oid;
 	int ret;
-
 	struct option module_summary_options[] = {
 		OPT_BOOL(0, "cached", &cached,
 			 N_("use the commit stored in the index instead of the submodule HEAD")),
@@ -1094,7 +1087,6 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 			     N_("limit the summary size")),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
@@ -1251,14 +1243,12 @@ static int module_sync(int argc, const char **argv, const char *prefix)
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
@@ -1390,14 +1380,12 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
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
@@ -1666,7 +1654,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
-
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
@@ -1698,7 +1685,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
@@ -2486,7 +2472,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
-
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
@@ -2530,7 +2515,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule [--quiet] update"
 		" [--init [--filter=<filter-spec>]] [--remote]"
@@ -2679,7 +2663,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
-
 	struct option embed_gitdir_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
@@ -2688,7 +2671,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 			ABSORB_GITDIR_RECURSE_SUBMODULES),
 		OPT_END()
 	};
-
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
@@ -2712,7 +2694,6 @@ static int module_config(int argc, const char **argv, const char *prefix)
 		CHECK_WRITEABLE = 1,
 		DO_UNSET = 2
 	} command = 0;
-
 	struct option module_config_options[] = {
 		OPT_CMDMODE(0, "check-writeable", &command,
 			    N_("check if it is safe to write to the .gitmodules file"),
@@ -2758,7 +2739,6 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	const char *newurl;
 	const char *path;
 	char *config_name;
-
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for setting url of a submodule")),
 		OPT_END()
@@ -2789,13 +2769,13 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
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
@@ -2830,7 +2810,6 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 {
 	enum branch_track track;
 	int quiet = 0, force = 0, reflog = 0, dry_run = 0;
-
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("print only error messages")),
 		OPT__FORCE(&force, N_("force creation"), 0),
@@ -3129,7 +3108,6 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
 	char *to_free = NULL;
-
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3146,7 +3124,6 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "depth", &add_data.depth, N_("depth for shallow clones")),
 		OPT_END()
 	};
-
 	const char *const usage[] = {
 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
-- 
2.37.1.1233.ge8b09efaedc

