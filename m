Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388EC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCTRxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCTRwc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:52:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA530B30
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:46:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id n20so2839588pfa.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679334404;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzvRpcTwNUGi38i9+Xev4JFUpvHl0VVzIL9Z3+f5Wtw=;
        b=AI3j8w3JhsUA2bO64qw/VDvYPbcOkk2MSiZ+Z7x/DMoGa2RCIYRHG3Fte2mNg58jvK
         qBeSdlJZ/G48QI3YpfJxFGUvple1GsXcyyzI269qESuxA+XqxPd9VMJPo2SY5NMclm9e
         BAv56pHO3pRo7pHER7AIOyqCacG36Xf4O8MgWId3WNGaFSr3hp0So0+N9hiuyn9Xy864
         v8J7oGVYG40cvkygikYfEnfUpXFhhYwekkanKh3Er5EeRb8N0y4f/Hr6e09IIClCTfk3
         lAsz+4rUNUCB5eANZbvuUvLiSVqYIMR0qW6kiC4lUM4GqOV9iEBMCISIWLZRBHBmxABL
         ZnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334404;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mzvRpcTwNUGi38i9+Xev4JFUpvHl0VVzIL9Z3+f5Wtw=;
        b=c8tlIX/acc76I/HT22cMTzP9QMkdQcOBL1M8+vncQN+io0bWpl6tnKBhX42aaSfZ7S
         oB5nWM1hvXNIIcocp1QIDp13IlZGJI2GcpO60wGyhgEdZV1ofTpc08V3/LxbecBNRXEX
         jLje+Cd9VxBFEmozWMFZqK6XwweCUFc64AQc8+4oLAOdvKmOlaM3C3hMF38u1Pyn0/6p
         aDrjCA0PdhCFHFZ12UBwbkEru7MxAHM0OoUhgFpRWwYIIVSgAjlT/FHWV9LZQ3VJMeIG
         UzYswmVbLhe73EmUywMyjxBxdF5UX0+P4iMp7gkcFCGhy8vArX66rWExOH07e+6nGX7Z
         CELg==
X-Gm-Message-State: AO0yUKXn9OIsUUxB7pAtlPfFPDJ0xn5/R6hAAhypTF6TxuH0osIDjSv1
        dCWQXgZJmnrgQo+I5jTE6g8qNqwUtcs=
X-Google-Smtp-Source: AK7set/T0MYoyOE04PgPjsejCqhue4kbKPQWHO3NsfaSTVPkZneT+nKsrHgZQOWGg8mgBh2EJxJLbQ==
X-Received: by 2002:a62:647:0:b0:625:c4ea:4a03 with SMTP id 68-20020a620647000000b00625c4ea4a03mr15374798pfg.11.1679334404156;
        Mon, 20 Mar 2023 10:46:44 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78e1a000000b00625616f59a1sm6640400pfr.73.2023.03.20.10.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:46:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling command
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 10:46:43 -0700
In-Reply-To: <pull.1492.git.1679237337683.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Sun, 19 Mar 2023 14:48:57 +0000")
Message-ID: <xmqq4jqfmi2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As the sequencer executes todo commands it appends them to
> .git/rebase-merge/done. This file is used by "git status" to show the
> recently executed commands. Unfortunately when a command is rescheduled
> the command preceding it is erroneously appended to the "done" file.
> This means that when rebase stops after rescheduling "pick B" the "done"
> file contains
>
> 	pick A
> 	pick B
> 	pick A
>
> instead of
>
> 	pick A
> 	pick B

Here it may not be clear what you meant with the verb "reschedule"
to those who weren't closely following the previous discussion that
led to this fix.

Is it the same as "the command attempted to execute a step, couldn't
complete it (e.g. due to conflicts), and gave control to the end
user until they say 'git rebase --continue'"?  What cases, other
than interrupted step due to conflicts, involve "rescheduling"?

> Note that the rescheduled command will still be appended to the "done"
> file again when it is successfully executed. Arguably it would be better
> not to do that but fixing it would be more involved.

And without quite understanding what "reschedule" refers to, it is
unclear why it is even arguable---it is perfectly sensible that a
command that is rescheduled (hence not yet done) would not be sent
to 'done'.  If a command that was once rescheduled (hence it wasn't
finished initially) gets finished now, shouldn't it be sent to
'done'?  It is unclear why is it better not to.

> -static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
> +static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
> +		     int reschedule)
>  {

OK, all callers to save_todo() are in pick_commits() that knows what
the value of "reschedule" is, and it is passed down to this helper ...

> @@ -3389,7 +3390,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>  	 * rebase -i writes "git-rebase-todo" without the currently executing
>  	 * command, appending it to "done" instead.
>  	 */
> -	if (is_rebase_i(opts))
> +	if (is_rebase_i(opts) && !reschedule)
>  		next++;
>  
>  	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
> @@ -3402,7 +3403,7 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
>  	if (commit_lock_file(&todo_lock) < 0)
>  		return error(_("failed to finalize '%s'"), todo_path);
>  
> -	if (is_rebase_i(opts) && next > 0) {
> +	if (is_rebase_i(opts) && !reschedule && next > 0) {
>  		const char *done = rebase_path_done();
>  		int fd = open(done, O_CREAT | O_WRONLY | O_APPEND, 0666);
>  		int ret = 0;

... and the change here is quite straight-forward.  With reschedule,
we do not advance because by definition we haven't finished the
step yet.  OK.

> @@ -4648,7 +4649,7 @@ static int pick_commits(struct repository *r,
>  		const char *arg = todo_item_get_arg(todo_list, item);
>  		int check_todo = 0;
>  
> -		if (save_todo(todo_list, opts))
> +		if (save_todo(todo_list, opts, 0))
>  			return -1;

I wonder why we pass a hardcoded 0 here---shouldn't the value match
the local variable 'reschedule'? here?

The same question for the other two callers, but I admit that when
the second one is called, the local variable "reschedule" is not
set...

>  		if (is_rebase_i(opts)) {
>  			if (item->command != TODO_COMMENT) {
> @@ -4695,8 +4696,7 @@ static int pick_commits(struct repository *r,
>  							    todo_list->current),
>  				       get_item_line(todo_list,
>  						     todo_list->current));
> -				todo_list->current--;
> -				if (save_todo(todo_list, opts))
> +				if (save_todo(todo_list, opts, 1))
>  					return -1;

... yet we call the helper with reschedule set to 1.  Puzzled.

> @@ -4788,8 +4788,7 @@ static int pick_commits(struct repository *r,
>  			       get_item_line_length(todo_list,
>  						    todo_list->current),
>  			       get_item_line(todo_list, todo_list->current));
> -			todo_list->current--;
> -			if (save_todo(todo_list, opts))
> +			if (save_todo(todo_list, opts, 1))
>  				return -1;

At this point, reschedule is set and passing it instead of 1 would
be OK.

Thanks.
