Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BC19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiG1Qa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiG1QaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B62DD8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a11so1262885wmq.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rH9cgA8h1eI+KecCw1kRKi1Gaal7P1v5hKy6OJ1rv9k=;
        b=VAINC1RyXVQci0iHjFj1nkwCQF2Tad1JmOudjap48VlwNC+XPggRos3iPXYhOyYnMv
         BhlgKm2O6vVIESc1EgbuXOra+ac+NEJDQxC+H+9PZfjjGMhW5ADg/3PPa8UXuH5mgz8n
         NKDspskEYpLcAMG0hNFhVi/SZLYTKqim/zhI9PH7JtSq9Fuhisu4yVk4J9O8lDatmu9R
         oXP1yhOWMmcVXPc1xqzLCiQZt4TTJHB/kIGpDJeRt178opFHk2CRw2Y6+gpMfVLlbHm3
         CQthnqfQIlQnu8D3Gm4QcfDdATIDsJdWS91uPMj3qHlkQ26a4X3ujWajqn0YztGUH2Nr
         LGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rH9cgA8h1eI+KecCw1kRKi1Gaal7P1v5hKy6OJ1rv9k=;
        b=GRDbVECtTf8bGQ12VQr8f9Bb2NxtscOGmTR10cuTr1+vKPHfDhMJfjY9M/1pvDcQAp
         0jdS/3Tdy3rDxn14o7zkeh5SJZj/U5oX6WSUYQu85ytpZDvm7qQnzfEfkxtUzQhBqNvJ
         AxM0fpuitWzZ/yyo8gm7KlqbzbtcR5u4Ukbrsq91DMP6tLN95CLDK5OoRp7deJAk49UD
         XlNNDSlD8R4OqZ4gY40eReRBYl5555ect0JP3jVhjhvPGlhJSSIrPIrXBuTm8SiMK54b
         o6aBTL9qIDJOJBsqCivZCp9CGgpPFrqpkJA7KNbbuiWfaPGFLLK9jJTZg3yR83nX2LMp
         2XXQ==
X-Gm-Message-State: AJIora/QPotAXdJ9aVv2ltxqRqWcpBNCbE5J5h/FtYvbj+ovWlNgqJmL
        +BU030Cd5gGX/ZBzx+bYZoTSp2P3uoURMw==
X-Google-Smtp-Source: AGRyM1sHBfQBFGJRvqOwarCDIUeyh8BGNlHbx9gaDJAfP2jiovu5zVpLbzLQEG5NxQYlGSIxNyhKFQ==
X-Received: by 2002:a05:600c:3399:b0:3a3:f1e:ebd8 with SMTP id o25-20020a05600c339900b003a30f1eebd8mr167571wmp.6.1659025819798;
        Thu, 28 Jul 2022 09:30:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/17] submodule--helper: fix most "struct pathspec" memory leaks
Date:   Thu, 28 Jul 2022 18:29:57 +0200
Message-Id: <patch-v4-03.17-529e10233d5-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 74 +++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d452af40d2d..6c53c83a2af 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -367,7 +367,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option module_foreach_options[] = {
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
@@ -379,12 +379,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.argc = argc;
 	info.argv = argv;
@@ -392,7 +393,10 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int starts_with_dot_slash(const char *const path)
@@ -502,7 +506,7 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct init_cb info = INIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_init_options[] = {
@@ -513,12 +517,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	/*
 	 * If there are no path args and submodule.active is set then,
@@ -533,7 +538,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct status_cb {
@@ -680,7 +688,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 static int module_status(int argc, const char **argv, const char *prefix)
 {
 	struct status_cb info = STATUS_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_status_options[] = {
@@ -693,12 +701,13 @@ static int module_status(int argc, const char **argv, const char *prefix)
 		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_status_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -706,7 +715,10 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, status_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_cb {
@@ -1245,7 +1257,7 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_sync(int argc, const char **argv, const char *prefix)
 {
 	struct sync_cb info = SYNC_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
@@ -1259,12 +1271,13 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_sync_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1274,7 +1287,10 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, sync_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct deinit_cb {
@@ -1383,7 +1399,7 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 static int module_deinit(int argc, const char **argv, const char *prefix)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int force = 0;
@@ -1398,6 +1414,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_deinit_options,
 			     git_submodule_helper_usage, 0);
@@ -1412,7 +1429,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1422,7 +1439,10 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_clone_data {
@@ -2516,7 +2536,7 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2593,8 +2613,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
-		list_objects_filter_release(&filter_options);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	if (pathspec.nr)
@@ -2605,8 +2625,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2623,7 +2645,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = update_submodules(&opt);
+cleanup:
 	list_objects_filter_release(&filter_options);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
@@ -2707,7 +2731,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
 	struct option embed_gitdir_options[] = {
@@ -2722,17 +2746,21 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	for (i = 0; i < list.nr; i++)
 		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int module_config(int argc, const char **argv, const char *prefix)
-- 
2.37.1.1197.g7ed548b7807

