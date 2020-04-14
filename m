Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEFDC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A748206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Z8VogUl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405072AbgDNEEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405066AbgDNEEV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3FC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c5so5440958pgi.7
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zduc4neDurObiXp22bggDoN5FRJTrfoEwdnk8oyGWBQ=;
        b=Z8VogUl/7KnPhtr45NxYvrAVmqB5hFZctvG6SWFzP9HJcm6BBvYNHlUslP0MJdIo/b
         oAuVvgEEQ7molyu2s3eIdLWNT5tqUOrnS54O/hev6PNFJf+kfns+WieMFBJ+zYhOHf4G
         Taku5zsc1+VvV97pZhfHqGFtwKnJOqyP2WvPLj+JZJgxXTETEilThTIBiWEO+SQYLjxZ
         ZzJpPoyq1Rbksl+7YVJqYazQBuYoENgOKMjM3/UJF7xb/8mI/jeMAUrEJu+8B9J7/yyE
         CDELfdvgkNGDdOBZttsX4z7Hc98UkmzqvZZnqjwbRFWTuOBEklgsZ0dqzziJ+A8QcMwY
         mwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zduc4neDurObiXp22bggDoN5FRJTrfoEwdnk8oyGWBQ=;
        b=HsTLIstpfHGTC6sKLmGzZNH6wg2zDB3y1ag4533HPD15wdxNBBxSY2ZskiIPwYVFj2
         LaEMY9vTqIDXVWVxjykL8Vo8pDhCxqt4obAyCxewNt5bnbgdRCgiXLqDZnz1t1WZjGVp
         R5x3EyTtt9cC+Hxkbqa7Gkf7XWvDVfXX/XLU178lZp1Njm+4f5Huaoz+flbUcl5bhZVl
         Oi0L2hsz0zAc9NKw6VbZZpF7KfAjUwfVpc/sZO5Xg5wgt7WrjICLQbYlNzEaTRcxrrIK
         cFhNot3MH0KiOHt+laOHSj3zdi2mNjgQNYilVBcDhaZorReJFKumzKXWIviDcvSmgYM0
         sa0Q==
X-Gm-Message-State: AGi0PuZydfdEdIhpupLgAXTrG4+QsdEwfOU14xt7B0nOK1kOO6TPnihX
        /Rluc+cudO5NfPPHZpjUzRb6JMqXJQqN3MFn
X-Google-Smtp-Source: APiQypL5eKZ8EfDVd4oQFPLktDH98B35PTNzWqCEnRCuZqp7Siw0aW6fGGPm7cICK152zl5JQo2MXw==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr9484153pgc.168.1586837059667;
        Mon, 13 Apr 2020 21:04:19 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h2sm10024287pfr.220.2020.04.13.21.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:18 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:17 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 4/7] builtin/commit-graph.c: introduce split strategy
 'replace'
Message-ID: <50d2e005ac685ad771e2450222b52474fd3cbde4.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using split commit-graphs, it is sometimes useful to completely
replace the commit-graph chain with a new base.

For example, consider a scenario in which a repository builds a new
commit-graph incremental for each push. Occasionally (say, after some
fixed number of pushes), they may wish to rebuild the commit-graph chain
with all reachable commits.

They can do so with

  $ git commit-graph write --reachable

but this removes the chain entirely and replaces it with a single
commit-graph in 'objects/info/commit-graph'. Unfortunately, this means
that the next push will have to move this commit-graph into the first
layer of a new chain, and then write its new commits on top.

Avoid such copying entirely by allowing the caller to specify that they
wish to replace the entirety of their commit-graph chain, while also
specifying that the new commit-graph should become the basis of a fresh,
length-one chain.

This addresses the above situation by making it possible for the caller
to instead write:

  $ git commit-graph write --reachable --split=replace

which writes a new length-one chain to 'objects/info/commit-graphs',
making the commit-graph incremental generated by the subsequent push
relatively cheap by avoiding the aforementioned copy.

