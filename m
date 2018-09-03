Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56AB1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeICXKr (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:10:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:60739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbeICXKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:10:46 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrvWY-1flKQk23rS-013hBY; Mon, 03
 Sep 2018 20:49:16 +0200
Date:   Mon, 3 Sep 2018 20:49:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 19/20] stash: optimize `get_untracked_files()`
 and `check_changes()`
In-Reply-To: <e4c17b20b0204386be06270e4a7f7283e6641f5a.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809032046470.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <e4c17b20b0204386be06270e4a7f7283e6641f5a.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7wqwssKfOZrtDRbpmejrDWDuyH2HSHHh2znVrfzfjj0tmPW2pNf
 qCUPiqouJtSwSQp0xiYJ73QmDhbFAvNaH6S2vIL/5hP1LNill+NZcxIx0Su+X2+jZQLjfaG
 g9JhFraz7No0ikqLWTJGeb1XVXMQmrDuceV8Q3v/d3If6xTuC+nDsOAcR14I2fZ0609C9LC
 4iMbfHU8yo+KZxirIOSKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uSd44gsQjjY=:H8P4VF7AOQ8LoN4fOsEWT0
 FSgTxtOds8ikefjAeucrHLDkWSSpLRAfTBLQAZ5SH1ez26/nVrEOrVYUSI/cpAkzTFAGR6InO
 4VkxbT8MBLy62sa3QoA7jzRB4uS0PB/GeZa3uK+di9zURRu2WH2x7MT9Lfkc6G826WrzUls3V
 /wXoR09K/7iSRf0E1HO6ysebMqnSBr1R4t8cHc9DVxSER2kiW/and7Srv/rZvFLh6ZlBsWjhP
 cgrOwZZNsIvJOcUsRcWY94AsAPufj8AO+I+784Jlq7F+W/5zPrnFAImDaUxbW8gyCRc5IyBTW
 WD2D99DyJUeGSY8ekaBBEcOX5JPKbxm6yLqLUTtZT51b1LPg+utTRd8HuFmfLh1NeQ1Uk2M/b
 rcyltBq/DOUyVrSn5XXZgUBfb1IExXOlcIvlUzGV797rUyWHAv5c3w/hAb5nN79pL6ed/UCOO
 NY5T8DZBWkhiPrjV0rCR8H8ofjdXF9XS/YW9kpe6/neLP+CI2/DLxWMoMfRj3ZglG8y3HoO5n
 gjzkkWxY0YIzl7I+aTyABSyl1Uj0TVpgCZlWpqlHfY+lL75dkUhMi7t4IylUYEi7kJWnrJAOq
 7Aoht9pyMsL9NB8EsHDlsVzFoRq3wzmeSjRLBOZ7xa9OTSs8Rg9eQSV6RKPZdgcDXvsz3uYLZ
 hOcozSraSgf+kRT/2MApq2+v9Uo8fm3GzrgiWaUoZT8ZOHtdHGdgbs8qm9KyK/hCh2SOC5QDk
 +Ohisp83cDQRIUP/13j0KBOLstF+gEAbVVMDwfnymPfUKN5YzZr9bxXuHRsqdKg1GZE7agW4m
 OzIRTS9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> This commits introduces a optimization by avoiding calling the
> same functions again. For example, `git stash push -u`
> would call at some points the following functions:
> 
>  * `check_changes()` (inside `do_push_stash()`)
>  * `do_create_stash()`, which calls: `check_changes()` and
> `get_untracked_files()`
> 
> Note that `check_changes()` also calls `get_untracked_files()`.
> So, `check_changes()` is called 2 times and `get_untracked_files()`
> 3 times.
> 
> `get_untracked_files()` has now only two parameters and it will
> fill a global strbuf called `untracked_files`.
> 
> The old function `check_changes()` now consists of two functions:
> `get_untracked_files()` and `check_changes_tracked_files()`.
> 
> These are the call chains for `push` and `create`:
> 
>  * `push_stash()` -> `do_push_stash()` -> `do_create_stash()`
> 
>  * `create_stash()` -> `do_create_stash()`
> 
> To prevent calling the same functions over and over again,
> `check_changes()` inside `do_create_stash()` is now placed
> in the caller functions (`create_stash()` and `do_push_stash()`).
> This way `check_changes()` and `get_untracked files()` are called
> only one time.
> 
> https://public-inbox.org/git/20180818223329.GJ11326@hank.intra.tgummerer.com/

I like the idea, and I like most of the implementation of it. However...

> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash.c | 73 ++++++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 40 deletions(-)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 3d2316e3f7..ba5818e24e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -813,13 +813,15 @@ static int store_stash(int argc, const char **argv, const char *prefix)
>  }
>  
>  /*
> - * `out` will be filled with the names of untracked files. The return value is:
> + * `untracked_files` will be filled with the names of untracked files.
> + * The return value is:
>   *
>   * = 0 if there are not any untracked files
>   * > 0 if there are untracked files
>   */
> -static int get_untracked_files(struct pathspec ps, int include_untracked,
> -			       struct strbuf *out)
> +static struct strbuf untracked_files = STRBUF_INIT;

... file-local variables invariably make it harder to reuse functions than
necessary. And as your code is pretty neat, I imagine that other
developers might want to reuse your functions by moving them out of the
builtin/ realm into the "internal API", and it would be better to prepare
the functions that way.

