Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE8FC4360C
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340DE61057
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhCaTKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhCaTKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA8C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so20708476wrs.9
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQ1N5Mvh1Y4u23/1Ndq6YRjzs9VmB1LJEWdeaF6VN8g=;
        b=SlJnNiAaBKTdQ6XmLmVu6PDdbhQSB2VwEFlwXgRrWeoyst1ej5IzEmOb3ELnlifDIA
         PKWRcxuXF2SPEche9Vw1ZCxwAVZtto4xbv9BFouuO8Za9tTOkk34LsFfrd73P+dbdr7t
         s56PXXWuGigb0Jm69oOEyWwARXBddNYDe7ctSgXnXyMPniC7eJxoPzdaDCAvywUMXSAj
         w6210b0TEdUxzrAFh6xqmkHRbLkuo897xE4TVKpEt+2tY8A2VB5FzgjG/o9FqyzCF2ho
         X8e4k7dQirjJyxXjIkv6DfEnT6bA9RNXV+OUU7ugOzfUwTbq5kpnIPcuyDyiCgTYLUsb
         6ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQ1N5Mvh1Y4u23/1Ndq6YRjzs9VmB1LJEWdeaF6VN8g=;
        b=McEC/K5bS2kCeTTECBtr0MF6kAMSG7gC98y/lwhQGbah9k9p0osKN1cLRKgdCoqqqZ
         hClee+hYksswqcjCFD5U+mk2okVRlD7Doc9O4tLu6JQW925T3YBoT89g1gOVRriIKtYa
         b5D4dEtS3sT5PTiFCdDeTu2KgPqm06Z+rfjSUPj18u+eHzlqLv0MKgT84hBv2kE8ZaQE
         5d8cb3Eq7RxG/Szot+xphiWqTuUBTQVrZZYKUl+kZIoyFnOIbe1tusK+HMfc85FWHxzd
         YBecyxH8nJi5QqSGP/A+uGPmHWRlelfS9FZH+07BDseEd7GtdAoLkx1HGPu0Qpp9APRQ
         tBJw==
X-Gm-Message-State: AOAM532rgDDTfW8n1nu4uC+aczar20uXeeib5kTtxcEBM3ABVrzNBnC2
        ZD1vh5iBOP8SM469Arb8L3uPraMKEwxxWQ==
X-Google-Smtp-Source: ABdhPJxh1/q2d1pqjLxnwSw/oeu01wePjZhW44Nj0RscaCTraYBGG8xCa+l9qVqa4ytenYMtBEopBQ==
X-Received: by 2002:adf:90f0:: with SMTP id i103mr5246243wri.318.1617217798449;
        Wed, 31 Mar 2021 12:09:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/18] tree-walk.h users: use temporary variable(s) for "mode"
Date:   Wed, 31 Mar 2021 21:09:38 +0200
Message-Id: <patch-10.19-5c0a49c188f-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for an eventual rename of the "mode" field, add
temporary variable(s) in those places where it's used more than once.

