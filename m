Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9AC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364A560E52
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbhJPRiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 13:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244459AbhJPRi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 13:38:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410ACC061769
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 10:36:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 5so21329162edw.7
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2Kqzc2Wkqr0tkm56skfDFzvJzeQrlh/dhxJboBGE+TA=;
        b=NxUI6H1dCBbwzqWEapaGFD2tvV7DIdlvK32C/it99F3H/kHliuFgTBUrWdmPVZclQR
         4mYL7X4U9/bCh2y3cY2bRi8K+MNgw/a8VkEtRFzS+akSHr1t90GPuP7f7JqfFprSbp10
         hpOSyyzwOOWcSs2VgzyVxKf/vwgasqU77sFDAsHjDwAiNk+qtdRmRP0RyTa3uz7zkGd5
         kTn6iXBOcN+7CPcvyeypVaAbc1WUSp5KAVRNmGLpZQA2PoTGChdx3gY7fWlHL2V+z+zl
         w3buo4eO2MPt/hkqeqHcHyAuHUqe3uxTxWsQ4Ow4072//HBPdYbpdhU1iQKRPY9PtAEx
         ziYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2Kqzc2Wkqr0tkm56skfDFzvJzeQrlh/dhxJboBGE+TA=;
        b=LkPb6oUQpGmRUvZeSfm8cVx2yalgHejaveUT6XFe5EZm4rQSfZtG+dhwMizc+7ux4u
         qk23DAfNHenQUqSj/M/2UotFt6s3SAyvV5N/GNdU0Q5uq7HXT00cv1+RLXWfRwS3VqLc
         mOH90d26QOy2b75r84S0/JNRKFSozi5FtRzfpUORZHgAd4MBZD0neZGfiqtxIUnZFrJD
         a6+IEBVjWzhNStertFqrawHgrUiN1EuFc4AXEk+zU3FM2RDURbvx/+CQta0dskZTt0kW
         wctnSXcA9hsz2782uL/zHx2LXMVIcq1sa6ZU5/l+SofR14rZx97BZm9crf1ySlFeP6Yd
         +NKQ==
X-Gm-Message-State: AOAM530tx+6puT02IZTEukcmr2XjSV3YIZHsvVkwmcT3JvHucCRbiacj
        Up2ZUa5ctaD/zsbT4x3VBuk=
X-Google-Smtp-Source: ABdhPJxVH2R7pRwGXJfF1pMD1qrTGnXWSukF+GB5nW8yPqUwQs7RhgWXOC501hEw6+zDE7GSeoTeUA==
X-Received: by 2002:a05:6402:1547:: with SMTP id p7mr29124959edx.371.1634405773627;
        Sat, 16 Oct 2021 10:36:13 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g22sm6541501ejd.33.2021.10.16.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 10:36:13 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbnbQ-0007Yq-JT;
        Sat, 16 Oct 2021 19:36:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Date:   Sat, 16 Oct 2021 19:12:47 +0200
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <xmqq4k9i5a4n.fsf@gitster.g> <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
Message-ID: <87zgr8dg8j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 16 2021, Ren=C3=A9 Scharfe wrote:

> Am 15.10.21 um 22:03 schrieb Junio C Hamano:
>> Hamza Mahfooz <someguy@effective-light.com> writes:
>>
>>> If we attempt to grep non-ascii log message text with an ascii pattern,=
 we
>>
>> "with an ascii pattern, when Git is built with and told to use pcre2, we"
>>
>>> run into the following issue:
>>>
>>>     $ git log --color --author=3D'.var.*Bjar' -1 origin/master | grep ^=
Author
>>>     grep: (standard input): binary file matches
>
> I get no error message on macOS 11.6, but this result, with the underlined
> part in red:
>
>    Author: ??var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>             ^^^^^^^^^^^^^^^^^^
>
> So the pattern matches the second byte of a two-byte character, inserts a
> color code in the middle and thus produces invalid output in this case.

Thanks for digging into these edge cases...

