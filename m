Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD4373BF2
	for <git@vger.kernel.org>; Sat, 16 May 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778929814; cv=none; b=nEDNU4txfYMVyNM0R7piTohqZuIdmBVnL1h2fUwD1PQ8nvG83bmA/txgDEFcON4M3tVdT3rTdpFw3aBEKc74/XB+Fwy9swA8JfFfyr74eogdk4zTGhbfwvpNf4NPUc8T4pP5iYmzj4LyaSxTYeIL0HFkX+4k8QH4ymj3KqVsWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778929814; c=relaxed/simple;
	bh=CDH+Ad7ykmmGuK2Gvd96XYwT7VyR9fo9nhjzwfNeVpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGJ7Ex2lTcfSahyKQ4efKQHSTfHdDara+3HUWwBYRajkFePfofmvtr8xha65IFt3bRJwOCzMGVy+kVLM17kPOeNl8Msr6QwdwbPGSNCjmTdx6VRdqy5c9j7y8pjgI7T/QsXFzIi9TISVsdXTjAPV7LyrRtC7//PU09PtoUiSL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=fyGYpIA7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="fyGYpIA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778929810; x=1779534610; i=l.s.r@web.de;
	bh=3cjE2TefWuGTPXAwygo7cEMb4HvwNmCQsjGEqO2Py5c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fyGYpIA7MPLGyIdhkuvWxEI0ylzhBc4DZKKEdweLS6TbfUDievoHwwjrviN7OFvd
	 IdZJWs4njkdeNmYjUpv+6l4AWhS8h3WLTtLu/KvM39j16wV/GoIoS4KiL0T0RbCMs
	 Z0W879Z5vqBgHOmsLqqhLzwjtDPGYOIZtcGFsrvB81dHoxZxK40ZEIaL6hP4bQ8uk
	 IBiGh2yeFa9njz4LbTE4/7OZtNFsBPHc6poCHvXyn9S+6nsiJh7Jz2qWgcYPciPn+
	 rktzEl0k0IbdNrssHWVov6jlpvchqx5Z88VKobgQQrk/ycG49Tu1tKCs0Zu/j9/En
	 DnA+jPRXlZZRcjpcKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Movne-1xADue1C6Y-00aM15; Sat, 16
 May 2026 13:10:10 +0200
Message-ID: <23be5317-4f28-4871-8aab-5281f4da5f0e@web.de>
Date: Sat, 16 May 2026 13:10:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] evaluate the second argument of ALLOC_GROW only once
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
 <20260515190818.GA98370@coredump.intra.peff.net>
 <20260515195049.GA149960@coredump.intra.peff.net>
 <1d79d7bc-5441-4e72-9cb0-e8900f57172c@web.de>
 <20260516025119.GA832077@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260516025119.GA832077@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+NV23TIdHebi6jD1krKaJ7D4cpVCfZDB3KfGGFX1JQzjXldjMgr
 GLviwBhnu/aBQ/c3iwtN9ATJeszaJ11LT78KWYRQjy3yqD/tIfdHNYXDaJLaru8AFkFANeT
 56AQYjihRMovLBNpBsNDn6pHMKg+VARAGlwl76J+9QKSQyyljtbjQcPJyAyf1bOjZ2PVtUk
 W/EawEnCBFWpfo+M06M3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zF+sJTIcfvo=;G+hmNgOw2HmxjNzQeDcn6dNQa3o
 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
 8RRzRWs3v9C+L3SI7/ACutR6ndAVo5bE5WF8=

On 5/16/26 4:51 AM, Jeff King wrote:
> On Sat, May 16, 2026 at 01:01:05AM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>>> I think as long as the behavior remains "slow, but we do not overflow
>>> any buffers" when you reach these limits, that's OK. Nobody is going t=
o
>>> do it in practice, and we just want to make sure that malicious inputs
>>> cannot get out-of-bounds writes. It might be worth adding a comment,
>>> though, to make sure nobody ever swaps "alloc_grow_new_alloc_" for
>>> "alloc" in that macro.
>> There is no overflow check in either version (yet), so neither is safe
>> to operate close to the boundary.  Close meaning the intermediate term
>> (alloc + 16) * 3 being bigger than the maximum value.
>=20
> Yes, but for some definition of safe. Both before and after your patch,
> as we get close to the boundary the allocation will grow slower than it
> should, but we'll never write out of bounds. The behavior for the "git
> foo" I showed earlier is slightly different:
>=20
>   - before your patch, ~2GB we stop doubling and instead start growing
>     the array by one at each ALLOC_GROW() call. This is because
>     alloc_nr() overflows to a small value, but the:
>=20
>       if (alloc_nr(alloc) < (nr))
>               alloc =3D (nr);
>=20
>     check kicks in.
>=20
>   - after your patch we grow to ~4GB, and then things get super slow.
>     This is because we correctly compute the new allocation as a size_t,
>     but then truncate it while assigning to alloc. So on the next
>     ALLOC_GROW() call, we'll think the buffer is way too small and try
>     to realloc again. I don't know why this is so much slower than the
>     grow-by-one above, but it is.
>=20
> Neither is really correct, but both are in the realm of OK: stupidly
> large input doesn't perform well, but there's no buffer overflow
> vulnerability.
>=20
> What I was worried about is what happens if you tweak your patch like
> this:
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 2bc1f43f48..0730dd24ad 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -870,7 +870,7 @@ static inline bool st_alloc_nr(size_t nr, size_t all=
oc, size_t *outp)
>  		size_t alloc_grow_new_alloc_; \
>  		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
>  			alloc =3D alloc_grow_new_alloc_; \
> -			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
> +			REALLOC_ARRAY(x, alloc); \
>  		} \
>  	} while (0)
> =20
>=20
> In that case we really do end up with too-small allocations and
> out-of-bounds writes.
>=20
> Maybe you saw that coming and that's why you wrote it as you did. But it
> is definitely subtle enough that I think it would merit a big warning
> comment that "alloc" and "alloc_grow_new_alloc_" are not necessarily the
> same type, and hence not necessarily the same value.

