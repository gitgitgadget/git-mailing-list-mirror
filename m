Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D9BC433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 06:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C33B217A0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 06:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLMjtIhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgGNGZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgGNGZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 02:25:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687AFC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 23:25:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so1050998pjb.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oHS1h/vtQqWCv1/S8IA0BCA3DmklykRu8B5aqxFGnsw=;
        b=mLMjtIhSSIEOQ+q8YMkiC6faEunq1NOlHm6Uqqq29PBT+JmAn6eDqdKPLnBYRupiU/
         93B3y1uIvBfG7m2MdhLMNc5wTmxeETqSSaNc6qN2OHqamhbjR93v7/vgVzwznuU0oaI0
         Gxx+FPQLIJ1lVFrO3K/fbvo/61H2dUFDpZPZ8fw1hQ5shxf2fiLLmURvHlB7eL2KtJzX
         2l/YLhuWlmP3BOlBAtla5B7/hlB6ppTVD2FIvo7l/uhbHwBLqvd0SBL1q17QFN+ELjAn
         hw0dlPNnwYE6Nm4UrOeLCHYlyPKoTJ3HUHYvafl3x6c43e5SnuZGeFqByR36F6BUamPm
         sOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=oHS1h/vtQqWCv1/S8IA0BCA3DmklykRu8B5aqxFGnsw=;
        b=AU5+dWZJWC9wSqn1q81Wu5mTcc49bvQu2eWtYuQ4O2gCGy64sVmZKtrCUiGCqgRbl1
         enNM7B9kBWMw20rQyPJi7ICdVnLZxyH0+oUaiMLkrdQ8EXJiv3R5z57cf25R2bkQ94db
         VD5zRBdj0JdlkPw7gn6usr+W+yCW8//CScnxLDxmNc19SIZA615SRAPN41DAlydKrg5K
         DrgPI+x8/YUNkeoXbL56XDVi5WtH18orr5nupVrJJzaCubhxSN6doVkSh3ASWdYjCuOI
         9t5OAjg3vnR5TdLve8OoH+R6sxk+Ds5R4EfnVzCdJShEuRbXXjjX0Yv1vRDc9mIrynez
         dj2Q==
X-Gm-Message-State: AOAM532sou090wyuR3txhp0cTTRxPbxsKeMuUeTMWZwHQC2WsOeWyl3p
        pYC6kLeNe9cV3z3NAm44t9I=
X-Google-Smtp-Source: ABdhPJzAzWNt0POIJmcfs22HHLz7JfQ9IKXQTEt40eCDDNzwBtbjb6xOD8vxnOOUWv7r1f6du6m2kA==
X-Received: by 2002:a17:90a:2dcb:: with SMTP id q11mr3048305pjm.135.1594707937709;
        Mon, 13 Jul 2020 23:25:37 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:e8a:69a1:3523:a8cb:2cbf:c365])
        by smtp.gmail.com with ESMTPSA id 19sm16326676pfy.193.2020.07.13.23.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 23:25:37 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:53:39 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, abhishekkumar8222@gmail.com
Subject: Re: [GSOC] Blog about weeks 4, 5
Message-ID: <20200714062339.GA10242@Abhishek-Arch>
Reply-To: 85imerqj7g.fsf@gmail.com
References: <20200706182213.GA51227@Abhishek-Arch>
 <20200707022425.GA1649@Abhishek-Arch>
 <85imerqj7g.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment
