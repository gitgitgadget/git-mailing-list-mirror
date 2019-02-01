Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6321F453
	for <e@80x24.org>; Fri,  1 Feb 2019 11:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfBALED (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 06:04:03 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:9544 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfBALED (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 06:04:03 -0500
Received: from [192.168.2.240] ([92.26.116.186])
        by smtp.talktalk.net with SMTP
        id pWbvgLIrawhzSpWbygcFCG; Fri, 01 Feb 2019 11:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549019039;
        bh=sNpJMYoOqQe2kF77+1Ryj6Zth5sbXLoAC+Cs7sIPWx0=;
        h=Reply-To:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=KxF08GC5JZIMPFzjgXHY1OIXMezNiJDfYr0UqMktnHpfxxpB8h22u4S49bBpflOL6
         mavlKhr+oxSKNOWJMbQ5ndhX3vs1SrVGGawkilXpoXQV3Qe16F7dwlC/55vZXw8KI7
         jjcwLdDhA0tuDDl3p9CFlrY2tSXRucY/EfMtAsLA=
X-Originating-IP: [92.26.116.186]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=Pfo8oxCPEre7EYRssK5nbQ==:117
 a=Pfo8oxCPEre7EYRssK5nbQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NZiNPd3eSG9DS8iVEPgA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 14/16] rebase-interactive: rewrite edit_todo_list() to
 handle the initial edit
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-15-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <f3652f60-dde4-0e5a-50ab-81536af9bae0@talktalk.net>
Date:   Fri, 1 Feb 2019 11:03:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129150159.10588-15-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMqZv6yCU2f9kRjj9l9Kd4+yS8q87YAvEz6/q0hTEC8sLOKsShBwo9QHyVoTyjq3WmBoB+EkhOTfwIc9ZAEp91FO78Hx+EdF4PHgxACqEAwP6NbSJv5F
 pB+9sFmhl4V/IsmpaSKxPURjgEA5RW/cXn8MDL0RQKHsEOjYLyLmxtjYPa/kh29qB5XTQbaydufW0wvFKnzpnnGNc/Tzcz22ewwQxVdc6cp3ijYC+VAKdPgD
 fD7pycBSxputKG0Wgt9TQwnyknRcQxnBLdgcpZAiPo9w/VUToyKAG+A2OOPe1m4D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

This looks good apart from some missing error handling.

On 29/01/2019 15:01, Alban Gruin wrote:
> edit_todo_list() is changed to work on a todo_list, and to handle the
> initial edition of the todo list (ie. making a backup of the todo
> list).
> 
> It does not check for dropped commits yet, as todo_list_check() does not
> take the commits that have already been processed by the rebase (ie. the
> todo list is edited in the middle of a rebase session).
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--interactive.c | 24 +++++++++++++++++-
>   rebase-interactive.c          | 48 ++++++++++++++++++-----------------
>   rebase-interactive.h          |  4 ++-
>   sequencer.c                   |  3 +--
>   sequencer.h                   |  1 +
>   5 files changed, 53 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index 2dbf8fc08b..645ac587f7 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -13,6 +13,28 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
>   static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>   static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
>   
> +static int edit_todo_file(unsigned flags)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT,
> +		new_todo = TODO_LIST_INIT;
> +
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +
> +	strbuf_stripspace(&todo_list.buf, 1);
> +	if (!edit_todo_list(the_repository, &todo_list,
> +			    &new_todo, NULL, NULL, flags) &&
> +	    todo_list_write_to_file(the_repository, &new_todo, todo_file, NULL, NULL,
> +				    -1, flags & ~(TODO_LIST_SHORTEN_IDS)) < 0)
> +		return error_errno(_("could not write '%s'"), todo_file);

If edit_todo_list() fails then the function returns 0. I think you need 
to do

if (edit_todo_list() || todo_list_write_file())
	return error...

todo_list_write_file() forwards the return value of write_message() 
which is 0/-1 so there is no need for the '< 0'

> +
> +	todo_list_release(&todo_list);
> +	todo_list_release(&new_todo);
> +
> +	return 0;
> +}
> +
>   static int get_revision_ranges(const char *upstream, const char *onto,
>   			       const char **head_hash,
>   			       char **revisions, char **shortrevisions)
> @@ -242,7 +264,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   		break;
>   	}
>   	case EDIT_TODO:
> -		ret = edit_todo_list(the_repository, flags);
> +		ret = edit_todo_file(flags);
>   		break;
>   	case SHOW_CURRENT_PATCH: {
>   		struct child_process cmd = CHILD_PROCESS_INIT;
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 807f8370db..3301efbe52 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -87,35 +87,37 @@ void append_todo_help(unsigned keep_empty, int command_count,
>   	}
>   }
>   
> -int edit_todo_list(struct repository *r, unsigned flags)
> +int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> +		   struct todo_list *new_todo, const char *shortrevisions,
> +		   const char *shortonto, unsigned flags)
>   {
>   	const char *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	int res = 0;
> -
> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> -		return error_errno(_("could not read '%s'."), todo_file);
> -
> -	strbuf_stripspace(&todo_list.buf, 1);
> -	todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
> -	if (todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
> -				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP)) {
> -		todo_list_release(&todo_list);
> -		return -1;
> +	unsigned initial = shortrevisions && shortonto;
> +
> +	if (initial) {
> +		todo_list_write_to_file(r, todo_list, todo_file, shortrevisions, shortonto,
> +					-1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);

This has lost the error handling when we cannot write the file

> +
> +		if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
> +			return error(_("could not copy '%s' to '%s'."), todo_file,
> +				     rebase_path_todo_backup());
> +	} else {
> +		todo_list_parse_insn_buffer(r, todo_list->buf.buf, todo_list);
> +		todo_list_write_to_file(r, todo_list, todo_file, NULL, NULL, -1,
> +					flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP);

error handling again

>   	}
>   
> -	strbuf_reset(&todo_list.buf);
> -	if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
> -		todo_list_release(&todo_list);
> -		return -1;
> -	}
> +	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
> +		return -2;
>   
> -	if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list))
> -		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1,
> -					      flags & ~(TODO_LIST_SHORTEN_IDS));
> +	strbuf_stripspace(&new_todo->buf, 1);
> +	if (initial && new_todo->buf.len == 0)
> +		return -3;
>   
> -	todo_list_release(&todo_list);
> -	return res;
> +	if (!initial)
> +		todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);

