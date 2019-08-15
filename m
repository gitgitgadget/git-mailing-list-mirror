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
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EEA1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbfHOVlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34439 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbfHOVlY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so2000375pfp.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qiZsaliA013COW9T+AGWqhHf5yAtHGWtoleGBu8HBs=;
        b=U4Z/m39+bqP57Sr91pdAQwGsqSE/oRxUUy23SPEF2q0Yyw3o80+FMRmDh9KQoXZw2N
         92FRccllwNYq2Y2atnhOJgLmgMkHOByn/UDe9stx+uVWL981308lACQq3xoqxg5V+kx7
         ab5T8w2EwCqVKjkNZyI24/z5wEiHXtPwkOUfBy6+pgz5/GbOPP4v5yTK6CLMN5v9qdIL
         PjkZ66cqrkdKE6jErUs7xYV5BT0i4q78h06cYJ4YWBDOOudSlMNrKTPftJdb2YPrsavE
         uMGeii/ojLKGvf6q7Phxa4OlJsec1V6ZZhmTq2fhXGlRkasFXRXgEUpcbovL9ygG+YHQ
         AM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qiZsaliA013COW9T+AGWqhHf5yAtHGWtoleGBu8HBs=;
        b=kU6BZNNfVyNzRvakrftL9BYRz5SU/2KIplaN7K9buKV7QB7masaEtcfCcOrAOMD4Zq
         OjciDQuV4434fkqNnZgKL7dqdNKXG+1se3FClwtfoMSgETtggstZ7nfcTVK/kskJim4y
         fsgujvuOiodx3gktbHLs2dKt4ICKL9aTfGdshk3xCWqO/76rfY8YbQgiv35K/deeVZl5
         0EzH4eONSXlXabVMa7VzA2W8orhgvktDsD/RX8v0rTdjOTpBZZtBfl2x4dPTjFo+X17q
         XJ/sXynXCK9LpVj622Cz/qhLcg1dnQmq8Jm5S+0DG52rN6XAhpWHeeuMNPLQz+ZtyTBi
         c2Iw==
X-Gm-Message-State: APjAAAWSuaxXyV3eAgJZ9Ins61OPHHR5zAuz1vJefe6uyYOkS+gQFWl1
        mbfd3dcngmejnFDktK73HbC2Q7Qn
X-Google-Smtp-Source: APXvYqzGx3sQeJ3SLZCmiUXuz14UTXbYKgy387WGbT15X9+0pRm2IOBKjnkLjKIlrF+2BVHVfLDaCw==
X-Received: by 2002:a63:d34c:: with SMTP id u12mr5152053pgi.114.1565905282997;
        Thu, 15 Aug 2019 14:41:22 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 09/24] merge-recursive: exit early if index != head
Date:   Thu, 15 Aug 2019 14:40:38 -0700
Message-Id: <20190815214053.16594-10-newren@gmail.com>
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

We had a rule to enforce that the index matches head, but it was found
at the beginning of merge_trees() and would only trigger when
opt->call_depth was 0.  Since merge_recursive() doesn't call
merge_trees() until after returning from recursing, this meant that the
check wasn't triggered by merge_recursive() until it had first finished
all the intermediate merges to create virtual merge bases.  That is a
potentially huge amount of computation (and writing of intermediate
merge results into the .git/objects directory) before it errors out and
says, in effect, "Sorry, I can't do any merging because you have some
local changes that would be overwritten."

Further, not enforcing this requirement earlier allowed other bugs (such
as an unintentional unconditional dropping and reloading of the index in
merge_recursive() even when no recursion was necessary), to mask bugs in
other callers (which were fixed in the commit prior to this one).

Make sure we do the index == head check at the beginning of the merge,
and error out immediately if it fails.  While we're at it, fix a small
leak in the show-the-error codepath.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 101 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fb668fc84c..ded2e1bcfb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3382,23 +3382,14 @@ static int process_entry(struct merge_options *opt,
 	return clean_merge;
 }
 
