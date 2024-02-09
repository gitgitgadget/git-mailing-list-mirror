Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5218AE4
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515646; cv=none; b=giIozxl86jKX0z3hHqXZBYug7tC9MnBHDV/44xNuPNIXvkdJtfCPo2BqawPTnCBTOavJRJQGWxJKr+CRxX7gRYJmNASkyqEmisLG24+hWuefR8rb7UTHqlQB1Ng1yiNAgZQ9qNnFcy6W+ymShRXuC+eHuLI8SUoU6PJdQ8f/Bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515646; c=relaxed/simple;
	bh=MOkCLlDVAOm89uMld7UACK6e/YyGUEhTLNXUpHYGoh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNviSpwxVTFUtWY37A1isecD1UnF5Vxx/63qHs9qPJKolZF8cnMpwd9XpGB6eFoP2EPG6AVfUcibZohI6vUHtWZMy4s7pP69msIEM4gSBrDQ8iFWjlGEWDghGiG5KD+G47MGdXbr6EfX765c6K0Ure7Rp/T8cYm11PsSymFtSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aknB8ZpO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aknB8ZpO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 604D11C4DB5;
	Fri,  9 Feb 2024 16:54:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MOkCLlDVAOm89uMld7UACK6e/YyGUEhTLNXUpH
	YGoh0=; b=aknB8ZpO8LR1NdMpIjuQp5LFWl2EIQJMAVbFuI33TIq5FczCLmcppu
	F+/651SzOgqvEea/t9tXLSq/q7HNBdmWzERTh2Z4u1WgrLmzan0UCWgvRk5ancGD
	sPvXUiOuyLyVlAo9ull3oiSXZl085TyUdk4vVfGh2eaO/toPLfC4M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 572831C4DB4;
	Fri,  9 Feb 2024 16:54:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6D881C4DB3;
	Fri,  9 Feb 2024 16:54:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 11/28] format_trailer_info(): drop redundant
 unfold_value()
In-Reply-To: <457f2a839d5da9da225e842275bbf8b15f194f1f.1707196348.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Tue, 06 Feb 2024 05:12:11
	+0000")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<457f2a839d5da9da225e842275bbf8b15f194f1f.1707196348.git.gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 13:54:00 -0800
Message-ID: <xmqqwmrdcnif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BCDC8F16-C795-11EE-A4A4-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This is another preparatory refactor to unify the trailer formatters.
>
> In the last patch we made format_trailer_info() use trailer_item objects
> instead of the "trailers" string array. This means that the call to
> unfold_value() here is redundant because the trailer_item objects are
> already unfolded in parse_trailers() which is a dependency of our
> caller, format_trailers_from_commit().
>
> Remove the redundant call.

OK.  The previous step had this hunk:

-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->unfold)
 					unfold_value(&val);

where parse_trailers() already has a call to parse_trailer()
followed by a call to unfold_value(), so in a sense, switching
to use the result of calling parse_trailers() by the caller instead
of duplicating our own parsing in format_trailer_info() that started
at step [09/28] made both parse_trailer() call (removed in step [10/28])
and unfold_value() call (removed in this step [11/28]).

So it would have also made sense if this were done as part of
[10/28], but it is also OK to keep them separated.

In either way, breaking the transition into these steps does make
them easier to follow.

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index 6333dfe1c11..12cae5b73d2 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1102,9 +1102,6 @@ static void format_trailer_info(const struct process_trailer_options *opts,
>  			strbuf_addstr(&val, item->value);
>  
>  			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
> -				if (opts->unfold)
> -					unfold_value(&val);
> -
>  				if (opts->separator && out->len != origlen)
>  					strbuf_addbuf(out, opts->separator);
>  				if (!opts->value_only)
