Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22E3FB10
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732019; cv=none; b=CXej45XLlbJ99zAun9eMbyrhVTuWnz/3ndUIip1h1L4mInmDXMBoEsK1XFO2IrPWfa4nSKzcWTJdVnRc3Re1Ym5V5Fq5LB0ZdiogsL3YeSweQAgpYVlMlCxfcRUocrZQ0os6nb4IX90oK2uw5lSKgc10Nd0OSrNkVht1jFXUYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732019; c=relaxed/simple;
	bh=xouCzRR1VNXwBgNmD3puaCRa9KASP8p+/LPEPS8e9bU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiId+jY12WW9xadO9fBie3NH+JbjaPdakXSQEZVe2v9pUsl2k/vn1JD52W+IiOPcZhpeBTiYjOFtsLe3jqq6etQ8H7NRGiUgndh/z7fI9562w/Vj52OlgAvBCyUsUdheoo+x1lWW2fq7lyLjpgHXEZX61iKQfUf4hsTbfF17DJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=etUdwxOy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="etUdwxOy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B83AE1EAAB1;
	Wed, 31 Jan 2024 15:13:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xouCzRR1VNXwBgNmD3puaCRa9KASP8p+/LPEPS
	8e9bU=; b=etUdwxOyFLYobgv8ZEc1xXwlu2x6+wL70NWyO8EWNk2YeKiSuxcYFy
	VBoO5NoKdN4/B73EJto4aPjJQvJ0GEcRC1kpDPUSP8pbaANzovIlYRSXgkahrx1j
	ksXWc5zuaj3KIyyYqTjQWkO6j1t4HDfKMdH/uJPshFghnvGZ8Dfyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF32F1EAAB0;
	Wed, 31 Jan 2024 15:13:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D3551EAAAE;
	Wed, 31 Jan 2024 15:13:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:17
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<5c7a2354df0f4a29841f9ab8294ead0e1c3b9cf5.1706664145.git.gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 12:13:27 -0800
Message-ID: <xmqqy1c545y0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32D17074-C075-11EE-9D96-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Currently have two functions for formatting trailers exposed in
> trailer.h:
>
>     void format_trailers(FILE *outfile, struct list_head *head,
>                         const struct process_trailer_options *opts);
>
>     void format_trailers_from_commit(struct strbuf *out, const char *msg,
>                                     const struct process_trailer_options *opts);
>
> and previously these functions, although similar enough (even taking the
> same process_trailer_options struct pointer), did not build on each
> other.
>
> Make format_trailers_from_commit() rely on format_trailers(). Teach
> format_trailers() to process trailers with the additional
> process_trailer_options fields like opts->key_only which is only used by
> format_trailers_from_commit() and not builtin/interpret-trailers.c.
> While we're at it, reorder parameters to put the trailer processing
> options first, and the out parameter (strbuf we write into) at the end.
>
> This unification will allow us to delete the format_trailer_info() and
> print_tok_val() functions in the next patch. They are not deleted here
> in order to keep the diff small.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---

I am not sure how I helped this particularly (say, compared to all
the other patches on the list from everybody), though.

The updated format_trailers() does so much more than the original
and does so quite differently, it is hard to tell if the existing
caller is getting the same behaviour (modulo obviously it now needs
to prepare a strbuf and print the resulting string in the strbuf,
which is expected) as before.

The conversion for the sole existing caller looks like this, ...

>  	LIST_HEAD(head);
>  	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf trailer_block = STRBUF_INIT;
>  	struct trailer_info info;
> ...
> -	format_trailers(opts, &head, outfile);
> +	/* Print trailer block. */
> +	format_trailers(opts, &head, &trailer_block);
> +	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
> +	strbuf_release(&trailer_block);

... and it is very straight-forward.


But what it called was this:

> -static void print_tok_val(FILE *outfile, const char *tok, const char *val)
> -{
> -	char c;
> -
> -	if (!tok) {
> -		fprintf(outfile, "%s\n", val);
> -		return;
> -	}
> -
> -	c = last_non_space_char(tok);
> -	if (!c)
> -		return;
> -	if (strchr(separators, c))
> -		fprintf(outfile, "%s%s\n", tok, val);
> -	else
> -		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
> -}
> -
> -void format_trailers(const struct process_trailer_options *opts,
> -		     struct list_head *trailers, FILE *outfile)
> -{
> -	struct list_head *pos;
> -	struct trailer_item *item;
> -	list_for_each(pos, trailers) {
> -		item = list_entry(pos, struct trailer_item, list);
> -		if ((!opts->trim_empty || strlen(item->value) > 0) &&
> -		    (!opts->only_trailers || item->token))
> -			print_tok_val(outfile, item->token, item->value);
> -	}
> -}

