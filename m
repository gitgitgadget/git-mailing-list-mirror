Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF5C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjCQPgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjCQPgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A331E07
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x3so21903127edb.10
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMyJtSJUatPdCLocI60I4sEHD/I7w/H4QLyV/Cf5rE4=;
        b=jUk3NRlsunMiPyG8mW1Xhb4GlYMf81fQtrsTRMSX1oUkHUYb1L/E96F9YjHxp1A7Tu
         QJVLw0u3L868PH3JB2HbRGg3ZdIPl3iSw7yLyPm50gz0MBLqy/h4PTQ7nFfBYcqngNVB
         YvDM19UxCwDXGbqxuCIGzQtrnQSo5hOF4/dNktJuKT+/Q03eNdxAR4vPbAQnFacgbEgq
         Bmh8nTT8nUtMoGulB018S5FCAMVS3a8vR1JMrsiBtAwIs0MSNM/bhZasO7zHWTkG1rCx
         lho8olTNlIYYxyMz945d8B2iKoplSuY/z56/8nuQFlPVHFOGvzcwtxBaW7mGfEoLQgac
         XiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMyJtSJUatPdCLocI60I4sEHD/I7w/H4QLyV/Cf5rE4=;
        b=FsYGg4YbZqt2PSnrbiTl1YQ9dqN/BPEl6nVxieF99qpv2EGo+Lj1WVrVc2xlhpVeGP
         irMHf2FgusxsIInR0GVtKw6A+ffaHSWpfM3ACYZieRM9kHLZbEqCXqFN5rHa+9kp+ZdX
         X5S6jTNZ5tnpb0vy9Vx1R0d9du1QyeFk2SLOOdDjbLknKzeu/wvPwb6oJAMPRbeVwdlU
         ECbCOWQpPzMz9x3YR2HcyIh1kCYWzOFqmJBYk8yxNF4zR/2Z3ziVy52oiGnZ+sbgargk
         e/O7w1Vu6QqNSFBHScR9mfEXE1VoIV9mdzZ6QZBJqFjGK04VFxmvIgPaS7cLOhW02J5a
         jTyw==
X-Gm-Message-State: AO0yUKXeXJkZlEgm8KCs4itqmGqn8EyP05ZYcXRGWNindDzExu2MuK7t
        gYXLV7AWZewr91EVXrtrDi5MNhpx6EYr7w==
X-Google-Smtp-Source: AK7set8dT128d/et2BswkUQ7kRGvqSekAiIAHqI3NAfcqY3XKAwFuH1y2TGMikFqHLt668sAs/t+nw==
X-Received: by 2002:aa7:d6d4:0:b0:4f9:a97d:469b with SMTP id x20-20020aa7d6d4000000b004f9a97d469bmr3791693edr.10.1679067336385;
        Fri, 17 Mar 2023 08:35:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/17] cocci: apply the "promisor-remote.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:16 +0100
Message-Id: <patch-12.17-abd237009f9-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"promisor-remote.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c                              |  2 +-
 builtin/fetch.c                                 |  4 ++--
 builtin/gc.c                                    |  2 +-
 builtin/index-pack.c                            |  2 +-
 builtin/pack-objects.c                          |  2 +-
 builtin/repack.c                                |  2 +-
 cache-tree.c                                    |  4 ++--
 connected.c                                     |  4 ++--
 contrib/coccinelle/the_repository.cocci         | 10 ++++++++++
 contrib/coccinelle/the_repository.pending.cocci | 10 ----------
 diff.c                                          |  2 +-
 diffcore-break.c                                |  2 +-
 diffcore-rename.c                               |  4 ++--
 list-objects-filter-options.c                   |  7 ++++---
 merge-ort.c                                     |  2 +-
 packfile.c                                      |  2 +-
 promisor-remote.h                               | 15 ---------------
 unpack-trees.c                                  |  2 +-
 18 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index caf2d258619..b72dd91bd1f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -792,7 +792,7 @@ static int batch_objects(struct batch_options *opt)
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
 
-		if (has_promisor_remote())
+		if (repo_has_promisor_remote(the_repository))
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
 		read_replace_refs = 0;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 784e344d2bb..0020015ca42 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2008,7 +2008,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!has_promisor_remote() && !filter_options.choice)
