Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF12ECE
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625173; cv=none; b=P5KZIBm/nitHqNF4L7vUgETK7cn2sbmpLXJX9Bi/Q25t9VJlFsFV8cdDJ37RT6fh7cUKFd3W18zXnvkWMf/5kV4W3a1hTLieaaYdfXfIYcv4v2bp5WEJhq1Q6cn07M7d/wqcklcnV3pPKJZtF2WYASOLJtLvDxe5M9yLgnWpgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625173; c=relaxed/simple;
	bh=7EHOixeRJ8jP9tzNPS+brkRLHU8PgGrJQg1KMekdYFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3zuS3qDBWAb2EqIrJhwR4i2uq08EbZGURX37M+lfBbSICTNgw/aB+6dRFl22cXuF2wdkbo7xAhFahyma8s/XoM78HdaUUuAEIYlmejQiDPHKpL9wVZYh/wJN+JrLk0NuM3VylQzZUHrfSBJ//dAJazJUv4nUOqoU9xmoCIe7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yDY34cZ9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yDY34cZ9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FA412C053;
	Thu, 18 Jan 2024 19:46:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7EHOixeRJ8jP9tzNPS+brkRLHU8PgGrJQg1KMe
	kdYFM=; b=yDY34cZ942ArPOjbbyJgS+4R91RctfBSR/bH1XIBNzjPA41+47f+pC
	AAVPAvD/GKf2ROQAR403vZHdunkyv16zrEFMZizlCyNQ7c+wpwR7x7WUldBagK0w
	HmUuhhXXSQY0D84WM5tNIqz3BtipxOBcfeWvqIxw1TKGuZyWqUgGg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 77C782C052;
	Thu, 18 Jan 2024 19:46:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FE232C051;
	Thu, 18 Jan 2024 19:46:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 05/10] sequencer: use the trailer iterator
In-Reply-To: <fd4a9d54d9522973a4c22e43cb1d7964033d4837.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:21
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<fd4a9d54d9522973a4c22e43cb1d7964033d4837.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 16:45:59 -0800
Message-ID: <xmqq34uunoag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E90295E-B664-11EE-B0A9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This patch allows for the removal of "trailer_info_get()" from the
> trailer.h API, which will be in the next patch.
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

Nice.

> Also, teach the iterator about non-trailer lines, by adding a new field
> called "raw" to hold both trailer and non-trailer lines. This is
> necessary because a "trailer block" is a list of trailer lines of at
> least 25% trailers (see 146245063e (trailer: allow non-trailers in
> trailer block, 2016-10-21)), such that it may hold non-trailer lines.

OK.  This would change behaviour, wouldn't it, in the sense that we
used to yield a non-trailer line from the old iterator but the new
one skips them?  Is that something we can demonstrate and protect in
tests (presumably once we conclude these refactoring, we would be
able to call into this machinery from unit-testing framework)?

Thanks.

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/shortlog.c |  7 +++++--
>  sequencer.c        | 35 +++++++++++++++--------------------
>  trailer.c          | 20 ++++++++++++--------
>  trailer.h          | 13 +++++++++++++
>  4 files changed, 45 insertions(+), 30 deletions(-)
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
> index 3cc88d8a800..d199869cda9 100644
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
> +		    !strncmp(iter.raw.buf, sob->buf, sob->len)) {
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
> index 132f22b3dd7..593717fd56c 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1151,6 +1151,7 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>  	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
>  	strbuf_init(&iter->key, 0);
>  	strbuf_init(&iter->val, 0);
> +	strbuf_init(&iter->raw, 0);
>  	opts.no_divider = 1;
>  	trailer_info_get(&iter->internal.info, msg, &opts);
>  	iter->internal.cur = 0;
> @@ -1158,17 +1159,19 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
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
> +		strbuf_reset(&iter->raw);
> +		strbuf_addstr(&iter->raw, line);
>  		strbuf_reset(&iter->key);
>  		strbuf_reset(&iter->val);
>  		parse_trailer(&iter->key, &iter->val, NULL,
> -			      trailer, separator_pos);
> +			      line, separator_pos);
>  		unfold_value(&iter->val);
>  		return 1;
>  	}
> @@ -1180,4 +1183,5 @@ void trailer_iterator_release(struct trailer_iterator *iter)
>  	trailer_info_release(&iter->internal.info);
>  	strbuf_release(&iter->val);
>  	strbuf_release(&iter->key);
> +	strbuf_release(&iter->raw);
>  }
> diff --git a/trailer.h b/trailer.h
> index 50f70556302..d50c9fd79b2 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -127,6 +127,19 @@ struct trailer_iterator {
>  	struct strbuf key;
>  	struct strbuf val;
>  
> +	/*
> +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
> +	 * key/val pair. This field can contain non-trailer lines because it's
> +	 * valid for a trailer block to contain such lines (i.e., we only
> +	 * require 25% of the lines in a trailer block to be trailer lines).
> +	 */
> +	struct strbuf raw;
> +
> +	/*
> +	 * 1 if the raw line was parsed as a separate key/val pair.
> +	 */
> +	int is_trailer;
> +
>  	/* private */
>  	struct {
>  		struct trailer_info info;
