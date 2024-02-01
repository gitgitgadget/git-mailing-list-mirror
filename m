Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE612B167
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810777; cv=none; b=f3dWomzuGGf/LeJ/d9iXPLl6SIIbCxftkZBDokiS+2H7KCZ/44qopA4IxdvPYuTbNlJeC9DPTWc68PJhKb8HR10gfifSirrjkUCvm4nmJ/M4nZygtwqeNMb9XO4ZqorSbkarKPgQKl8iO4b9e9rmTP3kK38RLa/RYOTCPDi8+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810777; c=relaxed/simple;
	bh=/Eo1/Cx4jaKENCaByNeVH/HS7AkgfJDY+DllxgXjsFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPs24akpABsVM35EWo7z3UJG3uRMCyK3P0MXgQlOVEmcA3HoTYySkRbStYWXhZI36Npv7njrT7w1TIE4XLtzjEIZqMhVx6jLZ6e0dFzxurh6UCnQpmPQqbqjNQeDY9PmdUI46Pb2Nj9L2IxRfIr0a1i+sfG3BBsZM2W4Gm20xlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GVL2HJqP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GVL2HJqP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B6EB1E0D97;
	Thu,  1 Feb 2024 13:06:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/Eo1/Cx4jaKENCaByNeVH/HS7AkgfJDY+Dllxg
	XjsFU=; b=GVL2HJqP7nJ3KpyMymrsHbWm+oyRxPPCJ/LtIA203OvKAm8LB3JOTI
	hxiTcWQYR1Zx3GySVvjQ7ZyENeVsS46Lljj3Yu03jhixLQ9As+0Q5G7izuYtiXlh
	pIOxkBgbnrsONoZ9+ejeAk/Y7uq2YZHsGQsXyXIEpvRAfl67sBl/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 509BA1E0D96;
	Thu,  1 Feb 2024 13:06:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 844CB1E0D95;
	Thu,  1 Feb 2024 13:06:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 04/10] sequencer: use the trailer iterator
In-Reply-To: <bf2b8e1a3c4bc77022fab1ebaa0fc89a7813b4c4.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:18
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<bf2b8e1a3c4bc77022fab1ebaa0fc89a7813b4c4.1706664145.git.gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 10:06:06 -0800
Message-ID: <xmqqa5ok12lt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 92801B08-C12C-11EE-9E67-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This patch allows for the removal of "trailer_info_get()" from the
> trailer.h API, which will be in the next patch.

Hmph, do you mean "shortlog" and the sequencer were the only two
external callers and with this we can make it file-scope static to
trailer.c?  Or do you mean the next step will be more than a removal
of a declaration from trailer.h plus adding "static" in front of its
definition in trailer.c, because there need other adjustments before
that happens?

> Instead of calling "trailer_info_get()", which is a low-level function
> in the trailers implementation (trailer.c), call
> trailer_iterator_advance(), which was specifically designed for public
> consumption in f0939a0eb1 (trailer: add interface for iterating over
> commit trailers, 2020-09-27).

;-).

> Also, teach the iterator about non-trailer lines, by adding a new field
> called "raw" to hold both trailer and non-trailer lines. This is
> necessary because a "trailer block" is a list of trailer lines of at
> least 25% trailers (see 146245063e (trailer: allow non-trailers in
> trailer block, 2016-10-21)), such that it may hold non-trailer lines.

