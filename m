Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80B91F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfHQSmS (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36400 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfHQSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so3835000plo.3
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smKPkZrQK/U2IZRn17MXgKLLKjP2S2i661SIG0zHlM4=;
        b=hQhz0L3l1mi4eaD9mq7jwnWd9xDNoeBESn17DoCRsCNNsBpJdeiA0ALrp/uQcKJJ2F
         utWF7wULkx/B7IriAp4a3TBp64dScVHqsuVKVsXD9l3Pnycyq8ik+m+jZgI/kJ9dxT/4
         w+M5HDBryfM4QBFa6N1RiPoFJ8cQA9+fehAFSQjQTObn9p5vS5yUN9AQRt9i6oZ3nYPz
         yXw9A6rezukl4mUPaBA3h5IrIqCZ0JYOpYKA5qjFvLvk8qubegHnxiCnXMpYZHQjf1yR
         z4K5yR4J37NWn4Hrk98YyMJ8ZLyipomglFwIVemiQeOI96huLrIL2efiSOJ2yrBuiynQ
         Qddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smKPkZrQK/U2IZRn17MXgKLLKjP2S2i661SIG0zHlM4=;
        b=cVkCe5mOeUZ0p24BBoQxOT/EckFcOpVllZL0U36cnnT0Fsbm4T6Y5/QFyGRl8cxByd
         N1xBu68mEUAe4aAxL1m8JbjF/WTmcf3ErgrMTyAiIOSNS9gjQP6qlYSgPhJbwuqXPC4d
         Jlh4/X6JIqaoINwV3vP8wog3prFMZhswGn7OLRvaKZw2RHp7P2UUBnOXQaQWwtmECO1U
         943WMco2t8fUhsmoxBJ15AbdYxYhR7MqTB2onH7L4txT1H1mCKfpWpH9RCILLfOIckW5
         e9bMDZY5doWRX6XRC+GBGp777YHIsxGql/06kCFaxbxRu0gpUCl1iQ2r5jrcrTvpYCNa
         xxLw==
X-Gm-Message-State: APjAAAUZGVL+XwKaKnkvitsN0Xyl21WHyP3QPjPOKslsg/ulo0eYilXP
        rMh2PTL5gQbG9EnDE4K8xarvvjGZ
X-Google-Smtp-Source: APXvYqxLzL5AAPhSGlEHB7FlsT969UsHmR1qmXO5qZpGGwWfglDRky8TNelGJ0n493U1Hm2g0ZVkqw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr14947629plz.191.1566067334153;
        Sat, 17 Aug 2019 11:42:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 14/24] merge-recursive: use common name for ancestors/common/base_list
Date:   Sat, 17 Aug 2019 11:41:34 -0700
Message-Id: <20190817184144.32179-15-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_trees(), merge_recursive(), and merge_recursive_generic() in
their function headers used four different names for the merge base or
list of merge bases they were passed:
  * 'common'
  * 'ancestors'
  * 'ca'
  * 'base_list'
