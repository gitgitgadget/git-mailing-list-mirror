Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C22FC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiK1SaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiK1SaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:30:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEAA2F646
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:23:20 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so28037064ejc.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Y11zDasQCj29Rv6TyoFsfM8AB3tHx4FYUjXheV6ew0=;
        b=jU/ir+dvYnQl8dV2WCHR+PeW0OABgGSNk+620CXZeUzuvutgXJ4tTPRU/VMJSw7Ra5
         oHlCPGasdpHRCR7sYzqh5HHHKfpoTEDtjvqg+XRF1SghtkmuulKEm0qFDs6vO3Bo8/A8
         e/fUSGnup4dtE3i1UDWmu5Pu3muhiFeg3q7+x3DU/ZAcLbWNY302QnRTJMFlpqOylMhm
         yIqO35YJVpNZOyYxk/mU5W1IuaCI266acydXC6GTzD34Vm/w7qbCabgCSqhcNFXimOkt
         MCRXQU68Modcz+B3n29P7HpMXmNy/3Yh1SrIyBUu4V+lWAJqEJySt4HvpLbFTFbVetRl
         W8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Y11zDasQCj29Rv6TyoFsfM8AB3tHx4FYUjXheV6ew0=;
        b=EkXDJyELMD+rMCkdgCUzb2KyDYY9OtpxoqCT0WqvC7MOPg0l8Q9IqCiFOYBFA+sUhn
         EgNZ5v13ptDiyIs/cWFG/J0YD0Gw/bFptvDBV4Z0wsRSI7NGhgcI0T8/QQqUik0RIbW3
         43U9bvhNBgO4Wmsc+aSyCb/D4UO924AoOVVdVpHYUUtcnNmvEXb3USdUltVOnziZANGn
         fbYaV5kTPY2GsVD0sZrE65TOKvLPZ3zKyGYiNBR1C5iNJ3lFPaDdazUsNEXBWkqZ8wVp
         jdooXhig/NzfZ3PMpLieQ+Fl8XeGIrVHy2z5DBDO2MtptAgEqNpE4imGm1w08VzNl8NH
         FCMA==
X-Gm-Message-State: ANoB5pk+6sZG7+bG0daxuHvxnovFRDXAmDiFAJaMaAZwb2kh1GmtXIsy
        E2NFB+9R9KuwzXmH17zALdeTXhb3yARsvw==
X-Google-Smtp-Source: AA0mqf6p4LmIkfFt8Fu3smwBdNIcSyGyoGd+xaM7DF5EsrN9dmbeb7ma5EFAkA1BP84TyNKyFSnKeg==
X-Received: by 2002:a17:906:9e20:b0:7af:206:9327 with SMTP id fp32-20020a1709069e2000b007af02069327mr44994484ejc.154.1669659799058;
        Mon, 28 Nov 2022 10:23:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id tg13-20020a1709078dcd00b0077b523d309asm5240458ejc.185.2022.11.28.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:23:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozimj-001E7M-2s;
        Mon, 28 Nov 2022 19:23:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Date:   Mon, 28 Nov 2022 18:57:34 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
        <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
        <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de>
        <xmqqv8mz5ras.fsf@gitster.g>
        <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
        <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
        <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
        <221128.865yezkule.gmgdl@evledraar.gmail.com>
        <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
Message-ID: <221128.86sfi3j5uy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 28.11.2022 um 15:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> [...]
>> I mean skip it when it's not needed, it's needed when we call
>> get_object_list().
>>
>> But what "problem" is being caused by get_object_list()? That there's
>> some other case(s) where it'll leak still? I haven't checked, I think we
>> should leave that for some other time if there's such leaks, and just
>> not introduce any new leaks in this topic.
>
> The problem is "How to use struct rev_info without leaks?".  No matter
> where you move it, the leak will be present until the TODO in
> release_revisions() is done.

No, the problem at hand is that "--filter" doesn't accept N arguments,
which is easily fixed.

Junio then tested the patch, and noted CI failing. Yes we have various
outstanding issues with the revisions API etc. leaking, but the
scope-creep of conflating those questions with a regression fix doesn't
seem necessary.

