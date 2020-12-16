Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4FC2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E28233A0
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgLPUgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgLPUgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:36:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBBCC0617A7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a6so3580806wmc.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sgTt114+QKmF+KWN0MjKspJChMGtHfyEudchrFurSoM=;
        b=gq1qCcsbR4bk3Wvb/+BWwWJ2NUrm2c49TS7BYEVlIwxOqpe7eazLsxKLvVwYBHkdyk
         3/wEnJYCeiAstslBrpKD9x7uw9A++qMCryaBlApU7obLstd/kFm4ZE6FRijemjHPn2R8
         XfMM5KGaWED7QrywOihXKFMD8dWwqxTmgXubT5pzdnXYFvuJilHiQkJpqDmpgI7PstYQ
         6au8ZyE73AIGA4YEnuRiXsCfU2o019ObKei5jsX2h0MwlC9plVxWNNSjy+3k8DPBtC4x
         uFxECmPZYkFjyUTMZqjY2IDVpmAhB113JF3XOEWy2yRzfD1+HDsuVCXXZU0jKjpfqVOS
         4PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sgTt114+QKmF+KWN0MjKspJChMGtHfyEudchrFurSoM=;
        b=bP7j5zPkMYkg55PzdANDV4wBwMB+oyzsSH5FcbysLEafB0zdXPHPpbCvq35lkoh/5E
         +rszjwKZuYvyIbW2G4luczrmZY3INcq4LM1mQPRH6kef9zH4HpNYEsIGADBukkLqmLyc
         fX8kxyOLVVlnHjT52LShJbmoS/gYAVleFncOWxvpdeC28dyc1WN0V8VOIvescBdTjxMs
         eZUBEUiY5jJMz0TvI19mk7r0jrcvZA2ThPcWCgjY4HHcqeHG0ebwJj9i4/E0+5kv/Fos
         eav72zgVavNvizYa96zPEF4UwKmBgbI/8+JFdNsdu9gkdhFc29N5ZzMpPNeMVIftbWge
         ui3A==
X-Gm-Message-State: AOAM531ZfmJn8YSNUZVW3+g4FpfMttddtATGlj+MPA7GMK6X/kF+SxDz
        JtDXs7Tq6phX/SWFBU4OOshr0LJvbRY=
X-Google-Smtp-Source: ABdhPJwgjoQEScW/Vzn8VieqcLOc7vgik0+3yg/rEl/haGUBZfHaOBIWfNU02us1yyQBd0CinSCm7g==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4901717wmi.19.1608150923656;
        Wed, 16 Dec 2020 12:35:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm4356781wmb.37.2020.12.16.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:35:23 -0800 (PST)
Message-Id: <f622d6905d010544c335baba2d3a5857c2f6fd05.1608150919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
References: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
        <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 20:35:19 +0000
Subject: [PATCH v4 3/3] merge-ort: implement merge_incore_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement merge_incore_recursive(), mostly through the use of a new
helper function, merge_ort_internal(), which itself is based off
merge_recursive_internal() from merge-recursive.c.

This drops the number of failures in the testsuite when run under
GIT_TEST_MERGE_ALGORITHM=ort from around 1500 to 647.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 merge-ort.h | 10 ++++++
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7679c1d08e2..d6c0cd36f4c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1356,7 +1356,6 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-MAYBE_UNUSED
 static struct commit *make_virtual_commit(struct repository *repo,
 					  struct tree *tree,
 					  const char *comment)
@@ -1369,7 +1368,6 @@ static struct commit *make_virtual_commit(struct repository *repo,
 	return commit;
 }
 
-MAYBE_UNUSED
 static struct commit_list *reverse_commit_list(struct commit_list *list)
 {
 	struct commit_list *previous = NULL, *current, *backup;
@@ -1478,6 +1476,89 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 	}
 }
 
