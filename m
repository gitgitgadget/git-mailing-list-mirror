Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1CC433E3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C14206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DURA7Gud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgFOUPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbgFOUPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:15:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE17C05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so18479954wrt.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Q8Ed7Syi5EhU0989HD8NNIjYtThDtCQRHO2L6h1zz4I=;
        b=DURA7GudkRw7UJ2Wu681wZbxLSVW03nj09xDMR9NnJS6/GZFKV6zW0URwVhiDAw551
         KNTOdog2UHBIRaJzwvxQsThydaPcLOkBMQfSPLQh1IhywwOHp4tzbj/urHvU5lQjajHz
         yrKbni5WskBMx/xQkXgP20fHvTxl9Wdp6HTw9zcU8trfW8j6/H3jAbu4chBhut0vb+Ey
         O/fVYdnsb4Uwj7VNBhaoGL0eHU3o3H75TKS5eLGMvDO6PfXQn9BhnB53CGqDgf/cJ1XO
         P03gO2I+CBXzE3EH04BXL2CesWlC6CkADgSSiu1yFPpSFptKJm4wJ++xFrujHqPBJvvi
         ElfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Q8Ed7Syi5EhU0989HD8NNIjYtThDtCQRHO2L6h1zz4I=;
        b=CFqC5YfYWYvnD98dQSL4IAI+tiSMqOo8tOZGNz5eoGrePN7fAjN1Rs6kjASGOkhDXj
         5Fdo6KHk+FGurGcaIUmfJrkRanaNVh9RxVZoeAeA5oq9jgJcuxYThe2KeEU3611PvcQn
         sIk0Qt9TyEzpLn9rJnFfIwgdiFnDQ6kLoakgDFi7GhANYX9EkQsjW+vqBiTr133B2QDi
         N+ic44CC2nfoMyulzZ/im65ANu4Kqof/5Y/tonWFHTKoj3O59r1/C40qeYWgVLgWRDMb
         oIC85P5wXuPX36vPEUaZCko55mlBF7HvxJspjsllMC8zPlGre4bTIhJ1H5cyIM7OS5O+
         wFGg==
X-Gm-Message-State: AOAM5300ikIdBNTqP72mBbNeVHt4iI7YG2hvrFBKNcEi2XYsq+xE22sI
        3Sd4FpO8bRNj36oTDMju9wcu2eqX
X-Google-Smtp-Source: ABdhPJxtnt60RRRI75sI5Uk7hdavhuh30cfzv/7MBsPXDY3AxSy8xUlZAni3LndlWg5HpEZu9Q1U4A==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr30062364wrv.315.1592252098972;
        Mon, 15 Jun 2020 13:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v66sm882579wme.13.2020.06.15.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:58 -0700 (PDT)
Message-Id: <9975fc96f1269b049ebdd54835a63480c3dcbe4e.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:50 +0000
Subject: [PATCH 5/8] commit-graph: check all leading directories in changed
 path Bloom filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

The file 'dir/subdir/file' can only be modified if its leading
directories 'dir' and 'dir/subdir' are modified as well.

So when checking modified path Bloom filters looking for commits
modifying a path with multiple path components, then check not only
the full path in the Bloom filters, but all its leading directories as
well.  Take care to check these paths in "deepest first" order,
because it's the full path that is least likely to be modified, and
the Bloom filter queries can short circuit sooner.

This can significantly reduce the average false positive rate, by
about an order of magnitude or three(!), and can further speed up
pathspec-limited revision walks.  The table below compares the average
false positive rate and runtime of

  git rev-list HEAD -- "$path"

before and after this change for 5000+ randomly* selected paths from
each repository:

                    Average false           Average        Average
                    positive rate           runtime        runtime
                  before     after     before     after   difference
  ------------------------------------------------------------------
  git             3.220%   0.7853%     0.0558s   0.0387s   -30.6%
  linux           2.453%   0.0296%     0.1046s   0.0766s   -26.8%
  tensorflow      2.536%   0.6977%     0.0594s   0.0420s   -29.2%

*Path selection was done with the following pipeline:

	git ls-tree -r --name-only HEAD | sort -R | head -n 5000

The improvements in runtime are much smaller than the improvements in
average false positive rate, as we are clearly reaching diminishing
returns here.  However, all these timings depend on that accessing
tree objects is reasonably fast (warm caches).  If we had a partial
clone and the tree objects had to be fetched from a promisor remote,
e.g.:

  $ git clone --filter=tree:0 --bare file://.../webkit.git webkit.notrees.git
  $ git -C webkit.git -c core.modifiedPathBloomFilters=1 \
        commit-graph write --reachable
  $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/info/
  $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=1 \
        rev-list HEAD -- "$path"

then checking all leading path component can reduce the runtime from
over an hour to a few seconds (and this is with the clone and the
promisor on the same machine).

This adjusts the tracing values in t4216-log-bloom.sh, which provides a
concrete way to notice the improvement.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c           | 35 ++++++++++++++++++++++++++---------
 revision.h           |  6 ++++--
 t/t4216-log-bloom.sh |  2 +-
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index c644c660917..027ae3982b4 100644
--- a/revision.c
+++ b/revision.c
@@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
 	char *path_alloc = NULL;
-	const char *path;
+	const char *path, *p;
 	int last_index;
-	int len;
+	size_t len;
+	int path_component_nr = 0, j;
 
 	if (!revs->commits)
 		return;
@@ -705,8 +706,22 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	len = strlen(path);
 
-	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
-	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
+	p = path;
+	do {
+		p = strchrnul(p + 1, '/');
+		path_component_nr++;
+	} while (p - path < len);
+
+	revs->bloom_keys_nr = path_component_nr;
+	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
+
+	p = path;
+	for (j = 0; j < revs->bloom_keys_nr; j++) {
+		p = strchrnul(p + 1, '/');
+
+		fill_bloom_key(path, p - path, &revs->bloom_keys[j],
+			       revs->bloom_filter_settings);
+	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
@@ -720,7 +735,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result;
+	int result = 1, j;
 
 	if (!revs->repo->objects->commit_graph)
 		return -1;
@@ -740,9 +755,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	result = bloom_filter_contains(filter,
-				       revs->bloom_key,
-				       revs->bloom_filter_settings);
+	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
+		result = bloom_filter_contains(filter,
+					       &revs->bloom_keys[j],
+					       revs->bloom_filter_settings);
+	}
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -782,7 +799,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_key && !nth_parent) {
+	if (revs->bloom_keys_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
diff --git a/revision.h b/revision.h
index 7c026fe41fc..abbfb4ab59a 100644
--- a/revision.h
+++ b/revision.h
@@ -295,8 +295,10 @@ struct rev_info {
 	struct topo_walk_info *topo_walk_info;
 
 	/* Commit graph bloom filter fields */
-	/* The bloom filter key for the pathspec */
-	struct bloom_key *bloom_key;
+	/* The bloom filter key(s) for the pathspec */
+	struct bloom_key *bloom_keys;
+	int bloom_keys_nr;
+
 	/*
 	 * The bloom filter settings used to generate the key.
 	 * This is loaded from the commit-graph being used.
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c7011f33e2c..c13b97d3bda 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -142,7 +142,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":8"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
-- 
gitgitgadget

