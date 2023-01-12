Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F88C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjALKLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjALKLB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 05:11:01 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A8634B
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:07:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so43430541ejm.8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1gcDEGXvA/gXHNfOSyjn/slg+yYssizWDVPQ9thF+8=;
        b=YfFa4M3BOfUw1xHZp4MLoZ5JGFsi4udtCTmumUoqYy0zQrqQp6Dmlxtbkws0COGRKn
         NfiEaEJHahKbUP35+WIVuJNNAoDkPTIC7MGpEGLObXBH42xrPJ+gxTyD3ggtkvITNo4E
         IyyDFL6Cgl5djr7QvvDLZIo057zn38eOOVUcoqVu8z0vDtmiTK+0filTGd/leL9wja8f
         jCdXtbEiQSzv5dd36cpdOaxvBdNUGIynBwLOTOZT8dp+1h76dOiI5XrbRxNM1IrZ7wDh
         lO4jSFVMyT1GLn55fPJbxKk8nzbkk3erTH1QMmoXSe7IDiw/InpmN9m38E31r9qyIeJu
         lBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1gcDEGXvA/gXHNfOSyjn/slg+yYssizWDVPQ9thF+8=;
        b=4QITB5Ys3lDLdD7fsElxkXVz9Dv0yHWDpInWQgHptXrx5ET6mT20mPZJAF+gDnry5b
         eHZzKDbV6rgEkvVFTgngyKVlZ6FNku6Otcu7+ggrmsbDU63QPMrdxBsTmpEJKF2RlI1H
         wzEELJ9F0TbXc5ZYAaNCk4c1ZBPhN1KWndRvZhaC34vgijzdOH0t41dhqB4bDW/YV3SV
         zdXLDH4o3Gh9qf0UcbHjh7ZVeueJOpK4vtAeQ20VgRKXLFfns483LN93eQ4FWOoFoHDp
         aeI/NWLrn81+WS+Or5ELXdeSm7VVQWT2K87YSld8Aun0LMV0wN5DWscciNQKbyGi46bP
         S/fQ==
X-Gm-Message-State: AFqh2kpPoBDAieBqBE3vIB+hvYEqAlpX9AezDHyFxhZrTLaVsv5PT2fc
        W9qpG4bt6XKPiZ+171nO+0A=
X-Google-Smtp-Source: AMrXdXuqimrsM69li83fDBE3jluowM+0dmuWLoUhhMDvGPR2ElFBylfSldOYHIpvgKORGyc0essDOA==
X-Received: by 2002:a17:906:184a:b0:78d:f456:1ed0 with SMTP id w10-20020a170906184a00b0078df4561ed0mr73341841eje.33.1673518036388;
        Thu, 12 Jan 2023 02:07:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090611d300b008373f9ea148sm7284471eja.71.2023.01.12.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:07:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFuUN-0007TU-14;
        Thu, 12 Jan 2023 11:07:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v4 5/5] notes.c: introduce "--separator" option
Date:   Thu, 12 Jan 2023 10:53:04 +0100
References: <cover.1673490953.git.dyroneteng@gmail.com>
 <f7edbd0e508243ab55c13721a21b78bf50278a21.1673490953.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <f7edbd0e508243ab55c13721a21b78bf50278a21.1673490953.git.dyroneteng@gmail.com>
Message-ID: <230112.86y1q812y4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> When appending to a given notes object and the appended note is not
> empty too, we will insert a blank line at first which separates the
> existing note and the appended one, which as the separator.
>
> Sometimes, we want to use a specified <text> as the separator. For
> example, if we specify as:
>
>     * --separator='------': we will insert "------\n" as the separator,
>     because user do not provide the line break char at last, we will add
>     the trailing '\n' compatibly.
>
>     * --separator='------\n': we will insert as-is because it contains
>     the line break at last.
>
>     * --separator='': we specify an empty separator which means will
>     append the message directly without inserting any separator at
>     first.
>
>     * not specified --separator option: will use '\n' as the separator
>     when do appending and this is the default behavour.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-notes.txt | 18 +++++++++--
>  builtin/notes.c             | 49 +++++++++++++++++++++++++++---
>  t/t3301-notes.sh            | 59 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index efbc10f0f5..227fa88317 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git notes' [list [<object>]]
>  'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>  'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
> -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' append [--allow-empty] [--separator] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>  'git notes' edit [--allow-empty] [<object>]
>  'git notes' show [<object>]
>  'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
> @@ -86,7 +86,11 @@ the command can read the input given to the `post-rewrite` hook.)
>  
>  append::
>  	Append to the notes of an existing object (defaults to HEAD).
> -	Creates a new notes object if needed.
> +	Creates a new notes object if needed. If the note of the given
> +	object and the note to be appended are not empty, a blank line
> +	will be inserted between them as the separator ("blank line" is
> +	the default behavior, `--separator` option supports to specify
> +	a customized one).

