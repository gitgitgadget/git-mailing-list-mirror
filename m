Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC941C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDD261919
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhGCSo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhGCSo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 14:44:59 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AB1C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 11:42:25 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id d1-20020a4ad3410000b029024c4d2ea72aso3393821oos.4
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LuJKMxhi5vH55i3cbSflrK5Ko9+TSVEK7sTV7SiXH8Y=;
        b=KXYXa9Xdpz0HAMgpbOy875Iiqb6Fcs98JpoiAQDAykDnChJ8ytySFiVcVfBF0kakMQ
         AVGtPcWRPL5/xsTZMwieibe4jweV7MVjhwiR3nhLpfnTFEcpnw+9Doza/MkWXp8vjaFp
         ZRHQpnWmGgaQuoj0m45cKMZN0RnD33n55IplBrVWzK1SHMmqUuEZdivSc7Dy5aNHQuG4
         hdiZGZplyt3vnpMwKpbvlrE3+NU3ey98eqQmYPdBhtX/xq/lfXk6KjqdnS6cPwwSjbEw
         Vm4E2XR2btqAU1DTROlJi2Ug/VkJXU/1YU+q8v0JxJ7/0mbWQ3x1Vlfybq3MCjG6rU1p
         ZL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LuJKMxhi5vH55i3cbSflrK5Ko9+TSVEK7sTV7SiXH8Y=;
        b=Gn++qbQNxBSiwALp+xFHzQLMI8v+mNKL7iGiqcho2ADrMzX1MxoNnHEYBJLuOLB/yL
         1KCJ7mvzFCOKvNEg17CKZJTcZd7t3TjydsuwA8M2utxaZ1rIpXgsfVFTiwFz2EKBqi+E
         Zj6JMwKoqB6I+CoKS0Cg1jMu+N+fvGvMA8I6PvvnkksCnHw6pVaoj7+i0382hv7zHv/3
         dCVMzvQNO+d/CYOkuQa7prL8YwXi0NxVV0u6KUPFAux8nYXmeo7fxOVHqGcjTiYcke4/
         4j1H95Jcac53PxpWSt1n3ZvjheczUyZSpeVzwru4ItX4HgzkYuBrRMUnYllsr2ubaexN
         iZUw==
X-Gm-Message-State: AOAM531TqLNHdX7ZVZdipbMXPMzkFOSgOtO+2N3k2xSqrlVjorZ6bQd8
        mr+EQtBx5I84NygkKXEtK/4=
X-Google-Smtp-Source: ABdhPJw8CVElvdtMfftEqf7WnaVADPTzrdRJXK1qpt67MXr4PDZAPDooyZzMhZaqgP8C+UkToOp+zw==
X-Received: by 2002:a4a:6941:: with SMTP id v1mr4610092oof.38.1625337744946;
        Sat, 03 Jul 2021 11:42:24 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id j22sm1422127otl.46.2021.07.03.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 11:42:24 -0700 (PDT)
Date:   Sat, 03 Jul 2021 13:42:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Message-ID: <60e0af8f1636d_2f720865@natae.notmuch>
In-Reply-To: <87k0m78sc7.fsf@evledraar.gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
 <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
 <871r8r1hwe.fsf@evledraar.gmail.com>
 <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
 <87fsx6xn0b.fsf@evledraar.gmail.com>
 <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
 <xmqqfsx1yyza.fsf@gitster.g>
 <875yxxgkav.fsf@evledraar.gmail.com>
 <60dd3c92ef44b_174a220836@natae.notmuch>
 <87tulecfx7.fsf@evledraar.gmail.com>
 <60dfb240ec471_3dd220879@natae.notmuch>
 <87k0m78sc7.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, Jul 02 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Wed, Jun 30 2021, Felipe Contreras wrote:
> >> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> =

> >> >> Even if you don't care about the end result or making git easier =
to hack
> >> >> on for people who don't share your setup,
> >> >
> >> > I don't know about Junio, I do want to make git easier to hack for=

> >> > people that don't share my setup, but I would like to know what th=
at
> >> > setup is.
> >> =

> >> I think all of this is covered in detail upthread.
> >
> > From [1] I understand some systems have a problem clobbering a binary=

> > that is being run. So if you are running a test that is using a binar=
y
> > that you are rebuilding at the same time, you get an error.
> >
> > OK.
> >
> > I still don't see why anyone would want to rebuild the binary in the
> > middle of running tests. The result of the tests is only meaningful f=
or
> > a particular build. This is what I don't get. I get that you want to =
do
> > this, what I don't get is *why*.
> =

> This is mostly covered upthread & in the linked thread(s), but as
> summary / elaboration:
> =

>  1. Running the tests on some of these machines takes 30-45 minutes. A
>     common use-case is firing off a test run to see how bright the
>     dumpster fire is that day, noticing an early failure, and inspectin=
g
>     it manually.
> =

>     Then while the rest of the full run is underway I'd like to
>     re-compile and e.g. add some printf debugging guarded by a getenv()=

>     to some isolated code I'm poking, it's nice if the full test run
>     isn't invalidated by that.
> =

>     Keep in mind that it takes 30-45 minutes because it's *slooooooow*,=

>     so "just use another workdir" isn't a viable option. I'm also going=

>     to wait 10-20 minutes for another full recompile in that workdir
>     (and now the concurrent test run takes more than an hour).

OK. If you are careful enough that makes sense.

>  2. We have bugs in the test suite that e.g. leave orphaned git-daemon
>     background processes on these platforms.
> =

>     Yes that should be fixed, but fixing it is annoying when you can't
>     even recompile and run other (even more broken) tests due to the bu=
g
>     you're trying to fix.

Yeah, that's a separate issue.

>  3. You're assuming that the only thing I might want to use the built
>     git for is the tests.

Not really.

>  4. I think you/Junio/Jeff (although maybe less so in Jeff's case) are
>     taking this axiom that thou shalt not recompile during tests as an
>     absolute.

Just like in language I'm not a prescriptivist in workflows either. The
fact that I don't recompile during tests doesn't mean I would presume to
dictate to others what they should do.

You know more about your setup than me.

> I think you've also said something to the effect that the 3rd party too=
l
> should be the thing doing the in-place-rename if needed, fair
> enough.
> =

> But claiming that it's both an external implementation detail (so it
> could do an in-place rename, or not), and also maintaining that we can'=
t
> do in-place rename ourselves because doing so would enable bad thing XY=
Z
> to happen (i.e. this concurrent test thing), seems like a case of
> wanting to have your cake and eat it too.

I never claimed we can't do in-place rename ourselves, I only said that
I did not see the point. And to be clear the fact that I don't see it
doesn't mean it isn't here.


Now I see why you want this and I suppose for this particular case only
it does make sense to do the renaming. But it still seems like a wart to
me. If the build system supported out-of-tree builds there would be no
need for us to do this manually in the Makefile, correct?

But yeah, for now I suppose there's no better alternative.

-- =

Felipe Contreras=
