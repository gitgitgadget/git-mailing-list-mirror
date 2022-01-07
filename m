Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E71C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbiAGQVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 11:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239927AbiAGQVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 11:21:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D863C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 08:21:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w20so11999680wra.9
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BmO8I+8v+eHjbiY26/UpqV1JKCk7WHiKE73ulfyWP+0=;
        b=FIhEUVudyta+WEGkU0xYaJhBOdteGdobcCAUKi2Rr/ocAHYbvU87wjQn49xdq2GkM/
         1kmwTWx2ZpPRfnOdrg7Up9X/i3q17VtNIr+5/Jl/3G0NbqFY4MNMSmCZ5TiB+2JSB41g
         NDx7qOSLP1tO0nfd3KK3AkjDDw9Qn+Klrmb9/vKI2VpQL9/HiNzb+LwczF/HrMcBMZmv
         GlqYyr3vijd/6qf/h++FIhODj5HvEZ2PYD8AiNt9cgY2qKpfL64QKZxVs50MmLERnHLu
         0SKf4LuTI2im7aY/osPRIkKuQAhlXrAA+QLHOFpg6OtaK87iG8jAFWTmUO/nhypL/5FJ
         Ve5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BmO8I+8v+eHjbiY26/UpqV1JKCk7WHiKE73ulfyWP+0=;
        b=JyFQ8wSdgRD8ofXOBINagL3yPvGhUgkc1axLtBks1swtXEYZNEDvYyNhmLj4yK0dxc
         WHE7uLOTHM2/RAiR/JNAllSzuiKM4pe8oR7vme0jjAnjJeaDnwhewKof6Xq8u8zLLBTJ
         JeYynH5h4JogVuTbYKf+aLP8dJBaRvzq8AfwfBETud5C7p4QL94bEAGxDOJ1nruHmgx3
         gvkxKhbfjlcl+Rqr/GzGvqP675WTIrdmBmyd/N+joyebpU0eKm6/6YjKrP8PQJVgI+bt
         VOJNtuJs0RKhIZuMDy4GR1TRZYrNB1MJAz6/YSMFnvyPYmUZ8nTc5u8UpWN6EYq1sQXo
         twfQ==
X-Gm-Message-State: AOAM533736WLRE3KiMhfbzvnpJQEzhXt2NH4DvgUCAO+y54fhmudySYe
        jRl+tiQH1amiSMEj+lW1kjzGGm03IV5Kss3a
X-Google-Smtp-Source: ABdhPJzxoscuXyLKgxwXPyt7nGWL7+JNJHk01Ik4FMDmbRUYvqzB4ZaIBGFVoaaXX8jjbq56zMBi/Q==
X-Received: by 2002:a05:6000:50b:: with SMTP id a11mr23517602wrf.387.1641572507811;
        Fri, 07 Jan 2022 08:21:47 -0800 (PST)
