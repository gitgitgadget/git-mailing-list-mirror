Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE3C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjARQBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjARQAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:00:09 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262383FF29
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 07:57:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so84382223ejc.4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jm53Ka5sEUDUxKI6NmyGDlLRFwa+eMlNGVEETLAOYYc=;
        b=g7+oIvUlqnCxMPxOdZ7uCPzh1wXUkUDUbNAcirWPYLERxPk9c07zFPTcvELVCU1YNq
         OHft+RdbkW+unvB14qK7suxOJPqwzGEQFPRU7smz3g/U82cJ8JoVxcPRtrl6fDCWsE/I
         zDTvnsbaN/o8bGMbU/JSvYhjbMGTsPKHBX1FgCT6U6lz+Gco/tIyOzHiyzMm90vrty0N
         +wpIE3MmwhFW2OCsK9AItWZP4aFfRZm1d2v3+F8b2RdJQH9yxrC4oaJvmYJ9BVDXIhA4
         DFquqO1Hv2qBdkSCVNQNHe84YyHaf6olfHcCCNKlHe7wLWCDyU4xU2yofmkYosX8lRnd
         DbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jm53Ka5sEUDUxKI6NmyGDlLRFwa+eMlNGVEETLAOYYc=;
        b=A9PK7I+/veNUM+ND0giSYpW8ijKn3GEg4uEKBrr8Kp3ZvuitTqQWFyOgcY8kjpqLQI
         8qGNO1wvFn/FhSgisykYkrSAPKFsG3umaQm3I4CqbcXeJn8tpMnu7jRS7UNJSk1qSnIG
         oUr96MpdyESaMjh557BynE8Dcptswndx8GJ7O4jt0ZSTOUAXyx17TwxxCWN8fkyvx7ud
         r8csUI1C/tOyGqPcvjNja9fhLDJnZZ2+FBRlTmsIbDXg4LqeIL6IILaq1T0vF7eEfjaF
         a6OkUaCGDYvkt3eLCdT1YD6NfdV72yeBfaTIpPPqrL3q7M3d4h2edxpQDMTBbXWRq3R8
         n7nA==
X-Gm-Message-State: AFqh2kryWUYgAEf88ZFGlW6zQ+aS8xVoKxwui0aMB+46hBgyZa9uZG1F
        LbVUBEGMYwZbznBGDioif8ed6kvp1n1aoA==
X-Google-Smtp-Source: AMrXdXtktPik4T+Y9lUWZUGJCzxfZKLHZggluz6T763i/IM4ZMLuVKHsk1W+br1W0SwpI1QRIgauXw==
X-Received: by 2002:a17:906:2b8e:b0:86e:3531:5548 with SMTP id m14-20020a1709062b8e00b0086e35315548mr6917166ejg.73.1674057452304;
        Wed, 18 Jan 2023 07:57:32 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14390758edt.8.2023.01.18.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:57:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pIAod-002xHQ-0q;
        Wed, 18 Jan 2023 16:57:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Date:   Wed, 18 Jan 2023 16:44:54 +0100
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
 <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
 <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
 <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
 <2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net>
 <221220.86bknxwy9t.gmgdl@evledraar.gmail.com>
 <f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net>
Message-ID: <230118.86lelzx2c4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Mathias Krause wrote:

> On 20.12.22 22:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Dec 20 2022, Mathias Krause wrote:
>>=20
>> [De-CC-ing pcre-dev@, since this part is all git-specific]
>>=20
>>> Am 19.12.22 um 10:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Fri, Dec 16 2022, Carlo Arenas wrote:
>>>>
>>>> [CC-ing pcre-dev@ for this "future error API" discussion]
>>>>
>>>>> On Fri, Dec 16, 2022 at 3:09 PM Junio C Hamano <gitster@pobox.com> wr=
ote:
>>>>>>
>>>>>> Mathias Krause <minipli@grsecurity.net> writes:
>>>>>>
>>>>>>> ... However, from a user's point of view a fall back to
>>>>>>> interpreter mode might still be desired in this case, as a failing
>>>>>>> 'git grep' is simply not acceptable, IMHO.
>>>>>>
>>>>>> "git grep" that silently produces a wrong result (by falling back
>>>>>> after a problem is detected) would not be acceptable, either.
>>>>>
>>>>> except that an error at this point only invalidates the use of JIT,
>>>>> so calling pcre2_jit_match() is invalid but calling pcre2_match() is =
not.
>>>>>
>>>>> the later is setup to be used later by the code that is added,
>>>>
>>>> I think we could stumble ahead, but if this were to happen our
>>>> assumptions about how the API works have been invalidated.
>>>
>>> Well, pcre2_jit_compile() might fail for internal reasons, e.g.
>>> pcre2jit(3) states: "[...] If a pattern is too big, a call to
>>> pcre2_jit_compile() returns PCRE2_ERROR_NOMEMORY."
>>>
>>> For example, the following fails for me:
>>> $ git grep -P "$(perl -e 'print "(.)" x 4000')" -- grep.c
>>> fatal: Couldn't JIT the PCRE2 pattern '(.)(.)(.)(.)=E2=80=A6
>>>
>>> But explicitly disabling JIT makes it "work":
>>> $ git grep -P "(*NO_JIT)$(perl -e 'print "(.)" x 4000')" -- grep.c
>>> $
>>>
>>> It's a made up example and might even be intended behavior by git, but
>>> it also proves a point Carlo already mentioned, a failing call to
>>> pcre2_jit_compile() only invalidates the use of the JIT engine. We can
>>> still use and fall back to the interpreter.
>>=20
>> We should arguably do this, I hadn't bothered because I haven't been
>> able to find anything except pathological patterns where it matters, and
>> silently falling back in those cases will suck a lot more IMO.
>>=20
>> If you are using such a pathological pattern it's almost always a better
>> idea to adjust your crazy pattern.
>>=20
>> So I think in the *general* case we really should just keep this, and
>> *maybe* suggest the user try with (*NO_JIT) in the pattern.
>
> Except for the case I'm trying to address, where we simply cannot detect
> *why* the JIT is failing from the error code alone. It'll error out with
> PCRE2_ERROR_NOMEMORY for the case where the JIT fails to allocate W|X
> memory as well as for the case where the pattern is crazy.

