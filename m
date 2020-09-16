Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D4C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D2E2083B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="B2UnH2vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgIPSJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgIPSJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:09:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43896C061797
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:08:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w186so9200698qkd.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nkm2hW01F+x4POn5IQ5Zq/VdAiiMrlutWoaJBtfCkuk=;
        b=B2UnH2vxSAtSMDBCpYbF81H4aASVuIetykHOcLlk9POPBwDABh1goFtvhXKXKidjyZ
         puOBEVZqPEz9z6bUQH9K0Rd1LnwaxLYu2WAdd7GyzFdSVDRY3rh2QWGT+B+WvFkUqgyc
         TT1M2rR8M+YaRE3C3RJkk7CF8+d5vSmlsE9BykoSZ9L6COdmCz/ALHw/WSj0yn5S4dZF
         h9cHnX8RvDrbEFIoKr/F9SGDIqpzJXUqFjcuYVPriDEnQNRXL1XpMuAZdbe3YQhpgo2W
         pmUzR7HqIj/uDLAblf4iI3oRR5AJnDIMSUz8YFyriFGBnJbAXEzgZ0Cy42TBa2nOOLEM
         blGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkm2hW01F+x4POn5IQ5Zq/VdAiiMrlutWoaJBtfCkuk=;
        b=MFJQU07LhYJ12r0cirDSL9fBCuAyhFS7ssyV5i4p+3RdbPy9M5eTz+1FOjgT+O700Y
         bcicJtB4bLOlUYGeRfrSbuzEV4i7LpUZmGVa7H29DuFQmT/SSvxUEjgt2FWEESdoNeWH
         oJmEZ1lwQLjnG6DR67v+n0bm4c8QDlLBIU+sBjM7pIbLSod0M0LrpXnRAaUyN7N8sNoh
         zB1X42twpq4iA1Xzug7w2lSgOqm23URs28jzHp0pJO025gsnLgOrtMqRZie4EPCrSmHx
         IF9twrbQPO4S1Y8O5Ij6cZ14ClndkVN069ju73S6oncCiSfPbfcD66KB9XsTj3qXnOBW
         l81A==
X-Gm-Message-State: AOAM531l8n9hAjnQBhSgI5VsPCYlYMczJONQmI3XrGxIaIJimlz3RCHQ
        +ZofjUgUtj/ElbSblzAvptW8y/Q550OYdqrk
X-Google-Smtp-Source: ABdhPJzcy8fQ7ccLSyYXDbFBVmm6ED6vqVX2ehyidJVi8BAV8+MTMlLiC4gXKVFPvf5pKa0uVICBCg==
X-Received: by 2002:a37:9046:: with SMTP id s67mr24244387qkd.212.1600279693916;
        Wed, 16 Sep 2020 11:08:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id 145sm20381718qkf.18.2020.09.16.11.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:08:13 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:08:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 12/13] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <ccb6482feb8d8606d82b5ab97e33184f26d6c5b6.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a command-line flag to specify the maximum number of new Bloom
filters that a 'git commit-graph write' is willing to compute from
scratch.

Prior to this patch, a commit-graph write with '--changed-paths' would
compute Bloom filters for all selected commits which haven't already
been computed (i.e., by a previous commit-graph write with '--split'
such that a roll-up or replacement is performed).

This behavior can cause prohibitively-long commit-graph writes for a
variety of reasons:

  * There may be lots of filters whose diffs take a long time to
    generate (for example, they have close to the maximum number of
    changes, diffing itself takes a long time, etc).

  * Old-style commit-graphs (which encode filters with too many entries
    as not having been computed at all) cause us to waste time
    recomputing filters that appear to have not been computed only to
    discover that they are too-large.

This can make the upper-bound of the time it takes for 'git commit-graph
write --changed-paths' to be rather unpredictable.

To make this command behave more predictably, introduce
'--max-new-filters=<n>' to allow computing at most '<n>' Bloom filters
from scratch. This lets "computing" already-known filters proceed
quickly, while bounding the number of slow tasks that Git is willing to
do.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  5 +++
 bloom.c                            |  7 ++-
 builtin/commit-graph.c             | 27 +++++++++++-
 commit-graph.c                     |  9 +++-
 commit-graph.h                     |  1 +
 t/t4216-log-bloom.sh               | 70 ++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 17405c73a9..8357846d30 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -67,6 +67,11 @@ this option is given, future commit-graph writes will automatically assume
 that this option was intended. Use `--no-changed-paths` to stop storing this
 data.
 +
+With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
+filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
+enforced. Commits whose filters are not calculated are stored as a
+length zero Bloom filter.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/bloom.c b/bloom.c
index d24747a1d5..230a515831 100644
--- a/bloom.c
+++ b/bloom.c
@@ -204,12 +204,11 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
-		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
-				return filter;
+		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
 	}
 
