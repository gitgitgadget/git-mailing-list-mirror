Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF548C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 09:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiAXJkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 04:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbiAXJk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 04:40:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D0DC061749
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 01:40:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ka4so19663235ejc.11
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RKvofZx5gW8EViKX8yrBeqm4lxrbNkzu/Po8kbdtigU=;
        b=RzRYFwIqnS9YXjh14BiilLvlKY189nnbqPLf0i3SYArDVYTcJbbOalpwDHf/HI6zoo
         22C5V03/iyFVPE8XwKQXR1frONn/FCfoodSxOwdpfycgt56pFPAcakBtdOSj38Ejneq7
         DFXnVF3G9YyiCQcbX7WclWDvs1Nq5gYcl9uTdWxXdOgX1La+JtQtMYo4tCLQeH4wjIaQ
         oepMK1FzltuCqScO9mqO9QY5rhEiUzOg1pH9QQv0UBy8t2NwSJejNQk9ZgLj/fPQA42i
         +L83JLAQWwLmk1q26m3E0W9xLA3hitUnM9YPB/0r6YeeqrVMam25aSzaVPV0EGe2xXGM
         7f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RKvofZx5gW8EViKX8yrBeqm4lxrbNkzu/Po8kbdtigU=;
        b=J6DYNMsrCKrLAjKHIeUNavWPdQ3o5GVmmop1644L53eWOtosdc6ghcyCtk4SrJYjfD
         YDT+fZ4jsLSRFEQNjM9SUxyH1dNgcmUOowItU5BPL0dP37MkJwMdEHPcp34oNzMFlRZB
         gjJk5Y2DLb95BGmjIfPcIxyrF2w4nmaEbCaFA5H/8FhDZvdnKESquGb8uu5Zl4k1rnKr
         /bDZhE8zAtgzdu4wd3XlL/1UJBO0uN4wvHGJSUrht4+/ZArL5OeqTtay8HQplCWNUxzE
         O1U9YakJgjb0wup26iSD2DBbZNACEuaCY+h4fnszEHTU1AJPzGB+kCXM3q1n63tAiRUZ
         jZ/g==
X-Gm-Message-State: AOAM532Ed1z8QWYnVJcWgCJEP9V3G7/m6JeL4y7w7Ko46q24+YSjwEFe
        prEpCpBHBSpVPGGTKm2FdqrRsC7NV5Y=
X-Google-Smtp-Source: ABdhPJwHWi8Ui/BCGJylS6wxbMDr8HDhyuFErb5VP+j6eDrBKe7loZj1+4qHxJplti8S7Y/RQYcRgA==
X-Received: by 2002:a17:907:2cc2:: with SMTP id hg2mr11506058ejc.702.1643017227058;
        Mon, 24 Jan 2022 01:40:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a11sm6293225edv.76.2022.01.24.01.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:40:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBvpk-002PkR-OH;
        Mon, 24 Jan 2022 10:40:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4] compat: auto-detect if zlib has uncompress2()
Date:   Mon, 24 Jan 2022 10:27:02 +0100
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
 <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
 <xmqqr190ekrh.fsf@gitster.g>
 <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
 <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqh79t7sj4.fsf_-_@gitster.g>
Message-ID: <220124.86pmohii9n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 23 2022, Junio C Hamano wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> We have a copy of uncompress2() implementation in compat/ so that we
> can build with an older version of zlib that lack the function, and
> the build procedure selects if it is used via the NO_UNCOMPRESS2
> $(MAKE) variable.  This is yet another "annoying" knob the porters
> need to tweak on platforms that are not common enough to have the
> default set in the config.mak.uname file.
>
> =C3=86var came up with an idea to instead ask the system header <zlib.h>
> to decide if we need the compatibility implementation.  We can
> compile and link compat/zlib-uncompress2.c file unconditionally, but
> conditionally hide the implementation behind #if/#endif when zlib
> version is 1.2.9 or newer, and unconditionally archive the resulting
> object file in the libgit.a to be picked up by the linker.
>
> There are a few things to note in the shape of the code base after
> this change:
>
>  - We no longer use NO_UNCOMPRESS2 knob; if the system header
>    <zlib.h> claims a version that is more cent than the library
>    actually is, this would break, but it is easy to add it back when
>    we find such a system.
>
>  - The object file compat/zlib-uncompress2.o is always compiled and
>    archived in libgit.a, just like a few other compat/ object files
>    already are.
>
>  - The inclusion of <zlib.h> is done in <git-compat-util.h>; we used
>    to do so from <cache.h> which includes <git-compat-util.h> as the
>    first thing it does, so from the *.c codes, there is no practical
>    change.
>
>  - Beat found a trick used by OpenSSL to avoid making the
>    conditionally-compiled object truly empty (apparently because
>    they had to deal with compilers that do not want to see an
>    effectively empty input file).  Our compat/zlib-uncompress2.c
>    file borrows the same trick for portabilty.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Beat Bolli <dev+git@drbeat.li>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * So, here is an updated one, still retaining the authorship but
>    adjusting for the "no empty source" trick.  v3 seems to fail
>    "win+VS build" due to the use of an extra $(ZLIB_COMPAT_OBJS)
>    macro, [...]

I hadn't noticed that "win+VS build" issue, but it's another issue with
the CMake.txt scraping of the Makefile. I.e. it scrapes $(LIB_OBJS) with
a regex, and as soon as another variable is used to append to it it
fails. It has special-casing for the $(COMPAT_OBJS) seen in the v3 diff
context.

All of which b.t.w. would be avoided with the approach I suggested in in
https://lore.kernel.org/git/patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avara=
b@gmail.com/
of having it ask "make" for these values rather than scraping them.

>    and this iteration, which just uses LIB_OBJS as everybody
>    else does, should be sufficient to avoid introducing such an
>    issue.

The change you have here doesn't work because in relying on $(LIB_OBJS)
you broke the linking of libreftable.a, which doesn't link using
$(LIB_OBJS), but requires uncompress2().

I think you didn't test this on a system that doesn't have
uncompress3(). Testing it can be emulated by just naming it
uncompress3() or something, and making the "#if" macro check an "#if 1".

That linking issue can also be fixed, but overall I really don't see the
point of this complexity of insisting that this fallback function must
arrive via a compat object.

The approach I had in the v2 of just including these sources in the
top-level zlib.c just works, without any of the added build system
complexity.

So just taking the v2 would also work (perhaps with the config.mak.uname
changes), or this v4 with compat/zlib-uncompress2.o hardcoded in both
LIB_OBJS and REFTABLE_OBJS, so that the scraping in CMake.txt can
understand it.

>    One thing that I found a bit iffy is the use of "force z_const to
>    an empty string before including <zlib.h>".  This trick to work
>    around too old a version of zlib (according to Carlo) was used
>    only when compat/zlib-uncompress2.c included <zlib.h> via
>    <reftable/system.h>, but never done when <cache.h> included
>    <zlib.h>, which means that the two parts of the code could have
>    been using incompatible definitions of the same structs (many
>    struct definitions zlib uses have const members).  I opted to be
>    "conservative" and choose to cast away z_const before
>    <git-compat-util.> includes <zlib.h>, but we may want to drop it
>    to see if anybody screams.

Weren't any issues with this avoided because we didn't include the
reftable/* sources, but compiled them and then linked libreftable.a?
