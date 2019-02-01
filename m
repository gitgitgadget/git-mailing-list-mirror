Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9B91F453
	for <e@80x24.org>; Fri,  1 Feb 2019 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBALPf (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 06:15:35 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:37446 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfBALPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 06:15:35 -0500
Received: from [192.168.2.240] ([92.26.116.186])
        by smtp.talktalk.net with SMTP
        id pWn5gLKJdwhzSpWnCgcFkI; Fri, 01 Feb 2019 11:15:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549019733;
        bh=2B0In/oUtgjKvuZiOtiicIrBxvhNeB1dW0QVzFU4jEc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FYYgDKyRBEnrOLyDUqNniw9fDkYhbAd/mmy7fOx951srFBnhRE90ChBOgPAojpa5y
         uNOe9OV+D3Cbbv8VZmntOs9MLA6+/F0gNV/NznlCqkJOLWnRfqPFPLUChTE5PGRdkb
         79kGYUMeZhyYYR8kDhZCn3DBiaRCcl3TRcyRjaIc=
X-Originating-IP: [92.26.116.186]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=Pfo8oxCPEre7EYRssK5nbQ==:117
 a=Pfo8oxCPEre7EYRssK5nbQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=hSzC6YhCil4ctn9M5b0A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 16/16] rebase--interactive: move transform_todo_file()
 to rebase--interactive.c
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-17-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d00c11bc-013e-5839-9766-6999e99edf34@talktalk.net>
Date:   Fri, 1 Feb 2019 11:15:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129150159.10588-17-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBp8tKB576YhGrGCM+3cJ5DP8YunZ3aC9CCznwzd7ai4w/QvVJdOxH/s5Ij5i0tY0dWP6PuOYg6QMj4j+rrbqFIiCNagCDD3BHgSMyfNjzsvpVI0t1+N
 w4v7NI+gyJ0VaCUWiyjyiJBh4ggVXX4eTP8Re/3Dp6RkZ9PCmVTRD3WmiA7EcOjNsDpIqUO9PihI4uzK/ue/WP5ARRdfUFSNby50OaC8zT9fboDYogYFAzfm
 tbHmk9BIFJ9XN9aCWqApvjDlKtu8D3nR2MYNoWhuw8ydTgs3E8RZ7mzP2TOD0g65kGPvhC63aXbN1K8RzHx3GQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 29/01/2019 15:01, Alban Gruin wrote:
> As transform_todo_file() is only needed inside of rebase--interactive.c,
> it is moved there from sequencer.c.

I think I'd prefer to minimize the code under builtin and move this to 
rebase-interactive.c when it is modified earlier in the series. (I'd be 
quite happy if all the files in builtin just consisted of some option 
parsing followed by a call to run_git_foo() which resides in libgit)

Also I wonder if we should be moving more functions (e.g. 
todo_list_write_file() and possibly add_exec_commands(), 
rearrange_squash() and the script generation) from sequencer.c to 
rebase-interactive.c when they're rewritten (possibly in a separate 
commit for ease of review) but I haven't looked if this is practical or 
if there are some dependencies that make that tricky. Unless there are 
some simple cases it should probably be a separate series.

Thanks for working on this series, it's great to see the todo list 
handling becoming more efficient.

Best Wishes

Phillip

> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--interactive.c | 26 +++++++++++++++++++++++++-
>   sequencer.c                   | 23 -----------------------
>   sequencer.h                   |  1 -
>   3 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index 645ac587f7..7f1e88a087 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -35,6 +35,30 @@ static int edit_todo_file(unsigned flags)
>   	return 0;
>   }
>   
> +static int transform_todo_file(unsigned flags)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int res;
> +
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +
> +	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
> +					&todo_list)) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}
> +
> +	res = todo_list_write_to_file(the_repository, &todo_list, todo_file,
> +				      NULL, NULL, -1, flags);
> +	todo_list_release(&todo_list);
> +
> +	if (res)
> +		return error_errno(_("could not write '%s'."), todo_file);
> +	return 0;
> +}
> +
>   static int get_revision_ranges(const char *upstream, const char *onto,
>   			       const char **head_hash,
>   			       char **revisions, char **shortrevisions)
> @@ -277,7 +301,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   	}
>   	case SHORTEN_OIDS:
>   	case EXPAND_OIDS:
> -		ret = transform_todo_file(the_repository, flags);
> +		ret = transform_todo_file(flags);
>   		break;
>   	case CHECK_TODO_LIST:
>   		ret = check_todo_list_from_file(the_repository);
> diff --git a/sequencer.c b/sequencer.c
> index 21b04e0642..5239700efc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4593,29 +4593,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
>   	return res;
>   }
>   
> -int transform_todo_file(struct repository *r, unsigned flags)
> -{
> -	const char *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	int res;
> -
> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> -		return error_errno(_("could not read '%s'."), todo_file);
> -
> -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
> -		todo_list_release(&todo_list);
> -		return error(_("unusable todo list: '%s'"), todo_file);
> -	}
> -
> -	res = todo_list_write_to_file(r, &todo_list, todo_file,
> -				      NULL, NULL, -1, flags);
> -	todo_list_release(&todo_list);
> -
> -	if (res)
> -		return error_errno(_("could not write '%s'."), todo_file);
> -	return 0;
> -}
> -
>   static const char edit_todo_list_advice[] =
>   N_("You can fix this with 'git rebase --edit-todo' "
>   "and then run 'git rebase --continue'.\n"
> diff --git a/sequencer.h b/sequencer.h
> index 68acab980b..11afd47aa9 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -145,7 +145,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>   
>   int sequencer_add_exec_commands(struct repository *r,
>   				struct string_list *commands);
> -int transform_todo_file(struct repository *r, unsigned flags);
>   int check_todo_list_from_file(struct repository *r);
>   int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
> 

