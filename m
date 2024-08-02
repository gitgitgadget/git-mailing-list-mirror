Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B81396
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634340; cv=none; b=B1BZ1dymN11F0xuDi2Ltddlpl6WmDYcnH+Ac92o167nX4/QcMecjeEx2nnOvyv8DC9pGHKAASfEinpLNmtiH/II7JRoBgwbl5mwEkwiQW797Absfoc/L7WdxAz7UVVl2O4OjnhTrt1FJPm8ny38JJytb8s5fw18EYegyK1XqOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634340; c=relaxed/simple;
	bh=s8nWbIdYF5/Janc4TSn3LaArMTh0C/trtNlbWe0xlKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZCqrh2W0uxt8pihXyj/le4/lHUZvxSujF3J5GIS0+dL+krMKSGat1VmF0rB10qLfBX96d3GAAbpDTxF3N7EbEZYJQ9Jx3ikXD5G+B09G0SQJA12p1BMeiu8t4SY26qyNtM+s+tAVa+s0fmISZi1uQzs9OCHAYfeEWmZByloYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLOkg9Sw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLOkg9Sw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1501D294F6;
	Fri,  2 Aug 2024 17:32:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=s8nWbIdYF5/Janc4TSn3LaArMTh0C/trtNlbWe
	0xlKo=; b=MLOkg9SwxFVLqZ23RPhga3woWnyka5Sx0yloqYCEymp10a8qz7foQc
	FY4Kvel1a6s9qDMOvtqQJpLPVRtM9McxmKYLqIcuxx7ZDoGXT8EQqxoyIS9Mc+FM
	vkrFA3Thvf2Cky2ir2S4vLrd0rNnBHw78Ga7m8CiFaLX5ZTuBbHm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BDEC294F5;
	Fri,  2 Aug 2024 17:32:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67608294F4;
	Fri,  2 Aug 2024 17:32:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
In-Reply-To: <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
	(Kyle Lippincott via GitGitGadget's message of "Fri, 02 Aug 2024
	20:58:06 +0000")
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
	<pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 14:32:16 -0700
Message-ID: <xmqqv80ia9wf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B11D5736-5116-11EF-B18B-BAC1940A682E-77302942!pb-smtp2.pobox.com

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> If the loop executes more than once due to cwd being longer than 128
> bytes, then `errno = ERANGE` might persist outside of this function.
> This technically shouldn't be a problem, as all locations where the
> value in `errno` is tested should either (a) call a function that's
> guaranteed to set `errno` to 0 on success, or (b) set `errno` to 0 prior
> to calling the function that only conditionally sets errno, such as the
> `strtod` function. In the case of functions in category (b), it's easy
> to forget to do that.
>
> Set `errno = 0;` prior to exiting from `strbuf_getcwd` successfully.
> This matches the behavior in functions like `run_transaction_hook`
> (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).

I am still uneasy to see this unconditional clearing, which looks
more like spreading the bad practice from two places you identified
than following good behaviour modelled after these two places.

But I'll let it pass.

As long as our programmers understand that across strbuf_getcwd(),
errno will *not* be preserved, even if the function returns success,
it would be OK.  As the usual convention around errno is that a
successful call would leave errno intact, not clear it to 0, it
would make it a bit harder to learn our API for newcomers, though.

Thanks.

> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>  strbuf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index 3d2189a7f64..b94ef040ab0 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -601,6 +601,7 @@ int strbuf_getcwd(struct strbuf *sb)
>  		strbuf_grow(sb, guessed_len);
>  		if (getcwd(sb->buf, sb->alloc)) {
>  			strbuf_setlen(sb, strlen(sb->buf));
> +			errno = 0;
>  			return 0;
>  		}
