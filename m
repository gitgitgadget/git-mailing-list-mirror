Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC61EB56
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840566; cv=none; b=nRqQfZaeAVoT46ZeErItzwmYKhIa2cl6LIHxsiVzLNsCzYNI1OI4q4xIGXvHs7I/d6RnNiZ2AQCW2hTApTpES7r8hBgDkSNMnagcabRCgCog5i3jaVCrYrSm+h7SqfNtQJgPFgSRJckZU8du2XzqNBhnrnhXqf3q24T5RO2z4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840566; c=relaxed/simple;
	bh=31HiBjcz/52qHVbOesxdve10ceewXnIEqxNQdFw5n8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYU4EodBRRQkUBrXgZapFspRoqdgno767mPZXhgsavKJUsKhw/a4B0Sugxf44wB/zyI4YYDV6ITu+J8H0x/3xB+8299yz30wtf1XS4UkMOFpR74B33R3Guw5loVYuG6IhaKDVWEJ9+VqVshIwq9ZUJX9XZLaJvWHvecrxiuwXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=QpIijIRl; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QpIijIRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709840525; x=1710445325; i=l.s.r@web.de;
	bh=31HiBjcz/52qHVbOesxdve10ceewXnIEqxNQdFw5n8k=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QpIijIRliOuSlqfkAzNA2jXK4wNCjAXKn8wRUQSdPEEIc2i6F3zsMpLZW3/kcMsd
	 P70wTWJLEXJIeQEMdSmGHXUfY/3+yqu2jMKNbMQAcARmnRxDRUPug8ITnwI1Oc31u
	 3uaIcf5YOBcch1qvLGnpFMGpueTgSDE66BCjF30LdQ92E3L7CGAa/C2kX1Brs2xA6
	 7Do1wqWCNlQg+AvaONrVg4YNe8dloFeCqj39bTVKOwtipc6FPVOKZwyyMyW33uVHM
	 rPqPyZvetO5dZFmYhe0ckj42PYm3N2W0umSPybsH1vg8cdKw80EpiNgeZ13jm5x3T
	 nKYB1Un1PJtXoOhJfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1rMxZL19Dq-00Ww4V; Thu, 07
 Mar 2024 20:42:05 +0100
Message-ID: <742ed8e6-d68b-47a0-8d57-731716c5365d@web.de>
Date: Thu, 7 Mar 2024 20:41:59 +0100
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
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Manlio Perillo <manlio.perillo@gmail.com>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <20240307110809.GA3668372@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240307110809.GA3668372@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0BEOoRJyrYZDLLDg8Toe6HQPvXXYQfs0p3UxPQ6hkd2yvBTPu92
 16ghVoMFVZuA01WElGLGcbfG5MAy10w8uygJ3m95ynjnGjCAKLr/FeUxkl1ir/7wkW35RKD
 b+uZTS2ZVoE++bm5OovTRnCp2tv2+lrKxfcO9mZ5CEOWggW4fP+LXTx04ZQiuC6XUXY+0X9
 OA7yXaEkBwdVNjSNrHqUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vCnVYPCB7Rk=;cE2K8pcVQODWP3peAazh8Nqx0LO
 BEdQDTyMtU0OlpAbrC9Bsylee66EUmA/9PR5m4ChPk8jL2/I4IbZqyyv4ZBH4ifxd6xNNAUtb
 FWRssNFj8kDkzxhSzTjUzi8yIVm9eV1AqTWpe0ijLZjt4cxpE/tKdpJpN7ddgYQR8XLxlked3
 o2Ehk+nj0IXJHDiqPBDZaH2ght/pXSEJfkRmCbTgYwS3VHMijP09oNWtSIb3r4T9Zb3Jfe3jm
 DrRi+CWLNtkYrS5JalP0S4xkPXvukyCCDq8SQbrMyU/FTdcZPqmrz+ex0Vkz8JiCiQuGvwc8x
 rLX5jW9ewrwTB37yUFmkfTZUeFiknobNfdOh34DIqJxAjKLdybwVJfAbLAncTB0ZyNqySUWUc
 qxFY9mo3yQ6TKck31vhKUOPSxsjRA/cbrpITtCV1jUAnXQvfLu5YhBzSOfGVe64v/i2ogocp0
 b9mOR4m3wA76rhu5SM/2QFciQ6NFVP4m5qAt4ZgL6YcdIWXcDMOPEBQmrrgoGko/8Q1eP/oLI
 LzAZBBY0NPSiaGWBPxltYCMryvPkMQK0vKvxXV2T8sKHknvflTdu4xZqn0XIjn5ZYuLWpxp9c
 cKMuGhGoJ1ejHXtef8PaRUX2QUVoU7ZpNpv4TBluC8DKLh8TLUVbsb0h/2nGt2+mJpxKoDE86
 gHEyRunE6DS1Q4xSsLyduwHXXyojK4ltdCAvGR4Vgu+TrVXePLoviSwzQsLYCh4znE3Vx3LTU
 iccOrX8nN/PH8KB6eQe9sxBhYadTShp2vFbrwcj5RTaaNikDTmcmDs0SZXt3ieOZV2lH33cty
 JV0TCpNF5DjO8tg2GoTRXsHwKdD3YypCT/fOrekLu558s=

