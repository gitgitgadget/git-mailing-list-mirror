Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBC6208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 13:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbeHGQM1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:12:27 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:48099 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHGQM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:12:27 -0400
Received: from [192.168.2.201] ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id n2Unf3WhmpXFjn2UofZ7AU; Tue, 07 Aug 2018 14:57:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533650279;
        bh=PBRR6OxHY/3cIIndqnghj+OGzj5kznFm4t68nwbxFao=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Euig4XauplPtYFBcAuwaGmZeTmCObMb1kyK0THyOj/Qt4QxSx4fc0l/u1U9DGgA1X
         kriVYHccw+MkXXXEweS/iRL3dld/ruRpzgdbeHFI+TSJQP+3vo6W+Q3ULp2b0V2w2x
         9nKe1pz3TkhFLmJJ43d+HvwF5EOVaDXNDFkWMzLQ=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=V1tvLcJoTuWL594lREAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
Date:   Tue, 7 Aug 2018 14:57:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731180003.5421-3-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfITJEygGYPe4iO0pxSJ7yrZKbDU9YNBbsW9ZHM9IYnD5mJi0LpWnhXlftPgzaH9SG2sFsJ5t4ZVKcwFpqXq6WFUIpwhcet5QEUe3wKZdRQUTOJdWlnjk
 +77bJP5HeZ9YbjyL03xwOyv+33Ww4nlOppMMNwAiA180MOr4nloYMUfTdW7+Qt1FpRgH+FMchqZeWncHbKZdOR8P94GR4QcUitMteH3ySXctXhxdrNPElcWa
 elblCZjg+Mwte3OAOxiPtyWeKXOJw1XgMXlbHF317RZxmTR/bZxjD2F1og0nXZt4fXL9oUS+VfX+kn9zahcVPBC8+zlf+xycqAsU3NthKWe10vsteptC/4KO
 pvqI1WUaRhnoc9+CG9fxwopNxBRumCnpmjUN0VQF3efKtAwj1m4oxOChWO0BsW3gLbSFmayR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 31/07/18 18:59, Alban Gruin wrote:
