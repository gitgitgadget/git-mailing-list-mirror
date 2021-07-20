Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C299DC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15DF608FC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhGTRHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhGTRHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:07:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A9C061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:47:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hc15so35581738ejc.4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T2oHsuE8blnn/gdycyK8vXgrAQJzRY/SIITfM3eHpoY=;
        b=F1y6PKLNICu1tpsIxUJLN3X8+m0iIZjfG09tjhj+FGOqYIvdDZnuXPOxfkzfjeVURo
         PqYCpaGylHkkz8Xh9u7jv4mG1h9bSP3TFzMBDtIaisRPVVfI8mj5YL7cwnu4hN1N0wEj
         ull8K63zkxGsN0dFlALfJVgTnn0XupgEsdBnsOqW6D1mAFTTSC2YSXAB6a+xfy5CK7kz
         sNvfqIo4gwvnaIx9lPCIs1fmZDQFSlXo12wvdCnqxQ1C1fYy8XCaq3EaildLyKgBzNMz
         p5KV5ZdbSB+AZIDHlnNTN6ceWnAnCDb7E/C3SsZ3X+WYlbmhd00vxTISWQrs98IWZXGC
         39IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T2oHsuE8blnn/gdycyK8vXgrAQJzRY/SIITfM3eHpoY=;
        b=naHA+ixG7sp2Nd1GJJ1Xn25EvaDeX3hRZ2kTfXj51OLUUvUD5zzm4ZG5qrFer9e+o7
         ZtN80BxtPGK3Ew7mFU1/dznjBr/Y50FBHcyjjIvT5jlV7mt8OHL1C8sTqT+G/b4OGgC4
         w2DHBVFHrWdRj6AUZ7aCaMZoPvzMdHUZTL9Na1VPVBIgZKXAVqZ2uyWAVPt2S0964uw2
         XECIWOs+T4Kz05HI5Lu0Tnpd6J54b+3UY0EWqPUcoZfHzZpUm9PRzUvyl6qi96BbNX0F
         i9AziM0TyGQF9oXIFNm79Wlr3Clk0mupyt3vNqZ6yIVT23PsTQqHLSL0panG+PLivJBM
         E5/g==
X-Gm-Message-State: AOAM533bFxOoqJ67By5IM5TqysCam9IbREjY/kNqcYh/3lHQe/jd/5Id
        9auuaw8hy0oDYL+n2sraAUw=
X-Google-Smtp-Source: ABdhPJyFMebY2D0p6BLEFPMDqXv7eD6lknvJRcxbsbGX0eDWzxxaH4HcbysRx70mEFEbRyL6lHiGCw==
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr33751135ejc.263.1626803263895;
        Tue, 20 Jul 2021 10:47:43 -0700 (PDT)
Received: from szeder.dev (62-165-236-2.pool.digikabel.hu. [62.165.236.2])
        by smtp.gmail.com with ESMTPSA id k21sm7391423ejj.55.2021.07.20.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:47:43 -0700 (PDT)
Date:   Tue, 20 Jul 2021 19:47:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <20210720174739.GA2025@szeder.dev>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 01:39:45PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change the parse_options() invocation in the commit-graph code to make
> sense. We're calling it twice, once for common options parsing, and
> then for the sub-commands.
> 
> But we never checked if we had something leftover in argc in "write"
> or "verify", as a result we'd silently accept garbage in these
> subcommands. Let's not do that.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/commit-graph.c  | 10 ++++++++--
>  t/t5318-commit-graph.sh |  5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index bf34aa43f22..88cbcb5a64f 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -104,7 +104,10 @@ static int graph_verify(int argc, const char **argv)
>  	opts.progress = isatty(2);
>  	argc = parse_options(argc, argv, NULL,
>  			     options,
> -			     builtin_commit_graph_verify_usage, 0);
> +			     builtin_commit_graph_verify_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +	if (argc)
> +		usage_with_options(builtin_commit_graph_verify_usage, options);

Checking 'argc' alone is sufficient to catch unsupported parameters.

Using PARSE_OPT_KEEP_UNKNOWN is not only unnecessary, but arguably
wrong here, because 'git commit-graph write --foo' won't print "error:
unknown option `foo'", and we don't want to pass the remaining
unrecognized options to a different command, like e.g. 'git difftool',
or another parse_options(), like e.g. 'git archive'.

>  	if (!opts.obj_dir)
>  		opts.obj_dir = get_object_directory();
> @@ -261,7 +264,10 @@ static int graph_write(int argc, const char **argv)
>  
>  	argc = parse_options(argc, argv, NULL,
>  			     options,
> -			     builtin_commit_graph_write_usage, 0);
> +			     builtin_commit_graph_write_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +	if (argc)
> +		usage_with_options(builtin_commit_graph_write_usage, options);
>  
>  	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
>  		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index af88f805aa2..09a2ccd2920 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -5,6 +5,11 @@ test_description='commit graph'
>  
>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>  
> +test_expect_success 'usage' '
> +	test_expect_code 129 git commit-graph write blah &&
> +	test_expect_code 129 git commit-graph write verify
> +'
> +
>  test_expect_success 'setup full repo' '
>  	mkdir full &&
>  	cd "$TRASH_DIRECTORY/full" &&
> -- 
> 2.32.0.874.ge7a9d58bfcf
> 
