Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8CC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA8B20DD4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfv+sj4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgIRJXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRJXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 05:23:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2FDC06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 02:23:34 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so7205030eja.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YMPykfCWa995aayHi6H+fmR9gSnNJQHyLVa6bpflJZk=;
        b=tfv+sj4taV3YZ2TN8lTBBdIg0pdmJ7jowcPXGDvM6FmGqKPZRuxSat0HRBPWJSsYDo
         t7hWnphyFZZTe4DoVy5ONNo1U9xQ2mY6sUyY9Qawk5p37c7ClSuMKDinOIKeAdg5Mz1v
         oKelFvTg/Up4bppt088+9HNiFvldzBQqQipC6FChY4UI8mYG4qgOytU35fWlW+wjOJXi
         n/wzqMk1OcxhVrRd49r3fQnCgeNoESeopgXWQISVnKrNNfjwDhlujK0Aads5ByGhu83b
         xyIMM9rPF+TlwjNfvCsiZUN9axTRdf+t7bfQuxQmL284qJ7U7dkZkUjs+FNACvsxFSM0
         bg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMPykfCWa995aayHi6H+fmR9gSnNJQHyLVa6bpflJZk=;
        b=FlIXHJCLBbjWPBCDlNhPIaLLK22GfhxTzcAmItj4CCqQD8YH0e+QD18YPQxMQH33c7
         NUjRikTYW4BYobfMBIXNiIoPx/4d3XIgK1a0m9wHElAPbg7TtNgvSi+Zy/ta625fV15z
         RnvQzkAGQo8jPz44WTh+gf5XXnODhM9CS2a6UEYSmbEJ0VdkxK9sgSsczVVu15oKgH2Q
         SOXbLPR3ZOhE67qQp59Oa2nqrcS14b6hZwKEumjXHpMGln9iKg567mHo5+rljl6K1XdW
         wy8/UZcL2hyPeCuJS/upNR14XFsFUzyFp5avmITj/g+5A4APJL4cQ6zyoSoK1ZdcIW6V
         3WxQ==
X-Gm-Message-State: AOAM532Jmn7pzMXEwmqGtrqQeWtrys643jVxvBGbsw+mNnxiEoCvo5+0
        jxbpNKFr7PEj741MPILojoA=
X-Google-Smtp-Source: ABdhPJytlGv8qmXgoysv2qRAl7LLbGa+0ocnWhe9BoLu3sKYBtIAvR5e2f91km19UZ7dqT3GCZm1dA==
X-Received: by 2002:a17:906:a444:: with SMTP id cb4mr34095668ejb.432.1600421013567;
        Fri, 18 Sep 2020 02:23:33 -0700 (PDT)
Received: from szeder.dev (84-236-109-2.pool.digikabel.hu. [84.236.109.2])
        by smtp.gmail.com with ESMTPSA id k16sm1827119ejg.64.2020.09.18.02.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 02:23:32 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:23:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v2 12/13] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200918092036.GA24813@szeder.dev>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
 <ccb6482feb8d8606d82b5ab97e33184f26d6c5b6.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccb6482feb8d8606d82b5ab97e33184f26d6c5b6.1600279373.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 02:08:10PM -0400, Taylor Blau wrote:
> Introduce a command-line flag to specify the maximum number of new Bloom
> filters that a 'git commit-graph write' is willing to compute from
> scratch.
> 
> Prior to this patch, a commit-graph write with '--changed-paths' would
> compute Bloom filters for all selected commits which haven't already
> been computed (i.e., by a previous commit-graph write with '--split'
> such that a roll-up or replacement is performed).
> 
> This behavior can cause prohibitively-long commit-graph writes for a
> variety of reasons:
> 
>   * There may be lots of filters whose diffs take a long time to
>     generate (for example, they have close to the maximum number of
>     changes, diffing itself takes a long time, etc).
> 
>   * Old-style commit-graphs (which encode filters with too many entries
>     as not having been computed at all) cause us to waste time
>     recomputing filters that appear to have not been computed only to
>     discover that they are too-large.
> 
> This can make the upper-bound of the time it takes for 'git commit-graph
> write --changed-paths' to be rather unpredictable.
> 
> To make this command behave more predictably, introduce
> '--max-new-filters=<n>' to allow computing at most '<n>' Bloom filters
> from scratch. This lets "computing" already-known filters proceed
> quickly, while bounding the number of slow tasks that Git is willing to
> do.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-commit-graph.txt |  5 +++
>  bloom.c                            |  7 ++-
>  builtin/commit-graph.c             | 27 +++++++++++-
>  commit-graph.c                     |  9 +++-
>  commit-graph.h                     |  1 +
>  t/t4216-log-bloom.sh               | 70 ++++++++++++++++++++++++++++++
>  6 files changed, 111 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 17405c73a9..8357846d30 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -67,6 +67,11 @@ this option is given, future commit-graph writes will automatically assume
>  that this option was intended. Use `--no-changed-paths` to stop storing this
>  data.
>  +
> +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
> +filters (if `--changed-paths` is specified).

If '--max-new-filters=42' is specified without '--changed-paths', then
it is silently ignored instead of erroring out.  Is that intentional?

> If `n` is `-1`, no limit is
> +enforced. Commits whose filters are not calculated are stored as a
> +length zero Bloom filter.

This last sentence goes into implementation details of the file
format, so I don't think it should be included here.

What should be documented here instead is what happens later with
those commits for which no modified path Bloom filters were computed.
Will they ever be computed?  If yes, which commands will compute them
(even implicitly), and thus will run slower?  What command(s) should
the users run if they want to compute the missing filters?

Let's suppose that running

  git commit-graph write --reachable --changed-paths --max-new-filters=<L> --split

writes a commit-graph layer containing N1 commits, and N1 > L, so N1-L
commits won't have an associated modified path Bloom filter.  After
creating and fetching new commits, this command is executed again to
add information about N2 commits to the commit-graph, and N2 < L.

  - If this second invocation writes a new commit-graph layer, then it
    will only compute Bloom filters for commits in this new layer,
    even though it still has some "Bloom-computing-capacity" left.
    (This will happen even if this second write were invoked without
    '--max-new-filters'.)

  - If the merge strategy decides that, instead of writing a new
    layer, the new N2 commits should be merged with the layer
    containing the previous N1 commits, then it will compute Bloom
    filters for some or all of those N1 commits without filters,
    depending on whether N2-L is smaller or larger than N1-L.

Is this how it is supposed to work?  We can't tell, because neither
the commit messages nor the documentation updates talk about this.

> ++
>  With the `--split[=<strategy>]` option, write the commit-graph as a
>  chain of multiple commit-graph files stored in
>  `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
