Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CF274B37
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385289; cv=none; b=uxAIt3c2YJc/lnHH3TbkmL1+/3QNkT9MtJEw9D+V/cvgrLxPZkzDqyMaCJ4ZTslqpxjdXD2fyTs1ndQXi+GQgNIo3UOOH7GNthUFXAeYFsC910Cq3vruWqipenEtq6gTZLwQz1PQT1RUYfJl9iebe+yQnxbeF597S57JJ5p0ueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385289; c=relaxed/simple;
	bh=0IaFyUG6MOMqTeoUNVgwunNpp+fz4JXTv/CaM/7OD5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjiVHZvUXekF+09hjtsta/421Cms1XfTE5F2kj4U1YaRA2Cs9ulF7gaMxN3ONiLSsoRfXu4opw6c8KrFUOHXXvYRvWTDrlF0Z8TL1e6G3QcVYkEyA4L64BGt/I1IU5dw1k2lnB03HQy+BkYhvMrlaD1gZW1AQNFCa2/BxOtLE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=RqSsHCHN; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="RqSsHCHN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751385282; x=1751990082; i=l.s.r@web.de;
	bh=BVKakepg8Q4IrfBoZQIYGM5kSIDp7PRdvfbvynVbmYU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RqSsHCHNCfZUWv8Pik84ojwwG9TycqYaB4St12T1G4lLn46vn7mu+tFgyQ9jwzkC
	 7Wo01aiiXxlMCRTAFLMUamOjNe68cOfUwRWMiHHoOBm00idLwHqd8rcIhBSob+Cw4
	 m1tcYclmsfXz/gMuxAltnFPtR1mqoB3dnO+s+zBdP0gtsZja7jj24sDdKlaEoHAei
	 nsh1jYb1coPfhBL8gRp565KPlr5DvaUtlEA2dYh7x4t/43x2bbD2a6Qb7UA1fNwTl
	 OKKt+a2U98018h3iD8BC7FOQsirxuvFjJ5MnJODHQoHNfWYkz6EDD9+WzgYyr677M
	 fw3QD9ScwXk/jmo+rg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1uyrL21QgY-00hIam; Tue, 01
 Jul 2025 17:54:42 +0200
