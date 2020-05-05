Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7214C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64EF20661
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="NojkLEO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgEEAVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgEEAU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:20:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1929C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:20:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a31so227280pje.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OIYsOgV63F5t5v19D4V/R+pLtU7QSZ2+7A3IycjCdgU=;
        b=NojkLEO7G3SPGMOnTMLjUPo/YIlp4uZaGyHXdKVhb+eUqUiLGTrHOhC82GXBJMkshi
         NMQQwxlZmSUvo5XbZ3M8ZmHS2Q1E4BX2XhUGeB3CW1/A5UI5gc7/0qKDzrFlDXvPrixW
         rXliYQvIyEaWa5RkZeRngYZrRT9Mvm9yhf/gH5Z8h+qIwwMnplAkL0eMgMeO+1D2ETa6
         KgEmRUazTluS3wIaM/ZPdnOGWz5uviq5ZGp+0MVrL+pT4h9bSUNxMqT2tC8TzcpOtz/0
         iw5QoOnB/sv59cez9gq1vwpH9+NL+8UjoVgNCJ6mQaq3sPwBbUyPYKyNJ5P3FEw7KFpJ
         /OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OIYsOgV63F5t5v19D4V/R+pLtU7QSZ2+7A3IycjCdgU=;
        b=WDhhBgHQDcJbCd3n9krCkCypfXyo/W7WQqK8qD/U4X1cZB0QD/niL/bqgogGiMfqeh
         LEha2fomILiKrkkjdWywx7NHLIzKK0zX7OFY+of2SUPSYJFRmpGEeA0KKwY7dGQaJFZg
         OhCKR8YASOcdFGNm2G74mA2RvUBrGQwZ64erwgs6jPppzkpZ1XjQz21+6OKrONL7Lb2i
         S4Z37yVOKYCKy+pGnZoQNc1L3GS6k9d1FjNhBb3TgD2CEmMHNs/P2Ut9kTFljgk0KCfO
         mWQ0h2aDTiG/tL6GzN/5RamDMFkHnUFom5/gF/pYpOPjm603lYXAZqdRssPXocMi9r+I
         kE7g==
X-Gm-Message-State: AGi0PuZSU2Fg7pqs3Vwnx62qCcdiSdChUMIGVAybENBpQ+JoQwrsX90B
        Sr7IVMsOjFJ8YGtp1QwCpCgLFg==
X-Google-Smtp-Source: APiQypIfbY1PWqfES8NP0AU2jVVBB6sXShk5hyz7IHM7D4MlHNrGb6s+sYHITBbqu+qH0GEfasxObA==
X-Received: by 2002:a17:90a:2602:: with SMTP id l2mr25067pje.110.1588638057142;
        Mon, 04 May 2020 17:20:57 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v1sm142889pjs.36.2020.05.04.17.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:20:56 -0700 (PDT)
Date:   Mon, 4 May 2020 18:20:55 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200505002055.GC64230@syl.local>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504233634.GB39798@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:36:34PM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 03:58:24PM -0600, Taylor Blau wrote:
>
> > Huh; I'm not sure that I'm sold on the idea of a 'for-ci' namespace
> > here. In addition to running 'make test' on patches locally before I
> > send them, I find it tremendously convenient for GitHub to run them for
> > me when I push 'tb/' branches up to 'ttaylorr/git'.
> >
> > So, while the above is more-or-less what I'd expect the monitored list
> > of branches to look like (at least, ignoring the missing 'for-ci/**'
> > bits), I wish that I could also build every branch that I push up to my
> > fork.
> >
> > Of course, I don't want to maintain a one-patch difference between
> > ttaylorr/git@master and git/git@master, so I wonder if we could get a
> > little more creative with these rules and actually run Actions on
> > *every* branch, but introduce a new first step which stops the rest of
> > the actions run (so that in practice we're not running CI on
> > non-integration branches in Junio's tree).
>
> I don't understand what that would accomplish. If we ran the actions on
> every branch but stopped the run, then you wouldn't get the CI results
> you want. What am I missing?

That on forks of git/git we *would't* stop the run for non-integration
branches, i.e., that we'd have something like:

  * Actions is running on all branches, of all forks, all the time.

  * If a branch is pushed to git/git, and it's not an integration
    branch, the run is aborted early.

  * If a branch is pushed to a fork of git/git, it's allowed to run no
    matter what.

Maybe it's an over-engineered solution to a problem that we don't
have, though. Junio seems happy to simply disable Actions on git/git.
OTOH, I think it would be OK to skip the second bullet point, and
have Junio disable Actions notifications.

/shrug

> -Peff

Thanks,
Taylor