I think this should change to:

	[...]will be inserted between them. Use the `--separator` option
	to insert other delimiters.

I.e. part of that's fixes for odd grammar, but mainly just offloading
the explanation to the --separator discussion below.


>  
>  edit::
>  	Edit the notes for a given object (defaults to HEAD).
> @@ -159,6 +163,16 @@ OPTIONS
>  	Allow an empty note object to be stored. The default behavior is
>  	to automatically remove empty notes.
>  
> +--separator <text>::
> +	Specify the <text> to be inserted between existing note and appended
> +	message, the <text> acts as a separator.

Maybe let's use '<string>' or '<separator>' here instead? e.g.:

	Specifies the <string> ...

Maybe "<text>" just looks odd to me.

More generally, let's say something like:

	When invoking "git notes append", specify the...

I.e. this is only for "append", but nothing here says so.

> +	If <text> is empty (`--separator=''`), will append the message to
> +	existing note directly without insert any separator.
> +	If <text> is nonempty, will use as-is. One thing to notice is if
> +	the <text> lacks newline charactor, will add the newline automatically.
> +	If not specify this option, a blank line will be inserted as the
> +	separator.


We're spending a lot of text here on a pretty simple concept if I
understand it correctly, I.e. just (pseudocode):

	int sep_extra_nl = 0;
	const char *sep = opt_sep ? opt_sep : "\n";
	if (!strstr(sep, '\n'))
		sep_extra_nl = 1;
	[...]

Except that was written after I read your explanation, but looking at
the code it's incorrect, it's whether the "*last*" character contains a
newline or not.

So all in all, I think we should just say:

	--separator <separator>:
		The '<separator>' inserted between the note and message
		by 'append', "\n" by default. A custom separator can be
		provided, if it doesn't end in a "\n" one will be added
		implicitly .

> +
>  --ref <ref>::
>  	Manipulate the notes tree in <ref>.  This overrides
>  	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
> diff --git a/builtin/notes.c b/builtin/notes.c
> index f2efb3736c..6746ad3232 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -24,6 +24,8 @@
>  #include "notes-utils.h"
>  #include "worktree.h"
>  
> +static char *separator = "\n";
> +
>  static const char * const git_notes_usage[] = {
>  	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
>  	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
> @@ -209,7 +211,7 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
>  	}
>  }
>  
> -static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
> +static int parse_msg_arg_add(const struct option *opt, const char *arg, int unset)
>  {
>  	struct note_data *d = opt->value;
>  
> @@ -225,6 +227,43 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static void insert_separator(struct strbuf *message)
> +{
> +	const char *insert;
> +
> +	if (!separator)
> +		separator = "\n";
> +	if (*separator == '\0')

Style: Don't compare to 0, NULL, '\0' etc. Just use !*separator.

> +		/* separator is empty; use as-is (no blank line) */
> +		return;
> +	else if (separator[strlen(separator) - 1] == '\n')
> +		/* user supplied newline; use as-is */
> +		insert = separator;
> +	else
> +		/* separator lacks newline; add it ourselves */
> +		insert = xstrfmt("%s%s", separator,"\n");

We're leaking memor here, and making it hard to fix that by conflating a
const "insert" with this allocated version.

I haven't read the whole context, but this seems really complex per the
doc feedback above. Why can't we just keep track of if we're using the
default value or not? I.e. just have the "--separator" option default to
NULL, if it's not set y ou don't need to do this "\n" check, and just
use the default, otherwise append etc.

> +	strbuf_insertstr(message, 0, insert);

Maybe you were trying to get around using a more complex strbuf_splice()
here, but let's just avoid teh xstrfmt() and splice() that "\n" in, if
needed?

> +}
> +
> +static int parse_msg_arg_append(const struct option *opt, const char *arg, int unset)
> +{
> +	struct note_data *d = opt->value;
> +	struct strbuf append = STRBUF_INIT;
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	strbuf_addstr(&append, arg);
> +	if (d->buf.len){
> +		insert_separator(&append);
> +	}

Drop the {} here.

> +	strbuf_addbuf(&d->buf, &append);
> +	strbuf_stripspace(&d->buf, 0);
> +
> +	d->given = 1;
> +	strbuf_release(&append);

Why do we need this other variable, canet'w just append to d.buf
directly?

Do we mean to strbuf_stripspace() here over the whole buffer, or just
what we're appending?