> This rewrites append_todo_help() from shell to C. It also incorporates
> some parts of initiate_action() and complete_action() that also write
> help texts to the todo file.
> 
> This also introduces the source file rebase-interactive.c. This file
> will contain functions necessary for interactive rebase that are too
> specific for the sequencer, and is part of libgit.a.
> 
> Two flags are added to rebase--helper.c: one to call
> append_todo_help() (`--append-todo-help`), and another one to tell
> append_todo_help() to write the help text suited for the edit-todo
> mode (`--write-edit-todo`).
> 
> Finally, append_todo_help() is removed from git-rebase--interactive.sh
> to use `rebase--helper --append-todo-help` instead.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> No changes since v4.
> 
>  Makefile                   |  1 +
>  builtin/rebase--helper.c   | 11 ++++--
>  git-rebase--interactive.sh | 52 ++---------------------------
>  rebase-interactive.c       | 68 ++++++++++++++++++++++++++++++++++++++
>  rebase-interactive.h       |  6 ++++
>  5 files changed, 86 insertions(+), 52 deletions(-)
>  create mode 100644 rebase-interactive.c
>  create mode 100644 rebase-interactive.h
> 
> diff --git a/Makefile b/Makefile
> index 08e5c54549..909a687857 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -922,6 +922,7 @@ LIB_OBJS += protocol.o
>  LIB_OBJS += quote.o
>  LIB_OBJS += reachable.o
>  LIB_OBJS += read-cache.o
> +LIB_OBJS += rebase-interactive.o
>  LIB_OBJS += reflog-walk.o
>  LIB_OBJS += refs.o
>  LIB_OBJS += refs/files-backend.o
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index f7c2a5fdc8..05e73e71d4 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -3,6 +3,7 @@
>  #include "config.h"
>  #include "parse-options.h"
>  #include "sequencer.h"
> +#include "rebase-interactive.h"
>  
>  static const char * const builtin_rebase_helper_usage[] = {
>  	N_("git rebase--helper [<options>]"),
> @@ -12,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
>  	int abbreviate_commands = 0, rebase_cousins = -1;
>  	enum {
>  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>  		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> -		ADD_EXEC
> +		ADD_EXEC, APPEND_TODO_HELP
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -27,6 +28,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
>  		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>  			 N_("keep original branch points of cousins")),
> +		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
> +			 N_("append the edit-todo message to the todo-list")),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  				CONTINUE),
>  		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
> @@ -45,6 +48,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
>  		OPT_CMDMODE(0, "add-exec-commands", &command,
>  			N_("insert exec commands in todo list"), ADD_EXEC),
> +		OPT_CMDMODE(0, "append-todo-help", &command,
> +			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
>  		OPT_END()
>  	};
>  
> @@ -84,5 +89,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!rearrange_squash();
>  	if (command == ADD_EXEC && argc == 2)
>  		return !!sequencer_add_exec_commands(argv[1]);
> +	if (command == APPEND_TODO_HELP && argc == 1)
> +		return !!append_todo_help(write_edit_todo, keep_empty);
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 299ded2137..94c23a7af2 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -39,38 +39,6 @@ comment_for_reflog () {
>  	esac
>  }
>  
> -append_todo_help () {
> -	gettext "
> -Commands:
> -p, pick <commit> = use commit
> -r, reword <commit> = use commit, but edit the commit message
> -e, edit <commit> = use commit, but stop for amending
> -s, squash <commit> = use commit, but meld into previous commit
> -f, fixup <commit> = like \"squash\", but discard this commit's log message
> -x, exec <command> = run command (the rest of the line) using shell
> -d, drop <commit> = remove commit
> -l, label <label> = label current HEAD with a name
> -t, reset <label> = reset HEAD to a label
> -m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
> -.       create a merge commit using the original merge commit's
> -.       message (or the oneline, if no original merge commit was
> -.       specified). Use -c <commit> to reword the commit message.
> -
> -These lines can be re-ordered; they are executed from top to bottom.
> -" | git stripspace --comment-lines >>"$todo"
> -
> -	if test $(get_missing_commit_check_level) = error
> -	then
> -		gettext "
> -Do not remove any line. Use 'drop' explicitly to remove a commit.
> -" | git stripspace --comment-lines >>"$todo"
> -	else
> -		gettext "
> -If you remove a line here THAT COMMIT WILL BE LOST.
> -" | git stripspace --comment-lines >>"$todo"
> -	fi
> -}
> -
>  die_abort () {
>  	apply_autostash
>  	rm -rf "$state_dir"
> @@ -143,13 +111,7 @@ initiate_action () {
>  		git stripspace --strip-comments <"$todo" >"$todo".new
>  		mv -f "$todo".new "$todo"
>  		collapse_todo_ids
> -		append_todo_help
> -		gettext "
> -You are editing the todo file of an ongoing interactive rebase.
> -To continue rebase after editing, run:
> -    git rebase --continue
> -
> -" | git stripspace --comment-lines >>"$todo"
> +		git rebase--helper --append-todo-help --write-edit-todo
>  
>  		git_sequence_editor "$todo" ||
>  			die "$(gettext "Could not execute editor")"
> @@ -220,17 +182,7 @@ $comment_char $(eval_ngettext \
>  	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
>  	"$todocount")
>  EOF
> -	append_todo_help
> -	gettext "
> -	However, if you remove everything, the rebase will be aborted.
> -
> -	" | git stripspace --comment-lines >>"$todo"
> -
> -	if test -z "$keep_empty"
> -	then
> -		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
> -	fi
> -
> +	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
>  
>  	has_action "$todo" ||
>  		return 2
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> new file mode 100644
> index 0000000000..d7996bc8d9
> --- /dev/null
> +++ b/rebase-interactive.c
> @@ -0,0 +1,68 @@
> +#include "cache.h"
> +#include "commit.h"
> +#include "rebase-interactive.h"
> +#include "sequencer.h"
> +#include "strbuf.h"
> +
> +int append_todo_help(unsigned edit_todo, unsigned keep_empty)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *todo;
> +	int ret;
> +	const char *msg = _("\nCommands:\n"
> +"p, pick <commit> = use commit\n"
> +"r, reword <commit> = use commit, but edit the commit message\n"
> +"e, edit <commit> = use commit, but stop for amending\n"
> +"s, squash <commit> = use commit, but meld into previous commit\n"
> +"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
> +"x, exec <command> = run command (the rest of the line) using shell\n"
> +"d, drop <commit> = remove commit\n"
> +"l, label <label> = label current HEAD with a name\n"
> +"t, reset <label> = reset HEAD to a label\n"
> +"m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
> +".       create a merge commit using the original merge commit's\n"
> +".       message (or the oneline, if no original merge commit was\n"
> +".       specified). Use -c <commit> to reword the commit message.\n"
> +"\n"
> +"These lines can be re-ordered; they are executed from top to bottom.\n");
> +
> +	todo = fopen_or_warn(rebase_path_todo(), "a");
> +	if (!todo)
> +		return 1;
> +
> +	strbuf_add_commented_lines(&buf, msg, strlen(msg));
> +
> +	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
> +		msg = _("\nDo not remove any line. Use 'drop' "
> +			 "explicitly to remove a commit.\n");
> +	else
> +		msg = _("\nIf you remove a line here "
> +			 "THAT COMMIT WILL BE LOST.\n");
> +
> +	strbuf_add_commented_lines(&buf, msg, strlen(msg));
> +
> +	if (edit_todo)
> +		msg = _("\nYou are editing the todo file "
> +			"of an ongoing interactive rebase.\n"
> +			"To continue rebase after editing, run:\n"
> +			"    git rebase --continue\n\n");
> +	else
> +		msg = _("\nHowever, if you remove everything, "
> +			"the rebase will be aborted.\n\n");
> +
> +	strbuf_add_commented_lines(&buf, msg, strlen(msg));
> +
> +	if (!keep_empty) {
> +		msg = _("Note that empty commits are commented out");
> +		strbuf_add_commented_lines(&buf, msg, strlen(msg));
> +	}
> +
> +	ret = fputs(buf.buf, todo);

It is not worth changing the patch just for this but strbuf_write()
might be clearer (you use it in a later patch)

> +	if (ret < 0)
> +		error_errno(_("could not append help text to '%s'"), rebase_path_todo());
> +
> +	fclose(todo);

You should definitely check the return value and return an error if
appropriate as fputs() might not actually write any data until you try
and close the file.

Best Wishes

Phillip

> +	strbuf_release(&buf);
> +
> +	return ret;
> +}
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> new file mode 100644
> index 0000000000..47372624e0
> --- /dev/null
> +++ b/rebase-interactive.h
> @@ -0,0 +1,6 @@
> +#ifndef REBASE_INTERACTIVE_H
> +#define REBASE_INTERACTIVE_H
> +
> +int append_todo_help(unsigned edit_todo, unsigned keep_empty);
> +
> +#endif
> 