*nod*, though I see you saw that I addressed that below.

>> But silently falling back kind of sucks, but unfortunately pcre2 doesn't
>> provide a way to say "failed because of SELinux" v.s. "failed because
>> the pattern is crazy", except that we could try to compile a known-good
>> pattern with the JIT, to disambiguate the two.
>
> Exactly, so what about something like this:
>
> If JIT is generally available, try to JIT the user supplied pattern:
> 1/ If it fails with PCRE2_ERROR_NOMEMORY, try to compile a know good
>    pattern, e.g. ".":
>    1a/ If this fails with PCRE2_ERROR_NOMEMORY as well, fall back to
>        interpreter, as JIT is non-functional because of SELinux / PaX.
>    1b/ If not, it's a "crazy" pattern, suggest '(*NO_JIT)'.
> 2/ If it succeeds or fails with a different error, continue as of now,
>    i.e. use JIT on success or die() on error, optionally suggesting
>    '(*NO_JIT)'.
>
> That should handle the case you're concerned about and only fall back to
> interpreter mode if JIT won't be functional anyway. Admitted, this would
> also allow crazy patterns, but there's simply no way to detect these
> under such constraints.

That sounds good, i.e. we could narrow the JIT falling back case to
these SELinux cases and the like, distinct from generic internal errors.

Maybe it's too much paranoia, but it should work & get rid of the
ambiguity.

>> Anyway, if this is your goal you should really lead with that, not with
>> fixing a relatively obscure SELinux edge case...
>
> It's just that I'm suffering from that "obscure SELinux edge case", just
> not under SELinux but PaX MPROTECT. I only mentioned SELinux to state,
> it's not only an issue for PaX but regular systems as well. So it's not
> a hypothetical case I like to get handled, but my work environment to
> get usable again.

Right, I didn't mean to imply it was, just that for the rest of us the
more general effect of this change outside of SELinux is of more general
interest.

>>> It would be used anyway if PCRE2 was compiled without JIT support, so I
>>> don't see any issues with falling back to interpreter mode if the JIT
>>> compilation fails -- for whatever reason.
>>=20
>> It's the "for whatever reason" that I take issue with. We'd be in an
>> unknown state with the API behaving differently than we expect, and
>> returning unknown codes. That's different than the *known* error codes
>> (e.g. "no memory", oven though it's meaning is apparently overloaded to
>> the point of near-uselessness).
>>=20
>>>> The pcre2_jit_compile() doesn't promise to return a finite set of error
>>>> codes, but:
>>>>
>>>> 	[...]0 for success, or a negative error code otherwise[...]
>>>>
>>>> But if new codes were added it's anyone's guess what state we'd be in,
>>>> so I think the safe thing is to BUG() out if we get as far as
>>>> pcre2_jit_compile() and don't get either PCRE2_ERROR_JIT_BADOPTION or
>>>> PCRE2_ERROR_NOMEMORY.
>>>
>>> But why BUG()? JIT is an optimization that might fail for PCRE2 internal
>>> reasons. Why should we make 'git grep' fail too in this case when we can
>>> handle it just fine by attempting to use the interpreter?
>>>
>>> If the pattern is really bogus, the interpreter will complain as well
>>> and we'll error out. But failing just because the JIT engine can't
>>> handle the pattern? Doesn't sound right to me.
>>=20
>> See above, we're failing because our assumptions about how to use the
>> API have broken down at that point. We usually bug out in those cases.
>>=20
>>>>>> Receiving BADOPTION could be a sign that there is something wrong in
>>>>>> the input, not from the end-user but from the code, in which case
>>>>>> stopping with BUG() may be a more appropriate?
>>>>>
>>>>> The way PCRE handles this kind of errors internally is to instruct pc=
re2_match()
>>>>> to use the interpreter.
>>>>>
>>>>> While a BUG() might be a way to ensure the code is using the right set
>>>>> of options
>>>>> I would expect that the failure will be reported by pcre2_compile
>>>>> instead, with the
>>>>> only cases left, only being interna to PCRE (ex: JIT can't yet support
>>>>> a feature the
>>>>> interpreter has)
>>>>
>>>> I agree that it's possible in general that an external library might
>>>> start returning a "benign" error code that we could recover from, so
>>>> BUG(...) would be overdoing it.
>>>
>>> And I think that's the case here: JIT is an optimization that might not
>>> be available under all circumstances, as, for example, under SELinux's
>>> 'deny_execmem' setting. So we need to have a backup plan for such
>>> systems anyway. Why not always try to use the interpreter if JIT
>>> compilation fails?
>>=20
>> See above, but maybe it's the least sucky thing (and definitely
>> simpler). I'm mainly checking that we're doing that we want here, and
>> that we're going into it with eyes open.
>>=20
>> That we're now discussing a topic entirely different from SELinux on a
>> thread where we're (according to the commit message) fixing pcre2 where
>> the JIT is "unusable on such systems" is my main concern here.=20
>
> Yeah, I overlooked that angle initially, but it's a valid concern.
> However, limiting the functional change of falling back to interpreter
> mode on "JIT's broken anyway" systems only should address these and get
> me a functional 'git grep' again.

