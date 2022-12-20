Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E2C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 21:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiLTVjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 16:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLTVjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 16:39:14 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CFCE0B2
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 13:39:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so32433925ejc.4
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NB3aASZd/TEbJHwmU9N4p65zPQn2tjrhbeVuvMBxsaw=;
        b=Xphlu9vI+vW5VXrZLtT3wR0fuiDTRkTEO6F1ve7d+nQUjkCLwvuEXKXNvxwwpcd/L1
         ByS4UhWcwjpK/aEN+/Ymf/THDEzm1CnGF66RlEk+1WexwiFMvIPsbYRskV2uCZN0UUv/
         KcnTefZs1f9zrzuRSFpJoajenrB1awG+/U4o5wPvL04e9ifPxIslElTbFwIULKgNah3p
         Zsqzd2RAZljzvRM+onrjU2uyl6Ux+bXMJb7F7TmfABJq3T2E75AH1Rz9hbr0OH5WRiY6
         fIfgFD+wrJgqIr848AurOShURgNxfzyXRyW7bX9Q5+5+8q8lWElzLLPaXXEKFmcmGEt3
         pEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB3aASZd/TEbJHwmU9N4p65zPQn2tjrhbeVuvMBxsaw=;
        b=od9FkRCGc9Fj2/oqLGA0NN9LJVQ23fa/+RfByEdnuudAm/339HWhvxeyo/Bqb/Jz2c
         K6HRE0kxouwUIqbgWVvCyOFm0p1lljxObPSsM2j5nk6OGm/jWGs9mK4OhxV8u2vckILo
         bBavdW6zoP4Z1BjitWdI4RaiUAB4sarsGmz8lWe+BiFAT8y6dCUVimN+4nZWTNwQXiGo
         +ZklynnPM+6Muy1nieoEBuBD05dhImJl6erRowM1Zal10NhfcBGsIjX5IcqNigzN55dQ
         yoitJ/hL27/FPxFbBip+7pF2ajyOEHaWS8UUUY76ndNmPit1CKpR02eU6xyIqMgad/da
         5cQA==
X-Gm-Message-State: AFqh2kobisvAeER19NShMevoldkp3ptdXrb2QkVBPJDOWNWVeuJoIhhn
        zrnV2a3HppHi1P4TgHRmVO8=
X-Google-Smtp-Source: AMrXdXuYu2QgU8UgFvhymLrK2PGAj9emhzjPD/o3Ou8prkIU29kQHNW6m6Bmn/CSBpoi7E69OjW5JA==
X-Received: by 2002:a17:906:c246:b0:7c0:dfbd:5a1a with SMTP id bl6-20020a170906c24600b007c0dfbd5a1amr3364784ejb.33.1671572351427;
        Tue, 20 Dec 2022 13:39:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id gy19-20020a170906f25300b007bf24b8f80csm6206326ejb.63.2022.12.20.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:39:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7kKM-007YmU-1H;
        Tue, 20 Dec 2022 22:39:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Date:   Tue, 20 Dec 2022 22:11:28 +0100
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
 <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
 <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
 <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
 <2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net>
Message-ID: <221220.86bknxwy9t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Mathias Krause wrote:

[De-CC-ing pcre-dev@, since this part is all git-specific]

> Am 19.12.22 um 10:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>=20
>> On Fri, Dec 16 2022, Carlo Arenas wrote:
>>=20
>> [CC-ing pcre-dev@ for this "future error API" discussion]
>>=20
>>> On Fri, Dec 16, 2022 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>>>
>>>> Mathias Krause <minipli@grsecurity.net> writes:
>>>>
>>>>> ... However, from a user's point of view a fall back to
>>>>> interpreter mode might still be desired in this case, as a failing
>>>>> 'git grep' is simply not acceptable, IMHO.
>>>>
>>>> "git grep" that silently produces a wrong result (by falling back
>>>> after a problem is detected) would not be acceptable, either.
>>>
>>> except that an error at this point only invalidates the use of JIT,
>>> so calling pcre2_jit_match() is invalid but calling pcre2_match() is no=
t.
>>>
>>> the later is setup to be used later by the code that is added,
>>=20
>> I think we could stumble ahead, but if this were to happen our
>> assumptions about how the API works have been invalidated.
>
> Well, pcre2_jit_compile() might fail for internal reasons, e.g.
> pcre2jit(3) states: "[...] If a pattern is too big, a call to
> pcre2_jit_compile() returns PCRE2_ERROR_NOMEMORY."
>
> For example, the following fails for me:
> $ git grep -P "$(perl -e 'print "(.)" x 4000')" -- grep.c
> fatal: Couldn't JIT the PCRE2 pattern '(.)(.)(.)(.)=E2=80=A6
>
> But explicitly disabling JIT makes it "work":
> $ git grep -P "(*NO_JIT)$(perl -e 'print "(.)" x 4000')" -- grep.c
> $
>
> It's a made up example and might even be intended behavior by git, but
> it also proves a point Carlo already mentioned, a failing call to
> pcre2_jit_compile() only invalidates the use of the JIT engine. We can
> still use and fall back to the interpreter.

