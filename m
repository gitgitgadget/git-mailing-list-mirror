Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7918AE4
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515650; cv=none; b=bZFGgV5HinDWYEmO0z0Z+Wco8wUhMAOhzSUu5IXts+MqZsZ3oG3fAdYEUsiFvYZJ1dESpNpLRIZ1kZ5qmIW7rHlygrcNvuulIghh7RtsnkKjTyFNZcHKBSN08PPSX3AcM7Rm9zhwxLFGXwAQWfaI31AXmBTeUGsSdaPoMRlK8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515650; c=relaxed/simple;
	bh=97amse0GF9nDjd/56aFVg1F5u/3YKxjGwF1+2aYreRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRFVWm1uTHsWgA2kOBjDpvwCXy2nSmZUEXjSGdZxOeeLq08nSkDH4v4fCO4+KcipH/rD0De4O6oVl4A2KwrG35pqCFEmrSkDFyOnRF8/P0fk1IANTYRsc5s2gzoLp/DECwuxvwq+1MCfl1NGIYElyo35vVKVYPjVL/+qsLx2h0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I7Xah9ta; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7Xah9ta"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EFC4B208A7;
	Fri,  9 Feb 2024 16:54:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=97amse0GF9nDjd/56aFVg1F5u/3YKxjGwF1+2a
	YreRQ=; b=I7Xah9taE0AZdlOij866aamqhFFbkp0OyCT0hZzvGxs7S0H7cvYGnw
	Jmwd+3+/y+sN4BdO5oim89OAVC2fg6rIfKqlAIz7Niylaeqh6SRRgBm8KV3GwWyl
	ztkiFW3wgTfb646tYKPvGjBFdUph/IAEOWbPHPHlTEUhnf5lsorGg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E7CDD208A6;
	Fri,  9 Feb 2024 16:54:01 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD72F208A0;
	Fri,  9 Feb 2024 16:53:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 10/28] format_trailer_info(): use trailer_item objects
In-Reply-To: <f5b7ba08aa7c80a3bd5bcbf5563eac8896fe7054.1707196348.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Tue, 06 Feb 2024 05:12:10
	+0000")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<f5b7ba08aa7c80a3bd5bcbf5563eac8896fe7054.1707196348.git.gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 13:53:57 -0800
Message-ID: <xmqq34u1e22y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA919BB6-C795-11EE-AFB3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This is another preparatory refactor to unify the trailer formatters.
>
> Make format_trailer_info() operate on trailer_item objects, not the raw
> string array.
>
> This breaks t4205 and t6300. We will continue to make improvements until
> the test suite passes again, ultimately renaming format_trailer_info()
> to format_trailers(), at which point the unification of these formatters
> will be complete.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

I would have expected a (tentative) flip from test_expect_success to
test_expect_failure in the affected tests, to illustrate what behaviour
change this step introduces and why.

But the huge single step in the previous round broken out into
smaller steps like this round makes them much easier to follow.

Thanks.

> diff --git a/trailer.c b/trailer.c
> index e6665c99cc3..6333dfe1c11 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1086,21 +1086,21 @@ void trailer_info_release(struct trailer_info *info)
>  }
>  
>  static void format_trailer_info(const struct process_trailer_options *opts,
> -				const struct trailer_info *info,
> +				struct list_head *trailers,
>  				struct strbuf *out)
>  {
>  	size_t origlen = out->len;
> -	size_t i;
> -
> -	for (i = 0; i < info->trailer_nr; i++) {
> -		char *trailer = info->trailers[i];
> -		ssize_t separator_pos = find_separator(trailer, separators);
> +	struct list_head *pos;
> +	struct trailer_item *item;
>  
> -		if (separator_pos >= 1) {
> +	list_for_each(pos, trailers) {
> +		item = list_entry(pos, struct trailer_item, list);
> +		if (item->token) {
>  			struct strbuf tok = STRBUF_INIT;
>  			struct strbuf val = STRBUF_INIT;
> +			strbuf_addstr(&tok, item->token);
> +			strbuf_addstr(&val, item->value);
>  
> -			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
>  			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
>  				if (opts->unfold)
>  					unfold_value(&val);
> @@ -1127,13 +1127,12 @@ static void format_trailer_info(const struct process_trailer_options *opts,
>  			if (opts->separator && out->len != origlen) {
>  				strbuf_addbuf(out, opts->separator);
>  			}
> -			strbuf_addstr(out, trailer);
> +			strbuf_addstr(out, item->value);
>  			if (opts->separator) {
>  				strbuf_rtrim(out);
>  			}
>  		}
>  	}
> -
>  }
>  
>  void format_trailers_from_commit(const struct process_trailer_options *opts,
> @@ -1152,7 +1151,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
>  		strbuf_add(out, msg + info.trailer_block_start,
>  			   info.trailer_block_end - info.trailer_block_start);
>  	} else
> -		format_trailer_info(opts, &info, out);
> +		format_trailer_info(opts, &trailers, out);
>  
>  	free_trailers(&trailers);
>  	trailer_info_release(&info);
