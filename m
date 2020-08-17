Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCB3C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 12:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0802F2075B
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 12:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9YcjhU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgHQMMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgHQMMp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:45 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FE8C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 05:12:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so7421164plr.7
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 05:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9WiiYkiroMAsQmQtckdtXiq2mnUHFW2fer91hauY64A=;
        b=U9YcjhU9IlXWpF35X5UaW97cYXTgGQ60sh0mu94jd2neqUcX1xJwhKAcnVc2ZldrwY
         UQO/J4Ns8AqgCZa5jevQ3S7ek7nwjIqsP5kDZAxI2hAKCu211JSNJePFzmbCkunhSVb0
         EQxuRcpiPgU/eGuPhsSTRVl89c9LB09ub7f7WMK/XaVQvjfH2+kjzmQc4rEphigQGFT9
         iIPO87DBYZPij7JA3ZS18DO7fnjyP5H5xL+7LqwVN0GmiSIM0ftLnslDKYmVLrtoV/zn
         c2lQFxHBmYKC2UlMmR6qHNNx/LcfKUM9uvD5oUhskkCzMzh37P012b4BTBigxIfN8CV+
         95WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WiiYkiroMAsQmQtckdtXiq2mnUHFW2fer91hauY64A=;
        b=EVSty8i/Q/9RsWIKsJOCZi8wpWxdY1AjwfY+Y15dBdQboRhY5I97UIadvna2gIQ15V
         XAWDNDxa3pe56AGgD8XVT++TYeAHcNW7o3Z3uUnklPp5o99/gYPmQMink9Rksbiq/pm/
         RZoz2Aeov/neIvx1c6t6J7rwzVrBsOmhf8wm/yiLe6K6/SCgeiYUdLAHMec6SRmXWJB6
         D8tZIBrpTrq8eMO76vb28K1Q7RhGD91Nh+nhEZcn1Oy+R/i7M9yG1CVwy/bwejCpRJvs
         1eZdN63dWiRKzBm+jO/WqivkwLnDlhptQ3GuuM3LuaqDQV/X0mB5KsTEQDIELPRCZaqT
         tvBQ==
X-Gm-Message-State: AOAM5331NUz02Mm8AIEM7pGTkMAbGyf0gPhApsn38Baw965UbsE+I4R5
        FsukzeNQ4NPHUB76paGcidX24Mx1oEeP5A==
X-Google-Smtp-Source: ABdhPJyyqyCYP5CdLTpKvT4VozDwgB8cplX9JNdwoqbjgM8oqkmcXuxbT0fWpbGEs2fLW/wRlp3k/A==
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr11973719pjj.164.1597666364577;
        Mon, 17 Aug 2020 05:12:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id j94sm18191001pje.44.2020.08.17.05.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 05:12:43 -0700 (PDT)
Date:   Mon, 17 Aug 2020 05:12:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200817121239.GA44309@google.com>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
 <xmqqr1sa2znw.fsf@gitster.c.googlers.com>
 <20200815063811.GA628010@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815063811.GA628010@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 15, 2020 at 02:38:11AM -0400, Jeff King wrote:
> 
> On Thu, Aug 13, 2020 at 11:01:23AM -0700, Junio C Hamano wrote:
> 
> > > ---
> > >  Makefile                            |  6 +-----
> > >  builtin.h                           |  1 +
> > >  bugreport.c => builtin/bugreport.c  | 10 +++-------
> > >  contrib/buildsystems/CMakeLists.txt |  5 +----
> > >  git.c                               |  1 +
> > >  5 files changed, 7 insertions(+), 16 deletions(-)
> > >  rename bugreport.c => builtin/bugreport.c (96%)
> > 
> > I am on the fence, as bugreport does not seem to be fully completed
> > part of the system.  The original thinking was that it may soon want
> > to grow by linking with platform specific libraries for lower-level
> > system characteristic identification, at which time we'd not want to
> > have it in builtins and "we can take advantage of builtin niceties"
> > will cause us regrets.  The only reason that hasn't happened as far
> > as I can see is because its development speed is rather slow.
> > 
> > So, I dunno.
> 
> Where do we want to go with this? After the discussion and sleeping on
> it, I'm still of the mind that we should generally default things to
> being builtins unless there's an immediate need not to do so (like
> extra link dependencies). But I don't care _too_ much, so I'd rather
> eject this patch and move forward with the rest of the series if it's a
> sticking point. Thoughts?

Just now catching up. I think it's a fine idea to turn it into a
builtin. As stated elsewhere, this means the version reported is more
reliable (and saves me work which I had on my list to query 'git
version' instead of listing the version when git-bugreport was built).
It's true that there is more work to do on bugreport, it's true that
that work is moving very slowly, as I had a number of things on my plate
even before the world turned upside down :) At the time, Junio seemed
inclined to take git-bugreport as a standalone, and I didn't care very
much one way or another, so it seemed like a fine way to get the series
out of review and into use. As I said then, turning it into a builtin
down the road isn't difficult - so I'm happy with the general direction.

 - Emily

> 
> -Peff
