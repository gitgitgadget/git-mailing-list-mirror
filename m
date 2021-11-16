Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE07C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3C063227
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhKPS0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhKPS0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:26:01 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2BC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:23:04 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id w15so111300ill.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fSARd+G3FSdf4ER1Q+8h/eJebLhAmYD5E/CniF/suNA=;
        b=Ex7G4Hgc3Gglt3rXvuFFIEWZWOAPyzojoixnD3ptAK//7c0DSInGi77wIzGlB+Sm2I
         Tj+luRx0diJA/Cygw4MfLNLUecF8luQAR7O1xCWWWjCMmsQKVJCxhdw0Mmu1+45JG+qB
         b+7FwzqfOJ890909IJvwLdjg4e+6/PxLMO2lDMNHtbtCCk22I+XPJC5NPxGUYi8WjJsu
         awomRHnLY8WLAJQYzeX64+r7ag7nV0sRPh4Su9mgPrREFXvwWU1RPy5w//KzdRAAy4bO
         7pfwuKAjpS3r1XX3zLC+gztnGrQyiH2O6IL0YZb1YptdTDRs8pJXytycCCvOvIv8iDLX
         QzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSARd+G3FSdf4ER1Q+8h/eJebLhAmYD5E/CniF/suNA=;
        b=V54GplBYajEBg9RNuXgfw8PYu1xKgqy90aMicqQaYCIN1O/P/ikvsJITV0WPMsoUOV
         Iej/WliOxz2Xkv4Tgei40KmqyC2crsGBr36pwfkEgq21NklYAzjuZFUhz+NJgMhc3y1x
         Pazgm4TzAB+U5pOU4KL2UsEihTPmHTuBfEBzOne3n7t4ENzA2kf//3Kht5aZpG6MRrve
         yn4PS8QcaG7kbsVC7ai5kRIjxfqu/jFw1kAE90NM24pcFVnvv0JhEGtXDfPSh70e1jEl
         VS+MADmPqAJTUMSwgLqQjmVeWiEeNmcTpHHqWpoeUFemMHN1ZD0CthXMECgbadcYmfW9
         faEg==
X-Gm-Message-State: AOAM531lkOkljMr1QWmw6Yvw+n+4N+9dEatPEUPrTbxhOHAWgC0gl5lH
        LLVCdMVXuvGgG9ApGShVr5voqcGCuueUn6iL
X-Google-Smtp-Source: ABdhPJx4dR0N1LRaXkKu1uKnbBerL6LECfchZLY8kZiKreqYDRdTVGaLkVhPd4i+7Ya5fs9egJevNg==
X-Received: by 2002:a05:6e02:1521:: with SMTP id i1mr6055608ilu.101.1637086984043;
        Tue, 16 Nov 2021 10:23:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g7sm12634463ild.87.2021.11.16.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:23:03 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:22:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Jeff King' <peff@peff.net>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZP3ApaDcMGIsKeb@nand.local>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <YZPOzqU0UQDVA57R@coredump.intra.peff.net>
 <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 11:01:20AM -0500, rsbecker@nexbridge.com wrote:
> On November 16, 2021 10:31 AM, Jeff King wrote:
> > On Tue, Nov 16, 2021 at 03:35:41AM +0000, brian m. carlson wrote:
> >
> > > The order of options is also important here.  On systems with
> > > arc4random, which is most of the BSDs, we use that, since, except on
> > > MirBSD, it uses ChaCha20, which is extremely fast, and sits entirely
> > > in userspace, avoiding a system call.  We then prefer getrandom over
> > > getentropy, because the former has been available longer on Linux, and
> > > finally, if none of those are available, we use /dev/urandom, because
> > > most Unix-like operating systems provide that API.  We prefer options
> > > that don't involve device files when possible because those work in
> > > some restricted environments where device files may not be available.
> >
> > I wonder if we'll need a low-quality fallback for older systems which don't
> > even have /dev/urandom. Because it's going to be used in such a core part of
> > the system (tempfiles), this basically becomes a hard requirement for using
> > Git at all.
> >
> > I can't say I'm excited in general to be introducing a dependency like this, just
> > because of the portability headaches. But it may be the least bad thing
> > (especially if we can fall back to the existing behavior).
> > One alternative would be to build on top of the system mkstemp(), which
> > makes it libc's problem. I'm not sure if we'd run into problems there, though.
>
> None of /dev/urandom, /dev/random, or mkstemp are available on some
> platforms, including NonStop. This is not a good dependency to add.
> One variant PRNGD is used in ia64 OpenSSL, while the CPU random
> generator in hardware is used on x86. I cannot get behind this at all.
> Libc is also not used in or available to our port. I am very worried
> about this direction.

I share Peff's lack of enthusiasm about the dependency situation. But
making Git depend on having /dev/urandom available is simply not
feasible, as you point out.

I wonder if the suitable fall-back should be the existing behavior of
git_mkstemps_mode()? That leaves us in a somewhat-disappointing
situation of not having fully resolved the DOS attack on all platforms.
But it makes our dependency situation less complicated, and leaves
things no worse off than the were before on platforms like NonStop.

Thanks,
Taylor
