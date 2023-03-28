Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3695BC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 15:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjC1Pjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjC1Pje (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 11:39:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E8BB755
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 08:37:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o11so12077418ple.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680017879;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AZ2Is6x4xeCxn1OKsjcZfmLkYlHUbAbLc/hPQGQeGE=;
        b=CN6Uzsu/1qe/VjLVE+jcFcCb5BKyPU1qOBpHPDs3Co3RQ9s95I+FPM2rbXPJZCZ+Gy
         B3RtvwtyHPRr4Z9CIbSpAxmkBH8m+UzFUbTQvk4mf071eCi6K5YrCSDvw6pffF8JeHAS
         HATjMw2j/tTf63BU2NO2QQ83WVFpyRYU+zVeKKMKXLvoL3T0/ZLL1TueX1JEHU8zsD32
         cLLOqu6koNAKv4hBOk2Pn4V5RD2JCgdONYKGPuamw3WZEmBJ3jxoDniGozSepdCLEhVY
         uGMi89BrlPS2KyXvvmvNKQO3n3JEEO1dAtupDt5qco9RLecOs+gysZAf4InIAeWv5gE3
         FKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017879;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+AZ2Is6x4xeCxn1OKsjcZfmLkYlHUbAbLc/hPQGQeGE=;
        b=Bo5Fn2uSCNrdgpvcY+N1RIxCHJ6eqq1H5hgaJ+2v4FjMkDFPAU3ckGEivBvsdsnyWi
         7Jr6du9mIEyal8zlJ4iJ6iGvWZ1JSg8TNbjICpN8Phiq2zVAtnxJ8efuY89G6ESdt6zr
         FqClctXpoxgaJcBFl4f29aNva0DVQyRzU3p7boD7Iek51mCOJsYHG+ytb+pMUEUF0+Yy
         TTS3PPcfzTHJRTOkbKzLIfYiFGWbnJJKX2UJOdDNrtraighuv8JZ7AG97Osi2woxRtxC
         hxnKX3cpHY/xNGhWUvrjCqRcvwYB8htyCzOEwSy327pnJwB7E/1gMoHp4JPPAxqLoiBT
         GR2Q==
X-Gm-Message-State: AO0yUKUVEO0DR8XwV3zJmpJHPGp4/Y8un+36+2d6OXu6LlQDjAAZfHVh
        NJLj0dif3LjU2YzunC3CQaw=
X-Google-Smtp-Source: AK7set9L7VcUInZ5r1oqL41WqicLHF5MuhzM1tRsjzYKoGbzAiULVF1A7y/V6VMqp5PVlWyzAIyhRw==
X-Received: by 2002:a05:6a20:1e58:b0:db:9537:2c3 with SMTP id cy24-20020a056a201e5800b000db953702c3mr15398836pzb.34.1680017878592;
        Tue, 28 Mar 2023 08:37:58 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78e51000000b00627fea66a4asm16473395pfr.39.2023.03.28.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:37:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 3/4] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1680012650.git.dyroneteng@gmail.com>
        <d1febf86d8471c24c9a045d6962fd86f63f414d5.1680012650.git.dyroneteng@gmail.com>
Date:   Tue, 28 Mar 2023 08:37:58 -0700
In-Reply-To: <d1febf86d8471c24c9a045d6962fd86f63f414d5.1680012650.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 28 Mar 2023 22:28:46 +0800")
Message-ID: <xmqq5yakhoo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> When adding new notes or appending to an existing notes, we will
> insert a blank line between the paragraphs, like:
>
>      $ git notes add -m foo -m bar
>      $ git notes show HEAD | cat
>      foo
>
>      bar
>
> The default behavour sometimes is not enough, the user may want
> to use a custom delimiter between paragraphs, like when
> specifiy '-m', '-F', '-C', '-c' options. So this commit

"like when specifying", you mean?

> introduce a new '--separator' option for 'git notes add' and
> 'git notes append', for example when execute:

"when executing"?

>     $ git notes add -m foo -m bar --separator="-"
>     $ git notes show HEAD | cat
>     foo
>     -
>     bar
>
> A newline is added to the value given to --separator if it

"a newline is ...", because this is not starting a new sentence, but
continuing from the "for example, when ..." above.

> does not end with one already. So execute:
>
>       $ git notes add -m foo -m bar --separator="-"
> and
>       $ export LF="
>       "
>       $ git notes add -m foo -m bar --separator="-$LF"
>
> Running A and B produces the same result.

Here, it is totally unclear what A and B refers to.  "both
... and ... produce the same result" or something?

> @@ -85,8 +87,12 @@ corresponding <to-object>.  (The optional `<rest>` is ignored so that
>  the command can read the input given to the `post-rewrite` hook.)
>  
>  append::
> -	Append to the notes of an existing object (defaults to HEAD).
> -	Creates a new notes object if needed.
> +	Append new message(s) given by `-m` or `-F` options to an
> +	existing note, or add them as a new note if one does not
> +	exist, for the object (defaults to HEAD).  When appending to
> +	an existing note, a blank line is added before each new
> +	message as an inter-paragraph separator.  The separator can
> +	be customized with the `--separator` option.

Excellent.

> @@ -101,6 +102,9 @@ struct note_data {
>  	int use_editor;
>  	char *edit_path;
>  	struct strbuf buf;
> +	struct strbuf **messages;
> +	size_t msg_nr;
> +	size_t msg_alloc;
>  };

