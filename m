Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA3C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908D423119
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WMd59iM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIRDAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIRC7s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D825C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:48 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so4613194qke.13
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vlYinUfs9l8TUJ98WDhFxKj7fHhxkDqaX7jwaFLQzBY=;
        b=WMd59iM6pX06ryr1xM38iuz5FlWeQhKbwuj1qbXbsGA/DsMnCS6kmz6kif2WFjG5Tl
         PvfxdXCwqNlB8A9dxh7mDLOEpXFcs4PJAmj9IPpYce0rq8Dv0P+uLtZY8zK9EYY3a7VU
         V4daTt2x/001YJAzSt9/yzbI+6cnJvICFc/nzPyFjLIQ9ataJr2vGYZJi3K/fgkmyofd
         zIr8smNGivMRgGqXfxj6f9rwHrMNkXKSDWcYmAQ/mhfVjq2SbVUYOZvmK6M8Psj4NtFy
         cf0kLRw3e3FAuti18+wIXrdtsQkAhk539k4YIfob5ouroFU790CFqAmvZQ778ogM9wC/
         psdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vlYinUfs9l8TUJ98WDhFxKj7fHhxkDqaX7jwaFLQzBY=;
        b=YMRQf1viNQygCvKK/xsQSel+tJEW3oPsbGAnt10WWS/rdB3sMJ3O3oS/5ifkiyGZtM
         B718rAF4vd5r4uPzsG2/qKhcluREbmyGL8Dk48kr77w0cwkFPBgeWOHkyXu0WfypCkOt
         L87V1pLZOlZpWg3j4aZtozwQEuEVrJm/37OwYdthXDELFBWZ89Z1Z4qcKOuCNU4YddxO
         YVv9J4UslY0NnFXBOay3/jBCCIYE/51TzvM6Gfb1coCktNof8a8kHUEAqy1297cDcRjs
         D7fTh6YUOB5zmu9QVaXh681xYRvAD62QRkACo/+FBoSpJ4+gZiwZBMfSQd10bHVXCNK3
         +jxA==
X-Gm-Message-State: AOAM532XglQlWDCaNSXkt7+NCCQcFxJERcFSujkxe9DmRAs+YiMXI2ER
        mYCL56DvAAlX1R4H/plxJUgUN9oXjgFKM0aD
X-Google-Smtp-Source: ABdhPJz2iqenFVsfg6arB8m5psESGVF+c08AFKQoJhcsFowabxLlRgJ734zcHikk9FXwAMCvCa31LA==
X-Received: by 2002:a37:7106:: with SMTP id m6mr29948055qkc.412.1600397987160;
        Thu, 17 Sep 2020 19:59:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id o2sm1188478qkk.42.2020.09.17.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:46 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 10/13] bloom: encode out-of-bounds filters as non-empty
Message-ID: <b1da2564fac38259d2c8150732ea3bb5232c7aff.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a changed-path Bloom filter has either zero, or more than a
certain number (commonly 512) of entries, the commit-graph machinery
encodes it as "missing". More specifically, it sets the indices adjacent
in the BIDX chunk as equal to each other to indicate a "length 0"
filter; that is, that the filter occupies zero bytes on disk.

This has heretofore been fine, since the commit-graph machinery has no
need to care about these filters with too few or too many changed paths.
Both cases act like no filter has been generated at all, and so there is
no need to store them.

In a subsequent commit, however, the commit-graph machinery will learn
to only compute Bloom filters for some commits in the current
commit-graph layer. This is a change from the current implementation
which computes Bloom filters for all commits that are in the layer being
written. Critically for this patch, only computing some of the Bloom
filters means adding a third state for length 0 Bloom filters: zero
entries, too many entries, or "hasn't been computed".

It will be important for that future patch to distinguish between "not
representable" (i.e., zero or too-many changed paths), and "hasn't been
computed". In particular, we don't want to waste time recomputing
filters that have already been computed.

To that end, change how we store Bloom filters in the "computed but not
representable" category:

  - Bloom filters with no entries are stored as a single byte with all
    bits low (i.e., all queries to that Bloom filter will return
    "definitely not")

  - Bloom filters with too many entries are stored as a single byte with
    all bits set high (i.e., all queries to that Bloom filter will
    return "maybe").

These rules are sufficient to not incur a behavior change by changing
the on-disk representation of these two classes. Likewise, no
specification changes are necessary for the commit-graph format, either:

  - Filters that were previously empty will be recomputed and stored
    according to the new rules, and

  - old clients reading filters generated by new clients will interpret
    the filters correctly and be none the wiser to how they were
    generated.

Clients will invoke the Bloom machinery in more cases than before, but
this can be addressed by returning a NULL filter when all bits are set
high. This can be addressed in a future patch.

