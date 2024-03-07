Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25E1CABF
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840898; cv=none; b=GmtCAZkK0+0nMAsHBOixzE0+k7Z22TvkVssQ42svYg2yC3grThK5p38G8VpVcLItOmkd800o23NlzMlKn02sscHZi2h3Xv3H8uZLqdjGmhRN2TMePsrexuwyrWKRpABZDAZJvLTiqvhLQLucJIfxUHk+AAegjf5TVd3iTSO5K9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840898; c=relaxed/simple;
	bh=qbE0zFAgeD1NSp/5N2Yg7pAc/RuFVhzIvu9LBW7w71Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pvPNiz8IeO3+arcMbs7aO6sgss/wqRebVO3BusThLgsbEx6iduAT+zMtPolHQP+tr5Szq7dPuY1gRWk+2i2Zl6U/3XiLbYd8ge1vNRLKHqjz9wWJOXXrcLKgQ+gYIn/uZoVS4HD1ILg2NCSjQNs0rzTvTcPjEpfQmx5iI7HKj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JglQrRq5; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JglQrRq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709840878; x=1710445678; i=l.s.r@web.de;
	bh=qbE0zFAgeD1NSp/5N2Yg7pAc/RuFVhzIvu9LBW7w71Y=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=JglQrRq5P9NIB6uqmPn2j/cr6Gfr88BcWZR1NpfoJ+nXpxxBg66pBLH3Ik22R1VL
	 KV7s7wppubkuWRnYebm+11E5kncUej7hxU7teNVZ/IMlFnUXJADDHRoVNrSLkD1PV
	 pf7WmW/rg77QAaFTNvi5or6nVkvWQoUZN8WmeqMEelH3dwvDjwwD6OlAIcFbwcn3F
	 KLgomkqsIndMG8Ek+tjoUTwuDB3mOzdvfoJMulcOwn+B7Ggak87H6XwygfW8n6jhu
	 B2iUM4yG9zGzH4CIx9+OLDjVQls3T+2eME+bN30ce2iWFG8am5YfZ8nP45gABtQjj
	 SUtOG6aav4webUER3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1qoRo133bA-015Lxp; Thu, 07
 Mar 2024 20:47:57 +0100
Message-ID: <50c7f2b9-2f40-49f8-af13-1521323825cd@web.de>
Date: Thu, 7 Mar 2024 20:47:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <20240307110809.GA3668372@coredump.intra.peff.net>
 <742ed8e6-d68b-47a0-8d57-731716c5365d@web.de>
In-Reply-To: <742ed8e6-d68b-47a0-8d57-731716c5365d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EcrQ6bLV+FZztfmv30kRF+oZzRXjDzSW/gH6hHCaYlcJ578pYsX
 8F7dYdumfTbds1Kh0Unc9aw/Drty+qz1jiC1vslyX7kGE+a7zAp5Zft1xoCkEG4+5LtK+Q7
 +CSJ7ZvKTOhOQKdqfkb6/q+A/sQCDVZCZe6eNRnX4+wadFO2RfXJi+dWwYmjpQUEJjB+Nwt
 8MHj7GjlQ3sOizdFVrOug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cRy03AuKf0E=;qc7m4RgoEEGctdvTlLnXykt+1jL
 qLDNIl1Sw+61yVzZCiZxm574SA6ktm6d6TTpcHl0OkIeroBROVUM+Y/7ta4TecFdwhmZnLyFD
 QwInKay27LBkhlVZqRa8+FyhOjxZVVOq6LMy+ZYQeYF5hfvT8MN0xiwkiHx+31YomlX1EjOIN
 iJn9b3EWK6vFfpxSbaGwMbHuDaKhXJ08T8Stdx0TzohuHaWr2DkpGHJwzFuXaTvu+6sPQQEOf
 neLFGsGecjab3sjmptSr3A+8L5WFWvFV7tcVKYJLnlyY0zZO1W13JmDTkZ0y++4f1Fkjfy47t
 /vYCL8vpSPwLOOO8vSkvYdwHRNdfO2VczFSzS2YP9r6nmGj6Euc/eepOwdLnF3j0nHiYckgN0
 3RzOxwL5dW3bSbE+xrB1rCk+cOBGEtwT5rLNs/b8r2+hyOjrEDVKI1Y8AduZpkvV/axOoFHgt
 tBPVPNJPjUJ3b+zs7tn+FPuHpfh7RaXsNZ+IzkSb3Zc5zVYmJDi879/iBrxvTGDgkbrZbV8aX
 exaHc3GUms5ruZv8o1T304FZ/M8tSzJ0kRUV7yi8usl/W4k3t1hvzseyq9Tr1gbAL0Q3BmYPf
 06KjU9y2pZC0r4xp1dIxhi5VI86s3dFNPyX/SjMSg8QrSAIOwUKP8ks6rc+NkUSCCoglpJCTW
 UEX5xom5lbi6H6hdbze54StAAjczYfHDrfRTnxfY8tdBfwTKJ1zGH/3GvJmk4EuIDTPie34uO
 7chdVTRJ3uXO6uxoabBLuCrK9oF6JQw0WZYwsL5jaX5J7M8rQDqmDXlP6jvQFjtjDErUJwkpb
 NJZb3nLdaxqYMnD2+w5F12kqqG+f5phSM2PZONZ+YxYx8=

