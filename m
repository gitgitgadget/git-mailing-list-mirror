Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83270143866
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907173; cv=none; b=sFPyYYlvd3P5V/NfNztqkeS+EHSkLNLH6EH2PNEtAOMwbNsDFE7rP1rvTtTKthyX5lz9YefqVjzIEbjSY6chpC2oF1AcBJac3jTflrHt+cW6F1ftUKnoh/TqLgQsBXO3eTOEsw8MWT7RwF+pFUstK+10gnDZMAAi2HDvidIX/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907173; c=relaxed/simple;
	bh=/M0kXJ28tffQinFlMyKjl5KzAKvKmQ/5sNM7cw2bsUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJRj1OIvoCIK8t5/DiG9BGeBGJwU7jmmZwFeq9MUOP2T9RDSpq8AeLM6N8DvR5q66w88eMao9KZbn6LuBJjEtl9BT4tEZxoEdql6Ps/QCmBXbq4qqV0KYSy+U2nOV9Ht9+U8TvlzuXAhwU3ldYw/Nrn5Oz013ZpGFqPbD7RNS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uwr4x3gq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uwr4x3gq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48F571F546F;
	Tue, 23 Apr 2024 17:19:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/M0kXJ28tffQinFlMyKjl5KzAKvKmQ/5sNM7cw
	2bsUI=; b=Uwr4x3gqfVGz10ZLC3Wevo8V0GCT53A69Ckka3DBHIUjxXCldbJq9g
	Mzsanl8d3CQKoVyMBmONqREw6NUSfZMHmaOg4Nq4ux/a3uUupUhb0ndAi3TD29BI
	man/bRqxfBv/xNXk2pUv1MaDAa0xCb0IR4Hq4WkckAvJkjRfs9g3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F5761F546E;
	Tue, 23 Apr 2024 17:19:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A05541F546D;
	Tue, 23 Apr 2024 17:19:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 4/8] sequencer: use the trailer iterator
In-Reply-To: <84897cf5c83eb67c023603016b49fb7b56870aa3.1713504153.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Fri, 19 Apr 2024 05:22:29
	+0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<84897cf5c83eb67c023603016b49fb7b56870aa3.1713504153.git.gitgitgadget@gmail.com>
Date: Tue, 23 Apr 2024 14:19:22 -0700
Message-ID: <xmqqh6frojz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28320F92-01B7-11EF-B223-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Instead of calling "trailer_info_get()", which is a low-level function
> in the trailers implementation (trailer.c), call
> trailer_iterator_advance(), which was specifically designed for public
> consumption in f0939a0eb1 (trailer: add interface for iterating over
> commit trailers, 2020-09-27).
>
> Avoiding "trailer_info_get()" means we don't have to worry about options
> like "no_divider" (relevant for parsing trailers). We also don't have to
> check for things like "info.trailer_start == info.trailer_end" to see
> whether there were any trailers (instead we can just check to see
> whether the iterator advanced at all).
>
> Note how we have to use "iter.raw" in order to get the same behavior as
> before when we iterated over the unparsed string array (char **trailers)
> in trailer_info.

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  sequencer.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)

OK.  The code reduction primarily comes from the fact that the
original was manually iterating over the trailer lines that you can
get from the iterator API.

> +	while (trailer_iterator_advance(&iter)) {
> +		i++;
> +		if (sob && !strncmp(iter.raw, sob->buf, sob->len))
> +			found_sob = i;
> +	}
> +	trailer_iterator_release(&iter);
>  
> +	if (!i)
> +		return 0;
>  
> +	found_sob_last = (int)i == found_sob;

This is slightly harder to reason about, as we cannot directly say
"the collection being iterated over has .nr members, and what we
found was at the end" like the original could do in its loop.

> -	for (i = 0; i < info.trailer_nr; i++)
> -		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
> -			found_sob = 1;
> -			if (i == info.trailer_nr - 1)
> -				found_sob_last = 1;
> -		}

As 'i' is incremented before we set found_sob to it in the new loop,
when it is assigned in the loop, the value of found_sob will never
be zero.  It used to be that found_sob takes only 0 or 1, but
because we only care about found_sob and found_sob_last being
zero/non-zero in the remainder of the code, this does not affect the
correctness of the code.

Looking good.


