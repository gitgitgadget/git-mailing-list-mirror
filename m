Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70ECC433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 00:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2EF22251
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 00:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw9sRoOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgJJAzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 20:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgJJAhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 20:37:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7666DC0613D5
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 17:37:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id n9so8585973pgf.9
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2FvHYoVbGOGZs/ZB+tpeQ28bjxBdDyELC+QZ5ZrN29Y=;
        b=Qw9sRoOalQ7RhZdSfG2C1QxHPgS3+xyMyw4s5Hj4tzpo/E3ijephm5L7fi1rXdsUDq
         p+sB0pO6FSC62vbfvm/4LVJhYPdWzXdHVDnYxYbs7Zk9yPVePDP7ljeWb7BmxgpKcBeK
         ei1raLOzUfjWYotBaGCKE8fTwkR1FPpd8JY6XHOoVxTeMbaAKaVnxs3eq6mwlqBqSeye
         tMm9IglegS9TEb6PaXuDdUVbCRjpeAu3DUaKOuJTZL/ERYyod+VRGFdSctYwdXR9Mpvu
         qamBOL1lKZJEVw2R1tIxTDjoN7C6cOp5QC4J09Y+pXDOtcYb445Yb5PN0Zl1hbKe8Wmh
         NZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2FvHYoVbGOGZs/ZB+tpeQ28bjxBdDyELC+QZ5ZrN29Y=;
        b=bcmiwgh9uJetw89EwWmsOzpKp1sAz13UBOqqMosYdvN9z1gjprS58KYgiqlHNTZGjY
         6tld87ZOFoxHV3sEiprYr/XrYQ9bjsWNw+ImT2jWUt7/R8bbEZXcHMYubW0NOD4U/Cef
         Fuh+UYZ1vTnf3JO5RgMwAQUkMlCA5LFlYUnQ4KoV2WAFXFeb7UYEtcaCOiH08THfQpJF
         fhYpJ9p7ueS6gp6zcxSiB6jZ9edQlBa/AoubLXF2Yl7obswMzpog70kC5uEGrRNVJNL/
         BftECjzRSKpbAdJ7vSlyN98DdgMGxA8SVGndShzO8grb8Amhz4AWJl748ZCvUHCr/A6E
         Ktbg==
X-Gm-Message-State: AOAM533egnJJ1/+ZXFC7FBTKfaW8wdOufO8jYkw3FXCayAuD79AnAU7o
        KIlMkid16Hy44NgGEabYCJ2sd1EXwnI=
X-Google-Smtp-Source: ABdhPJyBLTdZV9oN0I2Znzjdlj8utS2ZhgT6ioFdv1mdpC1lli7QRARz0wst//a1xuLQWwqrQsTzdA==
X-Received: by 2002:a17:90b:4c8c:: with SMTP id my12mr6994612pjb.129.1602290223984;
        Fri, 09 Oct 2020 17:37:03 -0700 (PDT)
Received: from localhost ([2402:800:63a8:e735:e424:e5d:450a:d98e])
        by smtp.gmail.com with ESMTPSA id 36sm12203799pgl.72.2020.10.09.17.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 17:37:03 -0700 (PDT)
Date:   Sat, 10 Oct 2020 07:37:01 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
Message-ID: <20201010003701.GC27795@danh.dev>
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
 <20201009015505.GB1314@generichostname>
 <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
 <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
 <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
 <20201009195701.GA967869@coredump.intra.peff.net>
 <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-09 13:33:39-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> 
> > The argument for including it is less clear to me. You say below:
> >
> >> [...]By doing so, we would also prevent a
> >> mistake of not writing "extern" when we need to (i.e. decls of data
> >> items, that are not functions) when less experienced developers try
> >> to mimic how the existing surrounding declarations are written.
> >
> > but to my recollection that has not been a big problem. And it's one
> > that's usually easily caught by the compiler. A missing "extern" on a
> > variable will usually get you a multiple-definition warning at
> > link-time (if you manage to also omit the actual definition you won't
> > see that, though "make sparse" will warn that your variable ought to be
> > static).
> 
> Not really, that is where the "common" extension comes in, to help
> us with it hurt others without it, unknowingly X-<.

Yes, that's where tentative definition jumpes in.
But, tentative definition is known to cause headache to compiler optimization.
And from GCC 10, gcc change to `-fno-common` by default.

We can enable `-fno-common` now if we can detect our compiler is gcc,
but, I don't think it worth to fiddle with Makefile to add that logic.

> 
>         $ cat >a.c <<\EOF
>         #include <stdio.h>
>         #include "c.h"
> 
>         int common = 47;
> 
>         int main(int ac, char **av)
>         {
>             printf("%d\n", common + other);
>             return 0;
>         }
>         EOF
>         $ cat >b.c <<\EOF
>         #include "c.h"
> 
>         int other = 22;
>         EOF
>         $ cat >c.h <<\EOF
>         int common;
>         int other;
>         EOF
>         $ gcc -Wall -o c a.c b.c; ./c
>         59
> 
> And I have a strong preference, after thinking about it, to have
> "extern" in front in the declarations.  It gives another clue for
> patterns I feed to "git grep" to latch onto, and help my eyes to
> scan and tell decls and defns apart in the output.


With this argument, I think adding "extern" is worth it.
It could help people find the code better.

-- 
Danh
