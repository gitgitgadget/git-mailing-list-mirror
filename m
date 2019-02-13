Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B06D1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbfBMKRU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:17:20 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:34007 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfBMKRU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:17:20 -0500
Received: from [192.168.2.201] ([92.22.24.194])
        by smtp.talktalk.net with SMTP
        id trbOgx7zcoI6LtrbOgV5t0; Wed, 13 Feb 2019 10:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550053035;
        bh=b2Yd/L5WImr2ZJ/UoBfiW1OB2JLvh2VR+Oxvzx7gS+8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OUI+QwBL8ulnOFmR/FCdHoW8VgteX8huGPsUCkoTMC7g5jIEK28oEXSkR1yHAZM+2
         1SmkhZF/MoV7ewfOPBaPME1myWFWFVJW8WQaDySdb1J/Lxbb3cJid+zVgJkS8cwvlP
         Lhg05Dqu0dioeMSobZBofwEf7A6XdA+4Doeomj8Q=
X-Originating-IP: [92.22.24.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=OJBejJTAIYRVoGQ3FWVcuw==:117
 a=OJBejJTAIYRVoGQ3FWVcuw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=rcIynHm9lFjP8c9YvL4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 16/16] rebase--interactive: move several functions to
 rebase--interactive.c
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190210132648.12821-17-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <e04475c2-6e31-428c-41a1-1805d0378014@talktalk.net>
Date:   Wed, 13 Feb 2019 10:17:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210132648.12821-17-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCetEjQ7lLXMiCwkJfA3Lrvs0JFSbDoWUyyxaVunuJJvVC2d4nI3RwWZbtFgLa+QjDG3YvCMK0SfjBD0fVi1JRAPkZ6mJkB+ngovR70E5Tng7RH44Slo
 Gv1U5xIh/TaKqvV6RZhsjoN2a/0Nz8omjQtCao6ROy1S0GOQrx9spVfQhOhljXGHP8EaGihYf3U3aYtnIjGnn9608/0HvnzajvEucp7+ozH9dCuv6r6bJ19Q
 DFJYmRuRll3IeawxcqXXUSmArl2+3OPPnY2peQpuSOWflCwPWKuMEdir+V/A4vHVIhNNmoYufOX39cG3MKFreA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I think it is a good idea to move these functions out of sequencer.c,
previously I suggested moving them to rebase-interactive.c rather than
builtin/rebase--interactive.c but I don't think it matters that much. If
these can be moved when they're refactored (or in a separate commit
immediately after they're refactored if that makes the refactoring patch
clearer) rather than at the end it might make the history cleaner.

Best Wishes

Phillip

