Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB3C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhLZSr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 13:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLZSr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 13:47:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2395C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 10:47:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j21so53832370edt.9
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=caHn/KndxhuoeFf7HwW1fqWqEePKBjB6VBnru3dxUZI=;
        b=dI+LDGx0ZX1GGRp7DZDigXzBZHQPJNJphnRbX5AFQruRk7jQY8MkLFklPTSPqtujf4
         eY+MlGxBzcRpME/GPEwFK8NR/HkUxb/2MoK6v9R3innjguUu2tEWwRxJYj63plZP/GmZ
         9XYBu0OBwkj+gDxIYbCDrwEm7mdtqzAgoJYqWlIGVwtvFCDAkkPx/xSmA90fFx4E68go
         dFrGETnjzFTyPNfeS8ucxhRGM8VGs9wf/2jGzDlUy1+WOwF1/4BUfkB+bIWwYHRXwAOS
         VTBPfYKqCxBW5Z++qN3PrNSH+q5tnlvBBBjVuDsIzGwd7kX3/sheLT5JwbqfSJDhzD/e
         gAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=caHn/KndxhuoeFf7HwW1fqWqEePKBjB6VBnru3dxUZI=;
        b=itGLj1hFvhQZOOBvB9sDQDR9tfJHtJnO8JtAowbEv8Zpu+JFeYFVFDL4N8us+rPzbs
         23yvfg77VCDbWpZJFXdkxM9m0JM5Pm7Ry/UUDnvleOA+sL56zNbu2JRWdqY7yMDL45VU
         sAPuv2zgIx/qnyBq4e1QZjT8dX0ma7L58TnbXqMtI3W/TGAFa4rbAAZ3cJBlGPnAysW4
         TaSfIbRBrUru1wxp8UGHyLqymFsl6QLP0cjF3qQ+RYY0Sp4y6PSfAvXf68zvYDRskKm1
         7YqsDr9+gZTOZCyriCKjtW16TRB5XjC0DiXQKCSnDI6257jQJUpvaGbXuqWJ0kn3wG9P
         bdiQ==
X-Gm-Message-State: AOAM5303ax9H6k3q0cTw7TFAH6ZB62GGvmoRNenwni92Cca3kv3qdz9I
        tibWGYo+1uKc3tbpan9U2QjjiHNch4PIjQ==
X-Google-Smtp-Source: ABdhPJyZ9mkfBHmAO33yHhyQdgR2gyi6aSRNgomn5JrqewpPBXXQQsazyEapZbiNdsS1M64i7/Mi9Q==
X-Received: by 2002:a05:6402:849:: with SMTP id b9mr13748796edz.151.1640544445772;
        Sun, 26 Dec 2021 10:47:25 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z7sm5365405edb.59.2021.12.26.10.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 10:47:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1YYG-000BnR-6R;
        Sun, 26 Dec 2021 19:47:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: In-tree strbuf "in-place" search/replace (was: [PATCH v2 6/8]
 merge-ort: format messages slightly different for use in headers)
Date:   Sun, 26 Dec 2021 19:30:34 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <887e46435c0561e86f1858682fe53e9de926b69c.1640419160.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <887e46435c0561e86f1858682fe53e9de926b69c.1640419160.git.gitgitgadget@gmail.com>
Message-ID: <211226.86tuevfbk3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 25 2021, Elijah Newren via GitGitGadget wrote:

> @@ -634,17 +634,46 @@ static void path_msg(struct merge_options *opt,
>  		     const char *fmt, ...)
>  {
>  	va_list ap;
> -	struct strbuf *sb = strmap_get(&opt->priv->output, path);
> +	struct strbuf *sb, *dest;
> +	struct strbuf tmp = STRBUF_INIT;
> +
> +	if (opt->record_conflict_msgs_as_headers && omittable_hint)
> +		return; /* Do not record mere hints in tree */
> +	sb = strmap_get(&opt->priv->output, path);
>  	if (!sb) {
>  		sb = xmalloc(sizeof(*sb));
>  		strbuf_init(sb, 0);
>  		strmap_put(&opt->priv->output, path, sb);
>  	}
>  
> +	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
> +
>  	va_start(ap, fmt);
> -	strbuf_vaddf(sb, fmt, ap);
> +	strbuf_vaddf(dest, fmt, ap);
>  	va_end(ap);
>  
> +	if (opt->record_conflict_msgs_as_headers) {
> +		int i_sb = 0, i_tmp = 0;
> +
> +		/* Copy tmp to sb, adding spaces after newlines */
> +		strbuf_grow(sb, 2*tmp.len); /* more than sufficient */
> +		for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
> +			/* Copy next character from tmp to sb */
> +			sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
> +
> +			/* If we copied a newline, add a space */
> +			if (tmp.buf[i_tmp] == '\n')
> +				sb->buf[++i_sb] = ' ';
> +		}
> +		/* Update length and ensure it's NUL-terminated */
> +		sb->len += i_sb;
> +		sb->buf[sb->len] = '\0';
> +
> +		/* Clean up tmp */
> +		strbuf_release(&tmp);
> +	}
> +
> +	/* Add final newline character to sb */
>  	strbuf_addch(sb, '\n');
>  }
>  

I'm not saying this is wrong or needs to change. Just a reader's note
that this sent me on an interesting journey of looking at various
in-tree callers of strbufs that want to do the equivalent of
s/$from/$to/ on a strbuf, with and without the equivalent of /g.

I figured I'd change the $subject since this is more of a general
musing...

In trailer.c we've got strbuf_replace(), which looks like it could be
made to be general enough to serve most callers if it did a memmem()
instead of a strstr(), and knew to take a "all" flag to implement a /g.

We then have e.g. lf_to_crlf() in imap-send.c, which uses a newly
alloc'd buffer followed by a strbuf_attach(), which is a common pattern.

Then strbuf_reencode() in strbuf.c basically solves this problem, and
calls reencode_string_len(), both it and the underlying function are
*almost* general enough to know to take some "from/to" string/length
pair, i.e. to not be bound to "reencoding" only with iconv().

Then there's strbuf_add_percentencode() and strbuf_add_urlencode() whose
API users might be happy with in-place replacing, but do a
read-and-copy-maybe-expand.

It might be an interesting follow-up project for someone to come up with
a generic in-place search-replace function with a signature like:

	int strbuf_replace(struct strbuf *sb, const char *from,
			   size_t from_len, const char *to,
			   size_t to_len, int max);

To do e.g. in this case:

	if (opt->record_conflict_msgs_as_headers)
		strbuf_replace(sb, "\n", strlen("\n"), "\n ", strlen("\n "), -1);

The various in-tree implementations do some variant of over-mallocing to
save work in the loop (as is being done here), copying where a small
realloc/memmove might do, scanning the string to figure out how much to
malloc, then copying in a second pass etc.
