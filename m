Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E032CC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE3160E09
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 14:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhHGObU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhHGObT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 10:31:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D9BC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 07:31:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p21so17508197edi.9
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9zM0xkxAfY9hKHWmOZTO824pijVHoXvGx0wbVxcjC/I=;
        b=G2NyZRYw8p9579sHPdHA8wFG36UxXELbzAnAjEXHATJbg1nX1bJpbGs7aO+2Dp8iXP
         4CrHeF8pSVFKIed/b4GsOoQrBlMRVtbAbufQ+5YdcJ9d3D0DXNucFhxg071ItZvGJWx5
         RQsFrM1xkcurGiG5Db4yAQcPhITnYzS7BKuCYLXmb05kMK6zr8xNp1gj7x3iDz50lh8f
         D6XNc7fDl4uu/YDFyYY3BdErXSn57eZbc/UM6an8bdUr/ydidMPLorNSyvGTUJ+8mKIF
         CbhPGedp32ccxMZpxDGDKJYK9/SukYmrgyMiQ1ToBCT5c3UaQqi8pYAGk7Zs1snyyx8W
         SKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9zM0xkxAfY9hKHWmOZTO824pijVHoXvGx0wbVxcjC/I=;
        b=Jt1eY59ySTqfb92E4wqQZcexPl77fYTGQk0Pm8epNF7DG2Ww2sQYdcahhqWSrCo5Hy
         /3BY0XNBk/p867L7YhxF4OiwXGT6hbXO5c49UTzhRDFNcoUZMvKy25Sa668TICv+2gd9
         kFBB1xN7o93z7DstpnbxAhEa0Z3VnM2sFQgUq57jpWXbgXTezyUX7uKigCbHaUHylJYi
         p001tmC48IUs3/0CQBAW6J/5LrWrBRPO051nb0EqIMUiyx6bz9K0YYde7nkb0z+6hzzJ
         Pub6HvvnEk/cxKKNwIdssXZV6sxIajpkADzYzdCpAEwXdXu2gE/YikL4xQDLQ48ytHOa
         7g/g==
X-Gm-Message-State: AOAM530fASWLRAuFm2DQTG6TrdFu24rz5eB/7bdg3wEo90Dl77nKY5VU
        Bi/em5er4vc0FSHBWKLMJ3s=
X-Google-Smtp-Source: ABdhPJziDNT9/oeUefyIcE9LJUddGTjL3Jd0BncYTXyE8CZmJttoSM/OdGfon4vBhhkcw7ZEZvOZ1A==
X-Received: by 2002:a05:6402:b19:: with SMTP id bm25mr19345224edb.213.1628346658848;
        Sat, 07 Aug 2021 07:30:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gr14sm3868897ejb.60.2021.08.07.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 07:30:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Date:   Sat, 07 Aug 2021 16:26:33 +0200
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com>
 <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
Message-ID: <8735rlz5r2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 07 2021, Jeff King wrote:

> On Sat, Aug 07, 2021 at 04:56:04AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > On Sat, Aug 07, 2021 at 04:02:45AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >
>> >> Perhaps I've missed some obvious reason not to do this, but why are we
>> >> parsing the --version output of two modern compilers, as opposed to j=
ust
>> >> asking them what type/version they are via their usual macro faciliti=
es?
>> >> I.e. something like the below:
>> >
>> > That would probably work OK in practice, but it actually seems more
>> > complex to me (how do other random compilers react to "-E -"?
>>=20
>> We only care about gcc and clang in that script, which I think have
>> supported that form of "-E" on stdin input for any version we're likely
>> to care about for the purposes of config.mak.dev. It seems unlikely that
>> we'll care about non-modern compilers in config.mak.dev, so using more
>> modern features there seems fine (it's all for opting us into even more
>> modern warning flags and the like...).
>
> Yeah, but we don't find out what we have until we run the script in
> question. I guess it is OK as long as we redirect stderr, ignore the
> exit code, and only look for a positive outcome in the output (your
> patch does the latter two already).
>
> I also wondered how this might interact with CC=3D"ccache gcc" (where
> caching might fail to notice version changes). But from some quick
> testing, it looks like it doesn't cache in this case (neither stdin, nor
> with -E).
>
>> > Is it possible for us to get other output from the preprocessor that
>> > would confuse an eval?).
>>=20
>> Probably, I just meant that as a POC. We could pipe it into some
>> awk/grep/cut/perl or whatever that would be more strict.
>
> That would probably be better. I would be curious to hear from somebody
> with a mac if this technique gives more sensible version numbers for the
> Apple-clang compiler.

It does, on the gcc304 box on the gccfarm (recent apple M1 Mac Mini):

    avar@minimac ~ % uname -a
    Darwin minimac.moose.housegordon.com 20.4.0 Darwin Kernel Version 20.4.=
0: Thu Apr 22 21:46:41 PDT 2021; root:xnu-7195.101.2~1/RELEASE_ARM64_T8101 =
arm64=20=20=20=20
    avar@minimac ~ % clang --version
    Apple clang version 12.0.5 (clang-1205.0.22.9)
    Target: arm64-apple-darwin20.4.0
    Thread model: posix
    InstalledDir: /Library/Developer/CommandLineTools/usr/bin

    avar@minimac ~ % cat >f=20=20
    GNUC=3D__GNUC__
    GNUC_MINOR=3D__GNUC_MINOR__
    GNUC_PATCHLEVEL=3D__GNUC_PATCHLEVEL__
    clang=3D__clang__
    clang_major=3D__clang_major__
    clang_minor=3D__clang_minor__
    clang_patchlevel=3D__clang_patchlevel__
=20=20=20=20
    ^C

    avar@minimac ~ % clang -E - <f
    # 1 "<stdin>"
    # 1 "<built-in>" 1
    # 1 "<built-in>" 3
    # 384 "<built-in>" 3
    # 1 "<command line>" 1
    # 1 "<built-in>" 2
    # 1 "<stdin>" 2
    GNUC=3D4
    GNUC_MINOR=3D2
    GNUC_PATCHLEVEL=3D1
    clang=3D1
    clang_major=3D12
    clang_minor=3D0
    clang_patchlevel=3D5

I think nobody who's using clang derivatives is screwing with these
macro variables, they're just changing whatever the "product name" or
whatever is in the --version output.
