Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DBC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604B323A34
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 19:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2KGps4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgI0TTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 15:19:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53573 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0TTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 15:19:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBA758392F;
        Sun, 27 Sep 2020 15:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qVxbKSnCAyrkzsG3n0JPFzwWD5w=; b=F2KGps
        4cl57JoqxHkzHkNo58X7moeagH8ADRhtQRl0W00ucAztEsVA7AQDIEzJ9JKjQz1m
        GEWVKwoxjWVLIskpz/MJnemwUQIQqs0bv1REH6//HttzAbh3jT2Cyro33W5fUzHG
        ju7bj+R1RQN6zFVKzC0EmY7qUJSrsb9BZZlss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Zb+sHNc31p/N30pFkt/nJj493kYmo2uQ
        yXHD/FqcCBWMHy+OKxrEMLmNVph2Rf7GSlt/D9hKCVeUECD+6GCyjH8pg869AfAk
        oh1JA9y+HnUAQKpTbfxPk0j+Sq3gDLdQZXpLSTH4HkyTmb4mzq1yjqS5tE6YzMbU
        ZPIvZHcNTTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0A498392E;
        Sun, 27 Sep 2020 15:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5499E8392D;
        Sun, 27 Sep 2020 15:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/8] shortlog: change "author" variables to "ident"
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927083952.GA2465761@coredump.intra.peff.net>
Date:   Sun, 27 Sep 2020 12:18:57 -0700
In-Reply-To: <20200927083952.GA2465761@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 27 Sep 2020 04:39:52 -0400")
Message-ID: <xmqqpn67ni3i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B80FC76-00F6-11EB-82DF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We already match "committer", and we're about to start
> matching more things. Let's use a more neutral variable to
> avoid confusion.

Looks good at least when seen alone.

It is curious how we are going to handle less structured nature of
trailers.  The author and committer header fields are required to be
in good shape, but it is perfectly fine for *-by lines to be just
human-readable strings (e.g. without <address@looking.tokens>).

We'll see.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/shortlog.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index c856c58bb5..edcf2e0d54 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -49,12 +49,12 @@ static int compare_by_list(const void *a1, const void *a2)
>  }
>  
>  static void insert_one_record(struct shortlog *log,
> -			      const char *author,
> +			      const char *ident,
>  			      const char *oneline)
>  {
>  	struct string_list_item *item;
>  
> -	item = string_list_insert(&log->list, author);
> +	item = string_list_insert(&log->list, ident);
>  
>  	if (log->summary)
>  		item->util = (void *)(UTIL_TO_INT(item) + 1);
> @@ -97,8 +97,8 @@ static void insert_one_record(struct shortlog *log,
>  	}
>  }
>  
> -static int parse_stdin_author(struct shortlog *log,
> -			       struct strbuf *out, const char *in)
> +static int parse_stdin_ident(struct shortlog *log,
> +			     struct strbuf *out, const char *in)
>  {
>  	const char *mailbuf, *namebuf;
>  	size_t namelen, maillen;
> @@ -122,18 +122,18 @@ static int parse_stdin_author(struct shortlog *log,
>  
>  static void read_from_stdin(struct shortlog *log)
>  {
> -	struct strbuf author = STRBUF_INIT;
> -	struct strbuf mapped_author = STRBUF_INIT;
> +	struct strbuf ident = STRBUF_INIT;
> +	struct strbuf mapped_ident = STRBUF_INIT;
>  	struct strbuf oneline = STRBUF_INIT;
>  	static const char *author_match[2] = { "Author: ", "author " };
>  	static const char *committer_match[2] = { "Commit: ", "committer " };
>  	const char **match;
>  
>  	match = log->committer ? committer_match : author_match;
> -	while (strbuf_getline_lf(&author, stdin) != EOF) {
> +	while (strbuf_getline_lf(&ident, stdin) != EOF) {
>  		const char *v;
> -		if (!skip_prefix(author.buf, match[0], &v) &&
> -		    !skip_prefix(author.buf, match[1], &v))
> +		if (!skip_prefix(ident.buf, match[0], &v) &&
> +		    !skip_prefix(ident.buf, match[1], &v))
>  			continue;
>  		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
>  		       oneline.len)
> @@ -142,20 +142,20 @@ static void read_from_stdin(struct shortlog *log)
>  		       !oneline.len)
>  			; /* discard blanks */
>  
> -		strbuf_reset(&mapped_author);
> -		if (parse_stdin_author(log, &mapped_author, v) < 0)
> +		strbuf_reset(&mapped_ident);
> +		if (parse_stdin_ident(log, &mapped_ident, v) < 0)
>  			continue;
>  
> -		insert_one_record(log, mapped_author.buf, oneline.buf);
> +		insert_one_record(log, mapped_ident.buf, oneline.buf);
>  	}
> -	strbuf_release(&author);
> -	strbuf_release(&mapped_author);
> +	strbuf_release(&ident);
> +	strbuf_release(&mapped_ident);
>  	strbuf_release(&oneline);
>  }
>  
>  void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  {
> -	struct strbuf author = STRBUF_INIT;
> +	struct strbuf ident = STRBUF_INIT;
>  	struct strbuf oneline = STRBUF_INIT;
>  	struct pretty_print_context ctx = {0};
>  	const char *fmt;
> @@ -170,17 +170,17 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  		(log->email ? "%cN <%cE>" : "%cN") :
>  		(log->email ? "%aN <%aE>" : "%aN");
>  
> -	format_commit_message(commit, fmt, &author, &ctx);
> +	format_commit_message(commit, fmt, &ident, &ctx);
>  	if (!log->summary) {
>  		if (log->user_format)
>  			pretty_print_commit(&ctx, commit, &oneline);
>  		else
>  			format_commit_message(commit, "%s", &oneline, &ctx);
>  	}
>  
> -	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
> +	insert_one_record(log, ident.buf, oneline.len ? oneline.buf : "<none>");
>  
> -	strbuf_release(&author);
> +	strbuf_release(&ident);
>  	strbuf_release(&oneline);
>  }
