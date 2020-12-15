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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C626C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DF122475
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgLORyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbgLORyN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:54:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C35C06138C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a6so53801wmc.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K60eeE17tUkjsWtqdAkEox/OdZyVAzWWoQ6JTSXG/bU=;
        b=dV+sgtc4b6teQlN2lgEKSAv96ezqsQLhbg059Buqq3GRBO4vTTKZodd7ixjUu70dgr
         EiYhEoB9Feub2ZwtfsfkRTReZBzbnFEBELlcCYId9uWTYtUn3Z2/QB7r3LfdFyZkFA3K
         4fGgm4OTWSPZIJPqB1IwbdKb/ymPN6W2B/3h8oYoR51BsN/t2UyBQ8ltS7ORCWM+03u6
         qWF7tawSRQe2gGWRIDSB6x00gEvCQc/UrkTKoreLxSPtp/qzppDKKAnzE+l7glked2Wo
         GxtGg1WYm+lTlgnst5oaekG58RvDW2FK4RCcePU50xL0uuU23g6YUTXTEjkd0UlNmxC8
         G9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K60eeE17tUkjsWtqdAkEox/OdZyVAzWWoQ6JTSXG/bU=;
        b=lQwUCMKx5GhrVkosCY21Ygb66soXz7YcIwH20zA+qaT/v3xPBO46xtUle3+D7mOyjY
         NAPjs+HQeLhqIlo8JaIxVzOXfcGCbY6h0i0cu/+O5lGeXBIgJweNAEyN93vXNA0rIaEm
         GMOwxoXWCGKwC5Bzow3sTq3zrE+47Q8pGGKshJZ2loxMNgNYT43qSG+pUNaow8o5W2Gd
         K6uJIkuNuavz6HmgdywqoMRcVQuZ5iGewpF5zGbK7kkf7LDxB2BLThPLJNhskKaY0WUu
         7LlQ6XoqyhbSZjtxdXioQipL4NDls/dhi+IO2EKmIullGC4BuyZzsAeXk2+CJu4tSgKh
         YBMQ==
X-Gm-Message-State: AOAM533fMBB1mP5gtCYEUr63OJ/O6HVS/0iMnZuv5Q7/US0/Qn0gur+L
        E0+wYsKeO6nQyx9cTdFxaVm9ep5wcnc=
X-Google-Smtp-Source: ABdhPJzN/Vnz0duubxJ4d06fZw4Yf2x6NKWsbYun00dKfp8Qirtf4w/8I0h62NVAMA8Rdm/NuA0xiQ==
X-Received: by 2002:a1c:b742:: with SMTP id h63mr44963wmf.122.1608054811006;
        Tue, 15 Dec 2020 09:53:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm37156367wre.24.2020.12.15.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:53:30 -0800 (PST)
Message-Id: <82a773d8972b6641a25b3c84121dd38703a9286c.1608054807.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.git.1608054807.gitgitgadget@gmail.com>
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 17:53:27 +0000
Subject: [PATCH 3/3] merge-ort: implement merge_incore_recursive()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
 merge-ort.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 10a97e944c4..65f7ce2b223 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1476,6 +1476,90 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
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
@@ -1493,7 +1577,9 @@ void merge_incore_recursive(struct merge_options *opt,
 			    struct commit *side2,
 			    struct merge_result *result)
 {
-	(void)reverse_commit_list;
-	(void)make_virtual_commit;
-	die("Not yet implemented");
+	assert(opt->ancestor == NULL ||
+	       !strcmp(opt->ancestor, "constructed merge base"));
+
+	merge_start(opt, result);
+	merge_ort_internal(opt, merge_bases, side1, side2, result);
 }
-- 
gitgitgadget
