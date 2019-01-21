Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4E11F453
	for <e@80x24.org>; Mon, 21 Jan 2019 15:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfAUPAC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 10:00:02 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:32302 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfAUPAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 10:00:02 -0500
Received: from [192.168.2.240] ([89.242.180.111])
        by smtp.talktalk.net with SMTP
        id lb3MgSaLmdJAelb3Mg1q2I; Mon, 21 Jan 2019 14:59:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548082797;
        bh=Tahd2S3br2+/lT8mrqqxIcB6DVPEOkTbfzIxjmSPZJc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DVnuEuw+wjKYdpneq/z7a8e3Br+ikeYtNn2emJNNrBp7CHf3jASakKmMZYQXqSfbB
         s0lbHspQJUrvQaGhvzGDmkDrTcBJx6QrBYni8fIkLb+be05spAD9Ge2Sp4HYJ+gCMb
         Uydm2KzCHTIPTpc5suuHPfn0nlf+flTTIhHyQvsI=
X-Originating-IP: [89.242.180.111]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yUcx3x9LIBXmIswB4ICbEw==:117
 a=yUcx3x9LIBXmIswB4ICbEw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=nxBd-tKk4zbOnZZSowkA:9 a=YGDutXTWX3EK6IGJ:21 a=_S3txx9iZwmyTZ1r:21
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/16] sequencer: remove the 'arg' field from todo_item
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181229160413.19333-1-alban.gruin@gmail.com>
 <20181229160413.19333-4-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6bc7f154-a18a-3311-cbd0-c2a578931c4b@talktalk.net>
Date:   Mon, 21 Jan 2019 14:59:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181229160413.19333-4-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIaJVmsXCAf08r6CzbxsbRNddbGT4GcHBA+3bup2WUpRyzAcijH4HstnetH7KJ4FjS4fdplzIDWhaZnZdlQZcmN/kvv6GtuSXpYfcFv4CXnau7PzopQf
 yQ1EgxgEMNYSEX007+y/uaDzXE2rg+1Fu1WBBxUh5u72xwBSlqo7Z3jCTyeRb8AlDAe2zU5UDzruyssMx5D5qAysRTWSNv316sgASqPt1RppfYUaLMoo8Vow
 VVpx/rr6Wa6Ld5YZM7eoMofI2t9IJyrGElBfV9uB71fsE3NGiy5luKCK6d2vYieBTCbI//8rikbUU2OcX5LMo+bfY71UqI7Q46QMkf2ofwM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I think this is a good change, I just wonder if it would be better to 
have an accessor function to get the arg pointer from a todo list item 
see below

