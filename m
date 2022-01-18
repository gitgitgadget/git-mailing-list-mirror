Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C1C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbiARM1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:27:17 -0500
Received: from mout.web.de ([212.227.15.14]:46699 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232814AbiARM1R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642508826;
        bh=EzROlSgC6r+SwNRasa0ttt5IDtrhcvEJ9ZVcFkVFc7U=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=d8AdIWHyEHq5H5ZWFaP4lSu1UYFEgEohvaiSoN4aTLVy4OJLcwzi7y/bYwX7zyrFn
         MHbLeTd2yN3rKeDpaOUIedR9Td/vh5Py/qirs467yX7sV58kxxqM9jEtU/tx7evnXa
         UnPmnZ2pYF9noPwILUzccF5GWqvABJurRvz4d2XA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1mTYwb3Alv-00kzdf; Tue, 18
 Jan 2022 13:27:06 +0100
Message-ID: <e8396687-3bd4-4f52-1952-d99836c01d5d@web.de>
Date:   Tue, 18 Jan 2022 13:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 9/9] mergesort: use ranks stack
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <636647b1-f666-f1e2-4127-ee0869b61036@web.de>
 <220117.864k62qmt1.gmgdl@evledraar.gmail.com>
 <c605ecc2-29d6-9025-152e-1bcb831e7188@web.de>
 <cf5053b9-451c-7db6-acff-aae41bfabed3@web.de>
 <220118.86r195pb2b.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220118.86r195pb2b.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYC/N5ZGia7QAQxTqriUE1HxQFoVKcNmsDy6D+zaGxUziX+8EJr
 xL2gurZll6rsRyVNVj5sYbRmh0yML4KH3BMJ+7XJ+VLzwtLHjfMvqxC4WWaNXeUG3tEjO+S
 a/pmrwtB6DnaEu13od1gt6da8yGZytQgQhnq1L1rgPLCzf2heqz+lQbmFNjjKZbUUZ4yUOW
 BAP8e94RNymX2iRUIYKxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+yiUHG5v1As=:zNqE1DKhqD6OmMYXRP/beN
 VSqZuCrcnR3j4QpMAinv4L9N2ImP5KiI977VaOK1qKlntQJjuB8Vvwg1xJeDH7qVln57CYMAA
 QJoNmjGsNaV7mP9mAuGz45yZuRxjAmFrAbB0+REEOZjXdxYbbLWs6w/B+LPDvBWTMJzuESQi+
 OpVyEUjrJJew9xKm1KiL0wRMChi18bYvA6BIfsVLlUDf1SUmQebWwQg8PfBntn6qkIxxuvmYH
 bpgMGe83SSeN1S4ITmQ2/CwW1KJ2haKNe/M7rpbHr0QdQXgWXgpONFlEByar1IiNJQqi9MSm7
 FgJpoyKk96zmp/ezUZRdWc9v3N1vRNXWNSVyx5jS1cBm2sEoE4k+R9CBxfJn2qze6qrr89bq3
 reuS/FbGwTdTajQyM6wA/R2EYElcaU/BPTfS8jHpa6CPERUZmQK2MvJTxe1g2GIDSFUMJH3Hl
 j7Df8RpXfxP1LtMSm53XA7KGd81G5bhpA2Ul/psV1YuTJRvK6GgaciSRVPRF/PBYlS4Bi3p3P
 lj3STsyQfgyeV60Kvu0Z7ER81rrFhtzWT8aBaLloS/geSZZO1kTEW6Ka8sjks+J3Z0g5qYj1Z
 HahTPs7a6BL+q7sy+TG5VOqhO5Jj41Z/s7KWfphiMg84MAQQ7tbE37aeyjLj9z76OY40zfXNc
 DbrGqDgRa3DfQh+YKE8DzS/+/xmLCjYEuwKFFrmSLuT4ZIi+1Glj5lKitT4eShDCSp0/29TrE
 5HWljwe3lYqMf24v8gysqJvB48+fBuRkm3QTQz4vmHIpaCB8BWl/4GAU6j2tyn33upd35Z5L4
 9ZKK1J/nkZunlXpndqGeD/GASBmwoaLckhBcTAj0KSxhR0aa4XjaNnd53HPZy8YJ9BlLrGwMZ
 kYntJ7vgpwSlb9dqichj84m2AcB5WDOAVSmH0O1eJgrQ/lBvitlhf8VYE4WKeI3vk3zGvcmdV
 n9xbwLihYsSvbdzE/Alp49X8BvPap2qsFCb1rJf+u9mm9pVeWq6KJpbIOeWzNfjVAqbqofXmH
 zsN6FT6OE+KpWwgTJju/MuSH/BnuB/2QM4CxBtOkTjbzxmiaNa5/5QMyJvELzvZoIg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.22 um 11:40 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Jan 18 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 17.01.22 um 19:22 schrieb Ren=C3=A9 Scharfe:
>>> Am 17.01.22 um 18:43 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>>
>>>> On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:
>>>>
>>>>
>>>>> +/*
>>>>> + * Perform an iterative mergesort using an array of sublists.
>>>>> + *
>>>>> + * n is the number of items.
>>>>> + * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
>>>>> + * ranks[i] contains a sublist of length 2^i otherwise.
>>>>> + *
>>>>> + * The number of bits in a void pointer limits the number of object=
s
>>>>> + * that can be created, and thus the number of array elements neces=
sary
>>>>> + * to be able to sort any valid list.
>>>>> + *
>>>>> + * Adding an item to this array is like incrementing a binary numbe=
r;
>>>>> + * positional values for set bits correspond to sublist lengths.
>>>>> + */
>>>>>  void *llist_mergesort(void *list,
>>>>>  		      void *(*get_next_fn)(const void *),
>>>>>  		      void (*set_next_fn)(void *, void *),
>>>>>  		      int (*compare_fn)(const void *, const void *))
>>>>>  {
>>>>> -	unsigned long l;
>>>>> -
>>>>> -	if (!list)
>>>>> -		return NULL;
>>>>> -	for (l =3D 1; ; l *=3D 2) {
>>>>> -		void *curr;
>>>>> -		struct mergesort_sublist p, q;
>>>>> +	void *ranks[bitsizeof(void *)];
>>>>> +	size_t n =3D 0;
>>>>> +	int i;
>>>>>
>>>>> -		p.ptr =3D list;
>>>>> -		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>>>>> -		if (!q.ptr)
>>>>> -			break;
>>>>> -		p.len =3D q.len =3D l;
>>>>> +	while (list) {
>>>>> +		void *next =3D get_next_fn(list);
>>>>> +		if (next)
>>>>> +			set_next_fn(list, NULL);
>>>>> +		for (i =3D 0; n & (1 << i); i++)
>>>>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>>>>> +					   set_next_fn, compare_fn);
>>>>> +		n++;
>>>>> +		ranks[i] =3D list;
>>>>> +		list =3D next;
>>>>> +	}
>>>>
>>>> (Commenting on a commit integrated into v2.34.0)
>>>>
>>>> The aCC compiler on HP/UX notes:
>>>>
>>>>     "mergesort.c", line 67: warning #2549-D: variable "ranks" is used=
 before its value is set
>>>>                         list =3D llist_merge(ranks[i], list, get_next=
_fn,
>>>>
>>>> It's commenting on the ranks[i] within the for-loop-within-while-loop
>>>> above.
>>>
>>> That would be a bug.  I think none of the array elements are read befo=
re
>>> they are written -- but of course I'm biased.  Can that compiler show =
a
>>> sequence that would lead to reading uninitialized data?  Or anyone els=
e?
>>>
>>> Initializing the array would memset(3) 128 bytes on 32-bit systems and
>>> 512 bytes on 64-bit systems.  Doing that everywhere just to appease a
>>> confused compiler on a dying platform would be merciful, but still sad=
.
>>
>> Does the warning disappear if you add "ranks[0] =3D NULL;" before the w=
hile
>> loop?  And if it does, has adding "if (n & 1) ranks[0] =3D NULL;" inste=
ad
>> the same effect?
>
> Both of those make the warning go away.

The second one is optimized out by GCC and Clang because n =3D=3D 0 before
the while loop.  The data flow analysis in aCC that leads to the warning
must be taking some shortcuts if can be fooled by an inconsequential
expression.

> Anyway, if you think the pre-image in master now is fine let's leave it
> as it is. There's no point in just trying to appease aCC here.
>
> I just thought I'd send a quick mail about it because I was looking at
> its warning output, most of those warnings point to obviously harmless
> issues, but I thought this one *might* point to an actual logic error
> (but didn't look carefully enough myself), so I thought I'd send a quick
> note about it.

Sure, it would be a disaster if this loop somehow read uninitialized
data, and any hint needs towards that end must be taken seriously.  But
that warning from aCC seems to be a false positive.

Adding "if (n & 1) ranks[0] =3D NULL;" before the loop and a comment would
not change the code generated by  "normal" optimizing compilers, so we
could add this at the cost of slightly hurting readability, if necessary.

> If you think not it's probably best just to leave the code as-is.

That works for me as well. :)

Ren=C3=A9