Message-ID: <fb50bdea-f529-447a-9cf1-0fbde3f8e22e@web.de>
Date: Tue, 1 Jul 2025 17:54:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] parse-options: add precision handling for
 OPTION_SET_INT
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <3690df99-8a83-4377-9b03-6766f7958c21@web.de> <aGO-l81JiOESvbS9@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aGO-l81JiOESvbS9@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l65Ueso+Gs4BJwwMMUZwVaIgmJ26Ou4SD+vckKVsRuntXMyFKTJ
 hFmh6mVj4Fp10QXjlk4lN1pPr5FBhwV/ZqxgwofFgAIgf6zdHf12MqEGfjOGavmUU4RHHcG
 JmHYTYfwZkwQ6TfKmzmiTuKTuNxOnaeMG1MovGv47H67zeq6A8OpbkHVM4sVCWWe8dFgY95
 2xpTRIsdGMMI6haRX2g9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p+GihLwgEKU=;QvQVbEf1GvhS5j7tPtSTK7e261t
 8RnXhX1pt5My2s8WQINUdGEucIrDXv6dkc/faJgn5q5pWvRZARMTGsTyYkb7i8xHn2wuDkpKu
 76L9kGY57wMJ+Ry8m6jjoOsKcMjSyygWFPT9xf84J5S7T+vV5uzb4OJON88OrXY2iR60Qqxrq
 Y6iQjG7YUluU6QxfaNGpFw5ACNSCsEXEHfAK1s2EzpAo8OE6g5Fq71cg01JrXQSgFqsYhsS+b
 NV9Z3L7qEh53dk775g5vphuiKN23PRBjGOEpYg5B3Qf80ZrtCom5dKudVAHCattszD9R6iEE2
 JsvzuO2zSdwaBuW3mi58G8eYH48acRT5fYYBB5wDc5LQxfDMte5RUOi0DR0yv+zKzXs8s4qOt
 WlicCHlTxJm0w1rgEUvep7zBioz07NWi9Ut68XPKQmMBjVy9BorG/IpqQ0KMZUJgwZKUvvmdF
 M4XigKtj2AJEkYK0APZIvYu9SshOIrGyC8iNGxNvqFque4aW5/OSDUPwvd0ckNBw3MJFBX/PL
 a9+Y/zOCbdQtYvXCTE9FKDR5/pdTKbIVjCLX+NiTxyIqgJPK5ehAa+4UG9RI124XBeMZGCeuT
 Bx5Uhr0QGWLUhhS495riM13GYyRxuAkyR2e5DaInlEki/kus6dsrlkaj6SN93iZL4LmKgJd3Y
 hBVJqWtzTNXwSZ75Fnl+yEecE1tpIDphj6PyZrxhVT0h9AtHHeQosuCE8VvxezsM+IuasPvZs
 TVcKODRaLstWTCrevz+3+tIJxvXZnsyIZoa8CY1w16UJfboZjxYPuaEInr1vP4kOjQwa3wZuV
 AZn7uaIV/r2K5R0okptqdCzE+HcJUZl4oA/KKx2XFcqeqBDNeXtviO2hovx/HmsxLlxHYB8sc
 Cu7P9pbQ5Wbc7kWqPQlL5iWD8pn1nJG9Uk9OSszuisr5ZmEhISxBd7XYvlDno07zCTE73IeD3
 LPKVAMzsN+GcFlzKtU3MUmAqHbs4KKdrdDdwyHJhUhpbOj5GZOIF/nsd7FHOcZOv3sXBui06/
 vT7GM21K+O3ce2l5jMhxjBNqUQPS8mobyVBbtBaU8lEPqPLFiMK+2qmogAtvnBQ4LpAFiPZbJ
 MI8B9NmMG8GFBDaibYTqlBYkZxZjOvwsiNemnzERjWy3fypeiRuQYDN7kmNuARc+YjbQR+Kbw
 Q9Soh1x7zpxv5yGA9vzQ63NQUmLCTrOxThRwL2zXQk0wPbjr4HkwGKXvN2OBQskAxLcJaaf7l
 wZ0zabNPCrL3eX3Z/g/+BTWMp5Et8NtrQ19UqBJWXQCorQVx6rpUAToTUiYvWunuc+V0DD00d
 jWJ9pLVK0uyGhgsveJAv5XEad6SaYWhdN8SEzF2VzRUzsZw489fkawpEHlizDeMYUZ3neoJBN
 yWbsa1cEJKP6cBHjHGOsAuYfC8r++Novo4/ZTsD7U5Ll5oYhrYXCiiAS5JkdeaHvGeCsdrEaZ
 QxlGbg5R5Y+YPbHyNVYdoXPMAn3hFXjyN+uNmw1XG1UHjUZp0GbXzAzzLhAIUOp74MKopiQS4
 ouq9otSiF0gaBRu4N2hX82hzjCNf99AztH0SmSGgE2pmJYnSvB1ARgn2Z82yhDNMlVDn4OLL5
 sbUJOUenAekFsu+/atq1FZYEuM6H0lzBapW/M0n5VLVkvq+b7yKuLQ+yllhv6Xk5duuCcR6VO
 xSGm36fpoUQKRKXJoSSiL0XpxJ/xvK8aZK+i5RM3FAH4nfGNPjXGngDgl5ckJWCwMtyMDRKir
 8pF9mRbkDrs3jT/AkFm2BQm2cFUqUx4zHoOOvySW+snHNG4VECTNSG5AyWyCN78Zd8EdWzrvT
 2nqhp4yqfm4SDRWNUCMk0cukom+QjMgbB4ixyqtsQ0VCeQ1itXTgML6VgOm0+kKolGIk9nHYD
 7JAYgECJPMcNl1AvyamnXE6ugD7fhSIzgr4G1GOwVDmcTnG9lI1dMm5s1kVcejBpxnFLyhKfb
 VujXfXwpn2GxexDOwsu/W15YQy9rmbhteLyqmSxl1G8QWB4v+16a4VDRWGt9wN89Rhk9/6lXJ
 11e75sBG7B78/0G/49Mlypac/UeH5+WoLZl8PGRmonznmx6Bci4N5a4E5x3RlvkFWT6jH2mEd
 Z6EgCY+scQbPgZKbyYrvP9WBR0FTA8EUstwrymZx7fmXWgTpmbCh2eEtiO4gJsQCM5wWFTxof
 K4CRkRDVqa1sQimIllK0vGS0MtbgG0Zq0GshA3A68hRy40iRUDiZHUfCXsI5sL0TLtNijA/bI
 RdHZQ9sLjc+lCVsNaW0AHSOxETuw/ClzvGuUbEs36fn4fxuD8A8sqk815bZSiJ/9bvVckP9WQ
 qt/SU2R+pBLUd94DsevcTC5zy0eS121Jf+W+j54EJoyGHMQdfEIDDjGoyjVM5Y2QnSWYx4wGx
 e67npyAW++gD4CBhH9fHn1k/VjT8mhSeITMJSpGnOEXKtZAkB/ZzbpnkBpB2+6Oq3WdjD6ZOd
 3ZatbuXpgfFv6VBvQS4oh5TlGNgR8I3gZmpg0LoYaEXnjWLH6ko+E5vaY9QEXRzJ0xGv3cSPj
 lVNdkx6hfrnrEuwMj8qthlVlXDa8u7YAY8VjcYtAiD53jNjrYilgkUrEat5OR0V98GLBf7VHV
 TyNf1KrvryPf80wFLF8ogG5DNvgXeL4bdapSzmD7L2GUAOz42TOphYwWloWIKqnEWvqHh9J4t
 7Fweu5SSCJm8HY8XORMGYTm9JTUMF9Z0DYOB+MUZHgs6fRmO+EDyWA2/lHNoOAZrJUsngLoIs
 AHU2WQH2S4YdQ3tIEdaSWNL0GlP3TMNdjduYSRrCeP/Q1PHYIFp0ulH4t/Hm1an18/Q3DIdhS
 MqYlUGXQudU1hPcH4r/XbYuDaXhdc/UCQSrJrkdJdiOh2dm+ZXuJFFs7oyT/mVi7cJoN+fG3f
 0HaZl4dBFV2XpzrQjDuv6JaUTEmviNjy39V4sC0DtzVts6fEtMblJdAbTNCwYgKm56Hnov2dd
 O8Ala8E2DD8HXTaiXKgaV46nM9mZ3Uf4nWEpsMHKrQ9CMrq6ZL2wfXUCAKN/no6NF4xyKooXi
 JrHLmlHLw40HvK3QEQE6vvPWOxbwxOOWQcLlq7szEqKR/RokcEzxW0jqRn7eJUbxsjhu5nSt3
 NMgcU7uXgVTJrXNVjgLZufJRmO0nUez15WHrhelHzBVKYmp0O4g28gQiObaK13ZnJj/XPtpTe
 nlGqds2+eoY0DEtvENCp4i4UScldYRAchwopYStkXFx76iJ0XG5hLX60N9uviM41sE88PXRfU
 +SvUvbyahlbdm2uf+XCS8/lIQzEKFnIfm+58RJgzSYtqjhJnWPhiWhQ7lRgzgDXEMUOFiQ+gF
 aI56rOfUFQ2+dblR2IYTXK/HdLB4cfBIBH/qaYw5tRz3tYEEy2URvOrPhpYS3Zr9UIy0cxjtM
 SA2TveDiQ0TPj31rM/yw==

