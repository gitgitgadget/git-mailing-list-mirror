Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C98494
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755858; cv=none; b=YSYdKYVNx+M5hGRLXm3y1sYs/+hv682/9+J6xnYu64+6QQgAfqZPpsxFWVNGJ/D5kUtJbenjJ3VQT48q9CBjD5SZnKRdTJ5VvQmYmND0WJfHQjyTm/ufjHutRtch6r/MUJPv4g8u9OaUX2KirWF9S2Mjg7kDQ0tF/jixbzWwO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755858; c=relaxed/simple;
	bh=Yr+fwVtxXKxrX9X0MsWM/C9/kxfJPWqLW8xReqnyboY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KL7SMJy9zCmHJVq9qb9XrWSfZbX5xsn0XkZjwKpHaraxsAQCpdNXUExp6mA0GQUHy16iVXhNHmqDRki/01DnbcNx7Fi69AWvSQlLQCfqp5pEyxeqs0OfNk5P8N2VtsvSY8AZfl5ZwLCsj0/aGwPTdC4KwfNp9mnZqbYHJJWfPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RShU2BxE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RShU2BxE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EBB82FD6C;
	Mon, 12 Feb 2024 11:37:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yr+fwVtxXKxr
	X9X0MsWM/C9/kxfJPWqLW8xReqnyboY=; b=RShU2BxEtaEydF8x9hglqPNLqcNd
	TkHcmqbYYQJ3z/XhpFKtQJtafyZqhC3Lw4PfngCs6ixbGWIPCsL86NkbPcIRIjya
	JEuDqEc8vi5kNb+Ii4z/NfqHvE2HXj5YbfqpODJd5QC1gmM8SVVK4ajB0BNcnsVB
	Zt4froGSgrOYTHs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 676E12FD6B;
	Mon, 12 Feb 2024 11:37:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06D0B2FD69;
	Mon, 12 Feb 2024 11:37:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Tiago Pascoal" <tiago@pascoal.net>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: git column fails (or crashes) if padding is negative
In-Reply-To: <3380df68-83fb-417b-a490-71614edc342f@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 11 Feb 2024 18:08:10 +0100")
References: <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
	<571fb353-af1d-4cc9-a2c2-197296685623@app.fastmail.com>
	<xmqqttmhfrko.fsf@gitster.g>
	<3380df68-83fb-417b-a490-71614edc342f@app.fastmail.com>
Date: Mon, 12 Feb 2024 08:37:25 -0800
Message-ID: <xmqqh6id8wqi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 01C49E30-C9C5-11EE-BFBC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Fri, Feb 9, 2024, at 18:57, Junio C Hamano wrote:
>>  builtin/column.c | 2 ++
>>  column.c         | 4 ++--
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> [=E2=80=A6]
>> diff --git c/column.c w/column.c
>> index ff2f0abf39..9cc703832a 100644
>> --- c/column.c
>> +++ w/column.c
>> @@ -189,7 +189,7 @@ void print_columns(const struct string_list *list,
>> unsigned int colopts,
>>  	memset(&nopts, 0, sizeof(nopts));
>>  	nopts.indent =3D opts && opts->indent ? opts->indent : "";
>>  	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";
>> -	nopts.padding =3D opts ? opts->padding : 1;
>> +	nopts.padding =3D (opts && 0 < opts->padding) ? opts->padding : 1;
>
> If these two are meant to check the same condition as in
> `builtin/column.c`, shouldn=E2=80=99t it be `0 <=3D opts->padding`?

Good eyes.  Otherwise we lose the ability to set the padding to 0.