Am 07.03.24 um 20:41 schrieb Ren=C3=A9 Scharfe:

Sorry, sent too early.

> Am 07.03.24 um 12:08 schrieb Jeff King:
>> On Thu, Mar 07, 2024 at 04:26:38AM -0500, Jeff King wrote:
>>
>>> IMHO this is the trickiest commit of the whole series, as it would be
>>> easy to get the length computations subtly wrong.
>>
>> And sure enough...
>>
>>> diff --git a/trailer.c b/trailer.c
>>> index fe18faf6c5..f59c90b4b5 100644
>>> --- a/trailer.c
>>> +++ b/trailer.c
>>> @@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char =
*buf, size_t len)
>>>
>>>  	/* The first paragraph is the title and cannot be trailers */
>>>  	for (s =3D buf; s < buf + len; s =3D next_line(s)) {
>>> -		if (s[0] =3D=3D comment_line_char)
>>> +		if (starts_with_mem(s, buf + len - s, comment_line_str))
>>>  			continue;
>>>  		if (is_blank_line(s))
>>>  			break;
>>> @@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char =
*buf, size_t len)
>>>  		const char **p;
>>>  		ssize_t separator_pos;
>>>
>>> -		if (bol[0] =3D=3D comment_line_char) {
>>> +		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str=
)) {
>>>  			non_trailer_lines +=3D possible_continuation_lines;
>>>  			possible_continuation_lines =3D 0;
>>>  			continue;
>>
>> This second hunk needs:
>>
>> diff --git a/trailer.c b/trailer.c
>> index f59c90b4b5..fdb0b8137e 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *=
buf, size_t len)
>>  		const char **p;
>>  		ssize_t separator_pos;
>>
>> -		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str)=
) {
>> +		if (starts_with_mem(bol, buf + len - bol, comment_line_str)) {
>>  			non_trailer_lines +=3D possible_continuation_lines;
>>  			possible_continuation_lines =3D 0;
>>  			continue;
>>
>> I was trying to bound the size based on the loop, which is:
>>
>>           for (l =3D last_line(buf, len);
>>                l >=3D end_of_title;
>>                l =3D last_line(buf, l)) {
>>                   const char *bol =3D buf + l;
>>
>> but I misread "end_of_title" as an upper bound, not a lower one. Which
>> makes sense because we're iterating backwards over the lines. So I
>> suppose we could bound it by the previous "bol" value. But in practice,
>> your prefix won't cross such a boundary anyway, as it won't have a
>> newline in it (maybe that's something we should enforce? I guess you
>> could set core.commentChar to '\n' even before my series, which would b=
e
>> slightly insane).
>>
>> So just bounding ourselves to "buf + len" seems reasonable, as that
>> makes sure we don't step outside the buffer passed into the function.

If you don't want or expect LF in comment_line_str, better check it.
And if you do that, most callers of starts_with_mem() -- including this
one -- can use starts_with() instead, as mentioned in my reply to your
patch.  Less calculations, less errors..

Ren=C3=A9



