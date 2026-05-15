Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862C339872
	for <git@vger.kernel.org>; Fri, 15 May 2026 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886070; cv=none; b=FzKQneCllEXDISGRDqNxEcj7ZfThzxTiPwFWD7hNLhfqDeJSVub3addF5/YWLO6pvlCg4oRoRmpjSWQtv4ujgsVVy/RQbfKPZ9FlqZmVPryAdIMvaR9/EvyhnkOePrCimMog4/clxc4xxNiT7VuY0bHBbBZ40qQvVBaGrRJavZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886070; c=relaxed/simple;
	bh=rEaao8kKadAInkzXFUdiEF4Uco+Sq6r6EPO/ZqGhP5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+0ZP1xavb1+NAWaCwWN3uBnLg6ic2tmwlbLqtT/Rs005zks76ftn+o/OYVj53ohd6Ws4hcgSuYoOezSFAJ6nmcVRGFGde0E3Lnpf9Vg56IiRmsQ+zdibS/IT9zc1zTxSEjPPMfpNUWp6+kPng+TogHybxo1eKuziFJ5488Lr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=qPXmQYyi; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qPXmQYyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778886066; x=1779490866; i=l.s.r@web.de;
	bh=AuOB1oiy21IA6AWAoiF3yuEYXd8MCXDfwsO3awJMWVs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qPXmQYyiBEvAIQqhnysddOREZRNF2gCvlsaffxh3xM30JdFC7D2smtJEG+OhL2MQ
	 HW25nFX3HOX79llAkx00PgDYCdT93bE+V/J3pp31obXlmbr7ZcznlODmojpmCKaMP
	 wv2A9Uz6wYvOGH1zUq41B+Fj8bKASlykWTHxQjScXzxCtK8UBjwJnTTtZm+I6iFOg
	 Y/aH0xz7AH4+Q96YdqyDPWkfg9O8pYzRCcwKWt1xdXIsNjyPJxlwViGt+69fzbazN
	 LDOERNpuBHijGdzwhX8fWzABrpF03n0HgG63ho0FklkUIUkQsjge09C/ds6edfLr9
	 1tJ667NSWUEnaMeW7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbms-1xD6DE02ys-017NdS; Sat, 16
 May 2026 01:01:06 +0200
Message-ID: <1d79d7bc-5441-4e72-9cb0-e8900f57172c@web.de>
Date: Sat, 16 May 2026 01:01:05 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260515195049.GA149960@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:54EbICXL/as28yMgtuSxu9HvK2FLrbJE9KYCMuYdQMnbtXRcwAN
 ups40LgPax1WackFXYV7VDOyuFMJvVhRmPUV6N5B1CIOV56cEOo7s0zYDN0t2mpD6yMR69v
 ishwueanWzJ+w/CTcL7N1ag36XHRS4rkeW0UQ7Ged1NgGZWsog3hT/oWM+0i8rjTEOl83OG
 K9e2KNqIgfSL6FeJ//Gyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PTr4Vbc/Ec0=;Q09JBbCedCfex54cWd+C4SNz69t
 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
 R3jg9krm0HD/+y4cPdP3oMfVf+RlvTqJp7Bg=

