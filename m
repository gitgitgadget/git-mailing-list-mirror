Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8BC433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D52F23383
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbhAMPfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhAMPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 10:35:38 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1CC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:34:57 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v5so1320244qtv.7
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsLsu6vQeGHUbncAOG/vh+jLfoDmGcLa4XEdCRC3kes=;
        b=ptEElXjDDe+a/QQcVaGbpTWdVueOxljcfjpGOwaHeFZ0domWFPCUu8lM2ai8YawTEd
         HTYdkVbJ9evmQlGPnvqyg1H4HY8glMvi/cPJsqB1Tj0f86DiDVl7i8zyuAYstSFAe21K
         DLy9pzMvPyDysWWyNTAdwfzr8rOEw4ch0QMZ7up/TJiiBI7VA9VWoGAgNkNeMa7f33Pv
         WWlAdsgnA19HEPQV8XADqlt0ywxQ3/eOoRsdAB+LZUzpGuZfVu4MHyYsL3E1/unj97MQ
         puQmZEWNnALlSwK7o4upizdqUOCqDecvH4WpHR9xEP8jnlyjIwz4gQImUlUVQ4qA6MkA
         OG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsLsu6vQeGHUbncAOG/vh+jLfoDmGcLa4XEdCRC3kes=;
        b=pkeYYTo4zjUXawj+6cXEwWq66xCkT7zr6nzaMhi4dfF5rJmazL8S7cJvF8s0uZglNO
         cZZ2/WTto2tKl+rHoggIHOUVuzol+paTs/dz7ey9gV/6H1nOxOOVR4HoQ5c96FK3e+VH
         bYoTlXXTEya8BEU2ARy3/kqiz6vG7/AR3/3txrFqv5mwFQJE6ou++E3LZkr9sMbQiFYo
         eki83MyPjTlsWcskRm/mH80aYmKh71Ig2DVWexNkHeJpn3UbZ8ueT5rQZ83Z1v7sOnhq
         Kvb75GqTM/0VhQVLhuLvIUWOzaAGoPVps2+e4vXKGpqVgpsp3ZEdgn2jTuT0rtih1jw3
         xmag==
X-Gm-Message-State: AOAM531t0WRVfckRmRocWq44jxrMB32+BUFda5quKaLF4wPTPtr3DUV1
        bSc2YJ04s7f/v9tfa/8eBTgDjQ==
X-Google-Smtp-Source: ABdhPJzfKVGkXRLLMbd7QaeC9dr3eOa5voVttzqfvHVhXYp1hkpcOYNWDLvMVmQv0YXLvOEbeQ777A==
X-Received: by 2002:ac8:6b46:: with SMTP id x6mr2691622qts.104.1610552095781;
        Wed, 13 Jan 2021 07:34:55 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id q92sm1100991qtd.48.2021.01.13.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:34:54 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:34:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/8THO3ck3bjJH+K@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <xmqqk0shznvf.fsf@gitster.c.googlers.com>
 <X/5ER+ml/MhDjROA@nand.local>
 <xmqqft35ziog.fsf@gitster.c.googlers.com>
 <X/5nsw6uqKDCHGql@nand.local>
 <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
 <X/7yFdqUmSmRE8A0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/7yFdqUmSmRE8A0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 08:13:57AM -0500, Jeff King wrote:
> On Wed, Jan 13, 2021 at 12:21:12AM -0800, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > If you agree that the bottom topic is stable, I'd prefer to send the top
> > > one separately. Otherwise, I can send both together. Let me know.
> >
> > I do not expect the first 20 of the 20+8 patches to be stable from
> > the beginning---in fact, after reading 01/20 myself, and seeing a
> > few of Peff's reviews, I expect that you'll be redoing at least some
> > of them.
>
> They'll definitely need at least one re-roll. But I think Taylor is
> expecting (and I do too) that the second half will probably have a lot
> more back-and-forth over the on-disk format, and hence need more
> re-rolls.

Indeed, I find the first ~20 patches fairly benign, and I think that the
interesting discussion will and should take place over the final 8
patches.

For what it's worth, I was referring to the pending re-roll I have of
the first 20 patches as the stable one. (Peff notes in [1] that he
thought there wasn't much else to consider beyond his comments.)

> My main concern is reviewer fatigue. 28 patches is a lot. If we can
> solidify the first 20 and then let people focus on the final 8
> separately, that helps. If you're OK with splitting a topic and saying
> "this is a re-roll of just the last 8 patches", then that problem is
> solved. But IMHO it is easier to just point out that split from the
> start than it is to come up with it after the fact. It tells reviewers
> what to expect from the get-go.

Yes, exactly.

> > That way, the bottom part can be merged sooner to 'next' than the
> > rest.  It always is cumbersome to have some part of the series in
> > 'next' and remainder in 'seen', so at that point, the lower half
> > would naturally gain a different name before it gets merged to
> > 'next', I would think.
>
> That seems to me like it ends up being _more_ work than just making them
> into two branches in the first place.

I agree, but I also wasn't aware that you would consider queuing part of
a series. If that's the route you want to take, I'm OK with that. But I
tend to agree with Peff that (in this case since a clear deliniation
already exists) it may save us time to just send two separate series
from the get-go.

> So I guess I remain skeptical that ad-hoc splitting of longer series is
> easier than doing so up front. But you're the one who does all of the
> branch shuffling in the end, so if you really prefer longer series, I'm
> not what I think matters that much. ;)

Agreed. Junio, let me know which you'd prefer in this case (I'm not sure
if the additional context has changed your mind or not).

> -Peff

Thanks,
Taylor

[1]: https://lore.kernel.org/git/X%2F1vy3D10wDEZNva@coredump.intra.peff.net/
