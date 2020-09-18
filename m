Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE4C43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A50238A1
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Wckdh+0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgIRDAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgIRC75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:59:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199E2C06178B
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c18so3841782qtw.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GTpdfdFCI3Sha7K8/1UUzEGY1oiz1OJ3+nc0i5Cbsac=;
        b=Wckdh+0SUbPgojHKPbm3Pxt7R/w4kFGWFX2lNM5fmMr3pcKHHJVIgopHlFc2u4M5y1
         PxwAs14i4+HbeX2AKjpxvoKMvcWPnsgpVOws4E6ENMh2YxPYVcvVx15w9VW8cqQeTq+A
         POqjzVddRq1Qdu8sQ99OShNl7LzTOvacEUlb6SDVNA10EDlZb7g49duGVPLUocX6cFcJ
         KhQxSesIcshQG9qQXasweQVxfqAX0dlcepYOlWx9Ht1fsnyixpf7MDbTqWiBfZmay3Nw
         FrZQiHX34mkP7zl4WtYMy8qjhvRIc6kgSun+o8jE3FGMrIW8Oy4yKnKufnsir/OHsRl6
         Wqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GTpdfdFCI3Sha7K8/1UUzEGY1oiz1OJ3+nc0i5Cbsac=;
        b=eHiR5X9+VtN1PnNrjO0b4B+EyylkI/LHhO5huh4BSiile2J0yjoOEPz8bN8B7aHO+R
         98eDxcXWKyDFqqdJhfS6DwJOsdyz8ItomtqDhaGRRY5j5uDzb6zAlDsnEr/1TfFDeqdW
         A+Uzv2wKeDrUw2Fhm7tajxZIHaI2uRrraPRCrwkXYoHMY04NUGebjoKOjF94fcnNxffj
         ptszaXKh6ggEieyje7yruS1Bpmwf4ewJAZbs9jwfpgsk3NrBYVQgPMZwUVktELcAJx0M
         tBVtTVIdwv5OCqHh7zSvPVCxoWZMlXd76zZBiSC48ASKzlHYgCqE3uUUjpkLVb/CYafF
         iX4g==
X-Gm-Message-State: AOAM5307kvkMU9I6Q7RBHE2kHnFuvZ/ictkVTyiTtm0JQYHU8jkjJhjb
        qDVafmA/9xVtGNWqh+hSF9KL3gv9bu5FXHn1
X-Google-Smtp-Source: ABdhPJwiPmjfwqv88N5Ewj6Ej31EyZXp8jLY8DCTrZxy/D44zjGkBVQ1me1rOiTBnwCc7PiMzUbCGQ==
X-Received: by 2002:ac8:3714:: with SMTP id o20mr32364176qtb.0.1600397995822;
        Thu, 17 Sep 2020 19:59:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id 29sm1235301qkr.114.2020.09.17.19.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:55 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 12/13] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <4549f0f747017a96d612d0f6ddd117684cf90b8f.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index d234551ce0..68c73200a5 100644
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
index d2a2f78776..d10e730f29 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1415,6 +1415,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
+	int max_new_filters;
 
 	init_bloom_filters();
 
@@ -1431,13 +1432,16 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
@@ -1448,7 +1452,8 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
index 15bbb626a1..af0975c841 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -310,4 +310,74 @@ test_expect_success 'correctly report commits with no changed paths' '
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
+		test_filter_trunc_empty 0 trace.event &&
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
+		test_filter_trunc_empty 0 trace.event &&
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
+			test_filter_trunc_empty 2 trace.event &&
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
+		test_filter_trunc_empty 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_done
-- 
2.28.0.510.g375ecf1f36

