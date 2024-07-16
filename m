Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638B19A86A
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147613; cv=none; b=m+5e14zgaRILbNCYRxmd3XuvcTkU/XHLvnXl4CXFWSQKsPAZmMHXMVFVf29Zkz7tVUhbiQ1KZs0O9HqQtZ1mtjZuA/mi6GJZ21IZFbuUj7iLU8HaOcpr3FDWkIhUTXbJN15l+H7v3a9zV0oITZdISmCf9pgyvlWwcCscivz13t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147613; c=relaxed/simple;
	bh=DvKpPjNwMDyjl5QRUiKOO3zGgsONQ9C3wID4nZ/5vMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GeBJnw6xqRS4nKJtsAqYMf6jUDg/RK9OmN+RmSChN2fnNstbxIcDhXqTGapsv08ITUFuE/VJWnOw+4iWOUh3+ioPhK0t1gVKPdZDJzN6VFY3Vpwi/8UFe+vAI+7xOpNuPqsi4D8554OlcGoniHhyeFBznR2W7Tgylk2M2Kc24pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=snPS9pF/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="snPS9pF/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D1D935503;
	Tue, 16 Jul 2024 12:33:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DvKpPjNwMDyj
	l5QRUiKOO3zGgsONQ9C3wID4nZ/5vMs=; b=snPS9pF/QwtSVPTIDH6edB771k0o
	NsPVPMXPI6gk9/PBUEnHsaZ1NKcK2JtHmHLH4A7v+hq/dILK8VVFAcm/5MRinA2D
	dK5EI9iAtSLBJ2XcYVyrw1+tPC8Py7kktF7wiwuiRoGuuxV2qkYGiV/9K234Y62g
	Ne4tY4/rd+a5JdY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 44F4F35502;
	Tue, 16 Jul 2024 12:33:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF28135501;
	Tue, 16 Jul 2024 12:33:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  Git List <git@vger.kernel.org>,  Patrick
 Steinhardt <ps@pks.im>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] t-strvec: fix type mismatch in check_strvec
In-Reply-To: <1521ed89-989e-452b-b7fc-9e73672e0764@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 16 Jul 2024 18:14:35 +0200")
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
	<5bbef273-382e-4096-9ca6-d74781223e55@web.de>
	<20240716043727.GA1429885@coredump.intra.peff.net>
	<xmqq4j8pcqji.fsf@gitster.g>
	<1521ed89-989e-452b-b7fc-9e73672e0764@web.de>
Date: Tue, 16 Jul 2024 09:33:25 -0700
Message-ID: <xmqqbk2x9u0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 208EF81A-4391-11EF-90D3-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Cast i from size_t to uintmax_t to match the format string.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Oops, sorry about that. :-(
>
> PRIuMAX is "lu" on my system, so the compiler didn't flag the mistake.
>
>  t/unit-tests/t-strvec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

The fix is of course identical to what I added to the integration I
prepared, but the line-wrapping is better in this version, so I'll
replace ;-)

> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
> index fdb28ba220..fa1a041469 100644
> --- a/t/unit-tests/t-strvec.c
> +++ b/t/unit-tests/t-strvec.c
> @@ -11,7 +11,8 @@
>  		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
>  			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
>  				if (!check_str((vec)->v[i], expect[i])) { \
> -					test_msg("      i: %"PRIuMAX, i); \
> +					test_msg("      i: %"PRIuMAX, \
> +						 (uintmax_t)i); \
>  					break; \
>  				} \
>  			} \
> --
> 2.45.2
