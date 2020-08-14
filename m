Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D24DC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B8206DA
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uEmpRtZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHNUKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgHNUKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:10:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDBC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:10:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p25so9510400qkp.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kLMEP578qJMp07/XZPYRooBetIjgzEewkgwnwfzFxm8=;
        b=uEmpRtZrQQk1A06KHGHMmnM2APevCgD10i9ADFAs0HTZsnytGdJtJAVppibDjvh/N8
         D+P4zMXOfNU+J1xA6YxC/ptSS+sLTapMl5XVgHXncJJJXE01nwiKDogUSjhIOWE51J7z
         OC4L/KJMmCLUkoVtqH0c62t0BU1Hrdamv36h3QAG4p55xuqSabN5pmZPeiYxYUq3Z+6U
         N0mcJ77TI7gB1gnWil1IT1epuHlC4CT+5RcjyR5Ygrh1OOSqKgJkpF98bdK9RyZpVvuo
         L7b1VJaTZjcKuaf1WetM1ef2tkJf4YC5NMIczjkv5h7a0YmZZtHvY0ohq0Vgbj2CmNao
         5xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kLMEP578qJMp07/XZPYRooBetIjgzEewkgwnwfzFxm8=;
        b=dl2MUNH/zDc3pg3/EHaTCjDhl3ZvnALY3qjGKD9bjvN+p4///NFB5zbj6feXi+JzM5
         pMzOb/P3Jc6EXniiE7jSbrfIfzWPyzjEVtp3UsaVk/qoFw4UDKhmhkxIj8TATcDAwggS
         SuJ7bSbLBPNhQsYUiCRe5TNUxMpEYUTPFhGP/D2FcK+spu4KXoJfUdzcwMwREnIs56+S
         ImVuM38siKkBQCaU0VXnfeIFAQPTktig80f95+qjsCqqNp2VN5yKmOc5SFS5A2b+xUrt
         9/CjTz5dPHzhk/9CM5STrKghyrxo1xpvtrw6CoIc40EfNc10Hh/4qF5ZCP2ntjS7i2AH
         U+7A==
X-Gm-Message-State: AOAM531BrAgcxY44XlNYv6GAM2BTaFSRPdwNjfsbgJcE67u58l3M6kk6
        fYq5zPFvxylY9kZpRDoCi9sYkQ==
X-Google-Smtp-Source: ABdhPJy8Og/Kxt/RTljxBsdnRfuGNx4MHBdSJJnHtzty/5ZFtPNZGIzi99L3eRNW+xpVnhT1w0rojA==
X-Received: by 2002:a37:a7cc:: with SMTP id q195mr3449575qke.110.1597435830727;
        Fri, 14 Aug 2020 13:10:30 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3009:7f9d:1da1:7877])
        by smtp.gmail.com with ESMTPSA id y3sm11596848qtj.55.2020.08.14.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:10:29 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:10:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200814201028.GC30103@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <ee5c0db0-6582-f039-96e1-be64ee4fe7a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee5c0db0-6582-f039-96e1-be64ee4fe7a6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 08:29:06AM -0400, Derrick Stolee wrote:
> On 8/11/2020 4:52 PM, Taylor Blau wrote:
> > Introduce a command-line flag and configuration variable to fill in the
> > 'max_new_filters' variable introduced by the previous patch.
> >
> > The command-line option '--max-new-filters' takes precedence over
> > 'commitGraph.maxNewFilters', which is the default value.
> > '--no-max-new-filters' can also be provided, which sets the value back
> > to '-1', indicating that an unlimited number of new Bloom filters may be
> > generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> > '0', hence a custom callback was used instead).
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> ...
>
> > diff --git a/bloom.c b/bloom.c
> > index ed54e96e57..8d07209c6b 100644
> > --- a/bloom.c
> > +++ b/bloom.c
> > @@ -51,6 +51,21 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
> >  	else
> >  		start_index = 0;
> >
> > +	if ((start_index == end_index) &&
> > +	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
> > +		/*
> > +		 * If the filter is zero-length, either (1) the filter has no
> > +		 * changes, (2) the filter has too many changes, or (3) it
> > +		 * wasn't computed (eg., due to '--max-new-filters').
> > +		 *
> > +		 * If either (1) or (2) is the case, the 'large' bit will be set
> > +		 * for this Bloom filter. If it is unset, then it wasn't
> > +		 * computed. In that case, return nothing, since we don't have
> > +		 * that filter in the graph.
> > +		 */
> > +		return 0;
> > +	}
> > +
>
> Here, you are creating a distinction between an "empty" filter and
> a "too large" filter at a place that I don't think is important.
>
> For instance, this code will be triggered by "git log -- <path>"
> but you only care about the filter being too large when writing the
> commit-graph. I think this check for a "too large" filter should
> instead be inside get_or_compute_bloom_filter(). I include a patch
> below that applies on top of tb/bloom-improvements that gets to
> my point (and how minor the issue might be).

That's a good point. I factored the lazy-loading out in basically the
same way that you did below, but didn't move this call out of
'load_bloom_filter_from_graph'. I think that you're right that this is
better at the calling end (replacing the 'start_index == end_index'
check with a '!filter->len' one instead).

I'm going to "ignore" this patch below since I (a) already have it
locally, and (b) would rather just do this correctly the first time than
introduce and subsequently fix a performance regression.

