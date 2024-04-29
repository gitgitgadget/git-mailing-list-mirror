Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE012B73
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418694; cv=none; b=dM4wQiJiR0oUP2IFWFNgV6e8lMLH3urHfobJSZJ16TrtFsoB8AKZ0gBNniWPUkUpMW3OaW9s5+uK2X2d6zexM44wmen6yyo189x00WXBp1dM/KXa2lyJ6YWWgSsI1FZd5Y55aoxZTKNDZLlxibfNi7ZYLLCccCMl2FvzKkR02Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418694; c=relaxed/simple;
	bh=RQnTMQm7cvVTNRYlzNQeDy56MIJPmYo+xrKXQ1OvSN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E7K0NdAp+596GH1HZInTTWBQ9fCkv05hUt7mrj6BFehP4EgEVWxjsALAiTkUpvfysvlwYoK+C88ePui0bqdTcRnIKz7QtEZ7/32JCjBF290oFXdOsyXLcihjpvFuZ9U3k98A/qsXwiuO6Mx0CZtgDbsukHYFwSZLzBkmKfjy6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KMsJKjtB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KMsJKjtB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 288181862F;
	Mon, 29 Apr 2024 15:24:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RQnTMQm7cvVT
	NRYlzNQeDy56MIJPmYo+xrKXQ1OvSN4=; b=KMsJKjtB3XCVtUlgo4rutZ+d2yhS
	nOz4WegDYrBeZN5Jlwa7vxuojSrHaoMBpns0+XPQQ3JsB4HCydx5W/MkfyrOu6eB
	8NoQS653VOiHxYNmxai3N9Tt4vkVJB0iA1aCb+OlTt1PiwDonBFat6X/AM3+9tFg
	vXPlXDyXSpHbqaY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2100B1862C;
	Mon, 29 Apr 2024 15:24:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0788118629;
	Mon, 29 Apr 2024 15:24:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
In-Reply-To: <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 29 Apr 2024 20:37:03 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
	<10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
Date: Mon, 29 Apr 2024 12:24:46 -0700
Message-ID: <xmqqfrv4ug3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 247AB3A8-065E-11EF-BFEF-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> diff --git a/add-patch.c b/add-patch.c
> index 0997d4af73..fc0eed4fd4 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -293,10 +293,9 @@ static void err(struct add_p_state *s, const char =
*fmt, ...)
>  	va_list args;
> =20
>  	va_start(args, fmt);
> -	fputs(s->s.error_color, stderr);
> -	vfprintf(stderr, fmt, args);
> -	fputs(s->s.reset_color, stderr);
> -	fputc('\n', stderr);
> +	fputs(s->s.error_color, stdout);
> +	vprintf(fmt, args);
> +	puts(s->s.reset_color);

I like the attention of the detail here ;-).
