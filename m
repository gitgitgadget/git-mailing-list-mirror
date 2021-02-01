Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B18EC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4E964EA0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBASFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBASFF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:05:05 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7728C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 10:04:18 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l14so8583823qvp.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8aKF8b9WsJuK17UKGt7CDNyi8wYvkjxp4FR8oATUOw=;
        b=DxPWn7pyBBq5vXN2Q52lfT2wL2LBWVHiB/XyKF/u2itRrY95Faw6V3JJ7Es08PHuQF
         Dyj5aBdoOmXVDRijM48SkT1ysdRKZ5bTIdENMfSKpWLLT5pkYzsRKU/i708ivNVmHEBi
         g98Z86H6hM/XcvdlR7OHs94dH5MYGAQm/dXcijRbZB4CAGl5UZiKIGdkJV8oPW5lWTHq
         lQ1+DnL9dlyx35mjuZwZJ2/TXRXZCdcPmTHyJFAOP222+gI659C1YKlm9meFqk0V5DAp
         YDlx3fs4RXeA8QqxD2+07sJUF5Ak6e5FwqQVj9YtOWsBDVyq1sYg0/kkDjHCliyTJYMp
         fP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8aKF8b9WsJuK17UKGt7CDNyi8wYvkjxp4FR8oATUOw=;
        b=e3vJwoujEx4SDcaq45Gjc0GhzX1HjlGvwYbnHYvOcr1uIgLrCAQ9FVU4P/4TywOt1x
         m+9vEd4TO68AfeNwF+cs6C7AIoZAunub6dn2Lvw7hoFmHyD1oulSLyX3M6tu1MW1TZ2I
         e0ZymTnybz0i6XOE3d3pNpfKaIUi0H/s+o2NtwRhGJzFy6kQxotWWkH7wnq/c3JhHpd+
         ggS487JsH7hI59K2Wvyom1eWzshVVlyVxWitA4hdOQnSmrNaqDEmF24JdSivpl9NM7M6
         m+Sq9gUEsCKvjJi0vep/27Q0AOUbNY3r2/CBBH6y/3jrv7W59vUjxQlQQfIn96KkLkTv
         MmKQ==
X-Gm-Message-State: AOAM531dUoHWCPVyVfSgF57pnx1Q8Z3/v+Hkp+BdCNAQvjq4RY83fOdB
        iGMIoMx+IWk/Gpp1D18U4HE0hQ==
X-Google-Smtp-Source: ABdhPJyA50bhdACRSpBT+YaixMwt31k2GotojPNWgcNu0Zn6cO01NaXMT7vlf6VN/Eke7iYg00GTUQ==
X-Received: by 2002:a0c:b414:: with SMTP id u20mr16440221qve.57.1612202657717;
        Mon, 01 Feb 2021 10:04:17 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id f125sm14752830qkd.22.2021.02.01.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:04:16 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:04:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/5] commit-graph: be extra careful about mixed
 generations
Message-ID: <YBhChR3ReDhAde87@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <b267a9653a7560d1e59708f20106ef054d140a9f.1612199707.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b267a9653a7560d1e59708f20106ef054d140a9f.1612199707.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 05:15:06PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When upgrading to a commit-graph with corrected commit dates from
> one without, there are a few things that need to be considered.
>
> When computing generation numbers for the new commit-graph file that
> expects to add the generation_data chunk with corrected commit
> dates, we need to ensure that the 'generation' member of the
> commit_graph_data struct is set to zero for these commits.
>
> Unfortunately, the fallback to use topological level for generation
> number when corrected commit dates are not available are causing us
> harm here: parsing commits notices that read_generation_data is
> false and populates 'generation' with the topological level.
>
> The solution is to iterate through the commits, parse the commits
> to populate initial values, then reset the generation values to
> zero to trigger recalculation. This loop only occurs when the
> existing commit-graph data has no corrected commit dates.
>
> While this improves our situation somewhat, we have not completely
> solved the issue for correctly computing generation numbers for mixes
> layers. That follows in the next change.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 13992137dd0..08148dd17f1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1033,7 +1033,8 @@ struct write_commit_graph_context {
>  		 split:1,
>  		 changed_paths:1,
>  		 order_by_pack:1,
> -		 write_generation_data:1;
> +		 write_generation_data:1,
> +		 trust_generation_numbers:1;
>
>  	struct topo_level_slab *topo_levels;
>  	const struct commit_graph_opts *opts;
> @@ -1452,6 +1453,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  		ctx->progress = start_delayed_progress(
>  					_("Computing commit graph generation numbers"),
>  					ctx->commits.nr);
> +
> +	if (ctx->write_generation_data && !ctx->trust_generation_numbers) {
> +		for (i = 0; i < ctx->commits.nr; i++) {
> +			struct commit *c = ctx->commits.list[i];
> +			repo_parse_commit(ctx->r, c);
> +			commit_graph_data_at(c)->generation = GENERATION_NUMBER_ZERO;
> +		}
> +	}
> +

This took me a while to figure out since I spent quite a lot of time
thinking that you were setting the topological level to zero, _not_ the
corrected committer date.

Now that I understand which is which, I agree that this is the right way
to go forward.

That said, I do find it unnecessarily complex that we compute both the
generation number and the topological level in the same loops in
compute_generation_numbers()...

>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		struct commit *c = ctx->commits.list[i];
>  		uint32_t level;
> @@ -1480,7 +1490,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
>
>  				if (level == GENERATION_NUMBER_ZERO ||
> -				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
> +				    (ctx->write_generation_data &&
> +				     corrected_commit_date == GENERATION_NUMBER_ZERO)) {

...for exactly reasons like this. It does make sense that they could be
computed together since their computation is indeed quite similar. But
in practice I think you end up spending a lot of time reasoning around
complex conditionals like these.

So, I feel a little bit like we should spend some effort to split these
up. I'm OK with a little bit of code duplication (though if we can
factor out some common routine, that would also be nice). But I think
there's a tradeoff between DRY-ness and understandability, and that we
might be on the wrong side of it here.

>  					all_parents_computed = 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> @@ -1500,12 +1511,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  					max_level = GENERATION_NUMBER_V1_MAX - 1;
>  				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
>
> -				if (current->date && current->date > max_corrected_commit_date)
> -					max_corrected_commit_date = current->date - 1;
> -				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
> -
> -				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
> -					ctx->num_generation_data_overflows++;
> +				if (ctx->write_generation_data) {
> +					timestamp_t cur_g;
> +					if (current->date && current->date > max_corrected_commit_date)
> +						max_corrected_commit_date = current->date - 1;
> +					cur_g = commit_graph_data_at(current)->generation
> +					      = max_corrected_commit_date + 1;
> +					if (cur_g - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
> +						ctx->num_generation_data_overflows++;
> +				}

Looks like two things happened here:

  - A new local variable was introduced to store the value of
    'commit_graph_data_at(current)->generation' (now called 'cur_g'),
    and

  - All of this was guarded by a conditional on
    'ctx->write_generation_data'.

The first one is a readability improvement, and the second is the
substantive one, no?

>  			}
>  		}
>  	}
> @@ -2396,7 +2410,7 @@ int write_commit_graph(struct object_directory *odb,
>  	} else
>  		ctx->num_commit_graphs_after = 1;
>
> -	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
> +	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
>
>  	compute_generation_numbers(ctx);

Makes sense.

Thanks,
Taylor
