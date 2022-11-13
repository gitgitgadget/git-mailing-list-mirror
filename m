Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72377C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 17:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiKMRbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKMRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 12:31:26 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2001117A
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668360667; bh=yYVoYaEyln30YaXQ/zDu5/pr36w0PH1ubMENiR7Jrzc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RRQUwjOz2IWtGoDOsFXavp6mr6KvW2Jvn5imy0IoN0tuA6u8zx7j/YIQPsS/44uMy
         rZFoNc2lm6vwmiUZbA+5wdN8e9wqMfqYoHAQqOg1phBdUl9s6enYzea9LLUSdHMyVF
         4C6X0L3Q8N0i3lnijnXd/8VfUUM1NRUsdqsa7IHf71eDFAa/fX+S7b2fiOX9P6uMtG
         A2s1vptb4GmQp36ilxpX2B7fn4uRjAa8LoxiJGv9bQQUNqzMtTTYwC8ES+4R7Yrl2m
         I1bHhBKnPbrDVXvZyvv4VX2WRGcBR7CzbDgxzkXD2aqWJr/YSr972TaTEJz7XDFiGg
         M03m+qXPQ5fnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1pGwOX1mzq-00nFaU; Sun, 13
 Nov 2022 18:31:07 +0100
Message-ID: <12542034-b5cc-bad0-5a60-2672bde35b78@web.de>
Date:   Sun, 13 Nov 2022 18:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
 <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
 <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
 <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
 <221106.86k048w2f4.gmgdl@evledraar.gmail.com>
 <36337a3f-6443-f272-09f0-7ddb3c20d7a4@web.de>
 <Y2/LF/qiZI99YuxM@coredump.intra.peff.net>
 <221112.8635aom6p5.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221112.8635aom6p5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2pK1lvQr9i1t330VuruBRzo89Hll3xooG8NkR+BvVrIPU5VTOG8
 X9kzWVGLWuTo4HqRX1Krbg6dXdR1t+AdxTK8594YAHXlr8xLlmcb/l0xOZ9Ay5/fQn/d5mv
 hho/Dbl0WKn6kyD5yFqigf/AZUYZ/7IoNuaQ9+czfKVxmetQOzUTMYrII/cEQk7LOYmKldL
 qcgPXlOuNbygg2A6ip0ew==
UI-OutboundReport: notjunk:1;M01:P0:mfaUZAPIwoE=;6m7JcqFoibBaw7hlGLIhndqNZAx
 1NJzMPObTPi+Pgn/hCle2iS6Qq5Q+6Y+6sXxatsrvuaP5PmO7MJCvoR/JDxk6+oS1qwwH4kFh
 CikRd2NuJ+lE8huIIm/0YGhhqCqYzZazZdDIC9PwERijLaQVj7LPld3RTljzlIvTsUTh2VeLF
 Jys9bLLt6nCzWewUW/wn47k8ae/fvCYRjOJloSkAwpf2/lrC8Dle7v7evvoc8p24DIfjAIYkK
 /rItLO6TNQB+kDMwROVA2AIJZcKNDEHBXcrsWBZJge3sd5+sesHOFI4WUrWfJv8XSvoxVF8Qy
 p7pJMd7CgibRsTzaF0jCuDPfn+qBkXwiaFDo6qnC4FB+kLmaNyq3IvqRcRmDbz9lltVsf19LP
 1AKiQ4U+A6S3Zi2zDD2SxhlGXCj3+XgNjgMXEO3wsrB+qqxcHHn6eL1F3hkdSmYDe/0zTGF5C
 JGOvLGG+KBZzFDc+FRZUdsjFDjdLziyKIf4opvj82lpWZyXT+gikDJGbHunyYClEto95Oq9Zg
 rp2RCwB3CMaW0Jd5ptO9OnwP/j9AoMLFWvuQfohoZbRDh22NA/7h49mfkgLXHFAFajeicR5kF
 rdO5JYQuGankcaTKcGTsTyc5LkplUpdOZANzh2F5wEWyyhmUeWPORur/4yj6PTTWwBaVhEkPu
 WqSbjgJHhtp2wWfnZqBS4XU+DUlJL96hYhL1k4fqzIjXhw1pymn78hlOLEBe/qOUuCW9KavOo
 6IdufwKreE1gUVkfroA957qy7f1Mg3WdbufqZmIzxIjWevJNqX+xa0oZ9rOYRN5uQzLKEeMuQ
 /4Qp14c1Z9dAf0wG48d5GZSSO6DzR5oFoJzyuEHyMyPnQo7hJ6kvX+6YXzUuH+CDw4gbtxmpw
 mRvdQuJRrjCKWF+pjkhZKCn1UkZYfhqVEBa62sa69PdtxEYIx1vxvyxuxtfjB7zRQv628ocnP
 vZ7eRPofuWpDqxUPr4+fbHmE008=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.22 um 17:55 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Nov 12 2022, Jeff King wrote:
>
>> On Sat, Nov 12, 2022 at 11:42:09AM +0100, Ren=C3=A9 Scharfe wrote:
>>
>>>> E.g. we have plenty of code that assumes ASCII, instead of catering t=
o
>>>> EBCDIC, and assuming NULL is (void *)0, not (void *)123456 or whateve=
r.
>>>
>>> NULL is defined as "0" or "(void *)0" by C99 6.3.2.3 Pointers paragrap=
h
>>> 3 and 7.17 Common definitions <stddef.h> paragraph 3.
>>
>> I think he is alluding to the fact that while the standard requires tha=
t
>> a "0" constant refers to a NULL pointer, the representation does not
>> have to be all-bits-zero. So:
>>
>>   char *foo =3D 0;
>>
>> is fine, but:
>>
>>   char *foo;
>>   memset(foo, 0, sizeof(&foo));
>
> Yes, to elaborate: the "null pointer constant" referred to in 6.3.2.3
> deliberately leaves room for the representation being unequal to the
> "all zero bits". And as you point out the former example is portable,
> but not the latter.
>
>> is not. And we absolutely do the latter in our code base anyway, becaus=
e
>> it's convenient and unlikely to be a problem on practical platforms. An=
d
>> I think it has always been our attitude in this community to let
>> engineering practicality trump strict adherence to the standard. But
>> "practicality" there should be measuring the tradeoff of how useful
>> something is versus how likely it is to bite us.

For me the usefulness so far is negative: The code is more complicated
than necessary.  Adding a context pointer to the callback function
signature here and keeping the extra code outside the callback function
in builtin/pack-objects.c is simpler.

> All I've been trying to get across in this sub-thread is that there's an
> interesting empirical question here: Are we in fact targeting an
> architecture where J.5.7 isn't implemented, or likely to have one sneak
> up on us?

How would you measure this?  Undefined behavior can manifest itself
differently e.g. based on compiler version and options, or in this
case pointer value and perhaps even function calling convention.  And
of course in the form of the famous nasal demons..

> I don't think so, and timing-wise deciding to be paranoid about this
> particular thing would leave that question unanswered, when all we have
> to do is wait a bit (some of the slower platforms tend to be a few
> releases behind).
>
> The argument for the change[1] (further articulated upthread) hasn't
> answered the "do we target such an arch?", but seems to just fall back
> to general standards paranoia.

I mentioned CHERI (Arm Morello) as a candidate, but can't tell you for
sure.

> Which isn't an invalid argument in itself. But doesn't really address
> why we'd be worried about *this* particular thing, but not e.g. those
> sort of memsets, assuming ASCII ordering for 'A'..'z' etc.

You can keep worrying about them if you like.  Replacing memset calls
with _INIT macros has been going on for while already.  Using isalpha()
instead of character range comparisons etc. is probably a good idea
anyway.

>> In the case under discussion, my gut feeling agrees with you, though.
>> I'm skeptical that equivalence of object and function pointers is all
>> that useful in practice. And your mention of CHERI seems like a
>> plausible way it could bite us.
>
> I think the post-image of [1] looks nicer when reviewed stand-alone, so
> I'm not against the change per-se, I actually like it.
>
> And I don't have a use-case for using that feature further, in a way
> that isn't easy to do differently.
>
> But e.g. now we're having a parallel discussion about using some 3rd
> party bitmap library. We might e.g. want to incorporate some 3rd party
> JIT or whatever in the future. If we run into this question again it
> would be nice to have it answered already.

Why would a bitmap library require function pointer casts?

A JIT library probably comes with a list of supported systems and
requires a fallback for anyone else.  I'd expect the system-specific
parts to be encapsulated in that library.

> And if we didn't have this J.5.7 reliance in that code already I don't
> think it would be worth the effort to introduce one as a test
> balloon. I'm only saying this in the context that we already have one.
>
> 1. https://lore.kernel.org/git/c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.=
de/

If it's not worth adding then it's probably not worth keeping.

Ren=C3=A9