In order to do this, remove an assumption in 'write_commit_graph_file'
that chains are always at least two incrementals long.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  7 ++--
 builtin/commit-graph.c             |  2 ++
 commit-graph.c                     | 53 ++++++++++++++++++++++--------
 commit-graph.h                     |  3 +-
 t/t5324-split-commit-graph.sh      | 19 +++++++++++
 5 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index a4c4a641e5..46f7f7c573 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -64,9 +64,10 @@ strategy and other splitting options. The new commits not already in the
 commit-graph are added in a new "tip" file. This file is merged with the
 existing file if the following merge conditions are met:
 * If `--split=no-merge` is specified, a merge is never performed, and
-the remaining options are ignored. A bare `--split` defers to the
-remaining options. (Note that merging a chain of commit graphs replaces
-the existing chain with a length-1 chain where the first and only
+the remaining options are ignored. `--split=replace` overwrites the
+existing chain with a new one. A bare `--split` defers to the remaining
+options. (Note that merging a chain of commit graphs replaces the
+existing chain with a length-1 chain where the first and only
 incremental holds the entire graph).
 +
 * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 42182ed71c..922f876bfa 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -129,6 +129,8 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 
 	if (!strcmp(arg, "no-merge"))
 		*flags = COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED;
+	else if (!strcmp(arg, "replace"))
+		*flags = COMMIT_GRAPH_SPLIT_REPLACE;
 	else
 		die(_("unrecognized --split argument, %s"), arg);
 
diff --git a/commit-graph.c b/commit-graph.c
index af3fe20bb5..c598508d7f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -866,7 +866,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 			if (edge_value >= 0)
 				edge_value += ctx->new_num_commits_in_base;
-			else {
+			else if (ctx->new_base_graph) {
 				uint32_t pos;
 				if (find_commit_in_graph(parent->item,
 							 ctx->new_base_graph,
@@ -897,7 +897,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 			if (edge_value >= 0)
 				edge_value += ctx->new_num_commits_in_base;
-			else {
+			else if (ctx->new_base_graph) {
 				uint32_t pos;
 				if (find_commit_in_graph(parent->item,
 							 ctx->new_base_graph,
@@ -964,7 +964,7 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 
 			if (edge_value >= 0)
 				edge_value += ctx->new_num_commits_in_base;
-			else {
+			else if (ctx->new_base_graph) {
 				uint32_t pos;
 				if (find_commit_in_graph(parent->item,
 							 ctx->new_base_graph,
@@ -1037,6 +1037,8 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit *commit;
+	enum commit_graph_split_flags flags = ctx->split_opts ?
+		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -1066,8 +1068,9 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		if (!commit)
 			continue;
 		if (ctx->split) {
-			if (!parse_commit(commit) &&
-			    commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
+			if ((!parse_commit(commit) &&
+			     commit->graph_pos == COMMIT_NOT_FROM_GRAPH) ||
+			    flags == COMMIT_GRAPH_SPLIT_REPLACE)
 				add_missing_parents(ctx, commit);
 		} else if (!parse_commit_no_graph(commit))
 			add_missing_parents(ctx, commit);
@@ -1287,6 +1290,8 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
+	enum commit_graph_split_flags flags = ctx->split_opts ?
+		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
 	ctx->num_extra_edges = 0;
 	if (ctx->report_progress)
@@ -1303,11 +1308,14 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		ALLOC_GROW(ctx->commits.list, ctx->commits.nr + 1, ctx->commits.alloc);
 		ctx->commits.list[ctx->commits.nr] = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
-		if (ctx->split &&
+		if (ctx->split && flags != COMMIT_GRAPH_SPLIT_REPLACE &&
 		    ctx->commits.list[ctx->commits.nr]->graph_pos != COMMIT_NOT_FROM_GRAPH)
 			continue;
 
-		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
+		if (ctx->split && flags == COMMIT_GRAPH_SPLIT_REPLACE)
+			parse_commit(ctx->commits.list[ctx->commits.nr]);
+		else
+			parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
 
 		num_parents = commit_list_count(ctx->commits.list[ctx->commits.nr]->parents);
 		if (num_parents > 2)
@@ -1488,8 +1496,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		}
 
 		if (ctx->base_graph_name) {
-			const char *dest = ctx->commit_graph_filenames_after[
-						ctx->num_commit_graphs_after - 2];
+			const char *dest;
+			int idx = ctx->num_commit_graphs_after - 1;
+			if (ctx->num_commit_graphs_after > 1)
+				idx--;
+
+			dest = ctx->commit_graph_filenames_after[idx];
 
 			if (strcmp(ctx->base_graph_name, dest)) {
 				result = rename(ctx->base_graph_name, dest);
@@ -1546,9 +1558,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	g = ctx->r->objects->commit_graph;
 	num_commits = ctx->commits.nr;
-	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
+	if (flags == COMMIT_GRAPH_SPLIT_REPLACE)
+		ctx->num_commit_graphs_after = 1;
+	else
+		ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
 
-	if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
+	if (flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED &&
+	    flags != COMMIT_GRAPH_SPLIT_REPLACE) {
 		while (g && (g->num_commits <= size_mult * num_commits ||
 			    (max_commits && num_commits > max_commits))) {
 			if (g->odb != ctx->odb)
@@ -1561,7 +1577,11 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		}
 	}
 
-	ctx->new_base_graph = g;
+	if (flags != COMMIT_GRAPH_SPLIT_REPLACE)
+		ctx->new_base_graph = g;
+	else if (ctx->num_commit_graphs_after != 1)
+		BUG("split_graph_merge_strategy: num_commit_graphs_after "
+		    "should be 1 with --split=replace");
 
 	if (ctx->num_commit_graphs_after == 2) {
 		char *old_graph_name = get_commit_graph_filename(g->odb);
@@ -1768,6 +1788,7 @@ int write_commit_graph(struct object_directory *odb,
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
 	int res = 0;
+	int replace = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
@@ -1802,6 +1823,9 @@ int write_commit_graph(struct object_directory *odb,
 				g = g->base_graph;
 			}
 		}
+
+		if (ctx->split_opts)
+			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
@@ -1862,13 +1886,14 @@ int write_commit_graph(struct object_directory *odb,
 		goto cleanup;
 	}
 
-	if (!ctx->commits.nr)
+	if (!ctx->commits.nr && !replace)
 		goto cleanup;
 
 	if (ctx->split) {
 		split_graph_merge_strategy(ctx);
 
-		merge_commit_graphs(ctx);
+		if (!replace)
+			merge_commit_graphs(ctx);
 	} else
 		ctx->num_commit_graphs_after = 1;
 
diff --git a/commit-graph.h b/commit-graph.h
index 8752afb88d..718433d79b 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -84,7 +84,8 @@ enum commit_graph_write_flags {
 
 enum commit_graph_split_flags {
 	COMMIT_GRAPH_SPLIT_UNSPECIFIED      = 0,
-	COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 1
+	COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED = 1,
+	COMMIT_GRAPH_SPLIT_REPLACE          = 2
 };
 
 struct split_commit_graph_opts {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 1438d63f24..e5d8d64170 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -362,4 +362,23 @@ test_expect_success '--split=no-merge always writes an incremental' '
 	test_line_count = 2 $graphdir/commit-graph-chain
 '
 
+test_expect_success '--split=replace replaces the chain' '
+	rm -rf $graphdir $infodir/commit-graph &&
+	git reset --hard commits/3 &&
+	git rev-list -1 HEAD~2 >a &&
+	git rev-list -1 HEAD~1 >b &&
+	git rev-list -1 HEAD >c &&
+	git commit-graph write --split=no-merge --stdin-commits <a &&
+	git commit-graph write --split=no-merge --stdin-commits <b &&
+	git commit-graph write --split=no-merge --stdin-commits <c &&
+	test_line_count = 3 $graphdir/commit-graph-chain &&
+	git commit-graph write --stdin-commits --split=replace <b &&
+	test_path_is_missing $infodir/commit-graph &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	ls $graphdir/graph-*.graph >graph-files &&
+	test_line_count = 1 graph-files &&
+	verify_chain_files_exist $graphdir &&
+	graph_read_expect 2
+'
+
 test_done
-- 
2.26.0.106.g9fadedd637

