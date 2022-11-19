Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6DCC433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiKSNIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiKSNH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9278FE4E
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n21so19102682ejb.9
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as5su2VCT4z+Hg6/C9laaK25IcyAiJP4JdHcObLJSEU=;
        b=Umd2TlgwGop92AuCQLMsIgIXyTakmZklEbfrjDWukNcTeuxi8oyUJlsAGAFEcFHWnj
         apiwsjBI8nxFrtrwu9DXvVjVEf2H8bfC0Q/SQeIqJjitP6l5z2XWz6xtFMhJ0QuucG3+
         tPXi1bMNgWYNdl3M75cjn268vHISlFHbPmhgsijSFkBP0wJf5EE1+pF+NDiAnt8MKW6E
         POldRXj2MxnAMlpvAXD4st4Yfb3evrGiFlYM1evD3FLzaxGTwP2c51lkDmiVo7iqAl4P
         5ZbogYwwBXzFy8alsxQ1A7Aoyp7M8Ig7naXzuD5lgyZombdsPpAKOK7w8XYz2IthLe7i
         xKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as5su2VCT4z+Hg6/C9laaK25IcyAiJP4JdHcObLJSEU=;
        b=dM5Am98puXJrprM9C9QgW5tJODB5wQUlUXYCHGnwLyqNmt4HmM/bhxE+7Ninn+tswa
         NRQfNnykACkmJ8BJjYYeRUVYasguf2lmvx/+oQgJ6ZmXdnobNCV4sy0VK5kB9tXxrKrW
         QOERB1q2LDKOMhAGLH2TSDVrq848IW34g+4fJ2WK4N+r6YPO3A5ZviIrRkBX4wSwjwGD
         jMkgaJKFZS094fhdir4G8x0Dqxc/D2Z3Fevbi/hZd3iUPGZ2iws2QNSUyStVcDiVJQPv
         SVj0uEjyJjC71HvtuU/pbZigtLDSvjfCJ4mDPeHVVCHNd3FwdMmV9s3jMUnnUeWxjlK7
         diPA==
X-Gm-Message-State: ANoB5pmMqrY4ephPz0k/ll0vjmWj1Psu/qY1mCXJI6b1HIwbFHPhgpgR
        dqounwUMapyYzoD3ffKsqgUeUOMSzWKOOg==
X-Google-Smtp-Source: AA0mqf628oMlYxJR1/C+4pjwQSbZj96NVbqWHfVwpX04rXy+l3IqLx+wfr4WfzWzRzkEJn1OeDJZ1A==
X-Received: by 2002:a17:906:2552:b0:7ad:917b:61ec with SMTP id j18-20020a170906255200b007ad917b61ecmr1083401ejb.513.1668863273552;
        Sat, 19 Nov 2022 05:07:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] cocci & cache.h: apply variable section of "pending" index-compatibility
Date:   Sat, 19 Nov 2022 14:07:34 +0100
Message-Id: <patch-v2-07.11-fff2d0459a0-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mostly apply the part of "index-compatibility.pending.cocci" that
renames the global variables like "active_nr", which are a shorthand
to referencing (in that case) a struct member as "the_index.cache_nr".

In doing so move more of "index-compatibility.pending.cocci" to
"index-compatibility.cocci".

In the case of "active_nr" we'd have a textual conflict with
"ab/various-leak-fixes" in "next"[1]. Let's exclude that specific case
while moving the rule over from "pending".