On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> On Sun, Jun 29, 2025 at 01:50:39PM +0200, Ren=C3=A9 Scharfe wrote:
>> diff --git a/parse-options.c b/parse-options.c
>> index da07a000a3..bbb68603cc 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -85,6 +85,36 @@ static intmax_t get_int_value(const struct option *o=
pt)
>>  	}
>>  }
>> =20
>> +static enum parse_opt_result set_int_value(const struct option *opt,
>> +					   enum opt_parsed flags,
>> +					   intmax_t value)
>> +{
>> +	switch (opt->precision) {
>> +	case sizeof(int8_t):
>> +		*(int8_t *)opt->value =3D value;
>> +		return 0;
>> +	case sizeof(int16_t):
>> +		*(int16_t *)opt->value =3D value;
>> +		return 0;
>> +	case sizeof(int32_t):
>> +		*(int32_t *)opt->value =3D value;
>> +		return 0;
>> +	case sizeof(int64_t):
>> +		*(int64_t *)opt->value =3D value;
>> +		return 0;
>> +	default:
>> +		BUG("invalid precision for option %s", optname(opt, flags));
>> +	}
>> +}
>=20
> The function only ever dies or returns successfully, so can't we make it
> return nothing instead? On the other hand it does make a couple of
> callsites a bit nicer to read.

We can.  Not sure we should, obviously, but I don't have strong feelings
either way.

>=20
>> +static int signed_int_fits(intmax_t value, size_t size)
>> +{
>> +	size_t bits =3D size * CHAR_BIT;
>> +	intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
>> +	intmax_t lower_bound =3D -upper_bound - 1;
>> +	return lower_bound <=3D value && value <=3D upper_bound;
>> +}
>> +
>=20
> Should we s/size/precision/ so that it's clear what kind of size this
> exactly is?
It's the width of an integer variable as in sizeof(), so the name fits.
We can inline this single-caller function if it's indeed confusing.

Ren=C3=A9


