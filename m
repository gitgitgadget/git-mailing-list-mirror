Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69E0C43217
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347813AbiAXTwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbiAXTlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:41:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181CC07A96B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:20:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j2so58228674edj.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jCgugfRwPHPg1wcdsRdohOnGLCUOKdlq5fvZ4bVW2pI=;
        b=BFdewsBSIirWhOw5hBaDAF3qMzFM9SIIvae1UsYnb1BR+ZgOot9DHkyfDtXLGellS6
         EL2UIS+sNnHgydAkrNXeWHQSv5xq3LVGSSxfiJfp9oE27+skoTMnXMCC7qbmYjJKzl7y
         6DgYISS5LbsrLLKTYsYrmZ/zmLgKs7Ab0G5/oHGFbRKYYNMjATHz5Y893y+roGxxUG7O
         IdAPoKGA88j7bGmBCBc4xJqSYXWUNwMB3ctyiWKiofq+4WzuI4MJs104H30YU8Ajn6uI
         +8svn0Jd2+odeLBctdUmzdH0ZhaHpfoDZ3l79480DA0LnMJXrQl0Z5ugmqN9LTOs6+H6
         XxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jCgugfRwPHPg1wcdsRdohOnGLCUOKdlq5fvZ4bVW2pI=;
        b=mBuIsbAWENXdzW41zWhgnd9rbP94wJ9MvwPOtgSe9Y1EBMHkWaqIeB1hWSPxkv/WAQ
         Zh3gzljnP6OaHqrqXTkhXFQlxA9MKfh7uATEQTuKoo1m2bAUP/YO6EOJa9Kz0lq5+JA3
         Hjac4k2LUADdlzVhmTE1PzuRzPmCl6sQRjN8lZIDG1jC7ftGvws/uqJnPT4UxiAvGfV0
         Fo7esWoGAA0P9nrk4MibhzqOL8N3j0NaUgHSJaj7KStMYB3LsRR3WzkKQnqi5cBqP08+
         KNmm+wBT1fd5J2qxitU/D4YteAAksyd7Dvm7MEpaDMusKXtxWwNOnlhiGGkUOrA4/Sk7
         7sYA==
X-Gm-Message-State: AOAM531frlbIFFOrhRRqjzwglR03QJL/V44uS++dAv3E3NxBymg9aggG
        ZNrUMbDXI+b/aMH+fUk1HBh7JKSaZcE=
X-Google-Smtp-Source: ABdhPJzZjRxGgmt/ydwXU2SnOHt2TXCC4GQfHXkIpDECer15iEfsdE5H9zh90tu67KkYRUAQiSgzeA==
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr17231841edd.377.1643052000411;
        Mon, 24 Jan 2022 11:20:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i12sm5260990ejj.198.2022.01.24.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:19:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nC4sh-002ZJz-4h;
        Mon, 24 Jan 2022 20:19:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5] compat: auto-detect if zlib has uncompress2()
Date:   Mon, 24 Jan 2022 20:07:26 +0100
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
 <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
 <xmqqr190ekrh.fsf@gitster.g>
 <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
 <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
 <xmqqr18x3s5s.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18x3s5s.fsf@gitster.g>
Message-ID: <220124.86r18xgcv4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, Junio C Hamano wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> [...]
> Attempt to instead ask the system header <zlib.h> to decide if we
> need the compatibility implementation.  This is a deviation from the
> way we have been handling the "compatiblity" features so far, and if
> it can be done cleanly enough, it could work as a model for features
> that need compatibility definition we discover in the future.  With
> that goal in mind, avoid expedient but ugly hacks, like shoving the
> code that is conditionally compiled into an unrelated .c file, which
> may not work in future cases---instead, take an approach that uses a
> file that is independently compiled and stands on its own.
> [...]

I think so, we do auto-probes on version (e.g. for libcurl and libpcre),
but I don't think we've outright defined some missing functions on that
basis, we have defined some missing macros though.

FWIW I did some experiments the other day with handling this via the
Makefile.

I.e. similar to how we generate the .depend/* dirs to optionally inject
the building of various "configure" programs into the build step, so
that e.g. git.c would depend on trying to compile a probe/uncompress2.c
or whatever. We'd then write NO_UNCOMPRESS2=3D$(FOUND_IT) to a file we'd
"include".

I think it's a generally nice thing to move towards, is relatively
light, and would eventually allow us to get rid of the optional
configure.ac (it would become redundant). We could also use it for
e.g. a more accurate "detect-compiler" shellscript (instead of trying to
guess from clang/gcc versions).

>  - Beat found a trick used by OpenSSL to avoid making the
>    conditionally-compiled object truly empty (apparently because
>    they had to deal with compilers that do not want to see an
>    effectively empty input file).  Our compat/zlib-uncompress2.c
>    file borrows the same trick for portabilty.

Aside: I have not yet found such a compiler, does anyone know of one
that breaks? In any case doing this for good measure seems fine, just
wondering if we're cargo-culting a needless workaround or not.

>  * With a single-liner update to the Makefile with an updated log
>    message that explains the change.  I am not sure if this version
>    can become the model of future "compat" support, or we should
>    just discard the new approach and use the Makefile macro approach
>    that has worked well for all of our existing compat support
>    already.
> [...]
>      -GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
>     ++# xdiff and reftable libs may in turn depend on what is in libgit.a
>      +GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) =
$(LIB_FILE)
>       EXTLIBS =3D

As noted I'm rather "who cares? :)" on the question of how we get the
uncompress2() compatibility function over to its eventual location
(directly or via *.o linker indirection), but this approch in v5 works &
addresses the issue I noted in v4. So this looks good to me!

FWIW I've tested this with this ad-hoc patch to simulate not having
uncompress2, and on systems that genuinely don't have it:
=20=20=20=20
    diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
    index 77a1b080484..539c14c2b54 100644
    --- a/compat/zlib-uncompress2.c
    +++ b/compat/zlib-uncompress2.c
    @@ -3 +3 @@
    -#if ZLIB_VERNUM < 0x1290
    +#if 1
    @@ -37 +37 @@
    -int ZEXPORT uncompress2 (
    +int ZEXPORT uncompress3 (
    diff --git a/git-compat-util.h b/git-compat-util.h
    index ea111a7b481..a6df48d76d5 100644
    --- a/git-compat-util.h
    +++ b/git-compat-util.h
    @@ -1392 +1392 @@ void unleak_memory(const void *ptr, size_t len);
    -#if ZLIB_VERNUM < 0x1290
    +#if 1
    @@ -1397 +1397 @@ void unleak_memory(const void *ptr, size_t len);
    -int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
    +int uncompress3(Bytef *dest, uLongf *destLen, const Bytef *source,
    diff --git a/reftable/block.c b/reftable/block.c
    index 855e3f5c947..ee341eb65fe 100644
    --- a/reftable/block.c
    +++ b/reftable/block.c
    @@ -213 +213 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
    -		    uncompress2(uncompressed + block_header_skip, &dst_len,
    +		    uncompress3(uncompressed + block_header_skip, &dst_len,
=20=20=20=20
