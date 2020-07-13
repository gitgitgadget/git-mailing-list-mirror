Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181FC433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BDE205CB
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfXupBIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGMUAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMUAI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:00:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C62C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:00:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x9so9521695ljc.5
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GK4F3BwGeAKdeGLLJvLFL4cQjOkav56POJG3CdUww24=;
        b=bfXupBIGdzvoRXQXGTz0y6akxyJMG002hAu4smIdetLKk5MnhRHihFEQtjqCf/bJJA
         uy9LOWAT968vlC49ltULVbtTDt3l7SVwobmR2ftPSGuAOGffzLEv+DyitVB90oTztb1R
         WXHGjWVnF7Yvrg577wufPnzqmkdZoQlAGySXWySrIIZ6tnF4FSL7pqMLdikcRVexXR8A
         Ptxz8q905h05WpZPRcibSX3+ZcSj7DcJgZtJR8pB4WAf9O2lCPrqUtYwGoHMDR8lJfiq
         c6AeuuOc44yAvKKtH7272p7/kz0IDJbMrYbxuZzVxZ4fTv5sgd6Vc6uDJav2b2UnIOrI
         6p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=GK4F3BwGeAKdeGLLJvLFL4cQjOkav56POJG3CdUww24=;
        b=F7d03TJZCv4dzyWD+Epo2LHKtsul4XhPpMZXv0VOxROyxEF5fr7UrJ1S2oEJPfTCL8
         FsEJNBpJHWQvRS4eHJPHaidT5hzF5mC6jgxrU3haj5RmOAd97yeoUYj5SW5UvHS8Ehuv
         mTZg+1Yx1GZ/SPhb+siw2mAiqHf23HUztYWtu7wVzUCrX4BoJlN3hjz0nV6397AsXH91
         SHU5IYURZenkh8SuJzgzEjq9U2h2rrvMi+iHhf2jc3xoOjj4y5F8sRI/k+7K/SGDk3jU
         +jAwJmuNAsI+FLooNtniQjapLgo8DrflNR758UTOkpDjDVHik012Jy83bIbYfJiBrfzh
         PiuQ==
X-Gm-Message-State: AOAM530LjvcoMqa0isOfSOp+VWLUukOKd7Y8IY4KWbtviEdtqgsT77eI
        KALCCOKSnY/nZZbbS7dtODk=
X-Google-Smtp-Source: ABdhPJyrQO3kR1Q2FrO+bsVLEXhus/mCpsgfYtML97fJCYJ03oxQJTKyRJrkiw0rpOVEL/bKTABEZA==
X-Received: by 2002:a05:651c:554:: with SMTP id q20mr582772ljp.137.1594670406551;
        Mon, 13 Jul 2020 13:00:06 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r22sm4227198ljc.25.2020.07.13.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:00:05 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSOC] Blog about weeks 4, 5
References: <20200706182213.GA51227@Abhishek-Arch>
        <20200707022425.GA1649@Abhishek-Arch>
Date:   Mon, 13 Jul 2020 22:00:03 +0200
In-Reply-To: <20200707022425.GA1649@Abhishek-Arch> (Abhishek Kumar's message
        of "Tue, 7 Jul 2020 07:54:25 +0530")
Message-ID: <85imerqj7g.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Hello everyone!
>
> Over the last two weeks, I have worked on refining the performance
> report on generation numbers. Here are our conclusions:
>
> - Corrected Commit Dates With Monotonically Offset (i.e.  generation
>   number v5) performs better than topological levels but is still walks
>   too many commits when compared with Corrected Commit Dates.

Thank you for your work examining different approaches to introducing
generation number v2.

> Number of commits walked (git merge-base v4.8 v4.9, on linux repository):
>
> Topological Level                          : 635579
> Corrected Commit Date                      : 167468
> Corrected Commit Date With Monotonic Offset: 506577

It is a bit strange that requiring monotonic offsets leads to so much
of a difference in performance (in commits walked).

