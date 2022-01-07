Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A04C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiAGQI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 11:08:59 -0500
Received: from mout.web.de ([212.227.15.14]:37013 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbiAGQI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 11:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641571737;
        bh=bB4eBX+UfChoqnpUjJKSc/rk/nWtn69u6wVCtQqpi5w=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=oEVSoMnoHFjWQfysfJ9OjIoMAPTPzd+0tu9myCRGIngv7zhWLuiwkn8jPk8EKfgre
         qqUNj0KET6FakXYl0rc1ndKpT4rfk0lOn9Ec/OWHXpBHd8rVBF7JAr+pz3pBo40e2n
         mL18t7X8U6Z0ndd4E8pP40SOVUVm9dQL874QI7nE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1mxn4s0o6d-00R2tw; Fri, 07
 Jan 2022 17:08:57 +0100
Message-ID: <3b469866-3718-9f0e-419c-bdc793de18e9@web.de>
Date:   Fri, 7 Jan 2022 17:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220105132324.6651-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P17NNBwsv1MBXvbM0RAFeogB6RogIp9GUl6NxJotRX4fmNhq5mu
 egHjUg7IEwtmWjRqf4TK7zcSNPEUPVDSkr8CRr/D/T2caQ/j++xnpMvbAVVbDJ9fPVzluGA
 8idE9Pm/tK18YujhTn6WXZ98clZtZSW7aRgqDW7QDuKTASQiqCx1BofqbxirOI+ou1hIWbL
 rJr1VYt9t84EEwHCbaypQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LZfCuwVJXPQ=:dP1VKWF3gOgEpYEm9iDO0k
 a7UtrJ+yJCjjHHF7PCkYjwrJrhQOG52NegLGFBbovm9hbwsdIHVIWB+yAU/EZKUbxGSBHEgUS
 cGOQDaoLZwSWHYwsLWg4W8fnrbLPwu/BJtinIcP/UtgzAs0PYMs1jGsGp1dnGGqmUJ62C9Y8c
 Isy8thkqhLg0u9/9bN5VU9iEsSpDR2Dttteve3X/0L1ES403+522ALLJqSXyVM30pOL8u7JWM
 kvbsAuJfBlLsWAzkrbfELy1rZqmfEQ0tJt3bwAwZzGeLtJywZL/fvujbHWAwaDuYnMBAH90Gl
 6AkMw4afa1UONTgoQnxPa33DWUGYcUihMAVgmmxrApP/Tx7qdwl90WlsX5o8AeyobJ7jTNwtI
 4cu0J8dz6Jgml1hj4ETM8edGiMA8pUwR1dr6K4V7ZxAykXiRP6T5wkKVkwYjnzw5r8rWlz1Ql
 LyuOZNZd6PlbzuegcTx34t+LuTSPjmoT8TY1gSa7jsltCQuBrDwME859gZw1NgP+mEKcYjyyJ
 J8w5vRQcpakz7S43cBzE3zBHs5MjYe/StJIDKYIjCeegJ9ssP7SD1V/eqwXu/demIJlaichyg
 Pt6KVfHvIHS0DWY3ontyMpS92VX9gbxEj76nkiD0liEVqPTjabFhAwrIE/qz8rphWbnFrSU5k
 Px5d++ro0BnK/4G94wXN8fiAKl0+5sv6bDs8gZaR/2SpRBYynYQBZ+CG8fRx/MiCEbMcsHn4n
 RdzFfEgRTN3UdtK06gyPchXNU0qlrRkhUI+nTXi/Qy87sezDtrw6hliGywih0x9IHzHh9UKav
 o02qGL2j4qx3TW3Q5cYZ++qcVOi/+rRfPEzIVM5AuSzc81gP9KSW+7kfmVdJCKEY9CQCbwFLK
 A5N6rttZfi84GdJdgJ412pNI2ecBDNzm43JjuMYvgdKg5meGnukIXh/cx2xN8ktjj22slpsma
 2Rau8l4tanGEEDkBDZ0MfR6SnHLgTBy1bzM78DaMcn73nUv8d5GXI8JYL/LiINeQvTqhEBX3q
 9TM+SROpNSi9mUrzZXpwoWAHSQfck7gc2WZgbvkyHzlDLNuZHQJJ0iTKkvIcxawQCA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.01.22 um 14:23 schrieb Jessica Clarke:
> Currently git_qsort_s allocates a buffer on the stack that has no
> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
> alignment for any type.
>
> On CHERI, and thus Arm's Morello prototype, pointers are implemented as
> hardware capabilities which, as well as having a normal integer address,
> have additional bounds, permissions and other metadata in a second word,
> so on a 64-bit architecture they are 128-bit quantities, including their
> alignment requirements. Despite being 128-bit, their integer component
> is still only a 64-bit field, so uintmax_t remains 64-bit, and therefore
> uintmax_t does not sufficiently align an allocation.
>
> Moreover, these capabilities have an additional "129th" tag bit, which
> tracks the validity of the capability and is cleared on any invalid
> operation that doesn't trap (e.g. partially overwriting a capability
> will invalidate it) which, combined with the architecture's strict
> checks on capability manipulation instructions, ensures it is
> architecturally impossible to construct a capability that gives more
> rights than those you were given in the first place. To store these tag
> bits, each capability sized and aligned word in memory gains a single
> tag bit that is stored in unaddressable (to the processor) memory. This
> means that it is impossible to store a capability at an unaligned
> address: a normal load or store of a capability will always take an
> alignment fault even if the (micro)architecture supports unaligned
> loads/stores for other data types, and a memcpy will, if the destination
> is not appropriately aligned, copy the byte representation but lose the
> tag, meaning that if it is eventually copied back and loaded from an
> aligned location any attempt to dereference it will trap with a tag
> fault. Thus, even char buffers that are memcpy'ed to or from must be
> properly aligned on CHERI architectures if they are to hold pointers.
>
> Address both of these by introducing a new git_max_align type put in a
> union with the on-stack buffer to force its alignment, as well as a new
> GIT_MAX_ALIGNMENT macro whose value is the alignment of git_max_align
> that gets used for mem_pool_alloc. As well as making the code work on
> CHERI, the former change likely also improves performance on some
> architectures by making memcpy faster (either because it can use larger
> block sizes or because the microarchitecture has inefficient unaligned
> accesses).
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>  compat/qsort_s.c  | 11 +++++++----
>  git-compat-util.h | 11 +++++++++++
>  mem-pool.c        |  6 +++---
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
> index 52d1f0a73d..1ccdb87451 100644
> --- a/compat/qsort_s.c
> +++ b/compat/qsort_s.c
> @@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
>  		int (*cmp)(const void *, const void *, void *), void *ctx)
>  {
>  	const size_t size =3D st_mult(n, s);
> -	char buf[1024];
> +	union {
> +		char buf[1024];
> +		git_max_align align;
> +	} u;
>
>  	if (!n)
>  		return 0;
>  	if (!b || !cmp)
>  		return -1;
>
> -	if (size < sizeof(buf)) {
> -		/* The temporary array fits on the small on-stack buffer. */
> -		msort_with_tmp(b, n, s, cmp, buf, ctx);
> +	if (size < sizeof(u.buf)) {
> +		/* The temporary array fits in the small on-stack buffer. */
> +		msort_with_tmp(b, n, s, cmp, u.buf, ctx);

So buf gets maximum alignment instead of char alignment (i.e. none)
because some callers use it to sort pointers, which need that on your
platform.  Makes sense.

>  	} else {
>  		/* It's somewhat large, so malloc it.  */
>  		char *tmp =3D xmalloc(size);

tmp is used instead of buf if the latter is not big enough, so it can
also contain pointers.  No problem, because malloc(3) returns memory
that is properly aligned for anything already.


stable-qsort.c uses the same algorithm as compat/qsort_s.c, it just
lacks the context pointer.  Shouldn't it get the same treatment?  It
is used e.g. (via the macro STABLE_QSORT) in merge-ort.c to sort
pointers..

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5fa54a7afe..28581a45c5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>  #define _ALL_SOURCE 1
>  #endif
>
> +typedef union {
> +	uintmax_t max_align_uintmax;
> +	void *max_align_pointer;
> +} git_max_align;

For your purposes just the void * member would suffice here, right?  And
with the added uintmax_t this currently gets maximum alignment, suitable
for any of our objects.  If we were to start using __int128 etc. then
we'd have to add that to this union as well to really get the maximum
possible alignment, though.

> +
> +typedef struct {
> +	char unalign;
> +	git_max_align aligned;
> +} git_max_alignment;
> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)

C11 has alignas, alignof and max_align_t.  We only recently started to
depend on some C99 features, so perhaps it's a bit early to use
stdalign.h in Git's code base.  That's a pity, though.  The
GIT_MAX_ALIGNMENT macro is sightly enough, but using a union to get
pointer alignment is a bit more cumbersome than something like

	alignas(alignof(max_align_t)) char buf[1024];

> +
>  /* used on Mac OS X */
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
> diff --git a/mem-pool.c b/mem-pool.c
> index ccdcad2e3d..748eff925a 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len=
)
>  	struct mp_block *p =3D NULL;
>  	void *r;
>
> -	/* round up to a 'uintmax_t' alignment */
> -	if (len & (sizeof(uintmax_t) - 1))
> -		len +=3D sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
> +	if (len & (GIT_MAX_ALIGNMENT - 1))
> +		len +=3D GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));

OK.

>
>  	if (pool->mp_block &&
>  	    pool->mp_block->end - pool->mp_block->next_free >=3D len)

