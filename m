Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A8EEB56E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjIHW2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIHW2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 18:28:36 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E01FC6
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694212101; x=1694816901; i=l.s.r@web.de;
 bh=XDzOrrJKrdq1hu0XxDdTCGssNtaS2POPbN/xTYh8UU0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=kPbJe0j1wz21gFcsjQlzpefXBByk8qNYCct+EI0arbxxEkeG/a/1bHQOzr/qaRABJTVtD0j
 qAW+OvZ4HOKRgZ+4P30O5OBdd0q8PEOcG+gAd3DlwZrhU2D/sXnbaFnDTC1jXQqQ2dCJwPm1K
 LDED/YPvC7saV52b43vD+xGYOmjpSTOgD1kS6/I8yC7DQAU86kG1qPRLFrmuuTbYrES1/LiEO
 Bdly8/nffGKiZbjsDT8iZoj414FTuBT9eYfMuYbHueWKHP9yv61EHXtpbPPf6FydM0sUj26j4
 AbX9mMts6ot7xz/MaVOyVXbja06FpUZNn8A/wSrS1oB1FEatIWgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.74]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1q9ij62Bt3-00UpnG; Sat, 09
 Sep 2023 00:28:21 +0200
Message-ID: <cec47733-5b15-6ca7-adaf-7f3216ad178b@web.de>
Date:   Sat, 9 Sep 2023 00:28:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] grep: use OPT_INTEGER_F for --max-depth
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
 <20230905072122.GG199565@coredump.intra.peff.net>
 <724641d2-1cba-3768-6008-01e8a1cdca4e@web.de>
 <20230907204027.GA941945@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230907204027.GA941945@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OqkVatYTKIFo13znealTr+sXRnfHmw/NbCzPEegbxOMo6Lsa9+W
 wq93d8WrmjTXNra6SM032yGHcybThC2J+KNJGJ3pg6vI94bsywzXThAqqitY5KMoXDpo9jM
 2Pb7WbkJzApIoqPRkgl+hPvIURhaRGH56cIxSd8uehwIn/6xZWd3HJpSzIeKWY7NINGf3it
 ctGXcb1vV59/xxxmyTRAQ==
UI-OutboundReport: notjunk:1;M01:P0:yeu/FzmLyKU=;bri9u+uDEhxI65WifVB6Kqsi7el
 wpvASj7bDh3+MkYfEu8VUzIuSG5UM83OiJN62XbCYE3HiFeq3DmuaYSRW1yfomEZOd+jUSCqL
 NNgwNptfPl/yMUrdHKFV/i1AlN6CUYWhvmJq6/JOuOspH3sOi/x9cT+Z0+P5r222e4Cq19p5V
 S58lpLmnUBOif90O08WdQbZAe/47Or/H6LPJQYPinidnpOByf8kqG8lSnxuLNf77azkw3qI3V
 Y+X75dJ2RVMNyHmo7Htw7L85ST5DFw326caanYqDmuoS6xNukIBfFboixbYTPQWGDPblva5e6
 qFBED35wXvUv0kOO2VVQw3LVNaeFSWghSa6EHBzZ8kEB/2/Pvhqgaaw2LyBDJuBc2nJrQHBuE
 T9lsyk7bm5sy3clJuXgG/rsIElTFaqbecqihXo46CTZF3BuEhL64M/zUimmPyhfmiLnjoY9xl
 5j595LSR88Fujh8aQx26FhNEqEMmK9NYJ3AoW4XeS+BnfemVI3DS+W22Wcf0F/KvcRFDz3O5q
 zzsnrtR1YN290TlO7sc/QLEJXNI6vnJpdvYfFEiPLIU6TT2GrR8yfmoHDT01ctCcxHxrly8DF
 z1/3CB5PGRhU5vRXqy29MI+1H3RkABn6FmGHi0IhIeX+tPUyMtplY7TaaXXv4Io3WYQ3nDgBY
 khIBpCxt8u+W2rS4mVfTEt9YxTOsyC3PcOGl8DJ8P+WY6VUseXweTAYPGQwK5cYkFrDayqfxi
 Pi9IjR6oBiSaCYrAPHXgkTwbYxEy2Zue5/fa6ZHk0VC5IJ1DcIF4VKhep+QnQs/foNn6/vJqZ
 yQnKfCu7RN5E8AqQEt3BIz7pUI4Aar9ettOmOcXu1K8L++4j5R+L6jBnfJ6UjhtQXONzjgeJ9
 8cInJPN6KnDKXtUFFfvHVCXghVn6OwXTbyVYs/iigS7gAdR5RId+N6j5yE2Q/aN68kb6hovDP
 CrzRfQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.09.23 um 22:40 schrieb Jeff King:
> On Thu, Sep 07, 2023 at 10:20:53PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Am 05.09.23 um 09:21 schrieb Jeff King:
>>> On Sat, Sep 02, 2023 at 08:54:54PM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>> In general, I wonder how many of the results from:
>>>
>>>   git grep '{ OPTION'
>>>
>>> could be converted to use the macros and end up more readable. There a=
re
>>> a number of OPTARG ones, which I guess can't use macros. Looks like
>>> there are a handful of others (mostly for OPT_HIDDEN).
>>
>> Indeed, and I have a semantic patch for that, but mostly because the
>> macros allow injecting a type check.
>>
>> OPTARG would need a new macro to allow specifying the default value.  O=
r
>> is there a variadic macro trick that we could use?
>
> Hmm, I had just assumed OPTARG was a lost cause (or we would need an
> "OPTARG" variant of each macro; yuck).

Only for OPT_INTEGER and OPT_STRING AFAICS.

> I suspect variadic macros could be made to work, but you'd lose some
> compile-time safety. If I say:
>
>   OPT_BOOL('x', NULL, &v, NULL, "turn on x")
>
> now, the compiler will complain about the number of arguments. In a
> variadic world, it silently ignores the final one. I feel like I've made
> this kind of error before (e.g., when switching to/from _F variants, or
> between types).

OPT_BOOL has PARSE_OPT_NOARG.  Just saying.

It's true that a macro that accepts a variable number of arguments would
accept accidental extra arguments of the right type, but I don't see how
it would ignore excessive ones.

> You'd want some semantic check between what's in flags (i.e., is the
> OPTARG flag set), but I think that's beyond what the compiler itself can
> do (you could probably write a coccinelle rule for it, though).

Actually I'd want the macro to set that flag for me.

> I think it also squats on the variadic concept for the macro, so that no
> other features can use it. I.e., if you accidentally give _two_ extra
> arguments, I don't know that we can parse them out individually.

In case of an accident I'd just expect a compiler error.  A cryptic one,
probably, alas, but no silence.

I was thinking more about something like the solutions discussed at
https://stackoverflow.com/questions/47674663/variable-arguments-inside-a-m=
acro.
It allows selecting variants based on argument count.

That could look like this (untested except on https://godbolt.org/; the
EVALs are needed for MSVC for some reason):

#define OPT_INTEGER_FULL(s, l, v, h, f, d) { \
	.type =3D OPTION_INTEGER, \
	.short_name =3D (s), \
	.long_name =3D (l), \
	.value =3D (v), \
	.argh =3D N_("n"), \
	.help =3D (h), \
	.flags =3D (f), \
	.defval =3D (d), \
}
#define OPT_INTEGER_4(s, l, v, h) \
	OPT_INTEGER_FULL(s, l, v, h, 0, 0)
#define OPT_INTEGER_5(s, l, v, h, f) \
	OPT_INTEGER_FULL(s, l, v, h, f, 0)
#define OPT_INTEGER_6(s, l, v, h, f, d) \
	OPT_INTEGER_FULL(s, l, v, h, (f) | PARSE_OPT_OPTARG, d)
#define EVAL(x) x
#define SEVENTH(_1, _2, _3, _4, _5, _6, x, ...) x
#define OPT_INTEGER(...) \
	EVAL(EVAL(SEVENTH(__VA_ARGS__, OPT_INTEGER_6, OPT_INTEGER_5, OPT_INTEGER_=
4, 0))(__VA_ARGS__))

So OPT_INTEGER(s, l, v, h) would be the same as before.  Add an argument
and it becomes current OPT_INTEGER_F, add another one and it acts as
your _OPTARG_F variant.

> So yeah, I think you'd really want a separate macro. The combinations
> start to add up (or multiply up, if you prefer ;) ). They _could_ be
> generated mechanically, I think, as they can all be implemented in terms
> of a master macro that knows about all features:
>
>    #define OPT_BOOL_F(s, l, v, h, f) OPT_BOOL_ALL(s, l, v, h, f, 0)
>    #define OPT_BOOL(s, l, v, h, f) OPT_BOOL_F(s, l, v, h, 0)

The "f" arg needs to go...

>    #define OPT_BOOL_OPTARG_F(s, l, v, h, arg) OPT_BOOL_ALL(s, l, v, h, f=
 | PARSE_OPT_OPTARG, arg)

... here, possibly.

>    #define OPT_BOOL_OPTARG(s, l, v, h, arg) OPT_BOOL_OPTARG_F(s, l, v, h=
, 0, arg)
>
> But I'm not sure if cpp is up to that, or if I'd want to see what the
> resulting code looks like.

You mean having a macro define another macro?  I don't think that's
possible.

Ren=C3=A9