Content-Transfer-Encoding: 8bit
In-Reply-To: <85imerqj7g.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 10:00:03PM +0200, Jakub Narębski wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
> > Hello everyone!
> >
> > Over the last two weeks, I have worked on refining the performance
> > report on generation numbers. Here are our conclusions:
> >
> > - Corrected Commit Dates With Monotonically Offset (i.e.  generation
> >   number v5) performs better than topological levels but is still walks
> >   too many commits when compared with Corrected Commit Dates.
> 
> Thank you for your work examining different approaches to introducing
> generation number v2.
> 
> > Number of commits walked (git merge-base v4.8 v4.9, on linux repository):
> >
> > Topological Level                          : 635579
> > Corrected Commit Date                      : 167468
> > Corrected Commit Date With Monotonic Offset: 506577
> 
> It is a bit strange that requiring monotonic offsets leads to so much
> of a difference in performance (in commits walked).
> 
> >
> > As such, I am expecting that we will store Corrected Commit Date in an
> > additional chunk (called "generation data chunk") and store topological
> > levels into CDAT. Thus, old Git clients can operate as expected, with
> > new Git clients using the better generation number.
> >
> > - Using a new chunk does affect the locality of reference but did not
> >   impact the performance appreciably.
> > - This does increase the size of commit graph file by nearly 5%.
> 
> All right, it seems like it is the way to go.
> 
> > You can read more in my report [1] and the pull request with
> > instructions to replicate the results [2].
> >
> > [1]: https://lore.kernel.org/git/20200703082842.GA28027@Abhishek-Arch/T/#mda33f6e13873df55901768e8fd6d774282002146
> > [2]: https://github.com/abhishekkumar2718/git/pull/1
> >
> > I talk a bit more about a patch I worked on, trying to improve
> > performance of commit graph write using buffers which ultimately did not
> > work and is dropped. Up next is actually implementing the generation
> > number and take care of all little details.
> >
> > https://abhishekkumar2718.github.io/programming/2020/07/05/gsoc-weeks-4-5.html
> >
> > Feedback and suggestions welcome!
> 
> Some comments about the blog entry contents:
> 
> AK> Dr. Stolee pointed out ... [to] use the number of commits as a
> AK> metric instead of wall clock timing (which can be influenced by other
> AK> factors like CPU usage at the time).
> 
> There are a few factors.  If we compare similar algorithms, that might
> be a good decision.
> 
> First, one can try to reduce the influence of random factors on the wall
> clock timing by using statistics.  For example one can try to detect and
> remove outliers by using robust statistics measures to detect them, like
> tools like for example Dumbbench [3], hyperfine [4] or bench [5].  After
> warmup, one approach is to compute the robust estimate of value, e.g.
> median, and robust estimate of dispersion, e.g. MAD = median absolute
> deviation, and use those to detect outliers, e.g. rescale MAD and mark
> as outlier and remove entries that are more than "three sigma" of robust
> dispersion away from robust estimate of value.  Dumbbench [3] has good
> explanation.
> 
> [3]: https://metacpan.org/pod/Dumbbench#HOW-IT-WORKS-AND-WHY-IT-DOESN'T
> [4]: https://github.com/sharkdp/hyperfine
> [5]: https://github.com/Gabriel439/bench

That's interesting. When you think about it, medians are a better
measure than average because medians are robust to the outliers.

> 
> Second, because of pecularities of current processor architecture
> (caches, data prefetching, branch prediction) performing more operations
> might in admittedly rare cases be faster than doing less operations. One
> such example can be found in the CppCon 2019 talk by Andrei Alexandrescu
> "Speed Is Found In The Minds of People" [6][7] about 'small sort', where
> doing more operations results in, on average, faster sort.  This of
> course has a possibility to happen only if difference with the number of
> operations is small enough... nevertheless it might be a good idea to at
> least check that the wall clock time agrees with conclusions from the
> number of commits walked, for at least a few examples.
> 
> [6]: https://www.youtube.com/watch?v=FJJTYQYB1JQ
> [7]: https://github.com/CppCon/CppCon2019/blob/master/Presentations/speed_is_found_in_the_minds_of_people/speed_is_found_in_the_minds_of_people__andrei_alexandrescu__cppcon_2019.pdf
> 
> AK> With the second report, storing corrected commit date in GDAT as
> AK> well as computing topological levels seems like a no-brainer. I have
> AK> started working on the patch and will push to the mailing list after
> AK> some discussion on the report.
> 
> Do you have any numbers how much does providing backward compatibility
> cost at `git commit-graph write`, that is how much more time it takes to
> computer topological levels during computation of corrected
> committerdate compared to storing GENERATION_NUMBER_MAX in place of
> topological level, and whether having topological level (as tie-breaker)
> helps with Git performance when using commit-graphh for querying?  Does
> having topological levels as tie-breaker or secondary negative-cut
> reachability index helps at all?
> 
We do have timings comparing the time to compute topological levels as
compared to storing GENERATION_NUMBER_MAX in place [1]:

Writing GENERATION_NUMBER_MAX to commit-graph: 14.175s
Writing topological levels to commit-graph:    14.331s

That's around 160ms and 1% percent faster.

I do think there's a case to be made for GENERATION_NUMBER_MAX because
the performance degradation for old Git would help in faster adoption
(Junio was in favor of this, the last time we discussed alternatives [2]).
It is a double-edged sword as we force people who cannot upgrade git
into worse performance.

I do not have anything for using topological level as a tie-breaker.
Will benchmark and get back to you.

[1]: https://lore.kernel.org/git/20200630150056.GA4111@Abhishek-Arch/
[2]: https://lore.kernel.org/git/xmqq8sjp1mnz.fsf@gitster.c.googlers.com/

> 
> Thank you for your work and for the report.
> 
> P.S. Would it be possible to put GSoC entries into separate 'GSoC'
> category instead of generic 'Programming' one, or add a 'GSoC' tag?
> 

Great idea! Try this out: https://abhishekkumar2718.github.io/gsoc/

> Best,
> --
> Jakub Narębski
