Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABCC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 14:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjAROeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjAROdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 09:33:31 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6454673B
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 06:22:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so83548733ejm.8
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTGSRMTw/sfEXsZ/qwAwfgXXVnsaK6Tm0ucwCX4y3SM=;
        b=OwbGtQ7yr+LYr/SAMdn9KjNuR4V8N/NGrnkCJdtf1VIbAxw06o4L2UXpXzWnQTg02/
         E+WKvuPRx4gIaigYOodews9gzT2Zpd9CsSC7MJrJeYvu1P0CdbEORsFUQ+0SHw6ebeq+
         915KqHjJXVkV3Gu4Nj9zGthIQayOcG9junwn87yazygAcbE8pxQT8R5tmDj64psYFJ5Z
         vPA590XWBjvz//9Y8DDbVcCLXs8L80dcNp9IYbODrd98XUaQQBehFGOStwuXpjiMDaKn
         yjJJV0CGonTnj4y796Vjn+noInq0QXeP0yHtfOmgRjg49medaI02pHdhe/vwvSiHrh1o
         BLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTGSRMTw/sfEXsZ/qwAwfgXXVnsaK6Tm0ucwCX4y3SM=;
        b=K/YMtZBUWc9T8E8K5rWOpEpEubfkEmZGOyyvrnVerAz7kvprZfANjP/5uqD0PYQ6jE
         aDnqqNa06eUC+jDnzQuTpbRSbV26f8rUQBVExzlTP6ADIS2fNYEIQjEu0TO3Fk8UE3Ha
         Vbvpl3WNRF5S2iOWb2BjvyfmEXaW7uqL87QTFpnojBsiagjespcXYP+f/XOEqu7PDhUz
         oaGHcd2o9HNCUN05sxgO+6UTMkWARrarHpC22y2rzm8FiV709cU80VgyD3OfZL2P1CWe
         ddgKG1PXuEcnx+U8QsMJgfYFZiVrVo6A3ezSHgNrkYXU8giYvmys/JVmOvk0ZZ8655ST
         zqUw==
X-Gm-Message-State: AFqh2koDblAsR4rA6hEUtaALV3+jVEFJ4jsZxaR6v4Eyucgk7b5wPw5D
        H+09Rcbnc/45RgGYhV9Jjy7mYQ==
X-Google-Smtp-Source: AMrXdXtKrVDnAiGeZpaTzdXIfHEhGsUH0aO0iP0yYgcx1NH+OdAMauXio5ZLHTBbEztO2Qr8YMjpyQ==
X-Received: by 2002:a17:907:3e18:b0:84d:3403:f4f2 with SMTP id hp24-20020a1709073e1800b0084d3403f4f2mr9748584ejc.62.1674051734694;
        Wed, 18 Jan 2023 06:22:14 -0800 (PST)
Received: from ?IPV6:2003:f6:af03:d200:ef9b:6781:7d3:df26? (p200300f6af03d200ef9b678107d3df26.dip0.t-ipconnect.de. [2003:f6:af03:d200:ef9b:6781:7d3:df26])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0084c723a626csm14572754ejh.209.2023.01.18.06.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:22:14 -0800 (PST)
Message-ID: <f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net>
Date:   Wed, 18 Jan 2023 15:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Content-Language: en-US, de-DE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
 <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
 <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
 <221219.86bknz21qj.gmgdl@evledraar.gmail.com>
 <2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net>
 <221220.86bknxwy9t.gmgdl@evledraar.gmail.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <221220.86bknxwy9t.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.12.22 22:11, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 20 2022, Mathias Krause wrote:
