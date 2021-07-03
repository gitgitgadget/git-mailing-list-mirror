Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032A7C07E95
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 00:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D135F61427
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 00:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhGCAoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 20:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCAoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 20:44:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1436C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 17:41:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso11837565otu.10
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zr2+PczYQKcwfIwyxEkZk9apqJ/83cgePL4VVxMLJA0=;
        b=sM1e3AbiQaUdQdqWtBfHFq90ltnKClpdwVzhFSM48clGzpx/bIhNMNRvw/POgtXUZU
         bqNC+rf3fdhQQAFmRACNWZlXqYqozXhoz2F4kRVRrYTPQ0VeGijdj0E1n9wd4ua+Xb2A
         e4eCzZjvfdfcmkBGi27sFG7D7UDcd5+s0F87Y2NUrwplBurz6nbFZZFEoDJ6J+fF59Gl
         BtNYeGePKb9hyGWLdO37UgumSk1D9B+ZqR2OsCvEw3my9icX3WplbxKokMpYDxMr4MkR
         KJyq7J8asUCk/6DygSX1VlpCsHQs7i6hpRyuAOerVtE2S6iIvXkdnqqvvYZyB++AAfl1
         eUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zr2+PczYQKcwfIwyxEkZk9apqJ/83cgePL4VVxMLJA0=;
        b=QaK4FXWxQf6e964R6axWASzqPdkXFEyYM2vUW+GT8RN5ofuo54cIPOGBOcdZmgB5w2
         nlDyaP7Aeb2csaCyAHP7oyNUPkbyubXb1n0U7xbVaz/2a23yDHSZGB+CQoAhzKwgIMC6
         neY5bL5qXo03JIDWOVVNfHW1loXIPNb8M83P5VDcZgMp6Hoj9H6+pdcMaiXiTPCe5zfC
         hcyI9nmUsRMDChP94h3a1GcTnU7PtUX6wkC/7bMeC2qZ6/bMD5UFxCsc4ePYFCbBRNjQ
         Y/y86rZ1xEoTsdSssSVrUgPrPaPVd8K1aGSJsBbRoGo7CIwsNyZ6G5sQzB9cf9zIBfEs
         U+AA==
X-Gm-Message-State: AOAM531F7ZRNjJqwj1MgEeVYkareRiuGUy9CUDGNYcigZFVC0ymd0RGc
        uNpykJyKX3AASnxqDg/JhfA=
X-Google-Smtp-Source: ABdhPJytwAcUEG6Z5RfxJUdZwbbuNOobb0tRjp3r/O9jlChe42JNzm63VDWRUfO8lq42685r0k4crQ==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr1554180oto.227.1625272898945;
        Fri, 02 Jul 2021 17:41:38 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id a7sm1026290oia.42.2021.07.02.17.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 17:41:38 -0700 (PDT)
Date:   Fri, 02 Jul 2021 19:41:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Message-ID: <60dfb240ec471_3dd220879@natae.notmuch>
In-Reply-To: <87tulecfx7.fsf@evledraar.gmail.com>
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
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Jun 30 2021, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> >> Even if you don't care about the end result or making git easier to =
hack
> >> on for people who don't share your setup,
> >
> > I don't know about Junio, I do want to make git easier to hack for
> > people that don't share my setup, but I would like to know what that
> > setup is.
> =

> I think all of this is covered in detail upthread.

From [1] I understand some systems have a problem clobbering a binary
that is being run. So if you are running a test that is using a binary
that you are rebuilding at the same time, you get an error.

OK.

I still don't see why anyone would want to rebuild the binary in the
middle of running tests. The result of the tests is only meaningful for
a particular build. This is what I don't get. I get that you want to do
this, what I don't get is *why*.

In order to be able to rebuild _and_ keep running the tests for a
certain build an out-of-source build is needed. Modern build systems
like CMake and Meson do these kinds of builds by default. In fact, Meson
doesn't support anything else.

With an in-source build such as in git, I first stop the tests, and
then rebuild, and that's what I would expect everyone else to do. I
don't think it has been explained why anybody wouldn't.

Cheers.

[1] https://lore.kernel.org/git/871r8r1hwe.fsf@evledraar.gmail.com/

-- =

Felipe Contreras=
