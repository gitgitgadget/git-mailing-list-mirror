Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A516C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 05:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiARFHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 00:07:22 -0500
Received: from mout.web.de ([212.227.15.4]:52951 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbiARFHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 00:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642482436;
        bh=4DYxj3ugc9+2St3X5jKgmUs3pf01UrBKB1nHU8QV1HE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=g6ncDFH0Nj5gfvpYYGm6CjtIB4HhnWJ3i5X28pgDzEO1g4pqwEIS0I8AxxFzd2JtA
         5DPM8kybhUWlr4bjtc2xDMZFdQKw4UMK/Ik+j/zHyEX5dF8Y3ptZguU2MvwYnSpEKz
         m99GCcccQBPou9LZFAK6JGwqQtlzyZ1i0EqiyS5A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqTK-1mjnbu2zhW-00UYca; Tue, 18
 Jan 2022 06:07:16 +0100
Message-ID: <cf5053b9-451c-7db6-acff-aae41bfabed3@web.de>
Date:   Tue, 18 Jan 2022 06:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 9/9] mergesort: use ranks stack
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <636647b1-f666-f1e2-4127-ee0869b61036@web.de>
 <220117.864k62qmt1.gmgdl@evledraar.gmail.com>
 <c605ecc2-29d6-9025-152e-1bcb831e7188@web.de>
In-Reply-To: <c605ecc2-29d6-9025-152e-1bcb831e7188@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+E3iV1J1nwsUYR53yc5vjyW5YvXGiThybvAIzwxHxcZ1rz/QNk
 qJOehxP/i2xS3CEk+VkzHYDuf1ExVhd0Nbn8pfcyL4cQLbETY2Lq+q4P2D38jOX3jbvvvZa
 I2eM9C+ZSIvpRTsekFzepW3E1uQvl/NZmPbKU1F/3LaHaDHaNPB0briWLMMpb0reMduMfrU
 dViV973q9h5lGymp6p+GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1VpDIntDpro=:YaCkHJ/L75vpRT09dvP0UY
 PV7G/dM/TEHJgxHGADhwsxIdKsqHGxaxx+mxQ0Wa+3cURHPu/XahbYz4HlvavIu98aSeib/Lp
 Ddb7p21JeAZ0G6XuCrQEVoFfCdMuTotv15mctnvfK9E11dtoWnJU3u0LvBbyQUvBwR7+3FJG5
 QKbpbkHbHET5JMFzwuwjj3snZdAGu/J0n+/J6cqXZUyqXfrdMax3Zfq4CaWKXSbnJdu83z0cb
 SO5Am4zPqH6hYwayF3NcL1NP2zXkM0w4ZuTMoy4L58icInXOkU9VRWdOFFhmNUKt7Sza+XyU0
 CBZW2jmW+iHDaniYgw6dVEdWGbro4Va2hIUHQpkmCZGnm6tMmIkLDXnGl2HF2kL1PrB7H39zJ
 cRarLkUz4qqc6ohylB4DIzhAeLLlKiDJZBCN9YulQ5rNDRqLCqj50ScpTNecj2oDmJlPwUctx
 2eqEJWgou4mPeCLBiIuXiejrbeT2UhkWyePiFYN2tnjMi9YcSwnte7s/UcyshgAOnvfLIDveu
 RictWgcwpTiFmzYvjnk2/eUxKB0xfhp3W+wsKKYvjTEONQMjCw2MdywWwHd0OLM07ZoKBHJvM
 buKDjFATuyC2bEDnQeUkBAXt8RfNFRL+XshPQav2J8vBGx06+ujK+OMdI0vSmqRV/WTLIW06G
 FsxN7MLCW3snOt5eb5dKsetr+LgX8K3OJWU39QH6qHnl4aFkLCjXrQL+ZDip83yO2NjDvXi3g
 6MmYvyjSx0vj4kz8avhITavhaXWcjsMkw0iw5uyGUxC8dP2bbjzkOh9Hhh5ueyR9gUI704FEC
 oZI7PSnVGB6/nxG51xlPx471OAMBz29ReJmtgtI4LUET1gUWah7xr7QNZgpAP03yp/oK8g7/Q
 4EP+EW98eGFls1h1x8LScZKC0yT2SrdE1s8gKXacggBN7tNaWIbeMJ8ijB7H94htDyPjDhrOC
 pTd66NLsLHMOMCNvlAHS05xPghD5A6whk25gX5iZiyxi+p6nhOtIV6WhMqjqklmafp7resAh4
 6UOdJklLNMymt0bLQOM2LaBzvIu4NMeqSSSB3QoLK6YWvX3KRVQHIY7/rwu0faUQy9L4FjX4X
 VCPpgXl7Yx3TFY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 17.01.22 um 19:22 schrieb Ren=C3=A9 Scharfe:
> Am 17.01.22 um 18:43 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:
>>
>>
>>> +/*
>>> + * Perform an iterative mergesort using an array of sublists.
>>> + *
>>> + * n is the number of items.
>>> + * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
>>> + * ranks[i] contains a sublist of length 2^i otherwise.
>>> + *
>>> + * The number of bits in a void pointer limits the number of objects
>>> + * that can be created, and thus the number of array elements necessa=
ry
>>> + * to be able to sort any valid list.
>>> + *
>>> + * Adding an item to this array is like incrementing a binary number;
>>> + * positional values for set bits correspond to sublist lengths.
>>> + */
>>>  void *llist_mergesort(void *list,
>>>  		      void *(*get_next_fn)(const void *),
>>>  		      void (*set_next_fn)(void *, void *),
>>>  		      int (*compare_fn)(const void *, const void *))
>>>  {
>>> -	unsigned long l;
>>> -
>>> -	if (!list)
>>> -		return NULL;
>>> -	for (l =3D 1; ; l *=3D 2) {
>>> -		void *curr;
>>> -		struct mergesort_sublist p, q;
>>> +	void *ranks[bitsizeof(void *)];
>>> +	size_t n =3D 0;
>>> +	int i;
>>>
>>> -		p.ptr =3D list;
>>> -		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>>> -		if (!q.ptr)
>>> -			break;
>>> -		p.len =3D q.len =3D l;
>>> +	while (list) {
>>> +		void *next =3D get_next_fn(list);
>>> +		if (next)
>>> +			set_next_fn(list, NULL);
>>> +		for (i =3D 0; n & (1 << i); i++)
>>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>>> +					   set_next_fn, compare_fn);
>>> +		n++;
>>> +		ranks[i] =3D list;
>>> +		list =3D next;
>>> +	}
>>
>> (Commenting on a commit integrated into v2.34.0)
>>
>> The aCC compiler on HP/UX notes:
>>
>>     "mergesort.c", line 67: warning #2549-D: variable "ranks" is used b=
efore its value is set
>>                         list =3D llist_merge(ranks[i], list, get_next_f=
n,
>>
>> It's commenting on the ranks[i] within the for-loop-within-while-loop
>> above.
>
> That would be a bug.  I think none of the array elements are read before
> they are written -- but of course I'm biased.  Can that compiler show a
> sequence that would lead to reading uninitialized data?  Or anyone else?
>
> Initializing the array would memset(3) 128 bytes on 32-bit systems and
> 512 bytes on 64-bit systems.  Doing that everywhere just to appease a
> confused compiler on a dying platform would be merciful, but still sad.

Does the warning disappear if you add "ranks[0] =3D NULL;" before the whil=
e
loop?  And if it does, has adding "if (n & 1) ranks[0] =3D NULL;" instead
the same effect?

>
>>
>>>
>>> -		if (compare_fn(p.ptr, q.ptr) > 0)
>>> -			list =3D curr =3D pop_item(&q, get_next_fn);
>>> +	for (i =3D 0; n; i++, n >>=3D 1) {
>>> +		if (!(n & 1))
>>> +			continue;
>>> +		if (list)
>>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>>> +					   set_next_fn, compare_fn);
>>>  		else
>>> -			list =3D curr =3D pop_item(&p, get_next_fn);
>>> -
>>> -		while (p.ptr) {
>>> -			while (p.len || q.len) {
>>> -				void *prev =3D curr;
>>> -
>>> -				if (!p.len)
>>> -					curr =3D pop_item(&q, get_next_fn);
>>> -				else if (!q.len)
>>> -					curr =3D pop_item(&p, get_next_fn);
>>> -				else if (compare_fn(p.ptr, q.ptr) > 0)
>>> -					curr =3D pop_item(&q, get_next_fn);
>>> -				else
>>> -					curr =3D pop_item(&p, get_next_fn);
>>> -				set_next_fn(prev, curr);
>>> -			}
>>> -			p.ptr =3D q.ptr;
>>> -			p.len =3D l;
>>> -			q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>>> -			q.len =3D q.ptr ? l : 0;
>>> -
>>> -		}
>>> -		set_next_fn(curr, NULL);
>>> +			list =3D ranks[i];
>>>  	}
>>>  	return list;
>>>  }
>>