On 5/15/26 9:50 PM, Jeff King wrote:
> On Fri, May 15, 2026 at 03:08:18PM -0400, Jeff King wrote:
>=20
>> On Fri, May 15, 2026 at 08:16:50PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>> +		size_t alloc_grow_new_alloc_; \
>>> +		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
>>> +			alloc =3D alloc_grow_new_alloc_; \
>>> +			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
>>>  		} \
>>
>> What happens if a caller passes in an argument that isn't a size_t?
>> We'll check for overflow in the size_t space, and then truncate it when
>> we assign to alloc, I think.
>>
>> I think we generally try to hold allocations in size_t these days, but
>> I'd be surprised if there weren't a few "int" holdouts. Grepping around=
,
>> alloc_node() seems to be an example.
>>
>> BTW, non-size_t arguments nullifies my earlier hand-waving around "nr +
>> 1 overflowing implies we've filled up the address space". But we are
>> still protected in the existing code by the:
>>
>>   if (alloc_nr(alloc) < (nr))
>> 	alloc =3D (nr);
>>
>> logic. But with your patch, that all happens in the size_t space, so I
>> think it would actually introduce possible array overflows when the
>> caller is using a smaller type.
>=20
> Hmm, playing with it and looking a little closer, I think we don't end
> up overflowing the buffer because you use the size_t for
> REALLOC_ARRAY(). So the result is big, but then "alloc" is truncated.
>=20
> And then on the next call, we think "oh no, the allocation is way too
> small" because we are using the truncated value. So we try to size up
> for every single allocation, even though it's actually big enough, and
> the program slows to a crawl. ;)
>=20
> For reference, IU was using this hack to play around and demonstrate:
>=20
> diff --git a/git.c b/git.c
> index 5a40eab8a2..638bbc69e4 100644
> --- a/git.c
> +++ b/git.c
> @@ -969,6 +969,19 @@ int cmd_main(int argc, const char **argv)
> =20
>  	cmd =3D argv[0];
> =20
> +	if (!strcmp(cmd, "foo")) {
> +		unsigned char *buf =3D NULL;
> +		unsigned nr =3D 0, alloc =3D 0;
> +		for (unsigned i =3D 0; i < UINT_MAX; i++) {
> +			ALLOC_GROW(buf, nr + 1, alloc);
> +			if (i % 313370 =3D=3D 0)
> +				warning("at i=3D%u, alloc=3D%u, nr=3D%u", i, alloc, nr);
> +			buf[nr++] =3D i % 256;
> +		}
> +		printf("done, final nr=3D%u, alloc=3D%u\n", nr, alloc);
> +		return 0;
> +	}
> +
>  	/*
>  	 * We use PATH to find git commands, but we prepend some higher
>  	 * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH
>=20
>=20
> The same problem exists in several places in actual code, but I'm not
> sure how practical it is to trigger. The alloc_node() is counting not
> just objects, but blocks of objects. So you'd need 2*31 * 1024 objects
> of one type, which is probably going to run afoul of other limitations.
> Other cases are similar; for example "yes | git fetch-pack --stdin foo"
> will grow an array indefinitely, but at one strbuf per line it starts
> swapping on my 64GB machine at only 350M entries.
>=20
> I think as long as the behavior remains "slow, but we do not overflow
> any buffers" when you reach these limits, that's OK. Nobody is going to
> do it in practice, and we just want to make sure that malicious inputs
> cannot get out-of-bounds writes. It might be worth adding a comment,
> though, to make sure nobody ever swaps "alloc_grow_new_alloc_" for
> "alloc" in that macro.
There is no overflow check in either version (yet), so neither is safe
to operate close to the boundary.  Close meaning the intermediate term
(alloc + 16) * 3 being bigger than the maximum value.

Does the size_t arithmetic make matters worse?  The only change I can
see is that it interprets negative values as big unsigned ones and
then doesn't reallocate.  The outcome for positive values is the same,
overflow and all, no?

Here's a demo program exercising the arithmetic part of the macros:


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
			x =3D true; \
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
			x =3D true; \
		} \
	} while (0)

#define T signed char
#define MIN 0
#define MAX SCHAR_MAX

int main(int argc, char **argv)
{
	for (T i =3D 0;; i++) {
		for (T j =3D MIN;; j++) {
			T alloc1 =3D j, alloc2 =3D j;
			bool allocated1 =3D false, allocated2 =3D false;
			ALLOC_GROW1(allocated1, i, alloc1);
			ALLOC_GROW2(allocated2, i, alloc2);
			if (alloc1 !=3D alloc2 || allocated1 !=3D allocated2)
				printf("%zu %zu %d %zu %d %zu\n",
				       (size_t)i, (size_t)j,
				       allocated1, (size_t)alloc1,
				       allocated2, (size_t)alloc2);
			if (j =3D=3D MAX)
				break;
		}
		if (i =3D=3D MAX)
			break;
	}
	return 0;
}