i.e. iterate over trailers, and sometimes call print_tok_val(),
which does not do all that much.  Print only the val, or when tok is
not empty, show "tok: val" while taking into account the possibility
that the last byte of tok may already be the separator.

But the new thing is way more complex.

> +void format_trailers(const struct process_trailer_options *opts,
> +		     struct list_head *trailers,
> +		     struct strbuf *out)
> +{
> +	struct list_head *pos;
> +	struct trailer_item *item;
> +	int need_separator = 0;
> +
> +	list_for_each(pos, trailers) {
> +		item = list_entry(pos, struct trailer_item, list);
> +		if (item->token) {
> +			char c;
> +
> +			struct strbuf tok = STRBUF_INIT;
> +			struct strbuf val = STRBUF_INIT;
> +			strbuf_addstr(&tok, item->token);
> +			strbuf_addstr(&val, item->value);
> +
> +			/*
> +			 * Skip key/value pairs where the value was empty. This
> +			 * can happen from trailers specified without a
> +			 * separator, like `--trailer "Reviewed-by"` (no
> +			 * corresponding value).
> +			 */
> +			if (opts->trim_empty && !strlen(item->value))
> +				continue;

OK, this matches the first condition to stay silent in the original.

> +			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {

For the original caller of format_trailers(), which is the
interpret_trailers(), .filter member is never set, so we always come
here, I presume.  cmd_interpret_trailers(), before calling
interpret_trailers() could affect the following members:

    .in_place .trim_empty .only_trailers .only_input .unfold .no_divider

so we should make sure this new implementation does not change the
behaviour from the original with various combination of these
options.

> +				if (opts->unfold)
> +					unfold_value(&val);

So, ... how would this affect an invocation of

    $ git interpret-trailers --unfold

which would have set opts.unfold to true in cmd_interpret_trailers()
and eventually called process_trailers() with it, which eventually
called print_all(), which conditionally called print_tok_val() but
never gave the val to unfold_value()?

 ... goes and digs a bit more ...

Ahhhh, original process_trailers() did this by calling
parse_trailers() that munged the value.  So its print_all()
codepath only had to print what has already been munged.

But then in this new code, do we unfold only here?  I thought that
in the new code you moved around, the caller, whose name is now
interpret_trailers(), still calls parse_trailers() and that calls
the unfold_value().  So, are we doing redundant work that may merely
be unneeded (if we are lucky) or could be harmful (if things, other
than the unfold thing I just noticed, that are done both in
parse_trailers() and this function are not idempotent)?

It could be that a bit more preparatory refactoring would clarify.
I dunno.

> +				if (opts->separator && need_separator)
> +					strbuf_addbuf(out, opts->separator);
> +				if (!opts->value_only)
> +					strbuf_addbuf(out, &tok);
> +				if (!opts->key_only && !opts->value_only) {
> +					if (opts->key_value_separator)
> +						strbuf_addbuf(out, opts->key_value_separator);
> +					else {
> +						c = last_non_space_char(tok.buf);
> +						if (c) {
> +							if (!strchr(separators, c))
> +								strbuf_addf(out, "%c ", separators[0]);
> +						}
> +					}
> +				}
> +				if (!opts->key_only)
> +					strbuf_addbuf(out, &val);
> +				if (!opts->separator)
> +					strbuf_addch(out, '\n');
> +
> +				need_separator = 1;
> +			}
> +
> +			strbuf_release(&tok);
> +			strbuf_release(&val);
> +		} else if (!opts->only_trailers) {
> +			if (opts->separator && need_separator) {
> +				strbuf_addbuf(out, opts->separator);
> +			}
> +			strbuf_addstr(out, item->value);
> +			if (opts->separator)
> +				strbuf_rtrim(out);
> +			else
> +				strbuf_addch(out, '\n');
> +
> +			need_separator = 1;
> +		}
> +
> +	}
> +}

