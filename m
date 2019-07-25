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
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E3E1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbfGYRq2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:28 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43448 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403800AbfGYRq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:26 -0400
Received: by mail-pg1-f181.google.com with SMTP id f25so23385759pgv.10
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gNNe4uOsRze3PLD/Q4oPQvnYcIYOkVgCL6N//EfhBo=;
        b=I9NMc80xvJBB8wij6SmbDkuZ17lgr5NhruEQzDmYzzCCdyPYCBiHj8FZv9uLYC4eT9
         R4BhX2ezN/fJgV/h7JcaqU4I2Ec09WtS5ULg+oiGZth571FhHEHhFwWfmFM7w0Km8x69
         h3q5UJXlH+5/ZBiNGuFrc2Gv34MT3dMJyfQMFtWEWW9Fk5ufLpFHl7mePCUriDl777mP
         vMcetv32+7hvlaQqho07s+DLZmWXc+4AiSl2zkr3AL4E0tP9OvLRrlX6m+Tc4uTauCZQ
         T3k5vstUrmU6LDsV6RFpA9DLOySd+KFgSR6UWAvPLa1Kcl1mB/CzHxag7E6hQhLN99iy
         4WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gNNe4uOsRze3PLD/Q4oPQvnYcIYOkVgCL6N//EfhBo=;
        b=H6MbJeJC14hhEJQ9zD9wX0XfV0LA0UHS5taJkZTAH2XA+Q+YL2heUHuaoAQaULFvHf
         5fiRvN2wysDR6Y8J+ICSCLm8VnuNRXqWc+f055Zt1zBT2VpNzInHQ7GB4QV5AFCMpTl5
         HK7sSOqNK68GebF91kZBS8yZF+MF9RfH268iy+fE6MGrMAk8xM8E/PJiWlZVWjNUUjqg
         P1YWX00OsV9em+k3ZbhuvuG+g6V1V8qRIc7mnEFBGmBggrYpScGUnZLzDw3WN5IC2ASY
         vsdWmKRu4x+24MSlIxfrcYjvntVISUf0+pGjkOCIA0O0xkbMKt+QXSt8D+pzd9CJf4Ph
         yxMA==
X-Gm-Message-State: APjAAAV64ztvObUZm2osrAxGmZmn23ctGCVvt+NNVeO62J75RK822198
        VoC6mwcbk+0SSHaPWcxrlDyw/lYv
X-Google-Smtp-Source: APXvYqwa5/FY8bf3NbIBFuVAU+M9Lwmn4i1wuDXSBSOiPnRTJFmF81thb8jkcjdufwPZ3S5zFii9vw==
X-Received: by 2002:a63:181:: with SMTP id 123mr89479232pgb.63.1564076785670;
        Thu, 25 Jul 2019 10:46:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 09/19] merge-recursive: use common name for ancestors/common/base_list
Date:   Thu, 25 Jul 2019 10:46:01 -0700
Message-Id: <20190725174611.14802-10-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
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
 merge-recursive.h |  8 +++---
 2 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 104c70b787..0a90546824 100644
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
@@ -3468,11 +3470,11 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
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
 
@@ -3482,31 +3484,31 @@ static int merge_recursive_internal(struct merge_options *opt,
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
@@ -3522,14 +3524,14 @@ static int merge_recursive_internal(struct merge_options *opt,
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
 
@@ -3542,7 +3544,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h1),
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
-							  merged_common_ancestors),
+							  merged_merge_bases),
 				     &mrtree);
 	if (clean < 0) {
 		flush_output(opt);
@@ -3585,14 +3587,14 @@ static void merge_finalize(struct merge_options *opt)
 int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common,
+		struct tree *merge_base,
 		struct tree **result)
 {
 	int ret;
 
 	if (merge_start(opt, head))
 		return -1;
-	ret = merge_trees_internal(opt, head, merge, common, result);
+	ret = merge_trees_internal(opt, head, merge, merge_base, result);
 	merge_finalize(opt);
 
 	return ret;
@@ -3601,14 +3603,14 @@ int merge_trees(struct merge_options *opt,
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *ca,
+		    struct commit_list *merge_bases,
 		    struct commit **result)
 {
 	int ret;
 
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
-	ret = merge_recursive_internal(opt, h1, h2, ca, result);
+	ret = merge_recursive_internal(opt, h1, h2, merge_bases, result);
 	merge_finalize(opt);
 
 	return ret;
@@ -3636,8 +3638,8 @@ static struct commit *get_ref(struct repository *repo,
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
@@ -3646,14 +3648,14 @@ int merge_recursive_generic(struct merge_options *opt,
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
index 973f2729a8..a96c8ad50f 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -74,14 +74,14 @@ static inline int merge_detect_rename(struct merge_options *o)
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *ancestors,
+		    struct commit_list *merge_bases,
 		    struct commit **result);
 
 /* rename-detecting three-way merge, no recursion */
 int merge_trees(struct merge_options *o,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common,
+		struct tree *merge_base,
 		struct tree **result);
 
 /*
@@ -91,8 +91,8 @@ int merge_trees(struct merge_options *o,
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
2.22.0.559.g28a8880890.dirty

