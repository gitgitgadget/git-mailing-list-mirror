Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902EC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiGSUrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiGSUrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8452FFB
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so23361269wrq.7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IbIvwwLRKFotN4/+PpIXiq4OoXNUW3RLLAtc08l+lWc=;
        b=WxlPKswJW9g5SUQhHraW3Yx3EXqt5IrkvYod/Doh725YyV6SaPcqslAStJe6dAxdYM
         +eYeQqdwUhEkxpc1ub8xtVDi1mazZ9Hexz2r5T5LdCAXKXitvcwDZvJHbwmq0b4fhxNy
         DRCfy8qedbzddJvp3ZsYzBXlwDR1qfRuWJneE0df9K13hVkAZAJLAKGDg30lkJX9XE6K
         KHoiTj3L1gbAfANp+tIrpeiVgPR46UAgf8CYNKt3M8Dg8syKG7CIcZIZB3dYrHqROBM0
         DzgNED5nO3DO9i5HKGJ+GAQhOy1e2IIDxLuy2x3WeJQxUJhqUh4edgZ2DpaGwOyqeHuh
         4Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbIvwwLRKFotN4/+PpIXiq4OoXNUW3RLLAtc08l+lWc=;
        b=wEXyF3OVyqNGjjO8aC4e3hjWsWX0a7ZTBUs3fSwKptZmtx2BhLI2Qv7GJ+5+xeT3Zk
         t4XriGWwgxYVyCGJCde+YdYylpOI8zV5fX+LZqufNW8N9ZVIjT835lXhVbNHmkN+IYNe
         vfbTn8Pf7ZAF+BXIlZeFsqoUw6MqQekJ/WnfHB1/RV8nV2VrRtnxbNR20uy61dPZGlHy
         tGuiXrvBCke7mr52+0HuQwnzOF6mfV6kSiNHM+fCgWH6rwLr43uOdQWI2KPoDQBf9aiv
         8vzNX+1SQS02SoneWDdhZmRHpkFnDkpQXc91P1C1uBw6LeqGUB3MW48aI84UQ21n1WuD
         Rfzg==
X-Gm-Message-State: AJIora/sh01shFZn57ImnhJChkX8LVFSlPxxEYelRwvJRYUxnk81drY6
        JsGZxzNbvp26nUAlWWkKe9V1FLMqhW/+8A==
X-Google-Smtp-Source: AGRyM1sguRr7PJtzNsm1B4kis0M0xO1fsgfKo0f3ESG2Oe9MDPgxav4lLqsCrdyFGAQu5ZuFJJOheQ==
X-Received: by 2002:a05:6000:2ab:b0:21e:2e68:52f4 with SMTP id l11-20020a05600002ab00b0021e2e6852f4mr4460250wry.236.1658263648110;
        Tue, 19 Jul 2022 13:47:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/24] submodule--helper: fix most "struct pathspec" memory leaks
Date:   Tue, 19 Jul 2022 22:46:55 +0200
Message-Id: <patch-v2-04.24-9fb60485c3e-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
index b36919b66c5..28c5fdb8954 100644
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
@@ -2564,7 +2601,7 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2643,8 +2680,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
-		list_objects_filter_release(&filter_options);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	if (pathspec.nr)
@@ -2655,8 +2692,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2673,7 +2712,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = update_submodules(&opt);
+cleanup:
 	list_objects_filter_release(&filter_options);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
@@ -2757,9 +2798,10 @@ static int push_check(int argc, const char **argv, const char *prefix)
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
@@ -2778,13 +2820,18 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
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
2.37.1.1062.g385eac7fccf