+	if (!repo_has_promisor_remote(the_repository) && !filter_options.choice)
 		return;
 
 	/*
@@ -2264,7 +2264,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			printf("%s\n", oid_to_hex(oid));
 		oidset_clear(&acked_commits);
 	} else if (remote) {
-		if (filter_options.choice || has_promisor_remote())
+		if (filter_options.choice || repo_has_promisor_remote(the_repository))
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index bef26020f99..a1a2ae4da29 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -699,7 +699,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			strvec_push(&prune, prune_expire);
 			if (quiet)
 				strvec_push(&prune, "--no-progress");
-			if (has_promisor_remote())
+			if (repo_has_promisor_remote(the_repository))
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
 			prune_cmd.git_cmd = 1;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4cf69ee1d97..de47f3f6441 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1390,7 +1390,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		sorted_by_pos[i] = &ref_deltas[i];
 	QSORT(sorted_by_pos, nr_ref_deltas, delta_pos_compare);
 
-	if (has_promisor_remote()) {
+	if (repo_has_promisor_remote(the_repository)) {
 		/*
 		 * Prefetch the delta bases.
 		 */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3c9b35642cb..2f2c02589b3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2078,7 +2078,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 
 	if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
 				     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		if (has_promisor_remote()) {
+		if (repo_has_promisor_remote(the_repository)) {
 			prefetch_to_pack(object_index);
 			if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
 						     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
diff --git a/builtin/repack.c b/builtin/repack.c
index f6493795318..25658fe732b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -901,7 +901,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--reflog");
 		strvec_push(&cmd.args, "--indexed-objects");
 	}
-	if (has_promisor_remote())
+	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (!write_midx) {
 		if (write_bitmaps > 0)
diff --git a/cache-tree.c b/cache-tree.c
index 59610117d0b..ab2cc1edf29 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -240,7 +240,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 
 static int must_check_existence(const struct cache_entry *ce)
 {
-	return !(has_promisor_remote() && ce_skip_worktree(ce));
+	return !(repo_has_promisor_remote(the_repository) && ce_skip_worktree(ce));
 }
 
 static int update_one(struct cache_tree *it,
@@ -470,7 +470,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (!istate->cache_tree)
 		istate->cache_tree = cache_tree();
 
-	if (!(flags & WRITE_TREE_MISSING_OK) && has_promisor_remote())
+	if (!(flags & WRITE_TREE_MISSING_OK) && repo_has_promisor_remote(the_repository))
 		prefetch_cache_entries(istate, must_check_existence);
 
 	trace_performance_enter();
diff --git a/connected.c b/connected.c
index b90fd61790c..5853fd7cbfd 100644
--- a/connected.c
+++ b/connected.c
@@ -54,7 +54,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_release(&idx_file);
 	}
 
-	if (has_promisor_remote()) {
+	if (repo_has_promisor_remote(the_repository)) {
 		/*
 		 * For partial clones, we don't want to have to do a regular
 		 * connectivity check because we have to enumerate and exclude
@@ -97,7 +97,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args,"rev-list");
 	strvec_push(&rev_list.args, "--objects");
 	strvec_push(&rev_list.args, "--stdin");
-	if (has_promisor_remote())
+	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		strvec_push(&rev_list.args, "--not");
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index a325361f961..d5b644a8687 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -95,6 +95,16 @@
 |
 - approximate_object_count
 + repo_approximate_object_count
+// promisor-remote.h
+|
+- promisor_remote_reinit
++ repo_promisor_remote_reinit
+|
+- promisor_remote_find
++ repo_promisor_remote_find
+|
+- has_promisor_remote
++ repo_has_promisor_remote
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 9b426e49e66..e17a60198c5 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,17 +5,7 @@
 @@
 @@
 (
-// promisor-remote.h
-- promisor_remote_reinit
-+ repo_promisor_remote_reinit
-|
-- promisor_remote_find
-+ repo_promisor_remote_find
-|
-- has_promisor_remote
-+ repo_has_promisor_remote
 // refs.h
-|
 - dwim_ref
 + repo_dwim_ref
 // rerere.h
diff --git a/diff.c b/diff.c
index 3abeca9d46c..5278343f95a 100644
--- a/diff.c
+++ b/diff.c
@@ -6860,7 +6860,7 @@ void diffcore_std(struct diff_options *options)
 	 * If no prefetching occurs, diffcore_rename() will prefetch if it
 	 * decides that it needs inexact rename detection.
 	 */
-	if (options->repo == the_repository && has_promisor_remote() &&
+	if (options->repo == the_repository && repo_has_promisor_remote(the_repository) &&
 	    (options->output_format & output_formats_to_prefetch ||
 	     options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		diff_queued_diff_prefetch(options->repo);
diff --git a/diffcore-break.c b/diffcore-break.c
index 0d4a14964d0..5462420bbbe 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -65,7 +65,7 @@ static int should_break(struct repository *r,
 	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (r == the_repository && has_promisor_remote()) {
+	if (r == the_repository && repo_has_promisor_remote(the_repository)) {
 		options.missing_object_cb = diff_queued_diff_prefetch;
 		options.missing_object_data = r;
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index c0422d9e709..a97b1322b51 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -981,7 +981,7 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
-	if (options->repo == the_repository && has_promisor_remote()) {
+	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
 		dpf_options.missing_object_cb = basename_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
@@ -1567,7 +1567,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	/* Finish setting up dpf_options */
 	prefetch_options.skip_unmodified = skip_unmodified;
-	if (options->repo == the_repository && has_promisor_remote()) {
+	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
 		dpf_options.missing_object_cb = inexact_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ee01bcd2cc3..ccfeabc4778 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -341,7 +341,7 @@ void partial_clone_register(
 	char *filter_name;
 
 	/* Check if it is already registered */
-	if ((promisor_remote = promisor_remote_find(remote))) {
+	if ((promisor_remote = repo_promisor_remote_find(the_repository, remote))) {
 		if (promisor_remote->partial_clone_filter)
 			/*
 			 * Remote is already registered and a filter is already
@@ -369,14 +369,15 @@ void partial_clone_register(
 	free(filter_name);
 
 	/* Make sure the config info are reset */
-	promisor_remote_reinit();
+	repo_promisor_remote_reinit(the_repository);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options,
 	const char *remote)
 {
-	struct promisor_remote *promisor = promisor_remote_find(remote);
+	struct promisor_remote *promisor = repo_promisor_remote_find(the_repository,
+								     remote);
 	struct strbuf errbuf = STRBUF_INIT;
 
 	/*
diff --git a/merge-ort.c b/merge-ort.c
index 979e8b057b1..ba3f5607bbb 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4216,7 +4216,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	struct string_list_item *e;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	if (opt->repo != the_repository || !has_promisor_remote())
+	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
 		return;
 
 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
diff --git a/packfile.c b/packfile.c
index 79e21ab18e7..4aee73d545f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2263,7 +2263,7 @@ int is_promisor_object(const struct object_id *oid)
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (has_promisor_remote()) {
+		if (repo_has_promisor_remote(the_repository)) {
 			for_each_packed_object(add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY |
diff --git a/promisor-remote.h b/promisor-remote.h
index df36eb08efc..2cb9eda9ea4 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -18,24 +18,9 @@ struct promisor_remote {
 };
 
 void repo_promisor_remote_reinit(struct repository *r);
-static inline void promisor_remote_reinit(void)
-{
-	repo_promisor_remote_reinit(the_repository);
-}
-
 void promisor_remote_clear(struct promisor_remote_config *config);
-
 struct promisor_remote *repo_promisor_remote_find(struct repository *r, const char *remote_name);
-static inline struct promisor_remote *promisor_remote_find(const char *remote_name)
-{
-	return repo_promisor_remote_find(the_repository, remote_name);
-}
-
 int repo_has_promisor_remote(struct repository *r);
-static inline int has_promisor_remote(void)
-{
-	return repo_has_promisor_remote(the_repository);
-}
 
 /*
  * Fetches all requested objects from all promisor remotes, trying them one at
diff --git a/unpack-trees.c b/unpack-trees.c
index 3d05e45a279..b82ad7e45d0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -458,7 +458,7 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	if (has_promisor_remote())
+	if (repo_has_promisor_remote(the_repository))
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
-- 
2.40.0.rc1.1034.g5867a1b10c5