That sounds like a task larger than something we would want in a
patch that focuses on another task (e.g. update sequencer not to
call trailer_info_get()) while at it.  It seems from a casual glance
that the change to shortlog.c is to accomodate this change in the
semantics of what the iterator could return?  It smells that this
patch does two more or less unrelated things at the same time?

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/shortlog.c |  7 +++++--
>  sequencer.c        | 35 +++++++++++++++--------------------
>  trailer.c          | 17 +++++++++--------
>  trailer.h          | 13 +++++++++++++
>  4 files changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 1307ed2b88a..dc8fd5a5532 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -172,7 +172,7 @@ static void insert_records_from_trailers(struct shortlog *log,
>  					 const char *oneline)
>  {
>  	struct trailer_iterator iter;
> -	const char *commit_buffer, *body;
> +	const char *commit_buffer, *body, *value;
>  	struct strbuf ident = STRBUF_INIT;
>  
>  	if (!log->trailers.nr)
> @@ -190,7 +190,10 @@ static void insert_records_from_trailers(struct shortlog *log,
>  
>  	trailer_iterator_init(&iter, body);
>  	while (trailer_iterator_advance(&iter)) {
> -		const char *value = iter.val.buf;
> +		if (!iter.is_trailer)
> +			continue;
> +
> +		value = iter.val.buf;
>  
>  		if (!string_list_has_string(&log->trailers, iter.key.buf))
>  			continue;
> diff --git a/sequencer.c b/sequencer.c
> index 3cc88d8a800..bc7c82c5271 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -319,37 +319,32 @@ static const char *get_todo_path(const struct replay_opts *opts)
>  static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	size_t ignore_footer)
>  {
> -	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> -	struct trailer_info info;
> -	size_t i;
> -	int found_sob = 0, found_sob_last = 0;
> -	char saved_char;
> -
> -	opts.no_divider = 1;
> +	struct trailer_iterator iter;
> +	size_t i = 0, found_sob = 0;
> +	char saved_char = sb->buf[sb->len - ignore_footer];
>  
>  	if (ignore_footer) {
> -		saved_char = sb->buf[sb->len - ignore_footer];
>  		sb->buf[sb->len - ignore_footer] = '\0';
>  	}
>  
> -	trailer_info_get(&info, sb->buf, &opts);
> +	trailer_iterator_init(&iter, sb->buf);
> +	while (trailer_iterator_advance(&iter)) {
> +		i++;
> +		if (sob &&
> +		    iter.is_trailer &&
> +		    !strncmp(iter.raw, sob->buf, sob->len)) {
> +			found_sob = i;
> +		}
> +	}
> +	trailer_iterator_release(&iter);
>  
>  	if (ignore_footer)
>  		sb->buf[sb->len - ignore_footer] = saved_char;
>  
> -	if (info.trailer_block_start == info.trailer_block_end)
> +	if (!i)
>  		return 0;
>  
> -	for (i = 0; i < info.trailer_nr; i++)
> -		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
> -			found_sob = 1;
> -			if (i == info.trailer_nr - 1)
> -				found_sob_last = 1;
> -		}
> -
> -	trailer_info_release(&info);
> -
> -	if (found_sob_last)
> +	if (found_sob == i)
>  		return 3;
>  	if (found_sob)
>  		return 2;
> diff --git a/trailer.c b/trailer.c
> index 71ea2bb67f8..5bcc9b0006c 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1158,17 +1158,18 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>  
>  int trailer_iterator_advance(struct trailer_iterator *iter)
>  {
> -	while (iter->internal.cur < iter->internal.info.trailer_nr) {
> -		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
> -		int separator_pos = find_separator(trailer, separators);
> -
> -		if (separator_pos < 1)
> -			continue; /* not a real trailer */
> -
> +	char *line;
> +	int separator_pos;
> +	if (iter->internal.cur < iter->internal.info.trailer_nr) {
> +		line = iter->internal.info.trailers[iter->internal.cur++];
> +		separator_pos = find_separator(line, separators);
> +		iter->is_trailer = (separator_pos > 0);
> +
> +		iter->raw = line;
>  		strbuf_reset(&iter->key);
>  		strbuf_reset(&iter->val);
>  		parse_trailer(&iter->key, &iter->val, NULL,
> -			      trailer, separator_pos);
> +			      line, separator_pos);
>  		unfold_value(&iter->val);
>  		return 1;
>  	}
> diff --git a/trailer.h b/trailer.h
> index 244f29fc91f..a7599067acc 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -127,6 +127,19 @@ struct trailer_iterator {
>  	struct strbuf key;
>  	struct strbuf val;
>  
> +	/*
> +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
> +	 * key/val pair as part of a trailer block. A trailer block can be
> +	 * either 100% trailer lines, or mixed in with non-trailer lines (in
> +	 * which case at least 25% must be trailer lines).
> +	 */
> +	const char *raw;
> +
> +	/*
> +	 * 1 if the raw line was parsed as a trailer line (key/val pair).
> +	 */
> +	int is_trailer;
> +
>  	/* private */
>  	struct {
>  		struct trailer_info info;
