Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E3C33CAC
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 10:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E49220661
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 10:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANHYHl58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBCKrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:47:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgBCKrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 05:47:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so4066382wrt.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 02:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ChPfud2iyHiAWcbz+z+YxYtpAQ9V2EMv+AMelW3Ctq8=;
        b=ANHYHl58D1bxmOsKX2blP6fDjS9b0XbGhZ6uyn2/FeIzrOnvK0n7oHRT6PnL9xYUFv
         pKPqI3+00/ZkqEAFfSDwTUlLonfOmVYGOmZAHyDKa8EDrRr0tVsSoasEQUtXmt2cFrdY
         C44CyxEuQtnvJI61/023Yza8zunOy62Qe1y7LeOhM/IXPzuCWxyJycq+UHp7YNVv182+
         2/icESkXIQ1nWSSLcjLmCPfnxNyhusVRthCupIB8A5PB9BKTyxNtNxzKiP6T0TsMYKNP
         P8XxnzdpbDOvr1tdRKnlSG3KGDSPN6iJSsct/5lGHY4glYj0NKBTU6UudEbzBTsUiqli
         /qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ChPfud2iyHiAWcbz+z+YxYtpAQ9V2EMv+AMelW3Ctq8=;
        b=ptqbibNKOyrR6MoTJbDuetG4RUXQZYhRWUmdnSNu8atTosvyGvLA7wDqGsOfWPbMS1
         HaFlKMZRyXAjD6j9HO8BYRBRC0GwePl44zOtUDvnzFKWa/JMyYt88uslkC8ADKatLi4G
         8XFj6j6g0qNg62S0PfmT6N+7Iz8fXkTgo6Jon/6Y09jXrUNIWUXFUCRAhgyT4GG3IEyD
         Y3i4AUcUOowyCMbPfgHvhfKNkjI5AH47ks9KfTy52meMSI8UyIBKRgvsGHtj7e+vbKTs
         FWnow1qBmNz+nxMxTKk5x9RK+KDFZamC1sSiWEspMeCYLxMSURXb2GfeBIXbqSNhijNF
         65ig==
X-Gm-Message-State: APjAAAXo3Dk4zLxMAM0gyH0t3UyW2Nff3XCX5iie4piEtxIprNetK3LI
        o7bwmL2Ce6KT7n39imF3cBI=
X-Google-Smtp-Source: APXvYqx4wosFL+jYiBRg6QyQUtkRWn4WpaswHS8sv1nIqr3GmnllKr6oQIJMSzocb+8tFsVlxxaRYw==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr14521308wrr.65.1580726854934;
        Mon, 03 Feb 2020 02:47:34 -0800 (PST)
Received: from szeder.dev (x4dbe3314.dyn.telefonica.de. [77.190.51.20])
        by smtp.gmail.com with ESMTPSA id f1sm25005746wro.85.2020.02.03.02.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:47:34 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:47:30 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200203104730.GK10482@szeder.dev>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
 <20200131233434.GJ10482@szeder.dev>
 <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2002012223490.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

Yeah, that's what I noted below, but I'm not sure that this is the
right solution.  Why doesn't cmd_fetch() call
write_commit_graph_reachable() with a real 'split_opts' parameter in
the first place?  Wouldn't it be better if it did?


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

