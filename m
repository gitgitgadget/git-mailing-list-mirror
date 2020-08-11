Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CAAC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00142076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TRPtvSaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHKUvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:23 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB27EC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:22 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s15so35251qvv.7
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FcwVKi0u+RGOZEkffFbj0JHqYJPk8trEu7Vdc1VPFmQ=;
        b=TRPtvSaITU7ScuJQDDdhW+c0hvDfmjynx6WzEXsScs0asQ75VMcP+AUBw5NvH3Ys3K
         G/3zAPIo8cRvQ4fYYMZOQe7PkXINEf+Y6JE9sownASp3gu4TqMxisC5AIT8ASESFanul
         Lkj7TUv8E3ZvdlYg9DuPJzASW+hHDOYv3Iiu0THBz4PY99GqGwlmOGzptB2sLy80W+JQ
         HlUrs0p8u1OQD6jFipfOoC2fFOOSObO8uEcJacubjxvDvVyiq6DVhgUOebI140rd8BQv
         1vGuk7YhftFjgXJ9nuV1U1CZt/4Ojpt8Zf+ypvUXargDwL5uCPnpqdGnWNSUCzrusZKV
         YLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FcwVKi0u+RGOZEkffFbj0JHqYJPk8trEu7Vdc1VPFmQ=;
        b=gGZj2uT50ouidaR3uR6sSVPniQ6fItpIQSmJga+Ab/bUSo7UYHfzBKphaPW34Mc4ax
         B3cwgqixNLdCNgGkO3Aeq00Sj9k5V29nanSlRy2pwv/ks0APulzOHkz9vVGT+AaTQVbZ
         wQ2823dB4jXu9qvLxhQZVepyHSatA4l42zDORwevoM+1AqLkgFuA/K79OcU4gcyGMeCE
         PnjX0CFtU51AIYRXjuc7+8f8eU3H2ULtAfAO5/r8V7PppsSBLuRM+819zmUyykI217CY
         Lbvy33OgpdnreYaFgy0sAhhZY0g1kgLRu5ZFAZKi1+LCIycHD+Fogjcm6jWe/0WsBpLk
         Mwqw==
X-Gm-Message-State: AOAM533s1S341ZmNiW0MlYN9nFW2boClldNm7nzmDONdnQdtImInZWyF
        ghzlDnofTWPh+FUcB/B84qz6f6mMypvpRys+
X-Google-Smtp-Source: ABdhPJw+O/IcWTJ2+LSuzqqW8H17CK00sdmKyPb5ouyTTg+4wHrC57rT/3uslvzWNoEPvTQBRU8U4A==
X-Received: by 2002:a0c:8b51:: with SMTP id d17mr3323335qvc.107.1597179080617;
        Tue, 11 Aug 2020 13:51:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id a6sm28588qka.5.2020.08.11.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:19 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 01/14] commit-graph: introduce
 'get_bloom_filter_settings()'
Message-ID: <e714e54240bb339d1ecebcea157b734abf1c14ef.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many places in the code often need a pointer to the commit-graph's
'struct bloom_filter_settings', in which case they often take the value
from the top-most commit-graph.

In the non-split case, this works as expected. In the split case,
however, things get a little tricky. Not all layers in a chain of
incremental commit-graphs are required to themselves have Bloom data,
and so whether or not some part of the code uses Bloom filters depends
entirely on whether or not the top-most level of the commit-graph chain
has Bloom filters.

This has been the behavior since Bloom filters were introduced, and has
been codified into the tests since a759bfa9ee (t4216: add end to end
tests for git log with Bloom filters, 2020-04-06). In fact, t4216.130
requires that Bloom filters are not used in exactly the case described
earlier.

There is no reason that this needs to be the case, since it is perfectly
valid for commits in an earlier layer to have Bloom filters when commits
in a newer layer do not.

Since Bloom settings are guaranteed to be the same for any layer in a
chain that has Bloom data, it is sufficient to traverse the
'->base_graph' pointer until either (1) a non-null 'struct
bloom_filter_settings *' is found, or (2) until we are at the root of
the commit-graph chain.

Introduce a 'get_bloom_filter_settings()' function that does just this,
and use it instead of purely dereferencing the top-most graph's
'->bloom_filter_settings' pointer.

While we're at it, add an additional test in t5324 to guard against code
in the commit-graph writing machinery that doesn't correctly handle a
NULL 'struct bloom_filter *'.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 blame.c                       |  6 ++++--
 bloom.c                       |  6 +++---
 commit-graph.c                | 11 +++++++++++
 commit-graph.h                |  2 ++
 revision.c                    |  5 +----
 t/t4216-log-bloom.sh          |  9 ++++++---
 t/t5324-split-commit-graph.sh | 13 +++++++++++++
 7 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/blame.c b/blame.c
