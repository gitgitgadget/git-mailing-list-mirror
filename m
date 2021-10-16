Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A47EC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E7260F41
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbhJPTqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 15:46:38 -0400
Received: from mout.web.de ([212.227.15.14]:36159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234499AbhJPTqh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 15:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634413454;
        bh=omPPXZS01UrCRTeVyE8fiJyqYa+RK7ODnJN3ZHHjRlY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=apZUYIQnP184aDsBWkndP6yZjJV/DCBFvea2vOP5MxB6jJHOfQc25Mtew3xMd0UmJ
         BvHFNWelZNm+nhD7A2YIF7ywwJhp5UpYZlffUF2TimGlc3Tam2AA5m/Fh+HLt+E/XA
         0XVyfayoQUpwWJ+AoPV9Gd9aF2Awoif6OriJbaXE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKuOP-1mIvAW3l2j-00LNXa; Sat, 16 Oct 2021 21:44:13 +0200
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <xmqq4k9i5a4n.fsf@gitster.g> <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
 <87zgr8dg8j.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fc7eb9fc-9521-5484-b05f-9c20086fd485@web.de>
Date:   Sat, 16 Oct 2021 21:44:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87zgr8dg8j.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m3XScA/PWft+FiIIM9oGXRtE2qiPnkEwGhvLPEiF8vWcPCRil/o
 8zkgR7uEOrEq9WVapWvKTNWcKoGhBs89mL9uqRd/jZhU3ids6XNBXN8e/2xJNbVm8DbUOmF
 xDqbn2cfSuzRShNx3WSwWGET75SKjkA9keK8Rp9BvkVQSfMi1YWOKbMEQekWSocpyhrhFJL
 9JSQcvZ9tTVBdM2O8qRzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXL4J307PUE=:mnmzFzrzmaPo5BPcn+NnlI
 uzPEte1w7JriaSZTUoOtaLKh+iNeVjsHn6CwCAU627efILAmSzul6Sg//G4p9xcW2vRiw36ld
 XE0fU5BoRaJsUjat8W6bcvi/MdY6kNgeXNrQT+81sPHnxOjpeB20VFPkpWMhcXLmi7IuoeSMm
 E8gk7W1ojiSODcXfs0l5iS2tLro7iPbJY5IYWQFB5bU7gk445uFZ3J+N/ydgWns6Dp3FFBaA3
 UDkqsK/ITQWY5e/Brf9jhkGnRA3OljmwpeRR2tkQGzUhWqA7KI3TIAgHEb1WiOyAj7GqJ/pdW
 a+JpFhgUv+as4GybZHeInniRKqhEg1DAyHwCfcp6la7G6qLw/ui5mSA5MtgJGd5bjWgBL99O7
 TssEpl9lB0iWwTGZHwEY/AW8drS52uIuECViNTQjW8UTvC5heXt5FrZFh8bqEIpeuRRWHfD1q
 66Ld112WAgz/wLgi+t/jlc3OqHsH9xp08jtMPUsdTTr45Mr9SH827O67xtggLBVhVm/u2IVNa
 lynL4sCpQGrtJWpH76lR6fEnotrltYXMZLJB95r4ackjPjWCmN0GyflMYN55htNW1rYh94UGd
 np4FfhIvbYxvSplNXFuVnQm0n9eKyIJwCpWd+Ua93twXEv5aJCDNCuZ8xOWbsAY74zr0/HxYv
 DpxMts5ffi7UaQjPs31muyUwYCLbsK/m+Eh/GQEJ7UhWEFDWejYzC+DUVFNvaOVFY4nzC6zbk
 Ego6O2JIQNWk9uGsLCK9awPdXTuuVuJDUo3+Bocrt5gi8VBonJw5B75PS0uucEIlUnvJFFwOF
 wa3fHpR1s9ke9I50hQGt79nWUn49ArU2qlbZBXQA8mGm77PXWv1uuSNjva717ld5RHwuCY7LF
 dem7t1EH2KAzbi2wi+yn+dJf5m9Q5I++501YFU8GAbhmdm/M/xMHD85sc+BXq6ILPpD1gsz1b
 KRo+cmu+kUw/Ep9ds2RQOCGkcboDHLj7SyE961XRYDPX9MmcoZTeZClr3+foB0mjp42zfColj
 mAhl9Eym5KwtkeLjmTw2IHoYmzTPNs8onfrOPAjbhMXWcbzOkualoDBUKs2bOXFEuQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.10.21 um 19:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Oct 16 2021, Ren=C3=A9 Scharfe wrote:
>
>> Am 15.10.21 um 22:03 schrieb Junio C Hamano:
>>> Hamza Mahfooz <someguy@effective-light.com> writes:
>>>
>>>> If we attempt to grep non-ascii log message text with an ascii patter=
n, we
>>>
>>> "with an ascii pattern, when Git is built with and told to use pcre2, =
we"
>>>
>>>> run into the following issue:
>>>>
>>>>     $ git log --color --author=3D'.var.*Bjar' -1 origin/master | grep=
 ^Author
>>>>     grep: (standard input): binary file matches
>>
>> I get no error message on macOS 11.6, but this result, with the underli=
ned
>> part in red:
>>
>>    Author: ??var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>             ^^^^^^^^^^^^^^^^^^
>>
>> So the pattern matches the second byte of a two-byte character, inserts=
 a
>> color code in the middle and thus produces invalid output in this case.
>
> Thanks for digging into these edge cases...
>
>>>>
>>>> So, to fix this teach the grep code to use PCRE2_UTF, as long as the =
log
>>>> output is encoded in UTF-8.
>>>
>>>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pat=
tern) &&
>>>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>>> +	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
>>>> +	    (!opt->ignore_locale && is_utf8_locale() &&
>>>> +	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
>>>> +					    (p->fixed || p->is_fixed))))
>>>
>>> That's a mouthful.  It is not obvious what new condition is being
>>> added.  I had to flip the order to see the only difference is, that
>>>
>>>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pat=
tern) &&
>>>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>>>> +	if ((!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pa=
ttern) &&
>>>> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed))) ||
>>>> +	    (!opt->ignore_locale && !has_non_ascii(p->pattern)))
>>>
>>> ... in addition to the case where the original condition holds, if
>>> we do not say "ignore locale" and the pattern is ascii-only, we
>>> apply these two option flags.  And that matches what the proposed
>>> log message explained as the condition the problem appears.
>>>
>>> So,... looks good, I guess.
>>>
>>> Thanks, will queue.
>>>
>>>
>>> Addendum.
>>>
>>> If we were reordering pieces in the condition, I wonder if there is
>>> a better way to reorganize it, though.  The original is already
>>> barely explainable with words, and with this new condition added, I
>>> am not sure if anybody can phrase the condition in simple words to
>>> others after staring it for a few minutes.  I can't.
>>>
>>> But straightening it out is best left as a future clean-up patch,
>>> separate from this series.
>>>
>>
>> It can be written as:
>>
>> 	literal =3D !opt->ignore_case && (p->fixed || p->is_fixed);
>> 	if (!opt->ignore_locale) {
>> 		if (!has_non_ascii(p->pattern) ||
>> 		    (is_utf8_locale() && !literal))
>> 			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>> 	}
>
> Whatever we go from here I'm very much for untangling that condition,
> but I guess it can be done as a follow-up too, I'll defer to Hamza
> there...
>
>> Literal patterns are those that don't use any wildcards or case-folding=
.
>> If the text is encoded in UTF-8 then we enable PCRE2_UTF either if the
>> pattern only consists of ASCII characters, or if the pattern is encoded
>> in UTF-8 and is not just a literal pattern.
>>
>> Hmm.  Why enable PCRE2_UTF for literal patterns that consist of only
>> ASCII chars?
>>
>> The old condition was (reformatted to better match the new one):
>>
>> 	if (!opt->ignore_locale) {
>> 		if (is_utf8_locale() && has_non_ascii(p->pattern) && !literal)
>> 			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>> 	}
>>
>> Intuitively I'd say the condition should be:
>>
>> 	if (!opt->ignore_locale && is_utf8_locale()) {
>> 		if (has_non_ascii(p->pattern) || !literal)
>> 			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>> 	}
>>
>> If both input and pattern are encoded in UTF-8, enable PCRE2_UTF if we
>> have to match non-ASCII characters or do more than just literal
>> matching.
>>
>> For literal patterns that consist only of ASCII characters we don't nee=
d
>> the cost and complication of PCRE2_UTF.
>>
>> Makes sense?
>
>     echo 'Ren=C3=A9 Scharfe' >f &&
>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?Ren. S=
' f; echo $?
>     1
>     $ git -P grep --no-index -P '^(?:You are (?:wrong|correct), )?R[e=C3=
=A9]n. S' f; echo $?
>     f:Ren=C3=A9 Scharfe
>     0
>
> So it's a choose-your-own adventure where you can pick if you're
> right. I.e. do you want the "." metacharacter to match your "=C3=A9" or =
not?

Yes, I do, and it's what Hamza's patch is fixing.

> These sorts of patterns demonstrate nicely that the relationship between=
 your
> pattern being ASCII and wanting or not wanting UTF-8 matching semantics
> isn't what you might imagine it to be.

Differences are:

o: opt->ignore_locale
h: has_non_ascii(p->pattern)
i: is_utf8_locale()
l: literal

o h i l master hamza rene
0 0 0 0      0     1    0
0 0 0 1      0     1    0
0 0 1 0      0     1    1   <=3D=3D your first example
0 0 1 1      0     1    0
0 1 1 1      0     0    1

Turning on PCRE2_UTF when is_utf8_locale() =3D=3D 0 seems wrong (first two
lines).

Turning on PCRE2_UTF for literal matching (fourth line) goes against
870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
2019-07-26).

Turning on PCRE2_UTF for literal matching of non-ASCII characters (fifth
line) also goes against that, so my intuition betrayed me.  When I
adjust it, I get:

	if (!opt->ignore_locale && is_utf8_locale() && !literal)
		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

That looks deceptively simple -- just drop has_non_ascii(p->pattern)
from the original condition.

Your second example is handle the same by all versions btw.:

o h i l master hamza rene
0 1 1 0      1     1    1

Ren=C3=A9
