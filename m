Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CBAECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 12:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiHaM31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHaM30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 08:29:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69FD1266
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 05:29:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id se27so20302105ejb.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=lj4clT25H62CZAtqmRCP3DcycSwIMHPcSJvHQI4pN/o=;
        b=knIDr/Pj1yA3xHz6HDNIxw/Kl1whnRq4vAczo6afmB+4ajMNbmssJ6fZFcknMYWFnu
         8im91hR9cJYK53g2B24xxiPkC5ZzYlrN9T8v6kvlFJD8JM81XLYTu0ueYFbTXiWZI5nx
         CFOTNZs7e2V2xOcofhuNf1h20B/7347TH4/rtUM6KaflCC8Jfl/3P3fxdoq/cAG/I56Z
         w53zKl4WOCly8gn9AXcflqyMjhAZm+VQ8/9XLnb4dGRHW1jQEIichrdjxWFTlzbdJhIq
         sq29gza9+GX8TJweAFx+al4W3kOBJhy+NyMk9OcFfjWx2Am2DMvhxXGBcG40E1QMTzC5
         /40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=lj4clT25H62CZAtqmRCP3DcycSwIMHPcSJvHQI4pN/o=;
        b=R6FNT+xpmC6ftAGWsKa0H/UOI/e/dT4v1/6VtPN1IzR+1jjCR8kOfGFHIeyBGVPVRo
         C1guo0BVCKTW4Ek2WqvMVjHwPy68nlKPznAqvmCawHKB6TyzP49D6n2RyQAumzOdB2RT
         Qa16Im8OHiycbWTjkIXXjQY7KhX0X0TlpRGF0tgbHck30nNEINRNY+na+OylRcKsJ2sv
         R0znrNHvPlgAjgk6oNccxPkZiAj4Y7zfEOoFtpChcECv8Rih6XTFqwwYQJYGrl4Z/O2+
         Y3BocaPgBHbbBbhdnTL6BhkRN/E9MUZ6TZjRACc+/ikv4ose6bZBdqs88lJZn3JBdNSy
         i6Qw==
X-Gm-Message-State: ACgBeo2r9Gln1NrPfG4fcdOJtBNBCbPaXT4m6UvOZi19oqLeRCSehD0+
        DIZpbz0WiuBLXb7Xa9CNhMqDQM9ZUwtX9Q==
X-Google-Smtp-Source: AA6agR4puPnnEc1bVRBXfi7UN6ue5mEEwETjOHV2q68K6wTi87ytta5IRQDZRC3I+FATPMI3NBoTBA==
X-Received: by 2002:a17:907:75c1:b0:72f:248d:5259 with SMTP id jl1-20020a17090775c100b0072f248d5259mr20609796ejc.227.1661948964133;
        Wed, 31 Aug 2022 05:29:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906601200b007314a01766asm7022377ejj.211.2022.08.31.05.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:29:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTMqQ-000Ds9-1q;
        Wed, 31 Aug 2022 14:29:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Date:   Wed, 31 Aug 2022 14:13:51 +0200
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g> <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net> <xmqqczcnymtd.fsf@gitster.g>
 <20220831084403.GA13663@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220831084403.GA13663@szeder.dev>
Message-ID: <220831.867d2oa95p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, SZEDER G=C3=A1bor wrote:

> On Fri, Aug 26, 2022 at 09:46:54AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>=20
>> >> But the fix here isn't to delete unused.cocci, but to hold off on the
>> >> UNUSEwork D() patches until we figure out how to make coccinelle jive=
 with
>> >> them.
>> >
>> > Yeah, my general skepticism and disappointment above notwithstanding,
>> > this seems like the best path forward from here. I tried a few other
>> > tricks (like --macro-file and --iso-file), but if its parser chokes, I
>> > don't think there's much we can do about it. Even if we wrote a patch =
to
>> > coccinelle itself (and I have no interest in doing that myself), it
>> > would take a while to become available.
>>=20
>> If it is just a single unused.cocci, I would actually think removing
>> it would be a much better path forward.  UNUSED() that renames to
>> help folks without checking compilers would help noticing bad code
>> much earlier than unused.cocci many contributors are not running
>> themselves anyway.
>
> Here is another reason for the removal of 'unused.cocci': it's very
> costly to apply that semantic patch to the whole code base.
>
>   make SPATCH_BATCH_SIZE=3D32 contrib/coccinelle/unused.cocci.patch
>
> takes 440s on my machine, whereas the second slowest 'object_id.cocci'
> takes only 56s [1].  Applying 'unused.cocci' to some of our source files
> individually takes well over a minute:
>
>   $ time spatch --all-includes --sp-file contrib/coccinelle/unused.cocci =
builtin/log.c
>   warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
>   warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/sta=
ndard.iso
>   HANDLING: builtin/log.c
>   Note: processing took    83.1s: builtin/log.c
>=20=20=20
>   real	1m23.083s
>   user	1m22.983s

If you remove the "done:" line in cmd_format_patch() buiiltin/log.c runs
in ~200ms instead of ~40s for me. Perhaps we should be discussing
removing or refactoring that one line of code instead? :)

Removing coccinelle rules because we're seeing slowness somewhere seems
particularly short-sighted to me.

Maybe we do run into intractable problems somewhere with it being slow,
and we'd also like to cater to more "interactive" use.

But we shouldn't do that by removing rules until we get below some
runtime limit, but rather by creating a "batch" category or something
(just like we have "pending") now.

Or, just actually look into why it's slow and fix those issues and/or
report them upstream.

There's nothing in unused.cocci that we either aren't running into
elsewhere, or wouldn't run into if we had 10x the coccinelle rules we
have now (which I think would be a good direction, we should rely on it
more heavily).

I've found that being able to have a ccache-like tool for "spatch"[1]
solved almost all of the practical performance concerns I had with
it. I.e. I can just run things in a batch, and usually any interactive
use will hit things already in cache.

To the extent it doesn't it's usually some pathological issue in spatch.

>   sys	0m0.033s
>   $ time spatch --all-includes --sp-file contrib/coccinelle/unused.cocci =
builtin/rebase.c=20
>   warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
>   warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/sta=
ndard.iso
>   HANDLING: builtin/rebase.c
>   Note: processing took    83.2s: builtin/rebase.c
>=20=20=20
>   real	1m23.223s
>   user	1m23.156s
>   sys	0m0.017s

I didn't look at this one, but I assume it's some similar (and probably
easily fixed) pathological issue.

1. https://lore.kernel.org/git/patch-5.5-ce4734e5d79-20220825T141212Z-avara=
b@gmail.com/