It was the economic thing to do: Fetching the value of user-supplied
alloc variable makes no sense when we have our calculated size_t value
at hand.

>> Here's a demo program exercising the arithmetic part of the macros:
>=20
> I think the difference isn't in the arithmetic values that come out, but
> in what is fed to realloc() itself. And in your harness, realloc is just
> "x =3D true". If you actually store the value that would be passed to
> realloc() like this:
>=20
> diff --git a/foo.c.orig b/foo.c
> index 2fbce8c..7498f36 100644
> --- a/foo.c.orig
> +++ b/foo.c
> @@ -11,7 +11,7 @@
>  				alloc =3D (nr); \
>  			else \
>  				alloc =3D alloc_nr(alloc); \
> -			x =3D true; \
> +			x =3D alloc; \
>  		} \
>  	} while (0)
> =20
> @@ -31,7 +31,7 @@ static inline bool st_alloc_nr(size_t nr, size_t alloc=
, size_t *outp)
>  		size_t alloc_grow_new_alloc_; \
>  		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
>  			alloc =3D alloc_grow_new_alloc_; \
> -			x =3D true; \
> +			x =3D alloc_grow_new_alloc_; \
>  		} \
>  	} while (0)
> =20
> @@ -44,7 +44,7 @@ int main(int argc, char **argv)
>  	for (T i =3D 0;; i++) {
>  		for (T j =3D MIN;; j++) {
>  			T alloc1 =3D j, alloc2 =3D j;
> -			bool allocated1 =3D false, allocated2 =3D false;
> +			size_t allocated1 =3D 0, allocated2 =3D 0;
>  			ALLOC_GROW1(allocated1, i, alloc1);
>  			ALLOC_GROW2(allocated2, i, alloc2);
>  			if (alloc1 !=3D alloc2 || allocated1 !=3D allocated2)
>=20
> then you see the differences. For negative values, yeah, you end up with
> big size_t values. But for an unsigned type you get different small
> allocations.
Good point.  For unsigned char I get differences starting at 156
elements, here just the first few:

unsigned char nr=3D156 0 (155 -> 0) vs 256 (155 -> 0)
unsigned char nr=3D157 0 (155 -> 0) vs 256 (155 -> 0)
unsigned char nr=3D157 2 (156 -> 2) vs 258 (156 -> 2)

So the current code cuts the allocation size to 0 if you have an
array of 155 and ask for more entries.  That would cause a buffer
overrun.  With the patch ALLOC_GROW actually grows the buffer.

For signed char I see a different failure mode:

signed char nr=3D71 18446744073709551489 (70 -> -127) vs 129 (70 -> -127)
signed char nr=3D72 18446744073709551489 (70 -> -127) vs 129 (70 -> -127)
signed char nr=3D72 18446744073709551490 (71 -> -126) vs 130 (71 -> -126)

The current code tries to allocate (something close to) infinity,
which would terminate the program.  With the patch ALLOC_GROW
actually grows the buffer.

I don't see this for int and unsigned, though.  Weird C integer
promotion rules hit us here, I guess.  Just this, as you mentioned:

ALLOC_GROW1 unsigned nr=3D1787844770 1787844770 (1787844769 -> 1787844770)=
 step too small, abort
ALLOC_GROW1 int nr=3D1787844770 1787844770 (1787844769 -> 1787844770) step=
 too small, abort

The demo code is now big and hairy enough to need its own
tests, though.  *snicker*

Ren=C3=A9


#include <limits.h>
#include <stdbool.h>
#include <stdio.h>

#define alloc_nr(x) (((x)+16)*3/2)

#define ALLOC_GROW1(x, nr, alloc) \
	do { \
		if ((nr) > alloc) { \
			if (alloc_nr(alloc) < (nr)) \
				alloc =3D (nr); \
			else \
				alloc =3D alloc_nr(alloc); \
			x =3D alloc; \
		} \
	} while (0)

static inline bool st_alloc_nr(size_t nr, size_t alloc, size_t *outp)
{
	if (nr > alloc) {
		size_t out =3D alloc_nr(alloc);
		*outp =3D out < nr ? nr : out;
		return true;
	}
	return false;
}


#define ALLOC_GROW2(x, nr, alloc) \
	do { \
		size_t alloc_grow_new_alloc_; \
		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
			alloc =3D alloc_grow_new_alloc_; \
			x =3D alloc_grow_new_alloc_; \
		} \
	} while (0)

#define COMPARE(T, P, nr, alloc1, alloc_sz1, alloc2, alloc_sz2) do { \
	T orig_alloc1 =3D alloc1, orig_alloc2 =3D alloc2; \
	ALLOC_GROW1(alloc_sz1, nr, alloc1); \
	ALLOC_GROW2(alloc_sz2, nr, alloc2); \
	if (alloc_sz1 !=3D alloc_sz2) \
		printf(#T" nr=3D"P" %zu ("P" -> "P") vs %zu ("P" -> "P")\n", \
		       nr,  \
		       alloc_sz1, orig_alloc1, alloc1, \
		       alloc_sz2, orig_alloc2, alloc2); \
} while (0)

