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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6131F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfHOVlc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbfHOVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id n4so1884729pgv.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Bo6zTkt3J1HiQISzltWFsJXL8x4MbBsF4NhgpyS4a0=;
        b=hswoaxzsT78ZvfcNlyug645ywmGcu+lUD84Pcj6OMlZmRjsJrDJFVJcvjNZ4O+MT6K
         FfhcSm3rQzljFMR7CYQTLleXgUEa1NdIkp03oR4Z4HWRWiDvZTMJzp2UIY9KqB74WaYK
         94rp/44es0jFnbF33WFgM2N5/ZmSAwMIhNl+BgAKYjvE1YRDPovVVQVVvFU8dmfQhZ64
         SA4EWo/Au1pm1ppjW41WT3KTP6BvPWzDvesxIsuLdYMZhthD8c8ZtjiOvab2YF1SLoTX
         oHhy1aoQHAYpVMDQWk3rAALw6T8q+AaFSeW+FBTz86c3IR8yH+keVoV+CyOtqN4QJUDs
         aRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Bo6zTkt3J1HiQISzltWFsJXL8x4MbBsF4NhgpyS4a0=;
        b=h7+kdco0eDoFNwd7haFUtmm5zx1neZ8xQjUmRJ+qQNwSPOHEDzj2RfzCKwztGYdMGg
         zH49MAsKWA81pzz2WqjufUSg+JJvyAjXTJ4JKjzKpzJprd4sxYxmaY9UL2wKDWbTTBIC
         srN6fryMUQCvKu+jYMkOsBlTyo13itt61TTqlIh5QUrBS927O0DWxfORTRiH2EPV4xSs
         h3zkg2SRmtxzIU9elOLvnBdDSpNXvsMisg7NMybwoeNFmyfsbUXV8P9UmOFkt4tZmgNf
         wiaTSaUjpkGlkqVOhiei9LGuK7GlbFhmgH4wPKdcE5ndu72u2/c14xHnLjxOX68uLwup
         FJRw==
X-Gm-Message-State: APjAAAXQeBIP3pTXda7E0YOgRXMSv2c/qnVl9XMtYOCNvxoCeXFuKGn3
        dHgp7lQoIqtcf97c2jH0d2UrL80/
X-Google-Smtp-Source: APXvYqxkdoNkXTrH+av1I3ByD6/ztWnFlTwDL5LvNrhUjPbpMu562qr3okwGqnPqyHI4JJxc87S2lQ==
X-Received: by 2002:a62:1ad4:: with SMTP id a203mr7330642pfa.210.1565905288580;
        Thu, 15 Aug 2019 14:41:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 14/24] merge-recursive: use common name for ancestors/common/base_list
Date:   Thu, 15 Aug 2019 14:40:43 -0700
Message-Id: <20190815214053.16594-15-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index 40f2c6ad55..d0153ba971 100644
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
 	int num_merge_bases;
@@ -3486,32 +3488,32 @@ static int merge_recursive_internal(struct merge_options *opt,
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
 
-	num_merge_bases = commit_list_count(ca);
-	merged_common_ancestors = pop_commit(&ca);
-	if (merged_common_ancestors == NULL) {
+	num_merge_bases = commit_list_count(merge_bases);
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
@@ -3527,14 +3529,14 @@ static int merge_recursive_internal(struct merge_options *opt,
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
 
@@ -3548,7 +3550,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 		break;
 	case 1:
 		strbuf_add_unique_abbrev(&merge_base_abbrev,
-					 &merged_common_ancestors->object.oid,
+					 &merged_merge_bases->object.oid,
 					 DEFAULT_ABBREV);
 		opt->ancestor = merge_base_abbrev.buf;
 		break;
@@ -3559,7 +3561,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h1),
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
-							  merged_common_ancestors),
+							  merged_merge_bases),
 				     &mrtree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
@@ -3602,7 +3604,7 @@ static void merge_finalize(struct merge_options *opt)
 int merge_trees(struct merge_options *opt,
 		struct tree *head,
 		struct tree *merge,
-		struct tree *common)
+		struct tree *merge_base)
 {
 	int clean;
 	struct tree *ignored;
@@ -3611,7 +3613,7 @@ int merge_trees(struct merge_options *opt,
 
 	if (merge_start(opt, head))
 		return -1;
-	clean = merge_trees_internal(opt, head, merge, common, &ignored);
+	clean = merge_trees_internal(opt, head, merge, merge_base, &ignored);
 	merge_finalize(opt);
 
 	return clean;
@@ -3620,7 +3622,7 @@ int merge_trees(struct merge_options *opt,
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *ca,
+		    struct commit_list *merge_bases,
 		    struct commit **result)
 {
 	int clean;
@@ -3629,7 +3631,7 @@ int merge_recursive(struct merge_options *opt,
 
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
-	clean = merge_recursive_internal(opt, h1, h2, ca, result);
+	clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
 	merge_finalize(opt);
 
 	return clean;
@@ -3657,8 +3659,8 @@ static struct commit *get_ref(struct repository *repo,
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
@@ -3667,14 +3669,14 @@ int merge_recursive_generic(struct merge_options *opt,
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
2.23.0.rc2.32.g2123e9e4e4