>>> [...]
>>> Well, that TODO fix should remove this new diff_free() call, but I
>>> agree that this is fragile.
>>>
>>> Removing the "TEST_PASSES_SANITIZE_LEAK=3Dtrue" line from affected tests
>>> is probably better.
>>
>> Or just not introduce new leaks, per my suggested fix-up at
>> https://lore.kernel.org/git/221128.86zgcbl0pe.gmgdl@evledraar.gmail.com/
>> (which it looks like you haven't seen when this E-Mail is composed...).
>
> Not adding leaks is a good idea.  AFAICS none of my patches so far add
> any.

I don't see where debating what constitutes a "new" or "added" memory
leak is going to get us.

But to clarify I'm not saying you're responsible for the
revisions/filter APIs you're running into, and some of those are
existing leaks.

I'm also saying that if you run:

	make SANITIZE=3Dleak test T=3D...

For some values of T=3D... (and the whole test suite with
"GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue") your 2/3 passes certain tests,
and your 3/3 doesn't.

> Patch 3 of v2 exposes an existing one that was only triggered by
> the --filter option before.  Which is also not ideal, of course, but
> giving it more visibility hopefully will motivate a proper fix.

We try not to break CI. Only finding out that existing CI breaks once a
patch is queued & Junio & others start testing it to hunt down issues
isn't a good use of anyone's time.

So, maybe you think this area of CI is useless etc., but again, if
you're submitting a change to advocate for that can we peel that away
from a regression we can fix relatively easily?

>>>> As you'd see if you made release_revisions() simply call
>>>> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
>>>> cases.
>>>
>>> That was my first attempt; it breaks lots of tests due to double frees.
>>
>> Right, to be clear I'm saying that none of this is needed right now,
>> i.e. I don't get why we'd want the scope-creep past the hunk I noted in
>> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
>> for the --filter bug fix (plus the tests you're adding).
>
> Well, you asked to squash the minimal fix into the laziness removal in
> https://lore.kernel.org/git/221112.86bkpcmm6i.gmgdl@evledraar.gmail.com/

The second part of the relevant request being so that we could
regression test the memory leak(s).

So, thanks for trying to address that in some way, but proceeding to
break linux-leaks, and then arguing that that's OK seems like an odd way
to go about that...

> Reverting 5cb28270a1 (pack-objects: lazily set up "struct rev_info",
> don't leak, 2022-03-28) wholesale is the simplest way to reach the goals
> of regression fix, simplification and standard compliance.  Except that
> the leak check tests have come to depend on the leak being hidden in the
> --filter corner.  So going back to v1 sure seems attractive.

Yeah.

Honestly I'd mostly forgotten about the v1 review, and only skimmed
things then. So, I've just noticed that the "squash" I'm suggesting is
basically equivalent to your v1 now.

But yeah I think it's fine to just skip testing the regression fix with
SANITIZE=3Dleak for now, we can do it some other time.

I just brought it up in the v1 feedback because that patch prominently
notes the leak fix, so if we can get regression test it relatively
easily that seemed like a good change to make.

>>> [...]
>>> I saw it as the way towards a release_revisions() that calls diff_free()
>>> itself: Add such calls to each of them, fix the "gnarlyness"
>>> individually, finally move them all into release_revisions().  The only
>>> problem is that there are 60+ callsites.
>>
>> I think this is a really bad approach in general.
>>
>> Yes, it may happen to work to free() some data from under an API, but
>> it's just as likely that we'll miss that this one caller is screwing
>> with its internal state, and e.g. when some new revision.c code is used
>> it'll go boom.
>>
>> If we wanted to phase in such a free() of "foo" I think the right way
>> would be to add some "revs.free_foo =3D 1" flag, giving the API a chance
>> to treat that sanely, not to start poking at members of the struct, and
>> assuming that its release() won't be free()-ing them.
>
> And that's why you added no_free to struct diff_options.  We could use
> it here by setting it in repo_init_revisions() and unsetting in
> cmd_pack_objects() and elsewhere, until it is set everywhere.

FWIW I think the "no_free" isn't all that good of an approach in
retrospect either, but at least it's (mostly) self-contained in the
struct that owns it.

But it's rather messy, because some of the time it's embedded in a
"struct rev_info" that should really own it, and sometimes now. At the
time release_revisions() didn't exist yet, so making some forward
progress with the diff leaks was easiest with the "no_free".

>> But as noted above & in the linked I think we can defer all of that. The
>> only reason we're discussing this is because you're changing the
>> lazy-init to be not-lazy, and introducing new leaks as a result.>
>> I've shown a couple of approaches in this thread of fixing the issue(s)
>> at hand without introducing such leaks, so ...
>
> As noted above: These leaks are not new, they are just moved into
> test coverage.

Right, and in some cases we should definitely just un-mark a test as
being tested under linux-leaks to make forward progress.

But in this case I just don't see how that's a good trade-off. We can
fix the --filter bug without that, and yes we'll have some new/existing
leaks, but those are all contained in tests that are not tested by
linux-leaks now.

Whereas the larger rewrite to make the init non-lazy would lose us test
coverage.