They were able to refer to it four different ways instead of only three
by using a different name in the signature for the .c file than the .h
file.  Change all of these to 'merge_base' or 'merge_bases'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 72 ++++++++++++++++++++++++-----------------------
 merge-recursive.h | 14 ++++-----
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 720678c21d..32871132a6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3357,24 +3357,26 @@ static int process_entry(struct merge_options *opt,
 static int merge_trees_internal(struct merge_options *opt,
 				struct tree *head,
 				struct tree *merge,
-				struct tree *common,
+				struct tree *merge_base,
 				struct tree **result)
 {
 	struct index_state *istate = opt->repo->index;
 	int code, clean;
 
 	if (opt->subtree_shift) {
-		merge = shift_tree_object(opt->repo, head, merge, opt->subtree_shift);
-		common = shift_tree_object(opt->repo, head, common, opt->subtree_shift);
+		merge = shift_tree_object(opt->repo, head, merge,
+					  opt->subtree_shift);
+		merge_base = shift_tree_object(opt->repo, head, merge_base,
+					       opt->subtree_shift);
 	}
 
-	if (oid_eq(&common->object.oid, &merge->object.oid)) {
+	if (oid_eq(&merge_base->object.oid, &merge->object.oid)) {
 		output(opt, 0, _("Already up to date!"));
 		*result = head;
 		return 1;
 	}
 
-	code = unpack_trees_start(opt, common, head, merge);
+	code = unpack_trees_start(opt, merge_base, head, merge);
 
 	if (code != 0) {
 		if (show(opt, 4) || opt->call_depth)
@@ -3402,7 +3404,7 @@ static int merge_trees_internal(struct merge_options *opt,
 		get_files_dirs(opt, merge);
 
 		entries = get_unmerged(opt->repo->index);
-		clean = detect_and_process_renames(opt, common, head, merge,
+		clean = detect_and_process_renames(opt, merge_base, head, merge,
 						   entries, &re_info);
 		record_df_conflict_files(opt, entries);
 		if (clean < 0)
@@ -3470,11 +3472,11 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
 static int merge_recursive_internal(struct merge_options *opt,
 				    struct commit *h1,
 				    struct commit *h2,
-				    struct commit_list *ca,
+				    struct commit_list *merge_bases,
 				    struct commit **result)
 {
 	struct commit_list *iter;
-	struct commit *merged_common_ancestors;
+	struct commit *merged_merge_bases;
 	struct tree *mrtree;
 	int clean;
 	const char *ancestor_name;
@@ -3486,39 +3488,39 @@ static int merge_recursive_internal(struct merge_options *opt,
 		output_commit_title(opt, h2);
 	}
 
-	if (!ca) {
-		ca = get_merge_bases(h1, h2);
-		ca = reverse_commit_list(ca);
+	if (!merge_bases) {
+		merge_bases = get_merge_bases(h1, h2);
+		merge_bases = reverse_commit_list(merge_bases);
 	}
 
 	if (show(opt, 5)) {
-		unsigned cnt = commit_list_count(ca);
+		unsigned cnt = commit_list_count(merge_bases);
 
 		output(opt, 5, Q_("found %u common ancestor:",
 				"found %u common ancestors:", cnt), cnt);
-		for (iter = ca; iter; iter = iter->next)
+		for (iter = merge_bases; iter; iter = iter->next)
 			output_commit_title(opt, iter->item);
 	}
 
-	merged_common_ancestors = pop_commit(&ca);
-	if (merged_common_ancestors == NULL) {
+	merged_merge_bases = pop_commit(&merge_bases);
+	if (merged_merge_bases == NULL) {
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
 		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(opt->repo,
-							      tree, "ancestor");
+		merged_merge_bases = make_virtual_commit(opt->repo, tree,
+							 "ancestor");
 		ancestor_name = "empty tree";
-	} else if (ca) {
+	} else if (merge_bases) {
 		ancestor_name = "merged common ancestors";
 	} else {
 		strbuf_add_unique_abbrev(&merge_base_abbrev,
-					 &merged_common_ancestors->object.oid,
+					 &merged_merge_bases->object.oid,
 					 DEFAULT_ABBREV);
 		ancestor_name = merge_base_abbrev.buf;
 	}
 
-	for (iter = ca; iter; iter = iter->next) {
+	for (iter = merge_bases; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
 		opt->call_depth++;
 		/*
@@ -3534,14 +3536,14 @@ static int merge_recursive_internal(struct merge_options *opt,
 		saved_b2 = opt->branch2;
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
-		if (merge_recursive_internal(opt, merged_common_ancestors, iter->item,
-				    NULL, &merged_common_ancestors) < 0)
+		if (merge_recursive_internal(opt, merged_merge_bases, iter->item,
+					     NULL, &merged_merge_bases) < 0)
 			return -1;
 		opt->branch1 = saved_b1;
 		opt->branch2 = saved_b2;
 		opt->call_depth--;
 
-		if (!merged_common_ancestors)
+		if (!merged_merge_bases)
 			return err(opt, _("merge returned no commit"));
 	}
 
@@ -3554,7 +3556,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h1),
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
-							  merged_common_ancestors),
+							  merged_merge_bases),
 				     &mrtree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
@@ -3597,7 +3599,7 @@ static void merge_finalize(struct merge_options *opt)
 int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common)
+		struct tree *merge_base)
 {
 	int clean;
 	struct tree *ignored;
@@ -3606,7 +3608,7 @@ int merge_trees(struct merge_options *opt,
 
 	if (merge_start(opt, head))
 		return -1;
-	clean = merge_trees_internal(opt, head, merge, common, &ignored);
+	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
 	merge_finalize(opt);
 
 	return clean;
@@ -3615,7 +3617,7 @@ int merge_trees(struct merge_options *opt,
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *ca,
+		    struct commit_list *merge_bases,
 		    struct commit **result)
 {
 	int clean;
@@ -3624,7 +3626,7 @@ int merge_recursive(struct merge_options *opt,
 
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
-	clean = merge_recursive_internal(opt, h1, h2, ca, result);
+	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
 	merge_finalize(opt);
 
 	return clean;
@@ -3652,8 +3654,8 @@ static struct commit *get_ref(struct repository *repo,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_base_list,
-			    const struct object_id **base_list,
+			    int num_merge_bases,
+			    const struct object_id **merge_bases,
 			    struct commit **result)
 {
 	int clean;
@@ -3662,14 +3664,14 @@ int merge_recursive_generic(struct merge_options *opt,
 	struct commit *next_commit = get_ref(opt->repo, merge, opt->branch2);
 	struct commit_list *ca = NULL;
 
-	if (base_list) {
+	if (merge_bases) {
 		int i;
-		for (i = 0; i < num_base_list; ++i) {
+		for (i = 0; i < num_merge_bases; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(opt->repo, base_list[i],
-					     oid_to_hex(base_list[i]))))
+			if (!(base = get_ref(opt->repo, merge_bases[i],
+					     oid_to_hex(merge_bases[i]))))
 				return err(opt, _("Could not parse object '%s'"),
-					   oid_to_hex(base_list[i]));
+					   oid_to_hex(merge_bases[i]));
 			commit_list_insert(base, &ca);
 		}
 	}
diff --git a/merge-recursive.h b/merge-recursive.h
index 0a3033bdb0..6f351098a5 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -81,14 +81,14 @@ static inline int merge_detect_rename(struct merge_options *o)
  *
  * NOTE: empirically, about a decade ago it was determined that with more
  *       than two merge bases, optimal behavior was found when the
- *       ancestors were passed in the order of oldest merge base to newest
- *       one.  Also, ancestors will be consumed (emptied) so make a copy if
- *       you need it.
+ *       merge_bases were passed in the order of oldest commit to newest
+ *       commit.  Also, merge_bases will be consumed (emptied) so make a
+ *       copy if you need it.
  */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *ancestors,
+		    struct commit_list *merge_bases,
 		    struct commit **result);
 
 /*
@@ -98,7 +98,7 @@ int merge_recursive(struct merge_options *o,
 int merge_trees(struct merge_options *o,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common);
+		struct tree *merge_base);
 
 /*
  * "git-merge-recursive" can be fed trees; wrap them into
@@ -107,8 +107,8 @@ int merge_trees(struct merge_options *o,
 int merge_recursive_generic(struct merge_options *o,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_ca,
-			    const struct object_id **ca,
+			    int num_merge_bases,
+			    const struct object_id **merge_bases,
 			    struct commit **result);
 
 void init_merge_options(struct merge_options *o,
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

