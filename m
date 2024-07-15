Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30521208A7
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062098; cv=none; b=O/BOvq28N7VuhO7V88X32qrcFM7o18aXPlrnIQkZk17uSYNBNiiHTzM9CrO2yXimMNAw5ro8NPi9CTIEwJ2F39B/IMsL/9evRVJnhLZs0Tb0YRF1HK9fIUdI0n02cawmk3m5TMX2x3ePaEL3bz4sotBWuRjrEsZFlGJCIjVtZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062098; c=relaxed/simple;
	bh=0evwAkjprxpELcC3q3ZmWEl+pvQ56KhvA5QziHgh68o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMNVoX3zHu6dw7Ryi9oZ4ttI1WGgp2qligxJbBfrwfW6mVSqepyfyCfbuChQRaDWWd4CalQ46IerA24C3a6i74/WmJq/KOo5aESpP9aJ+1nev3IKMfdCcYsQ6EGp8D3OhRJcyOnqbFAVV1fOeH7Ws7UERpNDE8XlYLPyYG2V5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AeFH1iGj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AeFH1iGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721062070; x=1721666870; i=l.s.r@web.de;
	bh=wKXxT4roa9BQqsIgPyzy7d08a94U96EypD0gpnQr+gQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AeFH1iGjjnqoyXK5vAGm7SqU+iS5tOiZl31Wmu1Yhb3zCdMTvmDYd0Qjp2UuKpE4
	 r+QewCTbIGmDGTVF1curURuST+mrDw/TqjjKVCthq3c/TxjzFQ01zOWgSOae3pV+k
	 Bcg66lSrVIfxq6j0PE8CcYHWwWaSRBJMDhHzB7Vy2mNOjuBHivjDsaq9XkOh2MSOj
	 iMF6Ta/799/IFzX7Lvjor6FI5fIgF7dEnRgIPBinkHH2QBSzRosf+y5sPdObFfvmM
	 pBmD9EgZDMWBDW1Un+JOLrUFJNLa9cEQee/Qg8ABYacSxmYcceKgpiGqFsmlmMJkj
	 ZInBfa5KRjqCyCaB8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1sjpoo23oi-00KNQa; Mon, 15
 Jul 2024 18:47:50 +0200
Message-ID: <bf7fd471-18fb-41df-a306-2413c9d441bd@web.de>
Date: Mon, 15 Jul 2024 18:47:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/1] t-strvec: tighten .alloc check in check_strvec
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
 <075b3d08-4270-4064-8103-1fece055e197@web.de> <xmqqjzhm90mb.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqjzhm90mb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r/qP9SzjWpo3/BUYqiDOKqYBrBfr9ck/FVcZAH6Mhon/ipHwyyO
 0aVT/haN0LZVPuDr/eI3FfZx/nX2phTG8hKaEOwizD451+7aPHujT6pT/gld8xaeOR60yod
 R41qZwh/Kw9PtnOJICJjY2AZWhTYc9chQkL6aleVeD/mckjyN4MbXMfi92BqCGbja2fMcjC
 TOIfDPgVYzxOcVwP640Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jz2dKp8drW8=;WC2yrRfcNh1qdlHrYSKwy7/rWhF
 LtX0Wrm8joTuHVcHpJAPYCeh4HVomelGHepQfaFJii7aWrMcmmLnDjvrAXDTDaVpvhZUzPjgb
 dHSnn0yeUeBJZgAwCRsl2mREWn6ZNr2nOqeblIt0xkDoXC8q+mrERet2488qh+Wi/AAZ4joZP
 /AAbwm++ngyZBLAmVyLDVvwpfusjZbHfZfa+cq/MZTk6DY0SDNhhQ7fP0JnR5d8M+FwhGmX05
 lYMe56wel9H5zEmZPT4z81rKd6Lt2GJVbX/QFpSLiRLULyuXAGueLzMLAXtUmGF6YHdmlzzMw
 PrGXjiV+SaJ289m6ZGdY9N8h2sfMTXkQtP/SOqnWyrsOcmJ9iMu4J5iJRJ0gbAgjS8elkt5UC
 he0W2w9gOikLjL5Gr1Z1MeDpL6RYBwfqBOfrLisnNXmRpy4yj1j7ArpIjMuFLElLNemU1ie0n
 dTi1qafk2ApdywJAqipeLYrASg3icR390ebaBr5BoNIJNQxLEsJ0G/zIjZKW4k2HwXIW34ZIi
 hXB7gxY51k72Qr2dIcVHfFNiKxXmbevS9pbDXBsZ56NCrEhbCaCNljEXu6mEDOtT9dJh9+ch4
 W/1h/Qmr9lSwSTjoKyse1NpeJrqDfqli4NyW8EJHyw9m9yPV8LehBPRzHhEb96A+c/eW8g/l3
 Cr90RkxjsZyokD7DGct5LPsO5lOao+ex1tFWUzdbESoW1rLckCWr7eBtex0JmA+54oh6p521f
 FEfilTQeWtdnhGZwbTYz1iNbBjJKIALO54lrD5sygyhOPIL+f0vdms/AC+IKp4EqWqlmJ7YM5
 HxPyRjvRmoukSUzabdy5g01Q==

Am 15.07.24 um 16:43 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
>> index fdb28ba220..6a4d425840 100644
>> --- a/t/unit-tests/t-strvec.c
>> +++ b/t/unit-tests/t-strvec.c
>> @@ -8,7 +8,9 @@
>>  		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
>>  		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
>>  		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
>> -		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
>> +		    ((vec)->v =3D=3D empty_strvec ? \
>> +		     check_uint((vec)->nr, =3D=3D, (vec)->alloc) : \
>> +		     check_uint((vec)->nr, <, (vec)->alloc))) { \
>
> Not a huge deal but with empty_strvec, don't we want to barf if
> nr=3D=3Dalloc=3D=3D1?

Yes, and that's handled by the comparison with ARRAY_SIZE(expect) - 1
above.  Perhaps comparing to 0 explicitly would be clearer.  My thinking
was just to split up the old <=3D check into its < and =3D=3D cases, witho=
ut
changing anything else..

>
>>  			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
>>  				if (!check_str((vec)->v[i], expect[i])) { \
>>  					test_msg("      i: %"PRIuMAX, i); \
>> --
>> 2.45.2
