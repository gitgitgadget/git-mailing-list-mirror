Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E75FC3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 03:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CCA2087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 03:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KKRfbX2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgBDD7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:59:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38874 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgBDD7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 22:59:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so6701406plj.5
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yHZzaLaW3I5CGeYkk9KeG4nVyU47g0XxgDKtHKjtRjI=;
        b=KKRfbX2pNP116+/dG17rFEjMAmJ/btGBckYP4HNJs3UgoaPp65iJwlVRyJAs1f/Ctv
         7OZmti2UTJCALlfiFla+vxe7H08e8p/ANYRtBi1/szh4Dx75uU1WsT5jL18OSd/k1/6B
         fZ80dSRPXhu2+J3EwXifaf548wxK1m0ly1gc6hQZ1RNJSeKSDCQTzDwAIfyvLPgJinLv
         i7LACIUAZe6HVgBBsF+EHKgAzoxqirK3cfV/1TXvpemVDgeuA/9lwzxvaFAZLRQvFWd6
         gh8LGh2xUrwHkYCVSoc5EKKNUQK6WjK5UUGo+QY6V2VDhhm/twNqaTOoe0Ex0AUgF4zb
         yXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yHZzaLaW3I5CGeYkk9KeG4nVyU47g0XxgDKtHKjtRjI=;
        b=t7GsMjXIgW+HPTyZ7Jsdh6WqHP9wUJeMi5LKu0Gfq5uD1UK+nh9QH9HaOao4L0JBZq
         yHeZ0LdfJt7AHepCRt1xbsUeqTrKTXgyZ51Wj+FToo678VrvtY90Up/MtQvIIl0aJkDc
         A6BcZb8uE2dpiBpJKyTOzkMeGkua9uHVee0VQJtZZtDKBBy9MnQrUs+NT2OLKHMUgV/2
         Fc2p/rLKxYK4UTqE6FRC6UanbqC6wqyvwTx7DrhE8iBipiYdWYUcId/3QkbhblxQ9Mpx
         EUONbt9yPLqn0hhzXXCoyE/DBq58ov+pICM+Xr3f06bXEn54sxIpcmh2elYHzK8G/C3o
         PTPw==
X-Gm-Message-State: APjAAAUQlQp0mfe8HKRKUuhObWYRSymAXuZ0bhqRHxDArr09FwSuwx7/
        qaZWyqxGGWHKh76b9uGny3Fhng==
X-Google-Smtp-Source: APXvYqyD9gN0QjwtUWRExKtnh33CFZBSIQfniJSqIaV6HtUANLM30UD/WPEopFX81hhVaWo3wx7mxg==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr27915588plb.123.1580788780966;
        Mon, 03 Feb 2020 19:59:40 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id w3sm20444263pgj.48.2020.02.03.19.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 19:59:40 -0800 (PST)
Date:   Mon, 3 Feb 2020 19:59:40 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200204035940.GD5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <20200131233434.GJ10482@szeder.dev>
 <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 01, 2020 at 10:25:36PM +0100, Johannes Schindelin wrote:
