Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A27C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811AA2080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TS3wBCOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHLNpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHLNpP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:45:15 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D41C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:45:13 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so1491569qtt.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Auzju/NTUJ4Rtp/TWPHtYzmaQ+E8oFSmrE8iQ4ByOLw=;
        b=TS3wBCOfElMQgpYegTRVV0pmx9e9wVSAh3l+gNITr1xv7egKlUJZbZOVOCHsg1gzhA
         q+saR+rKNETqbTaEDN5k7kk4q0X44dQYw3zdDnGiOKffJDWSqcZkHouCO5xVsQDDQpdD
         2asHi8I8UJz/KRGq1JJiLMhTykOIY7zBKs3su0BJVqweCotptXjVbm6bNtLyFH7wbvtV
         fdHJhwSyUeUYmwsWLPkATAAt7JRQ0nBKnraWG9Rts27VwJ1j8HAnfhU43fvrC1PmGE7T
         z7Az5hMdtYE5+rR/scBjtLiHC0mHWSK6LwrW84cSc8AzIRse1RuuEdy51P/rOnubFESX
         lnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Auzju/NTUJ4Rtp/TWPHtYzmaQ+E8oFSmrE8iQ4ByOLw=;
        b=TcuccPwHgcqpq4qaq1SZ2uwNndNDhI+BTSVP/5MlCVTL0TBEz6wvWMJ9NNF0O/CPr3
         plxjUldmoVIWP6J5YLSL3wkyqfSW80RuZsKUzXGcr6ZyJsyEjAW+OcS+pWepnpDrO26Q
         4DI9E8ruCYsWkL3jsnUMIRu9DCy5w+P4GKJRts3mgSMGlLyXmORk2nIwTBsDgi+ma3Cf
         sZ3lk3lU00AkqdPIIa2qtIX2P7mXoef4ehfZT40kd2Rr9xuiJGbI17DPiRWLTftBvgwB
         AuGnA97lhV19opUoh5TNvlwVQkgSq3JGwmCFCEa896lYRH8S2RFLcGClqGenCwdsk2g8
         jLgQ==
X-Gm-Message-State: AOAM530rxzFO+qFhDKnFdDc1mItdPjJfK7ZnLKy+V30dSobQqIjWGeSY
        RM7y31KU5XK8+BgQ2yVNavKdEQ==
X-Google-Smtp-Source: ABdhPJwu8M0xoEhdr+Au0IB7yBtRixBaZk94/dqPNxJehIaKgpuHFxLE+Fw4AsmuKnd0LzAxsmYgbg==
X-Received: by 2002:ac8:408f:: with SMTP id p15mr6366934qtl.156.1597239905558;
        Wed, 12 Aug 2020 06:45:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id a203sm2330776qkg.30.2020.08.12.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 06:45:04 -0700 (PDT)
Date:   Wed, 12 Aug 2020 09:45:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        jnareb@gmail.com, me@ttaylorr.com
Subject: Re: [GSoC] Blog about weeks 9, 10
Message-ID: <20200812134503.GA74542@syl.lan>
References: <20200812064627.GA40904@Abhishek-Arch>
 <af5ccced-7cfc-23fb-11ee-244b31b73d20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af5ccced-7cfc-23fb-11ee-244b31b73d20@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 08:45:01AM -0400, Derrick Stolee wrote:
> On 8/12/2020 2:46 AM, Abhishek Kumar wrote:
> > Hello everyone!
> >
> > Over the last two weeks, I worked on handling mixed commit-graph chains
> > and adding tests for the new premises - New Git can work with commit
> > graph files without generation data chunk and New Git handle mixed
> > commit-graph chains gracefully.
> >
> > I apologize for the rather slow progress and missing out on the blog
> > post for Week 9 - My college has re-commenced classes on 3rd August, and
> > the transition to online learning has been chaotic and uncertain.
>
> I don't think your progress has been slow. Your patches are coming
> after careful testing and I'm not seeing any "new contributor" mistakes!
> The only issues I'm seeing are these "higher order" problems related
> to mixed Git versions and striving for "perfect patches".

Better correct and slow than incorrect and quick -- but I don't think
that you are going slowly at all. These are tough problems to solve, and
getting them right is important.

You're doing great, and I don't think that you are going slow at all.

> The early school year is causing chaos all around.

Yes, and best of luck with beginning the school year. Certainly an odd
time (but feel free to reach out to me privately if you want to talk
about contributing to Git as a student).

> Thanks, and keep up the good work.

Seconded :-).

> -Stolee

Thanks,
Taylor