>>>
>>> So, to fix this teach the grep code to use PCRE2_UTF, as long as the log
>>> output is encoded in UTF-8.
>>
>>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>> +	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
>>> +	    (!opt->ignore_locale && is_utf8_locale() &&
>>> +	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
>>> +					    (p->fixed || p->is_fixed))))
>>
>> That's a mouthful.  It is not obvious what new condition is being
>> added.  I had to flip the order to see the only difference is, that
>>
>>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>> +	if ((!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patt=
ern) &&
>>> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed))) ||
>>> +	    (!opt->ignore_locale && !has_non_ascii(p->pattern)))
>>
>> ... in addition to the case where the original condition holds, if
>> we do not say "ignore locale" and the pattern is ascii-only, we
>> apply these two option flags.  And that matches what the proposed
>> log message explained as the condition the problem appears.
>>
>> So,... looks good, I guess.
>>
>> Thanks, will queue.
>>
>>
>> Addendum.
>>
>> If we were reordering pieces in the condition, I wonder if there is
>> a better way to reorganize it, though.  The original is already
>> barely explainable with words, and with this new condition added, I
>> am not sure if anybody can phrase the condition in simple words to
>> others after staring it for a few minutes.  I can't.
>>
>> But straightening it out is best left as a future clean-up patch,
>> separate from this series.
>>
>
> It can be written as:
>
> 	literal =3D !opt->ignore_case && (p->fixed || p->is_fixed);
> 	if (!opt->ignore_locale) {
> 		if (!has_non_ascii(p->pattern) ||
> 		    (is_utf8_locale() && !literal))
> 			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> 	}

Whatever we go from here I'm very much for untangling that condition,
but I guess it can be done as a follow-up too, I'll defer to Hamza
there...

> Literal patterns are those that don't use any wildcards or case-folding.
> If the text is encoded in UTF-8 then we enable PCRE2_UTF either if the
> pattern only consists of ASCII characters, or if the pattern is encoded
> in UTF-8 and is not just a literal pattern.
>
> Hmm.  Why enable PCRE2_UTF for literal patterns that consist of only
> ASCII chars?
>
> The old condition was (reformatted to better match the new one):
>
> 	if (!opt->ignore_locale) {
> 		if (is_utf8_locale() && has_non_ascii(p->pattern) && !literal)
> 			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> 	}
>
> Intuitively I'd say the condition should be:
>
> 	if (!opt->ignore_locale && is_utf8_locale()) {
> 		if (has_non_ascii(p->pattern) || !literal)
> 			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> 	}
>
> If both input and pattern are encoded in UTF-8, enable PCRE2_UTF if we
> have to match non-ASCII characters or do more than just literal
> matching.
>
> For literal patterns that consist only of ASCII characters we don't need
> the cost and complication of PCRE2_UTF.
>
> Makes sense?

    echo 'Ren=C3=A9 Scharfe' >f &&
    $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?Ren. S' f=
; echo $?
    1
    $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?R[e=C3=A9=
]n. S' f; echo $?
    f:Ren=C3=A9 Scharfe
    0

So it's a choose-your-own adventure where you can pick if you're
right. I.e. do you want the "." metacharacter to match your "=C3=A9" or not?

These sorts of patterns demonstrate nicely that the relationship between yo=
ur
pattern being ASCII and wanting or not wanting UTF-8 matching semantics
isn't what you might imagine it to be.

If you look at:

    git log --reverse -p -Gis_utf8_locale -- grep.c

And my earlier replies in this thread-at-large (not digging up a
reference now, sorry), you'll see that the current behavior in grep.c is
really a compromise based on some intersection of user patterns, us
potentially grepping arbitrary binary data and/or "valid" encodings, and
what PCRE does and doesn't puke on.

It's not "right" by any sense, but we sort of limp along with it, mostly
because unlike say Perl's regex engine which really is used for serious
production work where Unicode-correctness matters I don't think anyone
is using "git grep" for anything like that, it's mostly for people's
ad-hoc greps.

Right now I can't remember if the only reason we can't "fix this" is
because we'd be too aggressive with the PCRE version dependency, see
95ca1f987ed (grep/pcre2: better support invalid UTF-8 haystacks,
2021-01-24).






