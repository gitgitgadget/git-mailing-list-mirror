Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CAC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B276220663
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QqoHYhgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDV62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDV61 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 17:58:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EADC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 14:58:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so330522plp.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pkv+M9sRcAu8T1ct5uu4c0C372G1vZ/gT0CLg1ZpncA=;
        b=QqoHYhgPf67AlAfSm2URFCh5kdLD6/iuk6rEcMKWEm3P9MoiRqT9lNHFxwJ186UaWa
         QcFY0yXhzTEqkWuNK3n+4xo572KLEauKM4VBRS6pPcY3VTSxFOi9FchOQEMtrsW1hjFl
         Cc43rVOn6meE5TvWCfXUpKPosw0ohC1VIHOVE4l8TzapiEdRap1QkT0G7trPnAwd+XbN
         Za1CxdbBOx4NFKwn4TyicmI9dCfnPcAAWMCUYIvsy5mTC3QlyTHT6cQuzkBkyzKJhfCx
         ds+QQYzwPbQr0yeW1cxwDv+79sQIvbGrXOw/p1+IThEAxQrJAWbtuFlfRpSGK9F2k9/m
         A1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pkv+M9sRcAu8T1ct5uu4c0C372G1vZ/gT0CLg1ZpncA=;
        b=IP9fqJ4iU5LxA8yFH5Ue6+WHFdQlOTq1paN0uy1AFpk4uHB0e68/3LBnA7rOczcrlO
         XyvImQe00Q6pbGqzZl1lLx9iz9MCSmdGB68eRc8AdkQaX/ODl7JYDT9SFC2+qNj3pCWA
         ZAsg6TEmj3K3p+vuLi0Jjd2Lf8PGdsJBU55tAVpig5jEuZR2YkvdQrz08L9cbFft1Goq
         059/CPZA9qEcayHf0BnFlmFla6+BFig2z6Rq5ppsk6U6w2wFAMDdDrvA0TuFf5DjvKXb
         7AX9kCScEpvNTFl8e0g1xht+cKGlDDdo93bPDzbpXn9218rXm+TFKcvFLJTo2ByQbseT
         qqgA==
X-Gm-Message-State: AGi0Pua6csUd6ntV3jdHZAVdWsNEtb3YX8bPIizVNiZZiHkjPNIR8D8H
        VaHRC0C1MvflQ39QqXdGAbqOGZSc4qE=
X-Google-Smtp-Source: APiQypI5OrCA/ychXOrQOJYRemiJxfoIDfLsiAKROa5eGqB966Pm4tRPezW0cXov8/36lEg8TufIAQ==
X-Received: by 2002:a17:902:7141:: with SMTP id u1mr48771plm.164.1588629506645;
        Mon, 04 May 2020 14:58:26 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u14sm32367pgh.71.2020.05.04.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:58:25 -0700 (PDT)
Date:   Mon, 4 May 2020 15:58:24 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200504215824.GC45250@syl.local>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504162311.GE12842@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 12:23:11PM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 10:49:31PM +0700, Đoàn Trần Công Danh wrote:
>
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index fd4df939b5..ea43b03092 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -1,6 +1,18 @@
> >  name: CI/PR
> >
> > -on: [push, pull_request]
> > +on:
> > +  pull_request:
> > +    branches:
> > +      - '**'
>
> Doing "**" here makes sense to catch everything (it would be even better
> if we could just say "everything with a pull request" by omitting the
> branch filter entirely, but maybe that's not possible).
>
> > +    tags:
> > +      - '*'
>
> Would we want that here, too? I guess nobody is likely to push
> "foo/v1.2.3".
>
> Or on the flip side, would we want to tighten this? If I push a tag
> "wip", I probably don't want it built. Probably the right rule is
> "annotated tags only", but I suspect that's not possible.
>
> > +  push:
> > +    branches:
> > +      - maint
> > +      - master
> > +      - next
> > +      - jch
> > +      - pu
>
> What happened to "for-ci" (presumably "for-ci/**")?

Huh; I'm not sure that I'm sold on the idea of a 'for-ci' namespace
here. In addition to running 'make test' on patches locally before I
send them, I find it tremendously convenient for GitHub to run them for
me when I push 'tb/' branches up to 'ttaylorr/git'.

So, while the above is more-or-less what I'd expect the monitored list
of branches to look like (at least, ignoring the missing 'for-ci/**'
bits), I wish that I could also build every branch that I push up to my
fork.

Of course, I don't want to maintain a one-patch difference between
ttaylorr/git@master and git/git@master, so I wonder if we could get a
little more creative with these rules and actually run Actions on
*every* branch, but introduce a new first step which stops the rest of
the actions run (so that in practice we're not running CI on
non-integration branches in Junio's tree).

I figure that we need something more flexible than the 'push.branches'
list, but I'd be very curious to hear if something like what I'm
describing is possible.

> -Peff

Thanks,
Taylor
