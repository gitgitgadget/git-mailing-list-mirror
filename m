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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB147C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84312339E
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgLPW2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPW2t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:28:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA18C06138C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q18so17161943wrn.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2jckuNhVVGzIfCBthYGJnbNuTlbsPWBF0f2fbvBCqFc=;
        b=Aa6UNgRrgUxt9a9K0aCJ/HOSg/91W36Il/pa4lJsfEA6j1mxENcqZYoo3YhKNWh0YR
         kI4Oi7EIkuX3HfCbPzPzd4fKgQDVljEq9VgqE2+Yj1LYSyXd4duATgpOCkpg+RuLyvFI
         bdRHGkyEDoDCbUB2SmGH5qmY0/CMzV1wry7yB/xe/r+AtfN05EgI1UIADbCGA1mexj/C
         o00uh6wWzEgX+55d4Vx1QE5tS/o/Qb3xWx5+kJUi1x7U61xmP1/JepLYJjwQCygQ8ZiX
         E2qv8oSePm/KlPPKimGGTL6VkLGMDEYpw4aA1ult6iZocXwlCxGwBNY4BrAQ2I6Bj+uE
         1ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2jckuNhVVGzIfCBthYGJnbNuTlbsPWBF0f2fbvBCqFc=;
        b=s/3YzMQdK2RGXi/PcunVX3u47ghBnJnYZQP8B0P8fJQbPXfDXSSbho6Wkee2EZEL74
         JIHkDVvm9RkipGh7+BSoTeM44974OhC3iAG2siP74LA6bkvCHkL6TnLBl8UmyriFDWk/
         m6DhymOlXbLhHt29XwGenuaVfedGCsjHWAdZUFWNbmZQAo+0qMT1W1vV1so3BygTVt/0
         5DFQ7r42tqwIBpOInqZTijD4YN8PW/WjJZQDK1sTuCNitU5CvxzfyKtPuE+2NaVfYTxf
         raEiTWU//aGxGzKHD2w3CTaIeWsT8ZrOwAndqm70F1yTOUdHS6YNHiqpalTldg9/MeL2
         dzLg==
X-Gm-Message-State: AOAM532RdAud+LffzNH+53g+5248J4XP9GVG+RZdO176HPdFRFFvXb0A
        Q/xrmU3xcz2Ziqc9Il2Ii6bdugiSjHk=
X-Google-Smtp-Source: ABdhPJwUAjTZODhszWenX2nrWEUQEmr7drl30NvcmG0dGDbahTYyMdXptEcSvwwwSg59ap3nG8NB0Q==
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr40475574wrv.255.1608157687885;
        Wed, 16 Dec 2020 14:28:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm4532983wmh.29.2020.12.16.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:28:07 -0800 (PST)
Message-Id: <63e30492ccbc6da3b46abc766c98b81ef14996dd.1608157683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
References: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
        <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 22:28:02 +0000
Subject: [PATCH v5 4/4] merge-ort: implement merge_incore_recursive()
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
 merge-ort.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 merge-ort.h | 10 ++++++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index bd237f3472e..31103d21407 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1356,7 +1356,6 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-MAYBE_UNUSED
 static struct commit *make_virtual_commit(struct repository *repo,
 					  struct tree *tree,
 					  const char *comment)
@@ -1466,6 +1465,89 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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
@@ -1483,5 +1565,9 @@ void merge_incore_recursive(struct merge_options *opt,
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
