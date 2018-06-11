Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3441D1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeFKPcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 11:32:55 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:31725 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbeFKPcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 11:32:54 -0400
Received: from [192.168.2.240] ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id SOoNfBUzUpXFjSOoOf2wlS; Mon, 11 Jun 2018 16:32:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528731173;
        bh=cgKEx6yv6OxPDpgN5EoUMl8cbED1epg5cNUoAdUE9NI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QApiR+XQ3cnB1eHRR7dZ+AAS8XB4o0Dr2B0U/aXNgUOJSolliOPQv4PSpLus9t/ZL
         bBsMbHdw3AO1Keu/KBamWN9MR0iokAFfJBTKpj28FbqzJWiq68mgDXToP02eKzp2QV
         44F8Eq3BPAdBY1KrJ9fDLjdWm8iw25yDx7tJX9Fk=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=b_pqZEi0Kq4EG3XY7q8A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 1/1] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180611135714.29378-2-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3bfd3470-4482-fe6a-2cd9-08311a0bbaac@talktalk.net>
Date:   Mon, 11 Jun 2018 16:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611135714.29378-2-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEFlQRxq/d0JOV4NzPYY2Tm7LySK3bTcW/CZ2pqaf6prTHOoVkbdf7b33eOp2iOmQhTHXN6BWWQDdzvEv2UXnulIZa1Am1c6h6/VttBGj3iqT71w8iCQ
 8eVjJSc8imBb36dMV4G/qaLu1Qi4Ja6oRFlznSa9WI0EAE1ogU7IsGSHzmeBWN2b8CR2VvBGdh+Cln9eCSKsvYxg0PzGrY882Tqtdjzl1S0S+oHt7e8gpb0I
 /Yz0e/V1o70VfSHq41YgFCTfxrkDzkGSmyVDeWRn7lQdvGhevK52lU9TNYEPJIFHtCUQPC6nCDRpgBKMu9xSwNRLOoqsKsLnxYlUNVzYwEpQmJUZ0bZuG8AC
 b9zsWI9Z2LkSqVjAgfUWnt7sFx0UYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban, it's great to see you making progress with this.

I don't want to add to your workload but a couple of things that might 
be nice to have in the future would be

1) avoid rewriting the todo list and running the editor if 
GIT_SEQUENCE_EDITOR is ':', especially when creating the todo list for 
implicit interactive rebases.

2) have --edit-todo warn if the user drops commits, in the same way as 
rebase does for the initial edit of the todo list. This should also make 
it easier to use the same code for the initial edit as well as when the 
user does 'rebase --edit-todo'

I've got a couple of comments on this patch below.

On 11/06/18 14:57, Alban Gruin wrote:
> This rewrites the edit-todo functionality from shell to C.
> 
> To achieve that, a new command mode, `edit-todo`, is added, and the
> `write-edit-todo` flag is removed, as the shell script does not need to
> write the edit todo help message to the todo list anymore.
> 
> The shell version is then stripped in favour of a call to the helper.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--helper.c   | 13 ++++++++-----
>   git-rebase--interactive.sh | 11 +----------
>   sequencer.c                | 31 +++++++++++++++++++++++++++++++
>   sequencer.h                |  1 +
>   4 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index ded5e291d..d2990b210 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>   int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   {
>   	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
>   	int abbreviate_commands = 0, rebase_cousins = -1;
>   	enum {
>   		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>   		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> -		ADD_EXEC, APPEND_TODO_HELP
> +		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
>   	} command = 0;
>   	struct option options[] = {
>   		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -27,8 +27,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
>   		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>   			 N_("keep original branch points of cousins")),
> -		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
> -			 N_("append the edit-todo message to the todo-list")),
>   		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>   				CONTINUE),
>   		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
> @@ -49,6 +47,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   			N_("insert exec commands in todo list"), ADD_EXEC),
>   		OPT_CMDMODE(0, "append-todo-help", &command,
>   			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
> +		OPT_CMDMODE(0, "edit-todo", &command,
> +			    N_("edit the todo list during an interactive rebase"),
> +			    EDIT_TODO),
>   		OPT_END()
>   	};
>   
> @@ -89,6 +90,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>   	if (command == ADD_EXEC && argc == 2)
>   		return !!sequencer_add_exec_commands(argv[1]);
>   	if (command == APPEND_TODO_HELP && argc == 1)
> -		return !!append_todo_help(write_edit_todo, keep_empty);
> +		return !!append_todo_help(0, keep_empty);
> +	if (command == EDIT_TODO && argc == 1)
> +		return !!edit_todo_list(flags);
>   	usage_with_options(builtin_rebase_helper_usage, options);
>   }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 94c23a7af..2defe607f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -108,16 +108,7 @@ initiate_action () {
>   		     --continue
>   		;;
>   	edit-todo)
> -		git stripspace --strip-comments <"$todo" >"$todo".new
> -		mv -f "$todo".new "$todo"
> -		collapse_todo_ids
> -		git rebase--helper --append-todo-help --write-edit-todo
> -
> -		git_sequence_editor "$todo" ||
> -			die "$(gettext "Could not execute editor")"
> -		expand_todo_ids
> -
> -		exit
> +		exec git rebase--helper --edit-todo
>   		;;
>   	show-current-patch)
>   		exec git show REBASE_HEAD --
> diff --git a/sequencer.c b/sequencer.c
> index 1ffd990f7..1c1799c91 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4386,6 +4386,37 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
>   	return ret;
>   }
>   
> +int edit_todo_list(unsigned flags)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *todo_file = rebase_path_todo();
> +	FILE *todo;
> +
> +	if (strbuf_read_file(&buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +
> +	strbuf_stripspace(&buf, 1);
> +	todo = fopen_or_warn(todo_file, "w");
> +	if (!todo) {
> +		strbuf_release(&buf);
> +		return 1;
> +	}
> +
> +	strbuf_write(&buf, todo);
> +	fclose(todo);
> +	strbuf_release(&buf);
> +
> +	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
> +	append_todo_help(1, 0);
> +
> +	if (launch_editor(todo_file, NULL, NULL))

I'm not sure that this will respect GIT_SEQUENCE_EDITOR, it would be 
nice to have a launch_sequence_editor() function that shared as much 
code as possible with launch_editor()

> +		return 1;
> +
> +	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
> +
> +	return 0;
> +}
> +
>   static int rewrite_file(const char *path, const char *buf, size_t len)
>   {
>   	int rc = 0;
> diff --git a/sequencer.h b/sequencer.h
> index e14f6590e..35730b13e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -81,6 +81,7 @@ int sequencer_add_exec_commands(const char *command);
>   int transform_todos(unsigned flags);
>   int check_todo_list(void);
>   int append_todo_help(unsigned edit_todo, unsigned keep_empty);

Can this declaration be removed now?

> +int edit_todo_list(unsigned flags);
>   int skip_unnecessary_picks(void);
>   int rearrange_squash(void);

Best Wishes

Phillip

