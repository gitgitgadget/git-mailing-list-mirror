Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B3C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8123923AC2
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbhAHUD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbhAHUD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A905C0612FF
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c133so8722622wme.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sYrG+Tmjs3a0QRrDXQB7FAfyXPu2y77OsT88XEQh6vk=;
        b=ph7t2RFFL9u+htDkCXQ53KD2lA5LvCcsO1tnVTFgQhyknMZQXRyBRSQdqGI7cYvoRW
         Mz9MGIEAQBVSgcSDjvV9h7hjWVthMjAyghf2A+Z1XWhVkZtPvIXfx/tpOG5v3z0ZFKya
         8A5znplnMllHlJjRIU50lliQlGak4yJcBI+/zbe4YOmMVSjuNib/o0znXgRGrAoeyZXE
         RUXuTtxtCkrpUq2xzBgoDDTFvGY83I0B5pNcmq1ySzT+1snmNmBXV4Trj6BLfKuKfO8W
         INGK7Au/d2nGQuXTzZxK284iFNE4yx7b+RL6VXtyX3ql5gLG0h+XcmWPIjtur8Q2VWK7
         /TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sYrG+Tmjs3a0QRrDXQB7FAfyXPu2y77OsT88XEQh6vk=;
        b=ncYd/jTIRPAgnCEQW6Egyh3mYsuJzDR91cMhjp28JZvSUhdbZ8HYpeXbFsYaeCrjfY
         uKIrteOYSGh8m8f6Kpzust8AJsZ1iUYiahkIfZLhArAgnvFPzBlcP2B8PGe+Aq3eLchp
         LcpEwDxfx/go7g77humIhSWT2qhb1fFO3GS37xtv4s1ipQGa6mdmuiYOCtgizIsTAgll
         4B2eJFJHjMTGTY1pf98wWrpXRkneBgKgBFqTah1YssseX25/GVVTk2av2m4iZYFwK2Ej
         eM4frk4+pkCcXG2eEuX1Q8nGfzm/sBAJsW4B51h9A1ONDEldbPsaZqmJJAbwWuUvLhoW
         EP6A==
X-Gm-Message-State: AOAM532v8PpyjE2y2blaKJewp0hWJBG666GHFCpkxSFJoyp1MCOfTnLQ
        9gaFnvEXExFtjL6br2Vlei3zIcajuFE=
X-Google-Smtp-Source: ABdhPJxnOeBEyez7P0G4JXR1lvPhISZ/qHX4uXhli6Z21S0XVR6Hy6sgOrLzDABBFKuIw3NthY/s1Q==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr4551164wmc.187.1610136181833;
        Fri, 08 Jan 2021 12:03:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm13560640wmb.32.2021.01.08.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:01 -0800 (PST)
Message-Id: <f60f34ac1f5a9933742892c7d5ef03e864faf52b.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:46 +0000
Subject: [PATCH v3 03/14] update-index: drop the_index, the_repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To reduce the need for the index compatibility macros, we will replace
their uses in update-index mechanically. This is the most interesting
change, which creates global "repo" and "istate" pointers. The macros
that expand to use the_index can then be mechanically replaced by
references to the istate pointer.

We will be careful to use "repo->index" over "istate" whenever repo is
needed by a method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 59 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 44862f5e1de..22284f301dc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -227,18 +227,20 @@ static int test_if_untracked_cache_is_supported(void)
 	return ret;
 }
 
+static struct index_state *istate;
+
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
-		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
+		mark_fsmonitor_invalid(istate, active_cache[pos]);
 		if (mark)
 			active_cache[pos]->ce_flags |= flag;
 		else
 			active_cache[pos]->ce_flags &= ~flag;
 		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
-		cache_tree_invalidate_path(&the_index, path);
+		cache_tree_invalidate_path(istate, path);
 		active_cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
 	}
@@ -277,14 +279,14 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
 		return 0;
 
