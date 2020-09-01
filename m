Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E8BC433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4AC206CD
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 12:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB+5RC3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIAMKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgIAMJo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 08:09:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED648C061247
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 05:09:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so569348pjq.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RAfKPmGnZYYP9JtXTIGRZM39AQXuX8qNucpWZzWKXug=;
        b=QB+5RC3bmHDhez5sm0I3nOsH+hU0gAfcjtNbe/R84CqQE1J1a0Xifs7X2RtzAABMnt
         40yqzkGkBDUKYlDRVt2SGHMn/FcDxDGKfEqOodv1QhWCEEjtLs8vkZ2I8s4xtiDrO0ks
         QVXZrFup1L7AC00bY9qywuk9X+EUGuT8wo9lw09joYyKS3NvOBzBSSeLA1cw+zDN7+Nu
         bHCBTdwCKsTH65MHhVDrk6DLFqS0mwnHwGcBTuzSn3RgGDkKegtrdKJMD+pRTH7Cw7Ip
         /cUFXuYTDuJjEbOEd2TYOqlG2vopgod3CLwOrDkeXi6HyxqRQJhz0IfSPVOgzIzwTael
         /74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=RAfKPmGnZYYP9JtXTIGRZM39AQXuX8qNucpWZzWKXug=;
        b=gMtisds6lnFQpwb5wWZMcqoFDhE6CuZXd0gudacfXiWTbbGu4WnRWaY7pm9ML62AJR
         CIBHwLbyiyZXxsy0xmSuQvs1V5BjGPgPvc7AiGIc+Xn96DsFmivD4BSOdno5Q1z/nd3t
         1RRUnW3pWAyjJy8cEFid3YE2NF+F6xjl6tu6E/bqOc1lNg1kEc4LLZUJHWOengMhI1Ui
         xidBNtcuwzRZtr1KNumn3cyczwO36U8r4UEEGGlokAXn822NfkZ/wgFJoPQuMtCCrdwE
         ooew9qy010eNqN5651vov13I84T9NjlWIC3bmfRMwovuYveAalgCcreXpt7aZwRn6Udk
         yIHg==
X-Gm-Message-State: AOAM533J4PPGAqlG2ARGusZwfsS/p/eM60uAzRzbEL+Za2dve52GSFSO
        PcD7Gn0mj+iZLov9P0v/+DQ=
X-Google-Smtp-Source: ABdhPJwbQBWokV2I2+Oy2Web1MXhaLTEG4Jpjg0wx2GDYQWrgC8All904OFHTNxkrgsfe7FvoPr1Fw==
X-Received: by 2002:a17:90a:8e82:: with SMTP id f2mr1318580pjo.11.1598962154315;
        Tue, 01 Sep 2020 05:09:14 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:79b:52ed:48f6:b1a4:ca3c:754b])
        by smtp.gmail.com with ESMTPSA id v11sm1947510pgs.22.2020.09.01.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 05:09:13 -0700 (PDT)
Date:   Tue, 1 Sep 2020 17:36:53 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        me@ttaylorr.com
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
Message-ID: <20200901120653.GA59580@Abhishek-Arch>
Reply-To: 85ft8adilr.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
 <85d03km98l.fsf@gmail.com>
 <20200825050448.GA21012@Abhishek-Arch>
 <85ft8adilr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85ft8adilr.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 02:18:24PM +0200, Jakub Narębski wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
> ...
> 
> However, as I wrote, handling GENERATION_NUMBER_V2_OFFSET_MAX is
> difficult.  As far as I can see, we can choose one of the *three*
> solutions (the third one is _new_):
> 
> a. store 64-bit corrected commit date in the GDAT chunk
>    all possible values are able to be stored, no need for
>    GENERATION_NUMBER_V2_MAX,
> 
> b. store 32-bit corrected commit date offset in the GDAT chunk,
>    if its value is larger than GENERATION_NUMBER_V2_OFFSET_MAX,
>    do not write GDAT chunk at all (like for backward compatibility
>    with mixed-version chains of split commit-graph layers),
> 
> c. store 32-bit corrected commit date offset in the GDAT chunk,
>    using some kind of overflow handling scheme; for example if
>    the most significant bit of 32-bit value is 1, then the
>    rest 31-bits are position in GDOV chunk, which uses 64-bit
>    to store those corrected commit date offsets that do not
>    fit in 32 bits.
> 

Alright, so the third solution leverages the fact that in practice,
very few offsets would overflow the 32-bit limit. Using 64-bits for all
offsets would be wasteful, we can trade off a miniscule amount of
computation to save large amounts of disk space.

>
> This type of schema is used in other places in Git code, if I remember
> it correctly.
> 

Yes, it's a similar idea to the extra edge list chunk, where the most
significant bit of second parent indicates whether they are more than
two parents.

It's definitely feasible, albeit a little complex.

What's the overall consensus on the third solution?

>
> >> The commit message says nothing about the new symbolic constant
> >> GENERATION_NUMBER_V1_INFINITY, though.
> >>
> >> I'm not sure it is even needed (see comments below).
> >
> > Yes, you are correct. I tried it out with your suggestions and it wasn't
> > really needed.
> >
> > Thanks for catching this!
> 
> Mistakes can happen when changig how the series is split into commits.
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
