Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB075C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7FB20737
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdhwHbTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbgDATrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:47:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDATrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 15:47:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so1456007wru.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEid6x9NPkwbnWgpDoghI4bzSDN9p2pZZiI0UGhKrLA=;
        b=RdhwHbTPpO56dJHdlCHY5HCM1++4onDJmpDvs5gDgV9TdCUaH1lqGtF8QbD4g2279v
         +dhtXDixEbgfGUEbtv+7bYon9Xy6Vp0jCyL4kUopfmNTaZhbCOTs993m4eS9/3KkLV6/
         8Bv+QN4gtlYEvlwX6r6xY4ryWNUJFAJkQaB5Vka1Smxt2fjZbLsdVeQ5/mojiFcjJHYy
         5xl/ygZAojOcxNXryQYjamv5LINnQn2E8f+MxFPsrwxF3xgRLhtz7MXQjDPnDlilEO4N
         VOAZnvfUiudIzOxlQ94nGGzW+UNLnKcjGGDYbLlXAkY3syo8v4UMEU996ReKTkwaAFvx
         lJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEid6x9NPkwbnWgpDoghI4bzSDN9p2pZZiI0UGhKrLA=;
        b=EXu4HbN0JdTLJTBbDfwvkBBp7tv4rRLBAGu89jbL4/Y2tCaBoJofqRi/OPdfgpPcFn
         DXB4R7unAlnvjp76aiRNc8MtGp7WPl/o1590ZgtDaePCxwBlkxaZzNjy4mUntyTGlZqK
         UnJACE0hKdxXRCAA2kyqJUzC9OHIYNuivoHnqA0n2cUWYEkY+evc8tVTFsMB397/0TG+
         89ngcRNJUGTD+G1GPI2HYeSOwcfEvw0I8H+DhGU3Z98Ic2cGY/JQZ20BGAX5m8EkCjO/
         C5ic8c7rm9ebh2gsozxDMCyBhk7uEfCmR9xoXfFJZxOIpdU4UVQ+Yn/5XUknhF7mP7mK
         UVlw==
X-Gm-Message-State: ANhLgQ0jnRQEn32pj5VRP5XdSkkgMLIInrhE4vjAARGGBU+4yz2ZHPxi
        CaXEKSgfz3pdZ+PHt0D41zLkc5mx
X-Google-Smtp-Source: ADFU+vttfcja9Ucm+Edi2Pci20qFGWMrKbmipVe2XqAHa/dP1E/1b60kA2cQV4ABRVK+rCGY60bqQQ==
X-Received: by 2002:adf:a343:: with SMTP id d3mr26049514wrb.50.1585770429896;
        Wed, 01 Apr 2020 12:47:09 -0700 (PDT)
Received: from szeder.dev (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id o16sm4241377wrw.75.2020.04.01.12.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 12:47:09 -0700 (PDT)
Date:   Wed, 1 Apr 2020 21:47:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
Message-ID: <20200401194706.GE2224@szeder.dev>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 06:11:35PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The commit-graph builtin has an --expire-time option that takes a
> datetime using OPT_EXPIRY_DATE(). However, the implementation inside
> expire_commit_graphs() was treating a non-zero value as a number of
> seconds to subtract from "now".
> 
> Update t5323-split-commit-graph.sh to demonstrate the correct value
> of the --expire-time option by actually creating a crud .graph file
> with mtime earlier than the expire time. Instead of using a super-
> early time (1980) we need to use a recent time or else the old
> logic actually passes by accident. This test will start passing
> again on the old logic in 40 years or so.
> 
> I noticed this when inspecting some Scalar repos that had an excess
> number of commit-graph files. In Scalar, we were using this second
> interpretation by using "--expire-time=3600" to mean "delete graphs
> older than one hour ago" to avoid deleting a commit-graph that a
> foreground process may be trying to load.
> 
> Also I noticed that the help text was copied from the --max-commits
> option. Fix that help text.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     commit-graph: fix buggy --expire-time option
>     
>     This is embarassing. I should have noticed this when writing it the
>     first time, or when integrating the feature into Scalar and VFS for Git.
>     Sorry!
>     
>     Thanks, -Stolee
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-596%2Fderrickstolee%2Fcommit-graph-expire-fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-596/derrickstolee/commit-graph-expire-fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/596
> 
>  builtin/commit-graph.c        | 2 +-
>  commit-graph.c                | 2 +-
>  t/t5324-split-commit-graph.sh | 4 +++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 4a70b33fb5f..8000ff0d2ee 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -140,7 +140,7 @@ static int graph_write(int argc, const char **argv)
>  		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
>  			N_("maximum ratio between two levels of a split commit-graph")),
>  		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
> -			N_("maximum number of commits in a non-base split commit-graph")),
> +			N_("do not expire files newer than a number of seconds before now")),
>  		OPT_END(),
>  	};
>  
> diff --git a/commit-graph.c b/commit-graph.c
> index f013a84e294..0d0d37787a0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1707,7 +1707,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
>  	timestamp_t expire_time = time(NULL);
>  
>  	if (ctx->split_opts && ctx->split_opts->expire_time)
> -		expire_time -= ctx->split_opts->expire_time;
> +		expire_time = ctx->split_opts->expire_time;
>  	if (!ctx->split) {
>  		char *chain_file_name = get_chain_filename(ctx->odb);
>  		unlink(chain_file_name);
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 53b2e6b4555..4e4efcaff22 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
>  		git config core.commitGraph true &&
>  		test_line_count = 2 $graphdir/commit-graph-chain &&
>  		test_commit 15 &&
> -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
> +		touch -m -t 201801010000.00 $graphdir/extra.graph &&

You can set a mtime relative to the current time with:

  test-tool chmtime =-3600 $graphdir/extra.graph


> +		git commit-graph write --reachable --split --size-multiple=10 --expire-time=2019-01-01 &&
>  		test_line_count = 1 $graphdir/commit-graph-chain &&
> +		test_path_is_missing $graphdir/extra.graph &&
>  		ls $graphdir/graph-*.graph >graph-files &&
>  		test_line_count = 3 graph-files
>  	) &&
> 
> base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
> -- 
> gitgitgadget
