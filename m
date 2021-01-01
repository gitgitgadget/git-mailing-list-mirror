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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722BC43381
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F5020888
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAANH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbhAANHz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:07:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23089C0613CF
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g185so9011565wmf.3
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KHykIfsh0Vb8IWAINw3GY8cLRHHZg/Ilzg6BOGQHP74=;
        b=oRqJiIszrR0pHYBCeZOyTtqdWRfa2VqpAkVtKgb9ceOpASAGd0ubZ3EmDiPZIms6WJ
         cyOv/TNAdQQq6dCyXCa9auUekvctZ8bj2/K4XqNVDk2ysPLIsaFCDCGD4Eyf2DbEsRED
         IBShLgZtP3jt2AsCk4qEOlII50AFTJdYBEhJEum9wckAH4ctztr4vFyBLRcZikzGZ3iu
         QXc+ULO/ypiLi2hcmc0g4JRepjwYttKqGCYFV2eWif5lUQ98XNuP1ogRcw8lwKtvhoWw
         P4SfXW5tyy8uPTwBFY05Se9OHLQyLAA+dBaopkPMzg55PSFljglUkqtFMTSe413jiKic
         lnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KHykIfsh0Vb8IWAINw3GY8cLRHHZg/Ilzg6BOGQHP74=;
        b=GKk7ydk5jC+PYAxA19XC35El6HAY2D7w/9tiZBSNYLEytOE/SF4mXhK7fd1555zQbd
         GDblpzhMXH79Jp+RwnHGqVVNbHBendZYE3zbZVYanhydCerKNdnrvA5iEDS2W7uJz8Gh
         K9kQVEx9Pxqodserbc9oKE4JwqSpx5V/dxH2Y7sVaAHsLIjwHn21CvsYJ9nvrf/jEHRh
         ceAg2e//Az1gSmHZQBqWRQVP+c95OtecFYwL1YacWt1H9t/VZ3cCPkCQ4XqPlsSyDLU8
         dcSbnf/l0Ns0I5ukRrZXyWTm2xdSzTL6GtdftXn2Wqjiy5uO1WAVRs4bgdbljfzC2do7
         FwKA==
X-Gm-Message-State: AOAM530iYHkaQJT0wMqXgUov3ZmJZAlIqIbDb7jDAcX9HT/BbCbrdJ4x
        Jzwo9+HsPJBEP6XhucVWAf5tNPKdeDM=
X-Google-Smtp-Source: ABdhPJxeCg2XMridIJLsRyOt91QyQ5ExhJOJrFiFvNgXEzn1WYGEAkFwWRIbDM+937QFF+HoGxTG0g==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr15666991wmg.166.1609506433682;
        Fri, 01 Jan 2021 05:07:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm15460568wmc.44.2021.01.01.05.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:13 -0800 (PST)
Message-Id: <77f6510bb680aaf119526f75daadf8c40d22793e.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:00 +0000
Subject: [PATCH 04/12] update-index: drop the_index, the_repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To reduce the need for the index compatibility macros, we will replace
their uses in update-index mechanically. This is the most interesting
change, which creates global "repo" and "istate" pointers. The macros
can then be mechanically replaced by instances that use the istate
pointer instead of the version that autocompletes to use the_index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 59 +++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea4..c9a6cde97da 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -40,6 +40,9 @@ static int ignore_skip_worktree_entries;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+static struct repository *repo;
+static struct index_state *istate;
+
 /* Untracked cache mode */
 enum uc_mode {
 	UC_UNSPECIFIED = -1,
@@ -232,13 +235,13 @@ static int mark_ce_flags(const char *path, int flag, int mark)
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
@@ -277,14 +280,14 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
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
@@ -411,7 +414,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 		return error("Invalid path '%s'", path);
 
 	len = strlen(path);
-	ce = make_empty_cache_entry(&the_index, len);
+	ce = make_empty_cache_entry(istate, len);
 
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
@@ -603,7 +606,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	struct object_id oid;
 	struct cache_entry *ce;
 
-	if (get_tree_entry(the_repository, ent, path, &oid, &mode)) {
+	if (get_tree_entry(repo, ent, path, &oid, &mode)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
@@ -613,7 +616,7 @@ static struct cache_entry *read_one_ent(const char *which,
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
 	}
-	ce = make_empty_cache_entry(&the_index, namelen);
+	ce = make_empty_cache_entry(istate, namelen);
 
 	oidcpy(&ce->oid, &oid);
 	memcpy(ce->name, path, namelen);
@@ -751,7 +754,7 @@ static int do_reupdate(int ac, const char **av,
 		int save_nr;
 		char *path;
 
-		if (ce_stage(ce) || !ce_path_match(&the_index, ce, &pathspec, NULL))
+		if (ce_stage(ce) || !ce_path_match(istate, ce, &pathspec, NULL))
 			continue;
 		if (has_head)
 			old = read_one_ent(NULL, &head_oid,
@@ -968,7 +971,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
-	struct repository *r = the_repository;
 	struct option options[] = {
 		OPT_BIT('q', NULL, &refresh_args.flags,
 			N_("continue refresh even when index needs update"),
@@ -1077,16 +1079,19 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
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
+	istate->updated_skipworktree = 1;
 
 	/*
 	 * Custom copy of parse_options() because we want to handle
@@ -1140,9 +1145,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
-		if (the_index.version != preferred_index_format)
+		if (istate->version != preferred_index_format)
 			active_cache_changed |= SOMETHING_CHANGED;
-		the_index.version = preferred_index_format;
+		istate->version = preferred_index_format;
 	}
 
 	if (read_from_stdin) {
@@ -1173,28 +1178,28 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			warning(_("core.splitIndex is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable split index"));
-		if (the_index.split_index)
-			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
+		if (istate->split_index)
+			istate->cache_changed |= SPLIT_INDEX_ORDERED;
 		else
-			add_split_index(&the_index);
+			add_split_index(istate);
 	} else if (!split_index) {
 		if (git_config_get_split_index() == 1)
 			warning(_("core.splitIndex is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable split index"));
-		remove_split_index(&the_index);
+		remove_split_index(istate);
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
+		remove_untracked_cache(istate);
 		report(_("Untracked cache disabled"));
 		break;
 	case UC_TEST:
@@ -1202,11 +1207,11 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		return !test_if_untracked_cache_is_supported();
 	case UC_ENABLE:
 	case UC_FORCE:
-		if (r->settings.core_untracked_cache == UNTRACKED_CACHE_REMOVE)
+		if (repo->settings.core_untracked_cache == UNTRACKED_CACHE_REMOVE)
 			warning(_("core.untrackedCache is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable the untracked cache"));
-		add_untracked_cache(&the_index);
+		add_untracked_cache(istate);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
@@ -1218,14 +1223,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			warning(_("core.fsmonitor is unset; "
 				"set it if you really want to "
 				"enable fsmonitor"));
-		add_fsmonitor(&the_index);
+		add_fsmonitor(istate);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
 		if (git_config_get_fsmonitor() == 1)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
-		remove_fsmonitor(&the_index);
+		remove_fsmonitor(istate);
 		report(_("fsmonitor disabled"));
 	}
 
@@ -1235,7 +1240,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(istate, &lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
 
-- 
gitgitgadget

