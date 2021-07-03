Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20616C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 13:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E351C6191C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 13:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGCNDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhGCNDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 09:03:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB86C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 06:00:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w17so17073832edd.10
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZXADej4bcsjz1LTN8wVMw9CTQhJJ5/8KNxOLRgFoDu4=;
        b=MEmmPqP8KfgNT7jhXU+6zzTC1pxXrwD0+UED/3cGR0ITbGPU/ZNqB4u4BadHCxoH1M
         1V/1sl777QDxSkMf8aIqmec2WTqYT6P5CTYBJaaW+RSKcKm9y3HoaRpkzkFHAFkpnvkw
         H20UF+76LZsgMoIfDmE5aZqZjZYHLF+h4E9DZqrL18rr9k1bDScm/RXg4heej13yh3EC
         P9lfk6GDXqt2czhsl/ythpWQLbhMIl02nwgTm1/qyOz0/j8nuz6Bhk15XAna4K9n3xvG
         HFWlkTwrscwKwsuwv8m1S4cPc90sagEOZvVm2cn0Bw0aAc5ULjOQFtN7S3iHUzHaI4sa
         CqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZXADej4bcsjz1LTN8wVMw9CTQhJJ5/8KNxOLRgFoDu4=;
        b=Kp+8HIaJV8QBzr1ABEkfFYhJ2KVo6Eia6mPmPv2Q1Mwh/bz4qvlRsm20PQF8AkhaH5
         qMdTzAJ6lFqUSlZo6D1nYBj61kY0tcKAFzqa6lZvVBPB0dP6seYfAU5GAgfwTtsjDP4p
         M2BruotFPTgI2JISRhsGEN1BleUwfOvMN7nPj5DFmIV6vSnSPtesYVtA8rn+d0PCevmA
         LOoNJzFT/mJECXu1tGkQzVLwqy7drXi42LbnJZ8BN8B4dLO+vmq/rT+bxwa8a/pu35EU
         X5CnpRa+PRqbM9V8A4Jnxm1zQVb9ZhWLlVDM7cGV1Qd46isa8SSGHi4420Bfewr83rFt
         Lu6g==
X-Gm-Message-State: AOAM530DGGAPuxwWNXd49EUNvDuDMSuZbCX2zE18Cj7NilVVkFLlHqC3
        6bQe/3cXZvcxU4XZjsCkyv4=
X-Google-Smtp-Source: ABdhPJzJBXscgwoiSYuA1yY+F8XxC/nCwtUKnWUahCQNxF46tZyDWKhTvlKdj04TQ3Z9GIzAiTbwBw==
X-Received: by 2002:aa7:c7d0:: with SMTP id o16mr5162084eds.75.1625317258176;
        Sat, 03 Jul 2021 06:00:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w21sm2479782edc.95.2021.07.03.06.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 06:00:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Sat, 03 Jul 2021 14:31:40 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
        <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
        <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
        <87r1gs1hfx.fsf@evledraar.gmail.com>
        <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
        <871r8r1hwe.fsf@evledraar.gmail.com>
        <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
        <87fsx6xn0b.fsf@evledraar.gmail.com>
        <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
        <xmqqfsx1yyza.fsf@gitster.g> <875yxxgkav.fsf@evledraar.gmail.com>
        <60dd3c92ef44b_174a220836@natae.notmuch>
        <87tulecfx7.fsf@evledraar.gmail.com>
        <60dfb240ec471_3dd220879@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60dfb240ec471_3dd220879@natae.notmuch>
Message-ID: <87k0m78sc7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Jun 30 2021, Felipe Contreras wrote:
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> >> Even if you don't care about the end result or making git easier to h=
ack
>> >> on for people who don't share your setup,
>> >
>> > I don't know about Junio, I do want to make git easier to hack for
>> > people that don't share my setup, but I would like to know what that
>> > setup is.
>>=20
>> I think all of this is covered in detail upthread.
>
> From [1] I understand some systems have a problem clobbering a binary
> that is being run. So if you are running a test that is using a binary
> that you are rebuilding at the same time, you get an error.
>
> OK.
>
> I still don't see why anyone would want to rebuild the binary in the
> middle of running tests. The result of the tests is only meaningful for
> a particular build. This is what I don't get. I get that you want to do
> this, what I don't get is *why*.

This is mostly covered upthread & in the linked thread(s), but as
summary / elaboration:

 1. Running the tests on some of these machines takes 30-45 minutes. A
    common use-case is firing off a test run to see how bright the
    dumpster fire is that day, noticing an early failure, and inspecting
    it manually.

    Then while the rest of the full run is underway I'd like to
    re-compile and e.g. add some printf debugging guarded by a getenv()
    to some isolated code I'm poking, it's nice if the full test run
    isn't invalidated by that.

    Keep in mind that it takes 30-45 minutes because it's *slooooooow*,
    so "just use another workdir" isn't a viable option. I'm also going
    to wait 10-20 minutes for another full recompile in that workdir
    (and now the concurrent test run takes more than an hour).

 2. We have bugs in the test suite that e.g. leave orphaned git-daemon
    background processes on these platforms.

    Yes that should be fixed, but fixing it is annoying when you can't
    even recompile and run other (even more broken) tests due to the bug
    you're trying to fix.

 3. You're assuming that the only thing I might want to use the built
    git for is the tests.

    E.g. I might (and do) also clone some other repo to debug something
    else, if that one-off clone is running in one terminal I can't
    recompile git until it's finished.

    (Most of the boxes on the GCC farm have a /usr/bin/git, but some
    have e.g. version 1.8-something of git, so to do anything usefully
    modern like worktrees I'll need to bootstrap my own git anyway).

 4. I think you/Junio/Jeff (although maybe less so in Jeff's case) are
    taking this axiom that thou shalt not recompile during tests as an
    absolute.

    I just don't agree with that in general. E.g. if I'm hacking on some
    object.c changes and fire of a test run then sure, that's a general
    enough component that I'd like a full test run. The failure might
    (and often is) be in some obscure edge case in a test I won't expect
    to fail.

    But while that run is taking the better part of an hour maybe I'll
    fix a small bug in git-send-email, recompile, and run t/t9001*.sh
    while the main test run is underway.

    I'd be completely confident in submitting such a fix to
    git-send-email, even though I've never run the full test suite with
    it. It's simply not the case that all the code we develop is so
    generally used that all of it requires a full test suite run.

    I usually I do a full run anyway, but for something like a
    portability fix on an obscure platform on the GCC farm. No, often I
    don't run the full test suite, if I've assured myself that I've
    tested the code in question thoroughly by some other means
    (e.g. running the subset of tests I know stress it meaningfully).

I think you've also said something to the effect that the 3rd party tool
should be the thing doing the in-place-rename if needed, fair
enough.

But claiming that it's both an external implementation detail (so it
could do an in-place rename, or not), and also maintaining that we can't
do in-place rename ourselves because doing so would enable bad thing XYZ
to happen (i.e. this concurrent test thing), seems like a case of
wanting to have your cake and eat it too.

I.e. surely it's one or the other. If it's so important that we use this
behavior as a proxy in case someone is so mistaken as to re-build git
during tests we should be replacing things like:

	cc -o $@ $<

With:

	cc -o $@+ $< &&
	cat $@+ >$@

Just in case the "cc" is doing my proposed version of:

	cc -o $@+ $< &&
	mv $@+ $@

behind our backs.
