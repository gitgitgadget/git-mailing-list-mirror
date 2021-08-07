Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E04C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F203660D07
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 15:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhHGPiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 11:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbhHGPh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 11:37:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF24C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 08:37:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cf5so17703659edb.2
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9UxDL1zuJUXZGar++AeTtWlygqQwF67N6lzHkU1aV8w=;
        b=oBJzwWSNi+Q4uy4bx1iwKuBdeWoFFnEpTHucjTWJ7UCBC/nY95hDCi9NDSwSXukzsN
         6qtRQYDmkYGQ/7TKkyIYpKoBJnjhndFn8bEw9jxcI3H6jtNz2ng1RZ4fP/5DQ2VuLr10
         Mt+EJumitnqnjL8DHmKOfP/L1F5M7juxCQl8RoJhux+h5Xn8pL1XbPliNIRAP4sPlNGj
         gIcMNMBSdB9AghbSfOtYfZF6lnY9ONq8wge6H6cQQzGB/toqGj8aDjxWzOtR6SyCZbTZ
         nLrQXz1X9NY/CBdwNubEz53qeaGMRT6s+pZEM4FAmIygo8cb5V1I3mSmuK6fEOOTGH6y
         FTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9UxDL1zuJUXZGar++AeTtWlygqQwF67N6lzHkU1aV8w=;
        b=flH9F850QEbVphxsptjWB61jJ7lfROj5VukyejQVxiJX7v169VVHR4RhvJys5+nYki
         QIbkXllz47b3PSpfp0fDYyYQ50hqllUkI4za/9DtRO+iMxwhj7rJYnPw7NN8UC2dXmc1
         KtaRRm976i20wIJSPIn/6biIIyEhjxSo1J81OeVRIFfPbq2LfHYunm44TAIVi9PQmtEh
         Q+sOXFafY5x4MXTuIPGnYdY4vzYtyEgXcYtVVc40lEKEL9aWpGHFvpUkEfX7TLQTyfaC
         oFa5jbIeoddpQO2xLkm94S3ty5XKiRtpIHi084NabqL3Q0mNUJjZK/b4wz11Jqa+rh8I
         aXrA==
X-Gm-Message-State: AOAM531q9C/bY8NNVSIlz+BSR/ch3LRwuTPWq4BTGjN5j7WGdENuUq0A
        7T2W/59OipCEVYggVcldvb8=
X-Google-Smtp-Source: ABdhPJw9jFQtE7iJnsa91agRzXA6NM88VEucfrJbpLQyA1CUPf1JYAxHjp7rgGF5EdQHCRRmKiINeQ==
X-Received: by 2002:a05:6402:4412:: with SMTP id y18mr19311966eda.1.1628350658434;
        Sat, 07 Aug 2021 08:37:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w5sm3981602ejz.25.2021.08.07.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 08:37:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Date:   Sat, 07 Aug 2021 17:36:57 +0200
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
 <87bl6aypke.fsf@evledraar.gmail.com>
 <YQ3suvJfspzRNPL9@coredump.intra.peff.net>
 <875ywiyn4y.fsf@evledraar.gmail.com>
 <YQ6VJW0AwkouDnDe@coredump.intra.peff.net>
 <8735rlz5r2.fsf@evledraar.gmail.com>
 <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQ6bTm6DxeJLhmeA@coredump.intra.peff.net>
Message-ID: <87zgttxo3i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 07 2021, Jeff King wrote:

> On Sat, Aug 07, 2021 at 04:26:33PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > That would probably be better. I would be curious to hear from somebody
>> > with a mac if this technique gives more sensible version numbers for t=
he
>> > Apple-clang compiler.
>>=20
>> It does, on the gcc304 box on the gccfarm (recent apple M1 Mac Mini):
>>=20
>>     avar@minimac ~ % uname -a
>>     Darwin minimac.moose.housegordon.com 20.4.0 Darwin Kernel
>> Version 20.4.0: Thu Apr 22 21:46:41 PDT 2021;
>> root:xnu-7195.101.2~1/RELEASE_ARM64_T8101 arm64
>>     avar@minimac ~ % clang --version
>>     Apple clang version 12.0.5 (clang-1205.0.22.9)
>>     Target: arm64-apple-darwin20.4.0
>>     Thread model: posix
>>     InstalledDir: /Library/Developer/CommandLineTools/usr/bin
>>=20
>>     avar@minimac ~ % cat >f=20=20
>>     GNUC=3D__GNUC__
>>     GNUC_MINOR=3D__GNUC_MINOR__
>>     GNUC_PATCHLEVEL=3D__GNUC_PATCHLEVEL__
>>     clang=3D__clang__
>>     clang_major=3D__clang_major__
>>     clang_minor=3D__clang_minor__
>>     clang_patchlevel=3D__clang_patchlevel__
>>=20=20=20=20=20
>>     ^C
>>=20
>>     avar@minimac ~ % clang -E - <f
>>     # 1 "<stdin>"
>>     # 1 "<built-in>" 1
>>     # 1 "<built-in>" 3
>>     # 384 "<built-in>" 3
>>     # 1 "<command line>" 1
>>     # 1 "<built-in>" 2
>>     # 1 "<stdin>" 2
>>     GNUC=3D4
>>     GNUC_MINOR=3D2
>>     GNUC_PATCHLEVEL=3D1
>>     clang=3D1
>>     clang_major=3D12
>>     clang_minor=3D0
>>     clang_patchlevel=3D5
>
> Hmm, now I'm really confused, though. Is that really clang 12 (for which
> there is no 12.0.5; 12.0.1 is the latest version, shipped in July)? Or
> is it XCode 12, shipping with LLVM 11, according to the table in:
>
>   https://en.wikipedia.org/wiki/Xcode#Xcode_11.x_-_13.x_(since_SwiftUI_fr=
amework)
>
> (sorry, there are actually _two_ tables with that same anchor on the
> page; the one you want is the second one, under "Toolchain versions").
>
> The distinction does not matter for our script (where we only care about
> "clang4" and up). I guess the most relevant test would be to get XCode
> 8.x and see what it says. I expect it to claim "clang 8.1.0" or similar,
> but actually be clang-3. And therefore not support
> -Wtautological-constant-out-of-range-compare.
>
> If we can't get easily get hold of such a platform, then maybe that is a
> good indication that this conversation is too academic for now, and we
> should wait until somebody wants to add a more recent version-specifier
> to config.mak.dev. ;)

I think it's clang 12.0.5, and Apple just takes upstream versions and
increments them, e.g. I found this:
https://gist.github.com/yamaya/2924292

So you can presumably rely on it for having clang 12 features, and we'd
only ever care about the clang_major...