On 29/12/2018 16:04, Alban Gruin wrote:
> The 'arg' field of todo_item used to store the address of the first byte
> of the parameter of a command in a todo list.  It was associated with
> the length of the parameter (the 'arg_len' field).
> 
> This replaces the 'arg' field by 'arg_offset'.  This new field does not
> store the address of the parameter, but the position of the first
> character of the parameter in the buffer.
> 
> This will prevent todo_list_add_exec_commands() from having to do awful
> pointer arithmetics when growing the todo list buffer.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> This is a new commit.
> 
>   sequencer.c | 61 ++++++++++++++++++++++++++++-------------------------
>   sequencer.h |  4 ++--
>   2 files changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5b84a20532..61be04ccc5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1950,7 +1950,7 @@ static struct todo_item *append_new_todo(struct todo_list *todo_list)
>   }
>   
>   static int parse_insn_line(struct repository *r, struct todo_item *item,
> -			   const char *bol, char *eol)
> +			   const char *buf, const char *bol, char *eol)
>   {
>   	struct object_id commit_oid;
>   	char *end_of_object_name;
> @@ -1964,7 +1964,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
>   		item->command = TODO_COMMENT;
>   		item->commit = NULL;
> -		item->arg = bol;
> +		item->arg_offset = bol - buf;
>   		item->arg_len = eol - bol;
>   		return 0;
>   	}
> @@ -1991,7 +1991,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   			return error(_("%s does not accept arguments: '%s'"),
>   				     command_to_string(item->command), bol);
>   		item->commit = NULL;
> -		item->arg = bol;
> +		item->arg_offset = bol - buf;
>   		item->arg_len = eol - bol;
>   		return 0;
>   	}
> @@ -2003,7 +2003,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>   	    item->command == TODO_RESET) {
>   		item->commit = NULL;
> -		item->arg = bol;
> +		item->arg_offset = bol - buf;
>   		item->arg_len = (int)(eol - bol);
>   		return 0;
>   	}
> @@ -2017,7 +2017,7 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   		} else {
>   			item->flags |= TODO_EDIT_MERGE_MSG;
>   			item->commit = NULL;
> -			item->arg = bol;
> +			item->arg_offset = bol - buf;
>   			item->arg_len = (int)(eol - bol);
>   			return 0;
>   		}
> @@ -2029,8 +2029,9 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>   	status = get_oid(bol, &commit_oid);
>   	*end_of_object_name = saved;
>   
> -	item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
> -	item->arg_len = (int)(eol - item->arg);
> +	bol = end_of_object_name + strspn(end_of_object_name, " \t");
> +	item->arg_offset = bol - buf;
> +	item->arg_len = (int)(eol - bol);
>   
>   	if (status < 0)
>   		return -1;
> @@ -2058,11 +2059,11 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>   
>   		item = append_new_todo(todo_list);
>   		item->offset_in_buf = p - todo_list->buf.buf;
> -		if (parse_insn_line(r, item, p, eol)) {
> +		if (parse_insn_line(r, item, buf, p, eol)) {
>   			res = error(_("invalid line %d: %.*s"),
>   				i, (int)(eol - p), p);
>   			item->command = TODO_COMMENT + 1;
> -			item->arg = p;
> +			item->arg_offset = p - buf;
>   			item->arg_len = (int)(eol - p);
>   			item->commit = NULL;
>   		}
> @@ -2402,7 +2403,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>   
>   		item->command = command;
>   		item->commit = commit;
> -		item->arg = NULL;
> +		item->arg_offset = 0;
>   		item->arg_len = 0;
>   		item->offset_in_buf = todo_list->buf.len;
>   		subject_len = find_commit_subject(commit_buffer, &subject);
> @@ -3438,6 +3439,8 @@ static int pick_commits(struct repository *r,
>   
>   	while (todo_list->current < todo_list->nr) {
>   		struct todo_item *item = todo_list->items + todo_list->current;
> +		const char *arg = todo_list->buf.buf + item->arg_offset;
> +
>   		if (save_todo(todo_list, opts))
>   			return -1;
>   		if (is_rebase_i(opts)) {
> @@ -3488,10 +3491,9 @@ static int pick_commits(struct repository *r,
>   					fprintf(stderr,
>   						_("Stopped at %s...  %.*s\n"),
>   						short_commit_name(commit),
> -						item->arg_len, item->arg);
> +						item->arg_len, arg);
>   				return error_with_patch(r, commit,
> -					item->arg, item->arg_len, opts, res,
> -					!res);
> +					arg, item->arg_len, opts, res, !res);
>   			}
>   			if (is_rebase_i(opts) && !res)
>   				record_in_rewritten(&item->commit->object.oid,
> @@ -3500,7 +3502,7 @@ static int pick_commits(struct repository *r,
>   				if (res == 1)
>   					intend_to_amend();
>   				return error_failed_squash(r, item->commit, opts,
> -					item->arg_len, item->arg);
> +					item->arg_len, arg);
>   			} else if (res && is_rebase_i(opts) && item->commit) {
>   				int to_amend = 0;
>   				struct object_id oid;
> @@ -3519,16 +3521,16 @@ static int pick_commits(struct repository *r,
>   					to_amend = 1;
>   
>   				return res | error_with_patch(r, item->commit,
> -						item->arg, item->arg_len, opts,
> +						arg, item->arg_len, opts,
>   						res, to_amend);
>   			}
>   		} else if (item->command == TODO_EXEC) {
> -			char *end_of_arg = (char *)(item->arg + item->arg_len);
> +			char *end_of_arg = (char *)(arg + item->arg_len);
>   			int saved = *end_of_arg;
>   			struct stat st;
>   
>   			*end_of_arg = '\0';
> -			res = do_exec(r, item->arg);
> +			res = do_exec(r, arg);
>   			*end_of_arg = saved;
>   
>   			/* Reread the todo file if it has changed. */
> @@ -3545,14 +3547,14 @@ static int pick_commits(struct repository *r,
>   				todo_list->current = -1;
>   			}
>   		} else if (item->command == TODO_LABEL) {
> -			if ((res = do_label(r, item->arg, item->arg_len)))
> +			if ((res = do_label(r, arg, item->arg_len)))
>   				reschedule = 1;
>   		} else if (item->command == TODO_RESET) {
> -			if ((res = do_reset(r, item->arg, item->arg_len, opts)))
> +			if ((res = do_reset(r, arg, item->arg_len, opts)))
>   				reschedule = 1;
>   		} else if (item->command == TODO_MERGE) {
>   			if ((res = do_merge(r, item->commit,
> -					    item->arg, item->arg_len,
> +					    arg, item->arg_len,
>   					    item->flags, opts)) < 0)
>   				reschedule = 1;
>   			else if (item->commit)
> @@ -3561,9 +3563,8 @@ static int pick_commits(struct repository *r,
>   			if (res > 0)
>   				/* failed with merge conflicts */
>   				return error_with_patch(r, item->commit,
> -							item->arg,
> -							item->arg_len, opts,
> -							res, 0);
> +							arg, item->arg_len,
> +							opts, res, 0);
>   		} else if (!is_noop(item->command))
>   			return error(_("unknown command %d"), item->command);
>   
> @@ -3578,9 +3579,8 @@ static int pick_commits(struct repository *r,
>   			if (item->commit)
>   				return error_with_patch(r,
>   							item->commit,
> -							item->arg,
> -							item->arg_len, opts,
> -							res, 0);
> +							arg, item->arg_len,
> +							opts, res, 0);
>   		}
>   
>   		todo_list->current++;
> @@ -4520,7 +4520,8 @@ int transform_todos(struct repository *r, unsigned flags)
>   	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {

I think the changes to this function would be clearer with
+		const char *arg = todo_list.buf.buf + item->arg_offset
here and then used arg instead of item->arg rather than calculating arg 
twice. Given that we are going to need to calculate arg again in 
check_todo_list() maybe it would be better to have a function

const char *get_item_arg(struct todo_list *todo, struct todo_list_item 
*item) {
	return todo->buf.buf + item->arg_offset;
}

and do
+		const char *arg = get_item_arg(&todo_list, item);
to avoid any accidents when calculating arg in future.

Best Wishes

Phillip

>   		/* if the item is not a command write it and continue */
>   		if (item->command >= TODO_COMMENT) {
> -			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
> +			strbuf_addf(&buf, "%.*s\n", item->arg_len,
> +				    todo_list.buf.buf + item->arg_offset);
>   			continue;
>   		}
>   
> @@ -4550,7 +4551,8 @@ int transform_todos(struct repository *r, unsigned flags)
>   		if (!item->arg_len)
>   			strbuf_addch(&buf, '\n');
>   		else
> -			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
> +			strbuf_addf(&buf, " %.*s\n", item->arg_len,
> +				    todo_list.buf.buf + item->arg_offset);
>   	}
>   
>   	i = write_message(buf.buf, buf.len, todo_file, 0);
> @@ -4626,7 +4628,8 @@ int check_todo_list(struct repository *r)
>   		if (commit && !*commit_seen_at(&commit_seen, commit)) {
>   			strbuf_addf(&missing, " - %s %.*s\n",
>   				    short_commit_name(commit),
> -				    item->arg_len, item->arg);
> +				    item->arg_len,
> +				    todo_list.buf.buf + item->arg_offset);
>   			*commit_seen_at(&commit_seen, commit) = 1;
>   		}
>   	}
> diff --git a/sequencer.h b/sequencer.h
> index 7dc4d8946b..70a896e756 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -104,9 +104,9 @@ struct todo_item {
>   	enum todo_command command;
>   	struct commit *commit;
>   	unsigned int flags;
> -	const char *arg;
>   	int arg_len;
> -	size_t offset_in_buf;
> +	/* The offset of the command and its argument in the strbuf */
> +	size_t offset_in_buf, arg_offset;
>   };
>   
>   struct todo_list {
> 