*nod*

>>>> So not only would a BUG() biting us here require them to create a new
>>>> code for the state of "we have the JIT, but can't use it here" (for so=
me
>>>> reason I can't imagine, as "PCRE2_ERROR_NOMEMORY" is already
>>>> "overloaded" to mean that).
>>>>
>>>> It would also require them to invent a new "soft" failure mode for the
>>>> JIT, i.e. not the facility added in a25b9085043, where we can use the
>>>> JIT, but it's not on after all due to a "(*NO_JIT)" in the pattern
>>>> itself.
>>>
>>> We should really treat PCRE2 JIT as an *optional* optimization that
>>> might not be available for certain cases. For these we should, IMHO,
>>> simply use the interpreter mode, instead of bugging users with a BUG() /
>>> die().
>>=20
>> To summarize some of the above, I think performance also matters, we
>> have cases where:
>>=20
>>  A. We could use the non-JIT
>>  B. We could use the JIT, and it's a *lot* faster
>>  C. We can't use the JIT at all
>>  D. We can't use the JIT because we run into its limits
>>=20
>> I think it's fair to die on "D" as in practice you only (I think!) run
>> into it on pathological patterns, but yes, another option would be to
>> fall back to "A".
>>=20
>> But thinking you're doing "B" and not wanting to implicitly fall back to
>> "A" is also a valid use-case.
>
> Agreed. My above sketched handling should do that, as in not falling
> back to interpreter mode when the JIT would be functional per se, but
> just failed on this particular pattern.
>
>> So I'm inclined to suggest that we should be less helpful with automatic
>> fallbacks, and just suggest a "try it with '(*NO_JIT)'" advice() or
>> something.
>
> Well, that's a real pain from a user's (my) point of view. Trust me, I'm
> suffering from this, otherwise I wouldn't have brought up the issue ;)

That's fair enough, falling back in the "D" case sounds good.

>> But as noted above needing to always disable an apparently "available"
>> JIT on some systems (SELinux) does throw a monkey wrench into that
>> particular suggestion :(
>
> Yep.
>
>> So I'm not sure, I'm mainly trying to encourage you to think through the
>> edge cases, and to summarize the full impact of the change in a re-roll.
>
> Yeah, I agree. The implied fallback to the interpreter, even for the
> more obscure cases should have been mentioned in the changelog, but I
> overlooked / ignored that case initially.
>
> My take from the discussion is to do a re-roll with something like this:
>
>   if (p->pcre2_jit_on) {
>       jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
>       if (jitret =3D=3D PCRE2_ERROR_NOMEMORY && !pcre2_jit_functional()) {
>           /* JIT's non-functional because of SELinux / PaX */
>           p->pcre2_jit_on =3D 0;
>           return;
>       } else if (jitret) {
>           die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n"
>               "Try prefixing the pattern with '(*NO_JIT)'\n",
>               p->pattern, jitret);
>       }
>       ...
>   }
>
> ...with pcre2_jit_functional() being something like this:
>
>   static int pcre2_jit_functional(void)
>   {
>       pcre2_code *code;
>       size_t off;
>       int err;
>
>       code =3D pcre2_compile((PCRE2_SPTR)".", 1, 0, &err, &off, NULL);
>       if (!code)
>           return 0;
>
>       err =3D pcre2_jit_compile(code, PCRE2_JIT_COMPLETE);
>       pcre2_code_free(code);
>
>       return err =3D=3D 0;
>   }

This seems sensible as pseudocode, although please don't add another
pcre2_compile() entry point (as e.g. passing NULL here will bypass the
context we carefully set up, and if we have a custom allocator...).

Instead you could just re-enter the API itself via
compile_grep_patterns(), or perhaps lower via
compile_pcre2_pattern(). Then add some flag to "struct grep_opt" to
indicate that we shouldn't die() or BUG() there, but just run a "jit
test".

This code also treats all failures of pcre2_jit_compile() the same, but
here we only want PCRE2_ERROR_NOMEMORY.




