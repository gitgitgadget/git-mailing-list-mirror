Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335FCC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiGMNQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiGMNQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0522199
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d16so15444587wrv.10
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAs4qL93mDfMbwvOLmMb49gIZtMC2Pa1ckg6bbTRBrk=;
        b=kjAtzOJzn8rWkUuOIlwaXW8JGs/RQuq9F+INuA7qOVEjTs4js6Do63nyebIVrhBHTc
         JjKehKNIrp4LhH7/en/v7OSFnbj0I2ElHDLXkLHejzBgg2Bc+F3+j6COfPC//TGEuoGP
         s+ovep3ZI0sW+qPaVeSN/Z2DrtKY5XWwus3lOjsBrKPFTnMUT08rx+MSZu92yTTWENNs
         tpYhPSTzBdDQtOVCEMnQoqVF2MWHqAqe1FtImo6w+wdWqQlDPjA5ke7pTDg2MxghYe4k
         9VeTwINoUronfZz0H7wQRpNbz7LKwEHQMuxuMFIbz5LFlX6ThS6YT/WmMBMW3/8a/Pk5
         EgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAs4qL93mDfMbwvOLmMb49gIZtMC2Pa1ckg6bbTRBrk=;
        b=Ivx5SOP05GTk8O7COqzggA/f3h+g58Gd8CP8tTln0dgKw0RNebl6aBpYZN9KWPcnLq
         vSC3U6IzA+0HstjCHe3MrSelf16unHABhLa1HO4hg+y0KJhOcraTdVKXZOWjmhF7ZIFb
         Y+OUJDJf+A4EVJWSVWcPSTf5gUhl7igzcMvO4RXyUBAgTBzf++kYA8urecFBS/CIQF0Y
         vVSmNtSKO7jRjyycU5FbqAV7qXUV5NU+ll8EcK9cnpBOppYcZ1QtZz8znk7AJ7yDtRxX
         pn5c5BETP+gDHDS9F8ISsixYAVenK5KICKu9mGLi9ABQBBZ/VaOdDEEp4DZz72K41aUo
         AXwA==
X-Gm-Message-State: AJIora9tZveNbdYpfFyzeTNSjhPfuhEMP/uhVLiHyTl+2Xx4ClUro7ly
        /We8lKDf82Y1hkUCcxFhNz1yy5jqy6zsMA==
X-Google-Smtp-Source: AGRyM1tCumZHglovbMtyxb/sPRuwC/3gbo6jG5+eC4pUpkV1+RdV6OuQH3xYPtIWVlnenmRC54ivew==
X-Received: by 2002:adf:e28a:0:b0:210:b31:722 with SMTP id v10-20020adfe28a000000b002100b310722mr3216100wri.65.1657718189370;
        Wed, 13 Jul 2022 06:16:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/11] submodule--helper: fix "struct pathspec" memory leaks
Date:   Wed, 13 Jul 2022 15:16:09 +0200
Message-Id: <patch-04.11-cdefd283c23-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call clear_pathspec() at the end of various functions that work with
and allocate a "struct pathspec".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 115 +++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 23ab9c7e349..a8e439e59b8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -269,7 +269,7 @@ static char *get_up_path(const char *path)
 static int module_list(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_list_options[] = {
@@ -278,6 +278,7 @@ static int module_list(int argc, const char **argv, const char *prefix)
 			   N_("alternative anchor for relative paths")),
 		OPT_END()
 	};
+	int ret;
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
@@ -287,8 +288,10 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	for (i = 0; i < list.nr; i++) {
 		const struct cache_entry *ce = list.entries[i];
@@ -302,7 +305,10 @@ static int module_list(int argc, const char **argv, const char *prefix)
 
 		fprintf(stdout, "%s\n", ce->name);
 	}
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static void for_each_listed_submodule(const struct module_list *list,
@@ -427,7 +433,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 
 	struct option module_foreach_options[] = {
@@ -441,12 +447,15 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	info.argc = argc;
 	info.argv = argv;
@@ -454,7 +463,10 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int starts_with_dot_slash(const char *const path)
@@ -562,7 +574,7 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct init_cb info = INIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 
@@ -575,12 +587,15 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	/*
 	 * If there are no path args and submodule.active is set then,
@@ -595,7 +610,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct status_cb {
@@ -740,7 +758,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 static int module_status(int argc, const char **argv, const char *prefix)
 {
 	struct status_cb info = STATUS_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 
@@ -755,12 +773,15 @@ static int module_status(int argc, const char **argv, const char *prefix)
 		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
 		NULL
 	};
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, module_status_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	info.prefix = prefix;
 	if (quiet)
@@ -768,7 +789,10 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, status_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int module_name(int argc, const char **argv, const char *prefix)
@@ -1105,7 +1129,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
-	int ret = 0;
+	int ret;
 
 	strvec_push(&diff_args, get_diff_cmd(diff_cmd));
 	if (info->cached)
@@ -1145,6 +1169,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	else
 		run_diff_files(&rev, 0);
 	prepare_submodule_summary(info, &list);
+	ret = 0;
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
@@ -1326,10 +1351,11 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_sync(int argc, const char **argv, const char *prefix)
 {
 	struct sync_cb info = SYNC_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
+	int ret;
 
 	struct option module_sync_options[] = {
 		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
@@ -1346,8 +1372,10 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_sync_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1357,7 +1385,10 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, sync_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct deinit_cb {
@@ -1464,7 +1495,7 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 static int module_deinit(int argc, const char **argv, const char *prefix)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int force = 0;
@@ -1481,6 +1512,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
 		NULL
 	};
+	int ret;
 
 	argc = parse_options(argc, argv, prefix, module_deinit_options,
 			     git_submodule_helper_usage, 0);
@@ -1494,8 +1526,10 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 	if (!argc && !all)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1505,7 +1539,10 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_clone_data {
@@ -2568,7 +2605,7 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2647,8 +2684,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
-		list_objects_filter_release(&filter_options);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	if (pathspec.nr)
@@ -2659,8 +2696,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0)
-			return 1;
+					&pathspec, &list) < 0) {
+			ret = 1;
+			goto cleanup;
+		}
 
 		/*
 		 * If there are no path args and submodule.active is set then,
@@ -2677,7 +2716,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = update_submodules(&opt);
+cleanup:
 	list_objects_filter_release(&filter_options);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
@@ -2761,9 +2802,10 @@ static int push_check(int argc, const char **argv, const char *prefix)
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
+	int ret;
 
 	struct option embed_gitdir_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -2782,13 +2824,18 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
 
 	for (i = 0; i < list.nr; i++)
 		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int is_active(int argc, const char **argv, const char *prefix)
-- 
2.37.0.932.g7b7031e73bc