> 
> [De-CC-ing pcre-dev@, since this part is all git-specific]
> 
>> Am 19.12.22 um 10:00 schrieb Ævar Arnfjörð Bjarmason:
>>>
>>> On Fri, Dec 16 2022, Carlo Arenas wrote:
>>>
>>> [CC-ing pcre-dev@ for this "future error API" discussion]
>>>
>>>> On Fri, Dec 16, 2022 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>>>
>>>>> Mathias Krause <minipli@grsecurity.net> writes:
>>>>>
>>>>>> ... However, from a user's point of view a fall back to
>>>>>> interpreter mode might still be desired in this case, as a failing
>>>>>> 'git grep' is simply not acceptable, IMHO.
>>>>>
>>>>> "git grep" that silently produces a wrong result (by falling back
>>>>> after a problem is detected) would not be acceptable, either.
>>>>
>>>> except that an error at this point only invalidates the use of JIT,
>>>> so calling pcre2_jit_match() is invalid but calling pcre2_match() is not.
>>>>
>>>> the later is setup to be used later by the code that is added,
>>>
>>> I think we could stumble ahead, but if this were to happen our
>>> assumptions about how the API works have been invalidated.
>>
>> Well, pcre2_jit_compile() might fail for internal reasons, e.g.
>> pcre2jit(3) states: "[...] If a pattern is too big, a call to
>> pcre2_jit_compile() returns PCRE2_ERROR_NOMEMORY."
>>
>> For example, the following fails for me:
>> $ git grep -P "$(perl -e 'print "(.)" x 4000')" -- grep.c
>> fatal: Couldn't JIT the PCRE2 pattern '(.)(.)(.)(.)…
>>
>> But explicitly disabling JIT makes it "work":
>> $ git grep -P "(*NO_JIT)$(perl -e 'print "(.)" x 4000')" -- grep.c
>> $
>>
>> It's a made up example and might even be intended behavior by git, but
>> it also proves a point Carlo already mentioned, a failing call to
>> pcre2_jit_compile() only invalidates the use of the JIT engine. We can
>> still use and fall back to the interpreter.
> 
> We should arguably do this, I hadn't bothered because I haven't been
> able to find anything except pathological patterns where it matters, and
> silently falling back in those cases will suck a lot more IMO.
> 
> If you are using such a pathological pattern it's almost always a better
> idea to adjust your crazy pattern.
> 
> So I think in the *general* case we really should just keep this, and
> *maybe* suggest the user try with (*NO_JIT) in the pattern.

Except for the case I'm trying to address, where we simply cannot detect
*why* the JIT is failing from the error code alone. It'll error out with
PCRE2_ERROR_NOMEMORY for the case where the JIT fails to allocate W|X
memory as well as for the case where the pattern is crazy.

> But silently falling back kind of sucks, but unfortunately pcre2 doesn't
> provide a way to say "failed because of SELinux" v.s. "failed because
> the pattern is crazy", except that we could try to compile a known-good
> pattern with the JIT, to disambiguate the two.

Exactly, so what about something like this:

If JIT is generally available, try to JIT the user supplied pattern:
1/ If it fails with PCRE2_ERROR_NOMEMORY, try to compile a know good
   pattern, e.g. ".":
   1a/ If this fails with PCRE2_ERROR_NOMEMORY as well, fall back to
       interpreter, as JIT is non-functional because of SELinux / PaX.
   1b/ If not, it's a "crazy" pattern, suggest '(*NO_JIT)'.
2/ If it succeeds or fails with a different error, continue as of now,
   i.e. use JIT on success or die() on error, optionally suggesting
   '(*NO_JIT)'.

That should handle the case you're concerned about and only fall back to
interpreter mode if JIT won't be functional anyway. Admitted, this would
also allow crazy patterns, but there's simply no way to detect these
under such constraints.

> Anyway, if this is your goal you should really lead with that, not with
> fixing a relatively obscure SELinux edge case...

It's just that I'm suffering from that "obscure SELinux edge case", just
not under SELinux but PaX MPROTECT. I only mentioned SELinux to state,
it's not only an issue for PaX but regular systems as well. So it's not
a hypothetical case I like to get handled, but my work environment to
get usable again.

>> It would be used anyway if PCRE2 was compiled without JIT support, so I
>> don't see any issues with falling back to interpreter mode if the JIT
>> compilation fails -- for whatever reason.
> 
> It's the "for whatever reason" that I take issue with. We'd be in an
> unknown state with the API behaving differently than we expect, and
> returning unknown codes. That's different than the *known* error codes
> (e.g. "no memory", oven though it's meaning is apparently overloaded to
> the point of near-uselessness).
> 
>>> The pcre2_jit_compile() doesn't promise to return a finite set of error
>>> codes, but:
>>>
>>> 	[...]0 for success, or a negative error code otherwise[...]
>>>
>>> But if new codes were added it's anyone's guess what state we'd be in,
>>> so I think the safe thing is to BUG() out if we get as far as
>>> pcre2_jit_compile() and don't get either PCRE2_ERROR_JIT_BADOPTION or
>>> PCRE2_ERROR_NOMEMORY.
>>
>> But why BUG()? JIT is an optimization that might fail for PCRE2 internal
>> reasons. Why should we make 'git grep' fail too in this case when we can
>> handle it just fine by attempting to use the interpreter?
>>
>> If the pattern is really bogus, the interpreter will complain as well
>> and we'll error out. But failing just because the JIT engine can't
>> handle the pattern? Doesn't sound right to me.
> 
> See above, we're failing because our assumptions about how to use the
> API have broken down at that point. We usually bug out in those cases.
> 
>>>>> Receiving BADOPTION could be a sign that there is something wrong in
>>>>> the input, not from the end-user but from the code, in which case
>>>>> stopping with BUG() may be a more appropriate?
>>>>
>>>> The way PCRE handles this kind of errors internally is to instruct pcre2_match()
>>>> to use the interpreter.
>>>>
>>>> While a BUG() might be a way to ensure the code is using the right set
>>>> of options
>>>> I would expect that the failure will be reported by pcre2_compile
>>>> instead, with the
>>>> only cases left, only being interna to PCRE (ex: JIT can't yet support
>>>> a feature the
>>>> interpreter has)
>>>
>>> I agree that it's possible in general that an external library might
>>> start returning a "benign" error code that we could recover from, so
>>> BUG(...) would be overdoing it.
>>
>> And I think that's the case here: JIT is an optimization that might not
>> be available under all circumstances, as, for example, under SELinux's
>> 'deny_execmem' setting. So we need to have a backup plan for such
>> systems anyway. Why not always try to use the interpreter if JIT
>> compilation fails?
> 
> See above, but maybe it's the least sucky thing (and definitely
> simpler). I'm mainly checking that we're doing that we want here, and
> that we're going into it with eyes open.
> 
> That we're now discussing a topic entirely different from SELinux on a
> thread where we're (according to the commit message) fixing pcre2 where
> the JIT is "unusable on such systems" is my main concern here. 

