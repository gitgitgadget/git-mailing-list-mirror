Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A5C433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 15:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiKFPDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFPDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 10:03:31 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB55FF5
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 07:03:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u24so13951966edd.13
        for <git@vger.kernel.org>; Sun, 06 Nov 2022 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m60j96/SaaWBGpsKBP4Iw8gESwU9H/chLTyzLuzfjVE=;
        b=D+YAtHS5y34m+vH5QjQgKzGWErGB5f7e9ovW9FGvaz2NimFkKR+NUd8+8Fj2T1njEN
         BdQKk5O4PjSTYHnaAWNv4YfQ9TzTY2LeFeWSMzs+hWNp5zk63QWj97bTsEwevF004ySG
         0YWIUx2RjdtW3nxK/r21q3O5yD0exVF1Uk/fg9U5E5UlFZpxEe+rFPqEiPzIbQ9bWybR
         2uo2ppGBoRMO0AzDHF7Viz+v61C+dP3EWF7+1dTds7YcgfE8euhi58BPLwByR8ZkjbE1
         UrD7Lk/xZPXYXgUQS2AhVCHoz5lPVd2Fc6awcj32Nv6rT0S3jJtuUxNqcwYkPBATqPpY
         +Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m60j96/SaaWBGpsKBP4Iw8gESwU9H/chLTyzLuzfjVE=;
        b=xlbT2LzKVoO9EhMZluUgWOPx19jXDPZuALWc8WzGCzjFiwz/czUMUZcbpjJEBfsIoC
         JHfltE2c+OaJvmHGhXi8dCY8I5gnYNYHfvSGy3VtaPbtAoct2gobryzoaT59efgQ0yq4
         vjJ+Q9Xd5VVSIVOnQwLVjPh9UQwjvftY+cJnZXsWDXty8gU5cuVWUwWw9jGR/KuXj2o4
         WZRuAZkk1L16lcyG/20nd5IGMacBucqt+Nsj95ZenIT3B1w+YqkXUImlRnyIUrAGwxsw
         rltQVwzTVutLQP0oVCaHUJ+m3EKTafoYZ9lyRw0ylTqpO2uxJzRgZVSymDdFugFUlLfo
         v9gg==
X-Gm-Message-State: ACrzQf3qaAXJ1xyF5RiMEChnCwrtFgId3H3sbZg0eSBJof78PgtDqbw7
        ZX7qH0A5upE7DIxgDvLcD60=
X-Google-Smtp-Source: AMsMyM45kFLZAnBxfgB5i8A546eCw/DkyvnnX2ZyA7i9YqE9j2y5mW+lQoLkD3J74tBl/bVzyil5tQ==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr45561900edc.203.1667747008851;
        Sun, 06 Nov 2022 07:03:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d886000000b0045723aa48ccsm2686286edq.93.2022.11.06.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 07:03:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orhBH-000eCi-0r;
        Sun, 06 Nov 2022 16:03:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict
 OPT_SUBCOMMAND() to one *_fn type
Date:   Sun, 06 Nov 2022 14:28:58 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
        <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
        <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
        <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
        <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
        <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
        <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
        <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
Message-ID: <221106.86k048w2f4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 06 2022, Ren=C3=A9 Scharfe wrote:

> Am 05.11.22 um 23:33 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sat, Nov 05 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 05.11.22 um 14:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> I think that's an "unportable" extension covered in "J.5 Common
>>>> extensions", specifically "J.5.7 Function pointer casts":
>>>>
>>>> 	A pointer to an object or to void may be cast to a pointer to a
>>>> 	function, allowing data to be invoked as a function
>>>>
>>>> Thus, since the standard already establishes that valid "void *" and
>>>> "intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
>>>> gap between the two saying a function pointer can be converted to
>>>> either.
>>>>
>>>> Now, I may be missing something here, but I was under the impression
>>>> that "intptr_t" wasn't special in any way here, and that any casting of
>>>> a function pointer to either it or a "void *" was what was made portab=
le
>>>> by "J.5.7".
>>>
>>> Do you mean "possible" or "workable" instead of "portable" here?  As you
>>> write above, J.5.7 is an extension, not (fully) portable.
>>
>> I think my just-sent in the side-thread should clarify this.
>
> AFAIU you think that J.5.7 plus POSIX make conversions between object
> pointers and function pointers portable.

No, I think that:

1) J.5.7 does that on its own for C99
2) POSIX has orthagonally mandated this, seperate from C99.

In practice I think it's always worked for dlsym(), but there's
interesting changes in wording between v6 and v7 of POSIX:

   - https://pubs.opengroup.org/onlinepubs/009695399/functions/dlsym.html
   - https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlsym.html

v6 claims that conforming C compilers are required to produce a warning
if this isn't supported (I haven't found the part of the standard
they're referencing), and notes that the behavior may be deprecated in
the future.

Whereas v7 says that POSIX "requires this conversion to work correctly
on conforming implementations".

Is your reading of any of that different?

In addition to that: This is widely supported on systems that didn't
aquire such support via optional C99 extensions, or POSIX. E.g. Win32.

I think this is one of those things that C has left deliberately
undefined for the benefit of embedded implementations, and others with
odd memory models.

>> I think "just leave it, and see if anyone complains".
>>
>> If you look over config.mak.uname you can see what we're likely to be
>> ported to (and some of that's probably dead). The list of potential
>> targets that:
>>
>>  1) We know of ports to, or people would plausibly port git to
>>  2) Are updated so slow that they're on a release that's getting close
>>     to a year old.
>>
>> Are small, and it's usually easy to look up their memory model etc. are
>> you concerned about any specific one?
>
> Using implementation-defined behavior and requiring extensions when
> standard code would work just as well makes no sense to me.

I think it's useful in itself to see what subset or superset of C we
actually need to concern ourselves with.

E.g. we have plenty of code that assumes ASCII, instead of catering to
EBCDIC, and assuming NULL is (void *)0, not (void *)123456 or whatever.

Yes, in this case the alternative is trivial, but perhaps we'd find a
use-case in the future.

All I'm saying is let's leave the current one in place, as there's no
indication that it's not supported by our targets.
