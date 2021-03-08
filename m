Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5FAC41518
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC765237
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhCHPH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhCHPHf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0032C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b18so11816423wrn.6
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZqHk5KMJvfunVnzQodCfjZPBsAadG4w4oVKXWOkCf0=;
        b=RC/uj0e2tKk2GktRt4RiPJcQd8FVUek/BTZbnKz62tZ7/Hebb7j2t2PVWZAb7QxfXU
         VduJQQBugQ1dFyjruS7m0xNLfRV1EC0FAFU91E0bSiALpYAE0pQmOLnPGWxP1CZ5nPUj
         5rtc3aoCCv3apwOrbEhHpKVjceJTh8oTpQR1l+qTmTEYpSkR2X+jpaJ7xJkNMG1/bCU0
         7VvOeM+ZYcdrzxyjZgoG/16SErPbIrti54ymM/sAPPibVXz3X0gyuS23EY6dCO/hp8Az
         +GeXj1rmFtkM6efFkvNXZhIUmZLoFj+0H/gxfhQkPzgN9SAhLk9B12ILo2wvtezqehrB
         A/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZqHk5KMJvfunVnzQodCfjZPBsAadG4w4oVKXWOkCf0=;
        b=FAmKy/cJXo+Y6ADDnYarN88pE8ulYGH80t1fsCEXFFOSmzNbtQ+xBQvrkT6eHfMR87
         21LqkUN2Nguu21WkGzOjjxd99tHaGg7+AgU3mJzOLmfbk5XJssADUDvccY33x4M9AKN1
         lEAtBRFetkjKs86pWhSZnuLAR0WheM2cJWfAnNM5nsPIJUTylLBWZDX+gD7N888JoQcB
         UazTmLqEMJJV1vTRPnCUo2mBcCpbDSNKNDI/WafQmGk1asrjz/ckJF+P8OxKlSmKMWRN
         Zt8y+cW34FtwdhABIqZ+w914LZV1yvo6ZXBX/oqxwyRfTO+KGcpW+51AaQj2G8m1msNy
         JPgw==
X-Gm-Message-State: AOAM530BVAMHLL2PsdZpDyCVC+qM2WOhWhWXl+WMrPKlgz3VXpiqKOWL
        CSX0SR9ycAvNrOpvJANOgv2jYBiAq3jd1Q==
X-Google-Smtp-Source: ABdhPJwKEXUXF2qQiouchlMJQnytPdpfX56A9i5FfDqSq5es/KdKNrreBEi02AO7u2QYNFoWXwzMKw==
X-Received: by 2002:adf:8341:: with SMTP id 59mr22554152wrd.130.1615216053068;
        Mon, 08 Mar 2021 07:07:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 28/30] tree-walk.h API users: rename "struct name_entry"'s "mode" to "raw_mode"
Date:   Mon,  8 Mar 2021 16:06:48 +0100
Message-Id: <20210308150650.18626-29-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that most of the users of the "mode" variable have been moved to
use "object_type" instead let's rename it to "raw_mode" in preparation
for a revert of 7146e66f086 (tree-walk: finally switch over tree
descriptors to contain a pre-parsed entry, 2014-02-06).

This will allow API users who care about the actual mode bits in tree
objects to get access to them, such as fsck, the merge algorithm etc.

But most users will not want to have such potentially un-sanitized, so
let's indicate that by giving the variable a more scary name.

I am not renaming the variables being assigned to, i.e. it's now going
to be "int mode = entry.raw_mode", not "int raw_mode = [...]". This is
because we're going to be getting a sanitized "mode" via
"canon_mode()" in many of these functions soon, so renaming the local
variable back and forth will result in needless churn.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-tree.c |  8 ++++----
 match-trees.c        |  4 ++--
 merge-ort.c          | 12 ++++++------
 notes.c              |  2 +-
 tree-diff.c          | 22 +++++++++++-----------
 tree-walk.c          |  2 +-
 tree-walk.h          |  6 +++---
 tree.c               |  2 +-
 unpack-trees.c       |  6 +++---
 9 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index eec5b906561..b4e736e4b72 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -160,7 +160,7 @@ static int same_entry(struct name_entry *a, struct name_entry *b)
 	return	!is_null_oid(&a->oid) &&
 		!is_null_oid(&b->oid) &&
 		oideq(&a->oid, &b->oid) &&
-		a->mode == b->mode;
+		a->raw_mode == b->raw_mode;
 }
 
 static int both_empty(struct name_entry *a, struct name_entry *b)
@@ -197,9 +197,9 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 		return;
 
 	path = traverse_path(info, result);
-	orig_mode = ours->mode;
+	orig_mode = ours->raw_mode;
 	orig = create_entry(2, orig_mode, &ours->oid, path);
-	final_mode = result->mode;
+	final_mode = result->raw_mode;
 	final = create_entry(0, final_mode, &result->oid, path);
 
 	final->link = orig;
@@ -252,7 +252,7 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 		path = entry->path;
 	else
 		path = traverse_path(info, n);
