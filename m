Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B623C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 05:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A74B20656
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 05:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neHn+wrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgHNFCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNFCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 01:02:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4FFC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 22:02:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so3962479pfx.13
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 22:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=wa4MuSzwb/Kj4iHOLgkBVMMGXl5IuyVa21Z3wLjKh20=;
        b=neHn+wrHt9EnHodkEPjxp0hd87KyP1Hg/GhfaYcMTqgo47KKL52aU78WPIX4V1/GNJ
         fIyuKlO3hhknD5DCPFLUTjncigZGJnCfp63rXW55lYkEON9wFQFMAhWhzefstkSVCI7U
         bk+CEOwtS+xS0aK2763/GcH2h0fzYz2VAvAFG2EP1gK0yq9rAY9W9oSKBLQk++lPLgLF
         OO6euHgReRwKMLHjU8HYHK0Z5uYLHmeltyEfKeov0qKAz/nWEjaHtBEOMXLN3razi2Ng
         0prFKW+MSGTEEQSRYGwI5ox7deM8jlj8Cn8G6qGpPONqGmVwWrddCV/7Yk4QjAyydQab
         kPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=wa4MuSzwb/Kj4iHOLgkBVMMGXl5IuyVa21Z3wLjKh20=;
        b=lSiNfiHc+xAoPkRHYwP26boRugwrllPmmnp0PLIorqCPzfZd9FRxLuRtnvrQvH80A8
         B3x8oqCh6V3+/HZKQ6oIc5CUDckJAtBYp/fYu/4IvSnjy/YLtq5+joXH/0LHsBKrF52c
         Ohxws0QJZl9K68uMmEi5DD+LiaIRNI41W7kffEishaYWFu9AL/pZi9T7eH7mU6WeNiCa
         QP2hVEfKcmuXZ/PSDywJO4Gjh6WRGex046GKPYbsSCEbkL0N0KpMiAmZRzBRwzsVA2Fd
         NMu8yItJR0/3CpOl7aloTgoQBAbxQ+M9C8+2IEtLjDB1hhsed3IRRqrktbGwo6IF4AhC
         vXPQ==
X-Gm-Message-State: AOAM5332AZKHshSJ2fCnK9AYa6ch/qZj55j44NjGwul5j5uWh7igzQie
        1+jtwKsXzoyiqw12IJKy+zdEzRZXIYcjYA==
X-Google-Smtp-Source: ABdhPJyyr9v+duKM4PxNViUUpCI3Nk/eaWeyMOh0Ejjn6A7EVdpdf+2tfbW9AkIAbeNNpYa2uTRPMQ==
X-Received: by 2002:a63:955d:: with SMTP id t29mr636463pgn.135.1597381330191;
        Thu, 13 Aug 2020 22:02:10 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:817:231e:2936:d86b:3ba4:55cf])
        by smtp.gmail.com with ESMTPSA id t2sm7613912pfb.123.2020.08.13.22.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 22:02:09 -0700 (PDT)
Date:   Fri, 14 Aug 2020 10:29:57 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
        me@ttaylorr.com, gitgitgadget@gmail.com
Subject: Re: [PATCH v2 07/10] commit-graph: implement corrected commit date
Message-ID: <20200814045957.GA1380@Abhishek-Arch>
Reply-To: a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <bfe14732014807ff19f943cdf51068f0d3043c30.1596941625.git.gitgitgadget@gmail.com>
 <a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3910f82-ab2e-bf35-ac43-c30d77f3c96b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 10:23:32AM -0400, Derrick Stolee wrote:
> ....
> --- >8 ---
> 
> From 62189709fad3b051cedbd36193f5244fcce17e1f Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Mon, 10 Aug 2020 10:06:47 -0400
> Subject: [PATCH] commit-graph: use generation v2 only if entire chain does
> 
> Since there are released versions of Git that understand generation
> numbers in the commit-graph's CDAT chunk but do not understand the GDAT
> chunk, the following scenario is possible:
> 
>  1. "New" Git writes a commit-graph with the GDAT chunk.
>  2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
> 
> Because of the current use of inspecting the current layer for a
> generation_data_chunk pointer, the commits in the lower layer will be
> interpreted as having very large generation values (commit date plus
> offset) compared to the generation numbers in the top layer (topological
> level). This violates the expectation that the generation of a parent is
> strictly smaller than the generation of a child.
> 
> It is difficult to expose this issue in a test. Since we _start_ with
> artificially low generation numbers, any commit walk that prioritizes
> generation numbers will walk all of the commits with high generation
> number before walking the commits with low generation number. In all the
> cases I tried, the commit-graph layers themselves "protect" any
> incorrect behavior since none of the commits in the lower layer can
> reach the commits in the upper layer.
> 
> This issue would manifest itself as a performance problem in this
> case, especially with something like "git log --graph" since the low
> generation numbers would cause the in-degree queue to walk all of the
> commits in the lower layer before allowing the topo-order queue to write
> anything to output (depending on the size of the upper layer).
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index eb78af3dad..17623274d9 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -762,7 +762,9 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
>  	return &commit_list_insert(c, pptr)->next;
>  }
>  
> -static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
> +#define COMMIT_GRAPH_GENERATION_V2 (1 << 0)
> +
> +static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos, int flags)
>  {
>  	const unsigned char *commit_data;
>  	struct commit_graph_data *graph_data;
> @@ -785,11 +787,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>  	date_low = get_be32(commit_data + g->hash_len + 12);
>  	item->date = (timestamp_t)((date_high << 32) | date_low);
>  
> -	if (g->chunk_generation_data)
> -	{
> +	if (g->chunk_generation_data && (flags & COMMIT_GRAPH_GENERATION_V2))
>  		graph_data->generation = item->date +
>  			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
> -	}
>  	else
>  		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>  }
> @@ -799,6 +799,10 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
>  	c->maybe_tree = t;
>  }
>  
> +/*
> + * In the case of a split commit-graph, this method expects the given
> + * commit-graph 'g' to be the top layer.
> + */