+/*
+ * Originally from merge_recursive_internal(); somewhat adapted, though.
+ */
+static void merge_ort_internal(struct merge_options *opt,
+			       struct commit_list *merge_bases,
+			       struct commit *h1,
+			       struct commit *h2,
+			       struct merge_result *result)
+{
+	struct commit_list *iter;
+	struct commit *merged_merge_bases;
+	const char *ancestor_name;
+	struct strbuf merge_base_abbrev = STRBUF_INIT;
+
+	if (!merge_bases) {
+		merge_bases = get_merge_bases(h1, h2);
+		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
+		merge_bases = reverse_commit_list(merge_bases);
+	}
+
+	merged_merge_bases = pop_commit(&merge_bases);
+	if (merged_merge_bases == NULL) {
+		/* if there is no common ancestor, use an empty tree */
+		struct tree *tree;
+
+		tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
+		merged_merge_bases = make_virtual_commit(opt->repo, tree,
+							 "ancestor");
+		ancestor_name = "empty tree";
+	} else if (merge_bases) {
+		ancestor_name = "merged common ancestors";
+	} else {
+		strbuf_add_unique_abbrev(&merge_base_abbrev,
+					 &merged_merge_bases->object.oid,
+					 DEFAULT_ABBREV);
+		ancestor_name = merge_base_abbrev.buf;
+	}
+
+	for (iter = merge_bases; iter; iter = iter->next) {
+		const char *saved_b1, *saved_b2;
+		struct commit *prev = merged_merge_bases;
+
+		opt->priv->call_depth++;
+		/*
+		 * When the merge fails, the result contains files
+		 * with conflict markers. The cleanness flag is
+		 * ignored (unless indicating an error), it was never
+		 * actually used, as result of merge_trees has always
+		 * overwritten it: the committed "conflicts" were
+		 * already resolved.
+		 */
+		saved_b1 = opt->branch1;
+		saved_b2 = opt->branch2;
+		opt->branch1 = "Temporary merge branch 1";
+		opt->branch2 = "Temporary merge branch 2";
+		merge_ort_internal(opt, NULL, prev, iter->item, result);
+		if (result->clean < 0)
+			return;
+		opt->branch1 = saved_b1;
+		opt->branch2 = saved_b2;
+		opt->priv->call_depth--;
+
+		merged_merge_bases = make_virtual_commit(opt->repo,
+							 result->tree,
+							 "merged tree");
+		commit_list_insert(prev, &merged_merge_bases->parents);
+		commit_list_insert(iter->item,
+				   &merged_merge_bases->parents->next);
+
+		clear_or_reinit_internal_opts(opt->priv, 1);
+	}
+
+	opt->ancestor = ancestor_name;
+	merge_ort_nonrecursive_internal(opt,
+					repo_get_commit_tree(opt->repo,
+							     merged_merge_bases),
+					repo_get_commit_tree(opt->repo, h1),
+					repo_get_commit_tree(opt->repo, h2),
+					result);
+	strbuf_release(&merge_base_abbrev);
+	opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
+}
+
 void merge_incore_nonrecursive(struct merge_options *opt,
 			       struct tree *merge_base,
 			       struct tree *side1,
@@ -1495,5 +1576,9 @@ void merge_incore_recursive(struct merge_options *opt,
 			    struct commit *side2,
 			    struct merge_result *result)
 {
-	die("Not yet implemented");
+	/* We set the ancestor label based on the merge_bases */
+	assert(opt->ancestor == NULL);
+
+	merge_start(opt, result);
+	merge_ort_internal(opt, merge_bases, side1, side2, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index 55ae7ee865d..d53a0a339f3 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -34,6 +34,16 @@ struct merge_result {
 /*
  * rename-detecting three-way merge with recursive ancestor consolidation.
  * working tree and index are untouched.
+ *
+ * merge_bases will be consumed (emptied) so make a copy if you need it.
+ *
+ * NOTE: empirically, the recursive algorithm will perform better if you
+ *       pass the merge_bases in the order of oldest commit to the
+ *       newest[1][2].
+ *
+ *       [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet/
+ *       [2] commit 8918b0c9c2 ("merge-recur: try to merge older merge bases
+ *           first", 2006-08-09)
  */
 void merge_incore_recursive(struct merge_options *opt,
 			    struct commit_list *merge_bases,
-- 
gitgitgadget