> Thanks,
> -Stolee
>
> --- >8 ---
>
> From 92a7a3d0f769fad7617426730cb97584a3d07794 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Wed, 12 Aug 2020 08:20:03 -0400
> Subject: [PATCH] commit-graph: lazy-load large Bloom filter bitmap
>
> The bloom_large bitmap in struct commit_graph is currently loaded
> immediately upon first parse of the commit-graph file (when the chunk
> exists). This is needed because the current implementation of
> get_bloom_filter_from_graph() is special-cased to return NULL when the
> filter is marked as "too large".
>
> This has a slight drawback: before we can read a single commit out of
> the commit-graph file, we need to load this entire chunk into memory.
> This happens even for commands that don't need changed-path Bloom
> filters, such as "git log -1".
>
> This "too large" information is only used when writing a commit-graph
> file, so we can delay the check for a large filter until after we check
> compute_if_not_present in get_or_compute_bloom_filter(). Also, place
> that lazy-load directly in the get_bloom_filter_large_in_graph() method,
> so we ensure it is ready when needed.
>
> This may be overkill. For a repository with one million commits, this
> filter size is approximately 125 *kilobytes* of data. My local
> measurements found that this took between 1 and 2 milliseconds to load
> into memory. Even for repositories with 10 million commits, this
> difference would not be noticeable for end-user commands.
>
> On the other hand, these handfuls of milliseconds could add up when
> running a hosting service using Git, so this extra effort is probably
> worth it.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c        | 27 ++++++++-------------------
>  commit-graph.c | 30 +++++++++++++++++-------------
>  commit-graph.h |  8 ++++++++
>  3 files changed, 33 insertions(+), 32 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index 8d07209c6b..6d0884fa19 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -51,21 +51,6 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
>  	else
>  		start_index = 0;
>
> -	if ((start_index == end_index) &&
> -	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
> -		/*
> -		 * If the filter is zero-length, either (1) the filter has no
> -		 * changes, (2) the filter has too many changes, or (3) it
> -		 * wasn't computed (eg., due to '--max-new-filters').
> -		 *
> -		 * If either (1) or (2) is the case, the 'large' bit will be set
> -		 * for this Bloom filter. If it is unset, then it wasn't
> -		 * computed. In that case, return nothing, since we don't have
> -		 * that filter in the graph.
> -		 */
> -		return 0;
> -	}
> -
>  	filter->len = end_index - start_index;
>  	filter->data = (unsigned char *)(g->chunk_bloom_data +
>  					sizeof(unsigned char) * start_index +
> @@ -212,16 +197,20 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>
>  	if (!filter->data) {
>  		load_commit_graph_info(r, c);
> -		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
> -			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
> -				return filter;
> +		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
> +			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
>  	}
>
> -	if (filter->data)
> +	if (filter && filter->len)
>  		return filter;
>  	if (!compute_if_not_present)
>  		return NULL;
>
> +	if (filter && !filter->len &&
> +	    get_bloom_filter_large_in_graph(r->objects->commit_graph, c,
> +	    				    settings->max_changed_paths))
> +		return filter;
> +
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
>  	diffopt.detect_rename = 0;
> diff --git a/commit-graph.c b/commit-graph.c
> index 4aae5471e3..ea89f431cc 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -435,17 +435,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>  			if (graph->chunk_bloom_large_filters)
>  				chunk_repeated = 1;
>  			else if (r->settings.commit_graph_read_changed_paths) {
> -				size_t alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
> +				graph->bloom_large_alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
>  				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
>  				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
> -				if (alloc) {
> -					size_t j;
> -					graph->bloom_large = bitmap_word_alloc(alloc);
> -
> -					for (j = 0; j < graph->bloom_large->word_alloc; j++)
> -						graph->bloom_large->words[j] = get_be64(
> -							graph->chunk_bloom_large_filters + j * sizeof(eword_t));
> -				}
>  			}
>  			break;
>  		}
> @@ -953,9 +945,9 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
>  	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
>  }
>
> -static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> -					   const struct commit *c,
> -					   uint32_t max_changed_paths)
> +int get_bloom_filter_large_in_graph(struct commit_graph *g,
> +				    const struct commit *c,
> +				    uint32_t max_changed_paths)
>  {
>  	uint32_t graph_pos = commit_graph_position(c);
>  	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> @@ -964,8 +956,20 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
>  	while (g && graph_pos < g->num_commits_in_base)
>  		g = g->base_graph;
>
> -	if (!(g && g->bloom_large))
> +	if (!g || !g->bloom_large_alloc)
>  		return 0;
> +
> +	if (!g->bloom_large) {
> +		size_t j;
> +		g->bloom_large = bitmap_word_alloc(g->bloom_large_alloc);
> +
> +		for (j = 0; j < g->bloom_large->word_alloc; j++) {
> +			const void *data = g->chunk_bloom_large_filters +
> +					   j * sizeof(eword_t);
> +			g->bloom_large->words[j] = get_be64(data);
> +		}
> +	}
> +
>  	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
>  		/*
>  		 * Force all commits which are subject to a different
> diff --git a/commit-graph.h b/commit-graph.h
> index 75ef83708b..126fd43380 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -51,6 +51,13 @@ void load_commit_graph_info(struct repository *r, struct commit *item);
>  struct tree *get_commit_tree_in_graph(struct repository *r,
>  				      const struct commit *c);
>
> +/*
> + * Returns 1 if this commit was marked in the BFXL chunk as having more
> + * than max_changed_paths changes.
> + */
> +int get_bloom_filter_large_in_graph(struct commit_graph *g,
> +				    const struct commit *c,
> +				    uint32_t max_changed_paths);
>  struct commit_graph {
>  	const unsigned char *data;
>  	size_t data_len;
> @@ -74,6 +81,7 @@ struct commit_graph {
>  	const unsigned char *chunk_bloom_data;
>  	const unsigned char *chunk_bloom_large_filters;
>
> +	size_t bloom_large_alloc;
>  	struct bitmap *bloom_large;
>
>  	struct bloom_filter_settings *bloom_filter_settings;
> --
> 2.28.0.38.gc6f546511c1
>
>

Thanks,
Taylor
