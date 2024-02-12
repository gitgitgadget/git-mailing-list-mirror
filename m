Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643873D3BD
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756041; cv=none; b=a5RfyWEfwIYPNx6LAv1DkZyg+E1GsluicmgzlKhS3b9PMfWxjXUGEFIkbU1eKhJe5ngEhu5ln6aArxFsIGwLFbMUOF1eMjjq97ltFChFmJPZxggnzQdlkqkof/i8Wuim95jOm/VvqQmJoDrWHxLKE3sSrDknQzImVeb0ZCXPtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756041; c=relaxed/simple;
	bh=Tl0Sh3mlMLbHM5exogT3tTGTOUzx/T0dB/GWUmnDRPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=di1Q1zKWM+vmbMUOb4sX7ADi/yVmuLGrHIA+Ew/l0JuBI9Yf3aqcgNeRZEKESdcEEg83w/2gWh/OET7Sf2fUo0sB72PIFIKROQaKFW1nuseonVVPwusvu98PMIyz46sjjKREBZpzkYYbgAF9Sd+WD6MobTqLQ6NYEOgaIvfPp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eHAAdgLS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eHAAdgLS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 918C91DE38F;
	Mon, 12 Feb 2024 11:40:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Tl0Sh3mlMLbH
	M5exogT3tTGTOUzx/T0dB/GWUmnDRPM=; b=eHAAdgLST8p4mZKLTgGj4yXSWFmD
	7sjyEWfoZfQoOTVN5reKLRSeK/C2blMUQswLPbXVjyPNgDrMLWi//+n61OCWFm9O
	tJ1+diS/BCv2vu1rsPqu7vzx8+wRyB6LVK4Np1cqy+yYy3LR+4vUTt33yGb50lMA
	LdQWByIEvHhXgqM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 894E71DE38E;
	Mon, 12 Feb 2024 11:40:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0FF91DE38D;
	Mon, 12 Feb 2024 11:40:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Jeff King <peff@peff.net>,  Kyle
 Lippincott <spectral@google.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] receive-pack: use find_commit_header() in
 check_cert_push_options()
In-Reply-To: <7b0a87f1-4693-480e-90d4-14675e9a5f01@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 10 Feb 2024 08:42:48 +0100")
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
	<xmqqsf21cmp4.fsf@gitster.g>
	<7b0a87f1-4693-480e-90d4-14675e9a5f01@web.de>
Date: Mon, 12 Feb 2024 08:40:31 -0800
Message-ID: <xmqq4jed8wlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7091E638-C9C5-11EE-8B86-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> I just discovered 14570dc67d (wrapper: add function to compare strings
> with different NUL termination, 2020-05-25).  Perhaps squash this in to
> simplify?

Oooh, xstrncmpz() seems to target this exact use case.  Nice.


>
> ---
>  builtin/receive-pack.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index dbee508775..db65607485 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -717,9 +717,8 @@ static int check_cert_push_options(const struct str=
ing_list *push_options)
>  		buf =3D option + optionlen + 1;
>  		options_seen++;
>  		if (options_seen > push_options->nr
> -		    || strncmp(push_options->items[options_seen - 1].string,
> -			       option, optionlen)
> -		    || push_options->items[options_seen - 1].string[optionlen])
> +		    || xstrncmpz(push_options->items[options_seen - 1].string,
> +				 option, optionlen))
>  			return 0;
>  	}
>
> --
> 2.43.0
