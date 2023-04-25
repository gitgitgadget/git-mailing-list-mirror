Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB2AC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjDYReU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjDYReS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:34:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5572A2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:34:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so46854375ad.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682444056; x=1685036056;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YloGNwM4wWc4KtM1Rp6R2qZyIcy2RQK97CWY7cE6r0=;
        b=h7mObnnmwRmkx1W69aBWCd7ZF2cwv3H4ZofTLef8UtxTH7+7gy2xcQGqN9dDjXxth7
         qAwSTGLobAxn1JDhKwDZVSaV7wObknFK6LJl+c7P4zQayoAfT8ZWm3M6BIg+MIFdOusK
         MIK+BzB8H4z6zVSsqcaeLHmx16PXsJG2UngW8bdOJNEii3bPP4JATWwoN4XvkES+lr74
         iZ50gaORxOJX1SJkHT8veXoTDlVL97GE0z6ZZSTawIEGqN1AGYpfLDeQNtm+2aj2D7g+
         79gcK1akXistMV+hmWkXnw7t0OXaFYvPvPoyj6SBVwut7/Ym3disZq2b1sdgxMDHRwNq
         8hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444056; x=1685036056;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1YloGNwM4wWc4KtM1Rp6R2qZyIcy2RQK97CWY7cE6r0=;
        b=J3k6q2TjtpLhF4wXJx2RJeGzznnWwYZW7zomUinpsU3Gb975PIBIdT4k9LRWRu0S+6
         giAeG2v0CyiQLOPtZpZQpRxmYeMnzrF1g7oFw/7iWzagYIOyMd13w7e1YMj5nzbYIKm8
         Rpo26AzLxgvnctWJHDOtQ8t1aVk9/hR3JCdTOASQ/6xWTJUa1tRIIjXr/V+gVKUbPXdG
         ZEiPk8DuYpmT3Z7KrQ6a7cCgjQNtjsLOuMcd+9RgwgWWnuh/bfewgvaWrAtFBwbagW4F
         aouU15fv1Rzxj5KH6O2RqCzaljVeHyL5aHi2TyLyK3l2w2VarYjUAK3Eok3jcwSxrpML
         H87g==
X-Gm-Message-State: AAQBX9eBDqA3oS5i2r6zdW5cBWRuYdNabCB6R2o18q4W3hryR41fi8Oz
        T+i4nJQ+cZ/ypV6Gzz7A30E=
X-Google-Smtp-Source: AKy350ZUvtdbVTHbvbmaJU9Hs0qEh3pNstmnK6vE4lsUCLnNg3Ex7+TP4MrhvVOeveIxGLm/iyr6Gg==
X-Received: by 2002:a17:902:d4d1:b0:19a:9880:175f with SMTP id o17-20020a170902d4d100b0019a9880175fmr22070189plg.51.1682444056146;
        Tue, 25 Apr 2023 10:34:16 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jg20-20020a17090326d400b001a1a82fc6d3sm8517736plb.268.2023.04.25.10.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:34:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <be86f9cac3e651ab5aab49f89b6506012b756dab.1682429602.git.dyroneteng@gmail.com>