index 82fa16d658..3e5f8787bc 100644
--- a/blame.c
+++ b/blame.c
@@ -2891,16 +2891,18 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb,
 			    const char *path)
 {
 	struct blame_bloom_data *bd;
+	struct bloom_filter_settings *bs;
 
 	if (!sb->repo->objects->commit_graph)
 		return;
 
-	if (!sb->repo->objects->commit_graph->bloom_filter_settings)
+	bs = get_bloom_filter_settings(sb->repo);
+	if (!bs)
 		return;
 
 	bd = xmalloc(sizeof(struct blame_bloom_data));
 
-	bd->settings = sb->repo->objects->commit_graph->bloom_filter_settings;
+	bd->settings = bs;
 
 	bd->alloc = 4;
 	bd->nr = 0;
diff --git a/bloom.c b/bloom.c
index 1a573226e7..cd9380ac62 100644
--- a/bloom.c
+++ b/bloom.c
@@ -38,7 +38,7 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	while (graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	/* The commit graph commit 'c' lives in doesn't carry bloom filters. */
+	/* The commit graph commit 'c' lives in doesn't carry Bloom filters. */
 	if (!g->chunk_bloom_indexes)
 		return 0;
 
@@ -195,8 +195,8 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
 		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
-			r->objects->commit_graph->chunk_bloom_indexes)
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
+				return filter;
 	}
 
 	if (filter->data)
diff --git a/commit-graph.c b/commit-graph.c
index e51c91dd5b..d4b06811be 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -660,6 +660,17 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
+struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
+{
+	struct commit_graph *g = r->objects->commit_graph;
+	while (g) {
+		if (g->bloom_filter_settings)
+			return g->bloom_filter_settings;
+		g = g->base_graph;
+	}
+	return NULL;
+}
+
 static void close_commit_graph_one(struct commit_graph *g)
 {
 	if (!g)
diff --git a/commit-graph.h b/commit-graph.h
index 09a97030dc..0677dd1031 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -87,6 +87,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
  */
 int generation_numbers_enabled(struct repository *r);
 
+struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
+
 enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
diff --git a/revision.c b/revision.c
index 3dcf689341..be600186ee 100644
--- a/revision.c
+++ b/revision.c
@@ -680,10 +680,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	repo_parse_commit(revs->repo, revs->commits->item);
 
-	if (!revs->repo->objects->commit_graph)
-		return;
-
-	revs->bloom_filter_settings = revs->repo->objects->commit_graph->bloom_filter_settings;
+	revs->bloom_filter_settings = get_bloom_filter_settings(revs->repo);
 	if (!revs->bloom_filter_settings)
 		return;
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c21cc160f3..c9f9bdf1ba 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -60,7 +60,7 @@ setup () {
 
 test_bloom_filters_used () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":0,\"maybe\""
+	bloom_trace_prefix="statistics:{\"filter_not_present\":${2:-0},\"maybe\""
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom &&
@@ -134,8 +134,11 @@ test_expect_success 'setup - add commit-graph to the chain without Bloom filters
 	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
 '
 
-test_expect_success 'Do not use Bloom filters if the latest graph does not have Bloom filters.' '
-	test_bloom_filters_not_used "-- A/B"
+test_expect_success 'use Bloom filters even if the latest graph does not have Bloom filters' '
+	# Ensure that the number of empty filters is equal to the number of
+	# filters in the latest graph layer to prove that they are loaded (and
+	# ignored).
+	test_bloom_filters_used "-- A/B" 3
 '
 
 test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 9b850ea907..5bdfd53ef9 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -425,4 +425,17 @@ done <<\EOF
 0600 -r--------
 EOF
 
+test_expect_success '--split=replace with partial Bloom data' '
+	rm -rf $graphdir $infodir/commit-graph &&
+	git reset --hard commits/3 &&
+	git rev-list -1 HEAD~2 >a &&
+	git rev-list -1 HEAD~1 >b &&
+	git commit-graph write --split=no-merge --stdin-commits --changed-paths <a &&
+	git commit-graph write --split=no-merge --stdin-commits <b &&
+	git commit-graph write --split=replace --stdin-commits --changed-paths <c &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 1 graph-files &&
+	verify_chain_files_exist $graphdir
+'
+
 test_done
-- 
2.28.0.rc1.13.ge78abce653

