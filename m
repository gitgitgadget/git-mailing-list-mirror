Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AF3C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E75F610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 19:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhDITmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhDITme (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 15:42:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77BC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 12:42:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hq27so10407554ejc.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dWfaFVAoypEBcyA4T2N1hL9CLa32U3AnR3b7ZoXvSzY=;
        b=pbAn1pJZfJ7/8S0B3HUPOai+7cS2hkXifg4EEZdjUwteMagzxXFf/AA3eN+796+Uvy
         FucJzv+q7li27vpH4pevumAdWXKCD+oD5t4eS/hI6vWA1Dkd6BKPBHZCao6SmFtVTRdW
         hnPQyVg7n6V9RSxBmH53pjmxbOBRjjPl9GwooIElf7t+mDgi0liBhDLS9+ho+EJK+URU
         R2k25jh/Ssl4Nb7IrriP7XN36b02l+bV9Z/SXyLT61/VgCQOrBiPOZ9yiGkGaWUjMrqB
         /Z4nxGylHtjFEfhfloOecL6eDyqzryKoffEWPS5hNmv1OGpGsZAQqhTZvf95SMfNVciI
         mUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dWfaFVAoypEBcyA4T2N1hL9CLa32U3AnR3b7ZoXvSzY=;
        b=RsYh0MeVv94iBnfD7szr5/DLcQ1xOAWuP4VGSRh3Wun3AMY6MzClenTkS3Qk/NTQVD
         S+HhqMjobdZEuVbM7IzUevqSXXUhiE/jrsiLYi0KGWqYrlRPiMwJV5jEGwmquN0P/V5J
         f1VSc3rC/FmMJ8EYqrH9XQBFeifhjoUBvuJQW0KIFqbJFaN0ZGvsA/wTYTZyPPSMx/8T
         LLRKS9QF8bcuLfZZbsUpKsujmTkHwK5jZazMszcskmaII7VmKkBCUz6hbFPzeqWcgGJB
         jZjlKt8JDhaGyOjhDfvSKb+dVEZ0F9QCV5AezlOwBz/vmLNZMZQvjiO2QV9DG0lrL+O8
         iZRQ==
X-Gm-Message-State: AOAM530W8x/YFk+VECkax3iry5kGxd0X9cpadK+XU5ipAXn8pQusBMns
        O43jGW9c/FTTPSEY0SH8UB4=
X-Google-Smtp-Source: ABdhPJz6ZH6aUoLm5gYTd4EKbMIGnX3ZDKN9JQjicSb2Kz0CHmPUtesPrlel7ft5iSXj23crWkcJBw==
X-Received: by 2002:a17:906:55c9:: with SMTP id z9mr17159343ejp.360.1617997338388;
        Fri, 09 Apr 2021 12:42:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z20sm1937592edd.0.2021.04.09.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:42:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] object.c: make type_from_string() return "enum
 object_type"
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
        <patch-3.6-7fd86f6699-20210409T082935Z-avarab@gmail.com>
        <YHCZh5nLNVEHCWV2@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHCZh5nLNVEHCWV2@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 21:42:17 +0200
Message-ID: <87fszzgs86.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Jeff King wrote:

> On Fri, Apr 09, 2021 at 10:32:51AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the type_from_string*() functions to return an "enum
>> object_type", but don't refactor their callers to check for "=3D=3D
>> OBJ_BAD" instead of "< 0".
>>=20
>> Refactoring the check of the return value to check =3D=3D OBJ_BAD would
>> now be equivalent to "ret < 0", but the consensus on an earlier
>> version of this patch was to not do that, and to instead use -1
>> consistently as a return value. It just so happens that OBJ_BAD =3D=3D -=
1,
>> but let's not put a hard reliance on that.
>
> I think what the patch is doing is good, but this rationale misses the
> main point of that discussion, I think. I doubt that the value of
> OBJ_BAD would ever change. But the point was that we could grow a new
> "failure" value at "-2", and we would want to catch here (I do consider
> it relatively unlikely, but that IMHO is the reason to keep the negative
> check).
>
> I think for the same reason that "return OBJ_BAD" instead of "return -1"
> would be just fine (it is not "just so happens" that OBJ_BAD is
> negative; that was deliberate to allow exactly this convention). But I
> am also OK with leaving the "return -1" calls.

I'm beginning to think in response to this and the comment on 5/6 that
it might be cleaner to split up the object_type enum, as demonstrated
for a config.[ch] feature in [1].

Converting back and forth between them is a bit nasty, and having
multiple interchangable OBJ_* constants with identical values just to
satisfy them being in different enums, but it would allow having the
compiler explicitly help check that callers cover all possible cases of
values they could get.

Most callers just get OBJ_{COMMIT,TREE,BLOB,TAG} some more get that plus
OBJ_{BAD,NONE}, almost nobody gets OBJ_{OFS,REF}_DELTA, and AFAICT just
the peel code cares about OBJ_ANY. We then have an OBJ_MAX nobody's ever
used for anything (I've got some unsubmitted patch somewhere to remove
it).

What do you think about that sort of approach? I haven't convinced
myself that it's a good idea, so far I just thought bridging the gap of
things that return "enum" actually having that as part of their
signature for human legibility, even if C itself doesn't care about the
difference, and we currently can't get much/any of the benefits of the
compiler catching non-exhaustive "case" statements (unless every
callsite is to include OBJ_OFS etc.).

1. https://lore.kernel.org/git/875z0wicmp.fsf@evledraar.gmail.com/
