Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2412C432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0B660E90
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhHQR0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhHQR0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:26:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B5CC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:26:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id by4so32693641edb.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TmB7WtUF30GLTPZlKnEcPgcLU4I0RqRM8FSWj9NKyTE=;
        b=fvNuzbrHFhNTrtdnP7up9KlW/Mu3eBrxTDfS9l0uN7/2CrUwb7ntmGYr5l+TnGwbEW
         XUiSTocYortZwcQzGCiSzPsOb4FGq0nSC40bZlU8Coe7EfSLbluwFzv86O/tS0YVyvqL
         2sIQH/ZvWnt5DU1UcfRSqifG7ZRmxRJWzm8shLM/HuaK3lHmOk0f01zaUBMnyyiwfsba
         7MHHZWWFkfXS8mM8SA7a9UUDAa1hAfmhe+KVktXrgXIrCSH4jlXGRhSp6XTPfz/DwCA8
         UdvOpkt4eeTMmU15s+0Uxlbi2xOxf+LcfJpVHECryukn0Fzum+GNc+0hTRIgNYC692aL
         WGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TmB7WtUF30GLTPZlKnEcPgcLU4I0RqRM8FSWj9NKyTE=;
        b=nxQdGZZ7B/N1c71gc20lzkv8QGzDMunJi8iQ4KxbK7k46I3MOlhKjIjpZQXId+1rbS
         /ae1LxSozaoMJAm9RS7149g7MWFzx6Lrg8v8WGY55c/k9/aGnGcRCIna1aZJDsk+uLIu
         g8JM7Uuvow+uy92ZyA17BDiawJL18bk5xtTXi0Ojnxcbt9+rnT5ibjUNFxQgHmwcrtW2
         6VgEuHYhmtaIvUCHdzNAWrbYfBj0Yi/u/yneEw39LKmr9CMxs9ebb3/go3ME3QrRs77S
         Ztf+otR4noAuvuXmY5bGVK37LzrnflXHWiZ/6LiWQk3ziGCfCZ2v2Wkmhch51Y2zlfhB
         iNCA==
X-Gm-Message-State: AOAM530SEH/bdbG4BSkmRK0AoeA980H/6O9UYGvQqGfbBrZKo3bsudlA
        0ivx+gxwF3HIWKvIRK0b3Kg=
X-Google-Smtp-Source: ABdhPJwjhdSzgoZo+2z3ajvMeGk2msdrgRJxfq/LX9dcZ8ygcMBhClLdJj62jNBW11YQYE+9MfZ3dg==
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr5170451eds.381.1629221172562;
        Tue, 17 Aug 2021 10:26:12 -0700 (PDT)
Received: from szeder.dev (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id bm26sm1024383ejb.16.2021.08.17.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:26:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 19:26:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/4] rebase -r: don't write .git/MERGE_MSG when
 fast-forwarding
Message-ID: <20210817172609.GB2257957@szeder.dev>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
 <01d5ed4cba04d69e484d2c040635632df914bfa6.1628860053.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01d5ed4cba04d69e484d2c040635632df914bfa6.1628860053.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 01:07:32PM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When fast-forwarding we do not create a new commit so .git/MERGE_MSG
> is not removed and can end up seeding the message of a commit made
> after the rebase has finished. Avoid writing .git/MERGE_MSG when we
> are fast-forwarding by writing the file after the fast-forward
> checks.
> 
> Note that the way this change is implemented means we no longer write
> the author script when fast-forwarding either. I believe this is safe
> for the reasons below but it is a departure from what we do when
> fast-forwarding a non-merge commit. If we reword the merge then 'git
> commit --amend' will keep the authorship of the commit we're rewording
> as it ignores GIT_AUTHOR_* unless --reset-author is passed. It will
> also export the correct GIT_AUTHOR_* variables to any hooks and we
> already test the authorship of the reworded commit. If we are not
> rewording then we no longer call spilt_ident() which means we are no
> longer checking the commit author header looks sane. However this is
> what we already do when fast-forwarding non-merge commits in
> skip_unnecessary_picks() so I don't think we're breaking any promises
> by not checking the author here.

Thanks you for fixing this bug.