> Hi,
>
> On Sat, 1 Feb 2020, SZEDER Gábor wrote:
>
> > On Thu, Jan 30, 2020 at 04:28:17PM -0800, Taylor Blau wrote:
> > > diff --git a/commit-graph.c b/commit-graph.c
> > > index 6d34829f57..02e6ad9d1f 100644
> > > --- a/commit-graph.c
> > > +++ b/commit-graph.c
> > > @@ -1565,15 +1565,18 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
> > >  	num_commits = ctx->commits.nr;
> > >  	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
> > >
> > > -	while (g && (g->num_commits <= size_mult * num_commits ||
> > > -		    (max_commits && num_commits > max_commits))) {
> > > -		if (g->odb != ctx->odb)
> > > -			break;
> > > +	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> >
> > This line segfaults in the tests 'fetch.writeCommitGraph' and
> > 'fetch.writeCommitGraph with submodules' in 't5510-fetch.sh', because
> > 'git fetch' doesn't pass a 'split_opts' to the commit-graph functions.
>
> I noticed the same. This patch seems to fix it for me:
>
> -- snip --
> diff --git a/commit-graph.c b/commit-graph.c
> index a5d7624073f..af5c58833cf 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1566,7 +1566,8 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
>  	num_commits = ctx->commits.nr;
>  	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
>
> -	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> +	if (ctx->split_opts &&
> +	    ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
>  		while (g && (g->num_commits <= size_mult * num_commits ||
>  			    (max_commits && num_commits > max_commits) ||
>  			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
> -- snap --
>
> For your convenience, I also pushed this up as
> `tb/commit-graph-split-merge` to https://github.com/dscho/git

Thanks, Dscho. I also published it under the same name on my fork at
'https://github.com/ttaylorr/git'.

> Thanks,
> Dscho
>
>
> >
> > Thread 1 "git" received signal SIGSEGV, Segmentation fault.
> > 0x00000000005113dd in split_graph_merge_strategy (ctx=0x9ca930)
> >     at commit-graph.c:1568
> > 1568            if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
> > (gdb) p *ctx
> > $1 = {r = 0x9ae2a0 <the_repo>, odb = 0x9c0df0, graph_name = 0x0, oids = {
> >     list = 0xa02660, nr = 12, alloc = 1024}, commits = {list = 0x9caa00,
> >     nr = 6, alloc = 6}, num_extra_edges = 0, approx_nr_objects = 0,
> >   progress = 0x0, progress_done = 0, progress_cnt = 0, base_graph_name = 0x0,
> >   num_commit_graphs_before = 0, num_commit_graphs_after = 1,
> >   commit_graph_filenames_before = 0x0, commit_graph_filenames_after = 0x0,
> >   commit_graph_hash_after = 0x0, new_num_commits_in_base = 0,
> >   new_base_graph = 0x0, append = 0, report_progress = 1, split = 1,
> >   check_oids = 0, split_opts = 0x0}
> >                   ^^^^^^^^^^^^^^^^
> > (gdb) bt
> > #0  0x00000000005113dd in split_graph_merge_strategy (ctx=0x9ca930)
> >     at commit-graph.c:1568
> > #1  0x0000000000512446 in write_commit_graph (odb=0x9c0df0, pack_indexes=0x0,
> >     commit_hex=0x7fffffffd550,
> >     flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT),
> >     split_opts=0x0) at commit-graph.c:1891
> > #2  0x000000000050fd86 in write_commit_graph_reachable (odb=0x9c0df0,
> >     flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT),
> >     split_opts=0x0) at commit-graph.c:1174
> >     ^^^^^^^^^^^^^^
> > #3  0x0000000000444ea4 in cmd_fetch (argc=0, argv=0x7fffffffd9b8, prefix=0x0)
> >     at builtin/fetch.c:1873
> > #4  0x0000000000406154 in run_builtin (p=0x969a88 <commands+840>, argc=2,
> >     argv=0x7fffffffd9b0) at git.c:444
> > #5  0x00000000004064a4 in handle_builtin (argc=2, argv=0x7fffffffd9b0)
> >     at git.c:674
> > #6  0x000000000040674c in run_argv (argcp=0x7fffffffd84c, argv=0x7fffffffd840)
> >     at git.c:741
> > #7  0x0000000000406bbd in cmd_main (argc=2, argv=0x7fffffffd9b0) at git.c:872
> > #8  0x00000000004cfd4e in main (argc=5, argv=0x7fffffffd998)
> >     at common-main.c:52
> >
> > Note that this function split_graph_merge_strategy() does look at
> > various fields in 'ctx->split_opts' a bit earlier, but those accesses
> > are protected by a 'if (ctx->split_opts)' condition.
> > expire_commit_graphs() does the same.
> >
> >
> > > +		while (g && (g->num_commits <= size_mult * num_commits ||
> > > +			    (max_commits && num_commits > max_commits) ||
> > > +			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
> > > +			if (g->odb != ctx->odb)
> > > +				break;
> > >
> > > -		num_commits += g->num_commits;
> > > -		g = g->base_graph;
> > > +			num_commits += g->num_commits;
> > > +			g = g->base_graph;
> > >
> > > -		ctx->num_commit_graphs_after--;
> > > +			ctx->num_commit_graphs_after--;
> > > +		}
> > >  	}
> > >
> >

Thanks,
Taylor
