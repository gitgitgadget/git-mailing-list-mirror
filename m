Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C77F9
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711279038; cv=none; b=sHPv6ErdzDebKxhB9t4t/o/+JZPLMp41UeLM858w916Uj0aK03CqMIpIB1zwcX1OjiU16cH8fzy5BlN2+mq0UAA5CRWtyOcxqlQ0iSjErheIQsbF2kJwgZZxmCLakBmDp6OeA68rSeD1YLql6llUl2JodEg+KJbFHwXJ1n2NRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711279038; c=relaxed/simple;
	bh=lN0LcpBNtmkOUDZ+h3VpambVQjhgEEM/cHHIoAMEGjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAk3f5sQkI2E7LWE1XKYyjYFDpxzDt2m2i/IscBvl9AP9b9zAN581GF10c4scAaqk6lVuTXDuv2QYZQTy/uHl5a9lgGtpAB/nSHWCPptg02T65cyfNmDaBCJgD943PPhtY7BHgYhQxrnrooFjuRMdzj6+KJvSeGK7Btt6J7Xwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JzmLDXeN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JzmLDXeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711279032; x=1711883832; i=l.s.r@web.de;
	bh=rOVC+PYtMKk43XsTy2R8xOB20+5eEm9thNf3uJs4PjI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JzmLDXeNsuDw6LSjYI4RKXVC7Zv9tqiviXOmAL35bZa7r/vRGmh7P9QC2eHi7h1k
	 xz3vgxCAUUcSV5L+kvoS9jGdl1XLbzgIDMFaSkH5yHPyWZYXEPxwaCTqlh528D3a6
	 PyHAGoUuvF2t881xN+scI6hXGx+aevzhtn3uL1LYKe8ITfdwhBGiitsPfCFxkJClD
	 AR9YBJvqhSmZBEV+kvsaW6qL3awxNfN/QvnHUeOA8DqiTsnrkLzCBsb/stIx48EtZ
	 Yso903WBKN7nOX8RORLhIVq9Fkji0A4GYdzohhQTQn58+4gGNAffuN21TiQ4hvdW0
	 kYxbXtbJrUjg/RWUkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmm4-1s3FoE2LOY-00Eqwm; Sun, 24
 Mar 2024 12:17:12 +0100
Message-ID: <67aa076b-1a73-45a6-b727-6416963a1bd0@web.de>
Date: Sun, 24 Mar 2024 12:17:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] factor out strbuf_expand_bad_format()
To: Chris Torek <chris.torek@gmail.com>
Cc: Git List <git@vger.kernel.org>
References: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
 <CAPx1GveKUL1nexRQDYueAVU7G0vp+JzB=5yUf4r4eoRjU49Jcg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPx1GveKUL1nexRQDYueAVU7G0vp+JzB=5yUf4r4eoRjU49Jcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iLjAdGcSihPocKHf18woeyH7Yw4akay9DFLcCtjJwAi7fAPFp1P
 2nAw2LJHfYZl6NIwL0G/iOzbOv+KRmxTXr7SqJLCxy8wqq+seNUbS5O08J7gayrniT7l0ff
 1sxvrqJ1vGivMv7b/c8N/Nc/GU513SuxFl8P0aK/10koqJU8ptXwc+TAStXVp//o6l91jnA
 I2IfBg8BmxPzpFhWv63pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e7/7gMyqPs8=;u0XeUoeEgm3PN3UimCzRA2ajl4G
 Rhxqh4yBoBgXG9Z4TFa0WFQKfAZyxgtA5M3Bv5oRiV2yqCshSDUdJ2alIo0uIo8eGMvmr7Jix
 y9QMYsMJwLzgRf83ertKU0fn/HL4O01d4W81GGnTBwHvB6Ze1+OZwF3J74Mk5eebmQV+27fZt
 XCqJVhbYFb8KopVEdG3H9sCnMEOGQd2esRAQ5Q/NTzmPul2x+bKFNQlyfLgJx6Ord5a4h26Q6
 1qBTRJk4y25CsecYwSDJ5J3cBMp4ifKLfhPZP2XfDNfCXLkeL+Jo4ZHNCn21WvIkaatkujLOr
 vKtwYhKjuWFYwScXb86u12i8claT/YsTs1E26g0VVe2QR1I6wEY5RXYja8IO+VUg4TWXfGnJk
 h0tyCqF3ktZAqvYKZraMrE3Q3m3oKA59BTWdVWxR9UUWYLdXGCsYI8/A2ZPz7rID6R59JvlZ7
 Ofcc8Qc4QYrhnCCdPY27dDhuzezkNZwY1hclfUu3I3DqHBtkFXVp8BJrd2YCxpnX0v41V3FgT
 K3hdH25etDPZFecA3wK5M/Lh+AZpEDzNAAWMcs7BF/Z3Yw5rcQliajYIFxme4Uqz7uTlwxsbM
 pqAX7H2+WnG4ue6XHuGeUVdmf4SDwosUKiNmZifNnHfhlLrscsofejC+ojJ9/IdmFnY6+gnuD
 ZBtWGmnzpmQUYV/XqfHXjRi0STq9+celItPAJ9Do6EHHeq45jAz9+rdzdc8bS+WP51zmFW9KB
 3MguHO4ileriS0HUhvnYLTAaEqQCc19l6b8h2sRcG+yQF0ndTsy8GSNBrHcm56ywjJlOoej5b
 MQq7dmDyZn5czfeX6EeidJakivOilxLWLg2VfPFuLy10I=

Am 24.03.24 um 10:00 schrieb Chris Torek:
> Minor:
>
> On Sun, Mar 24, 2024 at 1:00=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>> @@ -308,8 +301,7 @@ static void show_ce_fmt(struct repository *repo, co=
nst struct cache_entry *ce,
>>                 else if (skip_prefix(format, "(path)", &format))
>>                         write_name_to_buf(&sb, fullname);
>>                 else
>> -                       die(_("bad ls-files format: %%%.*s"),
>> -                           (int)(end - format + 1), format);
>> +                       strbuf_expand_bad_format(format, "ls-format");
>
> This last string constant is clearly supposed to be "ls-files".

LOL.  Seems I can only hold one f-word in my mind at a time.

Thank you for catching this!

Ren=C3=A9