Am 07.03.24 um 12:08 schrieb Jeff King:
> On Thu, Mar 07, 2024 at 04:26:38AM -0500, Jeff King wrote:
>
>> IMHO this is the trickiest commit of the whole series, as it would be
>> easy to get the length computations subtly wrong.
>
> And sure enough...
>
>> diff --git a/trailer.c b/trailer.c
>> index fe18faf6c5..f59c90b4b5 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -882,7 +882,7 @@ static size_t find_trailer_block_start(const char *=
buf, size_t len)
>>
>>  	/* The first paragraph is the title and cannot be trailers */
>>  	for (s =3D buf; s < buf + len; s =3D next_line(s)) {
>> -		if (s[0] =3D=3D comment_line_char)
>> +		if (starts_with_mem(s, buf + len - s, comment_line_str))
>>  			continue;
>>  		if (is_blank_line(s))
>>  			break;
>> @@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *=
buf, size_t len)
>>  		const char **p;
>>  		ssize_t separator_pos;
>>
>> -		if (bol[0] =3D=3D comment_line_char) {
>> +		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str)=
) {
>>  			non_trailer_lines +=3D possible_continuation_lines;
>>  			possible_continuation_lines =3D 0;
>>  			continue;
>
> This second hunk needs:
>
> diff --git a/trailer.c b/trailer.c
> index f59c90b4b5..fdb0b8137e 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -902,7 +902,7 @@ static size_t find_trailer_block_start(const char *b=
uf, size_t len)
>  		const char **p;
>  		ssize_t separator_pos;
>
> -		if (starts_with_mem(bol, buf + end_of_title - bol, comment_line_str))=
 {
> +		if (starts_with_mem(bol, buf + len - bol, comment_line_str)) {
>  			non_trailer_lines +=3D possible_continuation_lines;
>  			possible_continuation_lines =3D 0;
>  			continue;
>
> I was trying to bound the size based on the loop, which is:
>
>           for (l =3D last_line(buf, len);
>                l >=3D end_of_title;
>                l =3D last_line(buf, l)) {
>                   const char *bol =3D buf + l;
>
> but I misread "end_of_title" as an upper bound, not a lower one. Which
> makes sense because we're iterating backwards over the lines. So I
> suppose we could bound it by the previous "bol" value. But in practice,
> your prefix won't cross such a boundary anyway, as it won't have a
> newline in it (maybe that's something we should enforce? I guess you
> could set core.commentChar to '\n' even before my series, which would be
> slightly insane).
>
> So just bounding ourselves to "buf + len" seems reasonable, as that
> makes sure we don't step outside the buffer passed into the function.
>
> Curiously, this was found by the sanitizer job in CI, where UBSan
> complains of integer overflow in the pointer computation. I had run with
> both ASan/UBSan locally, but just using gcc, which doesn't seem to find
> it (the CI job uses clang). So I'll that to my mental tally of "clang
> seems to be better with sanitizers".
>
> -Peff

