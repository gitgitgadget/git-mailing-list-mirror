Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F40C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C5C64FA7
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCFR2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 12:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhCFR1q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 12:27:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039E5C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 09:27:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ci14so10608266ejc.7
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4fgxlrwzfHmnxdNK0XDTbEkuumKVjUmjX0YytLYJBp8=;
        b=ZeMk9nW/kT/RXyaq+IT2+jBfOq/4M0rT2lHesdzI1265k8CmquBNW7yEhzw2RcAyGd
         klfdygqG8kHgCURsDgLWUbCKOKnwzQjhT1Fcp/eO3BuY8kQxf4vID3q92uQrzO4QqS0z
         sJPQFeJBC3mliLMTbqnLNszvdocMgb/n7L4y4TVmjvbOh+M/6gSjYzzEv2sBLl7tYWHZ
         4CSdCXaAV5pjr5DZ+ljMh2YrxIXNWTPFpOb/nA+m3ZdbowaFaef8xFgWpptb+Rn8oRiR
         7Ha9yWKR0SB/R1NQN0HVGC2kRxrCzUDN43Ngjga+hQlxIFb4BKN9SBYjQ66KijLr/5xe
         R/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4fgxlrwzfHmnxdNK0XDTbEkuumKVjUmjX0YytLYJBp8=;
        b=tZJCQ8KIzvQ9/rQbP2+FVVOknwjcDfmglXL8Xz1mt3oTtwj2zcWTVnc5BLzHZo9Oxe
         ELTfcg47Ej0mIWxYqMxJSnTZgHhyDhlz1WztNNCXZjMDpYehsWJU8tNlAXYP8sEcIjiy
         Wgux6O8DGFbpUlM63qvxldwrBuHgtrVoCvoaR3GKeaFm7gxrl+8JREN+GoNLX9gnjB+e
         z/vzckjEAah33kzYrnh3oMetuM1ZXR3/uw7ZWEnhOg+lyr9Fm4RfkQ6whwVBb+fpUurW
         CEIh59Rz834WZIFeTk17m/jfjTVVI/uJEMu0zDPE+/6AG6pJQcf8B/J3EsHWXHrQ5cSW
         d3ug==
X-Gm-Message-State: AOAM533DSkofEam2A/Z3jnjF+Ooq6kDDD8MIpD1KlE8hk0uQp1RV3NMn
        lRokjN8SNRkVl4EAm3dQXU8=
X-Google-Smtp-Source: ABdhPJzA2Qj5X0h1JzoJp5qICWp/F6QyunnHxVsIsJBbDTq/cJNAzA9YvJl1fw5VVPFetObtavZMiA==
X-Received: by 2002:a17:906:73d5:: with SMTP id n21mr7926420ejl.8.1615051664481;
        Sat, 06 Mar 2021 09:27:44 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o1sm3925730eds.26.2021.03.06.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 09:27:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
 <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
Date:   Sat, 06 Mar 2021 18:27:43 +0100
Message-ID: <87ft18tcog.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Ren=C3=A9 Scharfe. wrote:

> Am 05.03.21 um 18:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Addresses feedback on v1:
>>
>>  - The removal of the "cat $@.log" is gone.
>>  - Split up into N changes.
>>  - Explained why 960154b9c17 (coccicheck: optionally batch spatch
>>    invocations, 2019-05-06) broke things and produced duplicate hunks
>>    in 2/4: tl;dr: spatch does its own locking etc., xargs -n trips it
>>    up.
>>  - Set number of batch processes to 8, as suggested by Jeff King.
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>   Makefile/coccicheck: add comment heading for all SPATCH flags
>>   Makefile/coccicheck: speed up and fix bug with duplicate hunks
>>   Makefile/coccicheck: allow for setting xargs concurrency
>>   Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>>
>>  Makefile | 34 +++++++++++++++++++++++++---------
>>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> This speeds up "make coccicheck" after "make clean" as advertized for
> me:
>
>    before: 572.64s user 33.08s system 622% cpu 1:37.30  total
>    after:  195.40s user  9.97s system 629% cpu   32.612 total
>
> However, it also misses several conversions that coccicheck generated
> without this series for the example added by the patch at the bottom.
> Here's the difference of diffstats (< before, > after):
>
>    $ diff <(diffstat b | sort) <(diffstat a | sort) | grep '^[<>]' | sort=
 -k2 -k1
>    >  27 files changed, 55 insertions(+), 57 deletions(-)
>    <  36 files changed, 70 insertions(+), 71 deletions(-)
>    <  attr.c                   |    2 +-
>    >  blame.c                  |   15 +++++++--------
>    <  blame.c                  |   17 ++++++++---------
>    <  bloom.c                  |    2 +-
>    <  cache-tree.c             |    2 +-
>    >  combine-diff.c           |   18 +++++++++---------
>    <  combine-diff.c           |   20 ++++++++++----------
>    <  decorate.c               |    2 +-
>    <  diffcore-rename.c        |    2 +-
>    >  diffcore-rename.c        |    3 +--
>    <  ewah/bitmap.c            |    2 +-
>    <  hashmap.c                |    2 +-
>    >  midx.c                   |    4 ++--
>    <  midx.c                   |    8 ++++----
>    <  pack-objects.c           |    2 +-
>    <  pathspec.c               |    2 +-
>    >  read-cache.c             |    2 +-
>    <  read-cache.c             |    4 ++--
>    >  ref-filter.c             |    2 +-
>    <  ref-filter.c             |    4 ++--
>    <  remote.c                 |    2 +-
>
> That's with the current spatch version 1.1.0-00072-g3dc5d027.
>
>
> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.co=
cci
> index 46b8d2ee11..1f26da007a 100644
> --- a/contrib/coccinelle/array.cocci
> +++ b/contrib/coccinelle/array.cocci
> @@ -88,3 +88,16 @@ expression n;
>  @@
>  - ptr =3D xmalloc((n) * sizeof(T));
>  + ALLOC_ARRAY(ptr, n);
> +
> +@@
> +type T;
> +T *ptr;
> +expression n !=3D 1;
> +@@
> +(
> +- ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \));
> ++ CALLOC_ARRAY(ptr, n);
> +|
> +- ptr =3D xcalloc(\( sizeof(*ptr) \| sizeof(T) \), n);
> ++ CALLOC_ARRAY(ptr, n);
> +)

Well spotted, the issue is that you're using a "type" in the rule, or
well, rather that I don't know much about *.cocci and didn't think to
test that.

So because of s/--all-includes/--no-includes/ we don't include any
includes, and thus don't know about the type, and thus can't match on
this.

So obviously a bad bug, and I'll need to re-roll this, but any fix I've
been able to come up with (playing with other cocci options) takes away
most of the speed gains.

Well, there's the option of e.g. injecting options if "grep -q ^type
<cocci-file>" is true, which would work for the current input.

Do these sorts of rules really benefit that much from the type
v.s. expression? If yes we'll obviously need to support it, but if (and
I haven't looked closely) we can equally rewrite them with "expression"
(or it would be good enough) we could be quite a bit faster by
default...
