Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2CCC433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D57650B5
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhCFT3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCFT3I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:29:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB9C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:29:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mj10so11243665ejb.5
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ca0u77yv6mjssDPFNpDTK9UxHbu2D3lJkOR8GdhHVPo=;
        b=gxsKSM6mKRlErpyUmKHIafcn0MHX6jOgBWaEFIP5hgEjMkA4eNnSqxVq5ma5LmchJM
         UvRH1xpju9X4RbVEtdjFF1X2YNVkTs71NfQX54MbThgE/FUvrBoAOWpHVzXjdrgcwZmF
         qXpdZmTnRUf475Plsgc6hD44/xT4hwN5C65bOr/pcSC7+fvm7Y3m/TjUzQInNuKQqsJO
         dlL7YuSOcy5pl5tvRYUJz+SK7iD96a3iDNBdFNGTyMS2g6uK/ed1dNOOtZ48xWR8ZMa4
         34G1EopM2PnhBhenp3gkHhqTOAUO+9SYXL+x4nRSgzveu0uEC7ydckW8KEwd1wzZDMi0
         stKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ca0u77yv6mjssDPFNpDTK9UxHbu2D3lJkOR8GdhHVPo=;
        b=Fz5pqxtJa9dGTMwkKdE8hzLv4TCAaRG1oG0/5SavkfZaY6Qy/eEUyHMmdEKQv8jLvT
         jUjVHUaRiKv9YlXM9xfs8PqT/rdLjWgaXGI09DdYv0OCkb1o7OqED5Ta7Ujvz7NjzmTw
         +zugGwr6ia0chXA3jB7vo8OusEjkczV+n8WFzmrDaUx76E7VA9iJvC9I4Le5NM/G+Gba
         Q3Bim4Any5ZSg58EZ216oL+5PZ0EPulP1JkIZa/oWy561u13pDxn7v72aeXmmvHKSZlZ
         sQbcKJ6V+Bn6hOwXhR4p7R8axSluu/da3br8Dr2anWYRQ/aMaFo1mN9Ly+lstGHIFfy0
         5Cbg==
X-Gm-Message-State: AOAM530NqL1GIbz2yEYk2UfP+tUfuHgf7jhb0vfXWDXN7qVUdqyoF9NP
        0vlKzLq8/Sm/uOyVG7gthbQ=
X-Google-Smtp-Source: ABdhPJwNJ1TPf25RHYB13HH9DVzuhJhuDeo2ie6uvjhzYdtCgcwFGSjARQ+V3yhiHbVwKW7tNy99JQ==
X-Received: by 2002:a17:907:a04f:: with SMTP id gz15mr7947029ejc.293.1615058946889;
        Sat, 06 Mar 2021 11:29:06 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g25sm3894544edp.95.2021.03.06.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:29:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 2/4] Makefile/coccicheck: speed up and fix bug with
 duplicate hunks
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-3-avarab@gmail.com>
 <YENdUMLTM+cerfqJ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YENdUMLTM+cerfqJ@coredump.intra.peff.net>
Date:   Sat, 06 Mar 2021 20:29:05 +0100
Message-ID: <87lfb0jd32.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 06 2021, Jeff King wrote:

> On Fri, Mar 05, 2021 at 06:07:22PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Using --no-includes also fixes a subtle bug introduced in
>> 960154b9c17 (coccicheck: optionally batch spatch invocations,
>> 2019-05-06) with duplicate hunks being written to the
>> generated *.patch files.
>>=20
>> This is because that change altered a file-at-a-time for-loop to an
>> invocation of "xargs -n X". This would not matter for most other
>> programs, but it matters for spatch.
>>=20
>> This is because each spatch invocation will maintain shared lock files
>> in /tmp, check if files being parsed were changed etc. I haven't dug
>> into why exactly, but it's easy to reproduce the issue[2]. The issue
>> goes away entirely if we just use --no-includes, which as noted above
>> would have made sense even without that issue.
>
> This part still doesn't make any sense to me. If we are running with
> SPATCH_BATCH_SIZE=3D1, which is the default, then "xargs -n" is still
> going to run it in file-at-a-time mode. From spatch's perspective,
> there's no difference between a for-loop and "xargs -n 1" (unless it
> somehow cares about stdin, but it shouldn't).
>
> Using strace, I do see it creating files in /tmp, but they are all named
> after the process id, and cleaned up before exit. So I don't see how
> they could interfere with each other (certainly not in a sequential run,
> but even if you were to use "xargs -P" to get parallel runs, they seem
> distinct).
>
> If we increase the batch size, I'd expect _fewer_ duplicates. Because in
> file-at-a-time mode with --all-includes, wouldn't every file that
> mentions an include possibly end up emitting a patch for it?
>
> The results you show here (which do replicate for me) imply something
> much weirder is going on:
>
>>     with xargs -n 1:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>>     with xargs -n 2:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>>     with xargs -n 4:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>
> These results are wrong! They are not finding the entry in strbuf.h that
> should be changed.
>
>>     with xargs -n 16:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>>           2 +++ b/strbuf.h
>>     with xargs -n 64:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>>           2 +++ b/strbuf.h
>>     with xargs -n 128:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>>           2 +++ b/strbuf.h
>
> These ones are also wrong. Now we find the strbuf.h mention, but we are
> finding it twice.
>
>>     with xargs -n 512:
>>           1 +++ b/convert.c
>>           1 +++ b/strbuf.c
>>           1 +++ b/strbuf.h
>
> And this one, which is given all of the paths in one invocation gets it
> right. I'd expect that over the "128" version, which is running two
> independent spatch invocations. But the fact that "64" and "16" produce
> exactly two duplicates makes little sense. And even less that 1, 2, and
> 4 don't find the header change at all.

Yes, I don't know what's going on with spatch. Just the observed results
of duplication before/after youc commit.

> Running the same test with a for loop produces the same (wrong) results
> as "-n 1", as expected:
>
>   $ for i in *.c; do
>       spatch --sp-file test.cocci --all-includes --patch . $i 2>/dev/null
>     done | grep -F +++ | sort | uniq -c
>         1 +++ b/convert.c
>         1 +++ b/strbuf.c
>
> So in short I have no idea what spatch is doing. But I remain
> unconvinced that there is anything wrong with the batch-size patch.

Right, but that's an unrelated "didn't change this thing it should have"
bug (which we had before), not the duplicate hunk bug.

> Running it like your patch will, feeding the header directly along with
> --no-includes, does find the correct result:
>
>   $ for i in *.c *.h; do
>       spatch --sp-file test.cocci --no-includes --patch . $i 2>/dev/null
>     done | grep -F +++ | sort | uniq -c
>         1 +++ b/convert.c
>         1 +++ b/strbuf.c
>         1 +++ b/strbuf.h
>
> though I am still concerned by Ren=C3=A9's example which is missing more
> results.

*nod*. I just sent a patch on top to fix that, although it undoes most
 of the speedup in this series.
