Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E7C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjALMkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjALMkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:40:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC524C733
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:40:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so26649678edc.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cS0X1ZDSdwBAZKAfua1UimBs8nfxXGxbvHtXJRhvGXw=;
        b=e2WbzDyDkPSy6dr88wwGodSVC4FeOeNdeNuRTFFScjl7SR348+A+28vhX0sPAsrT69
         Fxt6yeqm1IThQfW05FiinqOgYltWc8fo9OIk3IAPP2xeFAVGNXq7oDQpEFOK/nYRD3qL
         zc+jgLESK1fvY+C7rtIbkGqqepkdmnrdwcDy2LbfjylrZKTJMQsLakyx2U1uAYJulkhB
         +iQadZfYzDjEvPHgMQKlwKM4x4fNTmTxbgRpi9wP8Qu7DEJ7AWrSh2pTl0Nfv4TjDT75
         QIZ1b4iUeTz/q5B9D3cf9fCWLK132SQyyhCAsQrFe1k25XzggU5N2GHMHRaaQm2Hj1H3
         ZcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS0X1ZDSdwBAZKAfua1UimBs8nfxXGxbvHtXJRhvGXw=;
        b=wZWKB/S2LoeHpYb6wkrVt+pDFYD66sYtgXpAqSNDqGhIrYt0g6WopDetsfofq+V/S+
         rKrfBza3Og8WbPrz5sCoshMM5N0XKdF4Tj0GUmgNII6TxzTMwrN0ruHCMfwMoRueUJy5
         De0fHC27CztT3O2V7pD42SPRZKrXUfch2Cp8tUcTrPmzowAk1+0rUSDe1vvOZCJDxxtb
         fOGsfNvqvB72JmkFkbFSf45CgG9NtAY/BBX9CyY85OokDU1JDWYm9ajhdqFBHL/i964u
         zyXckr+MZYOPnwRsZAnpWD65/fISo1hgh323nneAx35d7pUgqrKZc96Sq1MwF4bHExVV
         2cmg==
X-Gm-Message-State: AFqh2kqW9OJiBrJ9wQjxciL/U4ZyVx0CqACe7dOMMd/0BbiHWkRqrltQ
        zNHkaNkxTmhjc/jSVQ68i25hA2B/AX0=
X-Google-Smtp-Source: AMrXdXtzbgn6o4tCrQD9CmQmk49UMTecRvS5qjNrFDpr5JWkIhHwYIIIGQ0DQ1UAIZYPuvd7ewciOw==
X-Received: by 2002:a05:6402:538e:b0:48e:bf0d:f3a8 with SMTP id ew14-20020a056402538e00b0048ebf0df3a8mr28095546edb.38.1673527201844;
        Thu, 12 Jan 2023 04:40:01 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fd7-20020a056402388700b00483dd234ac6sm6967423edb.96.2023.01.12.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:40:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFwsC-000CbV-1E;
        Thu, 12 Jan 2023 13:40:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Date:   Thu, 12 Jan 2023 13:25:23 +0100
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
Message-ID: <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When adding a "break" command to a rebase todo list it can be helpful to
> add a comment as a reminder as to what the user was planning to do when
> the rebase stopped. Anything following the command is interpreted as an
> argument to the command and results in an error. Change this so that a
> "break command may be followed by "# <comment>" in the same way as
> a "merge" command. Requiring the comment to begin with "# " allows the
> break command to start taking an argument in the future if that turns
> out to be useful.
>
> Reported-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     rebase -i: allow a comment after a "break" command
>     
>     I'm open to suggestions for other ways to handle comments but copying
>     what we do to separate merge parents from the merge commit subject
>     seemed simplest.
>     
>     Should this print the comment when stopping for a break command?
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1460%2Fphillipwood%2Fsequencer-allow-comment-after-break-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1460/phillipwood/sequencer-allow-comment-after-break-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1460
>
>  Documentation/git-rebase.txt |  4 +++-
>  sequencer.c                  |  7 +++++--
>  t/lib-rebase.sh              |  2 +-
>  t/t3418-rebase-continue.sh   | 16 ++++++++++++++++
>  4 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f9675bd24e6..511ace43db0 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the commit, and continue
>  rebasing.
>  
>  To interrupt the rebase (just like an "edit" command would do, but without
> -cherry-picking any commit first), use the "break" command.
> +cherry-picking any commit first), use the "break" command. A "break"
> +command may be followed by a comment beginning with `#` followed by a
> +space.

