Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED3C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 13:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEBC2077C
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 13:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cplbroBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgAJNSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:18:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34973 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgAJNSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 08:18:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1962939wmb.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 05:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0c1CYTuL+8MSUZjdHmA8h5/X/Pd9/Vck71yroM5m3g4=;
        b=cplbroBBCoGkV/Vkh3k8bI2PA/IAqlmzoHsH63XJCqMGD1geeZfQiu31HIews0beuA
         sb6O78XySzLx6bn0blCx011X5JQE91ybthy/bezxJhENAeBd5hVGwBVWo4a9FHny7ADs
         kiuy/ygOfMpAmOxhxHkjdbwDMo9RBg1NYn1wKZ3M1njlRUrkLx4LhfviBNDADgf47EY1
         MhHGjdboP3WEkKP3LM31+dVccD1rM9PNHX9fWetpFfyUrOH+BH5x76DQWTAbj77sSDgd
         9zwzPmDmUagFhh3Uez7XYcxrVYVvwbuCaUKfoyFPxboHtkVA7zcRUf1Uorbp3e8PMYc/
         AxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0c1CYTuL+8MSUZjdHmA8h5/X/Pd9/Vck71yroM5m3g4=;
        b=SOXHng5JwfXPS7SGMqpmFBzlkkkn7KNYqvToazTHzABjilBXVwMRIrsD/zZZ3unkEm
         V/0EE69ryt6TRrXQd4OUe00z07FuwPBhypPwNpNPD4tk30putICLQUF9wRwe6tPv6Apm
         om+kfLDwOTqEPFSPxFAOAgEJPogVrMsGpLIpsZU2tToZFIxic3fp6OnAxrFeZ+j2XOka
         Mvd5maBFyQ2OVh+jPatrYuOT6aYG3e5JMCvks1KlKOicwwb8HXTHkXXG1BrNYrbHTYCl
         O+tbnHJY5PwXPJRt1ymuK0IkjIsH4ZiME0ep14lpE3fxL7z0pZHnEX0hj+UqixsBaL4Z
         GMEw==
X-Gm-Message-State: APjAAAVnHE+Z64UMG40yoO9YUhEGgw4OluGtzn+gl2SAkCpcggf2JccX
        //x6dxDZp/v+dSX2G46eoqs=
X-Google-Smtp-Source: APXvYqwOm721OcqWIqn1iCx6Vsieb7RgeBlPhlp2vUWgWim3EgvemYbWj5qTPaPbNi4C/hMTYsQvyw==
X-Received: by 2002:a05:600c:244:: with SMTP id 4mr4202775wmj.40.1578662323996;
        Fri, 10 Jan 2020 05:18:43 -0800 (PST)
Received: from szeder.dev (x4d0c4ac7.dyn.telefonica.de. [77.12.74.199])
        by smtp.gmail.com with ESMTPSA id o15sm2173761wra.83.2020.01.10.05.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2020 05:18:43 -0800 (PST)
Date:   Fri, 10 Jan 2020 14:18:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RFC: allow branch --edit-description during rebase
Message-ID: <20200110131840.GG32750@szeder.dev>
References: <20200110071929.119000-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200110071929.119000-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 11:19:29AM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This patch aims to allow editing of branch description during a rebase.
> 
> A common use case of rebasing is to iterate over a series of patches
> after receiving reviews. During the rebase, various patches will be
> modified, and it is often requested to put a summary of the changes for
> the next version in the cover letter ("v2: - fixed this, - changed
> that.."). This helps the reviewer to focus on the difference with the
> previous version.  Unfortunately, git branch --edit-description doesn't
> allow yet to modify the content during a rebase, and forces the author
> to use memory muscles to update the description after finishing the
> rebase.

That's not true, 'git branch --edit-description mybranch' already
allows you to edit the branch description of the currently rebased
branch (well, basically of any branch, really).

So it's not really about allowing '--edit-description' during rebase,
but choosing the default branch during rebase sensibly, and the
subject line could be something like "branch: let '--edit-description'
default to rebased branch during rebase", and the rest of the commit
message should be updated accordingly.

Having said that, I agree that defaulting to editing the description
of the rebased branch without an explicit branchname argument makes
sense.  Even the git bash prompt shows the name of the rebased branch,
and then

  ~/src/git (mybranch|REBASE-i 1/2)$ git branch --edit-description 
  fatal: Cannot give description to detached HEAD

looks quite unhelpful.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  builtin/branch.c | 19 ++++++++++++++++---
>  worktree.c       | 19 +++++++++++++++++++
>  worktree.h       |  7 +++++++

Tests? :)

