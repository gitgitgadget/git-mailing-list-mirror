Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CACC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5026F22482
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhAEJqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbhAEJqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 04:46:19 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64424C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 01:45:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id q22so40469642eja.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zniuQdlEW6oehlb8Wuf9c84if7NcIJ28tESWU7Ge1IE=;
        b=HbrvDlfCsLNEaFGytUdlyNQatALPPJXA6rWgPlHoV6aONbVo6q8ms95zUKH9Hm4qQX
         5Ogf642v0Rmf1k6Yz3lswHUC/IbdYJCC092H9nPweHFqCLpdhokQGKXguBbADG6Cfmei
         4zD3E541Y3BwJXZp1+w3TFJHQ+LXfMGNHpCVxjBA236w5X4jtcutXtT8kCbY0eSKipsr
         onEMoiPFN3tbNVE81VVnIzFf/vtbtj4nsvYO/bRctUnkVAF26XyLf8bOWtiiuyyR7FIf
         RUW7k7O5UvbAGJZpYX8F2qEvP99nAJCT/x0CvBa/qeft7rZPjpG+xvQUS2cwG4/FUNTV
         dOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zniuQdlEW6oehlb8Wuf9c84if7NcIJ28tESWU7Ge1IE=;
        b=d9CKiDmW+kvMd3ciyPM6L6mR5NDgAnz18dcAuE3QPfAf7Dz9sEMKOF+95685fpJqco
         ttqMPMJeHEzicstV6GOU+CoDdLD3nTeB1D/m0R3JtdRUNAEcW8l5URRtWsGnRYGOn+LY
         ra5Tnr4psCT75Hm8Dest8VWCDbL4hgY4Slq+KcFLteo7l8/coJOKtW/0QqzIhqaE49Pe
         ft1s5VmoOPDCT4cBWNiZOvHkuG/5qIgbTrkwVOR+zwh35Kk3Qnn278NJ3hW4/KqAZ8hX
         coki+gCi5C563w3fYREp5Sn2aVS1hbOvX+mq4dj8eWsJvvvjcq+HCvYQlp/UdMpq+qws
         lWFQ==
X-Gm-Message-State: AOAM532D+4Babfvw6VKq6TQDfbasMfJwTckftwEMwvUaUNhZ1HaSFfd2
        D7RoA0Yh0SV7Fl3Dnx57BjXNpiZB3Nw=
X-Google-Smtp-Source: ABdhPJyVu5S1O2Ge0r6yQtz/4yhCTzbMUAbn+JiBwlqNtsA+i3UaUg+sQokOXIXVEHeLNwWcWh53wA==
X-Received: by 2002:a17:906:dd3:: with SMTP id p19mr68666702eji.221.1609839937863;
        Tue, 05 Jan 2021 01:45:37 -0800 (PST)
Received: from szeder.dev (84-236-109-79.pool.digikabel.hu. [84.236.109.79])
        by smtp.gmail.com with ESMTPSA id l22sm24530472ejk.14.2021.01.05.01.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 01:45:37 -0800 (PST)
Date:   Tue, 5 Jan 2021 10:45:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v5 01/11] commit-graph: fix regression when computing
 Bloom filters
Message-ID: <20210105094535.GN8396@szeder.dev>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 28, 2020 at 11:15:58AM +0000, Abhishek Kumar via GitGitGadget wrote:
> Before computing Bloom fitlers, the commit-graph machinery uses
> commit_gen_cmp to sort commits by generation order for improved diff
> performance. 3d11275505 (commit-graph: examine commits by generation
> number, 2020-03-30) claims that this sort can reduce the time spent to
> compute Bloom filters by nearly half.

