Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE55C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 20:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbiAWUX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiAWUX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 15:23:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C88C06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 12:23:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r14so9917642wrp.2
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FNuce1wGZ10pWhpABlUBo/PJzZ9JDTuAAwJTF74jgdE=;
        b=R1R8AFKoOTdwLqz+WM+HJ0PNM0S3W6KEPmc0DAOCsj4Ma4X2RAWkAv9hJ68+X6e+LE
         s9T2YKogTcVVL0Kn3WvWzMZVtKMXK5nd7fdc42CEVsq39ERWeZNeFFLVyo0r59WZAlY5
         jexQO0lkAfqmkwHznDb++xnHCxvaU6jo7d3e9CuBvxN1KOSIKmWUrtCn17/3CUHZsur6
         jFYgVG18C5BFIQpl0wyj1QGglzDxh9xtD8+gSfuLjDTcnyxsw7YM0mdRnc42/E8zwxT0
         AnhloRSbRYhcNUQWVCve/H7aFpEGxdkUO6XtuqaDh/d6CY2zDSphUQRNQJPSF0TUD/BE
         egnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FNuce1wGZ10pWhpABlUBo/PJzZ9JDTuAAwJTF74jgdE=;
        b=y5hjNSg0Ch4W+35RvhA2raWmVlXi19Tg8EVhOiVTL5k3aDEdsp7tbZloH6onU6gcPY
         sQ2JtObSzrqr4my/q6kLVTc5N824zN0stItXKZw0eQTszUhZRdidDOXgz3XAyychI7Mr
         vq0/q1ExnGnS9oApQ45ZgEBUpUCSYE1eQulTQp1CUgcU2tlQbcySRaJJBenZLU+6ePyc
         OWmTcfzw8+Xt4XFkM908z3yAJxS9q2zqbGyVcY+aRgH0c3HFTAFYiCGpoIBNj6Jf88TB
         hNganqvBZwD5UwC7PVqejDgyxeL7+RmsugYvCLnDqaQrlK+Sm/AiakbjJ3kAsEQnJoFt
         ub5A==
X-Gm-Message-State: AOAM533EwKVRYVXfTm3z3u0pk+F8IO6YTORioqR0tp3Xof8Djs3iIr/K
        W6Cv3kt0EvkCWuIjZ9+Nc1CthF0BaKA5X00Y
X-Google-Smtp-Source: ABdhPJwISKESQFPbwUnQn+9hlJUNrzQxNNdVvAYRE5Uvktl+9xiJDFOGjdGMwpBqaC10bsD4pdwmJw==
X-Received: by 2002:adf:fd4f:: with SMTP id h15mr11514627wrs.60.1642969434139;
        Sun, 23 Jan 2022 12:23:54 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id b6sm17723875wri.117.2022.01.23.12.23.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jan 2022 12:23:53 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2] mem-pool: Don't assume uintmax_t is aligned enough for
 all types
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <xmqqsfte8awj.fsf@gitster.g>
Date:   Sun, 23 Jan 2022 20:23:53 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD089F0E-C826-4A8E-BC16-F763E256B410@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <20220123152458.72540-1-jrtc27@jrtc27.com> <xmqqsfte8awj.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 Jan 2022, at 20:17, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>=20
>> Currently mem_pool_alloc uses sizeof(uintmax_t) as a proxy for what
>> should be _Alignof(max_align_t) in C11. On most architectures this is
>=20
> Lose "Currently", as the present tense describes the status quo, the
> shape of the problematic code we have today that wants improvement
> by the proposed patch.

Do you want a v3 or is that something you'll amend on git-am?