Note that this does increase the size of on-disk commit-graphs, but far
less than other proposals. In particular, this is generally more
efficient than storing a bitmap for which commits haven't computed their
Bloom filters. Storing a bitmap incurs a penalty of one bit per commit,
whereas storing explicit filters as above incurs a penalty of one byte
per too-large or empty commit.

In practice, these boundary commits likely occupy a small proportion of
the overall number of commits, and so the size penalty is likely smaller
than storing a bitmap for all commits.

See, for example, these relative proportions of such boundary commits
(collected by SZEDER Gábor):

                  |     Percentage of     |    commit-graph   |           |
                  |   commits modifying   |     file size     |           |
                  ├────────┬──────────────┼───────────────────┤    pct.   |
                  | 0 path | >= 512 paths | before  |  after  |   change  |
 ┌────────────────┼────────┼──────────────┼─────────┼─────────┼───────────┤
 | android-base   | 13.20% |        0.13% | 37.468M | 37.534M | +0.1741 % |
 | cmssw          |  0.15% |        0.23% | 17.118M | 17.119M | +0.0091 % |
 | cpython        |  3.07% |        0.01% |  7.967M |  7.971M | +0.0423 % |
 | elasticsearch  |  0.70% |        1.00% |  8.833M |  8.835M | +0.0128 % |
 | gcc            |  0.00% |        0.08% | 16.073M | 16.074M | +0.0030 % |
 | gecko-dev      |  0.14% |        0.64% | 59.868M | 59.874M | +0.0105 % |
 | git            |  0.11% |        0.02% |  3.895M |  3.895M | +0.0020 % |
 | glibc          |  0.02% |        0.10% |  3.555M |  3.555M | +0.0021 % |
 | go             |  0.00% |        0.07% |  3.186M |  3.186M | +0.0018 % |
 | homebrew-cask  |  0.40% |        0.02% |  7.035M |  7.035M | +0.0065 % |
 | homebrew-core  |  0.01% |        0.01% | 11.611M | 11.611M | +0.0002 % |
 | jdk            |  0.26% |        5.64% |  5.537M |  5.540M | +0.0590 % |
 | linux          |  0.01% |        0.51% | 63.735M | 63.740M | +0.0073 % |
 | llvm-project   |  0.12% |        0.03% | 25.515M | 25.516M | +0.0050 % |
 | rails          |  0.10% |        0.10% |  6.252M |  6.252M | +0.0027 % |
 | rust           |  0.07% |        0.17% |  9.364M |  9.364M | +0.0033 % |
 | tensorflow     |  0.09% |        1.02% |  7.009M |  7.010M | +0.0158 % |
 | webkit         |  0.05% |        0.31% | 17.405M | 17.406M | +0.0047 % |

(where the above increase is determined by computing a non-split
commit-graph before and after this patch).

Given that these projects are all "large" by commit count, the storage
cost by writing these filters explicitly is negligible. In the most
extreme example, android-base (which has 494,848 commits at the time of
writing) would have its commit-graph increase by a modest 68.4 KB.

Finally, a test to exercise filters which contain too many changed path
entries will be introduced in a subsequent patch.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Suggested-by: Jakub Narębski <jnareb@gmail.com>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .../technical/commit-graph-format.txt         |  2 +-
 bloom.c                                       | 16 ++++++++--
 bloom.h                                       |  1 +
 commit-graph.c                                |  5 +++
 t/t0095-bloom.sh                              |  8 ++---
 t/t4216-log-bloom.sh                          | 31 +++++++++++++++++--
 6 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 6ddbceba15..6585f1948a 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -125,7 +125,7 @@ CHUNK DATA:
     * The rest of the chunk is the concatenation of all the computed Bloom
       filters for the commits in lexicographic order.
     * Note: Commits with no changes or more than 512 changes have Bloom filters
-      of length zero.
+      of length one, with either all bits set to zero or one respectively.
     * The BDAT chunk is present if and only if BIDX is present.
 
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
diff --git a/bloom.c b/bloom.c
index db9fb82437..d234551ce0 100644
--- a/bloom.c
+++ b/bloom.c
@@ -177,6 +177,13 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data,
 	return strcmp(e1->path, e2->path);
 }
 
+static void init_truncated_large_filter(struct bloom_filter *filter)
+{
+	filter->data = xmalloc(1);
+	filter->data[0] = 0xFF;
+	filter->len = 1;
+}
+
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
@@ -260,12 +267,18 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 		}
 
 		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
