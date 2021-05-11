Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E5DC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660C5613CA
	for <git@archiver.kernel.org>; Tue, 11 May 2021 04:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhEKE3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 00:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhEKE3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 00:29:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDB3C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 21:27:56 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u16so17900061oiu.7
        for <git@vger.kernel.org>; Mon, 10 May 2021 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CzrMFVuUYIxkkHgWZ7P0gkQr2w0xEQ3EFTHlFJro/HA=;
        b=XccI8QKE9scMrknMTjRjpMbjqNtrG26btNlBa7bDTNUyrr1QkeIZyITszoaqWPcspw
         xKhHrZUb6VKdG1wrC83xqtb6cygaKnEhyoqz3qTnFyzrUIK9T0G7Thg0j4coSIV2ib8J
         vSWbRqlg7SyG1e/3bFQFOD5dJ55+cnR09DGmo+mvjZ8JYUTce9HdDS9eOTPLJAb4S/Dc
         0T2k67FA8OrGmGPRSQggh7yGKP3jSE9hO1MapG5NMb0yMLXLW/6J7Saa0XAh5mGZy4xp
         DhB3hfUZSFNbQx4W7xyISbwK/XGE2SPdClMmVa7Ndnon/utsDFh/oCOlsxeqypRRmz2x
         YRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CzrMFVuUYIxkkHgWZ7P0gkQr2w0xEQ3EFTHlFJro/HA=;
        b=fXxugVu0BjGMiw2nmTnNp5POVXhYwVW504OkfZyg/iJD4Y4wVlLVVG9n5jCLUGWqmb
         ycdVMGwrgpgnUcecDZBEiScQheTLE5d9Z0LEAAzx37G56KfhSspNd/VGiPW+YCchPBev
         Ns92s2VGiCjZb4jRr0SVpFJtMkuKKNkMAxErBZn+R7PT0LK7oLO4VXBDEZKE0DGx+Rcl
         1grwbo6ltnBa61qDNknLZPGgWtugx1PR7CSzrn5SP69+nlvhZG6HzHO4hf/oUeoJO7tJ
         qvMys6k0ajwMm293dPe/JGzv/K/RzLOZR44F8yxsG4/pXE2MLlS6b7WUOLkJ6J3aqRVJ
         o5lQ==
X-Gm-Message-State: AOAM5313clPfT5RURWRvvzbmj65loSBkzcbx291uNc8/WQBbjVNhPxCS
        EOnYS8ndQnQrGSC90MuuEdU=
X-Google-Smtp-Source: ABdhPJy1kxHlwDc1dENH49M5Ke0FTuMiiXjzth8SnFGeQXXNjT1lrZWn5rRj+vjXhuRq18Yj47IvnA==
X-Received: by 2002:aca:7501:: with SMTP id q1mr9817223oic.9.1620707276251;
        Mon, 10 May 2021 21:27:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id k7sm3130957ood.36.2021.05.10.21.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:27:55 -0700 (PDT)
Date:   Mon, 10 May 2021 23:27:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <609a07ca6a51c_5afe12088b@natae.notmuch>
In-Reply-To: <YJmykGWaWi03+WoW@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sun, May 09, 2021 at 10:20:37AM +0200, Martin =C3=85gren wrote:
> > In general, I agree. I do think it's important that "most people
> > contributing to Git", whatever that means, can build the documentatio=
n
> > to check the part they're adding/modifying and not find it broken lef=
t
> > and right. They would then (quite rightly) not even bother building i=
t.
> =

> Agreed. But I think that is mostly the case (asciidoctor seems no harde=
r
> to acquire on most modern systems than asciidoc; there are system
> packages in most cases, and decent binary-package systems for both ruby=

> and python if you really need it).
> =

> It does create a situation where people like Randall on NonStop might
> need to do part of their dev work on another, more mainstream platform.=

> But I suspect that is already the case.

Or use distributed tarballs with already built documentation.

I don't see any big issue with cross-compilation though.

> > When we looked at xmlto-less rendering around two years ago [1], we
> > found various asciidoctor bugs up to and around version 2.0. We would=

> > likely need to require some >=3D2.0.x. The exact requirements will
> > probably only become clear when someone really does the work.
> =

> That does make things a little less convenient; Debian stable, for
> instance, still has 1.5.8.

And it has git 2.20.1, released at the end of 2018.

I've never understood developers worried about how the bleeding edge
would build in ancient platforms, when ancient platforms don't care
about the bleeding edge.

> It's not too hard to install an updated gem, but not quite as nice as
> using the system package (it also makes things weird for building the
> stable Debian package itself, which would want to rely only on other
> packages; but of course any proposed change to the doc toolchain would
> be for new versions, and would not get backported there anyway).

Anyone trying to build git master on top of Debian stable 1. probably
can live with the output of the current doc toolchain, and 2. probably
doesn't exist.

I'm not sure how much the git project gains by worrying about such
a hypothetical person.

> > I think what I'm arguing for is
> > =

> >   1) switch the default to asciidoctor,
> >   2) enable optionally using it without xmlto,
> >   3) figure out what broke and fix it, and document which is the mini=
mum
> >      asciidoctor version we're going to bother with for (2),
> >   4) lather, rinse, repeat (3),
> >   5) switch the default to not using xmlto,
> >   6) drop the xmlto way of generating the manpages(?).
> =

> I'm unclear when support for python asciidoc goes away here. Is it part=

> of step 6 (because it does not have another way of generating them)? Or=

> does it live on forever as a non-default legacy system? I'd prefer not,=

> but as long as we are clear about the primary target and leave it up to=

> people interested in the legacy to do the compat fixes, that might be
> OK.

How about we leave the legacy system in place as an alternative, and
decide later what to do with it?

-- =

Felipe Contreras=