-	link_mode = n->mode;
+	link_mode = n->raw_mode;
 	link = create_entry(stage, link_mode, &n->oid, path);
 
 	link->link = entry;
diff --git a/match-trees.c b/match-trees.c
index 0636f6e58e9..d45c76ffa79 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -86,8 +86,8 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 
 	for (;;) {
 		int cmp;
-		unsigned int one_mode = one.entry.mode;
-		unsigned int two_mode = two.entry.mode;
+		unsigned int one_mode = one.entry.raw_mode;
+		unsigned int two_mode = two.entry.raw_mode;
 
 		if (one.size && two.size)
 			cmp = base_name_entries_compare(&one.entry, &two.entry);
diff --git a/merge-ort.c b/merge-ort.c
index cad10436504..ea20bbe2af3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -502,7 +502,7 @@ static void setup_path_info(struct merge_options *opt,
 	mi->basename_offset = current_dir_name_len;
 	mi->clean = !!resolved;
 	if (resolved) {
-		mi->result.mode = merged_version->mode;
+		mi->result.mode = merged_version->raw_mode;
 		oidcpy(&mi->result.oid, &merged_version->oid);
 		mi->is_null = !!is_null;
 	} else {
@@ -512,7 +512,7 @@ static void setup_path_info(struct merge_options *opt,
 		ASSIGN_AND_VERIFY_CI(ci, mi);
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
 			ci->pathnames[i] = fullpath;
-			ci->stages[i].mode = names[i].mode;
+			ci->stages[i].mode = names[i].raw_mode;
 			oidcpy(&ci->stages[i].oid, &names[i].oid);
 		}
 		ci->filemask = filemask;
@@ -545,7 +545,7 @@ static void add_pair(struct merge_options *opt,
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
 	const struct object_id *oid = &names[names_idx].oid;
-	unsigned int mode = names[names_idx].mode;
+	unsigned int mode = names[names_idx].raw_mode;
 
 	one = alloc_filespec(pathname);
 	two = alloc_filespec(pathname);
@@ -616,13 +616,13 @@ static int collect_merge_info_callback(int n,
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
 	unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
-					names[0].mode == names[1].mode &&
+					names[0].raw_mode == names[1].raw_mode &&
 					oideq(&names[0].oid, &names[1].oid));
 	unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
-					names[0].mode == names[2].mode &&
+					names[0].raw_mode == names[2].raw_mode &&
 					oideq(&names[0].oid, &names[2].oid));
 	unsigned sides_match = (!side1_null && !side2_null &&
-				names[1].mode == names[2].mode &&
+				names[1].raw_mode == names[2].raw_mode &&
 				oideq(&names[1].oid, &names[2].oid));
 
 	/*
diff --git a/notes.c b/notes.c
index aa46cb2b09e..2817325651a 100644
--- a/notes.c
+++ b/notes.c
@@ -478,7 +478,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			struct strbuf non_note_path = STRBUF_INIT;
 			const char *q = oid_to_hex(&subtree->key_oid);
 			size_t i;
-			unsigned int mode = entry.mode;
+			unsigned int mode = entry.raw_mode;
 			for (i = 0; i < prefix_len; i++) {
 				strbuf_addch(&non_note_path, *q++);
 				strbuf_addch(&non_note_path, *q++);
diff --git a/tree-diff.c b/tree-diff.c
index 10c92d39c42..df8301d806a 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -232,7 +232,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 			 * tp[i] is valid, if present and if tp[i]==tp[imin] -
 			 * otherwise, we should ignore it.
 			 */
-			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
+			int tpi_valid = tp && !(tp[i].entry.raw_mode & S_IFXMIN_NEQ);
 
 			const struct object_id *oid_i;
 			unsigned mode_i;
@@ -245,7 +245,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 			if (tpi_valid) {
 				oid_i = &tp[i].entry.oid;
-				mode_i = tp[i].entry.mode;
+				mode_i = tp[i].entry.raw_mode;
 			}
 			else {
 				oid_i = &null_oid;
@@ -283,7 +283,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		FAST_ARRAY_ALLOC(parents_oid, nparent);
 		for (i = 0; i < nparent; ++i) {
 			/* same rule as in emitthis */
-			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
+			int tpi_valid = tp && !(tp[i].entry.raw_mode & S_IFXMIN_NEQ);
 
 			parents_oid[i] = tpi_valid ? &tp[i].entry.oid : NULL;
 		}
@@ -404,7 +404,7 @@ static inline void update_tp_entries(struct tree_desc *tp, int nparent)
 {
 	int i;
 	for (i = 0; i < nparent; ++i)
-		if (!(tp[i].entry.mode & S_IFXMIN_NEQ))
+		if (!(tp[i].entry.raw_mode & S_IFXMIN_NEQ))
 			update_tree_entry(&tp[i]);
 }
 
@@ -465,10 +465,10 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		 * mark entries whether they =p[imin] along the way
 		 */
 		imin = 0;
-		tp[0].entry.mode &= ~S_IFXMIN_NEQ;
+		tp[0].entry.raw_mode &= ~S_IFXMIN_NEQ;
 
 		for (i = 1; i < nparent; ++i) {
-			unsigned int mode = tp[i].entry.mode;
+			unsigned int mode = tp[i].entry.raw_mode;
 			cmp = tree_entry_pathcmp(&tp[i], &tp[imin]);
 			if (cmp < 0) {
 				imin = i;
@@ -480,12 +480,12 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			else {
 				mode |= S_IFXMIN_NEQ;
 			}
-			tp[i].entry.mode = mode;
+			tp[i].entry.raw_mode = mode;
 		}
 
 		/* fixup markings for entries before imin */
 		for (i = 0; i < imin; ++i)
-			tp[i].entry.mode |= S_IFXMIN_NEQ;	/* pi > p[imin] */
+			tp[i].entry.raw_mode |= S_IFXMIN_NEQ;	/* pi > p[imin] */
 
 
 
@@ -497,14 +497,14 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			/* are either pi > p[imin] or diff(t,pi) != ø ? */
 			if (!opt->flags.find_copies_harder) {
 				for (i = 0; i < nparent; ++i) {
-					unsigned int mode = tp[i].entry.mode;
+					unsigned int mode = tp[i].entry.raw_mode;
 					/* p[i] > p[imin] */
 					if (mode & S_IFXMIN_NEQ)
 						continue;
 
 					/* diff(t,pi) != ø */
 					if (!oideq(&t.entry.oid, &tp[i].entry.oid) ||
-					    (t.entry.mode != mode))
+					    (t.entry.raw_mode != mode))
 						continue;
 
 					goto skip_emit_t_tp;
@@ -536,7 +536,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			/* ∀i pi=p[imin] -> D += "-p[imin]" */
 			if (!opt->flags.find_copies_harder) {
 				for (i = 0; i < nparent; ++i)
-					if (tp[i].entry.mode & S_IFXMIN_NEQ)
+					if (tp[i].entry.raw_mode & S_IFXMIN_NEQ)
 						goto skip_emit_tp;
 			}
 
diff --git a/tree-walk.c b/tree-walk.c
index 12e0ed4e250..099a9b3bd77 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -48,7 +48,7 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
 	mode = canon_mode(mode);
-	desc->entry.mode = mode;
+	desc->entry.raw_mode = mode;
 	desc->entry.object_type = object_type(mode);
 	desc->entry.pathlen = len - 1;
 	hashcpy(desc->entry.oid.hash, (const unsigned char *)path + len);
diff --git a/tree-walk.h b/tree-walk.h
index 1f69e57db4c..885ced74258 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -16,7 +16,7 @@ struct name_entry {
 	struct object_id oid;
 	const char *path;
 	int pathlen;
-	unsigned int mode;
+	unsigned int raw_mode;
 	/* simple 'mode': Only OBJ_{BLOB,TREE,COMMIT} */
 	enum object_type object_type;
 };
@@ -55,7 +55,7 @@ static inline const struct object_id *tree_entry_extract_mode(struct tree_desc *
 							      unsigned short *modep)
 {
 	*pathp = desc->entry.path;
-	*modep = desc->entry.mode;
+	*modep = desc->entry.raw_mode;
 	return &desc->entry.oid;
 }
 
@@ -75,7 +75,7 @@ static inline const struct object_id *tree_entry_extract_all(struct tree_desc *d
 							     enum object_type *object_typep)
 {
 	*pathp = desc->entry.path;
-	*modep = desc->entry.mode;
+	*modep = desc->entry.raw_mode;
 	*object_typep = desc->entry.object_type;
 	return &desc->entry.oid;
 }
diff --git a/tree.c b/tree.c
index e4402fad69b..215d17e1295 100644
--- a/tree.c
+++ b/tree.c
@@ -40,7 +40,7 @@ static int read_tree_1(struct repository *r,
 		}
 
 		switch (fn(&entry.oid, base,
-			   entry.path, entry.object_type, entry.mode, context)) {
+			   entry.path, entry.object_type, entry.raw_mode, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
diff --git a/unpack-trees.c b/unpack-trees.c
index 9471c19de72..dcdf8130745 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -867,7 +867,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.pathspec = info->pathspec;
 	newinfo.name = p->path;
 	newinfo.namelen = p->pathlen;
-	newinfo.mode = p->mode;
+	newinfo.mode = p->raw_mode;
 	newinfo.pathlen = st_add3(newinfo.pathlen, tree_entry_len(p), 1);
 	newinfo.df_conflicts |= df_conflicts;
 
@@ -1020,7 +1020,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 		is_transient ?
 		make_empty_transient_cache_entry(len) :
 		make_empty_cache_entry(istate, len);
-	unsigned int mode = n->mode;
+	unsigned int mode = n->raw_mode;
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(stage);
@@ -1209,7 +1209,7 @@ static void debug_path(struct traverse_info *info)
 static void debug_name_entry(int i, struct name_entry *n)
 {
 	printf("ent#%d %06o %s\n", i,
-	       n->path ? n->mode : 0,
+	       n->path ? n->raw_mode : 0,
 	       n->path ? n->path : "(missing)");
 }
 
-- 
2.31.0.rc0.126.g04f22c5b82

