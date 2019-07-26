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
	by dcvr.yhbt.net (Postfix) with ESMTP id 417731F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfGZPxM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfGZPxL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so18754611pgc.1
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRBC4jeovfP/by6OUKLTEmYT5x28WX0DGW0cYJwYbZo=;
        b=T2ZwZSb1QOusvptFo4Y0/e+FbhNLOMJofoUuBYwZ+WvcLvt4d3lgjpOW2KsHSgSDhM
         4GfZHXqIh2YLbkpfud30rlefrVCSznOQtkPemcYV4d+tCJ5x6FgTDpxkh2O0qzKgU3w1
         Qzv3+h8+omM/a2tozk/iMl9uQft+ok1p0qn4yheRqb9tvNbSyfc02No57TKewb/6VTNQ
         AReT/naM7L7J3Fgal/nJAoqxXLmdOH35KOCDJjqc2ENhIOIKH8HuMBoz4f/lLDn33PGQ
         99HmdoayZPNJNaiM1LhMSzITuCNqBTwC7JctkgqwT8MTYB14+hZ0bl12zMEhfyOdR++9
         iKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRBC4jeovfP/by6OUKLTEmYT5x28WX0DGW0cYJwYbZo=;
        b=AC1tf1JUMK9XNgS5XiBGAHDTUMLiIWC7cMZMx+xJ/A43Vq7nSkUsEvkuU+rPbRVWXZ
         sAzigW5FtmHkbxMIjhiK0FeMBIm0Zw2uxtojaaIfH82YJiWASinrZb+sCHx21dC1hMat
         i4d2v0QfHRkIaH+jFuCajCq+iFWv4KOfbGWd0Y3eGcPtQOY6Uxrmpzfmh7ajll1jge6e
         FdfMhl7iVsj3Z1xk7N11XW8lBhM2T3EqyEA/D7xCtNyCuP0y4YaqUHnuTRvSe5OOZN+Q
         iwJUBex6tovw2A1EucC7qzSeu26fZd0ZQ7BoPAmJnYsCOz3jFyPl6xVoCPXbtYfi9o4h
         3bDg==
X-Gm-Message-State: APjAAAUU8ePY92xnnJ5pzJzadPUzlEoh2wY7LL3ea5a3PxIqwKFSojvB
        c+/KESrgMJdkfqoLiaMRg+YnYFx9
X-Google-Smtp-Source: APXvYqwYR5RM+0lUSoaqwNAv1sQ5BKujTNzgLvzQPEdCtnz+w2nhF4Vkg7/0IoUMZhUJcEhzrvvz4g==
X-Received: by 2002:a63:d90f:: with SMTP id r15mr72004559pgg.259.1564156389349;
        Fri, 26 Jul 2019 08:53:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 04/20] merge-recursive: exit early if index != head
Date:   Fri, 26 Jul 2019 08:52:42 -0700
Message-Id: <20190726155258.28561-5-newren@gmail.com>
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
 merge-recursive.c | 94 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 37bb94fb4d..f5cf21e2e0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3381,21 +3381,14 @@ static int process_entry(struct merge_options *opt,
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
-	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) {
-		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
-		    sb.buf);
-		return -1;
-	}
 
 	if (opt->subtree_shift) {
 		merge = shift_tree_object(opt->repo, head, merge, opt->subtree_shift);
@@ -3499,11 +3492,11 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
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
@@ -3555,7 +3548,7 @@ int merge_recursive(struct merge_options *opt,
 		saved_b2 = opt->branch2;
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
-		if (merge_recursive(opt, merged_common_ancestors, iter->item,
+		if (merge_recursive_internal(opt, merged_common_ancestors, iter->item,
 				    NULL, &merged_common_ancestors) < 0)
 			return -1;
 		opt->branch1 = saved_b1;
@@ -3571,12 +3564,12 @@ int merge_recursive(struct merge_options *opt,
 		repo_read_index(opt->repo);
 
 	opt->ancestor = "merged common ancestors";
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
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
@@ -3596,6 +3589,59 @@ int merge_recursive(struct merge_options *opt,
 	return clean;
 }
 
+static int merge_start(struct merge_options *opt, struct tree *head)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	assert(opt->branch1 && opt->branch2);
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
2.22.0.550.g71c37a0928.dirty