You're missing a corresponding edit here to the help string in
append_todo_help(), as you note you're making "break" support what
"merge" does, and that help string documents that "merge" accepts a
comment, after this we don't do that for "break", but should one way or
the other (see below).

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2509,7 +2509,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  	padding = strspn(bol, " \t");
>  	bol += padding;
>  
> -	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
> +	if (item->command == TODO_NOOP ||
> +	    (item->command == TODO_BREAK &&
> +	     (bol[0] != '#' || (bol[1] && !isspace (bol[1]))))) {
>  		if (bol != eol)
>  			return error(_("%s does not accept arguments: '%s'"),
>  				     command_to_string(item->command), bol);
> @@ -2524,7 +2526,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  			     command_to_string(item->command));
>  
>  	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> -	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
> +	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF ||
> +	    item->command == TODO_BREAK) {
>  		item->commit = NULL;
>  		item->arg_offset = bol - buf;
>  		item->arg_len = (int)(eol - bol);
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index b57541356bd..a648013f299 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -51,7 +51,7 @@ set_fake_editor () {
>  		case $line in
>  		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
>  			action="$line";;
> -		exec_*|x_*|break|b)
> +		exec_*|x_*|break_*|b_*|break|b)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;
>  		merge_*|fixup_*)
>  			action=$(echo "$line" | sed 's/_/ /g');;
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 130e2f9b553..18d82869b38 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -266,6 +266,22 @@ test_expect_success 'the todo command "break" works' '
>  	test_path_is_file execed
>  '
>  
> +test_expect_success 'the todo command "break" accepts a comment' '
> +	rm -f execed &&
> +	test_write_lines "break # comment" "break #" "exec >execed" >expect &&
> +	write_script cat-todo.sh <<-\EOS &&
> +	GIT_SEQUENCE_EDITOR="grep ^\[^#\]" git rebase --edit-todo >actual
> +	EOS
> +	FAKE_LINES="exec_./cat-todo.sh break_#_comment b_# exec_>execed" \
> +		git rebase -i HEAD &&
> +	test_cmp expect actual &&
> +	test_path_is_missing execed &&
> +	git rebase --continue &&
> +	test_path_is_missing execed &&
> +	git rebase --continue &&
> +	test_path_is_file execed
> +'
> +
>  test_expect_success '--reschedule-failed-exec' '
>  	test_when_finished "git rebase --abort" &&
>  	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
>
> base-commit: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b

I like this direction, but I don't see why we need to continue this
special-snowflakeness of only allowing specific commands to accept these
#-comments.

Why not just have them all support it? It started with "merge", which as
4c68e7ddb59 (sequencer: introduce the `merge` command, 2018-04-25) note
can be used for:

	merge -C baaabaaa abc # Merge the branch 'abc' into master

As Olliver points out we should probably support "#" without the
following " ", which seems to be an accident of history &
over-strictness.

But in this commit you extend it to "break", but we're going out of or
way to e.g. extend this to "noop".

So I'd expect that just like the first for-loop in "parse_insn_line()"
we'd check if strchr(bol, '#') returns non-NULL, and if so set eol to
that result.

The "just like" being that we may want to explicitly forbid this or
handle it specially for some, e.g. I didn't check but do the "label" and
"reset" perhaps support arbitrary non-'\n' (probably by accident, and we
could support commments there too).

For "pick" we probably need to explicitly exclude it, although I can't
remember if we do anything useful with the part of the line after the
OID (maybe not...).
