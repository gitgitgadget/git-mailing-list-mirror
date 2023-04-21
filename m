Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3316DC77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjDUTbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjDUTbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:31:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333D212E
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:31:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a6bc48aec8so20880395ad.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682105478; x=1684697478;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVnFxaqDFnjpzOeRvFW7ofRFFe9MOVYXEF7lJ/thLkg=;
        b=iYX1c7jC6zveWtWOPx1k8wjcpD/WcuhBOZIyfXoEBJ0HH7He8v+LJvjjB3n+bbGRUl
         1H2a5JNX+ORrCEk26MR8gwGdjHHL6Ie5nJU2CKqAQF5+NJ0OBFIt9TOuijofeKKFc3Nu
         SwHeZBPpXtJFLfbS36QVEXz0bDFKdUqJ/Lrr3YxTjZCe5c1H4HXMgAOMw4fJB2d0w4hP
         XnSFoBaDnqMGhw4vBT43L7FrKUHJUyN+2hVX9TfhGhkNw9P7PtoKYme8dWYQ44LU+yoW
         k7OoL7+9kj5OnGXicvrq80cM5OhF6/B1ETVjLAScDDAh9OTMYEoqrGU8RFHgDW3vfcwZ
         WhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105478; x=1684697478;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HVnFxaqDFnjpzOeRvFW7ofRFFe9MOVYXEF7lJ/thLkg=;
        b=G64b3YVn6OnYy74MkiFJ70Kd++xHK2kZVr+pIDxDsUR9yIm0birdP1ksl1MsaDOrue
         MeBDWNJHZu5J+ndPHeXm4pmtldj8//h8BTqGAHE6dgAgODFXMDeHwa/4hdzRERjQkx75
         uc0xNoRZukasXfVaT+sZNl5G1HDAIo63OSaPtOlWZ+wpp0j2p2H7aclTe7BKMnlxMzS/
         Ck2chzEa7XlAVoOHNnek5QPKG2i53SFvqhMedf1D9WWXIhfBPdb4AYW53LecL6++8uIf
         I4uNRc15YGCvNPdpz76y09c1uBDvMl5VHDz6o0cZ9LT5hCFaXOdgOL2bNna0wUhRenXG
         j8rQ==
X-Gm-Message-State: AAQBX9dzTZtytbNlT8T5guNOu/e1nQilPKbPl/T4ODKrrJxDYmp9PJjs
        HtNwby4ONR1ieTYKtgHxQ/0=
X-Google-Smtp-Source: AKy350aiHJa7V47qh/PXuoH0AXhW52cGq5Vc6OkVNuiBcW8qTYb99Vjka8Ptf6pCVmWH8HTc4iN28g==
X-Received: by 2002:a17:903:189:b0:1a6:4c34:98bb with SMTP id z9-20020a170903018900b001a64c3498bbmr6298652plg.57.1682105478333;
        Fri, 21 Apr 2023 12:31:18 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902849700b001a05122b562sm3034959plo.286.2023.04.21.12.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:31:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/6] sequencer: factor out part of pick_commits()
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 12:31:17 -0700
In-Reply-To: <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Apr 2023 14:57:51
        +0000")
Message-ID: <xmqqpm7xjam2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This is simplifies a change in a later commit. If a pick fails we now
> return the error at then end of the loop body rather than returning
> early but there is no change in behavior.

The new pick_one_commit() function is pretty much verbatim copy/move
from inside the "any command below SQUASH" block, and in the
original code, the block returned with an error whenever res is not
0, with one exception that TODO_EDIT would return with 0 if there is
no error (but still with a patch).

The new code that calls pick_one_commit() helper lets this exception
case to return from the function in the "any command below SQUASH"
block, but everything else falls through *and* eventually at the end
of the outer block there is

	if (res)
		return res;

that makes us return from the function.

But there are now a few other things done after the if/else if/else
cascade, namely

 * there is an extra "if (reschedule)" and "else if (rebase-i) etc"
   logic.

 * the todo_list->current counter is incremented

are done BEFORE that "if res is not zero return".  I am not sure we
can safely claim "there is no change in behaviour".  

Am I missing something?