+			init_truncated_large_filter(filter);
 			if (computed)
 				*computed |= BLOOM_TRUNC_LARGE;
 			goto cleanup;
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+		if (!filter->len) {
+			if (computed)
+				*computed |= BLOOM_TRUNC_EMPTY;
+			filter->len = 1;
+		}
 		filter->data = xcalloc(filter->len, sizeof(unsigned char));
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
@@ -279,8 +292,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	} else {
 		for (i = 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
-		filter->data = NULL;
-		filter->len = 0;
+		init_truncated_large_filter(filter);
 
 		if (computed)
 			*computed |= BLOOM_TRUNC_LARGE;
diff --git a/bloom.h b/bloom.h
index c6d77e8393..adde6dfe21 100644
--- a/bloom.h
+++ b/bloom.h
@@ -93,6 +93,7 @@ enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
 	BLOOM_COMPUTED     = (1 << 1),
 	BLOOM_TRUNC_LARGE  = (1 << 2),
+	BLOOM_TRUNC_EMPTY  = (1 << 3),
 };
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
diff --git a/commit-graph.c b/commit-graph.c
index 50519eb968..a71663c28c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -975,6 +975,7 @@ struct write_commit_graph_context {
 
 	int count_bloom_filter_computed;
 	int count_bloom_filter_not_computed;
+	int count_bloom_filter_trunc_empty;
 	int count_bloom_filter_trunc_large;
 };
 
@@ -1403,6 +1404,8 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 			   ctx->count_bloom_filter_computed);
 	trace2_data_intmax("commit-graph", ctx->r, "filter-not-computed",
 			   ctx->count_bloom_filter_not_computed);
+	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-empty",
+			   ctx->count_bloom_filter_trunc_empty);
 	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
 			   ctx->count_bloom_filter_trunc_large);
 }
@@ -1439,6 +1442,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
 			ctx->count_bloom_filter_computed++;
+			if (computed & BLOOM_TRUNC_EMPTY)
+				ctx->count_bloom_filter_trunc_empty++;
 			if (computed & BLOOM_TRUNC_LARGE)
 				ctx->count_bloom_filter_trunc_large++;
 		} else if (computed & BLOOM_NOT_COMPUTED)
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 232ba2c485..7e4ab1795f 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -71,8 +71,8 @@ test_expect_success 'get bloom filters for commit with no changes' '
 	git init &&
 	git commit --allow-empty -m "c0" &&
 	cat >expect <<-\EOF &&
-	Filter_Length:0
-	Filter_Data:
+	Filter_Length:1
+	Filter_Data:00|
 	EOF
 	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
 	test_cmp expect actual
@@ -107,8 +107,8 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
 	git add bigDir &&
 	git commit -m "commit with 513 changes" &&
 	cat >expect <<-\EOF &&
-	Filter_Length:0
-	Filter_Data:
+	Filter_Length:1
+	Filter_Data:ff|
 	EOF
 	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
 	test_cmp expect actual
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 123b46a0db..15bbb626a1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -30,6 +30,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	rm file_to_be_deleted &&
 	git add . &&
 	git commit -m "file removed" &&
+	git commit --allow-empty -m "empty" &&
 	git commit-graph write --reachable --changed-paths &&
 
 	test_oid_cache <<-EOF
@@ -37,6 +38,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	oid_version sha256:2
 	EOF
 '
+
 graph_read_expect () {
 	NUM_CHUNKS=5
 	cat >expect <<- EOF
@@ -49,7 +51,7 @@ graph_read_expect () {
 }
 
 test_expect_success 'commit-graph write wrote out the bloom chunks' '
-	graph_read_expect 15
+	graph_read_expect 16
 '
 
 # Turn off any inherited trace2 settings for this test.
@@ -156,7 +158,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":8"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
@@ -185,10 +187,18 @@ test_max_changed_paths () {
 	grep "\"max_changed_paths\":$1" $2
 }
 
+test_filter_not_computed () {
+	grep "\"key\":\"filter-not-computed\",\"value\":\"$1\"" $2
+}
+
 test_filter_computed () {
 	grep "\"key\":\"filter-computed\",\"value\":\"$1\"" $2
 }
 
+test_filter_trunc_empty () {
+	grep "\"key\":\"filter-trunc-empty\",\"value\":\"$1\"" $2
+}
+
 test_filter_trunc_large () {
 	grep "\"key\":\"filter-trunc-large\",\"value\":\"$1\"" $2
 }
@@ -283,4 +293,21 @@ test_expect_success 'correctly report changes over limit' '
 	)
 '
 
+test_expect_success 'correctly report commits with no changed paths' '
+	git init empty &&
+	test_when_finished "rm -fr empty" &&
+	(
+		cd empty &&
+
+		git commit --allow-empty -m "initial commit" &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --changed-paths &&
+		test_filter_computed 1 trace.event &&
+		test_filter_not_computed 0 trace.event &&
+		test_filter_trunc_empty 1 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_done
-- 
2.28.0.510.g375ecf1f36