-	if (filter->data)
+	if (filter->data && filter->len)
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f3243bd982..5df9b2ef80 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -13,7 +13,8 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]progress] <split options>"),
+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
+	   "<split options>"),
 	NULL
 };
 
@@ -25,7 +26,8 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
 	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
-	   "[--changed-paths] [--[no-]progress] <split options>"),
+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
+	   "<split options>"),
 	NULL
 };
 
@@ -162,6 +164,23 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
 	return 0;
 }
 
+static int write_option_max_new_filters(const struct option *opt,
+					const char *arg,
+					int unset)
+{
+	int *to = opt->value;
+	if (unset)
+		*to = -1;
+	else {
+		const char *s;
+		*to = strtol(arg, (char **)&s, 10);
+		if (*s)
+			return error(_("%s expects a numerical value"),
+				     optname(opt, opt->flags));
+	}
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
@@ -197,6 +216,9 @@ static int graph_write(int argc, const char **argv)
 			N_("maximum ratio between two levels of a split commit-graph")),
 		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
 			N_("only expire files older than a given date-time")),
+		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
+			NULL, N_("maximum number of changed-path Bloom filters to compute"),
+			0, write_option_max_new_filters),
 		OPT_END(),
 	};
 
@@ -205,6 +227,7 @@ static int graph_write(int argc, const char **argv)
 	write_opts.size_multiple = 2;
 	write_opts.max_commits = 0;
 	write_opts.expire_time = 0;
+	write_opts.max_new_filters = -1;
 
 	trace2_cmd_mode("write");
 
diff --git a/commit-graph.c b/commit-graph.c
index 913f78a9a1..33af6c2430 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1414,6 +1414,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
+	int max_new_filters;
 
 	init_bloom_filters();
 
@@ -1430,13 +1431,16 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	else
 		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
+	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
+		ctx->opts->max_new_filters : ctx->commits.nr;
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		enum bloom_filter_computed computed = 0;
 		struct commit *c = sorted_commits[i];
 		struct bloom_filter *filter = get_or_compute_bloom_filter(
 			ctx->r,
 			c,
-			1,
+			ctx->count_bloom_filter_computed < max_new_filters,
 			ctx->bloom_settings,
 			&computed);
 		if (computed & BLOOM_COMPUTED) {
@@ -1447,7 +1451,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 				ctx->count_bloom_filter_trunc_large++;
 		} else if (computed & BLOOM_NOT_COMPUTED)
 			ctx->count_bloom_filter_not_computed++;
-		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
+		ctx->total_bloom_filter_data_size += filter
+			? sizeof(unsigned char) * filter->len : 0;
 		display_progress(progress, i + 1);
 	}
 
diff --git a/commit-graph.h b/commit-graph.h
index b7914b0a7a..a22bd86701 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -110,6 +110,7 @@ struct commit_graph_opts {
 	int max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags split_flags;
+	int max_new_filters;
 };
 
 /*
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index a0c9c9ea23..9ce0c318e9 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -309,4 +309,74 @@ test_expect_success 'correctly report commits with no changed paths' '
 	)
 '
 
+test_expect_success 'Bloom generation is limited by --max-new-filters' '
+	(
+		cd limits &&
+		test_commit c2 filter &&
+		test_commit c3 filter &&
+		test_commit c4 no-filter &&
+
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --split=replace \
+				--changed-paths --max-new-filters=2 &&
+
+		test_filter_computed 2 trace.event &&
+		test_filter_not_computed 3 trace.event &&
+		test_filter_trunc_small 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
+test_expect_success 'Bloom generation backfills previously-skipped filters' '
+	(
+		cd limits &&
+
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --changed-paths \
+				--split=replace --max-new-filters=1 &&
+		test_filter_computed 1 trace.event &&
+		test_filter_not_computed 4 trace.event &&
+		test_filter_trunc_small 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
+test_expect_success 'Bloom generation backfills empty commits' '
+	git init empty &&
+	test_when_finished "rm -fr empty" &&
+	(
+		cd empty &&
+		for i in $(test_seq 1 6)
+		do
+			git commit --allow-empty -m "$i"
+		done &&
+
+		# Generate Bloom filters for empty commits 1-6, two at a time.
+		for i in $(test_seq 1 3)
+		do
+			rm -f trace.event &&
+			GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+				git commit-graph write --reachable \
+					--changed-paths --max-new-filters=2 &&
+			test_filter_computed 2 trace.event &&
+			test_filter_not_computed 4 trace.event &&
+			test_filter_trunc_small 2 trace.event &&
+			test_filter_trunc_large 0 trace.event
+		done &&
+
+		# Finally, make sure that once all commits have filters, that
+		# none are subsequently recomputed.
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable \
+				--changed-paths --max-new-filters=2 &&
+		test_filter_computed 0 trace.event &&
+		test_filter_not_computed 6 trace.event &&
+		test_filter_trunc_small 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_done
-- 
2.28.0.510.g86fdc5f89a

