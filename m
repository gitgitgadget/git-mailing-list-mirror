Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A151F437
	for <e@80x24.org>; Tue, 24 Jan 2017 21:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbdAXV6z (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 16:58:55 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35385 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdAXV6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 16:58:54 -0500
Received: by mail-pg0-f43.google.com with SMTP id 194so58094913pgd.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1RaA9Cm0CgR7VtFP8JYzq8uPHcrBv5cO5B3z0Ixu4DQ=;
        b=XhZYUbC6jz3qPM4+cDXYA+XslJioPgUSwWdHKr2sYrXd9TjZK09ZRp3Lantablrtz8
         Yt+w3ptWpTSkmrkwTknOt3QJ5MefDkfheHh2kGm9T9IJap55Fj+ufk4aLFAnUo6Rp6Iw
         7Cv+lwRXMVklGI6q18srALXo/WfFffSmC20z7Oz67Ghd1aefgbjwQ+ydK6y6aShgRPWm
         fxdNpDwvN0oZ9Zu7QQPphwM/6lOJgqaIJOAKgGZozHK8HNNcL2eK0uQPeb8HjR9Iy0LN
         0MZjSKqX59iPxgNjWplGysKMEoYLIAtk80RErYILhM0p8uvgvxsa1p8Xx+GMrEOFtmoe
         /A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1RaA9Cm0CgR7VtFP8JYzq8uPHcrBv5cO5B3z0Ixu4DQ=;
        b=cQF9J8iTspcIXCPLpx8T4ORlaPqQrhpiDgoeMgdZp7q0BqYcuoOQpfNAYzqenSpP3L
         w99E0hAlHSEkYlnjWFCz9msQFnBZgvfUtEKx33MLpP2zo0arZ9D4knRzZd8wIBqs0ty4
         5PmbXn7Vt3lv67i3kIaXvNttHzwPoImnwDqoNgbzHEUwZF88VOjbhtrCiExUvgcP7WVA
         /ankPr3GxRqUJHrt0fq8mXDhZ0beqe6AKATGjM7D/cwwM4OmTSp23oUQmc9CO4pZvfs/
         thFYuBkeQl9PhEWEVSwFqTsDbpnQBg4yrVlhImQMTDW/BWoAWxANqNVkQO14q/1UmDEy
         g+IQ==
X-Gm-Message-State: AIkVDXIcItH5IA2/O5QIMlp+afbSrzjCl0qNTiWdkh679ImfSqr6e0AeFkkzVOWNeRAhx/So
X-Received: by 10.98.139.22 with SMTP id j22mr41549147pfe.115.1485295133756;
        Tue, 24 Jan 2017 13:58:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:85e5:5d8f:4777:ba11])
        by smtp.gmail.com with ESMTPSA id b75sm21815390pfb.90.2017.01.24.13.58.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Jan 2017 13:58:52 -0800 (PST)
Date:   Tue, 24 Jan 2017 13:58:51 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] submodule absorbing: fix worktree/gitdir pointers
 recursively for non-moves
Message-ID: <20170124215851.GA58021@google.com>
References: <20170124210346.12060-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170124210346.12060-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/24, Stefan Beller wrote:
> +	if (read_gitfile_gently(old_git_dir, &err_code) ||
> +	    err_code == READ_GITFILE_ERR_NOT_A_REPO) {
> +		/*
> +		 * If it is an actual gitfile, it doesn't need migration,
> +		 * however in case of a recursively nested submodule, the
> +		 * gitfile content may be stale, as its superproject
> +		 * (which may be a submodule of another superproject)
> +		 * may have been moved. So expect a bogus pointer to be read,
> +		 * which materializes as error READ_GITFILE_ERR_NOT_A_REPO.
> +		 */
> +		connect_work_tree_and_git_dir(path, real_new_git_dir);

So connect_work_tree_and_git_dir() will update the .gitfile if it is
stale.

> +		return;
> +	}
> +
> +	if (submodule_uses_worktrees(path))
> +		die(_("relocate_gitdir for submodule '%s' with "
> +		      "more than one worktree not supported"), path);

No current support for worktrees (yet!).

> +
>  	if (!prefix)
>  		prefix = get_super_prefix();
>  
> @@ -1437,22 +1448,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  				      const char *path,
>  				      unsigned flags)
>  {
> -	const char *sub_git_dir, *v;
> -	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
>  	struct strbuf gitdir = STRBUF_INIT;
> -
>  	strbuf_addf(&gitdir, "%s/.git", path);
> -	sub_git_dir = resolve_gitdir(gitdir.buf);
>  
>  	/* Not populated? */
> -	if (!sub_git_dir)
> +	if (!file_exists(gitdir.buf))
>  		goto out;

There should be a is_submodule_populated() function now, maybe
we should start using it when performing population checks?

>  
> -	/* Is it already absorbed into the superprojects git dir? */
> -	real_sub_git_dir = real_pathdup(sub_git_dir);
> -	real_common_git_dir = real_pathdup(get_git_common_dir());
> -	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
> -		relocate_single_git_dir_into_superproject(prefix, path);
> +	relocate_single_git_dir_into_superproject(prefix, path);

So the check was just pushed into the relocation function.

>  
>  	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> @@ -1481,6 +1484,4 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  
>  out:
>  	strbuf_release(&gitdir);
> -	free(real_sub_git_dir);
> -	free(real_common_git_dir);
>  }
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 1c47780e2b..e2bbb449b6 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -64,6 +64,33 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>  	test_cmp expect.2 actual.2
>  '
>  
> +test_expect_success 're-setup nested submodule' '
> +	# un-absorb the direct submodule, to test if the nested submodule
> +	# is still correct (needs a rewrite of the gitfile only)
> +	rm -rf sub1/.git &&
> +	mv .git/modules/sub1 sub1/.git &&
> +	GIT_WORK_TREE=. git -C sub1 config --unset core.worktree &&
> +	# fixup the nested submodule
> +	echo "gitdir: ../.git/modules/nested" >sub1/nested/.git &&
> +	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
> +		core.worktree "../../../nested" &&
> +	# make sure this re-setup is correct
> +	git status --ignore-submodules=none
> +'
> +
> +test_expect_success 'absorb the git dir in a nested submodule' '
> +	git status >expect.1 &&
> +	git -C sub1/nested rev-parse HEAD >expect.2 &&
> +	git submodule absorbgitdirs &&
> +	test -f sub1/.git &&
> +	test -f sub1/nested/.git &&
> +	test -d .git/modules/sub1/modules/nested &&
> +	git status >actual.1 &&
> +	git -C sub1/nested rev-parse HEAD >actual.2 &&
> +	test_cmp expect.1 actual.1 &&
> +	test_cmp expect.2 actual.2
> +'
> +
>  test_expect_success 'setup a gitlink with missing .gitmodules entry' '
>  	git init sub2 &&
>  	test_commit -C sub2 first &&
> -- 
> 2.11.0.486.g67830dbe1c


Aside from my one question the rest of this looks good to me.

-- 
Brandon Williams