This will make those later commits easier to read, since we're only
going to need to modify the line on which the assignment happens.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-tree.c | 12 +++++++++---
 match-trees.c        | 13 +++++++------
 merge-ort.c          |  5 +++--
 notes.c              |  3 ++-
 tree-diff.c          | 13 ++++++++-----
 unpack-trees.c       |  3 ++-
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index de8520778d2..c03353b5457 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -190,14 +190,17 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 {
 	struct merge_list *orig, *final;
 	const char *path;
+	unsigned int orig_mode, final_mode;
 
 	/* If it's already ours, don't bother showing it */
 	if (!ours)
 		return;
 
 	path = traverse_path(info, result);
-	orig = create_entry(2, ours->mode, &ours->oid, path);
-	final = create_entry(0, result->mode, &result->oid, path);
+	orig_mode = ours->mode;
+	orig = create_entry(2, orig_mode, &ours->oid, path);
+	final_mode = result->mode;
+	final = create_entry(0, final_mode, &result->oid, path);
 
 	final->link = orig;
 
@@ -241,6 +244,7 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 {
 	const char *path;
 	struct merge_list *link;
+	unsigned int link_mode;
 
 	if (!n->mode)
 		return entry;
@@ -248,7 +252,9 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 		path = entry->path;
 	else
 		path = traverse_path(info, n);
-	link = create_entry(stage, n->mode, &n->oid, path);
+	link_mode = n->mode;
+	link = create_entry(stage, link_mode, &n->oid, path);
+
 	link->link = entry;
 	return link;
 }
diff --git a/match-trees.c b/match-trees.c
index 4ad0ca18256..a6796de442d 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -86,6 +86,8 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 
 	for (;;) {
 		int cmp;
+		unsigned int one_mode = one.entry.mode;
+		unsigned int two_mode = two.entry.mode;
 
 		if (one.size && two.size)
 			cmp = base_name_entries_compare(&one.entry, &two.entry);
@@ -100,22 +102,21 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 
 		if (cmp < 0) {
 			/* path1 does not appear in two */
-			score += score_missing(one.entry.mode);
+			score += score_missing(one_mode);
 			update_tree_entry(&one);
 		} else if (cmp > 0) {
 			/* path2 does not appear in one */
-			score += score_missing(two.entry.mode);
+			score += score_missing(two_mode);
 			update_tree_entry(&two);
 		} else {
+
 			/* path appears in both */
 			if (!oideq(&one.entry.oid, &two.entry.oid)) {
 				/* they are different */
-				score += score_differs(one.entry.mode,
-						       two.entry.mode);
+				score += score_differs(one_mode, two_mode);
 			} else {
 				/* same subtree or blob */
-				score += score_matches(one.entry.mode,
-						       two.entry.mode);
+				score += score_matches(one_mode, two_mode);
 			}
 			update_tree_entry(&one);
 			update_tree_entry(&two);
diff --git a/merge-ort.c b/merge-ort.c
index 97b8670c0a5..de565a1f12e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -538,11 +538,12 @@ static void add_pair(struct merge_options *opt,
 	struct diff_filespec *one, *two;
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
+	const struct object_id *oid = &names[names_idx].oid;
+	unsigned int mode = names[names_idx].mode;
 
 	one = alloc_filespec(pathname);
 	two = alloc_filespec(pathname);
-	fill_filespec(is_add ? two : one,
-		      &names[names_idx].oid, 1, names[names_idx].mode);
+	fill_filespec(is_add ? two : one, oid, 1, mode);
 	diff_queue(&renames->pairs[side], one, two);
 }
 
diff --git a/notes.c b/notes.c
index e2fec12a39e..00aa7d4115a 100644
--- a/notes.c
+++ b/notes.c
@@ -478,6 +478,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			struct strbuf non_note_path = STRBUF_INIT;
 			const char *q = oid_to_hex(&subtree->key_oid);
 			size_t i;
+			unsigned int mode = entry.mode;
 			for (i = 0; i < prefix_len; i++) {
 				strbuf_addch(&non_note_path, *q++);
 				strbuf_addch(&non_note_path, *q++);
@@ -485,7 +486,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			}
 			strbuf_add(&non_note_path, entry.path, path_len);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
-				     entry.mode, entry.oid.hash);
+				     mode, entry.oid.hash);
 		}
 	}
 	free(buf);
diff --git a/tree-diff.c b/tree-diff.c
index 644b4656421..b7a76cc2620 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -466,17 +466,19 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		tp[0].entry.mode &= ~S_IFXMIN_NEQ;
 
 		for (i = 1; i < nparent; ++i) {
+			unsigned int mode = tp[i].entry.mode;
 			cmp = tree_entry_pathcmp(&tp[i], &tp[imin]);
 			if (cmp < 0) {
 				imin = i;
-				tp[i].entry.mode &= ~S_IFXMIN_NEQ;
+				mode &= ~S_IFXMIN_NEQ;
 			}
 			else if (cmp == 0) {
-				tp[i].entry.mode &= ~S_IFXMIN_NEQ;
+				mode &= ~S_IFXMIN_NEQ;
 			}
 			else {
-				tp[i].entry.mode |= S_IFXMIN_NEQ;
+				mode |= S_IFXMIN_NEQ;
 			}
+			tp[i].entry.mode = mode;
 		}
 
 		/* fixup markings for entries before imin */
@@ -493,13 +495,14 @@ static struct combine_diff_path *ll_diff_tree_paths(
 			/* are either pi > p[imin] or diff(t,pi) != ø ? */
 			if (!opt->flags.find_copies_harder) {
 				for (i = 0; i < nparent; ++i) {
+					unsigned int mode = tp[i].entry.mode;
 					/* p[i] > p[imin] */
-					if (tp[i].entry.mode & S_IFXMIN_NEQ)
+					if (mode & S_IFXMIN_NEQ)
 						continue;
 
 					/* diff(t,pi) != ø */
 					if (!oideq(&t.entry.oid, &tp[i].entry.oid) ||
-					    (t.entry.mode != tp[i].entry.mode))
+					    (t.entry.mode != mode))
 						continue;
 
 					goto skip_emit_t_tp;
diff --git a/unpack-trees.c b/unpack-trees.c
index 23c1640ae9a..e804c7919b7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1023,8 +1023,9 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 		is_transient ?
 		make_empty_transient_cache_entry(len) :
 		make_empty_cache_entry(istate, len);
+	unsigned int mode = n->mode;
 
-	ce->ce_mode = create_ce_mode(n->mode);
+	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
 	oidcpy(&ce->oid, &n->oid);
-- 
2.31.1.474.g72d45d12706

