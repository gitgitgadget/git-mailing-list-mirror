Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F7C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 18:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjBWSVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 13:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBWSVc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 13:21:32 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA65A3B9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:21:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id bh1so14046842plb.11
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPiLufxXrSP9Lfcx/66/lHR3XvaahhitlWjr9k/R3KU=;
        b=BIW+Y/uyknwZM2mKazrXSpd+CkoQLYyeGHPl722sa3Xf0w/ot162A8XbFZJNzMj3qC
         4GtHRNid1zlRRguOJovIEIha9IqCleKuPKXtxDrNIZfZWj1jBcqSj6F29LVga8ERNhlu
         eCFmx3ut8YUEkUWViH40UdqztODoxHbsoIYj1DGPwAHVXrfNaWjxh7EuFsLWeoef6Bda
         cfOlKfim+xSe56puQ8XIOa2XUCbNu28Wew/zseyKPCv1lOtGmz1QbisYU/S4lmao9KCL
         rwIX+vcjgF9IZqs/KLBBKYKmLfTLV5PQ8ZAssI6hR0VEQ/Vif9Yn/CBjj1lhMI7DdUJM
         Z78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPiLufxXrSP9Lfcx/66/lHR3XvaahhitlWjr9k/R3KU=;
        b=ZQ+d10ATUL8+/Er5NRtWlRs6zQSb+NeSvCSVQmWAL8nue/Q2i/slVFgoKYdDRcyPjx
         eGBkExujDcm0wQw3xz7j+To67gB9y3HwkAkbFH4Ar5f6dqyTPSd1Lj8eyBOyimex+y5m
         KUOax4XwMv6m1KOdWJKXdcM/Tx7yA8tBSuWubOH7M/5l/kv4tHlxoUuP//qqYY6p1h9i
         uMrPgrSXM7Qmxu+Cwo9YQqLvUD5jysjXrmVNBcoAwClxu+Ih6p0q2EetXn2u/IMCpEGl
         h2snh151dfpP26ipgvdxvgQKIzjyhCSZQNFuqQ1MHV/cMYvJ5soSn4AzxwnfIHbFrtfS
         PFoA==
X-Gm-Message-State: AO0yUKVztNwSehYIijQnVDBtev+uoLyMwOsYGVjia04ZzxzEgIvdcO+h
        zYXQF9/yI2pT8X1L6EfHtos=
X-Google-Smtp-Source: AK7set9kYq9MQaWxFu8oqw1VQVlRTWCxcLKiGDzMXTIka2c+rZd2RuRiWsDb9MjO5EenTaVeOMXt/w==
X-Received: by 2002:a05:6a20:4290:b0:c7:27e8:20f3 with SMTP id o16-20020a056a20429000b000c727e820f3mr13430837pzj.10.1677176488610;
        Thu, 23 Feb 2023 10:21:28 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id n18-20020a638f12000000b00502fd141ffbsm1176166pgd.49.2023.02.23.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:21:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 3/3] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1677136319.git.dyroneteng@gmail.com>
        <d5a6c74792c15e2f83c2ed0758fb99eac11a8174.1677136319.git.dyroneteng@gmail.com>
Date:   Thu, 23 Feb 2023 10:21:27 -0800
In-Reply-To: <d5a6c74792c15e2f83c2ed0758fb99eac11a8174.1677136319.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 23 Feb 2023 15:29:47 +0800")
Message-ID: <xmqqcz608cpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> So this commit
> introduces a new '--separator' option for 'git-notes-add' and
> 'git-notes-append', for example when execute:

    Introduce a new '--separator' option for 'git notes add' and
    'git notes append'.

> We will check the option value and if the value doesn't contail
> a trailing '\n', will add it automatically,

contail?

	A newline is added to the value given to --separator if it
	does not end with one already.

> so execute
>       $ git notes add -m foo -m bar --separator="-"
> and
>       $ export LF="
>       "
>       $ git notes add -m foo -m bar --separator="-$LF"
>
> have the same behavour.

	Running A and B produces the same result.

> +	subcommand). If you specify multiple `-m` and `-F`, a blank
> +	line will be inserted between the messages. Use the `--separator`
> +	option to insert other delimiters. 

Concise and readable.  Nice.

> @@ -86,7 +88,13 @@ the command can read the input given to the `post-rewrite` hook.)
>  
>  append::
>  	Append to the notes of an existing object (defaults to HEAD).
> -	Creates a new notes object if needed.
> +	Creates a new notes object if needed. 
> +	The default delimiter is a blank line, use the `--separator`

Re-read the above three lines, pretending that it is already 6
months and you've forgotten about adding the feature yourself.

Notice something?

A reader with fresh mind would read and think along the description
but

 - OK, append command is used to append to the note to an existing
   object;

 - OK, if the object does not have a note yet, we will create one;

 - The default delimiter?  Delimiter for what?  I am puzzled.

at the third step, gets puzzled.  The command takes the existing
note's contents, adds a delimiter and then appends the new material
given by the user, but because that is not clear after reading the
first two lines, the sudden appearance of "delimiter" would confuse
readers.

> +	option to insert other delimiters. More specifically, if the
> +	note and the message are not empty, the delimiter will be
> +	inserted between them. If you specify multiple `-m` and `-F`

Again, the order of presentation is somewhat backwards and that is
why we need to say "More specifically" here.

