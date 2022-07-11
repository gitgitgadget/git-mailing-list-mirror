Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD87C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 20:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiGKUHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGKUHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 16:07:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51E27B12
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:07:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so10630901ejj.12
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oXmxP5Yix6RuYRDhPtrh+00WkoiENdz90hNjhWr5I1Y=;
        b=Ri3yPhdHN03kSqBaaj9nopLiGTia2P5j9VNw1T5PaXXAaQokaWxkkIWHDXqxrfYWMP
         SiH44T8bGG/iF/wZqKe5PxdhBbR62rGfEmpm1dTBzMJ80G7rR2bLMBxIsxU1Cin/GoL9
         TgcTEWHJ/p8GDzqII6tVEqs1Hxa7341GzvCVDEtv5MLrbiQ30XERB7g5O/FnspNer88O
         yPeZRJOhkJlBDhBxIJZNJYotn6MJK48TVKoBQQMuiTnGO+qpOpurICCXfaVZLZ+KBbaV
         om2i5hlDYH/gbhOT5fF7H+MDE+VwXXxPPs5iejaK1EyZ/hdlFReLdbGqUd10dpRRkBBv
         46hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oXmxP5Yix6RuYRDhPtrh+00WkoiENdz90hNjhWr5I1Y=;
        b=3U1O8EqN7X3Ek6IzXCSyD/I6ugqjiAKfzA1I1ATqQ1+Fl8PMGYrsZmp6u9gA3yQuQ0
         B8kaUR6TTGgrxie7MfCtswuEkuNSULNZWqPYo8Hgpl7fgA/fwlBNIWuILT7f4F14i8nm
         BFOwnrsZRM5ls1OPBUKBp0b2SsNl7982RUU0Pk22kq8bElUZguMiEf0MW0eSW6lS0RKU
         7noj0vzUrVHr4FGeWC4IEqgZ/2pjackwVWuVN0p7/Ac5j/is3GwFSKWDmokemSgHxtYc
         6pNpPcUoND2Z2gH6UWAigqYWhBJC7rg9RqnbVOCypbXy9PKIJSfEId8QRA5OXEH50PSx
         GuVA==
X-Gm-Message-State: AJIora+YAwVS4xPHxKilk5D0q+wcq7AowpX1wFvFm5FBTL25qX0nnLVA
        /fvDMOFZNCTPS+x5+ary7+Op1UzQadujJw==
X-Google-Smtp-Source: AGRyM1tfPDnx5+o7gYjFrHROMlhyozI0gsG17I9r1MKtxuRnBrhelxt4Nsiwli3kRdmhYZa+pQvxaQ==
X-Received: by 2002:a17:906:5d0d:b0:726:be8f:becc with SMTP id g13-20020a1709065d0d00b00726be8fbeccmr20185386ejt.323.1657570023559;
        Mon, 11 Jul 2022 13:07:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w21-20020a50fa95000000b0043a8f40a038sm4837456edr.93.2022.07.11.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:07:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAzgL-0015Gc-9h;
        Mon, 11 Jul 2022 22:07:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] cocci: avoid normalization rules for memcpy
Date:   Mon, 11 Jul 2022 22:05:25 +0200
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
 <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
 <95432eb4-e66a-5c04-9267-f71391fbe277@web.de> <xmqqmtdhsf1z.fsf@gitster.g>
 <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
 <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
 <e29e424f-c214-a912-fba8-107c5e402b8a@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e29e424f-c214-a912-fba8-107c5e402b8a@web.de>
Message-ID: <220711.86y1wz5s7u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Ren=C3=A9 Scharfe wrote:

> Am 10.07.22 um 16:45 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sun, Jul 10 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Some of the rules for using COPY_ARRAY instead of memcpy with sizeof are
>>> intended to reduce the number of sizeof variants to deal with.  They can
>>> have unintended side effects if only they match, but not the one for the
>>> COPY_ARRAY conversion at the end.
>>
>> Since ab/cocci-unused is marked for "next" it would be really nice to
>> have this based on top so we can add tests for these transformations
>> (the topic adds a way to do that).
>
> Testing semantic patches sounds like a good idea.  We can add tests later,
> once that feature landed.

Okey, I might look at this then...