Unfortunately, this turns out to be an optimistic assumption. After
adding in changes from this patch and extended tests for
split-commit-graph [1], the tests fail with `git commit-graph verify` as
Git tries to compare topological level with corrected commit dates.

The problem lies in assuming that `g` is always the top layer, without
any way to assert if that's true. In case of `commit-graph verify`, we
update `g = g->base_graph` and verify recursively.

If we can assume such behavior is only the part of verify subcommand, I
can update the tests to no longer verify at the end.

[1]: https://lore.kernel.org/git/4043ffbc-84df-0cd6-5c75-af80383a56cf@gmail.com/

>  static int fill_commit_in_graph(struct repository *r,
>  				struct commit *item,
>  				struct commit_graph *g, uint32_t pos)
> @@ -808,11 +812,15 @@ static int fill_commit_in_graph(struct repository *r,
>  	struct commit_list **pptr;
>  	const unsigned char *commit_data;
>  	uint32_t lex_index;
> +	int flags = 0;
> +
> +	if (g->chunk_generation_data)
> +		flags |= COMMIT_GRAPH_GENERATION_V2;
>  
>  	while (pos < g->num_commits_in_base)
>  		g = g->base_graph;
>  
> -	fill_commit_graph_info(item, g, pos);
> +	fill_commit_graph_info(item, g, pos, flags);
>  
>  	lex_index = pos - g->num_commits_in_base;
>  	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
> @@ -904,10 +912,14 @@ int parse_commit_in_graph(struct repository *r, struct commit *item)
>  void load_commit_graph_info(struct repository *r, struct commit *item)
>  {
>  	uint32_t pos;
> +	int flags = 0;
> +
>  	if (!prepare_commit_graph(r))
>  		return;
> +	if (r->objects->commit_graph->chunk_generation_data)
> +		flags |= COMMIT_GRAPH_GENERATION_V2;
>  	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
> -		fill_commit_graph_info(item, r->objects->commit_graph, pos);
> +		fill_commit_graph_info(item, r->objects->commit_graph, pos, flags);
>  }
>  
>  static struct tree *load_tree_for_commit(struct repository *r,
> -- 
> 2.28.0.38.gc6f546511c1
> 

I solved the issue by adding a new member to struct commit_graph
`read_generation_data` to maintain the "global" state of the entire
commit-graph chain instead.

The relevant changes are in validate_mixed_generation_chain(),
read_commit_graph_one() and fill_commit_graph_info().

Thanks
- Abhishek

--- >8 ---
From aaf8c27bfec6e110a8bb12173c2dd612a8c6b8b9 Mon Sep 17 00:00:00 2001
From: Abhishek Kumar <abhishekkumar8222@gmail.com>
Date: Thu, 6 Aug 2020 19:08:52 +0530
Subject: [PATCH] commit-graph: use generation v2 only if entire chain does

Since there are released versions of Git that understand generation
numbers in the commit-graph's CDAT chunk but do not understand the GDAT
chunk, the following scenario is possible:

1. "New" Git writes a commit-graph with the GDAT chunk.
2. "Old" Git writes a split commit-graph on top without a GDAT chunk.

Because of the current use of inspecting the current layer for a
chunk_generation_data pointer, the commits in the lower layer will be
interpreted as having very large generation values (commit date plus
offset) compared to the generation numbers in the top layer (topological
level). This violates the expectation that the generation of a parent is
strictly smaller than the generation of a child.

It is difficult to expose this issue in a test. Since we _start_ with
artificially low generation numbers, any commit walk that prioritizes
generation numbers will walk all of the commits with high generation
number before walking the commits with low generation number. In all the
cases I tried, the commit-graph layers themselves "protect" any
incorrect behavior since none of the commits in the lower layer can
reach the commits in the upper layer.

This issue would manifest itself as a performance problem in this case,
especially with something like "git log --graph" since the low
generation numbers would cause the in-degree queue to walk all of the
commits in the lower layer before allowing the topo-order queue to write
anything to output (depending on the size of the upper layer).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c                | 36 ++++++++++++++++--
 commit-graph.h                |  1 +
 t/t5324-split-commit-graph.sh | 70 +++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d0f977852b..10309f870f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -597,6 +597,27 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	return graph_chain;
 }
 
+static void validate_mixed_generation_chain(struct repository *r)
+{
+	struct commit_graph *g = r->objects->commit_graph;
+	int read_generation_data = 1;
+
+	while (g) {
+		if (!g->chunk_generation_data) {
+			read_generation_data = 0;
+			break;
+		}
+		g = g->base_graph;
+	}
+
+	g = r->objects->commit_graph;
+
+	while (g) {
+		g->read_generation_data = read_generation_data;
+		g = g->base_graph;
+	}
+}
+
 struct commit_graph *read_commit_graph_one(struct repository *r,
 					   struct object_directory *odb)
 {
@@ -605,6 +626,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 	if (!g)
 		g = load_commit_graph_chain(r, odb);
 
+	validate_mixed_generation_chain(r);
+
 	return g;
 }
 
@@ -740,6 +763,8 @@ static struct commit_list **insert_parent_or_die(struct repository *r,
 	return &commit_list_insert(c, pptr)->next;
 }
 
+#define COMMIT_GRAPH_GENERATION_V2 (1 << 0)
+
 static void fill_commit_graph_info(struct commit *item, struct commit_graph *g, uint32_t pos)
 {
 	const unsigned char *commit_data;
@@ -763,11 +788,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	date_low = get_be32(commit_data + g->hash_len + 12);
 	item->date = (timestamp_t)((date_high << 32) | date_low);
 
-	if (g->chunk_generation_data)
-	{
+	if (g->chunk_generation_data && g->read_generation_data)
 		graph_data->generation = item->date +
 			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
-	}
 	else
 		graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
@@ -884,6 +907,7 @@ void load_commit_graph_info(struct repository *r, struct commit *item)
 	uint32_t pos;
 	if (!prepare_commit_graph(r))
 		return;
+
 	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
 		fill_commit_graph_info(item, r->objects->commit_graph, pos);
 }
@@ -2186,6 +2210,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		g = ctx->r->objects->commit_graph;
 
+		if (g && !g->chunk_generation_data)
+			ctx->write_generation_data = 0;
+
 		while (g) {
 			ctx->num_commit_graphs_before++;
 			g = g->base_graph;
@@ -2204,6 +2231,9 @@ int write_commit_graph(struct object_directory *odb,
 
 		if (ctx->split_opts)
 			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
+
+		if (replace)
+			ctx->write_generation_data = 1;
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
diff --git a/commit-graph.h b/commit-graph.h
index f89614ecd5..305c332b7e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -63,6 +63,7 @@ struct commit_graph {
 	struct object_directory *odb;
 
 	uint32_t num_commits_in_base;
+	uint32_t read_generation_data;
 	struct commit_graph *base_graph;
 
 	const uint32_t *chunk_oid_fanout;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 531016f405..ac5e7783fb 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -424,4 +424,74 @@ done <<\EOF
 0600 -r--------
 EOF
 
+test_expect_success 'setup repo for mixed generation commit-graph-chain' '
+	mkdir mixed &&
+	graphdir=".git/objects/info/commit-graphs" &&
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git init &&
+	git config core.commitGraph true &&
+	git config gc.writeCommitGraph false &&
+	for i in $(test_seq 3)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/1 &&
+	for i in $(test_seq 4 5)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git reset --hard commits/2 &&
+	for i in $(test_seq 6 10)
+	do
+		test_commit $i &&
+		git branch commits/$i || return 1
+	done &&
+	git commit-graph write --reachable --split &&
+	git reset --hard commits/2 &&
+	git merge commits/4 &&
+	git branch merge/1 &&
+	git reset --hard commits/4 &&
+	git merge commits/6 &&
+	git branch merge/2 &&
+	GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write --reachable --split=no-merge &&
+	test-tool read-graph >output &&
+	cat >expect <<-EOF &&
+	header: 43475048 1 1 4 1
+	num_commits: 2
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	test_cmp expect output &&
+	git commit-graph verify
+'
+
+test_expect_success 'does not write generation data chunk if not present on existing tip' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git reset --hard commits/3 &&
+	git merge merge/1 &&
+	git merge commits/5 &&
+	git merge merge/2 &&
+	git branch merge/3 &&
+	git commit-graph write --reachable --split=no-merge &&
+	test-tool read-graph >output &&
+	cat >expect <<-EOF &&
+	header: 43475048 1 1 4 2
+	num_commits: 3
+	chunks: oid_fanout oid_lookup commit_metadata
+	EOF
+	test_cmp expect output &&
+	git commit-graph verify
+'
+
+test_expect_success 'writes generation data chunk when commit-graph chain is replaced' '
+	cd "$TRASH_DIRECTORY/mixed" &&
+	git commit-graph write --reachable --split=replace &&
+	test_path_is_file $graphdir/commit-graph-chain &&
+	test_line_count = 1 $graphdir/commit-graph-chain &&
+	verify_chain_files_exist $graphdir &&
+	graph_read_expect 15 &&
+	git commit-graph verify
+'
+
 test_done
-- 
2.28.0