> +	options, the delimiter will be inserted between the messages
> +	too.

	Append new message(s) given by `-m` or `-F` options to an
	existing note, or add them as a new note if one does not
	exist, for the object (defaults to HEAD).  When appending to
	an existing note, a blank line is added before each new
	message as an inter-paragraph separator.  The separator can
	be customized with the `--separator` option.

or something along that line, perhaps?

> +--separator <paragraph-break>::
> +	The '<paragraph-break>' inserted between paragraphs.
> +	A blank line by default.

Here is where you need to say about promoting incomplete line
separator more than the proposed log message.

	Specify a string used as a custom inter-paragraph separator
	(a newline is added at the end as needed).  Defaults to a
	blank line.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 553ae2bd..e0ada862 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -24,11 +24,12 @@
> ...
> +static void insert_separator(struct strbuf *message, size_t pos)
> +{
> +	if (!separator)
> +		strbuf_insertstr(message, pos, "\n");
> +	else if (separator[strlen(separator) - 1] == '\n')
> +		strbuf_insertstr(message, pos, separator);
> +	else
> +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> +}

It looks like you are very fond of "insert", but aren't we always
appending with the latest control flow?  In other words, is it worth
carrying 'pos' around?

> +static void parse_messages(struct string_list *messages, struct note_data *d)
> +{
> +	size_t i;
> +	for (i = 0; i < messages->nr; i++) {
> +		if (d->buf.len)
> +			insert_separator(&d->buf, d->buf.len);
> +		strbuf_insertstr(&d->buf, d->buf.len,
> +				 messages->items[i].string);
> +		strbuf_stripspace(&d->buf, 0);

This is not a new problem, but if we get three 100-byte messages, we

 - add the first 100-byte message to d->buf and then run
   stripspace() over that 100-byte.

 - add separator and then the second 100-byte message to d->buf, and
   then run stripspace() over that 200-plus-byte.

 - add separator and then the third 100-byte message to d->buf, and
   then run stripspace() over that 300-plus-byte.

Shouldn't we be doing better?

> +		d->given = 1;

Do we understand what d->given flag represents?  My understanding is
that it becomes true only when any of the -m/-F/-c/-C options are given
to tell the command what message to use, so that we can automatically
open the editor to ask for the message when nothing is given.

So, I suspect that

	d->given = !!messages->nr;

at the beginning of the function, or

	d->given = !!d->buf.len;

may be equivalent[*], instead of setting it once every iteration?

	Side note: The latter is slightly more strict, as giving a
	run of empty strings with the default separator would result
	in an empty d->buf and d->given will become false.

> +	}
> +}

This helper is not parsing, but just processing after the whole
thing was parsed.  "parse_messages" -> "concatenate_messages" or
something, perhaps?

Now d->given is set in parse_reuse_arg() and parse_reedit_arg(),
because -c/-C is another source of a paragraph.  Shouldn't the
paragraph taken by these options go in the message list to be
concatenated together with other messages, or are -c/-C incompatible
with -m/-F and we are OK with two separate and distinct behaviour?

>  static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  {
> -	struct note_data *d = opt->value;
> +	struct string_list *msg = opt->value;
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	if (d->buf.len)
> -		strbuf_addch(&d->buf, '\n');
> -	strbuf_addstr(&d->buf, arg);
> -	strbuf_stripspace(&d->buf, 0);
> -
> -	d->given = 1;
> +	string_list_append(msg, arg);
>  	return 0;
>  }

OK, this one now does not concatenate; just accumulates to the "msg"
string list.

>  static int parse_file_arg(const struct option *opt, const char *arg, int unset)
>  {
> -	struct note_data *d = opt->value;
> +	struct string_list *msg = opt->value;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	if (d->buf.len)
> -		strbuf_addch(&d->buf, '\n');
>  	if (!strcmp(arg, "-")) {
> -		if (strbuf_read(&d->buf, 0, 1024) < 0)
> +		if (strbuf_read(&buf, 0, 1024) < 0)
>  			die_errno(_("cannot read '%s'"), arg);
> -	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
> +	} else if (strbuf_read_file(&buf, arg, 1024) < 0)
>  		die_errno(_("could not open or read '%s'"), arg);
> -	strbuf_stripspace(&d->buf, 0);
>  
> -	d->given = 1;
> +	string_list_append(msg, buf.buf);
> +	strbuf_release(&buf);
>  	return 0;
>  }

Ditto.

> @@ -418,6 +438,8 @@ static int add(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "allow-empty", &allow_empty,
>  			N_("allow storing empty note")),
>  		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
> +		OPT_STRING(0, "separator", &separator, N_("separator"),
> +			N_("insert <paragraph-break> between paragraphs")),
>  		OPT_END()
>  	};
>  
> @@ -429,6 +451,7 @@ static int add(int argc, const char **argv, const char *prefix)
>  		usage_with_options(git_notes_add_usage, options);
>  	}
>  
> +	parse_messages(&messages, &d);

Yup, this one is "concatenate_messages".  We do not read the
existing one, we accumulated everything the user gave us in
messages, and concatenate them using the separator.  The result
is stored in d->buf.

I wonder why separator is not a parameter into the helper function?


In short, I think handling of -m/-F got vastly better from the
previous rounds in this version, but I am not sure about the only
other remaining "strbuf_addch(&d->buf, '\n')" in parse_reuse_arg().
I am inclined to say that that codepath should behave the same way,
but I didn't think it as deeply as you did, so...?

Thanks.
