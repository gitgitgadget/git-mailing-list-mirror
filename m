Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EFCC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B6A22283
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wFT2lRiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392105AbgJTWTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390635AbgJTWTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:19:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0FC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:19:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j8so454905ilk.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SfnXKJ+1TYzsv5vywECo7vy+9+bwQGZhmaNLRm9cMfY=;
        b=wFT2lRiwGZrVNHB4OAU0nyejN50D6xVffC6VmFqxi2019ernrblCBICbRn7rk6VlEw
         zCND8P44IpC2ORNF3Uof0eQqgXX3qyAEXBQMqoqFY1hzwQHtD6qBuB71sL6KUh43i+5+
         zQ3kPi+HiKtOVzPmBkC0Kkuo+kiaEp0+r6gJqUF6rJrm+R6HQCMl1PIWcvK0s+ziK5KB
         Px9zWtcERQc1Z1t2jdZwURLhrSxZaU8OMIhN67YkDdk5MXs6yVUsZB1zj2MKd7arAmYC
         5x4/sLobDMKZRbqDae0s7ROpEBV+5PvT6zCZY9JUpxkHTGg8TWLcPSXoaz0/u0aNFgqa
         4rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SfnXKJ+1TYzsv5vywECo7vy+9+bwQGZhmaNLRm9cMfY=;
        b=KNQ/6utInZUrM9M3gDIBYsFqBYMwuWSCmYEitvXVSTcqw5QyQ3PPcmIDI8PK6DQ/ct
         dJoGgXlayT+z68HejA/amzLCuwJomXh39DjoKfUYZuvPdDB++Zvu9FxVf38e+5AUrP5+
         JQEYk2ut7EJum5kN0yePMfilRNVWLa5p7M6efA1jrf2TH2lHVPWaGOisDZyH+JefHWIb
         qwA/MoUbzWP3yr3xi/iZfcW7EOIXovczCSVk5MnwSsi6gRErBTTkXlLyhc/dswR0wz1v
         RcFLAvBwGqcgCdaKHpW5Vwen33AG5/DsZz4KRmGD1nAaLKFqqdXE3P2EG9U7+7I79udB
         mjIw==
X-Gm-Message-State: AOAM532Yw7ctRovmDy52Idy80eXYf3+S/ev9ph7h7IfkXPcN9AMC2NaF
        eSltChca65VLvvR1Jt+MdtGZ1Q==
X-Google-Smtp-Source: ABdhPJyYnvxsc/yUV/1x8T+FSlb28NA3yBjrCJiGD8J7D8H9B1eWs+VWsmk6JA28U7lUb7Ddfg7Nig==
X-Received: by 2002:a05:6e02:df0:: with SMTP id m16mr107315ilj.220.1603232379206;
        Tue, 20 Oct 2020 15:19:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id s85sm54078ilk.41.2020.10.20.15.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:19:38 -0700 (PDT)
Date:   Tue, 20 Oct 2020 18:19:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Subject: Re: [PATCH v4 5/7] perf lint: add make test-lint to perf tests
Message-ID: <20201020221936.GA93217@nand.local>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
 <b534cd137a833de802d6d95c1affb8d2d8f7de85.1603201265.git.gitgitgadget@gmail.com>
 <20201020220629.GF75186@nand.local>
 <CAN8Z4-Uedr-6ThkyWCtVgRSrdTW+N0yeOQTUqFtqAj8QsGBEdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8Z4-Uedr-6ThkyWCtVgRSrdTW+N0yeOQTUqFtqAj8QsGBEdQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 11:17:23PM +0100, Nipunn Koorapati wrote:
> > > --- a/t/perf/p3400-rebase.sh
> > > +++ b/t/perf/p3400-rebase.sh
> > > @@ -9,16 +9,16 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
> > >       git checkout -f -B base &&
> > >       git checkout -B to-rebase &&
> > >       git checkout -B upstream &&
> > > -     for i in $(seq 100)
> > > +     for i in $(test_seq 100)
> > >       do
> > >               # simulate huge diffs
> > >               echo change$i >unrelated-file$i &&
> > > -             seq 1000 >>unrelated-file$i &&
> > > +             test_seq 1000 >>unrelated-file$i &&
> > >               git add unrelated-file$i &&
> > >               test_tick &&
> > >               git commit -m commit$i unrelated-file$i &&
> > >               echo change$i >unrelated-file$i &&
> > > -             seq 1000 | tac >>unrelated-file$i &&
> > > +             test_seq 1000 | tac >>unrelated-file$i &&
> >
> > The rest of this all looks good, but I think adding 'tac' here is still
> > wrong; this isn't available everywhere, so we would want to find an
> > alternative before going further. Is there a reason that you couldn't
> > use a different 'N' in 'test_seq N' here?
>
> Hey. I think there's some confusion. I didn't add `tac`. It was
> already here. I didn't even notice it until Junio mentioned it.

You're right, sorry; I just saw a line beginning with '+' that contained
'tac' and thought that it was new in this patch. What you have is OK,
then, since it's not a new problem with your patch.

It couldn't hurt to have the linting phase catch that, but let's leave
that for another day, since I think what you have in this version looks
good to me.

Thanks for listening to all of my feedback :).

> --Nipunn

Thanks,
Taylor
