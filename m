Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98ADC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E9D207FF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 16:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oA9AUvks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgFOQ2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgFOQ2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 12:28:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A412C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:28:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h185so8037968pfg.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=thtc+ZAL+Bv0tnxP++fppCRR4mSKHIzILGwttoGAgyQ=;
        b=oA9AUvksCae2jlrgtcaWCCmvM4RqsKwh0Nvx/d3hLP1WXnJ91JlwhgAVJkIsw5uFKQ
         VmSo3S/oRQoyxDbcacosr1Yp4wfEkCo7Um9Jg7zo7Z8T+j2t2oALpekRgRuLlhQjDKRM
         cTvzPBsNvEz5vl9AgLeC8w2CFvWPyWJ6c99bRoNUOZKbdv3l0Rr1MUsxO77+/MfV6AzK
         KtU1psJVopBa4Mi+wFxJnuTpfdmN7+23rbKNr0JJTCW3R5aln97LOQbc8PfYWiAGWkq2
         qlfZ0gjtfZjQNwaXjiTU11wE+WnGV+WgZJckoYiXLz6Y2XQ7sHr9f4e0K1GfWTc3OBYJ
         m/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thtc+ZAL+Bv0tnxP++fppCRR4mSKHIzILGwttoGAgyQ=;
        b=gl4EWwbkQcF9qh53f6mfRjhzkfhvAiraVqeebztrdIBSyK/wEgJW8n4kv7TApuLS99
         b3Hjdr6QaUsWsJgbV/vrNtVQCNhBRSiJO5dMp48ZXTQSka2JdNYgiOsezhm5oWRUJzPG
         ktNRINW7D3F3eIvAHRrVaVG7lc9FIO+ZIzUV12JMQVR+k2Cc8eHj5GenwMMmNvp68rg0
         X/+t6mesQu8qyrOXa0MJIYAIiMFzZ6ZWx9N10r+9DT71vJ2j8v2sxrVSL/DwmfdTXxmX
         Gr7j2L829zrssJ/j8joCDq+d734Qb66/GEmvcalvp6127XhPQJp4x0sX/J4RfZhbJ+/7
         mTfw==
X-Gm-Message-State: AOAM530KF8QOUitJVtidYuVVHN5q5NYyg8ouLrJM652Vb8OrSNzt4UAp
        wMxEu1Y6s1xatmv9XEXirJ3eXw==
X-Google-Smtp-Source: ABdhPJzsBdiRHAieKLtHMsVe1hUuMXGZHpovgHOz1fne53xPL4kzJEoPS6q8pyTM+WpDyfxCTJ19ww==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr23888342pfl.291.1592238481619;
        Mon, 15 Jun 2020 09:28:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w24sm14289772pfn.11.2020.06.15.09.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:28:00 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:27:59 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com, stolee@gmail.com
Subject: Re: [GSOC Patch v2 1/4] commit-graph: introduce
 commit_graph_data_slab
Message-ID: <20200615162759.GB71506@syl.local>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-2-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200607193237.699335-2-abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 08, 2020 at 01:02:34AM +0530, Abhishek Kumar wrote:
> The struct commit is used in many contexts. However, members
> `generation` and `graph_pos` are only used for commit-graph related
> operations and otherwise waste memory.
>
> As they are often accessed together, let's introduce struct
> commit_graph_data and move them to a commit_graph_data slab.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  commit-graph.h | 10 ++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e3420ddcbf..7d887a6a2c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -87,6 +87,55 @@ static int commit_pos_cmp(const void *va, const void *vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>
> +define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
> +static struct commit_graph_data_slab commit_graph_data_slab =
> +	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
> +
> +uint32_t commit_graph_position(const struct commit *c)
> +{
> +	struct commit_graph_data *data =
> +		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> +
> +	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
> +}
> +
> +uint32_t commit_graph_generation(const struct commit *c)
> +{
> +	struct commit_graph_data *data =
> +		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> +
> +	if (!data)
> +		return GENERATION_NUMBER_INFINITY;
> +	if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
> +		return GENERATION_NUMBER_INFINITY;
> +
> +	return data->generation;
> +}
> +
> +static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
> +{
> +	uint32_t i = commit_graph_data_slab.slab_count, j;
> +	uint32_t slab_size = commit_graph_data_slab.slab_size;
> +	struct commit_graph_data *data =
> +		commit_graph_data_slab_at(&commit_graph_data_slab, c);
> +
> +	/*
> +	 * commit-slab initializes elements with zero, overwrite this with
> +	 * COMMIT_NOT_FROM_GRAPH for graph_pos.
> +	 *
> +	 * We avoid the cost of initializing `generation` as generation
> +	 * number would be GENERATION_NUMBER_INFINITY if graph position
> +	 * is COMMIT_NOT_FROM_GRAPH.
> +	 */
> +	for (; i < commit_graph_data_slab.slab_count; i++) {
> +		for (j = 0; j < slab_size; j++) {
> +			commit_graph_data_slab.slab[i][j].graph_pos = COMMIT_NOT_FROM_GRAPH;
> +		}
> +	}
> +
> +	return data;
> +}
> +

It looks like this function ('commit_graph_data_at') is unused in this
patch. No big deal, especially since I can see that you are using it in
the second patch, but I think that you should remove it from this patch
and instead introduce it there.

In fact, this causes a build error (with 'make DEVELOPER=1') because of
'-Wunused-function'. It's good practice to "git rebase -x 'make
DEVELOPER=1' origin/master" before sending.

>  static int commit_gen_cmp(const void *va, const void *vb)
>  {
>  	const struct commit *a = *(const struct commit **)va;
> diff --git a/commit-graph.h b/commit-graph.h
> index 4212766a4f..9d22f98f44 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -137,4 +137,14 @@ void free_commit_graph(struct commit_graph *);
>   */
>  void disable_commit_graph(struct repository *r);
>
> +struct commit_graph_data {
> +	uint32_t graph_pos;
> +	uint32_t generation;
> +};
> +
> +/*
> + * Commits should be parsed before accessing generation, graph positions.
> + */
> +uint32_t commit_graph_generation(const struct commit *);
> +uint32_t commit_graph_position(const struct commit *);
>  #endif
> --
> 2.27.0

Thanks,
Taylor
