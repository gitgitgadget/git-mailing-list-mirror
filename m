Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3767C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 12:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9266108B
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 12:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhJVMj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhJVMj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 08:39:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E37C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 05:37:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 5so1873119edw.7
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bpHjt6aWTCDA045p1sbAfMNfX3ZNvcF1JaDXpKOOZ6A=;
        b=Gd9iOEiox9aRzBSEauzxwHrGuKqAPznHEsozs7aenHtGaDS+5ZtwKT6OcY6txE0Z5m
         rZI0njhPNCHonG+inulMCCb3/s5ve5id3IrhtHF5dD/r4yNm3BpvMNkpxeGQv/bneAS5
         iq8zFOpOXVRm0paYZ6aQ9MDMxR8jX1vYEXLYhyngNIm1ZcrIPOb1JxvR8oHHNy2RSX8y
         LBH8Z9KSse89laeHJTqIIGBO1by48NfsazME6Vm/Vd7HH25kJrWpGKG4GqnliR9hscZo
         LbfGsnD9fWVnr7avSZ9zr8BD1HCWGPu2qAPUCirYLqULE2QEcaV7tkeTo0Dx1SOaa0ao
         V52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bpHjt6aWTCDA045p1sbAfMNfX3ZNvcF1JaDXpKOOZ6A=;
        b=SE7qWfscgY9VDxbiuGiV9Wfz+zjUNvbbIuZ1mosnvn1BIgVELq38hCaGp4wtl8XKQ8
         rbdM/zxmPthH2gwHIj5oEFvhImvQqc9IwgYGUMFTpTcGhgV0J8VS7jViyaKJShE8hJeq
         6Qmmc7fJXJBGvRTxrgF1NAkKalOEcHxw5zdaok2lZoVztc9VEkL3iAxYIo8QAu6q+twz
         IvB7pZgzKlzb3Y+aeXIBS3ooe2XmhP6dsiNIYju+lZMAPacDIYucREQbliyRsFWyp3E3
         Ej3X+OWssgViyVqBPNkBANxCmLqOfU763IBcw3fSOzyRUw97BTu3PhhKHzv163IaYAVa
         zmQw==
X-Gm-Message-State: AOAM531AiBiUvQYaWsOS4bTHbKMZ2UIR6XhLRU5s13v4zVALPcGBB/Ft
        pcDc4cDpiCO/AZBe/LnMU9M=
X-Google-Smtp-Source: ABdhPJxzx9g+n8Sx6efSPR6RH+LhA7+7By1v5QnqUVMfEOQinzY+CSyQH3ppHkZhoTwNCwW5Iv4mgg==
X-Received: by 2002:a05:6402:154:: with SMTP id s20mr16845142edu.83.1634906229217;
        Fri, 22 Oct 2021 05:37:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v6sm4933050edc.52.2021.10.22.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 05:37:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdtnG-001CHy-Iw;
        Fri, 22 Oct 2021 14:37:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Date:   Fri, 22 Oct 2021 12:51:11 +0200
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
        <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
        <YXCKqAEwtwFozWk6@nand.local>
        <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
        <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
        <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
        <YXF6Wwcvc0vq5ADZ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXF6Wwcvc0vq5ADZ@coredump.intra.peff.net>
Message-ID: <211022.86h7d9kzgt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Jeff King wrote:

> On Thu, Oct 21, 2021 at 02:48:24AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> There's subtle dependency issues there as well, and just having a
>> >> one-off solution for the the command-list.h doesn't get us closer to
>> >> addressing that sibling implementation.
>> >
>> > So I don't know what "subtle dependency issues" you found here, but th=
is
>> > is exactly the kind of complexity it was my goal to avoid.
>>=20
>> But how? I don't see how narrowly making the loop in generate-cmdlist.sh
>> gets us closer to generating the "cmds_txt" in the
>> Documentation/Makefile.
>
> What I meant is that the work to get everything right in the Makefile to
> correctly handle dependencies and a partial rebuild can be tricky. For
> instance, you're still stuck with a big wildcard dependency on
> Documentation/git*.txt (and a manual list of exclusions in the Makefile)
> because it's hard in make to do make new dynamic rules based on an
> existing one (i.e., the list _should_ come from what's in
> command-list.txt). Or the fact that we apparently need to keep the old
> script around or cmake anyway.
>
> It's also much slower. Here are from-scratch builds before and after
> your patch 7:
>
>   $ hyperfine --warmup 1 -p 'make clean' 'make command-list.h'
>   Benchmark #1: make command-list.h
>     Time (mean =C2=B1 =CF=83):      1.527 s =C2=B1  0.060 s    [User: 1.3=
20 s, System: 0.649 s]
>     Range (min =E2=80=A6 max):    1.433 s =E2=80=A6  1.625 s    10 runs
>=20=20=20=20
>=20=20=20
>   $ hyperfine --warmup 1 -p 'make clean' 'make command-list.h'
>   Benchmark #1: make command-list.h
>     Time (mean =C2=B1 =CF=83):      2.661 s =C2=B1  0.080 s    [User: 2.3=
59 s, System: 1.082 s]
>     Range (min =E2=80=A6 max):    2.481 s =E2=80=A6  2.756 s    10 runs
>
> I know that partial builds will offset that in some cases, but it still
> feels like a step in the wrong direction. Even with a partial build,
> swapping out "make clean" for "touch Documentation/git-add.txt" takes
> about 200ms for me. Whereas with the faster version of
> generate-cmdlist.sh I showed, it takes 150ms.
>
> Now performance isn't everything, and it's possible these partial
> snippets will be useful in other places. But I'm not sure I see any real
> advantage in this series, and it seems like we're taking a hit in both
> performance and complexity in the meantime.

Yes, the same numbers are noted in the 7/8 commit message. I.e. it's
slower on -j1, but faster with higher -j<n> numbers.

Aside from any changes I'm proposing here it seems rather pointless to
me to optimize the runtime of -j1 runs.

I think we use those in e.g. CI, so of course if they become *really*
slow it will matter, but the purpose of this change is to make hacking
on git easier, both in terms of runtime and discovering what the
Makefile is doing wih V=3D1.

I think anyone hacking on git is going to be on a system with -j2 at
least. So again, separate from these specific changes, if we've got a
change that speeds up -jN runs at the cost of a -j1 run that seems like
good thing.

In terms of the utility of benchmarks this benchmark uses "make" and is
meaningful, but e.g. <YXCKqAEwtwFozWk6@nand.local> (and I think some
other ones?) in this thread invoke the shellscript directly.

Those sorts of benchmarks may or may not matter, and in this case the
script is always called in the context of a Makefile, so that's really
the only meaningful way to test it. If e.g. its performance changes in a
way that won't be noticed in other Makefile noise it probably won't
matter to anyone.

