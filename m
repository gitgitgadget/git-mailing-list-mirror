Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71F4E1BD
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708818337; cv=none; b=KXeWPWHYsd6FKv+VRM7ZC2M3tUQUVyz4FAstX8i9LIMOt/RhqG2y40Z5JjOkK4+J1OFTfmEjJRn4HqIFWt1yGUcSO8+JRwVq7oYwU3z1XftL244sv2Pa1dJcnSfWxpeI24MrU8ZlVPxlMhzYgjTmz/cPOUqh3kuqq4fMglVsFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708818337; c=relaxed/simple;
	bh=lP9YAp6gKyU+GhvogzP4fhw9J6iT5lWbJ4r6Yn7cIWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l4WuJLxLSQZgb373VHPGjNt1VcWNBwjvfF8wm3Rz3S6ZNU2+co09+Um+c6GyD/LwJW89lHbjyGhR1eLxZG/w+cjKxjg3uqIbIdR3FutGSzNXKaNhKEXVl20lbSM9BvZAzSZJCbQuJ6mj0I+vv4SCKlatRfRxth++mwGGrEnpixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F/rSI7CF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F/rSI7CF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 13F292CD39;
	Sat, 24 Feb 2024 18:45:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lP9YAp6gKyU+
	GhvogzP4fhw9J6iT5lWbJ4r6Yn7cIWs=; b=F/rSI7CF91P+WT6unIzRBzBs5332
	RioxiVR55m4Tzky2ReRSaAdB9FcYNfZtQqOtEyjnlx8221Fm+FyHJ6NiHUWxr+vD
	P+xbypsgJ0uBh9gTz8zOSn2c/K+Cc7+mlHQ8Q+tzkH5jScOwGDHIxvljIX/NybAi
	pruDHFms+CivDZ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B9602CD38;
	Sat, 24 Feb 2024 18:45:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7AAC2CD37;
	Sat, 24 Feb 2024 18:45:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: convert strncmp() with strlen() to starts_with()
In-Reply-To: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 24 Feb 2024 22:47:06 +0100")
References: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>
Date: Sat, 24 Feb 2024 15:45:28 -0800
Message-ID: <xmqqfrxhjujr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CAEFBCCE-D36E-11EE-A319-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Using strncmp() and strlen() to check whether a string starts with
> another one requires repeating the prefix candidate.  Use starts_with()
> instead, which reduces repetition and is more readable.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/fetch.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3aedfd1bb6..0a7a1a3476 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -448,9 +448,8 @@ static void filter_prefetch_refspec(struct refspec =
*rs)
>  			continue;
>  		if (!rs->items[i].dst ||
>  		    (rs->items[i].src &&
> -		     !strncmp(rs->items[i].src,
> -			      ref_namespace[NAMESPACE_TAGS].ref,
> -			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
> +		     starts_with(rs->items[i].src,
> +				 ref_namespace[NAMESPACE_TAGS].ref))) {

The original tries to check that "namespace" fully matches the
initial part of .src string, which is exactly what starts_with()
does.  Makes sense.

>  			int j;
>
>  			free(rs->items[i].src);
> --
> 2.44.0
