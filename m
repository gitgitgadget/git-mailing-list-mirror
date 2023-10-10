Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790BCD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjJJUdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjJJUd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3017391
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:26 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65b0557ec77so35571036d6.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970005; x=1697574805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2hiQDzvzOH04ATF2Y09DUGzs8UCVCslAIdd4WYxjmYo=;
        b=u4LI34ed9Zcp3HtDYKY1D+1x0NSfOIgCbT9D6ebfHze9RJiVfQrjQ1Kig4VbcwlK9B
         H/dw5aFaNfPfVCtJf75nO3yeRqJl//apIrVI6xyqV17A6aXJ9PzuQzpVLri3Z2ccxJg6
         q/Bi6R1DxAjbJ+oqvPxpMDBEfCCZLSkSHjzZdLNkvrx2jmtS46Yw+jz7w1kiyiylRyPp
         Fs59hFr9DygjjtiMTWHsYa7w1mJHgiYI1ap2ka8tCL8hspkeHFLJ0coUiKaxVk2qw8VH
         fhQGR52nirNl/L2H6mcVqFgWgtyv3KFRTIagDALqNIaYWa/cWQ6O/xjOLBltRO1ghRFP
         qJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970005; x=1697574805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hiQDzvzOH04ATF2Y09DUGzs8UCVCslAIdd4WYxjmYo=;
        b=GC+kntc8NY7tjTjDQ8Fl8hyS1xFB7dtWv8FMxImiE5GewdOiRgcrY5XKL7Ez9FKobb
         /kiCErHQfYimFMrIdyqR50j/jO5DJ+WP1oEh3Vytps/qQabvwI+UjqbYNvHvtSJ/RcyE
         /uUHEc5KMDX7N61VFRWB8thbXofCcqPOzpIHsavi5V33+7lKdRjqH4JVT9rfF8L+aQPA
         UKbjMcR+plvahUTyPShxC2hDFE19MJEiqVOiCjls8ylTNw+/ABvGdarcy7dbllkGIHq/
         6mSiW0FjzQfLwWRzWG/udH87fugquAOefbsBYcL3WB4To+KcWBOjlsGCFn4EqRiQVqq7
         KEMQ==
X-Gm-Message-State: AOJu0YySxVpQ80hi5x1UfLB1JwkoR+D/IIbKPgTF154le6tpTfBu0wqq
        jNqNJwPqCSlfgOWNdyz3muDWnfV1ZIKu4/gNuV4e0Q==
X-Google-Smtp-Source: AGHT+IGratRQGuwe/vxjPJzHMuZ/W6xeu/34oQ2gme1bnFdlc4JMD8fIjkQJWKp4qQo18ENlcsRzAw==
X-Received: by 2002:a0c:e3d1:0:b0:66d:2a3:2abe with SMTP id e17-20020a0ce3d1000000b0066d02a32abemr831138qvl.32.1696970005123;
        Tue, 10 Oct 2023 13:33:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15-20020a0ce0cf000000b0065b2e561c17sm5018774qvk.123.2023.10.10.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:24 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 02/17] revision.c: consult Bloom filters for root commits
Message-ID: <7d0fa9354328799606f7e9a85fb5cedd06da466c.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph stores changed-path Bloom filters which represent the
set of paths included in a tree-level diff between a commit's root tree
and that of its parent.

When a commit has no parents, the tree-diff is computed against that
commit's root tree and the empty tree. In other words, every path in
that commit's tree is stored in the Bloom filter (since they all appear
in the diff).

Consult these filters during pathspec-limited traversals in the function
`rev_same_tree_as_empty()`. Doing so yields a performance improvement
where we can avoid enumerating the full set of paths in a parentless
commit's root tree when we know that the path(s) of interest were not
listed in that commit's changed-path Bloom filter.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-patch-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 revision.c           | 26 ++++++++++++++++++++++----
 t/t4216-log-bloom.sh |  8 ++++++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index e789834dd1..dae569a547 100644
--- a/revision.c
+++ b/revision.c
@@ -834,17 +834,28 @@ static int rev_compare_tree(struct rev_info *revs,
 	return tree_difference;
 }
 
-static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
+static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
+				  int nth_parent)
 {
 	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
+	int bloom_ret = 1;
 
 	if (!t1)
 		return 0;
 
+	if (nth_parent == 1 && revs->bloom_keys_nr) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+		if (!bloom_ret)
+			return 1;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
+	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+		count_bloom_filter_false_positive++;
+
 	return tree_difference == REV_TREE_SAME;
 }
 
@@ -882,7 +893,7 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, nth_parent))
 			commit->object.flags |= TREESAME;
 		else
 			commit->object.flags &= ~TREESAME;
@@ -978,7 +989,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 
 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit))
+		/*
+		 * Pretend as if we are comparing ourselves to the
+		 * (non-existent) first parent of this commit object. Even
+		 * though no such parent exists, its changed-path Bloom filter
+		 * (if one exists) is relative to the empty tree, using Bloom
+		 * filters is allowed here.
+		 */
+		if (rev_same_tree_as_empty(revs, commit, 1))
 			commit->object.flags |= TREESAME;
 		return;
 	}
@@ -1059,7 +1077,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 
 		case REV_TREE_NEW:
 			if (revs->remove_empty_trees &&
-			    rev_same_tree_as_empty(revs, p)) {
+			    rev_same_tree_as_empty(revs, p, nth_parent)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
 				 * history beyond this parent is not
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 487fc3d6b9..322640feeb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -87,7 +87,11 @@ test_bloom_filters_not_used () {
 		# if the Bloom filter system is initialized, ensure that no
 		# filters were used
 		data="statistics:{"
-		data="$data\"filter_not_present\":0,"
+		# unusable filters (e.g., those computed with a
+		# different value of commitGraph.changedPathsVersion)
+		# are counted in the filter_not_present bucket, so any
+		# value is OK there.
+		data="$data\"filter_not_present\":[0-9][0-9]*,"
 		data="$data\"maybe\":0,"
 		data="$data\"definitely_not\":0,"
 		data="$data\"false_positive\":0}"
@@ -174,7 +178,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":10"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
-- 
2.42.0.342.g8bb3a896ee