1. 407b94280f8 (commit: discard partial cache before (re-)reading it,
   2022-11-08)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/add.c                                 |  8 ++--
 builtin/checkout-index.c                      | 10 ++--
 builtin/checkout.c                            | 46 +++++++++----------
 builtin/commit.c                              | 16 +++----
 builtin/fsck.c                                | 12 ++---
 builtin/merge-index.c                         | 10 ++--
 builtin/merge.c                               |  6 +--
 builtin/mv.c                                  | 19 ++++----
 builtin/read-tree.c                           |  2 +-
 builtin/reset.c                               |  2 +-
 builtin/rm.c                                  | 14 +++---
 builtin/stash.c                               |  8 ++--
 builtin/submodule--helper.c                   | 14 +++---
 builtin/update-index.c                        | 46 +++++++++----------
 cache.h                                       |  3 --
 contrib/coccinelle/index-compatibility.cocci  | 22 +++++++++
 .../index-compatibility.pending.cocci         | 17 -------
 t/helper/test-dump-cache-tree.c               |  2 +-
 t/helper/test-scrap-cache-tree.c              |  4 +-
 19 files changed, 132 insertions(+), 129 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 75be1d021ab..23f9f0e08bb 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -42,8 +42,8 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 		int err;
 
 		if (!include_sparse &&
@@ -159,8 +159,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 {
 	int i, retval = 0;
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 97e06e8c52c..c2aee450c40 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -75,8 +75,8 @@ static int checkout_file(const char *name, const char *prefix)
 	if (pos < 0)
 		pos = -pos - 1;
 
-	while (pos < active_nr) {
-		struct cache_entry *ce = active_cache[pos];
+	while (pos < the_index.cache_nr) {
+		struct cache_entry *ce = the_index.cache[pos];
 		if (ce_namelen(ce) != namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -136,8 +136,8 @@ static int checkout_all(const char *prefix, int prefix_length)
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
 
-	for (i = 0; i < active_nr ; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr ; i++) {
+		struct cache_entry *ce = the_index.cache[i];
 
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
 			if (!ce_skip_worktree(ce))
@@ -151,7 +151,7 @@ static int checkout_all(const char *prefix, int prefix_length)
 			 */
 			if (ignore_skip_worktree) {
 				ensure_full_index(&the_index);
-				ce = active_cache[i];
+				ce = the_index.cache[i];
 			}
 		}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index afbd71764a3..3fd303f5604 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -150,7 +150,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	 */
 	pos = cache_name_pos(ce->name, ce->ce_namelen);
 	if (pos >= 0) {
-		struct cache_entry *old = active_cache[pos];
+		struct cache_entry *old = the_index.cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
 		    !ce_intent_to_add(old) &&
 		    oideq(&ce->oid, &old->oid)) {
@@ -179,8 +179,8 @@ static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 
 static int skip_same_name(const struct cache_entry *ce, int pos)
 {
-	while (++pos < active_nr &&
-	       !strcmp(active_cache[pos]->name, ce->name))
+	while (++pos < the_index.cache_nr &&
+	       !strcmp(the_index.cache[pos]->name, ce->name))
 		; /* skip */
 	return pos;
 }
@@ -188,9 +188,9 @@ static int skip_same_name(const struct cache_entry *ce, int pos)
 static int check_stage(int stage, const struct cache_entry *ce, int pos,
 		       int overlay_mode)
 {
-	while (pos < active_nr &&
-	       !strcmp(active_cache[pos]->name, ce->name)) {
-		if (ce_stage(active_cache[pos]) == stage)
+	while (pos < the_index.cache_nr &&
+	       !strcmp(the_index.cache[pos]->name, ce->name)) {
+		if (ce_stage(the_index.cache[pos]) == stage)
 			return 0;
 		pos++;
 	}
@@ -207,8 +207,8 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 	unsigned seen = 0;
 	const char *name = ce->name;
 
-	while (pos < active_nr) {
-		ce = active_cache[pos];
+	while (pos < the_index.cache_nr) {
+		ce = the_index.cache[pos];
 		if (strcmp(name, ce->name))
 			break;
 		seen |= (1 << ce_stage(ce));
@@ -224,10 +224,10 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 			  const struct checkout *state, int *nr_checkouts,
 			  int overlay_mode)
 {
-	while (pos < active_nr &&
-	       !strcmp(active_cache[pos]->name, ce->name)) {
-		if (ce_stage(active_cache[pos]) == stage)
-			return checkout_entry(active_cache[pos], state,
+	while (pos < the_index.cache_nr &&
+	       !strcmp(the_index.cache[pos]->name, ce->name)) {
+		if (ce_stage(the_index.cache[pos]) == stage)
+			return checkout_entry(the_index.cache[pos], state,
 					      NULL, nr_checkouts);
 		pos++;
 	}
@@ -244,7 +244,7 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 static int checkout_merged(int pos, const struct checkout *state,
 			   int *nr_checkouts, struct mem_pool *ce_mem_pool)
 {
-	struct cache_entry *ce = active_cache[pos];
+	struct cache_entry *ce = the_index.cache[pos];
 	const char *path = ce->name;
 	mmfile_t ancestor, ours, theirs;
 	enum ll_merge_result merge_status;
@@ -257,7 +257,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	int renormalize = 0;
 
 	memset(threeway, 0, sizeof(threeway));
-	while (pos < active_nr) {
+	while (pos < the_index.cache_nr) {
 		int stage;
 		stage = ce_stage(ce);
 		if (!stage || strcmp(path, ce->name))
@@ -266,7 +266,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 		if (stage == 2)
 			mode = create_ce_mode(ce->ce_mode);
 		pos++;
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 	}
 	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
@@ -392,8 +392,8 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	if (pc_workers > 1)
 		init_parallel_checkout();
 
-	for (pos = 0; pos < active_nr; pos++) {
-		struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		struct cache_entry *ce = the_index.cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state,
@@ -541,13 +541,13 @@ static int checkout_paths(const struct checkout_opts *opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
-	for (pos = 0; pos < active_nr; pos++)
+	for (pos = 0; pos < the_index.cache_nr; pos++)
 		if (opts->overlay_mode)
-			mark_ce_for_checkout_overlay(active_cache[pos],
+			mark_ce_for_checkout_overlay(the_index.cache[pos],
 						     ps_matched,
 						     opts);
 		else
-			mark_ce_for_checkout_no_overlay(active_cache[pos],
+			mark_ce_for_checkout_no_overlay(the_index.cache[pos],
 							ps_matched,
 							opts);
 
@@ -562,8 +562,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		unmerge_marked_index(&the_index);
 
 	/* Any unmerged paths? */
-	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		const struct cache_entry *ce = the_index.cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
@@ -868,7 +868,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!cache_tree_fully_valid(active_cache_tree))
+	if (!cache_tree_fully_valid(the_index.cache_tree))
 		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
diff --git a/builtin/commit.c b/builtin/commit.c
index 10a827b1f4a..abbed750276 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -272,8 +272,8 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		struct string_list_item *item;
 
 		if (ce->ce_flags & CE_UPDATE)
@@ -461,8 +461,8 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (!only && !pathspec.nr) {
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
-		if (active_cache_changed
-		    || !cache_tree_fully_valid(active_cache_tree))
+		if (the_index.cache_changed
+		    || !cache_tree_fully_valid(the_index.cache_tree))
 			update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
@@ -998,10 +998,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 			/* TODO: audit for interaction with sparse-index. */
 			ensure_full_index(&the_index);
-			for (i = 0; i < active_nr; i++)
-				if (ce_intent_to_add(active_cache[i]))
+			for (i = 0; i < the_index.cache_nr; i++)
+				if (ce_intent_to_add(the_index.cache[i]))
 					ita_nr++;
-			committable = active_nr - ita_nr > 0;
+			committable = the_index.cache_nr - ita_nr > 0;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
@@ -1823,7 +1823,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
+	if (commit_tree_extended(sb.buf, sb.len, &the_index.cache_tree->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
 		rollback_index_files();
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7436e1a68ef..cd47675e371 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -961,26 +961,26 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		read_cache();
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(&the_index);
-		for (i = 0; i < active_nr; i++) {
+		for (i = 0; i < the_index.cache_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
 			struct object *obj;
 
-			mode = active_cache[i]->ce_mode;
+			mode = the_index.cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
 			blob = lookup_blob(the_repository,
-					   &active_cache[i]->oid);
+					   &the_index.cache[i]->oid);
 			if (!blob)
 				continue;
 			obj = &blob->object;
 			obj->flags |= USED;
 			fsck_put_object_name(&fsck_walk_options, &obj->oid,
-					     ":%s", active_cache[i]->name);
+					     ":%s", the_index.cache[i]->name);
 			mark_object_reachable(obj);
 		}
-		if (active_cache_tree)
-			fsck_cache_tree(active_cache_tree);
+		if (the_index.cache_tree)
+			fsck_cache_tree(the_index.cache_tree);
 		fsck_resolve_undo(&the_index);
 	}
 
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 012f52bd007..a334c513c9d 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -14,11 +14,11 @@ static int merge_entry(int pos, const char *path)
 	char ownbuf[4][60];
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if (pos >= active_nr)
+	if (pos >= the_index.cache_nr)
 		die("git merge-index: %s not in the cache", path);
 	found = 0;
 	do {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = the_index.cache[pos];
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -28,7 +28,7 @@ static int merge_entry(int pos, const char *path)
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
+	} while (++pos < the_index.cache_nr);
 	if (!found)
 		die("git merge-index: %s not in the cache", path);
 
@@ -62,8 +62,8 @@ static void merge_all(void)
 	int i;
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 		i += merge_entry(i, ce->name)-1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 2046992d75a..27218ee93c9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -694,7 +694,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn = threeway_merge;
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&the_index.cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
@@ -784,8 +784,8 @@ static int count_unmerged_entries(void)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < active_nr; i++)
-		if (ce_stage(active_cache[i]))
+	for (i = 0; i < the_index.cache_nr; i++)
+		if (ce_stage(the_index.cache[i]))
 			ret++;
 
 	return ret;
diff --git a/builtin/mv.c b/builtin/mv.c
index 6f94c3b9238..883cf3ff12b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -87,7 +87,7 @@ static void prepare_move_submodule(const char *src, int first,
 				   const char **submodule_gitfile)
 {
 	struct strbuf submodule_dotgit = STRBUF_INIT;
-	if (!S_ISGITLINK(active_cache[first]->ce_mode))
+	if (!S_ISGITLINK(the_index.cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok(&the_index))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed"));
@@ -111,8 +111,8 @@ static int index_range_of_same_dir(const char *src, int length,
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
 
 	first = -1 - first;
-	for (last = first; last < active_nr; last++) {
-		const char *path = active_cache[last]->name;
+	for (last = first; last < the_index.cache_nr; last++) {
+		const char *path = the_index.cache[last]->name;
 		if (strncmp(path, src_w_slash, len_w_slash))
 			break;
 	}
@@ -143,7 +143,7 @@ static int empty_dir_has_sparse_contents(const char *name)
 		pos = -pos - 1;
 		if (pos >= the_index.cache_nr)
 			goto free_return;
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 		if (strncmp(with_slash, ce->name, length))
 			goto free_return;
 		if (ce_skip_worktree(ce))
@@ -268,7 +268,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					bad = _("bad source");
 				goto act_on_entry;
 			}
-			ce = active_cache[pos];
+			ce = the_index.cache[pos];
 			if (!ce_skip_worktree(ce)) {
 				bad = _("bad source");
 				goto act_on_entry;
@@ -331,7 +331,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			dst_len = strlen(dst);
 
 			for (j = 0; j < last - first; j++) {
-				const struct cache_entry *ce = active_cache[first + j];
+				const struct cache_entry *ce = the_index.cache[first + j];
 				const char *path = ce->name;
 				source[argc + j] = path;
 				destination[argc + j] =
@@ -472,7 +472,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		assert(pos >= 0);
 		if (!(mode & SPARSE) && !lstat(src, &st))
 			sparse_and_dirty = ie_modified(&the_index,
-						       active_cache[pos], &st,
+						       the_index.cache[pos],
+						       &st,
 						       0);
 		rename_index_entry_at(&the_index, pos, dst);
 
@@ -489,7 +490,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			    path_in_sparse_checkout(dst, &the_index)) {
 				/* from out-of-cone to in-cone */
 				int dst_pos = cache_name_pos(dst, strlen(dst));
-				struct cache_entry *dst_ce = active_cache[dst_pos];
+				struct cache_entry *dst_ce = the_index.cache[dst_pos];
 
 				dst_ce->ce_flags &= ~CE_SKIP_WORKTREE;
 
@@ -500,7 +501,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				   !path_in_sparse_checkout(dst, &the_index)) {
 				/* from in-cone to out-of-cone */
 				int dst_pos = cache_name_pos(dst, strlen(dst));
-				struct cache_entry *dst_ce = active_cache[dst_pos];
+				struct cache_entry *dst_ce = the_index.cache[dst_pos];
 
 				/*
 				 * if src is clean, it will suffice to remove it
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9ced755a6db..c50b563e2be 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -253,7 +253,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (nr_trees == 1 && !opts.prefix)
 		opts.skip_cache_tree_update = 1;
 
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&the_index.cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
 		parse_tree(tree);
diff --git a/builtin/reset.c b/builtin/reset.c
index 59f777a1da4..75e061f5dcf 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -161,7 +161,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		 * to properly construct the reset sparse directory.
 		 */
 		pos = cache_name_pos(one->path, strlen(one->path));
-		if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
+		if ((pos >= 0 && ce_skip_worktree(the_index.cache[pos])) ||
 		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
 			ce->ce_flags |= CE_SKIP_WORKTREE;
 
diff --git a/builtin/rm.c b/builtin/rm.c
index c717cdc97f5..2b23eb25438 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -35,8 +35,8 @@ static int get_ours_cache_pos(const char *path, int pos)
 {
 	int i = -pos - 1;
 
-	while ((i < active_nr) && !strcmp(active_cache[i]->name, path)) {
-		if (ce_stage(active_cache[i]) == 2)
+	while ((i < the_index.cache_nr) && !strcmp(the_index.cache[i]->name, path)) {
+		if (ce_stage(the_index.cache[i]) == 2)
 			return i;
 		i++;
 	}
@@ -78,7 +78,7 @@ static void submodules_absorb_gitdir_if_needed(void)
 			if (pos < 0)
 				continue;
 		}
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !file_exists(ce->name) ||
@@ -127,11 +127,11 @@ static int check_local_mod(struct object_id *head, int index_only)
 			if (pos < 0)
 				continue;
 
-			if (!S_ISGITLINK(active_cache[pos]->ce_mode) ||
+			if (!S_ISGITLINK(the_index.cache[pos]->ce_mode) ||
 			    is_empty_dir(name))
 				continue;
 		}
-		ce = active_cache[pos];
+		ce = the_index.cache[pos];
 
 		if (lstat(ce->name, &st) < 0) {
 			if (!is_missing_file_error(errno))
@@ -303,8 +303,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (pathspec_needs_expanded_index(&the_index, &pathspec))
 		ensure_full_index(&the_index);
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
diff --git a/builtin/stash.c b/builtin/stash.c
index bb5485b4095..c251419af7c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -454,10 +454,10 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		 * path, but left it out of the working tree, then clear the
 		 * SKIP_WORKTREE bit and write it to the working tree.
 		 */
-		if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
+		if (pos >= 0 && ce_skip_worktree(the_index.cache[pos])) {
 			struct stat st;
 
-			ce = active_cache[pos];
+			ce = the_index.cache[pos];
 			if (!lstat(ce->name, &st)) {
 				/* Conflicting path present; relocate it */
 				struct strbuf new_path = STRBUF_INIT;
@@ -1520,8 +1520,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(&the_index);
-		for (i = 0; i < active_nr; i++)
-			ce_path_match(&the_index, active_cache[i], ps,
+		for (i = 0; i < the_index.cache_nr; i++)
+			ce_path_match(&the_index, the_index.cache[i], ps,
 				      ps_matched);
 
 		if (report_path_error(ps_matched, ps)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a7683d35299..808865a5e31 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -199,8 +199,8 @@ static int module_list_compute(const char **argv,
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < the_index.cache_nr; i++) {
+		const struct cache_entry *ce = the_index.cache[i];
 
 		if (!match_pathspec(&the_index, pathspec, ce->name, ce_namelen(ce),
 				    0, ps_matched, 1) ||
@@ -209,8 +209,8 @@ static int module_list_compute(const char **argv,
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
 		list->entries[list->nr++] = ce;
-		while (i + 1 < active_nr &&
-		       !strcmp(ce->name, active_cache[i + 1]->name))
+		while (i + 1 < the_index.cache_nr &&
+		       !strcmp(ce->name, the_index.cache[i + 1]->name))
 			/*
 			 * Skip entries with the same name in different stages
 			 * to make sure an entry is returned only once.
@@ -3255,15 +3255,15 @@ static void die_on_index_match(const char *path, int force)
 		 * need to check ps_matched[0] to know if a cache
 		 * entry matched.
 		 */
-		for (i = 0; i < active_nr; i++) {
-			ce_path_match(&the_index, active_cache[i], &ps,
+		for (i = 0; i < the_index.cache_nr; i++) {
+			ce_path_match(&the_index, the_index.cache[i], &ps,
 				      ps_matched);
 
 			if (ps_matched[0]) {
 				if (!force)
 					die(_("'%s' already exists in the index"),
 					    path);
-				if (!S_ISGITLINK(active_cache[i]->ce_mode))
+				if (!S_ISGITLINK(the_index.cache[i]->ce_mode))
 					die(_("'%s' already exists in the index "
 					      "and is not a submodule"), path);
 				break;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 533ba66df05..fec3da05abb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -239,14 +239,14 @@ static int mark_ce_flags(const char *path, int flag, int mark)
 	int namelen = strlen(path);
 	int pos = cache_name_pos(path, namelen);
 	if (0 <= pos) {
-		mark_fsmonitor_invalid(&the_index, active_cache[pos]);
+		mark_fsmonitor_invalid(&the_index, the_index.cache[pos]);
 		if (mark)
-			active_cache[pos]->ce_flags |= flag;
+			the_index.cache[pos]->ce_flags |= flag;
 		else
-			active_cache[pos]->ce_flags &= ~flag;
-		active_cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
+			the_index.cache[pos]->ce_flags &= ~flag;
+		the_index.cache[pos]->ce_flags |= CE_UPDATE_IN_BASE;
 		cache_tree_invalidate_path(&the_index, path);
-		active_cache_changed |= CE_ENTRY_CHANGED;
+		the_index.cache_changed |= CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -335,7 +335,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = the_index.cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
@@ -350,8 +350,8 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos = -pos-1;
-	while (pos < active_nr) {
-		const struct cache_entry *ce = active_cache[pos++];
+	while (pos < the_index.cache_nr) {
+		const struct cache_entry *ce = the_index.cache[pos++];
 
 		if (strncmp(ce->name, path, len))
 			break;
@@ -382,7 +382,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		return error("'%s' is beyond a symbolic link", path);
 
 	pos = cache_name_pos(path, len);
-	ce = pos < 0 ? NULL : active_cache[pos];
+	ce = pos < 0 ? NULL : the_index.cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
 		 * working directory version is assumed "good"
@@ -444,7 +444,7 @@ static void chmod_path(char flip, const char *path)
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
 		goto fail;
-	ce = active_cache[pos];
+	ce = the_index.cache[pos];
 	if (chmod_index_entry(&the_index, ce, flip) < 0)
 		goto fail;
 
@@ -642,8 +642,8 @@ static int unresolve_one(const char *path)
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_index_entry_at(&the_index, pos);
-		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+		if (pos < the_index.cache_nr) {
+			const struct cache_entry *ce = the_index.cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen))
@@ -656,8 +656,8 @@ static int unresolve_one(const char *path)
 		 * want to do anything in the former case.
 		 */
 		pos = -pos-1;
-		if (pos < active_nr) {
-			const struct cache_entry *ce = active_cache[pos];
+		if (pos < the_index.cache_nr) {
+			const struct cache_entry *ce = the_index.cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
 				fprintf(stderr,
@@ -752,8 +752,8 @@ static int do_reupdate(const char **paths,
 		 */
 		has_head = 0;
  redo:
-	for (pos = 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce = active_cache[pos];
+	for (pos = 0; pos < the_index.cache_nr; pos++) {
+		const struct cache_entry *ce = the_index.cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
 		char *path;
@@ -782,12 +782,12 @@ static int do_reupdate(const char **paths,
 		 * path anymore, in which case, under 'allow_remove',
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
-		save_nr = active_nr;
+		save_nr = the_index.cache_nr;
 		path = xstrdup(ce->name);
 		update_one(path);
 		free(path);
 		discard_cache_entry(old);
-		if (save_nr != active_nr)
+		if (save_nr != the_index.cache_nr)
 			goto redo;
 	}
 	clear_pathspec(&pathspec);
@@ -813,7 +813,7 @@ static int refresh(struct refresh_params *o, unsigned int flag)
 		 * refresh_cache() as these are no actual errors.
 		 * cmd_status() does the same.
 		 */
-		active_cache_changed |= SOMETHING_CHANGED;
+		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
 	return 0;
 }
@@ -951,7 +951,7 @@ static enum parse_opt_result unresolve_callback(
 	*has_errors = do_unresolve(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
-		active_cache_changed = 0;
+		the_index.cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -972,7 +972,7 @@ static enum parse_opt_result reupdate_callback(
 	setup_work_tree();
 	*has_errors = do_reupdate(ctx->argv + 1, prefix);
 	if (*has_errors)
-		active_cache_changed = 0;
+		the_index.cache_changed = 0;
 
 	ctx->argv += ctx->argc - 1;
 	ctx->argc = 1;
@@ -1178,7 +1178,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 
 		if (the_index.version != preferred_index_format)
-			active_cache_changed |= SOMETHING_CHANGED;
+			the_index.cache_changed |= SOMETHING_CHANGED;
 		the_index.version = preferred_index_format;
 	}
 
@@ -1290,7 +1290,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("fsmonitor disabled"));
 	}
 
-	if (active_cache_changed || force_write) {
+	if (the_index.cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
diff --git a/cache.h b/cache.h
index 79b8d479710..805e25f9a67 100644
--- a/cache.h
+++ b/cache.h
@@ -436,10 +436,7 @@ void prefetch_cache_entries(const struct index_state *istate,
 #ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
 extern struct index_state the_index;
 
-#define active_cache (the_index.cache)
 #define active_nr (the_index.cache_nr)
-#define active_cache_changed (the_index.cache_changed)
-#define active_cache_tree (the_index.cache_tree)
 
 #define read_cache() repo_read_index(the_repository)
 #define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 89c18986160..8b1ed65e7b0 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -1,3 +1,25 @@
+// the_index.* variables
+@@
+@@
+(
+- active_cache
++ the_index.cache
+|
+- active_cache_changed
++ the_index.cache_changed
+|
+- active_cache_tree
++ the_index.cache_tree
+)
+
+@@
+identifier f != prepare_to_commit;
+@@
+  f(...) {<...
+- active_nr
++ the_index.cache_nr
+  ...>}
+
 // "the_repository" simple cases
 @@
 @@
diff --git a/contrib/coccinelle/index-compatibility.pending.cocci b/contrib/coccinelle/index-compatibility.pending.cocci
index cf1ea57d700..8207aee62c3 100644
--- a/contrib/coccinelle/index-compatibility.pending.cocci
+++ b/contrib/coccinelle/index-compatibility.pending.cocci
@@ -1,20 +1,3 @@
-// the_index.* variables
-@@
-@@
-(
-- active_cache
-+ the_index.cache
-|
-- active_nr
-+ the_index.cache_nr
-|
-- active_cache_changed
-+ the_index.cache_changed
-|
-- active_cache_tree
-+ the_index.cache_tree
-)
-
 // "the_repository" simple cases
 @@
 @@
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 0d6d7f1ecbf..8d88111b357 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -67,7 +67,7 @@ int cmd__dump_cache_tree(int ac, const char **av)
 	istate = the_index;
 	istate.cache_tree = another;
 	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
-	ret = dump_cache_tree(active_cache_tree, another, "");
+	ret = dump_cache_tree(the_index.cache_tree, another, "");
 	cache_tree_free(&another);
 
 	return ret;
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 026c802479d..20e2e31f9e2 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -12,8 +12,8 @@ int cmd__scrap_cache_tree(int ac, const char **av)
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	if (read_cache() < 0)
 		die("unable to read index file");
-	cache_tree_free(&active_cache_tree);
-	active_cache_tree = NULL;
+	cache_tree_free(&the_index.cache_tree);
+	the_index.cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
 	return 0;
-- 
2.38.0.1509.g9445af83948

