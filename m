Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D6D1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755012AbdD0FdI (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:33:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35886 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdD0FdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:33:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so6209380pfd.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zI3r4nHMPlobF06KkapGVYniC48DqnGYV+xWdn2stwU=;
        b=EbAF66kg3oBJfYgbUDnPd8ZXVN14XBPqkPsQdc0DwrHXWmAmTSaBPwidgcDSEfy/ok
         elnEPKCIyhc51bqz9YNJec6rI11bLSp1ShIKMymqWb93oJeETyj+jjIYc7SLd/Ac2Dbb
         iGPTJMaCaACLY+9gOG8qgJjmXoQpgS3oX6Qg/9/u5lPpg0k5jON/gBQ63aSvfEmE7TrZ
         7WbMUk3uTXaw8TDsr75NiicWEVzEynZBBFBi++f/XHC5F7wklpm6XRd3SqiPD9azuybW
         bPG1v721Y49kYXruhnA3zyNqCWAbB3a2yyLYi9cywuXFhDsPTqfya+rR/U+kDoe/vb6W
         XaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zI3r4nHMPlobF06KkapGVYniC48DqnGYV+xWdn2stwU=;
        b=Hg3LrvPG9TuxK6KrWwdnJPst5QuBuBO/NxxTQyZoeB1TmGraKLcAVaVhc3CLKHRXrb
         foXph/nLCCvvJkHmmpw6Exbaqzndhcps3EvsBymE+1wk9i0McDIWb/7N8qRV9I6mUBaz
         MHmN26NanshVQbEBsLHhE1OjqroLnGOK2dofvfBBZkaOb9LmZA2K1bAXXku34VZaeNBL
         ypcmUJP15PWj6jGeyCcSVE+ubDBRr+CvRL2TkLeHwXMEtTBNkyF+fyHOSvFkqmH2DI6Z
         mXGSuOZMEdIuWvkz80K1YeU/87pUdOZF+SNXFAb8h9+//gld7SDMTKfPcYhJwBr09IVc
         9+yQ==
X-Gm-Message-State: AN3rC/7ZkX1BizdOUr39ws87MbkrA4/A8ssJjG+v9jBg1EpXOiCre46w
        zR8NnbSN3N7jpA==
X-Received: by 10.98.34.212 with SMTP id p81mr3882541pfj.118.1493271170600;
        Wed, 26 Apr 2017 22:32:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id 20sm1984167pfq.42.2017.04.26.22.32.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 22:32:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 6/9] rebase -i: check for missing commits in the rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <38bf320ec802386975843de6b5da4bbf823fb184.1493207864.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 22:32:48 -0700
In-Reply-To: <38bf320ec802386975843de6b5da4bbf823fb184.1493207864.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 13:59:31 +0200
        (CEST)")
Message-ID: <xmqqh91ao1of.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -check_todo_list
> +git rebase--helper --check-todo-list || {
> +	ret=$?
> +	checkout_onto
> +	exit $ret
> +}

I find this a better division of labor between "check_todo_list" and
its caller.  Compared to the original that did the "recover and exit
with failure" inside the helper, this is much easier to see what is
going on.

> +/*
> + * Check if the user dropped some commits by mistake
> + * Behaviour determined by rebase.missingCommitsCheck.
> + * Check if there is an unrecognized command or a
> + * bad SHA-1 in a command.
> + */
> +int check_todo_list(void)
> +{
> +	enum check_level check_level = get_missing_commit_check_level();
> +	struct strbuf todo_file = STRBUF_INIT;
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	struct commit_list *missing = NULL;
> +	int raise_error = 0, res = 0, fd, i;
> +
> +	strbuf_addstr(&todo_file, rebase_path_todo());
> +	fd = open(todo_file.buf, O_RDONLY);
> +	if (fd < 0) {
> +		res = error_errno(_("could not open '%s'"), todo_file.buf);
> +		goto leave_check;
> +	}
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		res = error(_("could not read '%s'."), todo_file.buf);
> +		goto leave_check;
> +	}
> +	close(fd);
> +	raise_error = res =
> +		parse_insn_buffer(todo_list.buf.buf, &todo_list);
> +
> +	if (check_level == CHECK_IGNORE)
> +		goto leave_check;

OK, so even it is set to ignore, unreadable todo list will be shown
with a loud error message that tells the user to use --edit-todo.

