Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A000C33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8FF20663
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1/oGCv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgAaXek (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:34:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38398 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgAaXek (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 18:34:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so10651592wmj.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X3+X7o1awCEhtqIIGub/BDHG8AUlkVKoF9IL9mLGobY=;
        b=T1/oGCv4Q5mzh9V+sR8YpCHbH4WtrtYyvKCSpviyQgXndQQ9pTCwjoPPHFVgLLB/dp
         +LfTDfvZuzLC1RqnvQLqjc7Isi/aPhnuUlFU8WxJX0+113I/5eAW0EwjRTjKTdRFeui4
         hVbEVRD3yVMbumClHqguGiAOSV6qu21AaLI7/f1dcmkGSdMGW4g3qPytOnFXOXJxDmIJ
         bJ9+i1Ja6Br28dnwngbkz4eFta0x8l1MrVvU/upVBMHLWzRQF28YFNSqEks9k2yxuIFN
         Cg/9vhRcCQjNafSDs0uA+wXuDO9JuYe89zMa3ozRwy0KJzs22pUnR2RVaXQ/3o/5U9Ak
         SKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X3+X7o1awCEhtqIIGub/BDHG8AUlkVKoF9IL9mLGobY=;
        b=WlPWlwAfoE5cFIfVdZD6LJyok3RzmXSwghQshalSawzs1cGitQXaxmkTrNj4QcNoL2
         qXOqqQy84CckvlVoNJkUVmaUGIefv6eZhAxSJk76MofgCFYPnRTkt0Jk4E9m+4FwvEr4
         gc/6xSVU++62AxFFQgNQ9i2JtGDlsq1i+ge7ZHI3OqdLa/QXmE+I8vB/MjPntkkb49Kx
         7LWH8JQvC4XzY+sHSRFCA6LNo+ahW1F8uLUdQBjOIFF9dHI2LaeKMC7xA54mcu6RMuhV
         E5/MOeEKZejzxnpm6YQ14zxnilZXzlFY8Mqfq2pACHArrOlAbqa0a/R7bOhPLrqNv1R5
         BB5A==
X-Gm-Message-State: APjAAAXHwoDvufZULWerituCPF4Gwm7OeBMLWoPhpi42YGAOxp3baUAx
        iYTmB1mubfZUercdsjB03S8uuZt3
X-Google-Smtp-Source: APXvYqySn/w9mryn0jVuZIYLywMQF+CJxGa+WrcPtfagyTmb7pjDWdQhec2wUKIuNUUtq2dF6w2Wzg==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr14266323wmj.27.1580513678105;
        Fri, 31 Jan 2020 15:34:38 -0800 (PST)
Received: from szeder.dev (x4db61755.dyn.telefonica.de. [77.182.23.85])
        by smtp.gmail.com with ESMTPSA id u8sm12887531wmm.15.2020.01.31.15.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 15:34:37 -0800 (PST)
Date:   Sat, 1 Feb 2020 00:34:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH 1/3] builtin/commit-graph.c: support
 '--split[=<strategy>]'
Message-ID: <20200131233434.GJ10482@szeder.dev>
References: <cover.1580430057.git.me@ttaylorr.com>
 <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f5bc19903f8a1f5b153b5665de378e743e12744.1580430057.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 04:28:17PM -0800, Taylor Blau wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 6d34829f57..02e6ad9d1f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1565,15 +1565,18 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
>  	num_commits = ctx->commits.nr;
>  	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
>  
> -	while (g && (g->num_commits <= size_mult * num_commits ||
> -		    (max_commits && num_commits > max_commits))) {
> -		if (g->odb != ctx->odb)
> -			break;
> +	if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {

This line segfaults in the tests 'fetch.writeCommitGraph' and
'fetch.writeCommitGraph with submodules' in 't5510-fetch.sh', because
'git fetch' doesn't pass a 'split_opts' to the commit-graph functions.

Thread 1 "git" received signal SIGSEGV, Segmentation fault.
0x00000000005113dd in split_graph_merge_strategy (ctx=0x9ca930)
    at commit-graph.c:1568
1568            if (ctx->split_opts->flags != COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED) {
(gdb) p *ctx
$1 = {r = 0x9ae2a0 <the_repo>, odb = 0x9c0df0, graph_name = 0x0, oids = {
    list = 0xa02660, nr = 12, alloc = 1024}, commits = {list = 0x9caa00, 
    nr = 6, alloc = 6}, num_extra_edges = 0, approx_nr_objects = 0, 
  progress = 0x0, progress_done = 0, progress_cnt = 0, base_graph_name = 0x0, 
  num_commit_graphs_before = 0, num_commit_graphs_after = 1, 
  commit_graph_filenames_before = 0x0, commit_graph_filenames_after = 0x0, 
  commit_graph_hash_after = 0x0, new_num_commits_in_base = 0, 
  new_base_graph = 0x0, append = 0, report_progress = 1, split = 1, 
  check_oids = 0, split_opts = 0x0}
                  ^^^^^^^^^^^^^^^^
(gdb) bt
#0  0x00000000005113dd in split_graph_merge_strategy (ctx=0x9ca930)
    at commit-graph.c:1568
#1  0x0000000000512446 in write_commit_graph (odb=0x9c0df0, pack_indexes=0x0, 
    commit_hex=0x7fffffffd550, 
    flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT), 
    split_opts=0x0) at commit-graph.c:1891
#2  0x000000000050fd86 in write_commit_graph_reachable (odb=0x9c0df0, 
    flags=(COMMIT_GRAPH_WRITE_PROGRESS | COMMIT_GRAPH_WRITE_SPLIT), 
    split_opts=0x0) at commit-graph.c:1174
    ^^^^^^^^^^^^^^
#3  0x0000000000444ea4 in cmd_fetch (argc=0, argv=0x7fffffffd9b8, prefix=0x0)
    at builtin/fetch.c:1873
#4  0x0000000000406154 in run_builtin (p=0x969a88 <commands+840>, argc=2, 
    argv=0x7fffffffd9b0) at git.c:444
#5  0x00000000004064a4 in handle_builtin (argc=2, argv=0x7fffffffd9b0)
    at git.c:674
#6  0x000000000040674c in run_argv (argcp=0x7fffffffd84c, argv=0x7fffffffd840)
    at git.c:741
#7  0x0000000000406bbd in cmd_main (argc=2, argv=0x7fffffffd9b0) at git.c:872
#8  0x00000000004cfd4e in main (argc=5, argv=0x7fffffffd998)
    at common-main.c:52

Note that this function split_graph_merge_strategy() does look at
various fields in 'ctx->split_opts' a bit earlier, but those accesses
are protected by a 'if (ctx->split_opts)' condition.
expire_commit_graphs() does the same.


> +		while (g && (g->num_commits <= size_mult * num_commits ||
> +			    (max_commits && num_commits > max_commits) ||
> +			    (ctx->split_opts->flags == COMMIT_GRAPH_SPLIT_MERGE_REQUIRED))) {
> +			if (g->odb != ctx->odb)
> +				break;
>  
> -		num_commits += g->num_commits;
> -		g = g->base_graph;
> +			num_commits += g->num_commits;
> +			g = g->base_graph;
>  
> -		ctx->num_commit_graphs_after--;
> +			ctx->num_commit_graphs_after--;
> +		}
>  	}
>  
