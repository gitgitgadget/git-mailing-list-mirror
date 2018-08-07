Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D004208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 14:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbeHGQP3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:15:29 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:53700 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389201AbeHGQP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:15:29 -0400
Received: from [192.168.2.201] ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id n2Xjf3X8BpXFjn2XjfZ7FA; Tue, 07 Aug 2018 15:01:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533650460;
        bh=Bfwp0mJbV36ArzvnNQ+23Wt1c1+2XgqoqJzS5ehMR0M=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Wlb/S6WgaKIA38/Ju3VRce20WPZImL2/WUD9Qg1bWeU9GWtBXu2s5qGqAcVKCv2Gz
         JmCuXmLfdI289P0y7sv1XG6q8ytaAz0KO4geIue1yGEFyCxifoN4ulGW89cqUOQGsT
         pn9SkFPUj80x8lLqM0PSl6gTYJn1WpO0/MuW+SNA=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ptadTxur15m-cMjFgksA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 04/20] rebase -i: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-5-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <325fd5d2-2a93-2270-7d1e-394c265f42d4@talktalk.net>
Date:   Tue, 7 Aug 2018 15:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731180003.5421-5-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNzy0DvoIlc0Ce2NRujbxDNNsp06utfmlQw70chca8SXdTZkIv9NynFMJhuG+dJ0/GARXmBQHFeCM0YFEy+pBpe6kcwieydPHinWcryHO1VUWCkmNPJ7
 V7OvXr2tkL8Yp+iZf3jZm0pWb3Iv1c5bFHs4wlDJnHrL1KevCBEv5h8le6j179l1dOBfZBclwMbQKZnQ5r/N/w9Ff6vgjN+Sz0RrSdBi9AmmadbpkfiwCafB
 6ycnLJl714uX/QPSzE3GROpC/+r4Y5NiBk4BJ/PECZz+ey25sgYqEFeqxr/8mqTUT2MRsSNQcEBXComZVTCrG5pF01AFOfRQ9WxVmTtOnLTJmCzE7D89+Lia
 EsyVzZorgVGf1XQO1qEodz6TsZ6Ka7sNpr2arzvlcX2FGRHG1EoiVsCGsU3o0EF+TMJO8H8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/18 18:59, Alban Gruin wrote:
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
> No changes since v4.
> 
>  builtin/rebase--helper.c   | 13 ++++++++-----
>  git-rebase--interactive.sh | 11 +----------
>  rebase-interactive.c       | 31 +++++++++++++++++++++++++++++++
>  rebase-interactive.h       |  1 +
>  4 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index 05e73e71d4..731a64971d 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -13,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
>  	int abbreviate_commands = 0, rebase_cousins = -1;
>  	enum {
>  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
>  		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
> -		ADD_EXEC, APPEND_TODO_HELP
> +		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> @@ -28,8 +28,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
>  		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>  			 N_("keep original branch points of cousins")),
> -		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
> -			 N_("append the edit-todo message to the todo-list")),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  				CONTINUE),
>  		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
> @@ -50,6 +48,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  			N_("insert exec commands in todo list"), ADD_EXEC),
>  		OPT_CMDMODE(0, "append-todo-help", &command,
>  			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
> +		OPT_CMDMODE(0, "edit-todo", &command,
> +			    N_("edit the todo list during an interactive rebase"),
> +			    EDIT_TODO),
>  		OPT_END()
>  	};
>  
> @@ -90,6 +91,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  	if (command == ADD_EXEC && argc == 2)
>  		return !!sequencer_add_exec_commands(argv[1]);
>  	if (command == APPEND_TODO_HELP && argc == 1)
> -		return !!append_todo_help(write_edit_todo, keep_empty);
> +		return !!append_todo_help(0, keep_empty);
> +	if (command == EDIT_TODO && argc == 1)
> +		return !!edit_todo_list(flags);
>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 94c23a7af2..2defe607f4 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -108,16 +108,7 @@ initiate_action () {
>  		     --continue
>  		;;
>  	edit-todo)
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
>  		;;
>  	show-current-patch)
>  		exec git show REBASE_HEAD --
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index d7996bc8d9..403ecbf3c9 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -66,3 +66,34 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
>  
>  	return ret;
>  }
> +
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

This truncates the existing file, if there are any errors writing the
new one then the user has lost the old one. write_message() in
sequencer.c avoids this problem by writing a new file and then renaming
it if the write is successful, maybe it is worth exporting it so it can
be used elsewhere.

> +	if (!todo) {
> +		strbuf_release(&buf);
> +		return 1;
> +	}
> +
> +	strbuf_write(&buf, todo);
> +	fclose(todo);

There needs to be some error checking after the write and the close
(using write_message() would mean you only have to check for errors in
one place)

Best Wishes

Phillip

> +	strbuf_release(&buf);
> +
> +	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
> +	append_todo_help(1, 0);
> +
> +	if (launch_sequence_editor(todo_file, NULL, NULL))
> +		return 1;
> +
> +	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
> +
> +	return 0;
> +}
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 47372624e0..155219e742 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -2,5 +2,6 @@
>  #define REBASE_INTERACTIVE_H
>  
>  int append_todo_help(unsigned edit_todo, unsigned keep_empty);
> +int edit_todo_list(unsigned flags);
>  
>  #endif
> 