Thanks.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 129 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 69 insertions(+), 60 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index c4a548f2c98..2d463818dd1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4628,6 +4628,72 @@ N_("Could not execute the todo command\n"
>  "    git rebase --edit-todo\n"
>  "    git rebase --continue\n");
>  
> +static int pick_one_commit(struct repository *r,
> +			   struct todo_list *todo_list,
> +			   struct replay_opts *opts,
> +			   int *check_todo)
> +{
> +	int res;
> +	struct todo_item *item = todo_list->items + todo_list->current;
> +	const char *arg = todo_item_get_arg(todo_list, item);
> +	if (is_rebase_i(opts))
> +		opts->reflog_message = reflog_message(
> +			opts, command_to_string(item->command), NULL);
> +
> +	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
> +			     check_todo);
> +	if (is_rebase_i(opts) && res < 0) {
> +		/* Reschedule */
> +		advise(_(rescheduled_advice),
> +		       get_item_line_length(todo_list, todo_list->current),
> +		       get_item_line(todo_list, todo_list->current));
> +		todo_list->current--;
> +		if (save_todo(todo_list, opts))
> +			return -1;
> +	}
> +	if (item->command == TODO_EDIT) {
> +		struct commit *commit = item->commit;
> +		if (!res) {
> +			if (!opts->verbose)
> +				term_clear_line();
> +			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
> +				short_commit_name(commit), item->arg_len, arg);
> +		}
> +		return error_with_patch(r, commit,
> +					arg, item->arg_len, opts, res, !res);
> +	}
> +	if (is_rebase_i(opts) && !res)
> +		record_in_rewritten(&item->commit->object.oid,
> +				    peek_command(todo_list, 1));
> +	if (res && is_fixup(item->command)) {
> +		if (res == 1)
> +			intend_to_amend();
> +		return error_failed_squash(r, item->commit, opts,
> +					   item->arg_len, arg);
> +	} else if (res && is_rebase_i(opts) && item->commit) {
> +		int to_amend = 0;
> +		struct object_id oid;
> +
> +		/*
> +		 * If we are rewording and have either
> +		 * fast-forwarded already, or are about to
> +		 * create a new root commit, we want to amend,
> +		 * otherwise we do not.
> +		 */
> +		if (item->command == TODO_REWORD &&
> +		    !repo_get_oid(r, "HEAD", &oid) &&
> +		    (oideq(&item->commit->object.oid, &oid) ||
> +		     (opts->have_squash_onto &&
> +		      oideq(&opts->squash_onto, &oid))))
> +			to_amend = 1;
> +
> +		return res | error_with_patch(r, item->commit,
> +					      arg, item->arg_len, opts,
> +					      res, to_amend);
> +	}
> +	return res;
> +}
> +
>  static int pick_commits(struct repository *r,
>  			struct todo_list *todo_list,
>  			struct replay_opts *opts)
> @@ -4683,66 +4749,9 @@ static int pick_commits(struct repository *r,
>  			}
>  		}
>  		if (item->command <= TODO_SQUASH) {
> -			if (is_rebase_i(opts))
> -				opts->reflog_message = reflog_message(opts,
> -				      command_to_string(item->command), NULL);
> -
> -			res = do_pick_commit(r, item, opts,
> -					     is_final_fixup(todo_list),
> -					     &check_todo);
> -			if (is_rebase_i(opts) && res < 0) {
> -				/* Reschedule */
> -				advise(_(rescheduled_advice),
> -				       get_item_line_length(todo_list,
> -							    todo_list->current),
> -				       get_item_line(todo_list,
> -						     todo_list->current));
> -				todo_list->current--;
> -				if (save_todo(todo_list, opts))
> -					return -1;
> -			}
> -			if (item->command == TODO_EDIT) {
> -				struct commit *commit = item->commit;
> -				if (!res) {
> -					if (!opts->verbose)
> -						term_clear_line();
> -					fprintf(stderr,
> -						_("Stopped at %s...  %.*s\n"),
> -						short_commit_name(commit),
> -						item->arg_len, arg);
> -				}
> -				return error_with_patch(r, commit,
> -					arg, item->arg_len, opts, res, !res);
> -			}
> -			if (is_rebase_i(opts) && !res)
> -				record_in_rewritten(&item->commit->object.oid,
> -					peek_command(todo_list, 1));
> -			if (res && is_fixup(item->command)) {
> -				if (res == 1)
> -					intend_to_amend();
> -				return error_failed_squash(r, item->commit, opts,
> -					item->arg_len, arg);
> -			} else if (res && is_rebase_i(opts) && item->commit) {
> -				int to_amend = 0;
> -				struct object_id oid;
> -
> -				/*
> -				 * If we are rewording and have either
> -				 * fast-forwarded already, or are about to
> -				 * create a new root commit, we want to amend,
> -				 * otherwise we do not.
> -				 */
> -				if (item->command == TODO_REWORD &&
> -				    !repo_get_oid(r, "HEAD", &oid) &&
> -				    (oideq(&item->commit->object.oid, &oid) ||
> -				     (opts->have_squash_onto &&
> -				      oideq(&opts->squash_onto, &oid))))
> -					to_amend = 1;
> -
> -				return res | error_with_patch(r, item->commit,
> -						arg, item->arg_len, opts,
> -						res, to_amend);
> -			}
> +			res = pick_one_commit(r, todo_list, opts, &check_todo);
> +			if (!res && item->command == TODO_EDIT)
> +				return 0;
>  		} else if (item->command == TODO_EXEC) {
>  			char *end_of_arg = (char *)(arg + item->arg_len);
>  			int saved = *end_of_arg;
