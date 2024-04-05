Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83A16ABDE
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322649; cv=none; b=LSsQm0WqA12P9KoAhmZyk9L3niuzHw2i0/OE+seHV3CTO8UZ7I2KA02sTvB+oJezqsGPCZbT53nXwL5Xex66mX2Po9xfhmwNgP2m8mLOzLgpBh9EjaoXJHoVpC6ZoeE/UjNCiqDdQoXciTHZ4hWL3iUVGtE8JWsZZ7Kp7ReVll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322649; c=relaxed/simple;
	bh=8JnlqjdunIjn8iEu4OdGHS5J5dN3OD87Y9mp2wNE4sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZcViV83Cvtuu2otN0NcuZ26OrB5SnvPTLtE/OgGluC7iZRt9Upb6yHPD5fEAj4E80TJ3th4A2M8fxDT7XKmDVda11jVX5OAaWNIJgz/OdQNRePgo94Wx5RlBSvQiw4e6Ihw+e7xKAACLBrKP1ekrHWvchD69zJ9d3lfVN2vWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=pXzXiKt8; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pXzXiKt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712322633; x=1712927433; i=l.s.r@web.de;
	bh=oJ/l3ILes8sPC96lB21gxpuKmZdAQaESM+gFERjUUug=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pXzXiKt8TaioQTeA+2HejL1GwZjYT+E6Ncak/yT+PJS92Lf9B3h/WsGDeVrDvhch
	 zkLuSZ30T7FkGEZ/QqDpMBdzBWYoHI9of6UpbtCAowZ9JBLjNNf3YKK7FztoY+lHt
	 oChqbNFr/mD7zq1siTMOhbv1slWnyifwGVAqtxHUSEAff9BTC4xHdQu60clgnMi1h
	 jcMqxSaie9PTW9eBjySOLbFUNGh1lHakNVtp0t1Nnpslh6yIRjY2XK+D1XLsGDfIY
	 Sk6Cakv/wnX2WUS747ElkblLQ+80gLv5YIMmdw+RBqlwrRh8IzEERlD1lFj2Fqerh
	 2qWtZlpzswkckXd2xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1ss5Or3FBI-00zplC; Fri, 05
 Apr 2024 15:10:33 +0200
Message-ID: <6f727926-a901-4d9f-8a7f-d966f222f15d@web.de>
Date: Fri, 5 Apr 2024 15:10:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
 <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
 <20240403011818.GB892394@coredump.intra.peff.net>
 <b48fd3ee-2975-481f-aa0e-8ec4d07ea705@web.de>
 <20240403204836.GC1949464@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240403204836.GC1949464@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hzKY8aEXrtUplVpokjRmcSNbSmtskw0GiGLmobvgxAKylEkUTYQ
 bZvh13RGg7+23Ex9q8fxA5s5t6xvKHdRka21CsEbK4u14UhSzXWzTTO7aJqHGAHA8AWPj9f
 E9gVQeL3pDktIsn4SJkTyRHedrvQnDwIL10jXuv9113g2soaKQ8iMl68hlfBUJ5eOZFRHcF
 +uFaF5EsqXm7p1qdrCCDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OwN6VTzGoRM=;NmWwlcG/VFM5G6O/IZnoZP4ce5W
 Sl84aP2d0Yrz2gYQBRWm7Gk2PhgCUX62g2Xb84ODeZcLDuWMT+RyOUoh3axi6nk+h0fMphnWn
 RQTRNKDjVbY1VpEq8l49KRzQOr/JRmM5so8aO4YIzH7ZXEQdAcW+hVvxIQzTtjS6Z24oLciyW
 JLKdqrN2VYbqD5C3Q14ZLOkQuvKFMLXiAwNO/O1JqBCuk+V7fqMDJNYd4RZRGcKUx1FiiCZf+
 0MRwPzVXor3bX+thhpzd+x/JlOLiTk6bqJ8TM0wLmyabw0fvlhnuyTVv41/sLPf1xlrlox8Ud
 Jyy1gIcoy4zvcSJoItF995wQHetUWw79G5vGq6cfI0+NnM0ATboDXdEV0+a8JzmgRCUjx/nv5
 UORrh4YQsV5oH0AqwSnWKRyjg/UND1W6YHfEbGNfz0fZ8Bc4H2ZksNJJEBUUBfbiQwAeFWqK7
 oqSFOhhxGOg11m2x5CHlbf04tLsNvk9QJN0Bn2eEwCpKamByULD29hnrwVq07JaL1Q1GyXTxx
 RKHnqtDCURydMPwH6mCiVQDcR2b0NornzsWyKYBChI2V+47fjBVZI84VdSYg87NnR/3Dhmcyr
 +t0NM0grM1E8Jodo5q+a6x3X8Vogyqm8QXWyu+5ZVcb5Hltkucd1jhGeBu5deA+4zbppljJqF
 h19Z5Fg8swp/aNFoEd0gwS5+EAiaqUwF4RayqUb3iI2pJYm4ZH7Jz8y+YfXDgUrO0+bgyjcvO
 PaNHM9Jw8xaFfbah/IuPSRFBqiQQoPSz3Lz/L2a7rmaVVrmWwOhzTOXPlFgZKdeISYlhp012k
 IWJoGX/67SuAiaMO7IZ5dgilqe/m21Mdgh/iuplZIn1ck=