I think it's worth checking '--edit-description' while rebasing a
branch, while rebasing a detached HEAD, and while rebasing in a
different worktree.

>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index d8297f80ff..f7122d31d6 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -613,6 +613,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	int icase = 0;
>  	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
>  	struct ref_format format = REF_FORMAT_INIT;
> +	struct wt_status_state state;

This variable is only used for '--edit-description', and even then only
when on a detached head; please limit its scope.

>  	struct option options[] = {
>  		OPT_GROUP(N_("Generic options")),
> @@ -664,6 +665,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  	setup_ref_filter_porcelain_msg();
>  
> +	memset(&state, 0, sizeof(state));
> +
>  	memset(&filter, 0, sizeof(filter));
>  	filter.kind = FILTER_REFS_BRANCHES;
>  	filter.abbrev = -1;
> @@ -745,13 +748,21 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		string_list_clear(&output, 0);
>  		return 0;
>  	} else if (edit_description) {
> -		const char *branch_name;
> +		const char *branch_name = NULL;
>  		struct strbuf branch_ref = STRBUF_INIT;
>  
>  		if (!argc) {
> -			if (filter.detached)
> +		    if (filter.detached) {

Please use tabs for indentation.

> +			const struct worktree *wt = worktree_get_current();
> +
> +			if (wt_status_check_rebase(wt, &state)) {

I think passing NULL as the 'wt' argument means "check the current
worktree".  If that's indeed the case then you don't have to add that
worktree_get_current() function at all.

> +				branch_name = state.branch;
> +			}
> +
> +			if (!branch_name)
>  				die(_("Cannot give description to detached HEAD"));
> -			branch_name = head;
> +		    } else
> +			    branch_name = head;
>  		} else if (argc == 1)
>  			branch_name = argv[0];
>  		else
> @@ -851,5 +862,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
>  
> +	free(state.branch);
> +	free(state.onto);
>  	return 0;
>  }
> diff --git a/worktree.c b/worktree.c
> index 5b4793caa3..0318c6f6a6 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -396,6 +396,25 @@ int is_worktree_being_bisected(const struct worktree *wt,
>  	return found_rebase;
>  }
>  
> +const struct worktree *worktree_get_current(void)
> +{
> +	static struct worktree **worktrees;
> +	int i = 0;
> +
> +	if (worktrees)
> +		free_worktrees(worktrees);
> +	worktrees = get_worktrees(0);

I'm not sure about this static worktrees array and how it is handled
here.  I mean, can the current worktree change mid-process?

(Though this is moot if this function turns out to be unnecessary, as
mentioned above.)

> +	for (i = 0; worktrees[i]; i++) {
> +		struct worktree *wt = worktrees[i];
> +
> +		if (wt->is_current)
> +			return wt;
> +	}
> +
> +	return NULL;
> +}
> +
>  /*
>   * note: this function should be able to detect shared symref even if
>   * HEAD is temporarily detached (e.g. in the middle of rebase or
> diff --git a/worktree.h b/worktree.h
> index caecc7a281..4fe2b78d24 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -91,6 +91,13 @@ void free_worktrees(struct worktree **);
>  const struct worktree *find_shared_symref(const char *symref,
>  					  const char *target);
>  
> +
> +/*
> + * Return the current worktree. The result may be destroyed by the
> + * next call.
> + */
> +const struct worktree *worktree_get_current(void);
> +
>  /*
>   * Similar to head_ref() for all HEADs _except_ one from the current
>   * worktree, which is covered by head_ref().
> 
> base-commit: 042ed3e048af08014487d19196984347e3be7d1c
> prerequisite-patch-id: 9b3cf75545ec4a1e702c8c2b2aae8edf241b87f2
> -- 
> 2.25.0.rc1.20.g2443f3f80d.dirty
> 
