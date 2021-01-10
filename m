Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8532EC433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4948C23741
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAJOG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 09:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbhAJOG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 09:06:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A02FC061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:06:18 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id e2so8097303plt.12
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NuILEJohHCfHqHNgTCz4CMz7hoZm1X6i55y6AfAiasw=;
        b=KJLsDUKzGT6rFChYB0ebbaXUXV16GoMmcjdt/jjf9LT2KXR5TysEYbOnJRjQrkHb2+
         WeeHCxx90sPeS68MB7d/yNYKGszNqMXmihRoeIt5yDI/+blH1UMnWnSyjgsiH0GFjDTU
         Ldxtbz4gLriV30SICG3a9jx4IzFkkfx9IN3OKAPyV7Gz9JXuDlu+oExWDuE7vHqtWsaa
         39i5MuGzG76hGUKv5xU28D+O18I95YjxeHOcr58ZZKNrneuJk56m2G8oLkelBjYKaRmg
         raYNj3FYfYXY/nGVCrdtYMdh9rzvJDvSETCWHMXSoXjJOah9oyJIYSf150fmW5LR4P3d
         oqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=NuILEJohHCfHqHNgTCz4CMz7hoZm1X6i55y6AfAiasw=;
        b=RjxLEy94oW9qfjwNN6WTueR3HKAt5Yo+camwkvRvB59N+/bk4zlfA3T6MUN6zxFi1i
         BQLxYKgxaoCbpTAy8xMaCYu9ujOxRsN9TmeuvrSljbGkKZDOTusiDkrL888/0W8Nlurz
         +LEFwybWmgQ+2+fYttTqIXi3hUnH0iYTxwZFYGzlMgHvFll1YJDJ8AJkx3yZ9HrHwhRs
         /8xNV/05abc01Tv+griFBmkKWyzmFOUmTkfxYMc14KW7mNJYWSsj5cqiD2/ZNk9bug/O
         2undpRC9tvFLsTaomQr6tgO6we2YgIw8YOxGSDJmOM78Am+WiMOvhQrf9GHQTmUcms6u
         DFug==
X-Gm-Message-State: AOAM532TrwAf2pzrkzmBw1iuvxpY5DGED1srQY7yqwmE34inNPNfFQAW
        +LInaIivEf0VP9j5fWQ2IWA=
X-Google-Smtp-Source: ABdhPJyWvXgUG22FnbbC+tct9hyVad6kIhNRSMVcthdklwPmTP7DqGik/sMa3RsL7UERaNPv+Buswg==
X-Received: by 2002:a17:902:7291:b029:dc:c69:e985 with SMTP id d17-20020a1709027291b02900dc0c69e985mr15447756pll.33.1610287578018;
        Sun, 10 Jan 2021 06:06:18 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:2e96:3919:aaca:74e3:b7c2:671e])
        by smtp.gmail.com with ESMTPSA id b26sm16477141pgm.25.2021.01.10.06.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 06:06:17 -0800 (PST)
Date:   Sun, 10 Jan 2021 19:36:38 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylor.com
Subject: Re: [PATCH v5 00/11] [GSoC] Implement Corrected Commit Date
Message-ID: <X/sJ7gd7g+nnvqNt@Abhishek-Arch>
Reply-To: 1adabda6-b80b-d543-f6c0-570dadbe589b@gmail.com
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <1adabda6-b80b-d543-f6c0-570dadbe589b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1adabda6-b80b-d543-f6c0-570dadbe589b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 11:35:56PM -0500, Derrick Stolee wrote:
> On 12/28/2020 6:15 AM, Abhishek Kumar via GitGitGadget wrote:
> > This patch series implements the corrected commit date offsets as generation
> > number v2, along with other pre-requisites.
> 
> Abhishek,
> 
> Thank you for this version. I appreciate your hard work on this topic,
> especially after GSoC ended and you returned to being a full-time student.
> 
> My hope was that I could completely approve this series and only provide
> forward-fixes from here on out, as necessary. I think there are a few minor
> typos that you might want to address, but I was also able to understand your
> intention.
> 
> I did make a particular case about a SEGFAULT I hit that I have been unable
> to replicate. I saw it both in my copy of torvalds/linux and of
> chromium/chromium. I have the file for chromium/chromium that is in a bad
> state where a GDAT value includes the bit saying it should be in the long
> offsets chunk, but that chunk doesn't exist. Further, that chunk doesn't
> exist in a from-scratch write.

I hope validating mixed generation chain while writing as well was
enough to fix the SEGFAULT.