Date:   Tue, 25 Apr 2023 10:34:15 -0700
In-Reply-To: <be86f9cac3e651ab5aab49f89b6506012b756dab.1682429602.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 25 Apr 2023 21:34:39 +0800")
Message-ID: <xmqqsfcn27e0.fsf@gitster.g>
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
> specifying '-m', '-F', '-C', '-c' options. So this commit
> introduce a new '--separator' option for 'git notes add' and
> 'git notes append', for example when executing:
>
>     $ git notes add -m foo -m bar --separator="-"
>     $ git notes show HEAD | cat
>     foo
>     -
>     bar
>
> a newline is added to the value given to --separator if it
> does not end with one already. So when executing:
>
>       $ git notes add -m foo -m bar --separator="-"
> and
>       $ export LF="
>       "
>       $ git notes add -m foo -m bar --separator="-$LF"
>
> Both the two exections produce the same result.
>
> The reason we use a "strbuf" array to concat but not "string_list", is
> that the binary file content may contain '\0' in the middle, this will
> cause the corrupt result if using a string to save.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-notes.txt |  21 ++++--
>  builtin/notes.c             | 111 ++++++++++++++++++++++++-------
>  t/t3301-notes.sh            | 126 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 229 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index efbc10f0..59980b21 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -9,9 +9,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git notes' [list [<object>]]
> -'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>  'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
> -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' append [--allow-empty] [--separator=<paragraph-break>] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>  'git notes' edit [--allow-empty] [<object>]
>  'git notes' show [<object>]
>  'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
> @@ -65,7 +65,9 @@ add::
>  	However, if you're using `add` interactively (using an editor
>  	to supply the notes contents), then - instead of aborting -
>  	the existing notes will be opened in the editor (like the `edit`
> -	subcommand).
> +	subcommand). If you specify multiple `-m` and `-F`, a blank
> +	line will be inserted between the messages. Use the `--separator`
> +	option to insert other delimiters.
>  
>  copy::
>  	Copy the notes for the first object onto the second object (defaults to
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
>  
>  edit::
>  	Edit the notes for a given object (defaults to HEAD).
> @@ -159,6 +165,11 @@ OPTIONS
>  	Allow an empty note object to be stored. The default behavior is
>  	to automatically remove empty notes.
>  
> +--separator <paragraph-break>::
> +	Specify a string used as a custom inter-paragraph separator
> +	(a newline is added at the end as needed).  Defaults to a
> +	blank line.
> +
>  --ref <ref>::
>  	Manipulate the notes tree in <ref>.  This overrides
>  	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 9d8ca795..6ae8b57b 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "cache.h"
> +#include "alloc.h"
>  #include "config.h"
>  #include "builtin.h"
>  #include "gettext.h"
> @@ -27,11 +28,12 @@
>  #include "worktree.h"
>  #include "write-or-die.h"
>  
> +static char *separator = NULL;
>  static const char * const git_notes_usage[] = {
>  	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
> -	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
> +	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
>  	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
> -	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
> +	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
>  	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
>  	N_("git notes [--ref <notes-ref>] show [<object>]"),
>  	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
> @@ -99,11 +101,19 @@ static const char * const git_notes_get_ref_usage[] = {
>  static const char note_template[] =
>  	N_("Write/edit the notes for the following object:");
>  
> +struct note_msg {
> +	int stripspace;
> +	struct strbuf buf;
> +};
> +
>  struct note_data {
>  	int given;
>  	int use_editor;
>  	char *edit_path;
>  	struct strbuf buf;
> +	struct note_msg **messages;
> +	size_t msg_nr;
> +	size_t msg_alloc;
>  };
>  
>  static void free_note_data(struct note_data *d)
> @@ -113,6 +123,13 @@ static void free_note_data(struct note_data *d)
>  		free(d->edit_path);
>  	}
>  	strbuf_release(&d->buf);
> +
> +	while (d->msg_nr) {
> +		--d->msg_nr;
> +		strbuf_release(&d->messages[d->msg_nr]->buf);
> +		free(d->messages[d->msg_nr]);
> +	}

        while (d->msg_nr--) {
                strbuf_relesae(...);
                free(d->messages[d->msg_nr]);
        }

> +	free(d->messages);
>  }



> @@ -213,65 +230,98 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
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

If you massage an unspecified separator beforehand into "\n"
(e.g. initialize separator to "\n" instead of NULL), you can lose
one of these three at runtime.

> +static void concat_messages(struct note_data *d)
> +{
> +	struct strbuf msg = STRBUF_INIT;
> +
> +	size_t i;
> +	for (i = 0; i < d->msg_nr ; i++) {
> +		if (d->buf.len)
> +			insert_separator(&d->buf, d->buf.len);
> +		strbuf_add(&msg, d->messages[i]->buf.buf, d->messages[i]->buf.len);
> +		strbuf_addbuf(&d->buf, &msg);
> +		if (d->messages[i]->stripspace)
> +			strbuf_stripspace(&d->buf, 0);
> +		strbuf_reset(&msg);
> +	}
> +	strbuf_release(&msg);
> +}

Interesting.  

I would have expected that where we add to d->messages[] array a new
note_msg structure and set its .stripspace member, we already knew
if the associated strbuf needs to be stripspace'd and instead of
maintaining the .stripspace member for each note_msg, we can just
have it contain only a string (not even a strbuf).

The above loop, and the design to have .stripspace per each
note_msg, smell iffy to me for one thing.  The .stripspace member is
used to flag "after adding this element, the whole thing need to be
treated with stripspace".  Is it intended?  What it means is that if
you have two elements in d->messages[] array, one of them with and
the other one without the .stripspace bit set, depending on the
order of the elements, the result would be vastly different.  When
the later element has the stripspace bit set, everything gets
cleansed, but when the earlier element has it, only the earlier
element gets cleansed and the later element is added with multiple
blank lines and trailing whitespaces intact.  It does not sound
quite right.

I wonder if the semantics intended (not implemented) by this series
is to concatenate if none of the elements want stripspace and cleanse
the whitespaces if any of them want stripspace, in which case an
obvious implementation would be to just concatenate everything in
the loop with separators, while seeing if any of them have the
stripspace bit set, and then after the loop finishes, run stripspace
on the whole thing just once if any of d->messages[] asked for it?
If that is the case, an even better design could be to move the
stripspace bit out of d->messages[] and make it d->stripspace to
apply to the whole thing.

Another possiblity is to just stripspace the elements taken from the
source you want to stripspace (like "-m" and "-F" but not the ones
taken from parse_reuse_arg()) before you even add them to
d->messages[] array.  That way, the only possible source of multiple
blank lines and trailing whitespaces in the concatenation of
elements you want stripspace would be from the separator, which is
under control by the end user.  So your concatenation could just
ignore running stripspace at all---if the user does (or does not)
want multiple blank lines or trailing whitespaces on the separator
line, that's under their control.  That sounds like the simplest and
cleanest design---we strip as we read from each source and make them
into simple strings to be kept in d->messages[] without having to
allocate and keep a strbuf per each source, and we concatenate just
once, without worrying about stripspace.

The simple approach may break when any of the elements ended up to
be truly empty, but then we can solve that by refraining to push an
empty result into d->messages[] array, or something?  I dunno.