>>
>> But if you don't feel like  doing that this is fine too.
>>
>>> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.=
cocci
>>> index 9a4f00cb1b..aa75937950 100644
>>> --- a/contrib/coccinelle/array.cocci
>>> +++ b/contrib/coccinelle/array.cocci
>>> @@ -1,60 +1,58 @@
>>> -@@
>>> -expression dst, src, n, E;
>>> -@@
>>> -  memcpy(dst, src, n * sizeof(
>>> -- E[...]
>>> -+ *(E)
>>> -  ))
>>> -
>>> -@@
>>> -type T;
>>> -T *ptr;
>>> -T[] arr;
>>> -expression E, n;
>>> -@@
>>> -(
>>> -  memcpy(ptr, E,
>>> -- n * sizeof(*(ptr))
>>> -+ n * sizeof(T)
>>> -  )
>>> -|
>>> -  memcpy(arr, E,
>>> -- n * sizeof(*(arr))
>>> -+ n * sizeof(T)
>>> -  )
>>> -|
>>> -  memcpy(E, ptr,
>>> -- n * sizeof(*(ptr))
>>> -+ n * sizeof(T)
>>> -  )
>>> -|
>>> -  memcpy(E, arr,
>>> -- n * sizeof(*(arr))
>>> -+ n * sizeof(T)
>>> -  )
>>> -)
>>> -
>>>  @@
>>>  type T;
>>>  T *dst_ptr;
>>>  T *src_ptr;
>>> -T[] dst_arr;
>>> -T[] src_arr;
>>>  expression n;
>>>  @@
>>> -(
>>> -- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
>>> +- memcpy(dst_ptr, src_ptr, (n) * \( sizeof(T)
>>> +-                                \| sizeof(*(dst_ptr))
>>> +-                                \| sizeof(*(src_ptr))
>>> +-                                \| sizeof(dst_ptr[...])
>>> +-                                \| sizeof(src_ptr[...])
>>> +-                                \) )
>>>  + COPY_ARRAY(dst_ptr, src_ptr, n)
>>> -|
>>> -- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
>>> +
>>> +@@
>>> +type T;
>>> +T *dst_ptr;
>>> +T[] src_arr;
>>> +expression n;
>>> +@@
>>> +- memcpy(dst_ptr, src_arr, (n) * \( sizeof(T)
>>> +-                                \| sizeof(*(dst_ptr))
>>> +-                                \| sizeof(*(src_arr))
>>> +-                                \| sizeof(dst_ptr[...])
>>> +-                                \| sizeof(src_arr[...])
>>> +-                                \) )
>>>  + COPY_ARRAY(dst_ptr, src_arr, n)
>>> -|
>>> -- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
>>> +
>>> +@@
>>> +type T;
>>> +T[] dst_arr;
>>> +T *src_ptr;
>>> +expression n;
>>> +@@
>>> +- memcpy(dst_arr, src_ptr, (n) * \( sizeof(T)
>>> +-                                \| sizeof(*(dst_arr))
>>> +-                                \| sizeof(*(src_ptr))
>>> +-                                \| sizeof(dst_arr[...])
>>> +-                                \| sizeof(src_ptr[...])
>>> +-                                \) )
>>>  + COPY_ARRAY(dst_arr, src_ptr, n)
>>> -|
>>> -- memcpy(dst_arr, src_arr, (n) * sizeof(T))
>>> +
>>> +@@
>>> +type T;
>>> +T[] dst_arr;
>>> +T[] src_arr;
>>> +expression n;
>>> +@@
>>> +- memcpy(dst_arr, src_arr, (n) * \( sizeof(T)
>>> +-                                \| sizeof(*(dst_arr))
>>> +-                                \| sizeof(*(src_arr))
>>> +-                                \| sizeof(dst_arr[...])
>>> +-                                \| sizeof(src_arr[...])
>>> +-                                \) )
>>>  + COPY_ARRAY(dst_arr, src_arr, n)
>>> -)
>>>
>>>  @@
>>>  type T;
>>
>> Hrm, this seems like a lot of repetition, it's here in the rules you're
>> editing already, but these repeated "sizeof" make it a lot more verbose.
>>
>> Isn't there a way to avoid this by simply wrapping this across lines, I
>> didn't test, but I think you can do this sort of thing in the cocci
>> grammar:
>>
>> - memcpy(
>> - COPY_ARRAY(
>>   (
>>   dst_arr
>>   |
>>   dst_ptr
>>   )
>>   ,
>>   (
>>   src_arr
>>   |
>>   src_ptr
>>   )
>>   ,
>>   (n) *
>> -  [your big sizeof alternate here]
>>   )
>
> Hmm, that would match many more combinations, e.g. this one:
>
> void f(int *a, int *b, long n, int c[1]) {
> 	memcpy(a, b, n * sizeof(*c));
> }
>
> The elements of a, b and c have the same type, so replacing c with a
> (which a conversion to COPY_ARRAY would do) would produce the same
> object code.  I can't come up with a plausible scenario like above and
> where a type change of c down the line would cause problems, but I
> also can't convince myself that no such thing can exist.  Tricky.
>
> And I can't get it to format the whitespace around the third argument
> of COPY_ARRAY nicely in all cases.
>
> And it takes 37% longer on my machine.
>
> But it sure is more compact. :)
>
> @@
> type T;
> T *dst_ptr;
> T *src_ptr;
> T[] dst_arr;
> T[] src_arr;
> expression n;
> @@
> - memcpy
> + COPY_ARRAY
>   (
>   \( dst_ptr \| dst_arr \) ,
>   \( src_ptr \| src_arr \) ,
> - (n) *  \( sizeof(T)
> -        \| sizeof(*(dst_ptr))
> -        \| sizeof(*(dst_arr))
> -        \| sizeof(*(src_ptr))
> -        \| sizeof(*(src_arr))
> -        \| sizeof(dst_ptr[...])
> -        \| sizeof(dst_arr[...])
> -        \| sizeof(src_ptr[...])
> -        \| sizeof(src_arr[...])
> -        \)
> + n
>   )

..once those land, because cocci debug output is a lot more useful with
target test data :)
