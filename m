Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E726EC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 10:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiARK4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 05:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiARK4A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 05:56:00 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0084C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 02:55:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q25so77625306edb.2
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kyV69AuRSDUPlSTkyn4IBfoQ8i9b/sRkrNIFWOElD/w=;
        b=JB94xNXx9UwutiN3x+jlXyK+J/TheK+4bLpLwfysYvEs8QwmpGnZDs4WvbbJBtnBbm
         t2eKJhgtFtP3xVCQrnCCaVJrhrGCxxQQUXvPxu8P3rCvds6HppBX460OqZ/d1zmslhIV
         YUVi7nRamZHcJl+bWTME3aP0oBNoAXOGwB/E8Z2RANFKT+3euaalWTuffD8HxS/X28om
         Gq7zVHZW6asP9HWoUZsi229/AHGpJgllpvq2qudgSx4dHoAbTKelcjLyfB1JR6DrkLsl
         M+/F8oprWZdZp4ZXFL7G77YYYsVe21Ip9e96Mw6wgAUvEeW1/H7SHnnsLi0vN7PMdnOA
         rERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kyV69AuRSDUPlSTkyn4IBfoQ8i9b/sRkrNIFWOElD/w=;
        b=b+ZDfjVoJ/gypc9Ufk8iDeUzXrLae7QUtOgVTIVwVApWnI4tnyAiUDrRAEie3ZhSeK
         7T/V/5A35QbBkgI5NlIW3K4euYXhwXDqqb7+o9nTrjOHGfusrg/iBfURUh/YuA71oUqb
         aInezMeJWjDs499BNDh0NQaWD9+YAx9/HqPQkkZRTMtV+L1Fl87NkiV8MJxa9OI341Kd
         Ifn1e8IGTVmxzvzLNqe9twuWkZVnAyl/pU1qfCS4diFA7UrrS6FglILB27o2ZQTlHhY7
         Hmhhzu2AqWG/oYDQNRwF5k7ORZ86bBefR0ouFR1SsQbVzXDwIdmWjwNESI4nu52bRkI9
         pJCg==
X-Gm-Message-State: AOAM5333CwYfHw82n9SV097B7SuM6IexBDGtd849XcLbAqrs9bW7wkJ0
        KVs2cWxCDICWoRjg0tUkPxZSzVl1IxYqfQ==
X-Google-Smtp-Source: ABdhPJxtfcOds0bnYvQ/3/Io9bBE6n3LD4I5fhLxe2R0kElX0YIh12GlFv1XOJRd0v+AJTC5yOMWlg==
X-Received: by 2002:a17:906:15d5:: with SMTP id l21mr20492235ejd.287.1642503358072;
        Tue, 18 Jan 2022 02:55:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k12sm5227139ejk.188.2022.01.18.02.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 02:55:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9m9c-001Wq8-UE;
        Tue, 18 Jan 2022 11:55:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] mergesort: use ranks stack
Date:   Tue, 18 Jan 2022 11:40:43 +0100
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <636647b1-f666-f1e2-4127-ee0869b61036@web.de>
 <220117.864k62qmt1.gmgdl@evledraar.gmail.com>
 <c605ecc2-29d6-9025-152e-1bcb831e7188@web.de>
 <cf5053b9-451c-7db6-acff-aae41bfabed3@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cf5053b9-451c-7db6-acff-aae41bfabed3@web.de>
Message-ID: <220118.86r195pb2b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Ren=C3=A9 Scharfe wrote:

> Am 17.01.22 um 19:22 schrieb Ren=C3=A9 Scharfe:
>> Am 17.01.22 um 18:43 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:
>>>
>>>
>>>> +/*
>>>> + * Perform an iterative mergesort using an array of sublists.
>>>> + *
>>>> + * n is the number of items.
>>>> + * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
>>>> + * ranks[i] contains a sublist of length 2^i otherwise.
>>>> + *
>>>> + * The number of bits in a void pointer limits the number of objects
>>>> + * that can be created, and thus the number of array elements necessa=
ry
>>>> + * to be able to sort any valid list.
>>>> + *
>>>> + * Adding an item to this array is like incrementing a binary number;
>>>> + * positional values for set bits correspond to sublist lengths.
>>>> + */
>>>>  void *llist_mergesort(void *list,
>>>>  		      void *(*get_next_fn)(const void *),
>>>>  		      void (*set_next_fn)(void *, void *),
>>>>  		      int (*compare_fn)(const void *, const void *))
>>>>  {
>>>> -	unsigned long l;
>>>> -
>>>> -	if (!list)
>>>> -		return NULL;
>>>> -	for (l =3D 1; ; l *=3D 2) {
>>>> -		void *curr;
>>>> -		struct mergesort_sublist p, q;
>>>> +	void *ranks[bitsizeof(void *)];
>>>> +	size_t n =3D 0;
>>>> +	int i;
>>>>
>>>> -		p.ptr =3D list;
>>>> -		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>>>> -		if (!q.ptr)
>>>> -			break;
>>>> -		p.len =3D q.len =3D l;
>>>> +	while (list) {
>>>> +		void *next =3D get_next_fn(list);
>>>> +		if (next)
>>>> +			set_next_fn(list, NULL);
>>>> +		for (i =3D 0; n & (1 << i); i++)
>>>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>>>> +					   set_next_fn, compare_fn);
>>>> +		n++;
>>>> +		ranks[i] =3D list;
>>>> +		list =3D next;
>>>> +	}
>>>
>>> (Commenting on a commit integrated into v2.34.0)
>>>
>>> The aCC compiler on HP/UX notes:
>>>
>>>     "mergesort.c", line 67: warning #2549-D: variable "ranks" is used b=
efore its value is set
>>>                         list =3D llist_merge(ranks[i], list, get_next_f=
n,
>>>
>>> It's commenting on the ranks[i] within the for-loop-within-while-loop
>>> above.
>>
>> That would be a bug.  I think none of the array elements are read before
>> they are written -- but of course I'm biased.  Can that compiler show a
>> sequence that would lead to reading uninitialized data?  Or anyone else?
>>
>> Initializing the array would memset(3) 128 bytes on 32-bit systems and
>> 512 bytes on 64-bit systems.  Doing that everywhere just to appease a
>> confused compiler on a dying platform would be merciful, but still sad.
>
> Does the warning disappear if you add "ranks[0] =3D NULL;" before the whi=
le
> loop?  And if it does, has adding "if (n & 1) ranks[0] =3D NULL;" instead
> the same effect?

Both of those make the warning go away.

Anyway, if you think the pre-image in master now is fine let's leave it
as it is. There's no point in just trying to appease aCC here.

I just thought I'd send a quick mail about it because I was looking at
its warning output, most of those warnings point to obviously harmless
issues, but I thought this one *might* point to an actual logic error
(but didn't look carefully enough myself), so I thought I'd send a quick
note about it.

If you think not it's probably best just to leave the code as-is.

>>
>>>
>>>>
>>>> -		if (compare_fn(p.ptr, q.ptr) > 0)
>>>> -			list =3D curr =3D pop_item(&q, get_next_fn);
>>>> +	for (i =3D 0; n; i++, n >>=3D 1) {
>>>> +		if (!(n & 1))
>>>> +			continue;
>>>> +		if (list)
>>>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>>>> +					   set_next_fn, compare_fn);
>>>>  		else
>>>> -			list =3D curr =3D pop_item(&p, get_next_fn);
>>>> -
>>>> -		while (p.ptr) {
>>>> -			while (p.len || q.len) {
>>>> -				void *prev =3D curr;
>>>> -
>>>> -				if (!p.len)
>>>> -					curr =3D pop_item(&q, get_next_fn);
>>>> -				else if (!q.len)
>>>> -					curr =3D pop_item(&p, get_next_fn);
>>>> -				else if (compare_fn(p.ptr, q.ptr) > 0)
>>>> -					curr =3D pop_item(&q, get_next_fn);
>>>> -				else
>>>> -					curr =3D pop_item(&p, get_next_fn);
>>>> -				set_next_fn(prev, curr);
>>>> -			}
>>>> -			p.ptr =3D q.ptr;
>>>> -			p.len =3D l;
>>>> -			q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>>>> -			q.len =3D q.ptr ? l : 0;
>>>> -
>>>> -		}
>>>> -		set_next_fn(curr, NULL);
>>>> +			list =3D ranks[i];
>>>>  	}
>>>>  	return list;
>>>>  }
>>>