-int merge_trees(struct merge_options *opt,
-		struct tree *head,
-		struct tree *merge,
-		struct tree *common,
-		struct tree **result)
+static int merge_trees_internal(struct merge_options *opt,
+				struct tree *head,
+				struct tree *merge,
+				struct tree *common,
+				struct tree **result)
 {
 	struct index_state *istate = opt->repo->index;
 	int code, clean;
-	struct strbuf sb = STRBUF_INIT;
-
-	assert(opt->ancestor != NULL);
-
-	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) {
-		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
-		    sb.buf);
-		return -1;
-	}
 
 	if (opt->subtree_shift) {
 		merge = shift_tree_object(opt->repo, head, merge, opt->subtree_shift);
@@ -3502,11 +3493,11 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
  */
-int merge_recursive(struct merge_options *opt,
-		    struct commit *h1,
-		    struct commit *h2,
-		    struct commit_list *ca,
-		    struct commit **result)
+static int merge_recursive_internal(struct merge_options *opt,
+				    struct commit *h1,
+				    struct commit *h2,
+				    struct commit_list *ca,
+				    struct commit **result)
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
@@ -3515,9 +3506,6 @@ int merge_recursive(struct merge_options *opt,
 	int num_merge_bases;
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
-	if (!opt->call_depth)
-		assert(opt->ancestor == NULL);
-
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
 		output_commit_title(opt, h1);
@@ -3564,7 +3552,7 @@ int merge_recursive(struct merge_options *opt,
 		saved_b2 = opt->branch2;
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
-		if (merge_recursive(opt, merged_common_ancestors, iter->item,
+		if (merge_recursive_internal(opt, merged_common_ancestors, iter->item,
 				    NULL, &merged_common_ancestors) < 0)
 			return -1;
 		opt->branch1 = saved_b1;
@@ -3592,12 +3580,12 @@ int merge_recursive(struct merge_options *opt,
 	default:
 		opt->ancestor = "merged common ancestors";
 	}
-	clean = merge_trees(opt,
-			    repo_get_commit_tree(opt->repo, h1),
-			    repo_get_commit_tree(opt->repo, h2),
-			    repo_get_commit_tree(opt->repo,
-						 merged_common_ancestors),
-			    &mrtree);
+	clean = merge_trees_internal(opt,
+				     repo_get_commit_tree(opt->repo, h1),
+				     repo_get_commit_tree(opt->repo, h2),
+				     repo_get_commit_tree(opt->repo,
+							  merged_common_ancestors),
+				     &mrtree);
 	strbuf_release(&merge_base_abbrev);
 	if (clean < 0) {
 		flush_output(opt);
@@ -3618,6 +3606,61 @@ int merge_recursive(struct merge_options *opt,
 	return clean;
 }
 
+static int merge_start(struct merge_options *opt, struct tree *head)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (repo_index_has_changes(opt->repo, head, &sb)) {
+		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+		    sb.buf);
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void merge_finalize(struct merge_options *opt)
+{
+	/* Common code for wrapping up merges will be added here later */
+}
+
+int merge_trees(struct merge_options *opt,
+		struct tree *head,
+		struct tree *merge,
+		struct tree *common,
+		struct tree **result)
+{
+	int clean;
+
+	assert(opt->ancestor != NULL);
+
+	if (merge_start(opt, head))
+		return -1;
+	clean = merge_trees_internal(opt, head, merge, common, result);
+	merge_finalize(opt);
+
+	return clean;
+}
+
+int merge_recursive(struct merge_options *opt,
+		    struct commit *h1,
+		    struct commit *h2,
+		    struct commit_list *ca,
+		    struct commit **result)
+{
+	int clean;
+
+	assert(opt->ancestor == NULL);
+
+	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
+		return -1;
+	clean = merge_recursive_internal(opt, h1, h2, ca, result);
+	merge_finalize(opt);
+
+	return clean;
+}
+
 static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
 			      const char *name)
 {
-- 
2.23.0.rc2.32.g2123e9e4e4

