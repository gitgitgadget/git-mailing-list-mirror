Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F893C2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE7820872
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="piyIiAKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIPSJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgIPSJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:09:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33DC06178A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:08:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so9147032qke.8
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z+Z0ZgoCx8GzfG/7B2Il5ctzxmP3dZx1lu4Bc5/+onQ=;
        b=piyIiAKsKRgnfNO6pNWnFUowedJrq/O4203HgAFJ59B0hPM9AdbgWTqVLeXD57OPPg
         uAQ4xtps2ywl6dtPUQjlBYcNELeii9RoFHgm0mS/gtaYvRpITVIyuRuqu6MBZwCS3ut0
         x9tcIpFuPcTpvbKHiy1MdmQOUI6hfSsRzFCK9ySSqsrQfcpoeAiTzHJxx84I1nRbhK0K
         +7ATG/WUx+GsoYw3h3r89HNvBQp4XRsSL+6SmAMeW2DFRaZfXEyPTRBOk6nNC4V+vNNC
         Tb3ppnYH5WggXw7Qjbu2GkilSA8rNkswLhpAy5un0USEIOApnjVW4wNUouQo1K8N3C6L
         56pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z+Z0ZgoCx8GzfG/7B2Il5ctzxmP3dZx1lu4Bc5/+onQ=;
        b=Uowbu2yjtawBaKmvOoz4+H6IaWUrwukol5SvxG/8BIGGvmHpjPZLdcp7ly8s7IJq6q
         MgdvBoeSsCT4Eu49ZDWbeAKM7p6yqjpI8amtYGumQEkCyrrmBQ5/zbzMM3g4/szgu0NE
         Tgjm5OEDfEMFtkaJcgOgplmY2+Fc39p1yOizhC0Cou0Luna0mMVu9/hAy31UhLwY1pk1
         HTDc9NlUzacOiU1zhIAFFMf6I+f5hMCqWtqXuRW2Nt8Xgd5o0EHf4QTCKGNXHWlgDn97
         y+UGvYxSifEwjorHyAaxYmHaXBnD5S+J0kU0CY9GgLzjE4jJIQWGD5hLCjydcPElBIy7
         cAow==
X-Gm-Message-State: AOAM533TXVbTgfTas2wxVOeAWkMYp5XkzF/8D/bVMBUaR4KS3mX8eWlO
        g8rgsPuBgJsMs1BoxXjXH0lKE5LpaRUG6kgk
X-Google-Smtp-Source: ABdhPJwpFkD9FuC7kT9WDGSmO3QQlnHw9QA/g7XOj3PpjEigAXNDpAe20u7Yzs2gufqIl9x59Lys7A==
X-Received: by 2002:ae9:f301:: with SMTP id p1mr24297625qkg.216.1600279683068;
        Wed, 16 Sep 2020 11:08:03 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id d10sm19419141qkk.1.2020.09.16.11.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:08:02 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 10/13] bloom: encode out-of-bounds filters as non-empty
Message-ID: <4653b5b4bcd254a3791797214b46722b4062dc18.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
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

Finally, note that this does increase the size of on-disk commit-graphs,
but far less than other proposals. In particular, this is generally more
efficient than storing a bitmap for which commits haven't computed their
Bloom filters. Storing a bitmap incurs a penalty of one bit per commit,
whereas storing explicit filters as above incurs a penalty of one byte
per too-large or too-small commit.

In practice, these boundary commits likely occupy a small proportion of
the overall number of commits, and so the size penalty is likely smaller
than storing a bitmap for all commits.

A test to exercise filters which contain too many changed path entries
will be introduced in a subsequent patch.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Suggested-by: Jakub Narębski <jnareb@gmail.com>
Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../technical/commit-graph-format.txt         |  2 +-
 bloom.c                                       | 16 ++++++++--
 bloom.h                                       |  1 +
 commit-graph.c                                |  5 ++++
 t/t0095-bloom.sh                              |  8 ++---
 t/t4216-log-bloom.sh                          | 30 +++++++++++++++++--
 6 files changed, 53 insertions(+), 9 deletions(-)

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
index db9fb82437..d24747a1d5 100644
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
+				*computed |= BLOOM_TRUNC_SMALL;
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
index c6d77e8393..70a8840896 100644
--- a/bloom.h
+++ b/bloom.h
@@ -93,6 +93,7 @@ enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
 	BLOOM_COMPUTED     = (1 << 1),
 	BLOOM_TRUNC_LARGE  = (1 << 2),
+	BLOOM_TRUNC_SMALL  = (1 << 3),
 };
 
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
diff --git a/commit-graph.c b/commit-graph.c
index 1ca754f19c..bd4247bca5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -974,6 +974,7 @@ struct write_commit_graph_context {
 
 	int count_bloom_filter_computed;
 	int count_bloom_filter_not_computed;
+	int count_bloom_filter_trunc_small;
 	int count_bloom_filter_trunc_large;
 };
 
@@ -1402,6 +1403,8 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 			   ctx->count_bloom_filter_computed);
 	trace2_data_intmax("commit-graph", ctx->r, "filter-not-computed",
 			   ctx->count_bloom_filter_not_computed);
+	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-small",
+			   ctx->count_bloom_filter_trunc_small);
 	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
 			   ctx->count_bloom_filter_trunc_large);
 }
@@ -1438,6 +1441,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
 			ctx->count_bloom_filter_computed++;
+			if (computed & BLOOM_TRUNC_SMALL)
+				ctx->count_bloom_filter_trunc_small++;
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
index 1ac8f4c4eb..a0c9c9ea23 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -30,6 +30,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	rm file_to_be_deleted &&
 	git add . &&
 	git commit -m "file removed" &&
+	git commit --allow-empty -m "empty" &&
 	git commit-graph write --reachable --changed-paths &&
 
 	test_oid_cache <<-EOF
@@ -49,7 +50,7 @@ graph_read_expect () {
 }
 
 test_expect_success 'commit-graph write wrote out the bloom chunks' '
-	graph_read_expect 15
+	graph_read_expect 16
 '
 
 # Turn off any inherited trace2 settings for this test.
@@ -156,7 +157,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":8"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
@@ -185,10 +186,18 @@ test_max_changed_paths () {
 	grep "\"max_changed_paths\":$1" $2
 }
 
+test_filter_not_computed () {
+	grep "\"key\":\"filter-not-computed\",\"value\":\"$1\"" $2
+}
+
 test_filter_computed () {
 	grep "\"key\":\"filter-computed\",\"value\":\"$1\"" $2
 }
 
+test_filter_trunc_small () {
+	grep "\"key\":\"filter-trunc-small\",\"value\":\"$1\"" $2
+}
+
 test_filter_trunc_large () {
 	grep "\"key\":\"filter-trunc-large\",\"value\":\"$1\"" $2
 }
@@ -283,4 +292,21 @@ test_expect_success 'correctly report changes over limit' '
 	)
 '
 
+test_expect_success 'correctly report commits with no changed paths' '
+	git init small &&
+	test_when_finished "rm -fr small" &&
+	(
+		cd small &&
+
+		git commit --allow-empty -m "initial commit" &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --changed-paths &&
+		test_filter_computed 1 trace.event &&
+		test_filter_not_computed 0 trace.event &&
+		test_filter_trunc_small 1 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_done
-- 
2.28.0.510.g86fdc5f89a