#define COMPARE_ALL(T, MIN, MAX, P) do { \
	for (T nr =3D 0;; nr++) { \
		for (T alloc =3D MIN;; alloc++) { \
			T alloc1 =3D alloc, alloc2 =3D alloc; \
			size_t alloc_sz1 =3D alloc1, alloc_sz2 =3D alloc2; \
			COMPARE(T, P, nr, alloc1, alloc_sz1, alloc2, alloc_sz2); \
			if (alloc =3D=3D MAX) \
				break; \
		} \
		if (nr =3D=3D MAX) \
			break; \
	} \
} while (0)

#define COMPARE_GROWTH(T, MAX, P) do { \
	T alloc1 =3D 0, alloc2 =3D 0; \
	size_t alloc_sz1 =3D 0, alloc_sz2 =3D 0; \
	for (T nr =3D 0;; nr++) { \
		COMPARE(T, P, nr, alloc1, alloc_sz1, alloc2, alloc_sz2); \
		if (nr =3D=3D MAX) \
			break; \
	} \
} while (0)

#define CHECK_GROWTH_ONE(T, MAX, P, ALLOC_GROW) do { \
	T alloc =3D 0; \
	size_t alloc_sz =3D 0; \
	for (T nr =3D 0;; nr++) { \
		T orig_alloc =3D alloc; \
		size_t orig_alloc_sz =3D alloc_sz; \
		ALLOC_GROW(alloc_sz, nr, alloc); \
		if (alloc_sz < (size_t)nr) \
			printf(#ALLOC_GROW" "#T" nr=3D"P" %zu ("P" -> "P")" \
			       " too small\n", \
			       nr, alloc_sz, orig_alloc, alloc); \
		if (alloc_sz > alloc_nr((size_t)nr)) \
			printf(#ALLOC_GROW" "#T" nr=3D"P" %zu ("P" -> "P")" \
			       " too big\n", \
			       nr, alloc_sz, orig_alloc, alloc); \
		if (alloc_sz > orig_alloc_sz && \
		    alloc_sz - alloc_sz / 3 < orig_alloc_sz) { \
			printf(#ALLOC_GROW" "#T" nr=3D"P" %zu ("P" -> "P")" \
			       " step too small, abort\n", \
			       nr, alloc_sz, orig_alloc, alloc); \
			break; \
		} \
		if (nr =3D=3D MAX) \
			break; \
	} \
} while (0)

#define CHECK_GROWTH(T, MAX, P) do { \
	CHECK_GROWTH_ONE(T, MAX, P, ALLOC_GROW1); \
	CHECK_GROWTH_ONE(T, MAX, P, ALLOC_GROW2); \
} while (0)

int main(int argc, char **argv)
{
	COMPARE_ALL(unsigned char, 0, UCHAR_MAX, "%hhu");
	COMPARE_ALL(signed char, 0, SCHAR_MAX, "%hhd");
	COMPARE_GROWTH(short, SHRT_MAX, "%hd");
	CHECK_GROWTH(short, SHRT_MAX, "%hd");
	CHECK_GROWTH(unsigned short, USHRT_MAX, "%hu");
	CHECK_GROWTH(unsigned, UINT_MAX, "%u");
	CHECK_GROWTH(int, INT_MAX, "%d");
	return 0;
}

