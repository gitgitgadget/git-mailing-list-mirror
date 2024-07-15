Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1333FD
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054717; cv=none; b=hB/FQ0QNZF7a7nkkWY3DU0E0ytv86VeL+c/Jz+ntPropy+4k/kceaHQljJqUH7AnBONhu5q6gHSkHRpCObaZLTKgjRcRS3mc5go7pOWP1mwb2bo7h+eE646prVfbobIfbOsJNkOeMee5ogDhNuTCFwx1aGS0OukQ2jiKdWAnLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054717; c=relaxed/simple;
	bh=agGx06v9CPT2Xer1WVpdDgrtbCsX7zn/OEz+yvP6J6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIg4z3hQJfIu4vo9C9Xa44PtrMtBAnOxdO2/8lSbKFn/keyRoZmK38Z1aUycEhlWF2wKbAggXw02Q5a4EoqWMMsXtUYj1rZP+N5Tu1eYGjyPiX1mUXnEeS23nH9E/RYu0+hszMm3VG7hNZh/tOg5JoKLGu5TOuco05kq6SWNKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xu7JZWeq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xu7JZWeq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D67D31B00;
	Mon, 15 Jul 2024 10:43:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=agGx06v9CPT2
	Xer1WVpdDgrtbCsX7zn/OEz+yvP6J6A=; b=Xu7JZWeqzdytxW0XoWdIte7O7PZP
	0anSi0zlM+SvzDmVPmbdKivRfQApiHBQcnjOnEqugJg8NsvGRs+2FxKFlwcjnVc0
	lI/NCsbp401PHIXrnQksAKBbH1SN2XVUVslS11UeADXwN7B4ncrNJ/HMtCC3z3UN
	2rS3oLuSHmjVghY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1440631AFF;
	Mon, 15 Jul 2024 10:43:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 813EA31AF5;
	Mon, 15 Jul 2024 10:43:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/1] t-strvec: tighten .alloc check in check_strvec
In-Reply-To: <075b3d08-4270-4064-8103-1fece055e197@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 14 Jul 2024 19:06:58 +0200")
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
	<983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
	<075b3d08-4270-4064-8103-1fece055e197@web.de>
Date: Mon, 15 Jul 2024 07:43:40 -0700
Message-ID: <xmqqjzhm90mb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A11180A4-42B8-11EF-9CAA-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
> index fdb28ba220..6a4d425840 100644
> --- a/t/unit-tests/t-strvec.c
> +++ b/t/unit-tests/t-strvec.c
> @@ -8,7 +8,9 @@
>  		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
>  		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
>  		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
> -		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
> +		    ((vec)->v =3D=3D empty_strvec ? \
> +		     check_uint((vec)->nr, =3D=3D, (vec)->alloc) : \
> +		     check_uint((vec)->nr, <, (vec)->alloc))) { \

Not a huge deal but with empty_strvec, don't we want to barf if
nr=3D=3Dalloc=3D=3D1?

>  			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
>  				if (!check_str((vec)->v[i], expect[i])) { \
>  					test_msg("      i: %"PRIuMAX, i); \
> --
> 2.45.2