That's true, though there are repositories where it has basically no
effect.  Alas we can't directly test it, because in 3d11275505 there
is no '--changed-paths' option yet... one has to revert 3d11275505 on
top of d38e07b8c4 (commit-graph: add --changed-paths option to write
subcommand, 2020-04-06) to make any runtime comparisons ('git
commit-graph write --reachable --changed-paths', best of five):

                   Sorting by
               pack    | generation
             position  |
    -------------------+------------
    gcc      114.821s  |    38.963s 
    git        8.896s  |     5.620s
    linux    209.984s  |   104.900s
    webkit    35.193s  |    35.482s

Note the almost 3x speedup in the gcc repository, and the basically
negligible slowdown in the webkit repo.

> But since c49c82aa4c (commit: move members graph_pos, generation to a
> slab, 2020-06-17), this optimization is broken, since asking for a
> 'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
> while writing.

I wouldn't say that c49c82aa4c broke this optimisation, because:

did not break that optimization.  Though, sadly, it's not
mentioned in 3d11275505's commit message, when commit_gen_cmp()
compares two commits with identical generation numbers, then it
doesn't leave them unsorted, but falls back to use their committer
date as a tie-braker.  This means that after c49c82aa4c the commits
are sorted by committer date, which appears to be so good a heuristic
for Bloom filter computation that there is barely any slowdown
compared to sorting by generation numbers:

> Not all hope is lost, though: 'commit_graph_generation()' falls back to

You mean commit_gen_cmp() here.

> comparing commits by their date when they have equal generation number,
> and so since c49c82aa4c is purely a date comparision function. This
> heuristic is good enough that we don't seem to loose appreciable
> performance while computing Bloom filters.

Indeed, c49c82aa4c barely caused any runtime difference in the
repositories I usually use to test modified path Bloom filter
performance:

                 c49c82aa4c^  c49c82aa4c
  ---------------------------------------------
  android-base     43.057s     43.091s   0.07%
  cmssw            21.781s     21.856s   0.34%
  cpython           9.626s      9.724s   1.01%
  elasticsearch    18.049s     18.224s   0.96%
  gcc              40.312s     40.255s  -0.14%
  gecko-dev       104.515s    104.740s   0.21%
  git               5.559s      5.570s   0.19%
  glibc             4.455s      4.468s   0.29%
  go                4.009s      4.016s   0.17%
  homebrew-cask    30.759s     30.523s  -0.76%
  homebrew-core    57.122s     56.553s  -0.99%
  jdk              18.297s     18.364s   0.36%
  linux           104.499s    105.302s   0.76%
  llvm-project     34.074s     34.446s   1.09%
  rails             6.472s      6.486s   0.21%
  rust             14.943s     14.947s   0.02%
  tensorflow       13.362s     13.477s   0.86%
  webkit           34.583s     34.601s   0.05%

> Applying this patch (compared
> with v2.29.1) speeds up computing Bloom filters by around ~4
> seconds.

Without a baseline and knowing which repo, this "~4 seconds" is
meaningless.

Here are my results comparing this fix to v2.30.0, best of five:

                              v2.30.0 +
                   v2.30.0    this fix
  ---------------------------------------------
  android-base     42.786s     42.933s   0.34%
  cmssw            20.229s     20.160s  -0.34%
  cpython           9.616s      9.647s   0.32%
  elasticsearch    16.859s     16.936s   0.45%
  gcc              38.909s     36.889s  -5.19%
  gecko-dev        99.417s     98.558s  -0.86%
  git               5.620s      5.509s  -1.97%
  glibc             4.307s      4.301s  -0.13%
  go                3.971s      3.938s  -0.83%
  homebrew-cask    31.262s     30.283s  -3.13%
  homebrew-core    57.842s     55.663s  -3.76%
  jdk              12.557s     12.251s  -2.43%
  linux            94.335s     94.760s   0.45%
  llvm-project     34.432s     33.988s  -1.28%
  rails             6.481s      6.454s  -0.41%
  rust             14.772s     14.601s  -1.15%
  tensorflow       11.759s     11.711s  -0.40%
  webkit           33.917s     33.759s  -0.46%

> So, avoid the useless 'commit_graph_generation()' while writing by
> instead accessing the slab directly. This returns the newly-computed
> generation numbers, and allows us to avoid the heuristic by directly
> comparing generation numbers.
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 06f8dc1d896..caf823295f4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
>  	const struct commit *a = *(const struct commit **)va;
>  	const struct commit *b = *(const struct commit **)vb;
>  
> -	uint32_t generation_a = commit_graph_generation(a);
> -	uint32_t generation_b = commit_graph_generation(b);
> +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> +	uint32_t generation_b = commit_graph_data_at(b)->generation;
>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;
> -- 
> gitgitgadget
> 