>> sufficient (though on m68k it is in fact overly strict, since the
>> de-facto ABI, which differs from the specified System V ABI, has the
>> maximum alignment of all types as 2 bytes), but on CHERI, and thus =
Arm's
>> Morello prototype, it is insufficient for any type that stores a
>> pointer, which must be aligned to 128 bits (on 64-bit architectures
>> extended with CHERI), whilst uintmax_t is a 64-bit integer.
>=20
> OK.
>=20
>> Fix this by introducing our own approximation for max_align_t and a
>> means to compute _Alignof it without relying on C11. Currently this
>> union only contains uintmax_t and void *, but more types can be added =
as
>> needed.
>=20
> Nicely described.
>=20
>> +/*
>> + * The inner union is an approximation for C11's max_align_t, and =
the
>> + * struct + offsetof computes _Alignof. This can all just be =
replaced
>> + * with _Alignof(max_align_t) if/when C11 is part of the baseline.
>> + *
>> + * Add more types to the union if the current set is insufficient.
>> + */
>> +struct git_max_alignment {
>> +	char unalign;
>> +	union {
>> +		uintmax_t max_align_uintmax;
>> +		void *max_align_pointer;
>> +	} aligned;
>> +};
>> +#define GIT_MAX_ALIGNMENT offsetof(struct git_max_alignment, =
aligned)
>> +
>=20
> The original computed the alignment requirement for uintmax_t as
> sizeof(uintmax_t), not as
>=20
> 	offsetof(struct {
> 		char unalign;
> 		union { uintmax_t i; } aligned;
> 	}, aligned)
>=20
> because if you have an array of a type, each element of it must be
> aligned appropriately already for that type, without the unalignment
> the outer struct enforces.  I wonder if your complex offsetof is
> equivalent to sizeof(union { uintmax_t u; void *p; })?
>=20
> IOW, in this struct:
>=20
> 	struct max_alignment_helper {
> 		char unalign;
> 		union {
> 			uintmax_t uintmax_t_unused;
> 			void *pointer_unused;
> 		} u[2];
> 	} s;
>=20
> both s.u[0] and s.u[1] must be properly aligned, so wouldn't the
> alignment requirement for the union type, which can be used to hold
> a single value of either uintmax_t or a poinhter, be the distance
> between these two array elements, i.e. sizeof(s.u[0])?
>=20
> To put it differently in yet another way, wouldn't it simplify down
> to this?
>=20
> 	union max_alignment_helper {
> 		uintmax_t uintmax_t_unused;
>                void *pointer_unused;
> 	};
> 	#define GIT_MAX_ALIGNMENT sizeof(union max_alignment_helper);
>=20
> I am not saying that the "a forcibly unaligned union in a struct" is
> a bad/wrong way to express what you want to achieve.  I just do not
> know if there is a reason to choose it over a seemingly simpler
> sizeof(that union) without the outer struct and unalign member.

So, sizeof(X) does not always equal _Alignof(X), even for primitive
types, _Alignof need only be a factor of sizeof. The two are the same
on most architectures, and is a sensible ABI, but the exception is the
m68k case I was referring to above. On m68k, sizeof(long long) =3D=3D 8,
but _Alignof(long long) =3D=3D 2 (yes this is a real pain point of its =
ABI;
in particular int is only 2-byte aligned, but futex(2) explicitly
requires 4-byte alignment). So using sizeof definitely gets you
something sufficiently aligned, but can waste space. This doesn=E2=80=99t
affect CHERI/Morello, all our implementations keep sizeof =3D=3D =
_Alignof,
but as I was changing this code I felt I should use the more precise
construct.

Jess

> Other than that, looks OK to me.  Especially the parts that use the
> macro look correctly converted.
>=20
> Thanks.
>=20
>> @@ -69,9 +85,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t =
len)
>> 	struct mp_block *p =3D NULL;
>> 	void *r;
>>=20
>> -	/* round up to a 'uintmax_t' alignment */
>> -	if (len & (sizeof(uintmax_t) - 1))
>> -		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - =
1));
>> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
>> +	if (len & (GIT_MAX_ALIGNMENT - 1))
>> +		len +=3D GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - =
1));
>>=20
>> 	if (pool->mp_block &&
>> 	    pool->mp_block->end - pool->mp_block->next_free >=3D len)
>=20
>=20
>> /*
>>  * Allocate a new mp_block and insert it after the block specified in
>>  * `insert_after`. If `insert_after` is NULL, then insert block at =
the
>> @@ -69,9 +85,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t =
len)
>> 	struct mp_block *p =3D NULL;
>> 	void *r;
>>=20
>> -	/* round up to a 'uintmax_t' alignment */
>> -	if (len & (sizeof(uintmax_t) - 1))
>> -		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - =
1));
>> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
>> +	if (len & (GIT_MAX_ALIGNMENT - 1))
>> +		len +=3D GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - =
1));
>>=20
>> 	if (pool->mp_block &&
>> 	    pool->mp_block->end - pool->mp_block->next_free >=3D len)