Hmph, OK.  I'd think twice before allowing an array of strbufs,
though.  strbuf is an excellent data structure to allow editing
string safely, and an array of strbufs may be very useful when these
strings need to be edited simultaneously, but such a use case is
very rare and I suspect this would not be it---rather, don't we take
one string at a time while processing each option, perhaps running
stripspace, and then after that aren't we done with the string until
when we finally have these N strings to loop over and concatenate
into a single string?  It would be sensible to use a strbuf to
produce the concatenation, but the strings to be concatenated do not
have to come from strbufs.  So my intuition, before reading the code
but after seeing the data structure, says that "const char **messages"
might be more appropriate here.  It sends a strong message about the
code structure and "phases" of processing, i.e. "we read each piece
and store it in the array once we are done preprocessing; then in
the next phase we concatenate them".

> @@ -209,71 +213,110 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
>  	}
>  }
>  
> +static void insert_separator(struct strbuf *message, size_t pos)
> +{
> +	if (!separator)
> +		strbuf_insertstr(message, pos, "\n");
> +	else if (separator[strlen(separator) - 1] == '\n')
> +		strbuf_insertstr(message, pos, separator);
> +	else
> +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> +}

Do we need "insert" separator?  The caller in "concat" certainly
shouldn't---all it needs is "append".

> +/* Consume messages and append them into d->buf, then free them */
> +static void concat_messages(struct note_data *d)
> +{
> +	struct strbuf msg = STRBUF_INIT;
> +
> +	size_t i;
> +	for (i = 0; i < d->msg_nr ; i++) {
> +		if (d->buf.len)
> +			insert_separator(&d->buf, d->buf.len);
> +		strbuf_add(&msg, d->messages[i]->buf, d->messages[i]->len);
> +		strbuf_addbuf(&d->buf, &msg);
> +		strbuf_reset(&msg);
> +		strbuf_release(d->messages[i]);
> +		free(d->messages[i]);
> +	}
> +	strbuf_release(&msg);
> +	free(d->messages);
> +}

As I suspected earlier, with the way d->messages[i] are used, they
have no reason to be strbufs---they can and should be a simple
string "const char *".

>  static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  {
>  	struct note_data *d = opt->value;
> +	struct strbuf *buf;
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	if (d->buf.len)
> -		strbuf_addch(&d->buf, '\n');
> -	strbuf_addstr(&d->buf, arg);
> -	strbuf_stripspace(&d->buf, 0);
> +	buf = xmalloc(sizeof(*buf));
> +	strbuf_init(buf, strlen(arg));
> +	strbuf_addstr(buf, arg);
> +	strbuf_stripspace(buf, 0);
>  
> -	d->given = 1;
> +	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
> +	d->messages[d->msg_nr - 1] = buf;
>  	return 0;
>  }

And this one can use an on-stack strbuf (initialized with STRBUF_INIT),
and strbuf_detach() the result into d->messages[].

>  static int parse_file_arg(const struct option *opt, const char *arg, int unset)
>  {
>  	struct note_data *d = opt->value;
> +	struct strbuf *buf;

Likewise.

>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	if (d->buf.len)
> -		strbuf_addch(&d->buf, '\n');
> +	buf = xmalloc(sizeof(*buf));
> +	strbuf_init(buf, 0);
> +
>  	if (!strcmp(arg, "-")) {
> -		if (strbuf_read(&d->buf, 0, 1024) < 0)
> +		if (strbuf_read(buf, 0, 1024) < 0)
>  			die_errno(_("cannot read '%s'"), arg);
> -	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
> +	} else if (strbuf_read_file(buf, arg, 1024) < 0)
>  		die_errno(_("could not open or read '%s'"), arg);
> -	strbuf_stripspace(&d->buf, 0);
> +	strbuf_stripspace(buf, 0);
>  
> -	d->given = 1;
> +	// we will note stripspace the buf here, because the file maybe
> +	// is a binary and it maybe contains multiple continuous line breaks.

No // comments in our codebase.

> +	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
> +	d->messages[d->msg_nr - 1] = buf;
>  	return 0;
>  }

>  static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
>  {
> ...
>  }

Ditto.

> @@ -567,7 +617,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  	const struct object_id *note;
>  	char *logmsg;
>  	const char * const *usage;
> -	struct note_data d = { .buf = STRBUF_INIT };
> +	struct note_data d = { .buf = STRBUF_INIT, .messages = NULL };

Why explicitly initialize .messages to NULL when we are leaving
other members to zero initialized implicitly by using designated
initializers?

> @@ -618,7 +675,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		char *prev_buf = read_object_file(note, &type, &size);
>  
>  		if (d.buf.len && prev_buf && size)
> -			strbuf_insertstr(&d.buf, 0, "\n");
> +			insert_separator(&d.buf, 0);
>  		if (prev_buf && size)
>  			strbuf_insert(&d.buf, 0, prev_buf, size);
>  		free(prev_buf);

Having to insert two things in front of d.buf feels somewhat
wasteful.  I wonder if we can easily reorder the logic to first read
the previous one, and then append new stuff to it, perhaps?

It wouldn't be a huge deal.  If this weren't the only reason why we
need to invent insertstr that takes "where", I wouldn't even be
mentioning it.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 3288aaec..716192b5 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -5,6 +5,7 @@
>  
>  test_description='Test commit notes'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh

This is a strange commit to add this.  If the test and the code
involved in the test were leak-sanitizer clean before this commit,
then you should have been able to insert this without any other
change, and we should do it that way in a separate commit.  If we
are fixing an existing leak that the sanitizer complains, then that
is a different matter.  If that is the case, it makes perfect sense
to have this here, but the proposed commit log message should
explain that it is what is happening.

Other than that, looks very nicely done.

Thanks.