error handling. Also why don't we try parse the file for the initial 
edit - is it done somewhere else?

Best Wishes

Phillip

> +
> +	return 0;
>   }
>   
>   define_commit_slab(commit_seen, unsigned char);
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 0e5925e3aa..44dbb06311 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -8,7 +8,9 @@ struct todo_list;
>   void append_todo_help(unsigned keep_empty, int command_count,
>   		      const char *shortrevisions, const char *shortonto,
>   		      struct strbuf *buf);
> -int edit_todo_list(struct repository *r, unsigned flags);
> +int edit_todo_list(struct repository *r, struct todo_list *todo_list,
> +		   struct todo_list *new_todo, const char *shortrevisions,
> +		   const char *shortonto, unsigned flags);
>   int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
>   
>   #endif
> diff --git a/sequencer.c b/sequencer.c
> index 92de982bc4..8f47f0cf39 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -55,8 +55,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
>    * file and written to the tail of 'done'.
>    */
>   GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
> -static GIT_PATH_FUNC(rebase_path_todo_backup,
> -		     "rebase-merge/git-rebase-todo.backup")
> +GIT_PATH_FUNC(rebase_path_todo_backup, "rebase-merge/git-rebase-todo.backup")
>   
>   /*
>    * The rebase command lines that have already been processed. A line
> diff --git a/sequencer.h b/sequencer.h
> index c5bee8124c..68acab980b 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -10,6 +10,7 @@ struct repository;
>   const char *git_path_commit_editmsg(void);
>   const char *git_path_seq_dir(void);
>   const char *rebase_path_todo(void);
> +const char *rebase_path_todo_backup(void);
>   
>   #define APPEND_SIGNOFF_DEDUP (1u << 0)
>   
> 

