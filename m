Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55781F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfGZPxS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36385 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbfGZPxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so24930965plt.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBNLQrgmljLmHLDoIaW4cusFjH9sy+B2r4+GPhhLV9Q=;
        b=kkZ5Xk5KUOW6dO5AkYFB7zqEKye9h0+TaRCIf3Y19dFdb/8PJka9wcvPXCOE6MJAMu
         iolNh58+oeaZEIA62KmsuNOC50yZg20ubxiZD1FM6qnQ8fKDsmCoXBk06yLgQtWAXwZK
         iM1dn9c+y8C0kNecuehaMItvc1JcLKEe3onVw+d6g0sJ70mm59fABKttLD789SYvamZj
         lfBwTc65HIgCP9hDU5fXxvdwrqrsDYvHHYf55FVn3me62dKXN1otR3CTt8u+tLtxRpZC
         7nJBNK9JS5DrnPZfxwp4FSb8iKtDORAkH7CsbtrzHE4P6z8LUQrRBlrqM4DIvrYwD6t1
         gkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBNLQrgmljLmHLDoIaW4cusFjH9sy+B2r4+GPhhLV9Q=;
        b=Mv9B4BOOlFZE/ceKz56iSflOP6zX7oWW6PO4D0SF9VuOMBPYJ+L1gPF/69OZkWCk6P
         OUEAr2DnIdL2p0ZafcbLHX3KcDtUO7rKLzw9b016Asd3B6GLknD0UoqJ9pBvCCPEiGgt
         kJJRxvqPkFivJSmWonctEqdtshzd0skBJDP3AqfgYjqGgRk4/SBt4jPtmMGXsxd3zS1b
         bj7HYzfxUT2gz7AYYZfUdctAfEz94cj2+qqxkZSxoETw/WJ4911rHY1zJIjXk1yenywx
         X66IvmQy6zseLwcgNz+/NatWwsK41QEdKeV0+7g53bGVUjxKZMQ0deKPVY91WAZYb8hB
         9DYw==
X-Gm-Message-State: APjAAAUAjq3L5VDchwH3Zi9mZY5zBfdcjl8Mn1OovyNioK0Idz6dKjsq
        QwmSYC1vX0eRYBydfHr3CGalaKyM
X-Google-Smtp-Source: APXvYqxydo2AbNVXV+OMmGY6g0JmGBWRiEfAQOet7LdeWFOtvSPjpWPpEK6O7V+x2h+heUaDEMqvbg==
X-Received: by 2002:a17:902:ff10:: with SMTP id f16mr2629057plj.141.1564156394608;
        Fri, 26 Jul 2019 08:53:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 09/20] merge-recursive: use common name for ancestors/common/base_list
Date:   Fri, 26 Jul 2019 08:52:47 -0700
Message-Id: <20190726155258.28561-10-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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
 merge-recursive.c | 68 ++++++++++++++++++++++++-----------------------
 merge-recursive.h | 14 +++++-----
 2 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e81dec8f1f..8114e77b98 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3356,24 +3356,26 @@ static int process_entry(struct merge_options *opt,
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
@@ -3401,7 +3403,7 @@ static int merge_trees_internal(struct merge_options *opt,
 		get_files_dirs(opt, merge);
 
 		entries = get_unmerged(opt->repo->index);
-		clean = detect_and_process_renames(opt, common, head, merge,
+		clean = detect_and_process_renames(opt, merge_base, head, merge,
 						   entries, &re_info);
 		record_df_conflict_files(opt, entries);
 		if (clean < 0)
@@ -3475,11 +3477,11 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
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
 
@@ -3489,31 +3491,31 @@ static int merge_recursive_internal(struct merge_options *opt,
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
 	}
 
-	for (iter = ca; iter; iter = iter->next) {
+	for (iter = merge_bases; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
 		opt->call_depth++;
 		/*
@@ -3529,14 +3531,14 @@ static int merge_recursive_internal(struct merge_options *opt,
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
 
@@ -3549,7 +3551,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h1),
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
-							  merged_common_ancestors),
+							  merged_merge_bases),
 				     &mrtree);
 	if (clean < 0) {
 		flush_output(opt);
@@ -3593,14 +3595,14 @@ static void merge_finalize(struct merge_options *opt)
 int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common)
+		struct tree *merge_base)
 {
 	int clean;
 	struct tree *ignored;
 
 	if (merge_start(opt, head))
 		return -1;
-	clean = merge_trees_internal(opt, head, merge, common, &ignored);
+	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
 	merge_finalize(opt);
 
 	return clean;
@@ -3609,14 +3611,14 @@ int merge_trees(struct merge_options *opt,
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *ca,
+		    struct commit_list *merge_bases,
 		    struct commit **result)
 {
 	int clean;
 
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
-	clean = merge_recursive_internal(opt, h1, h2, ca, result);
+	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
 	merge_finalize(opt);
 
 	return clean;
@@ -3644,8 +3646,8 @@ static struct commit *get_ref(struct repository *repo,
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
@@ -3654,14 +3656,14 @@ int merge_recursive_generic(struct merge_options *opt,
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
index b3394502c7..c7ba8d0a71 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -77,14 +77,14 @@ static inline int merge_detect_rename(struct merge_options *o)
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
@@ -94,7 +94,7 @@ int merge_recursive(struct merge_options *o,
 int merge_trees(struct merge_options *o,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common);
+		struct tree *merge_base);
 
 /*
  * "git-merge-recursive" can be fed trees; wrap them into
@@ -103,8 +103,8 @@ int merge_trees(struct merge_options *o,
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
2.22.0.550.g71c37a0928.dirty

