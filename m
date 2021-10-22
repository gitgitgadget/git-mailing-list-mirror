Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DCC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5557261059
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhJVWCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhJVWCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 18:02:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859FBC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:59:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ec8so6726235edb.6
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nIgyVVS1gz2OamgVhz75y/dTXb95+lfcenSyoq0Njs0=;
        b=UR2cy9bsPN3vkhvlpW+/AZMbqrP41nvrgnKMAhTMxBzOOIBpBkN8r6NDMwRqRXwsN/
         UzX56l9GWHTIG7qjiMzu6H+cmuTEejs+VRkpQflu94RpTkba05esb7XBhow6HYcHI95N
         1DYvRxevkwMXHj/2BAC+SpmcNaHmWcYyUwg00JPrnRCeciauzuig/RDQiW7SMb7NU251
         /LmgclnsGTVi6V8X7qZ4i0x2q+rmst/PqPtPruXBoazl5y43fc4VqquBNPGOJZh9Qx4Q
         EkG3mEgvmslg7RPwp94a8dm6k+DEXKyCbouzUpyWj55/FSLC41GBF1R6fKQ5M4hBFpAd
         y8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nIgyVVS1gz2OamgVhz75y/dTXb95+lfcenSyoq0Njs0=;
        b=mL9IM7aJLcgCRoy7QokUMxr9uXABIIe1bYzmk9q3fJBEDQFr9MSEFQSRmsehnQPyHi
         djy7J0DJE3yfI1ezgn+VRJZUE0qyoRU6DybETF+dcKJVMe9PirGTQf5KgAGqs9FgPGvU
         Am1br93EBT8pFgab6kYXTe25tqbFNJYPmkiGBc9Zr0gM/08Mj9Qk9VdeeaVKF/iTkPfi
         1BOY3IzE2zX3WylEgMkVCsm7WBd9MlepHqe3VcPrwu/4f1dYBYD296lS/BTdax36bUqW
         KSn7otcwI4jhBhUt5GLEYepWDviLJ9AAtdKRr1fg5+WW0F1fIQXaCML7PIJXu84b0L0C
         P8MQ==
X-Gm-Message-State: AOAM532n67DcmeKQTYbOjzzYacmzKCU0u8OojWUvJYy5mCCw7XqmPHxY
        IXxIvE/61xAvf753FflSXK8=
X-Google-Smtp-Source: ABdhPJzWQDIVllcNsNpEF3mFcnWB2Rm8HfnsCx/jg6LPQrxiNu+kHMlEsJ8nXfy73FvLKqliuIN7wA==
X-Received: by 2002:a50:d885:: with SMTP id p5mr3571776edj.255.1634939991005;
        Fri, 22 Oct 2021 14:59:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h20sm2222192edq.59.2021.10.22.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:59:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1me2Zp-001NUP-Vq;
        Fri, 22 Oct 2021 23:59:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Date:   Fri, 22 Oct 2021 22:50:16 +0200
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
        <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
        <YXCKqAEwtwFozWk6@nand.local>
        <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
        <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
        <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
        <YXF6Wwcvc0vq5ADZ@coredump.intra.peff.net>
        <211022.86h7d9kzgt.gmgdl@evledraar.gmail.com>
        <YXMDm3ZzgE1UGSwk@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXMDm3ZzgE1UGSwk@coredump.intra.peff.net>
Message-ID: <211022.865ytok9ey.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Jeff King wrote:

> On Fri, Oct 22, 2021 at 12:51:11PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Yes, the same numbers are noted in the 7/8 commit message. I.e. it's
>> slower on -j1, but faster with higher -j<n> numbers.
>>=20
>> Aside from any changes I'm proposing here it seems rather pointless to
>> me to optimize the runtime of -j1 runs.
>>=20
>> I think we use those in e.g. CI, so of course if they become *really*
>> slow it will matter, but the purpose of this change is to make hacking
>> on git easier, both in terms of runtime and discovering what the
>> Makefile is doing wih V=3D1.
>>=20
>> I think anyone hacking on git is going to be on a system with -j2 at
>> least. So again, separate from these specific changes, if we've got a
>> change that speeds up -jN runs at the cost of a -j1 run that seems like
>> good thing.
>
> It seems weird to me to assume that all of our processors are available
> to build command-list.h. In most cases you are not running "make -j16
> command-list.h", but rather "make -j16", and those other processors are
> doing useful things, like say, building actual C code.
>
> So counting CPU time is the interesting thing, because every cycle you
> save there gets used for other work. And "make -j1" just brings
> wall-clock and CPU time together.

There's been a lot of goalpost moving in the discussion around this
series, but if you look at the numbers for the v1 I proposed at
<patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com> it also had a
significant drop in "user" time.

The only thing that was slower in my tests in either wallclock or user
time was the wallclock time on the building from scratch case (the user
time was lower). Maybe those measurements were bad or whatever, but
that's the context for the above.

Now, since then I've submitted a v2 with just the "make the shellscript
faster" parts of this, including with some of your suggestions, making
the shellscript version faster.

FWIW there's a rather trivial addition to my version that makes the
"make all the things" faster again in wallclock/user time. We don't need
to re-parse the command-list.txt at all again to emit the headers if
command-list.txt doesn't change, which is the common case. So we can
just cache the whole header portion in another *.gen file and "cat" it.

Anyway, I've been running these changes on top of other Makefile changes
I've got locally where we re-build almost nothing as HEAD changes. No
FORCE targets shellscripting (but the same via native GNU make
features), and no *.sh/*.perl script re-generation on HEAD changes (the
former being on-list).

So with that the common case really is that everything hangs on the
command-list.h generation. Since we have maybe 1-5 *.c files modified,
then we need to link everything, and the linking is hanging on help.o,
which needs command-list.h.
