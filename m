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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09802C2BBD4
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B8F233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgLPRSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgLPRSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:18:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F279C0617A7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c5so20283588wrp.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nn9UgILTGX/C+hxA4TygR14BXD/AKUWQcTklkASqVxE=;
        b=j9dz2CoPNHI/x9Ze2MsflfHPPk+CSZ6FEE1C4nzsB/Y+Zzt9HBITRxMBo3UdBq2xyB
         OzRgmvnT/b3Gi/vNO95uPibfDVBNbcPPTsSTzvsEfJdKWF/bzwSxSEGmsSV8NiLpiIdk
         UZJNDrEknaVz924tG3PbrnxwAqOb5ILrQx0UhU6ijeSZd4uvsAzFvYh5sUEPEMVTO3fO
         shR8lrrL1Jv+ZZIBF6iQA+Syk87hbD69iNwVjQnqhZevOw0G6cekZzTuuv3Ca5XrTMbw
         PxJlF0OnMnNR1/+H1WpSND9OglEAOk5IcpbnBlW+ieI3LmAlvjvsDAVxr/cKYtrRoKHc
         3Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nn9UgILTGX/C+hxA4TygR14BXD/AKUWQcTklkASqVxE=;
        b=Tgeaax3ovPkWF8Kk5OipxgOyNg4N/Npp2Z1GNfQtahtTQBga6/M4NKdvbKIxHbaAyV
         RdfHwLsk6c++XaeB5j2tNJkSyQTqUyDCRQVKg3j/3dd24VwvfJwFNF7/I6kIC/2jRnsn
         +zghv5ghgNIevF3TbzcUzb2kd+sPIcWOd2nG/LKkEqKMVF5gWM6fuL4K/V/tPNX2MnoT
         Xa6uRqrfEiqWV6YyoqEUdnl0rJkWzW2dkhjVqYw/ajpL3tfEno6/CEf5c2+25CLcq8gJ
         zquESglHx5xBx4XC5pLQdgcyLlXpflXUTu9ldUZ3wf3Dd+oTlv0eeMblMP/e3aBvVji/
         zSFg==
X-Gm-Message-State: AOAM530jeMYD+ErqPNZL0Nq38J9AIqQZHEbEl8mOYrybjMsdgn3yCXr0
        0FeYVO3ueE8C+r2thvcRxe9sWUIYGo0=
X-Google-Smtp-Source: ABdhPJzmlAj8ts6EWuyrYGnBH+aIBN9lOO3BSjlDBaN+f91esCduX1jiy0zpIJZ+bt5rmHZKfSowyw==
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr8288586wrb.28.1608139038582;
        Wed, 16 Dec 2020 09:17:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n189sm3712221wmf.20.2020.12.16.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:17:18 -0800 (PST)
Message-Id: <59216a155ae4f17b959b646e484dfe4a6038751d.1608139034.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
References: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
        <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 17:17:14 +0000
Subject: [PATCH v3 3/3] merge-ort: implement merge_incore_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 merge-ort.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 merge-ort.h |  10 +++++
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 7679c1d08e2..f01307f2ee0 100644
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
@@ -1478,6 +1476,91 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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
+	} else if (opt->ancestor && !opt->priv->call_depth) {
+		ancestor_name = opt->ancestor;
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
@@ -1495,5 +1578,24 @@ void merge_incore_recursive(struct merge_options *opt,
 			    struct commit *side2,
 			    struct merge_result *result)
 {
-	die("Not yet implemented");
+	/*
+	 * merge_incore_nonrecursive() exists for cases where we always
+	 * know there is a well-defined single merge base.  However,
+	 * despite a similar structure, merge-recursive.c noted that some
+	 * callers preferred to call the recursive logic anyway and still
+	 * set a special name for opt->ancestor that would appear in
+	 * merge.conflictStyle=diff3 output.
+	 *
+	 * git-am was one such example (it wanted to set opt->ancestor to
+	 * "constructed merge base", since it created a fake merge base);
+	 * it called the recursive merge logic through a special
+	 * merge_recursive_generic() wrapper.
+	 *
+	 * Allow the same kind of special case here.
+	 */
+	int num_merge_bases_is_1 = (merge_bases && !merge_bases->next);
+	assert(opt->ancestor == NULL || num_merge_bases_is_1);
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