What should happen when it is not set to ignore and we found the
todo list unacceptable, I wonder?  Let's read on.

> +	/* Get the SHA-1 of the commits */
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct commit *commit = todo_list.items[i].commit;
> +		if (commit)
> +			commit->util = todo_list.items + i;
> +	}

It does not look like this loop is "Get(ting) the SHA-1 of the commits"
to me, though.  It is setting up ->util to be usable as a back-pointer
into the list.

> +
> +	todo_list_release(&todo_list);

But then the todo-list is released?  The util field we have set, if
any, in the previous loop are now dangling, no?

> +	strbuf_addstr(&todo_file, ".backup");
> +	fd = open(todo_file.buf, O_RDONLY);
> +	if (fd < 0) {
> +		res = error_errno(_("could not open '%s'"), todo_file.buf);
> +		goto leave_check;
> +	}
> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
> +		close(fd);
> +		res = error(_("could not read '%s'."), todo_file.buf);
> +		goto leave_check;
> +	}
> +	close(fd);
> +	strbuf_release(&todo_file);
> +	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);

Then we read from .backup; failure to do so does not result in the
"you need to --edit-todo" warning.

> +	/* Find commits that are missing after editing */
> +	for (i = 0; i < todo_list.nr; i++) {
> +		struct commit *commit = todo_list.items[i].commit;
> +		if (commit && !commit->util) {
> +			commit_list_insert(commit, &missing);
> +			commit->util = todo_list.items + i;
> +		}
> +	}

And we check the commits mentioned in the backup; any commit whose
util is not marked in the previous loop is noticed and thrown into
the missing list.

The loop we later have does "while (missing)" and does not look at
commit->util for commits that are *not* missing, i.e. the ones that
are marked in the previous loop, so it does not matter that their
util field have dangling pointers.  In that sense, it may not be
buggy, but it is misleading.  The only thing these two loops care
about is that the commits found in the earlier loop get their util
field set to non-NULL, so instead of using "todo_list.items+i",
perhaps doing this

	if (commit)
		commit->util = (void *)1; /* mark as seen */

in the earlier loop instead would be much less confusing.

> +	/* Warn about missing commits */
> +	if (!missing)
> +		goto leave_check;

If there is no missing one, we may still return error about
unacceptable backup file.  But if we read backup fine and didn't
find anything missing, we'll return silently and with success.  OK.

> +	if (check_level == CHECK_ERROR)
> +		raise_error = res = 1;

Otherwise, we found missing ones and we want to report here.

The reason why I started reading this function aloud was because I
found two variables (raise_error and res) somewhat confusing.  I
think what the code does makes sense, but I still find the way how
the code expresses the logic with these two variables confusing.
Perhaps somebody else can hopefully offer possible improvements, as
I do not offhand think of a way better than what is currently in
this patch myself.

> +	fprintf(stderr,
> +		_("Warning: some commits may have been dropped accidentally.\n"
> +		"Dropped commits (newer to older):\n"));
> +
> +	/* Make the list user-friendly and display */
> +	while (missing) {
> +		struct commit *commit = pop_commit(&missing);
> +		struct todo_item *item = commit->util;
> +
> +		fprintf(stderr, " - %s %.*s\n", short_commit_name(commit),
> +			item->arg_len, item->arg);
> +	}
> +	free_commit_list(missing);
> +
> +	fprintf(stderr, _("To avoid this message, use \"drop\" to "
> +		"explicitly remove a commit.\n\n"
> +		"Use 'git config rebase.missingCommitsCheck' to change "
> +		"the level of warnings.\n"
> +		"The possible behaviours are: ignore, warn, error.\n\n"));
> +
> +leave_check:
> +	strbuf_release(&todo_file);
> +	todo_list_release(&todo_list);
> +
> +	if (raise_error)
> +		fprintf(stderr,
> +			_("You can fix this with 'git rebase --edit-todo' "
> +			  "and then run 'git rebase --continue'.\n"
> +			  "Or you can abort the rebase with 'git rebase"
> +			  " --abort'.\n"));
> +
> +	return res;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index 47a81034e76..4978a61b83b 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -49,6 +49,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
>  		int argc, const char **argv);
>  
>  int transform_todo_ids(int shorten_sha1s);
> +int check_todo_list(void);
>  
>  extern const char sign_off_header[];