Received: from smtpclient.apple (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id i15sm5415178wrf.6.2022.01.07.08.21.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jan 2022 08:21:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <3b469866-3718-9f0e-419c-bdc793de18e9@web.de>
Date:   Fri, 7 Jan 2022 16:21:47 +0000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDDA4F68-B9D4-4F8D-B7D2-C1DF3237F897@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <3b469866-3718-9f0e-419c-bdc793de18e9@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 Jan 2022, at 16:08, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>=20
> Am 05.01.22 um 14:23 schrieb Jessica Clarke:
>> Currently git_qsort_s allocates a buffer on the stack that has no
>> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
>> alignment for any type.
>>=20
>> On CHERI, and thus Arm's Morello prototype, pointers are implemented =
as
>> hardware capabilities which, as well as having a normal integer =
address,
>> have additional bounds, permissions and other metadata in a second =
word,
>> so on a 64-bit architecture they are 128-bit quantities, including =
their
>> alignment requirements. Despite being 128-bit, their integer =
component
>> is still only a 64-bit field, so uintmax_t remains 64-bit, and =
therefore
>> uintmax_t does not sufficiently align an allocation.
>>=20
>> Moreover, these capabilities have an additional "129th" tag bit, =
which
>> tracks the validity of the capability and is cleared on any invalid
>> operation that doesn't trap (e.g. partially overwriting a capability
>> will invalidate it) which, combined with the architecture's strict
>> checks on capability manipulation instructions, ensures it is
>> architecturally impossible to construct a capability that gives more
>> rights than those you were given in the first place. To store these =
tag
>> bits, each capability sized and aligned word in memory gains a single
>> tag bit that is stored in unaddressable (to the processor) memory. =
This
>> means that it is impossible to store a capability at an unaligned
>> address: a normal load or store of a capability will always take an
>> alignment fault even if the (micro)architecture supports unaligned
>> loads/stores for other data types, and a memcpy will, if the =
destination
>> is not appropriately aligned, copy the byte representation but lose =
the
>> tag, meaning that if it is eventually copied back and loaded from an
>> aligned location any attempt to dereference it will trap with a tag
>> fault. Thus, even char buffers that are memcpy'ed to or from must be
>> properly aligned on CHERI architectures if they are to hold pointers.
>>=20
>> Address both of these by introducing a new git_max_align type put in =
a
>> union with the on-stack buffer to force its alignment, as well as a =
new
>> GIT_MAX_ALIGNMENT macro whose value is the alignment of git_max_align
>> that gets used for mem_pool_alloc. As well as making the code work on
>> CHERI, the former change likely also improves performance on some
>> architectures by making memcpy faster (either because it can use =
larger
>> block sizes or because the microarchitecture has inefficient =
unaligned
>> accesses).
>>=20
>> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
>> ---
>> compat/qsort_s.c  | 11 +++++++----
>> git-compat-util.h | 11 +++++++++++
>> mem-pool.c        |  6 +++---
>> 3 files changed, 21 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
>> index 52d1f0a73d..1ccdb87451 100644
>> --- a/compat/qsort_s.c
>> +++ b/compat/qsort_s.c
>> @@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
>> 		int (*cmp)(const void *, const void *, void *), void =
*ctx)
>> {
>> 	const size_t size =3D st_mult(n, s);
>> -	char buf[1024];
>> +	union {
>> +		char buf[1024];
>> +		git_max_align align;
>> +	} u;
>>=20
>> 	if (!n)
>> 		return 0;
>> 	if (!b || !cmp)
>> 		return -1;
>>=20
>> -	if (size < sizeof(buf)) {
>> -		/* The temporary array fits on the small on-stack =
buffer. */
>> -		msort_with_tmp(b, n, s, cmp, buf, ctx);
>> +	if (size < sizeof(u.buf)) {
>> +		/* The temporary array fits in the small on-stack =
buffer. */
>> +		msort_with_tmp(b, n, s, cmp, u.buf, ctx);
>=20
> So buf gets maximum alignment instead of char alignment (i.e. none)
> because some callers use it to sort pointers, which need that on your
> platform.  Makes sense.

Yes, exactly.

>> 	} else {
>> 		/* It's somewhat large, so malloc it.  */
>> 		char *tmp =3D xmalloc(size);
>=20
> tmp is used instead of buf if the latter is not big enough, so it can
> also contain pointers.  No problem, because malloc(3) returns memory
> that is properly aligned for anything already.

Yes.

> stable-qsort.c uses the same algorithm as compat/qsort_s.c, it just
> lacks the context pointer.  Shouldn't it get the same treatment?  It
> is used e.g. (via the macro STABLE_QSORT) in merge-ort.c to sort
> pointers..

Indeed it should; I guess git_stable_qsort just isn=E2=80=99t used for =
most
common commands, or at least not with structures containing pointers,
as I haven=E2=80=99t seen it break yet.

>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5fa54a7afe..28581a45c5 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>> #define _ALL_SOURCE 1
>> #endif
>>=20
>> +typedef union {
>> +	uintmax_t max_align_uintmax;
>> +	void *max_align_pointer;
>> +} git_max_align;
>=20
> For your purposes just the void * member would suffice here, right?  =
And
> with the added uintmax_t this currently gets maximum alignment, =
suitable
> for any of our objects.  If we were to start using __int128 etc. then
> we'd have to add that to this union as well to really get the maximum
> possible alignment, though.

For us, yes, uintmax_t=E2=80=99s alignment is never greater than void =
*=E2=80=99s. On
most 32-bit non-CHERI architectures though that isn=E2=80=99t the case, =
so
whilst omitting uintmax_t would be fine for qsort, it would break
mem_pool_alloc=E2=80=99s alignment, as this gets used for both. Plus =
aligning
to uintmax_t may still help performance for memcpy there (e.g. maybe it
guarantees the memcpy implementation can use a load/store pair
instruction that it wouldn=E2=80=99t otherwise necessarily be able to).

Regarding __int128, yes, you would, though both GCC=E2=80=99s and =
FreeBSD=E2=80=99s
stddef.h don=E2=80=99t admit __int128 exists. They do include long =
double in
their max_align_t, though, which generally has the same alignment
requirements as __int128 on 64-bit architectures, though I have a funny
feeling it might not on some.

>> +
>> +typedef struct {
>> +	char unalign;
>> +	git_max_align aligned;
>> +} git_max_alignment;
>> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)
>=20
> C11 has alignas, alignof and max_align_t.  We only recently started to
> depend on some C99 features, so perhaps it's a bit early to use
> stdalign.h in Git's code base.  That's a pity, though.  The
> GIT_MAX_ALIGNMENT macro is sightly enough, but using a union to get
> pointer alignment is a bit more cumbersome than something like
>=20
> 	alignas(alignof(max_align_t)) char buf[1024];

It is; max_align_t is our preferred solution and what our programming
guide recommends, but not everyone is ready to jump to C11, so until
then various bodges like this are needed.

Jess

>> +
>> /* used on Mac OS X */
>> #ifdef PRECOMPOSE_UNICODE
>> #include "compat/precompose_utf8.h"
>> diff --git a/mem-pool.c b/mem-pool.c
>> index ccdcad2e3d..748eff925a 100644
>> --- a/mem-pool.c
>> +++ b/mem-pool.c
>> @@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t =
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
>=20
> OK.
>=20
>>=20
>> 	if (pool->mp_block &&
>> 	    pool->mp_block->end - pool->mp_block->next_free >=3D len)