FWIW (not that much, I'm afraid), I think your reasoning about the
harmlessness of the behavior change concerning the author script makes
sense.

My only nit is that the movement of a ~40 lines block of code makes
out the bulk of the patch; perhaps it would be worth mentioning it
explicitly in the commit message, so future readers of this commit
won't look for changes in those hunks.

> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c     | 81 +++++++++++++++++++++++++------------------------
>  t/lib-rebase.sh | 10 ++++--
>  2 files changed, 49 insertions(+), 42 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index cc8a361cceb..c2cba5ed4b1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -983,7 +983,8 @@ static int run_git_commit(const char *defmsg,
>  
>  	cmd.git_cmd = 1;
>  
> -	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
> +	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
> +	    read_env_script(&cmd.env_array)) {
>  		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>  
>  		return error(_(staged_changes_advice),
> @@ -3815,6 +3816,45 @@ static int do_merge(struct repository *r,
>  		goto leave_merge;
>  	}
>  
> +	/*
> +	 * If HEAD is not identical to the first parent of the original merge
> +	 * commit, we cannot fast-forward.
> +	 */
> +	can_fast_forward = opts->allow_ff && commit && commit->parents &&
> +		oideq(&commit->parents->item->object.oid,
> +		      &head_commit->object.oid);
> +
> +	/*
> +	 * If any merge head is different from the original one, we cannot
> +	 * fast-forward.
> +	 */
> +	if (can_fast_forward) {
> +		struct commit_list *p = commit->parents->next;
> +
> +		for (j = to_merge; j && p; j = j->next, p = p->next)
> +			if (!oideq(&j->item->object.oid,
> +				   &p->item->object.oid)) {
> +				can_fast_forward = 0;
> +				break;
> +			}
> +		/*
> +		 * If the number of merge heads differs from the original merge
> +		 * commit, we cannot fast-forward.
> +		 */
> +		if (j || p)
> +			can_fast_forward = 0;
> +	}
> +
> +	if (can_fast_forward) {
> +		rollback_lock_file(&lock);
> +		ret = fast_forward_to(r, &commit->object.oid,
> +				      &head_commit->object.oid, 0, opts);
> +		if (flags & TODO_EDIT_MERGE_MSG)
> +			goto fast_forward_edit;
> +
> +		goto leave_merge;
> +	}
> +
>  	if (commit) {
>  		const char *encoding = get_commit_output_encoding();
>  		const char *message = logmsg_reencode(commit, NULL, encoding);
> @@ -3864,45 +3904,6 @@ static int do_merge(struct repository *r,
>  		}
>  	}
>  
> -	/*
> -	 * If HEAD is not identical to the first parent of the original merge
> -	 * commit, we cannot fast-forward.
> -	 */
> -	can_fast_forward = opts->allow_ff && commit && commit->parents &&
> -		oideq(&commit->parents->item->object.oid,
> -		      &head_commit->object.oid);
> -
> -	/*
> -	 * If any merge head is different from the original one, we cannot
> -	 * fast-forward.
> -	 */
> -	if (can_fast_forward) {
> -		struct commit_list *p = commit->parents->next;
> -
> -		for (j = to_merge; j && p; j = j->next, p = p->next)
> -			if (!oideq(&j->item->object.oid,
> -				   &p->item->object.oid)) {
> -				can_fast_forward = 0;
> -				break;
> -			}
> -		/*
> -		 * If the number of merge heads differs from the original merge
> -		 * commit, we cannot fast-forward.
> -		 */
> -		if (j || p)
> -			can_fast_forward = 0;
> -	}
> -
> -	if (can_fast_forward) {
> -		rollback_lock_file(&lock);
> -		ret = fast_forward_to(r, &commit->object.oid,
> -				      &head_commit->object.oid, 0, opts);
> -		if (flags & TODO_EDIT_MERGE_MSG)
> -			goto fast_forward_edit;
> -
> -		goto leave_merge;
> -	}
> -
>  	if (strategy || to_merge->next) {
>  		/* Octopus merge */
>  		struct child_process cmd = CHILD_PROCESS_INIT;
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 99d9e7efd2d..ec6b9b107da 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -173,10 +173,16 @@ set_reword_editor () {
>  
>  	write_script reword-editor.sh <<-EOF &&
>  	# Save the oid of the first reworded commit so we can check rebase
> -	# fast-forwards to it
> +	# fast-forwards to it. Also check that we do not write .git/MERGE_MSG
> +	# when fast-forwarding
>  	if ! test -s reword-oid
>  	then
> -		git rev-parse HEAD >reword-oid
> +		git rev-parse HEAD >reword-oid &&
> +		if test -f .git/MERGE_MSG
> +		then
> +			echo 1>&2 "error: .git/MERGE_MSG exists"
> +			exit 1
> +		fi
>  	fi &&
>  	# There should be no uncommited changes
>  	git diff --exit-code HEAD &&
> -- 
> gitgitgadget
> 
