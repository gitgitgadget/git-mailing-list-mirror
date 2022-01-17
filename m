Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E0C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiAQSWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:22:15 -0500
Received: from mout.web.de ([212.227.15.4]:46169 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238272AbiAQSWO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642443727;
        bh=Fc00h0rI0O4/tVnsnEWthvPCXp0bkWE2WgBkAXihwVs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EJl0jDYLz5gbVsVFQDnVk2BTEVWiF0ddF6mk7mDa23E08SCyvvagT1+IrH3hMDDjD
         k1JjVcQOo7LdLRCfQaJMo6/7H+mxqvShctaue+ajZnoj4e1ITtKjiktA4uYc2tCPVm
         +bT9/3xU/O9hKja8erM1p/08yL1GR6o0hYXvXRhA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1mSC0o15m1-00lXNT; Mon, 17
 Jan 2022 19:22:07 +0100
Message-ID: <c605ecc2-29d6-9025-152e-1bcb831e7188@web.de>
Date:   Mon, 17 Jan 2022 19:22:06 +0100
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220117.864k62qmt1.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zI49DNXSvhQBuizabsypKWuVvXccSpNRrvXm5Kl6KsqwuZMv6I2
 e5rt5jzdHeHbrWkeCGHdJwdeyWLbM4XRvuMYM4enS5nXqCiIjJBeuiyo5SlKkE3TQWXgaLw
 zuSKcKF17rM7KwFcZXJFUO6zH3HWOs/lkb2PLH2pBmRG7kfUi8+hE9VVfhcPHj3Ke4ny9Ez
 5npiqHg6clPWrz0vquyfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/a3CspSmAk=:tYoSUPuoSdRd9x6WLkYZ8p
 KU3XTwxQvn8Ncwl7lbV8sZ0Gor/e+lNbevkmqFa66FvjUrboWBqNowhtozT0138bjudwyeY7d
 FijhnzWuwBygYxYTbob+Ubq4uz+8BpouIxqOx1BeZl5wlbaFWbHQGmbvaKqtdJoo9DrnRS/Bi
 wZGfV3u4RIqjuxRWbKDuHN4TREf2RaLTagdtPzNXknXr7El0R8QxXaFxkfJvWRXYfq5EJgRV7
 y7p6YLdCHczWQNrjHOljxYcThvSTUbmKFEmdv7WReaTRHclJS+berRmuJwtI6zxX4ayf+vxzp
 uwkz6RkzVUF+6EC81Z+kFB6m5JBDzsJ6V8aXMxFMVMY++hqCiX8XdICBaNwU2tOOPEMms9UDN
 lhFLIFw4YqV8oKFKJIrdpFYy4TBjcIvz2ordMym+YeA2YzHaTJCS8cXtGQ98wlYy6oaFoTXzM
 eMlfyF3iAcfjH3HMqUyviB4P9rHjn4A2K2TyrXzValnaSz5UBiFoK+EwUqJmXzP+ss3JA2Qsf
 EurBY96PNG6nPHYPVrvJGJT25wwbwmvq6TwsEltHAZkt3zVZKjyQrW/MUXFIV4FBpFLXkpc26
 C8p5OUePk+zeJaNFpQl4vcnXKE3nNIlF9h0ADpBc2ZIIubUDghrQZJTxVpLB8TXBdY9pcGRYX
 VM7UHrqr97ktiNZ3wVxv+QO1FC3cUXsfVDYXkqk9UZISF4xBtKV4gfivsVh/xP9gCyXROUN7/
 MeJ7CEuDDSMkv6T6xy26ed3GDPwmGcL2czdjwk4gKNxSdg7zcSanQ0MCh+qfV37WVefwPRrUH
 8/GRZdwnMXueO4+L6hZplqikBGLGE/B2ulIy25Dtfk6/T9mGwNmYpNjkqucNANSssjLvqFi8X
 1GA4QsxQfj4IZ8qXff8SuEBs0Kw0mkcinafgMHclK7oOYqow7VbZE0ZnGAYLgc6p8SUrw1yzC
 NqQt1UWaq5EOEgdHv/uxhn3HiaZEHsU/R96QVXFygAuYGEqVG9UECUUoi4/F4oorcleGH+QMq
 ni737WRVNKOTLjHl4HLvMOwCZpx32Uz23JcXyU/KrPyS3D0Sb8rWMKhAyWhBmP4rxg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.01.22 um 18:43 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Oct 01 2021, Ren=C3=A9 Scharfe wrote:
>
>
>> +/*
>> + * Perform an iterative mergesort using an array of sublists.
>> + *
>> + * n is the number of items.
>> + * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
>> + * ranks[i] contains a sublist of length 2^i otherwise.
>> + *
>> + * The number of bits in a void pointer limits the number of objects
>> + * that can be created, and thus the number of array elements necessar=
y
>> + * to be able to sort any valid list.
>> + *
>> + * Adding an item to this array is like incrementing a binary number;
>> + * positional values for set bits correspond to sublist lengths.
>> + */
>>  void *llist_mergesort(void *list,
>>  		      void *(*get_next_fn)(const void *),
>>  		      void (*set_next_fn)(void *, void *),
>>  		      int (*compare_fn)(const void *, const void *))
>>  {
>> -	unsigned long l;
>> -
>> -	if (!list)
>> -		return NULL;
>> -	for (l =3D 1; ; l *=3D 2) {
>> -		void *curr;
>> -		struct mergesort_sublist p, q;
>> +	void *ranks[bitsizeof(void *)];
>> +	size_t n =3D 0;
>> +	int i;
>>
>> -		p.ptr =3D list;
>> -		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>> -		if (!q.ptr)
>> -			break;
>> -		p.len =3D q.len =3D l;
>> +	while (list) {
>> +		void *next =3D get_next_fn(list);
>> +		if (next)
>> +			set_next_fn(list, NULL);
>> +		for (i =3D 0; n & (1 << i); i++)
>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>> +					   set_next_fn, compare_fn);
>> +		n++;
>> +		ranks[i] =3D list;
>> +		list =3D next;
>> +	}
>
> (Commenting on a commit integrated into v2.34.0)
>
> The aCC compiler on HP/UX notes:
>
>     "mergesort.c", line 67: warning #2549-D: variable "ranks" is used be=
fore its value is set
>                         list =3D llist_merge(ranks[i], list, get_next_fn=
,
>
> It's commenting on the ranks[i] within the for-loop-within-while-loop
> above.

That would be a bug.  I think none of the array elements are read before
they are written -- but of course I'm biased.  Can that compiler show a
sequence that would lead to reading uninitialized data?  Or anyone else?

Initializing the array would memset(3) 128 bytes on 32-bit systems and
512 bytes on 64-bit systems.  Doing that everywhere just to appease a
confused compiler on a dying platform would be merciful, but still sad.

>
>>
>> -		if (compare_fn(p.ptr, q.ptr) > 0)
>> -			list =3D curr =3D pop_item(&q, get_next_fn);
>> +	for (i =3D 0; n; i++, n >>=3D 1) {
>> +		if (!(n & 1))
>> +			continue;
>> +		if (list)
>> +			list =3D llist_merge(ranks[i], list, get_next_fn,
>> +					   set_next_fn, compare_fn);
>>  		else
>> -			list =3D curr =3D pop_item(&p, get_next_fn);
>> -
>> -		while (p.ptr) {
>> -			while (p.len || q.len) {
>> -				void *prev =3D curr;
>> -
>> -				if (!p.len)
>> -					curr =3D pop_item(&q, get_next_fn);
>> -				else if (!q.len)
>> -					curr =3D pop_item(&p, get_next_fn);
>> -				else if (compare_fn(p.ptr, q.ptr) > 0)
>> -					curr =3D pop_item(&q, get_next_fn);
>> -				else
>> -					curr =3D pop_item(&p, get_next_fn);
>> -				set_next_fn(prev, curr);
>> -			}
>> -			p.ptr =3D q.ptr;
>> -			p.len =3D l;
>> -			q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
>> -			q.len =3D q.ptr ? l : 0;
>> -
>> -		}
>> -		set_next_fn(curr, NULL);
>> +			list =3D ranks[i];
>>  	}
>>  	return list;
>>  }
>
