Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E4C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FD164E3C
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGTvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGTvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:51:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E3C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 11:51:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y8so15744202ede.6
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gGm4S1InOKHbJPPNUCgsDZu1MVsTY4S1ZDMvlgdAiQE=;
        b=PPYqxBjDhXEqkyKAmUa6d6ukcRc/iknzKNZ5+udmMThm6HDz4ZjFy7QPWQw4riRhSD
         AYjiS17CfW2MV8Oeh5CZNVM4IgNXH7zJMtZh7FbTgBy221zYdiHWNf937XamlGMovU6h
         tW2u98knhZ2nUDH/KpL0Y44Ptb4aPZ2jgIF9h2mFQcUcQgwba4MFbRMit0SUYH5HparB
         cK4Jlqmyljq0KEmWt7kP+DoNcvya+Qs3UhVmfTuO7AT68XLSuAtwcE7BlCr6i1eTamSE
         w9GXHB+rHYFdZkpdr9Y/dYrIFJ7wBqRSXiNbDy6fCAeRSF/jfp5dNA3huxrzCYpba1gH
         n5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gGm4S1InOKHbJPPNUCgsDZu1MVsTY4S1ZDMvlgdAiQE=;
        b=LKRjHXVaQqV1I+Lj7xbeZLr+DVnbKC5fXhzt+PJhMW1FppzgAOiXu3jfxczEnCr85b
         VdfluWd/JKRNFdfzbm46cyW1xfBwVa/sxsT8FO16Ar5fO42A/1H+ITDNEZ104eC5d8Oe
         J86CrZaqqzxXDto+GTzrlB104BOhnd0TCzJju2EkZramuIoVtBujvDgAWUi4aotpLzU3
         41+zs4FULzgTnSJJ1eP96Gf0CU7vf3Yzfiqhd/UrtnhF0InYpIrRt/qaxvIT7Ptd+gPB
         0rpU254aNeMhbP1yePASAYMiMLVoAfN4GSfL14yaJlFhkYtxYShzg1+opO0+wDITnrR3
         10ZQ==
X-Gm-Message-State: AOAM531+CSDKwx36lDvXUDuFN6XMO8epTcWsefW0TI6Xbjl5LAncNofS
        0s4EHrXIkgKZkwdCK3l5Pdg=
X-Google-Smtp-Source: ABdhPJy4ewKvWdm0yCDyNGgbjpdRjTSZ7KM4jHVlXIn3K+p2fOMEs0oeAOmsGGP8HiDxe4wXYgsHiA==
X-Received: by 2002:a05:6402:5207:: with SMTP id s7mr13546490edd.311.1612727458940;
        Sun, 07 Feb 2021 11:50:58 -0800 (PST)
Received: from szeder.dev (62-165-236-114.pool.digikabel.hu. [62.165.236.114])
        by smtp.gmail.com with ESMTPSA id k4sm7300437eji.82.2021.02.07.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 11:50:58 -0800 (PST)
Date:   Sun, 7 Feb 2021 20:50:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
Message-ID: <20210207195053.GA1016223@szeder.dev>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
 <xmqq8s834c4s.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s834c4s.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 04:00:19PM -0800, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > When calculating the sizes of certain chunks, we should use 64-bit
> > multiplication always. This allows us to properly predict the chunk
> > sizes without risk of overflow.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  midx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This one I find somewhat questionable for multiple reasons.
> 
>  * the fourth parameter of add_chunk() is of size_t, not uint64_t;
>    shouldn't the multiplication be done in type size_t instead?
> 
>  * these mutiplications were introduced in "midx: use chunk-format
>    API in write_midx_internal()";

No, that patch also removes lines like: 

-       chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + ctx.entries_nr * the_hash_algo->rawsz;

-               chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] +
-                                          ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;

So those potentially problematic multiplications were already there
before this series, and in fact trace all the way back to the initial
midx patch series (commits 0d5b3a5ef7 (midx: write object ids in a 
chunk, 2018-07-12) and 662148c435 (midx: write object offsets,
2018-07-12)).

>    that step should use the
>    arithmetic with cast (if necessary) from the start, no?

As it fixes a long-standing issue, it should rather be a bugfix patch
at the beginning of the series.

