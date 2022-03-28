Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A84C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245424AbiC1TFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiC1TFe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:05:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5575245B1
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:03:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x34so18031935ede.8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bIv1qzBdafYszEW8TUQHw5ut+P8MqdyAgRzcXvcKrH4=;
        b=QgdWz4BwRSwll1xBuuZZX/st4PBqXNfEIOr2i5f//OAGKerSs53dzRiPsiregEKlkc
         3xSiukrMM2XhTeCiH2jydHZCuWH8SWFykcTvm38m5UJA1cITHcPcSnUCy7Pdqqs3s+ST
         FV6SFqRkBQbJUwWJcmJ1VogByB3cWMafNb/IegclazYB7r5L1yXioVBQ9cplRE0mfMLq
         hECz+s0aWuh0fCcGAs/TmasZf35TkiUeFJkBZyZKRGnwEkHcO5RRzj//f51mtkRpWtE8
         61zXqsRArbdnZQX6TBT82sLpUbh+eRouFL/toUFgT80KK6a9NZjyvDBu2iuIlE5XiDMb
         Y27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bIv1qzBdafYszEW8TUQHw5ut+P8MqdyAgRzcXvcKrH4=;
        b=TjB8BJ+XZGfzn1DqurYRJRHiu7XT+m8WufAJzSnZttr8jcFmFVSJgjkD6V95Ijqz0x
         LfIG5lrgqxKHaqODu6A81+hXOph1/QKeIknxgDfyNPQEMyffAJDVA5eswuhdvUAYaOon
         Hl67W+6jTse2zrFl0P3uqAv+520kXbISbHRbhMia7cQs1uyT0gOimh17awP6t1ytgnMF
         AJgeOxWl/OrLN0gNR2qGGgtIEQEdRCWH+iUmraNZ2FjQJXm+5U6v9hZNfVwcUs4odx6U
         qLkRhVWsiV76UZYL0m5kQj+l7D/xubTuSJbfOQ+Q9V/sry3k1HTbnUhTjD5KPaODcYPv
         kfkg==
X-Gm-Message-State: AOAM530VsKSJrHIW5s4cDk0WT8fAWBwIeFiElnVDD41J0Nn8h5TrgAYn
        +ni53JqOtLmvzwh8hykdq5o=
X-Google-Smtp-Source: ABdhPJyMJylPuKag0rUDOqQNV07q5i7zIIMVFrhYraaLSnDe9iZLz9wZdLN+3Fas39T8fNVKTIB2eQ==
X-Received: by 2002:a50:eb8b:0:b0:419:a11c:8676 with SMTP id y11-20020a50eb8b000000b00419a11c8676mr18027057edr.267.1648494232015;
        Mon, 28 Mar 2022 12:03:52 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090657c300b006d01de78926sm6263614ejr.22.2022.03.28.12.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:03:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYuec-003OGx-P4;
        Mon, 28 Mar 2022 21:03:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 08/27] revisions API users: add "goto cleanup" for
 "rev_info" early exit
Date:   Mon, 28 Mar 2022 20:55:31 +0200
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <patch-v3-08.27-f8a9443fe6f-20220325T171340Z-avarab@gmail.com>
 <xmqqtubl93n3.fsf@gitster.g> <220326.86ee2pleua.gmgdl@evledraar.gmail.com>
 <xmqqee2p70c1.fsf@gitster.g>
 <3bb95e8b-4977-ddca-225c-5afe28d8ac20@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <3bb95e8b-4977-ddca-225c-5afe28d8ac20@github.com>
Message-ID: <220328.86tubh3nmx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Derrick Stolee wrote:

> On 3/26/2022 1:24 AM, Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>>> Because I don't see how it makes any sense to have a REV_INFO_INIT if it
>>> doesn't actually give you an init'd "struct rev_info" that's ready for
>>> use. I.e. if you still need to call repo_init_revisions() it's just a
>>> misleading interface.
>>=20
>> You can say
>>=20
>> 	struct something *foo =3D NULL;
>>=20
>> 	if (some condition)
>> 		foo =3D alloc_and_init_foo();
>>=20
>> 	...
>>=20
>> 	free_and_destruct(foo);
>>=20
>> and it is correct that "initialize with NULL" alone would not let
>> you use the thing as full fledged 'foo', but you can still safely
>> pass it to free_and_destruct() (or if "something" does not hold
>> external resources, it could just be free()).  A flow like this:
>>=20
>> 	struct rev_info revs =3D REV_INFO_INIT;
>>=20
>> 	if (!some condition)
>> 		goto leave;
>> 	init(&revs);
>> 	... use revs ...
>> leave:
>>         release(&revs);
>>=20
>> would exactly be the same thing.
>>=20
>> In other words, you say "I do not see how it makes any sense" but to
>> me it looks more like what does not make sense is your argument
>> against what was suggested.
>

[re-arranging a bit]

> However, now that we are intending to free rev_info structs,
> we need them to be initialized with NULL pointers because
> otherwise the release_revisions() method won't know which
> portions were legitimately initialized and which ones were
> not.
>
> Maybe this NULL assignment happens as part of
> repo_init_revisions(), but that also assumes that there is no
> code path that would jump to a "leave" or "cleanup" tag before
> running that initialization method (which is the broken case
> that Junio mentions above).
>
> Maybe there are tools that would identify that Junio's example
> would be bad, but it is also likely that a compiler doesn't
> catch that issue and tests don't cover that error condition.
>
> It's my preference to initialize things to all-zeroes whenever
> there is any chance of complexity, which is why this topic has
> come to my attention on multiple threads.

Mine too, IOW I really don't like the version in my own v3 here, but
wanted to just use an initialization to { 0 } as in the v2.

But I read Junio's reply to
https://lore.kernel.org/git/220324.868rszmga6.gmgdl@evledraar.gmail.com/
as objecting to that general assumption, as we do e.g. in some of this
code:

    git grep 'struct.*=3D.*\{ 0 \}'

So the v3 rewrite of those was seeking a way around that which didn't
require implementing a full init-from-macro of REV_INFO_INIT.

Junio, would you be OK/prefer to basically have the v2 verison, with
just a dummy macro like this in revision.h?:

    #define REV_INFO_INIT { 0 }

Which we'd then do something more useful with down the line?

> =C3=86var has stated in multiple threads that he prefers to not
> initialize data so that static analysis tools can detect a
> use-before-initialization of specific members.

Just to be clear, I prefer not doing initialization in cases where the
compiler is guaranteed to help you by skipping them, i.e. init to NULL
within a function where say 2 branchesh both init the value, but if you
were to change that the init to NULL would hide the bug.

(And I'm sure it's not something I came up with, but got pointed out to
me repeatedly in review (by Jeff King or Junio?), until I got it...)

But skipping zero-ing out a struct like "struct rev_info" is not such a
case where the compiler can really help, and we often use that struct at
a far distance from where it was init'd. So I'd really like to see us
not do that as a habit, even if say valgrind can sometimes catch it (but
only if we have 100% test coverage!).

You're probably thinking more of the case of [1]. I consider that a
pretty clear case of running with scissors, I just figured that one was
narrow enough to be OK, but it's good to have [2] instead.

1. https://lore.kernel.org/git/patch-1.1-193534b0f07-20220325T121715Z-avara=
b@gmail.com/
2. https://lore.kernel.org/git/patch-v2-1.1-9951d92176e-20220328T154049Z-av=
arab@gmail.com/