So if you can think at all of a place (or more places) in callers that
could hold the `untracked_files` variable, that would make it much easier
to "libify" your functions.

Thanks,
Dscho

> +
> +static int get_untracked_files(struct pathspec ps, int include_untracked)
>  {
>  	int max_len;
>  	int i;
> @@ -839,7 +841,7 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
>  			free(ent);
>  			continue;
>  		}
> -		strbuf_addf(out, "%s%c", ent->name, '\0');
> +		strbuf_addf(&untracked_files, "%s%c", ent->name, '\0');
>  		free(ent);
>  	}
>  
> @@ -847,23 +849,22 @@ static int get_untracked_files(struct pathspec ps, int include_untracked,
>  	free(dir.ignored);
>  	clear_directory(&dir);
>  	free(seen);
> -	return out->len;
> +	return untracked_files.len;
>  }
>  
>  /*
> - * The return value of `check_changes()` can be:
> + * The return value of `check_changes_tracked_files()` can be:
>   *
>   * < 0 if there was an error
>   * = 0 if there are no changes.
>   * > 0 if there are changes.
>   */
> -static int check_changes(struct pathspec ps, int include_untracked)
> +
> +static int check_changes_tracked_files(struct pathspec ps)
>  {
>  	int result;
> -	int ret = 0;
>  	struct rev_info rev;
>  	struct object_id dummy;
> -	struct strbuf out = STRBUF_INIT;
>  
>  	init_revisions(&rev, NULL);
>  	rev.prune_data = ps;
> @@ -890,18 +891,22 @@ static int check_changes(struct pathspec ps, int include_untracked)
>  	if (diff_result_code(&rev.diffopt, result))
>  		return 1;
>  
> -	if (include_untracked && get_untracked_files(ps, include_untracked,
> -						     &out)) {
> -		strbuf_release(&out);
> -		return 1;
> -	}
> -
> -	strbuf_release(&out);
>  	return 0;
>  }
>  
> -static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
> -				struct strbuf *in)
> +static int check_changes(struct pathspec ps, int include_untracked)
> +{
> +	int ret = 0;
> +	if (check_changes_tracked_files(ps))
> +		ret = 1;
> +
> +	if (include_untracked && get_untracked_files(ps, include_untracked))
> +		ret = 1;
> +
> +	return ret;
> +}
> +
> +static int save_untracked_files(struct stash_info *info, struct strbuf *msg)
>  {
>  	int ret = 0;
>  	struct strbuf untracked_msg = STRBUF_INIT;
> @@ -916,7 +921,8 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
>  			 stash_index_path.buf);
>  
>  	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
> -	if (pipe_command(&cp_upd_index, in->buf, in->len, NULL, 0, NULL, 0)) {
> +	if (pipe_command(&cp_upd_index, untracked_files.buf, untracked_files.len,
> +			 NULL, 0, NULL, 0)) {
>  		ret = -1;
>  		goto done;
>  	}
> @@ -1090,18 +1096,11 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
>  	struct commit_list *parents = NULL;
>  	struct strbuf msg = STRBUF_INIT;
>  	struct strbuf commit_tree_label = STRBUF_INIT;
> -	struct strbuf out = STRBUF_INIT;
>  	struct strbuf stash_msg_buf = STRBUF_INIT;
>  
>  	read_cache_preload(NULL);
>  	refresh_cache(REFRESH_QUIET);
>  
> -	if (!check_changes(ps, include_untracked)) {
> -		ret = 1;
> -		*stash_msg = NULL;
> -		goto done;
> -	}
> -
>  	if (get_oid("HEAD", &info->b_commit)) {
>  		if (!quiet)
>  			fprintf_ln(stderr, _("You do not have the initial commit yet"));
> @@ -1132,9 +1131,8 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
>  		goto done;
>  	}
>  
> -	if (include_untracked && get_untracked_files(ps, include_untracked,
> -						     &out)) {
> -		if (save_untracked_files(info, &msg, &out)) {
> +	if (include_untracked) {
> +		if (save_untracked_files(info, &msg)) {
>  			if (!quiet)
>  				fprintf_ln(stderr, _("Cannot save the untracked files"));
>  			ret = -1;
> @@ -1191,7 +1189,6 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
>  done:
>  	strbuf_release(&commit_tree_label);
>  	strbuf_release(&msg);
> -	strbuf_release(&out);
>  	strbuf_release(&stash_msg_buf);
>  	return ret;
>  }
> @@ -1213,25 +1210,21 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  			     git_stash_create_usage,
>  			     0);
>  
> +	memset(&ps, 0, sizeof(ps));
> +	if (!check_changes_tracked_files(ps))
> +		return 0;
> +
>  	for (i = 0; i < argc; ++i)
>  		strbuf_addf(&stash_msg_buf, "%s ", argv[i]);
>  	stash_msg = strbuf_detach(&stash_msg_buf, NULL);
>  	to_free = (char *) stash_msg;
>  
> -	memset(&ps, 0, sizeof(ps));
> -	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, 0);
> -
> -	if (!ret)
> +	if (!(ret = do_create_stash(ps, &stash_msg, 0, 0, &info, 0)))
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
>  
>  	free(to_free);
>  	free((char *) stash_msg);
> -
> -	/*
> -	 * ret can be 1 if there were no changes. In this case, we should
> -	 * not error out.
> -	 */
> -	return ret < 0;
> +	return ret;
>  }
>  
>  static void add_ps_items_to_argv_array(struct argv_array *args,
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