-	ce = make_empty_cache_entry(&the_index, len);
+	ce = make_empty_cache_entry(istate, len);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
-	fill_stat_cache_info(&the_index, ce, st);
+	fill_stat_cache_info(istate, ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(&the_index, &ce->oid, path, st,
+	if (index_path(istate, &ce->oid, path, st,
 		       info_only ? 0 : HASH_WRITE_OBJECT)) {
 		discard_cache_entry(ce);
 		return -1;
@@ -406,7 +408,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 {
 	int res;
 
-	res = add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
+	res = add_to_index_cacheinfo(istate, mode, oid, path, stage,
 				     allow_add, allow_replace, NULL);
 	if (res == -1)
 		return res;
@@ -583,6 +585,7 @@ static const char * const update_index_usage[] = {
 
 static struct object_id head_oid;
 static struct object_id merge_head_oid;
+static struct repository *repo;
 
 static struct cache_entry *read_one_ent(const char *which,
 					struct object_id *ent, const char *path,
@@ -592,7 +595,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry(the_repository, ent, path, &oid, &mode)) {
+	if (get_tree_entry(repo, ent, path, &oid, &mode)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
@@ -602,7 +605,7 @@ static struct cache_entry *read_one_ent(const char *which,
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
 	}
-	ce = make_empty_cache_entry(&the_index, namelen);
+	ce = make_empty_cache_entry(repo->index, namelen);
 
 	oidcpy(&ce->oid, &oid);
 	memcpy(ce->name, path, namelen);
@@ -740,7 +743,7 @@ static int do_reupdate(int ac, const char **av,
 		int save_nr;
 		char *path;
 
-		if (ce_stage(ce) || !ce_path_match(&the_index, ce, &pathspec, NULL))
+		if (ce_stage(ce) || !ce_path_match(repo->index, ce, &pathspec, NULL))
 			continue;
 		if (has_head)
 			old = read_one_ent(NULL, &head_oid,
@@ -957,7 +960,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
-	struct repository *r = the_repository;
 	struct option options[] = {
 		OPT_BIT('q', NULL, &refresh_args.flags,
 			N_("continue refresh even when index needs update"),
@@ -1066,16 +1068,19 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	repo = the_repository;
+
 	/* we will diagnose later if it turns out that we need to update it */
-	newfd = hold_locked_index(&lock_file, 0);
+	newfd = repo_hold_locked_index(repo, &lock_file, 0);
 	if (newfd < 0)
 		lock_error = errno;
 
-	entries = read_cache();
+	entries = repo_read_index(repo);
 	if (entries < 0)
 		die("cache corrupted");
 
-	the_index.updated_skipworktree = 1;
+	istate = repo->index;
+	repo->index->updated_skipworktree = 1;
 
 	/*
 	 * Custom copy of parse_options() because we want to handle
@@ -1129,9 +1134,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
-		if (the_index.version != preferred_index_format)
+		if (repo->index->version != preferred_index_format)
 			active_cache_changed |= SOMETHING_CHANGED;
-		the_index.version = preferred_index_format;
+		repo->index->version = preferred_index_format;
 	}
 
 	if (read_from_stdin) {
@@ -1162,28 +1167,28 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			warning(_("core.splitIndex is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable split index"));
-		if (the_index.split_index)
-			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
+		if (repo->index->split_index)
+			repo->index->cache_changed |= SPLIT_INDEX_ORDERED;
 		else
-			add_split_index(&the_index);
+			add_split_index(repo->index);
 	} else if (!split_index) {
 		if (git_config_get_split_index() == 1)
 			warning(_("core.splitIndex is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable split index"));
-		remove_split_index(&the_index);
+		remove_split_index(repo->index);
 	}
 
-	prepare_repo_settings(r);
+	prepare_repo_settings(repo);
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
 		break;
 	case UC_DISABLE:
-		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
+		if (repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
 			warning(_("core.untrackedCache is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable the untracked cache"));
-		remove_untracked_cache(&the_index);
+		remove_untracked_cache(repo->index);
 		report(_("Untracked cache disabled"));
 		break;
 	case UC_TEST:
@@ -1191,11 +1196,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		return !test_if_untracked_cache_is_supported();
 	case UC_ENABLE:
 	case UC_FORCE:
-		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_REMOVE)
+		if (repo->settings.core_untracked_cache == UNTRACKED_CACHE_REMOVE)
 			warning(_("core.untrackedCache is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable the untracked cache"));
-		add_untracked_cache(&the_index);
+		add_untracked_cache(repo->index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
@@ -1207,14 +1212,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			warning(_("core.fsmonitor is unset; "
 				"set it if you really want to "
 				"enable fsmonitor"));
-		add_fsmonitor(&the_index);
+		add_fsmonitor(repo->index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
 		if (git_config_get_fsmonitor() == 1)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
-		remove_fsmonitor(&the_index);
+		remove_fsmonitor(repo->index);
 		report(_("fsmonitor disabled"));
 	}
 
@@ -1224,7 +1229,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
 
-- 
gitgitgadget

