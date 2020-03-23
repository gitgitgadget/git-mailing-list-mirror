Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B02C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DEF20719
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pibmf2uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCWScv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:32:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33495 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWScu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:32:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id c14so160459qtp.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PhcfndoLZdT5PDX3TG5Pm/vOTSQ6gbxvhLYlbMhzam0=;
        b=Pibmf2uoPSt5jO1mMw29k1kJVw/gU3vIup8fLvxmk4tXUx5+CA35h6zjFTe9y5NrMi
         J/KjWmFeL3X2iso3lc7yfLDXc96y6FsoiuxsiixDR32PhkeKLqUrZXdDj3dPMJK9mGNw
         QSXyqezMH40N3kjHec2zXad8iDIpakaFQrkFoMebL4RRwN2j3lqszToTs3xNnQkkHDZ8
         rUyW19Lr1eTDq7vxQEe9+5RIenStHUkhZSsZdgsM2ZY2wa95TzLy/KCjGdJn7mvA5Jg/
         4L7AcKQwQNlME/xW8vytPQIjg6hO+lplEMjsIVhBK4wFel/aRxX6REXSk4PnxopxTMuu
         yYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PhcfndoLZdT5PDX3TG5Pm/vOTSQ6gbxvhLYlbMhzam0=;
        b=AeHEImFoAZLFsNL06ed+ciWp9tlM8w+bTiQdlwjl/KLc6jah9TrD9BeHemOhZ91xjQ
         SgfwAMsftkz65spqgE0CyV2b+lwbOZlnt/pj5RMpOecxKrZ4OEoyytX/Pv6VYY+WzF2E
         5hcLBqIqRsd+H47Qdk6GxnHMquNSOPfftfZY6VvFk5RHDP0JLc3Oz2LcjClN+AgLPxlR
         J27ugz2feWEpxlScGoJ4p5+4MpDMYW5MROgjHjBEkawzwlqz3JCSX630qFATi7Lauim9
         gI0WPX65F4PHrmkMIvmEShB/ohzZ56Mjp0i4kCHsoj0IZKF6C7D4AkxkAjsH1nPhUCHN
         DhDQ==
X-Gm-Message-State: ANhLgQ3eHFxxFDClRLFC+TMNOxGM7KIlkulBMPpi+PNtKkwqmHpl3xYy
        GB9aXYHWA1c9B9rbBAQCZ1w=
X-Google-Smtp-Source: ADFU+vtcN/aLDUgRlRU1HXTX9ooRyVXcwRk4+wumn2RxCQvnk6svpXSrtOwf1DSg7JttiSSGZJ23/Q==
X-Received: by 2002:ac8:5252:: with SMTP id y18mr7060312qtn.311.1584988369392;
        Mon, 23 Mar 2020 11:32:49 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w18sm11362476qkw.130.2020.03.23.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:32:48 -0700 (PDT)
Subject: Re: [PATCH v2 14/18] unpack-trees: split display_error_msgs() into
 two
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
 <57679c8e292ceb58cea2b5b7d893d5f47e1e2de0.1584813609.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c384a788-9ce8-7a33-9d0d-e5dde746046e@gmail.com>
Date:   Mon, 23 Mar 2020 14:32:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <57679c8e292ceb58cea2b5b7d893d5f47e1e2de0.1584813609.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 2:00 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> display_error_msgs() is never called to show messages of both ERROR_*
> and WARNING_* types at the same time; it is instead called multiple
> times, separately for each type.  Since we want to display these types
> differently, make two slightly different versions of this function.
> 
> A subsequent commit will further modify unpack_trees() and how it calls
> the new display_warning_msgs().
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t1091-sparse-checkout-builtin.sh |  6 ++--
>  unpack-trees.c                     | 50 +++++++++++++++++++++++++-----
>  unpack-trees.h                     |  8 +++--
>  3 files changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 93c650ac038..0d93d3983e0 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -328,13 +328,13 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
>  	echo dirty >dirty/folder1/a &&
>  
>  	git -C dirty sparse-checkout init 2>err &&
> -	test_i18ngrep "error.*Cannot update sparse checkout" err &&
> +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
>  
>  	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
> -	test_i18ngrep "error.*Cannot update sparse checkout" err &&
> +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&
>  
>  	git -C dirty sparse-checkout disable &&
> -	test_i18ngrep "error.*Cannot update sparse checkout" err &&
> +	test_i18ngrep "warning.*Cannot update sparse checkout" err &&

I'm very happy this change is so clearly demonstrated by
a simple test change like this.