We should arguably do this, I hadn't bothered because I haven't been
able to find anything except pathological patterns where it matters, and
silently falling back in those cases will suck a lot more IMO.

If you are using such a pathological pattern it's almost always a better
idea to adjust your crazy pattern.

So I think in the *general* case we really should just keep this, and
*maybe* suggest the user try with (*NO_JIT) in the pattern.

But silently falling back kind of sucks, but unfortunately pcre2 doesn't
provide a way to say "failed because of SELinux" v.s. "failed because
the pattern is crazy", except that we could try to compile a known-good
pattern with the JIT, to disambiguate the two.

Anyway, if this is your goal you should really lead with that, not with
fixing a relatively obscure SELinux edge case...

> It would be used anyway if PCRE2 was compiled without JIT support, so I
> don't see any issues with falling back to interpreter mode if the JIT
> compilation fails -- for whatever reason.

It's the "for whatever reason" that I take issue with. We'd be in an
unknown state with the API behaving differently than we expect, and
returning unknown codes. That's different than the *known* error codes
(e.g. "no memory", oven though it's meaning is apparently overloaded to
the point of near-uselessness).

>> The pcre2_jit_compile() doesn't promise to return a finite set of error
>> codes, but:
>>=20
>> 	[...]0 for success, or a negative error code otherwise[...]
>>=20
>> But if new codes were added it's anyone's guess what state we'd be in,
>> so I think the safe thing is to BUG() out if we get as far as
>> pcre2_jit_compile() and don't get either PCRE2_ERROR_JIT_BADOPTION or
>> PCRE2_ERROR_NOMEMORY.
>
> But why BUG()? JIT is an optimization that might fail for PCRE2 internal
> reasons. Why should we make 'git grep' fail too in this case when we can
> handle it just fine by attempting to use the interpreter?
>
> If the pattern is really bogus, the interpreter will complain as well
> and we'll error out. But failing just because the JIT engine can't
> handle the pattern? Doesn't sound right to me.

See above, we're failing because our assumptions about how to use the
API have broken down at that point. We usually bug out in those cases.

>>>> Receiving BADOPTION could be a sign that there is something wrong in
>>>> the input, not from the end-user but from the code, in which case
>>>> stopping with BUG() may be a more appropriate?
>>>
>>> The way PCRE handles this kind of errors internally is to instruct pcre=
2_match()
>>> to use the interpreter.
>>>
>>> While a BUG() might be a way to ensure the code is using the right set
>>> of options
>>> I would expect that the failure will be reported by pcre2_compile
>>> instead, with the
>>> only cases left, only being interna to PCRE (ex: JIT can't yet support
>>> a feature the
>>> interpreter has)
>>=20
>> I agree that it's possible in general that an external library might
>> start returning a "benign" error code that we could recover from, so
>> BUG(...) would be overdoing it.
>
> And I think that's the case here: JIT is an optimization that might not
> be available under all circumstances, as, for example, under SELinux's
> 'deny_execmem' setting. So we need to have a backup plan for such
> systems anyway. Why not always try to use the interpreter if JIT
> compilation fails?

See above, but maybe it's the least sucky thing (and definitely
simpler). I'm mainly checking that we're doing that we want here, and
that we're going into it with eyes open.

That we're now discussing a topic entirely different from SELinux on a
thread where we're (according to the commit message) fixing pcre2 where
the JIT is "unusable on such systems" is my main concern here.=20

>> So not only would a BUG() biting us here require them to create a new
>> code for the state of "we have the JIT, but can't use it here" (for some
>> reason I can't imagine, as "PCRE2_ERROR_NOMEMORY" is already
>> "overloaded" to mean that).
>>=20
>> It would also require them to invent a new "soft" failure mode for the
>> JIT, i.e. not the facility added in a25b9085043, where we can use the
>> JIT, but it's not on after all due to a "(*NO_JIT)" in the pattern
>> itself.
>
> We should really treat PCRE2 JIT as an *optional* optimization that
> might not be available for certain cases. For these we should, IMHO,
> simply use the interpreter mode, instead of bugging users with a BUG() /
> die().

To summarize some of the above, I think performance also matters, we
have cases where:

 A. We could use the non-JIT
 B. We could use the JIT, and it's a *lot* faster
 C. We can't use the JIT at all
 D. We can't use the JIT because we run into its limits

I think it's fair to die on "D" as in practice you only (I think!) run
into it on pathological patterns, but yes, another option would be to
fall back to "A".

But thinking you're doing "B" and not wanting to implicitly fall back to
"A" is also a valid use-case.

So I'm inclined to suggest that we should be less helpful with automatic
fallbacks, and just suggest a "try it with '(*NO_JIT)'" advice() or
something.

But as noted above needing to always disable an apparently "available"
JIT on some systems (SELinux) does throw a monkey wrench into that
particular suggestion :(

So I'm not sure, I'm mainly trying to encourage you to think through the
edge cases, and to summarize the full impact of the change in a re-roll.
