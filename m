Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E6EC433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EE822AAA
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 13:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbhAJNOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 08:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJNOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 08:14:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437E7C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 05:13:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n25so10845061pgb.0
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 05:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=k8jsldVOkH9D+HDB0ShdCagU8ReXy4zu1fDu18TNzxo=;
        b=dbEi2KOMDcyTlns93ZaMFr3iWqQEV9BELKXiWSRkko08Et6Z4mTal7WEpCHjrpXjm9
         5cAF9/Eg8XhDuwqHjU1Nfd8/ZMAPxWog7djv+6kolQdX7CYeG8TxwV5c3y1buXP3jZXc
         VybLTe2rZ17gPdpiySeGtdHrBBCfszzytNGXuL4HKHLsZoF2asl955mbaaxZ8EwtylIF
         DLn8h9Lt5DvyDVxC3RRlKLEBXc8s8en6UYrsQcOwVZJU33Gw2coJ2Lg9XojwZ5M52gtj
         k01zsYyur/nnk8YfuURYlKfCred9jJL2KE/02pWS9eetdivwVy3ImH/Ep3rgzhE7Nc5x
         Uqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=k8jsldVOkH9D+HDB0ShdCagU8ReXy4zu1fDu18TNzxo=;
        b=KeSYpytsmklZN+6EW+0xnCHPAoz6UX53FbXX1rJgiSZIqI0u+vwxJAETnHFu0UCzLl
         WyOS8XHl7w6FuYUIevY3Be9IkiAvyjuzJYqk/dGVXHSB++2bY8VY3XkhT0zsiN5C0qwt
         HzfnoWpRsDMQp3KJMxEDbm/rolDFF6+qvyWf6JEXwbd5jeW24uGCGakg9Y0tUuOfVF/W
         eY+lzzM4/EMT8MApkvtnSYo5Ghpr5noPqItSOP7VRMvzb0X3ULTG9n3QZEtwoTYP4A/u
         fzSU9oZxrrRJLWl5B0iFqDR5kK9mzmx+KmBF6bRmWb8F0wi21xOqWGm2mjicuxikgxBC
         nAdA==
X-Gm-Message-State: AOAM533qHq0+PKvOKgZ7oxZjEoMG1jaSq1/f9d5t4TCRVPe04NcWlejC
        eCx7NP79WQeRJQSPPEwmL5ep+/XU5jdYWg==
X-Google-Smtp-Source: ABdhPJw1KmVFm1Qm2LstWdHeHoB2Zezx562EyhMA3XN1ndqdTVjYySjqSQVG/GFueVulV7q9FqLwOA==
X-Received: by 2002:a63:ca45:: with SMTP id o5mr15434706pgi.48.1610284405191;
        Sun, 10 Jan 2021 05:13:25 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:2e96:3919:aaca:74e3:b7c2:671e])
        by smtp.gmail.com with ESMTPSA id h17sm15297361pfo.220.2021.01.10.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 05:13:24 -0800 (PST)
Date:   Sun, 10 Jan 2021 18:43:47 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v5 09/11] commit-graph: use generation v2 only if entire
 chain does
Message-ID: <X/r9i0HJFEGxuyW/@Abhishek-Arch>
Reply-To: 2e89c6e1-e8e8-0d51-5670-038b4e296d93@gmail.com
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <a3a70a1edd0949ff3088fae625afa68fc61975df.1609154169.git.gitgitgadget@gmail.com>
 <2e89c6e1-e8e8-0d51-5670-038b4e296d93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e89c6e1-e8e8-0d51-5670-038b4e296d93@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 10:23:54PM -0500, Derrick Stolee wrote:
> On 12/28/2020 6:16 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> ...
> 
> > +static void validate_mixed_generation_chain(struct commit_graph *g)
> > +{
> > +	int read_generation_data;
> > +
> > +	if (!g)
> > +		return;
> > +
> > +	read_generation_data = !!g->chunk_generation_data;
> > +
> > +	while (g) {
> > +		g->read_generation_data = read_generation_data;
> > +		g = g->base_graph;
> > +	}
> > +}
> > +
> 
> This method exists to say "use generation v2 if the top layer has it"
> and that helps with the future layer checks.
> 
> > @@ -2239,6 +2263,7 @@ int write_commit_graph(struct object_directory *odb,
> >  		struct commit_graph *g = ctx->r->objects->commit_graph;
> >  
> >  		while (g) {
> > +			g->read_generation_data = 1;
> >  			g->topo_levels = &topo_levels;
> >  			g = g->base_graph;
> >  		}
> 
> However, here you just turn them on automatically.
> 
> I think the diff you want is here:
> 
>  		struct commit_graph *g = ctx->r->objects->commit_graph;
>  
> + 		validate_mixed_generation_chain(g);
> + 
>  		while (g) {
>  			g->topo_levels = &topo_levels;
>  			g = g->base_graph;
>  		}
> 
> But maybe you have a good reason for what you already have.
> 

Thanks, that was an oversight.

My (incorrect) reasoning at the time was:

Since we are computing both topological levels and corrected commit
dates, we can read corrected commit dates from layers with a GDAT chunk
hidden below non-GDAT layer.

But we end up storing both corrected commit date offsets (for a layers with
GDAT chunk) and topological level (for layers without GDAT chunk) in the
same slab with no way to distinguish between the two!

> I paid attention to this because I hit a problem in my local testing.
> After trying to reproduce it, I think the root cause is that I had a
> commit-graph that was written by an older version of your series, so
> it caused an unexpected pairing of an "offset required" bit but no
> offset chunk.
> 
> Perhaps this diff is required in the proper place to avoid the
> segfault I hit, in the case of a malformed commit-graph file:
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index c8d7ed1330..d264c90868 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -822,6 +822,9 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
>  		offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
>  
>  		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
> +			if (!g->chunk_generation_data_overflow)
> +				die(_("commit-graph requires overflow generation data but has none"));
> +
>  			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
>  			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
>  		} else
> 
> Your tests in this patch seem very thorough, covering all the cases
> I could think to create this strange situation. I even tried creating
> cases where the overflow would be necessary. The following test actually
> fails on the "graph_read_expect 6" due to the extra chunk, not the 'write'
> process I was trying to trick into failure.
> 
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 8e90f3423b..cfef8e52b9 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -453,6 +453,20 @@ test_expect_success 'prevent regression for duplicate commits across layers' '
>         git -C dup commit-graph verify
>  '
>  
> +test_expect_success 'upgrade to generation data succeeds when there was none' '
> +	(
> +		cd dup &&
> +		rm -rf .git/objects/info/commit-graph* &&
> +		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph \
> +			write --reachable &&
> +		GIT_COMMITTER_DATE="1980-01-01 00:00" git commit --allow-empty -m one &&
> +		GIT_COMMITTER_DATE="2090-01-01 00:00" git commit --allow-empty -m two &&
> +		GIT_COMMITTER_DATE="2000-01-01 00:00" git commit --allow-empty -m three &&
> +		git commit-graph write --reachable &&
> +		graph_read_expect 6
> +	)
> +'

I am not sure what this test adds over the existing generation data
overflow related tests added in t5318-commit-graph.sh

> +
>  NUM_FIRST_LAYER_COMMITS=64
>  NUM_SECOND_LAYER_COMMITS=16
>  NUM_THIRD_LAYER_COMMITS=7
> 
> Thanks,
> -Stolee

Thanks
- Abhishek