>
> I'm now taking backups of my existing commit-graph files before any later
> test, but it doesn't repro for my Git repository or any other repo I try on
> purpose.
> 
> However, I did some performance testing to double-check your numbers. I sent
> a patch [1] that helps with some of the hard numbers.
> 
> [1] https://lore.kernel.org/git/pull.828.git.1609302714183.gitgitgadget@gmail.com/
> 
> The big question is whether the overhead from using a slab to store the
> generation values is worth it. I still think it is, for these reasons:
> 
> 1. Generation number v2 is measurably better than v1 in most user cases.
> 
> 2. Generation number v2 is slower than using committer date due to the
>    overhead, but _guarantees correctness_.
> 
> I like to use "git log --graph -<N>" to compare against topological levels
> (v1), for various levels of <N>. When <N> is small, we hope to minimize
> the amount we need to walk using the extra commit-date information as an
> assistance. Repos like git/git and torvalds/linux use the philosophy of
> "base your changes on oldest applicable commit" enough that v1 struggles
> sometimes.
> 
> git/git: N=1000
> 
> 	Benchmark #1: baseline
> 	Time (mean ± σ):     100.3 ms ±   4.2 ms    [User: 89.0 ms, System: 11.3 ms]
> 	Range (min … max):    94.5 ms … 105.1 ms    28 runs
> 	
> 	Benchmark #2: test
> 	Time (mean ± σ):      35.8 ms ±   3.1 ms    [User: 29.6 ms, System: 6.2 ms]
> 	Range (min … max):    29.8 ms …  40.6 ms    81 runs
> 	
> 	Summary
> 	'test' ran
> 	2.80 ± 0.27 times faster than 'baseline'
> 
> This is a dramatic improvement! Using my topo-walk stats commit, I see that
> v1 walks 58,805 commits as part of the in-degree walk while v2 only walks
> 4,335 commits!
> 
> torvalds/linux: N=1000 (starting at v5.10)
> 
> 	Benchmark #1: baseline
> 	Time (mean ± σ):      90.8 ms ±   3.7 ms    [User: 75.2 ms, System: 15.6 ms]
> 	Range (min … max):    85.2 ms …  96.2 ms    31 runs
> 	
> 	Benchmark #2: test
> 	Time (mean ± σ):      49.2 ms ±   3.5 ms    [User: 36.9 ms, System: 12.3 ms]
> 	Range (min … max):    42.9 ms …  54.0 ms    61 runs
> 	
> 	Summary
> 	'test' ran
> 	1.85 ± 0.15 times faster than 'baseline'
> 
> Similarly, v1 walked 38,161 commits compared to 4,340 by v2.
> 
> If I increase N to something like 10,000, then usually these values get
> washed out due to the width of the parallel topics.

That's not too bad, as large N would be needed rather infrequently.

> 
> The place we were still using commit-date as a heuristic was paint_down_to_common
> which caused a regression the first time we used v1, at least for certain cases.
> 
> Specifically, computing the merge-base in torvalds/linux between v4.8 and v4.9
> hit a strangeness about a pair of recent commits both based on a very old commit,
> but the generation numbers forced walking farther than necessary. This doesn't
> happen with v2, but we see the overhead cost of the slabs:
> 
> 	Benchmark #1: baseline
> 	Time (mean ± σ):     112.9 ms ±   2.8 ms    [User: 96.5 ms, System: 16.3 ms]
> 	Range (min … max):   107.7 ms … 118.0 ms    26 runs
> 	
> 	Benchmark #2: test
> 	Time (mean ± σ):     147.1 ms ±   5.2 ms    [User: 132.7 ms, System: 14.3 ms]
> 	Range (min … max):   141.4 ms … 162.2 ms    18 runs
> 	
> 	Summary
> 	'baseline' ran
> 	1.30 ± 0.06 times faster than 'test'
> 
> The overhead still exists for a more recent pair of versions (v5.0 and v5.1):
> 
> 	Benchmark #1: baseline
> 	Time (mean ± σ):      25.1 ms ±   3.2 ms    [User: 18.6 ms, System: 6.5 ms]
> 	Range (min … max):    19.0 ms …  32.8 ms    99 runs
> 	
> 	Benchmark #2: test
> 	Time (mean ± σ):      33.3 ms ±   3.3 ms    [User: 26.5 ms, System: 6.9 ms]
> 	Range (min … max):    27.0 ms …  38.4 ms    105 runs
> 	
> 	Summary
> 	'baseline' ran
> 	1.33 ± 0.22 times faster than 'test'
> 
> I still think this overhead is worth it. In case not everyone agrees, it _might_
> be worth a command-line option to skip the GDAT chunk. That also prevents an
> ability to eventually wean entirely of generation number v1 and allow the commit
> date to take the full 64-bit column (instead of only 34 bits, saving 30 for
> topo-levels).

Thank you for the detailed benchmarking and discussion. 

I don't think there is any disagreement on utility of corrected commit
dates so far. 

We will run out of 34-bits for the commit date by the year 2514, so I
am not exactly worried about weaning of generation number v1 anytime
soon.

> 
> Again, such a modification should not be considered required for this series.
> 
> > ----------------------------------------------------------------------------
> > 
> > Improvements left for a future series:
> > 
> >  * Save commits with generation data overflow and extra edge commits instead
> >    of looping over all commits. cf. 858sbel67n.fsf@gmail.com
> >  * Verify both topological levels and corrected commit dates when present.
> >    cf. 85pn4tnk8u.fsf@gmail.com
> 
> These seem like reasonable things to delay for a later series
> or for #leftoverbits
> 
> Thanks,
> -Stolee
> 

Thanks
- Abhishek