>
> As such, I am expecting that we will store Corrected Commit Date in an
> additional chunk (called "generation data chunk") and store topological
> levels into CDAT. Thus, old Git clients can operate as expected, with
> new Git clients using the better generation number.
>
> - Using a new chunk does affect the locality of reference but did not
>   impact the performance appreciably.
> - This does increase the size of commit graph file by nearly 5%.

All right, it seems like it is the way to go.

> You can read more in my report [1] and the pull request with
> instructions to replicate the results [2].
>
> [1]: https://lore.kernel.org/git/20200703082842.GA28027@Abhishek-Arch/T/#=
mda33f6e13873df55901768e8fd6d774282002146
> [2]: https://github.com/abhishekkumar2718/git/pull/1
>
> I talk a bit more about a patch I worked on, trying to improve
> performance of commit graph write using buffers which ultimately did not
> work and is dropped. Up next is actually implementing the generation
> number and take care of all little details.
>
> https://abhishekkumar2718.github.io/programming/2020/07/05/gsoc-weeks-4-5=
.html
>
> Feedback and suggestions welcome!

Some comments about the blog entry contents:

AK> Dr. Stolee pointed out ... [to] use the number of commits as a
AK> metric instead of wall clock timing (which can be influenced by other
AK> factors like CPU usage at the time).

There are a few factors.  If we compare similar algorithms, that might
be a good decision.

First, one can try to reduce the influence of random factors on the wall
clock timing by using statistics.  For example one can try to detect and
remove outliers by using robust statistics measures to detect them, like
tools like for example Dumbbench [3], hyperfine [4] or bench [5].  After
warmup, one approach is to compute the robust estimate of value, e.g.
median, and robust estimate of dispersion, e.g. MAD =3D median absolute
deviation, and use those to detect outliers, e.g. rescale MAD and mark
as outlier and remove entries that are more than "three sigma" of robust
dispersion away from robust estimate of value.  Dumbbench [3] has good
explanation.

[3]: https://metacpan.org/pod/Dumbbench#HOW-IT-WORKS-AND-WHY-IT-DOESN'T
[4]: https://github.com/sharkdp/hyperfine
[5]: https://github.com/Gabriel439/bench

Second, because of pecularities of current processor architecture
(caches, data prefetching, branch prediction) performing more operations
might in admittedly rare cases be faster than doing less operations. One
such example can be found in the CppCon 2019 talk by Andrei Alexandrescu
"Speed Is Found In The Minds of People" [6][7] about 'small sort', where
doing more operations results in, on average, faster sort.  This of
course has a possibility to happen only if difference with the number of
operations is small enough... nevertheless it might be a good idea to at
least check that the wall clock time agrees with conclusions from the
number of commits walked, for at least a few examples.

[6]: https://www.youtube.com/watch?v=3DFJJTYQYB1JQ
[7]: https://github.com/CppCon/CppCon2019/blob/master/Presentations/speed_i=
s_found_in_the_minds_of_people/speed_is_found_in_the_minds_of_people__andre=
i_alexandrescu__cppcon_2019.pdf

AK> With the second report, storing corrected commit date in GDAT as
AK> well as computing topological levels seems like a no-brainer. I have
AK> started working on the patch and will push to the mailing list after
AK> some discussion on the report.

Do you have any numbers how much does providing backward compatibility
cost at `git commit-graph write`, that is how much more time it takes to
computer topological levels during computation of corrected
committerdate compared to storing GENERATION_NUMBER_MAX in place of
topological level, and whether having topological level (as tie-breaker)
helps with Git performance when using commit-graphh for querying?  Does
having topological levels as tie-breaker or secondary negative-cut
reachability index helps at all?


Thank you for your work and for the report.

P.S. Would it be possible to put GSoC entries into separate 'GSoC'
category instead of generic 'Programming' one, or add a 'GSoC' tag?

Best,
--
Jakub Nar=C4=99bski
