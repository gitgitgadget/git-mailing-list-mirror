Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32012C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F4120776
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 19:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="f4o5RkH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH1TH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgH1TH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 15:07:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16166C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 12:07:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o12so462970qki.13
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNeJrGsNQrRX0Wb6dC22eFl1ZiMsAka4DZmJEJn7CXY=;
        b=f4o5RkH9WfsHMkaphUx8Ar0STywwAM2oyxkjxKN+p1GatF7tfXV27dyhdrS5YVzIgK
         P/BOM8crvn8YeLx4ZVVmS+Gng7zZlyt7BBKxP3fFBfJFGiW8XkERSHS8NXdpBQSYhYjY
         5QCDNoJsT6T5dMMJVZ1V36FBuu6R9tosSggx+mHpX66zM4TgQ7JVDkjFhqDtEMEMVWB6
         1cm7DpUQ9xP0nlV1+a4ZOfxYU6vu/a9U6+C96h+mldNhtgoGT5uWd0HsyGK6A6HrH2KT
         O6LM3lmaJ2VlorQxROGgS/fGsDak+BxYbyt6fLOTQ2KeNnsNem4w0RhEV7SgQe2yKr86
         ygkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNeJrGsNQrRX0Wb6dC22eFl1ZiMsAka4DZmJEJn7CXY=;
        b=BtcMtAxWC5yb/xC+rDzM+WrHppIyKdKYzx6c6BLyCYNX1lzljNJ1LA1Pot9Fa/XyTk
         0lIQ53ZDIkzp6YOcyc9+gp22u9k79CH/ttsk9FQyJIl7JFVPrrH8jRbjaUizgzDenrI7
         9lOPTktoxlkjAOH05cSqrBEFcCNgllF13t4GD5uLKa1gh9rYalYSR7+OfxAD05jWeirc
         NZ5lS4nWsSIA8jauXssN5l7/6Ekkd5kzvzzE6EkKLwQ7RufmsA+4ytCKbWvhrG6lSByI
         U3VxveiI05i2THMvZzI90pC/ms3k54qW6j4ZR5IY7SCM4E7aPXLecbBu6UXNHMbRAIHz
         4/1g==
X-Gm-Message-State: AOAM530fmU3vH0CoSVfNMCvsJAUDu4u7OVYygcsKePKFdCj/w1qPxL65
        nGsZEB7rFsBkxS5BDQmZoKlXYw==
X-Google-Smtp-Source: ABdhPJxFhkawCsK6WNF16r4pBfTHTPGjPnZ802uYdd6iPH1GGN9mLqkdt+nrS2AoyDtB98uZRp8pkw==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr568408qkk.293.1598641675918;
        Fri, 28 Aug 2020 12:07:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f08e:2c2d:3ae3:2fac])
        by smtp.gmail.com with ESMTPSA id c185sm618qkb.135.2020.08.28.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:07:54 -0700 (PDT)
Date:   Fri, 28 Aug 2020 15:07:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] midx: traverse the local MIDX first
Message-ID: <20200828190752.GD19328@nand.nand.local>
References: <20200828180621.GA9036@nand.nand.local>
 <20200828185039.GA2171353@coredump.intra.peff.net>
 <20200828185531.GB2171353@coredump.intra.peff.net>
 <80ba7515-dc6c-3acd-4b53-c60cbdab1633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80ba7515-dc6c-3acd-4b53-c60cbdab1633@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 03:03:09PM -0400, Derrick Stolee wrote:
> On 8/28/2020 2:55 PM, Jeff King wrote:
> > On Fri, Aug 28, 2020 at 02:50:39PM -0400, Jeff King wrote:
> >
> >> So I'd be tempted to say that the latter callers should be using a
> >> separate function that gives them what they want. That lets them avoid
> >> being too intimate with the details of how we order things.
> >>
> >> The patch below illustrates that.  It also changes the existing function
> >> name to avoid confusion and to help audit the existing callers, but
> >> that's optional and maybe not worth it.
> >
> > And here's the same concept as a more minimal change, suitable for
> > squashing into yours. The advantage is that it keeps the "the local one
> > goes first" logic in one abstracted spot.
>
> This is nice because it is more future-proof: if we needed to
> change the order of the midx list, then we could update the
> implementation of this method instead of every caller.
>
> Personally, I prefer this one (squashed).

Ditto. Peff and I crossed emails, so I was talking about tidying up his
earlier patch before I even had seen the second one.

Peff -- any objections to me squashing this into mine and sending that
for queueing?

> Thanks,
> -Stolee

Thanks,
Taylor