Yeah, I overlooked that angle initially, but it's a valid concern.
However, limiting the functional change of falling back to interpreter
mode on "JIT's broken anyway" systems only should address these and get
me a functional 'git grep' again.

>>> So not only would a BUG() biting us here require them to create a new
>>> code for the state of "we have the JIT, but can't use it here" (for some
>>> reason I can't imagine, as "PCRE2_ERROR_NOMEMORY" is already
>>> "overloaded" to mean that).
>>>
>>> It would also require them to invent a new "soft" failure mode for the
>>> JIT, i.e. not the facility added in a25b9085043, where we can use the
>>> JIT, but it's not on after all due to a "(*NO_JIT)" in the pattern
>>> itself.
>>
>> We should really treat PCRE2 JIT as an *optional* optimization that
>> might not be available for certain cases. For these we should, IMHO,
>> simply use the interpreter mode, instead of bugging users with a BUG() /
>> die().
> 
> To summarize some of the above, I think performance also matters, we
> have cases where:
> 
>  A. We could use the non-JIT
>  B. We could use the JIT, and it's a *lot* faster
>  C. We can't use the JIT at all
>  D. We can't use the JIT because we run into its limits
> 
> I think it's fair to die on "D" as in practice you only (I think!) run
> into it on pathological patterns, but yes, another option would be to
> fall back to "A".
> 
> But thinking you're doing "B" and not wanting to implicitly fall back to
> "A" is also a valid use-case.

Agreed. My above sketched handling should do that, as in not falling
back to interpreter mode when the JIT would be functional per se, but
just failed on this particular pattern.

> So I'm inclined to suggest that we should be less helpful with automatic
> fallbacks, and just suggest a "try it with '(*NO_JIT)'" advice() or
> something.

Well, that's a real pain from a user's (my) point of view. Trust me, I'm
suffering from this, otherwise I wouldn't have brought up the issue ;)

> But as noted above needing to always disable an apparently "available"
> JIT on some systems (SELinux) does throw a monkey wrench into that
> particular suggestion :(

Yep.

> So I'm not sure, I'm mainly trying to encourage you to think through the
> edge cases, and to summarize the full impact of the change in a re-roll.

Yeah, I agree. The implied fallback to the interpreter, even for the
more obscure cases should have been mentioned in the changelog, but I
overlooked / ignored that case initially.

My take from the discussion is to do a re-roll with something like this:

  if (p->pcre2_jit_on) {
      jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
      if (jitret == PCRE2_ERROR_NOMEMORY && !pcre2_jit_functional()) {
          /* JIT's non-functional because of SELinux / PaX */
          p->pcre2_jit_on = 0;
          return;
      } else if (jitret) {
          die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n"
              "Try prefixing the pattern with '(*NO_JIT)'\n",
              p->pattern, jitret);
      }
      ...
  }

...with pcre2_jit_functional() being something like this:

  static int pcre2_jit_functional(void)
  {
      pcre2_code *code;
      size_t off;
      int err;

      code = pcre2_compile((PCRE2_SPTR)".", 1, 0, &err, &off, NULL);
      if (!code)
          return 0;

      err = pcre2_jit_compile(code, PCRE2_JIT_COMPLETE);
      pcre2_code_free(code);

      return err == 0;
  }


Thanks,
Mathias