On 10/02/2019 13:26, Alban Gruin wrote:
> As sequencer_add_exec_commands(), rearrange_squash_in_todo_file(), and
> transform_todo_file() are only needed inside of rebase--interactive.c
> for rebase -p, they are moved there from sequencer.c.
> 
> The parameter r (repository) is dropped from them, and the error
> handling of rearrange_squash_in_todo_file() is slightly improved.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--interactive.c | 81 +++++++++++++++++++++++++++++++++--
>  sequencer.c                   | 79 ++--------------------------------
>  sequencer.h                   |  7 ++-
>  3 files changed, 84 insertions(+), 83 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index 370d584683..fb11f23692 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -13,6 +13,81 @@ static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
>  static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
>  static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
>  
> +static int add_exec_commands(struct string_list *commands)
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
> +	todo_list_add_exec_commands(&todo_list, commands);
> +	res = todo_list_write_to_file(the_repository, &todo_list,
> +				      todo_file, NULL, NULL, -1, 0);
> +	todo_list_release(&todo_list);
> +
> +	if (res)
> +		return error_errno(_("could not write '%s'."), todo_file);
> +	return 0;
> +}
> +
> +static int rearrange_squash_in_todo_file(void)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int res = 0;
> +
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +	if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
> +					&todo_list)) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}
> +
> +	res = todo_list_rearrange_squash(&todo_list);
> +	if (!res)
> +		res = todo_list_write_to_file(the_repository, &todo_list,
> +					      todo_file, NULL, NULL, -1, 0);
> +
> +	todo_list_release(&todo_list);
> +
> +	if (res)
> +		return error_errno(_("could not write '%s'."), todo_file);
> +	return 0;
> +}
> +
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
>  static int edit_todo_file(unsigned flags)
>  {
>  	const char *todo_file = rebase_path_todo();
> @@ -276,16 +351,16 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  	}
>  	case SHORTEN_OIDS:
>  	case EXPAND_OIDS:
> -		ret = transform_todo_file(the_repository, flags);
> +		ret = transform_todo_file(flags);
>  		break;
>  	case CHECK_TODO_LIST:
>  		ret = check_todo_list_from_file(the_repository);
>  		break;
>  	case REARRANGE_SQUASH:
> -		ret = rearrange_squash_in_todo_file(the_repository);
> +		ret = rearrange_squash_in_todo_file();
>  		break;
>  	case ADD_EXEC:
> -		ret = sequencer_add_exec_commands(the_repository, &commands);
> +		ret = add_exec_commands(&commands);
>  		break;
>  	default:
>  		BUG("invalid command '%d'", command);
> diff --git a/sequencer.c b/sequencer.c
> index df8b239fdc..7d35f83f4c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4499,8 +4499,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>   * Add commands after pick and (series of) squash/fixup commands
>   * in the todo list.
>   */
> -static void todo_list_add_exec_commands(struct todo_list *todo_list,
> -					struct string_list *commands)
> +void todo_list_add_exec_commands(struct todo_list *todo_list,
> +				 struct string_list *commands)
>  {
>  	struct strbuf *buf = &todo_list->buf;
>  	size_t base_offset = buf->len;
> @@ -4559,30 +4559,6 @@ static void todo_list_add_exec_commands(struct todo_list *todo_list,
>  	todo_list->alloc = alloc;
>  }
>  
> -int sequencer_add_exec_commands(struct repository *r,
> -				struct string_list *commands)
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
> -	todo_list_add_exec_commands(&todo_list, commands);
> -	res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
> -	todo_list_release(&todo_list);
> -
> -	if (res)
> -		return error_errno(_("could not write '%s'."), todo_file);
> -	return 0;
> -}
> -
>  static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
>  				struct strbuf *buf, int num, unsigned flags)
>  {
> @@ -4649,29 +4625,6 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
>  	return res;
>  }
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
>  static const char edit_todo_list_advice[] =
>  N_("You can fix this with 'git rebase --edit-todo' "
>  "and then run 'git rebase --continue'.\n"
> @@ -4754,8 +4707,6 @@ static int skip_unnecessary_picks(struct repository *r,
>  	return 0;
>  }
>  
> -static int todo_list_rearrange_squash(struct todo_list *todo_list);
> -
>  int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>  		    const char *shortrevisions, const char *onto_name,
>  		    const char *onto, const char *orig_head, struct string_list *commands,
> @@ -4862,7 +4813,7 @@ define_commit_slab(commit_todo_item, struct todo_item *);
>   * message will have to be retrieved from the commit (as the oneline in the
>   * script cannot be trusted) in order to normalize the autosquash arrangement.
>   */
> -static int todo_list_rearrange_squash(struct todo_list *todo_list)
> +int todo_list_rearrange_squash(struct todo_list *todo_list)
>  {
>  	struct hashmap subject2item;
>  	int rearranged = 0, *next, *tail, i, nr = 0, alloc = 0;
> @@ -5000,27 +4951,3 @@ static int todo_list_rearrange_squash(struct todo_list *todo_list)
>  
>  	return 0;
>  }
> -
> -int rearrange_squash_in_todo_file(struct repository *r)
> -{
> -	const char *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	int res = 0;
> -
> -	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
> -		return -1;
> -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
> -		todo_list_release(&todo_list);
> -		return -1;
> -	}
> -
> -	res = todo_list_rearrange_squash(&todo_list);
> -	if (!res)
> -		res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
> -
> -	todo_list_release(&todo_list);
> -
> -	if (res)
> -		return error_errno(_("could not write '%s'."), todo_file);
> -	return 0;
> -}
> diff --git a/sequencer.h b/sequencer.h
> index b0688ba2a1..7cca49eff2 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -143,15 +143,14 @@ int sequencer_remove_state(struct replay_opts *opts);
>  int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  			  const char **argv, unsigned flags);
>  
> -int sequencer_add_exec_commands(struct repository *r,
> -				struct string_list *commands);
> -int transform_todo_file(struct repository *r, unsigned flags);
> +void todo_list_add_exec_commands(struct todo_list *todo_list,
> +				 struct string_list *commands);
>  int check_todo_list_from_file(struct repository *r);
>  int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>  		    const char *shortrevisions, const char *onto_name,
>  		    const char *onto, const char *orig_head, struct string_list *commands,
>  		    unsigned autosquash, struct todo_list *todo_list);
> -int rearrange_squash_in_todo_file(struct repository *r);
> +int todo_list_rearrange_squash(struct todo_list *todo_list);
>  
>  extern const char sign_off_header[];
>  
> 