Am 03.04.24 um 22:48 schrieb Jeff King:
> On Wed, Apr 03, 2024 at 12:01:13PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> diff --git a/usage.c b/usage.c
>>> index 09f0ed509b..5baab98fa3 100644
>>> --- a/usage.c
>>> +++ b/usage.c
>>> @@ -19,8 +19,10 @@ static void vreportf(const char *prefix, const char=
 *err, va_list params)
>>>  	}
>>>  	memcpy(msg, prefix, prefix_len);
>>>  	p =3D msg + prefix_len;
>>> -	if (vsnprintf(p, pend - p, err, params) < 0)
>>> +	if (vsnprintf(p, pend - p, err, params) < 0) {
>>> +		if (snprintf(p, pend - p, "could not format error: %s", err) < 0)
>>>  		*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
>>> +	}
>>>
>>>  	for (; p !=3D pend - 1 && *p; p++) {
>>>  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
>>>
>>> Though most of the rest of the function is not that useful (it is most=
ly
>>> removing unreadable chars, and hopefully we do not have any of those i=
n
>>> our format strings!).

Hmm, this might be worth doing to avoid messing up the terminal if
'err' points into the weeds for some reason.

>> For warnings and usage messages this would keep the prefix and not
>> die.  This would look a bit strange, no?
>>
>> 	usage: could not format error: TERRIBLE MESSAGE!
>
> Sure, but I think any solution here is going to look strange. Keep in
> mind that we're trying to improve the case where we print _nothing_
> useful at all. If you do see this on a non-fatal message, the subsequent
> messages may be informative. E.g.:
>
>   error: could not format error: unable to open loose object %s
>   fatal: bad object HEAD~12
>
> is probably better than just exiting after the first.

OK, right, a format error doesn't have to be fatal and we can keep
running and possibly provide more details.

But mixing the format error with the actual payload message is not ideal.
At least we should give the format error its proper prefix, while still
reporting the prefix of the original message, e.g. like this:

   error: unable to format message: unable to open loose object %s
   fatal:

... or this:

   error: unable to format message: fatal: unable to open loose object %s

I tend to like the first one slightly better, even though the empty
message looks silly.  It doesn't mix the two and answers the questions
that I would have:  Why did the program stop?  Due to a fatal error.
Why is the fatal message silent?  The preceding error explains it.

While the second one only reveals the fatality somewhere in the middle
of the text, weakening the meaning of prefixes.

>> Yes, showing errno doesn't add that much value.  Except in this case it
>> shows that there's something going on that I don't understand.  Dare I
>> dig deeper?  Probably not..
>
> Well, let us know if you do. ;)

I still don't know why the error code varies between runs, but it
clearly does not come from vsnprintf(3) -- if I set errno to some
arbitrary value before the call, it is kept.  Which is enough to
convince me to ignore errno here.

Ren=C3=A9