>  	git -C dirty reset --hard &&
>  	git -C dirty sparse-checkout init &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 0554842580b..9ee04992ac6 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -24,7 +24,7 @@
>   * situation better.  See how "git checkout" and "git merge" replaces
>   * them using setup_unpack_trees_porcelain(), for example.
>   */
> -static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
> +static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
>  	/* ERROR_WOULD_OVERWRITE */
>  	"Entry '%s' would be overwritten by merge. Cannot merge.",
>  
> @@ -46,6 +46,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
>  	/* ERROR_WOULD_LOSE_SUBMODULE */
>  	"Submodule '%s' cannot checkout new HEAD.",
>  
> +	/* NB_UNPACK_TREES_ERROR_TYPES; just a meta value */
> +	"",
> +
>  	/* WARNING_SPARSE_NOT_UPTODATE_FILE */
>  	"Entry '%s' not uptodate. Cannot update sparse checkout.",
>  
> @@ -222,7 +225,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
>  
>  	/*
>  	 * Otherwise, insert in a list for future display by
> -	 * display_error_msgs()
> +	 * display_(error|warning)_msgs()
>  	 */
>  	string_list_append(&o->unpack_rejects[e], path);
>  	return -1;
> @@ -233,13 +236,16 @@ static int add_rejected_path(struct unpack_trees_options *o,
>   */
>  static void display_error_msgs(struct unpack_trees_options *o)
>  {
> -	int e, i;
> -	int something_displayed = 0;
> +	int e;
> +	unsigned error_displayed = 0;
>  	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
>  		struct string_list *rejects = &o->unpack_rejects[e];
> +
>  		if (rejects->nr > 0) {
> +			int i;
>  			struct strbuf path = STRBUF_INIT;
> -			something_displayed = 1;
> +
> +			error_displayed = 1;
>  			for (i = 0; i < rejects->nr; i++)
>  				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
>  			error(ERRORMSG(o, e), super_prefixed(path.buf));
> @@ -247,10 +253,36 @@ static void display_error_msgs(struct unpack_trees_options *o)
>  		}
>  		string_list_clear(rejects, 0);
>  	}
> -	if (something_displayed)
> +	if (error_displayed)
>  		fprintf(stderr, _("Aborting\n"));
>  }
>  
> +/*
> + * display all the warning messages stored in a nice way
> + */
> +static void display_warning_msgs(struct unpack_trees_options *o)
> +{
> +	int e;
> +	unsigned warning_displayed = 0;
> +	for (e = NB_UNPACK_TREES_ERROR_TYPES+1;

super-nit: spaces around '+'

> +	     e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
> +		struct string_list *rejects = &o->unpack_rejects[e];
> +
> +		if (rejects->nr > 0) {
> +			int i;
> +			struct strbuf path = STRBUF_INIT;
> +
> +			warning_displayed = 1;
> +			for (i = 0; i < rejects->nr; i++)
> +				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
> +			warning(ERRORMSG(o, e), super_prefixed(path.buf));
> +			strbuf_release(&path);
> +		}
> +		string_list_clear(rejects, 0);
> +	}
> +	if (warning_displayed)
> +		fprintf(stderr, _("After fixing the above paths, you may want to run `git sparse-checkout reapply`.\n"));
> +}
>  static int check_submodule_move_head(const struct cache_entry *ce,
>  				     const char *old_id,
>  				     const char *new_id,
> @@ -1705,8 +1737,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	return ret;
>  
>  return_failed:
> -	if (o->show_all_errors)
> +	if (o->show_all_errors) {
>  		display_error_msgs(o);
> +		display_warning_msgs(o);
> +	}
>  	mark_all_ce_unused(o->src_index);
>  	ret = unpack_failed(o, NULL);
>  	if (o->exiting_early)
> @@ -1784,7 +1818,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
>  		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
>  
>  done:
> -	display_error_msgs(o);
> +	display_warning_msgs(o);
>  	o->show_all_errors = old_show_all_errors;
>  	if (free_pattern_list)
>  		clear_pattern_list(&pl);
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 3c6452fe9e5..d91c65ae453 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -24,10 +24,12 @@ enum unpack_trees_error_types {
>  	ERROR_BIND_OVERLAP,
>  	ERROR_WOULD_LOSE_SUBMODULE,
>  
> +	NB_UNPACK_TREES_ERROR_TYPES,
> +

I think this is a very clever way to partition the enum.

>  	WARNING_SPARSE_NOT_UPTODATE_FILE,
>  	WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN,
>  
> -	NB_UNPACK_TREES_ERROR_TYPES,
> +	NB_UNPACK_TREES_WARNING_TYPES,
>  };
>  
>  enum update_sparsity_result {
> @@ -73,13 +75,13 @@ struct unpack_trees_options {
>  	struct dir_struct *dir;
>  	struct pathspec *pathspec;
>  	merge_fn_t fn;
> -	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
> +	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
>  	struct argv_array msgs_to_free;
>  	/*
>  	 * Store error messages in an array, each case
>  	 * corresponding to a error message type
>  	 */
> -	struct string_list unpack_rejects[NB_UNPACK_TREES_ERROR_TYPES];
> +	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
>  
>  	int head_idx;
>  	int merge_size;

LGTM other than my really nitty nit-pick. Feel free to ignore.

-Stolee

