Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2971DA45
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618581; cv=none; b=bk+Y/OZbAftMnr+O0OHHRgMAjfXGNTjPxDCtsjtzP+iZbT1HPQYxGpoJ2eDFgq/NhNtOCxyI+0WOWWa0GcVHd+YtgXigw/ca6YyaXHgxwLzIv0Thvd+46qAaYDNGgxLK7AJSq+U+BlvbipBikcs+ZGc1QFIUN8sVn7cRSUeSunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618581; c=relaxed/simple;
	bh=fgCBRXQ+gnd13FPTby6jCoVMFWjxbx/hwl7TO843c9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sw5f3SzMNtqkDcV0T1BlVXjtCmNsonac2rL1+xOBOaBGxkFdNQGFOe5yYtuIciaSQtrkgojzKpTOjGqL1+MGnQDh3PzelGCeC9GiSAzhYVNQztGIvygFLg4Q8p/tOEwZK3+EfaxF4xvcrUixFI1dVoiOqe7SU64qr6hXUrnCZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u6C0m2z6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u6C0m2z6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2272E1CD5B0;
	Thu, 18 Jan 2024 17:56:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fgCBRXQ+gnd13FPTby6jCoVMFWjxbx/hwl7TO8
	43c9I=; b=u6C0m2z6FJ7r9vfI/SW8JIWki0myl4K44Q9aSUYVN17FbGkVXkq5BU
	IsQkvwt5nKR2nZGRdNrCFPUYfDUMpy3Sf24cHMlkFONF3uDFveqxQZIVTGY93IEQ
	llAJPMkEMXtTA2JBSJYBE6s0deYLFlbdyYaLwxWhiGOPmfyonRrLE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A3A61CD5AF;
	Thu, 18 Jan 2024 17:56:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BCA21CD5AE;
	Thu, 18 Jan 2024 17:56:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 03/10] trailer: unify trailer formatting machinery
In-Reply-To: <d3326021fb6a63707e4ce56f166447143f4e55a2.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:19
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<d3326021fb6a63707e4ce56f166447143f4e55a2.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 14:56:16 -0800
Message-ID: <xmqqr0ientdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C9DCA928-B654-11EE-BD8A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

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

Yay.  It feels a bit disappointing to see the diffstat and learn
that we are not deleting substantial number of lines.

> ---
>  builtin/interpret-trailers.c |   5 +-
>  pretty.c                     |   2 +-
>  ref-filter.c                 |   2 +-
>  trailer.c                    | 105 +++++++++++++++++++++++++++++------
>  trailer.h                    |  21 +++----
>  5 files changed, 102 insertions(+), 33 deletions(-)

> diff --git a/pretty.c b/pretty.c
> index cf964b060cd..f0721a5214f 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1759,7 +1759,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  				goto trailer_out;
>  		}
>  		if (*arg == ')') {
> -			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
> +			format_trailers_from_commit(msg + c->subject_off, &opts, sb);

I am curious (read: no objection---merely wondering if there is a
guiding principle behind the choice of the new order) why this new
parameter ordering.  I suspect it was originally written with a
strbuf-centric worldview and having sb at the beginning may have
made sense, but if we are moving them around, wouldn't it make more
sense to have &opts as the first parameter, as this is primarily a
"trailers" function?  Unsure until I read through to the end, but
that is my gut reaction.

>  static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
>  {
>  	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
> @@ -984,6 +971,78 @@ static void unfold_value(struct strbuf *val)
>  	strbuf_release(&out);
>  }
>  
> +void format_trailers(struct list_head *head,
> +		     const struct process_trailer_options *opts,
> +		     struct strbuf *out)
> +{
> +	struct list_head *pos;
> +	struct trailer_item *item;
> +	int need_separator = 0;
> +
> +	list_for_each(pos, head) {
> +		item = list_entry(pos, struct trailer_item, list);
> +		if (item->token) {
> +			char c;
> + ...
> +			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
> +				if (opts->unfold)
> +					unfold_value(&val);
> +
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

That's an overly deep nesting.  I wonder if a small file-scope
helper function is in order?

	static add_separator(struct process_trailer_options *opts,
        		     const char *token
			     struct strbuf *out)
	{
		if (opts->key_value_separator)
			strbuf_addbuf(out, opts->key_value_separator);
		else
			strbuf_addstr(out, ": ");
	}

Or perhaps inside the context of the loop to go over the list of
trailer items, one iteration of the list_for_each() loop can become
one call to a small helper function format_one_trailer() and that
may make the result easier to follow?

In any case, I didn't see anything glaringly wrong so far in this
series.  Let me keep reading.

Thanks.
