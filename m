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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2977C1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbfGYRqX (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35230 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbfGYRqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so23138473pfn.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knoph1IkJdE3ZNh9zCMY2MDvfAPRXQ9Nd0iuymG7ym4=;
        b=ez850tOxrD2HHGUBBMIw2wmhTMREr5WJioCZifYwxk9sw+GWfOv2YY2BcyfRZxPUaT
         Um9StvcETCV7eXKHtXUIRhE4HLxEaV17PnLbLGLFHe5nPnoL+rh0sWOr0pUaB0b0lYhK
         bWGyXIKDUd36wMAHdqT1QIJX87IQD/pfsInGAtodNbEl7937GeXCG8IFenzxT+jUpS1V
         hFNkWKJpgZXvUUo45779tTN4D3/N+QfyHTsSC6fX/3GV5ySGpE8zU71kz5V1CXDnYXag
         BhVC4F5Ks4ZuxazhAzLH3gC3sulU5RFPkIpHOxnQu3hcQDX33KK1zx7ma20aFbU2fEJH
         ALrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knoph1IkJdE3ZNh9zCMY2MDvfAPRXQ9Nd0iuymG7ym4=;
        b=kgWzzGA1CwqyuhUYvbth5ASHPtIpm42QX5mn/2yCCpPQ5Rrj3YMiQVP5eTQ6I8Jlyh
         65oOA4B49fDqSK+xCy8NaUo6bMp52SqSNeHKPTq+X5lS6jMJGyyOb+pTXVu/Isn81eLt
         gRyO2LLSSNeqDUcXe/j/JENzje54lN5u5aZ5VN6WrrqPpHJwbsyA0r7Cfqfc//fKInsy
         CMSsRvx6W0JLwkrigdycGHO0xqqzmXK86Z7M5Sl01Sue0Z3tF8UZiA/FXHRjAyemE29c
         A90QYrRKwzMcOuqF01Q/aGMfeCfIlc90F6wh6T2OQkjcBS3yxcI4qAAhSHho3G46y5lV
         E8Zw==
X-Gm-Message-State: APjAAAWP6dDaa/xLSrdFghSE1OY1NvkltBdEUZEgaGXqOBepsoGTx4LB
        nblVtU+kwW7SfJSNCQlBwty5a7pB
X-Google-Smtp-Source: APXvYqyCZOOZ4KJjf4Z6HXEr8pySutsLaNqXjctNP9sJxmxe/C64vCjexoHr26zFheo9aXy+Qr89sg==
X-Received: by 2002:a62:4d85:: with SMTP id a127mr17892027pfb.148.1564076781058;
        Thu, 25 Jul 2019 10:46:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 04/19] merge-recursive: exit early if index != head
Date:   Thu, 25 Jul 2019 10:45:56 -0700
Message-Id: <20190725174611.14802-5-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
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
and error out immediately if it fails.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 93 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 24 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 37bb94fb4d..b762ecd7bd 100644
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
@@ -3596,6 +3589,58 @@ int merge_recursive(struct merge_options *opt,
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
+	int ret;
+
+	if (merge_start(opt, head))
+		return -1;
+	ret = merge_trees_internal(opt, head, merge, common, result);
+	merge_finalize(opt);
+
+	return ret;
+}
+
+int merge_recursive(struct merge_options *opt,
+		    struct commit *h1,
+		    struct commit *h2,
+		    struct commit_list *ca,
+		    struct commit **result)
+{
+	int ret;
+
+	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
+		return -1;
+	ret = merge_recursive_internal(opt, h1, h2, ca, result);
+	merge_finalize(opt);
+
+	return ret;
+}
+
 static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
 			      const char *name)
 {
-- 
2.22.0.559.g28a8880890.dirty

