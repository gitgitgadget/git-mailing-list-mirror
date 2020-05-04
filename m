Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9788EC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6400C208DB
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="c1vCTVbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgEDXPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEDXPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:15:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C677C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:15:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so391442plq.12
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oaYbGzkgb/qoW91YU29Xt5LxLs6Uo9eRwb8Uai94Wp4=;
        b=c1vCTVbzbwSLy2638qy3zNxo7vA7gjCBG2KQFLRNDa3h5zzUf0R2gYoH1pj0pMhhAy
         bXVfwB2FbTuR8fS159tNgUIBoXktOsRKaEVVX+o1X/KlTHMO0zwTLrNi+IbC8mcFm877
         U8HR3PjezOhuBFXuTVu5vAvWcHZ/xbEzA4QLVJKToieaO0Ldo5da/6f643l25U5je/h+
         W/KaT96zWgNrGfDbYwwyqoLezzAQ5kTZCqhySjgDItjaoylxknl5dgw2648nikhQKSGt
         be4EEhWwSQyX588IQdfyefYJzI1IHYH7GdgXJflAt7eNXk373d3tUVwDcz0j9tcWR8LN
         x8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaYbGzkgb/qoW91YU29Xt5LxLs6Uo9eRwb8Uai94Wp4=;
        b=QJBQh245QPgjuouq/ga0EgOcaW4urV9Rl7AY7YmciL5IVIeZoaJlfkmkqwHVPnt0Zp
         sn0LFn1Jwrex9H/AwYgwKhlwntfP/5AIX1Z/GBEtTg0fbEsEr7987NAnLPDryTcRP/zt
         BbvAKZRyBX9RbI5q4JKk2xSCkiqofRRzSVBavveRVyQXC3wgoN+odRvwj5HA5DDYDuf2
         eoB2PlItUJtEbv/DkYdJTlNE/Bc5vfsoSaiPnK9rD48nNGVLHFA0lFWpVZ+HNprVASxc
         LjYNxmQWJSP3g5dTxObbrBVqfdlK9PdXNlCfz+8FjIUk3Ck0MNcqTkNwRun+hdLzOG18
         JlAA==
X-Gm-Message-State: AGi0PuZL0a8Jf2IzizRG0r0aYk4xzQs5zYp1FXP69dCN8mEeOhoe8deQ
        UBtYZXlv5p1sb2fxVMy7w5eHoQ==
X-Google-Smtp-Source: APiQypKQwrkFHqDkzqNtu2w2Ov0IXo6jLi6CAQP6xTPi09WexZnSq8+qxB8Vsx4k9Qs5xRsAz/C9lg==
X-Received: by 2002:a17:90a:db53:: with SMTP id u19mr191471pjx.41.1588634145923;
        Mon, 04 May 2020 16:15:45 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f30sm94327pje.29.2020.05.04.16.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:15:45 -0700 (PDT)
Date:   Mon, 4 May 2020 17:15:44 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200504231544.GJ45250@syl.local>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <73de97dfebfccabe9f1bf32ea41aea5008a949cd.1588607262.git.congdanhqx@gmail.com>
 <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <xmqqzhane2ir.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhane2ir.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 03:52:44PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
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
> Hmph, what are we trying to avoid by using the for-ci/ convention?
>
> If this is only a reaction to what I said earlier (i.e. "building
> everything in github.com/gitster/git/ has no value to me"), then I
> suspect it may be an over-engineered solution to a problem that does
> not exist, and harms people like you.  I could just go there and
> turn off GitHub Actions for that repository instead.

It is a reaction to that, yes. It would be nice to have a middle-ground
where you can run Actions on the official integration branches, but
contributors such as myself run Actions on *every* branch of their fork.

It does feel over-engineered, yes. I would not be surprised if Actions
supports something like this more directly, and I just don't know about
it.

> Or are there more issues being addressed with the "testing branches
> are opt-in, unless a pull request against git/git explicitly says it
> is ready to be tested" approach?

Thanks,
Taylor
