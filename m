Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB8D1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbfBDV5F (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:57:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40129 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfBDV5F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:57:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so1565345wmf.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=10RbCbSrPMSlAIBileBnD15M7nervRlYpB4y1Rw10l8=;
        b=J+tu+Os+zXIvHmTCu0EdFA5H+Ld1CS7Q49btKMUtOfH6GaU7SuJHFqSdqGeG/qmzCV
         TYdvczCsh6Gt9m9XWMILfxxBP+SyTtXOnu0h6XjqhrO2z2FFl1GNdxAvisLMosD5h2jb
         YHKANZpWrmItG1YEl0RcnzBJJdG7JI0ZiYzIcAlOE9gwtxMXVIxCRwnNaF6+SjGWg5cM
         KS2UDsIAvvkXkB7u9TFFnd/JrunQ8e6Pnhl7l9YGmeoT4eIKTsmBEpNtyujBxXSjon2L
         bfZfq6/7OBU8n0ehhFgxe7H/lAkvSd5yZwLuBTT0/NFS0/z9m/a0g8AA/TaxR743EoQu
         2gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=10RbCbSrPMSlAIBileBnD15M7nervRlYpB4y1Rw10l8=;
        b=cfuDgQro93HcAGUhhWE7cLtOy5zUhDiHcio4bP8b7vecWt4AWdii64k4OM6gd9zOur
         bELMuB6h59gImgPfn/RwbyMYIU9sIdlWpzIwX0RTyno4s9HNpD2+1h4LnhlhhoUQUSYx
         /8XawlAvsKWbF/9uKFWloxy9/QYiQjjve8j0+xQhXI8zV8EaniVtIKJeXtY1KrIBIBRG
         q+fgzJsDw47XCjR8U1dz21df7oUY7pJMuieixSYJacAdlzaji/Yqtf5CWEzFUIRUKljx
         cjtHrNmF6Mf42FwwPA7geJdAwS9KvkJssjvTDq/5ETRy8INR+hHgosnhZKChYtVylx7G
         fA6g==
X-Gm-Message-State: AHQUAuZuWMWkR7toHfxIfXRsCfWLvyiRuOXrB5Gne9hFOYoJ0nRuEIwP
        UpaoTJWgN4+WLPp3ErIy0t4=
X-Google-Smtp-Source: AHgI3IYEKxzjbghy7Kl1LElx0Op7iG7hAEKiuJ6EzYw1F/TGwH54sRc2YC3Mk+1B0jQdPD4XZvswCQ==
X-Received: by 2002:a1c:e911:: with SMTP id q17mr1135474wmc.31.1549317423329;
        Mon, 04 Feb 2019 13:57:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t4sm15723262wrb.64.2019.02.04.13.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:57:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer size to vsnprintf
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
Date:   Mon, 04 Feb 2019 13:57:02 -0800
In-Reply-To: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org> (Johannes Sixt's
        message of "Sun, 3 Feb 2019 17:51:54 +0100")
Message-ID: <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> strbuf_vinsertf inserts a formatted string in the middle of an existing
> strbuf value. It makes room in the strbuf by moving existing string to
> the back, then formats the string to insert directly into the hole.
>
> It uses vsnprintf to format the string. The buffer size provided in the
> invocation is the number of characters available in the allocated space
> behind the final string. This does not make any sense at all.
>
> Fix it to pass the length of the inserted string plus one for the NUL.
> (The functions saves and restores the character that the NUL occupies.)
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I found this, because in my environment I have to compile with
>  SNPRINTF_RETURNS_BOGUS. Our implementation of vsnprintf in
>  compat/snprintf.c writes into the end of the buffer unconditionally,
>  at a spot that is unrelated to the formatted string, and this leads to
>  "BUG: a NUL byte in commit log message not allowed" in some "stash"
>  tests.

An embarrassing indication that not every line is read during
development or review with fine toothed comb.  I guess it won't
trigger without the returns-bogus thing, and the "testing" done on
platforms did not help.

Thanks for finding it.  This needs to be squashed into bfc3fe33
("strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`",
2018-12-20)?

As you mention in the direct response of this message, it might make
sense to get rid of the helper with YAGNI, but that's something we
need to see what its potential users should be doing (note: I did
not say "what its potential users are doing").

It could turn out that there may be many places that could use this
helper, but it may merely be an indication that these many places
are structured poorly to compute the "shell" string too early before
the string to be inserted becomes computable, in which case the real
fix may not be to use this helper but to change the order of
building up the string.  Perhaps we want a string that is
concatenation of part #1, part #2 and part #3, but we somehow first
compute concatenation of part #1 and part #3 in a buffer, which
requires us to insert part #2 in between.  If we restructure the
code to keep parts #1 and #3 separate, or delay computing part #3,
until part #2 becomes available, that would fix the "potential
users" in a better way without having to make calls into this
helper, for example.


>  strbuf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index bfbbdadbf3..87ecf7f975 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -270,7 +270,7 @@ void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
>  	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
>  	/* vsnprintf() will append a NUL, overwriting one of our characters */
>  	save = sb->buf[pos + len];
> -	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
> +	len2 = vsnprintf(sb->buf + pos, len + 1, fmt, ap);
>  	sb->buf[pos + len] = save;
>  	if (len2 != len)
>  		BUG("your vsnprintf is broken (returns inconsistent lengths)");
