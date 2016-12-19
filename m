Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DE71FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 22:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbcLSWZ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:25:56 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:37115 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbcLSWZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:25:55 -0500
Received: by mail-it0-f50.google.com with SMTP id y23so96196978itc.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 14:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhuYjbidqhcjOp0ARjg5srrA6URFeaM/dAsnjOyWI/4=;
        b=EwYL/dP9P71hdApiZdsVo9Zp8N6OOtC2Q/chUwM7zQzepcxvQGG+TxsWvU3kqaqWBW
         edqwy69H9h981l6aTzZYi1S3rYJcCTLVFZ2xHivNdGcX+sxFateXg5TgSlGGa9JewEEg
         xu93f3oeH/9+DJulu+dxiT+PHxFv46HhNzRxrPQjqGT5566oJISGqpd2d1Iu84F9qlIS
         UR6Jab5XNKqZNl5Pmxuv2/Hj4PKCahjHhQIfTRS+awTNUoEBTqVTn3IHxOV7JGvqFZeK
         YgoJ0G6In2CAzJ9ColjRakydMMp4xqaXZdk6WVBA1Y3ObnMC4fhLoi13IT34xKoHTgot
         Sjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhuYjbidqhcjOp0ARjg5srrA6URFeaM/dAsnjOyWI/4=;
        b=doJc3nfaC07i1Er7w5wUkzJGcBrqtzkaNbuQDdTG/nO17Tv6rqsY2huLsApKovLYQQ
         GBfjZcb1cGSJsle90XbGtzyPBQsV9xSW0Sls3l1qSvt13xuds+0RhmHgTDZZdnY5MIK+
         yTw+7EEfV/eEDOBmulmw4TvEH+6vUunK5a14lZdJK2yqox1VOENb0EXu8huywMHiwaqV
         4PLX9RAjaITvHp3htBTm8D/g3TX/Xm3imnhH0End1U/baUvsiMBtj5HVXcrKqsDzk+Oh
         wQYMyxtccXXUaQEkUgsQ/7Rbg1WTvYVT9SQHXa9QOBUItxY9cxyhW8tHeXpouBIbIQqi
         /VAg==
X-Gm-Message-State: AKaTC01SQIA3sHQq+U4iTLAAOa7DGXYCmms/0UnTHIgzkuJXGTeRfCOm2aWhY3hy6l5de7ik
X-Received: by 10.36.51.21 with SMTP id k21mr18800671itk.110.1482186353834;
        Mon, 19 Dec 2016 14:25:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8043:3f72:e099:d313])
        by smtp.gmail.com with ESMTPSA id f24sm9100831iod.21.2016.12.19.14.25.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 14:25:52 -0800 (PST)
Date:   Mon, 19 Dec 2016 14:25:51 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] dir.c: add retry logic to relocate_gitdir
Message-ID: <20161219222551.GA41080@google.com>
References: <20161219215709.24620-1-sbeller@google.com>
 <20161219215709.24620-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161219215709.24620-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19, Stefan Beller wrote:
> Relocating a git directory consists of 3 steps:
> 1) Move the directory.
> 2) Update the gitlink file.
> 3) Set core.worktree correctly.
> 
> In an ideal world all three steps would be part of one transaction, such
> that either all of them happen correctly or none of them.
> However currently we just execute these three steps sequentially and die
> in case of an error in any of these 3 steps.
> 
> Dying is ok in 1) as the transaction hasn't started and the state is
> recoverable.
> 
> When dying in 2), this is a problem as the repo state is left in an
> inconsistent state, e.g. the git link file of a submodule could be
> empty and hence even the superproject appears to be broken as basic
> commands such as git-status would die as there is it cannot tell the
> state of the submodule.
> So in that case try to undo 1) to be in a less sufferable state.

I now see why an atomic filesystem swap operation would be useful :)

> 
> 3) is less of an issue as experiments with submodules show. When
> core.worktree is unset or set incorrectly, git-status still works
> both in the superproject as well as the working tree of the submodule.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  dir.c       | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  dir.h       |  6 ++--
>  submodule.c |  3 +-
>  3 files changed, 91 insertions(+), 12 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index b2cb23fe88..e4e3f69869 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2749,30 +2749,66 @@ void untracked_cache_add_to_index(struct index_state *istate,
>  	untracked_cache_invalidate_path(istate, path);
>  }
>  
> -static void point_gitlink_file_to(const char *work_tree, const char *git_dir)
> +/*
> + * Just like write_file, we try hard to write the full content to the file.
> + * If there is suspicion the write did not work correctly, make sure the file
> + * is removed again.
> + * Return 0 if the write succeeded, -1 if the file was removed,
> + * -2 if the (partial) file is still there.
> + */
> +static int write_file_or_remove(const char *path, const char *buf, size_t len)
> +{
> +	int retries = 3;
> +	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> +	if (write_in_full(fd, buf, len) != len) {
> +		warning_errno(_("could not write '%s'"), path);
> +		goto err;
> +	}
> +	if (close(fd)) {
> +		warning_errno(_("could not close '%s'"), path);
> +		goto err;
> +	}
> +	return 0;
> +err:
> +	while (retries-- > 0) {
> +		if (file_exists(path))
> +			unlink_or_warn(path);
> +		else
> +			return -1;
> +	}
> +	return -2;
> +}

Any reason why on attempt 2 or 3 this would succeed if it failed on try
1?

> +
> +static int point_gitlink_file_to(const char *work_tree, const char *git_dir)
>  {
>  	struct strbuf file_name = STRBUF_INIT;
>  	struct strbuf rel_path = STRBUF_INIT;
> +	struct strbuf content = STRBUF_INIT;
> +	int ret;
>  
>  	strbuf_addf(&file_name, "%s/.git", work_tree);
> -	write_file(file_name.buf, "gitdir: %s",
> -		   relative_path(git_dir, work_tree, &rel_path));
> +	strbuf_addf(&content, "gitdir: %s",
> +		    relative_path(git_dir, work_tree, &rel_path));
> +	ret = write_file_or_remove(file_name.buf, content.buf, content.len);
>  
>  	strbuf_release(&file_name);
>  	strbuf_release(&rel_path);
> +	return ret;
>  }
>  
> -static void set_core_work_tree_to_connect(const char *work_tree, const char *git_dir)
> +static int set_core_work_tree_to_connect(const char *work_tree, const char *git_dir)
>  {
>  	struct strbuf file_name = STRBUF_INIT;
>  	struct strbuf rel_path = STRBUF_INIT;
> +	int ret;
>  
>  	strbuf_addf(&file_name, "%s/config", git_dir);
> -	git_config_set_in_file(file_name.buf, "core.worktree",
> +	ret = git_config_set_in_file_gently(file_name.buf, "core.worktree",
>  			       relative_path(work_tree, git_dir, &rel_path));
>  
>  	strbuf_release(&file_name);
>  	strbuf_release(&rel_path);
> +	return ret;
>  }
>  
>  /* Update gitfile and core.worktree setting to connect work tree and git dir */
> @@ -2790,12 +2826,54 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  
>  /*
>   * Migrate the git directory of the given path from old_git_dir to new_git_dir.
> + * Return 0 on success and -1 on a minor issue. Die in case the repository is
> + * fatally messed up.
>   */
> -void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
> +int relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
>  {
> +	char *git_dir = xstrdup(real_path(new_git_dir));
> +	char *work_tree = xstrdup(real_path(path));
> +	int c;

I guess in a later patch we could clean up these calls to real_path to
use real_pathdup from bw/realpath-wo-chdir.

> +
>  	if (rename(old_git_dir, new_git_dir) < 0)
> -		die_errno(_("could not migrate git directory from '%s' to '%s'"),
> +		die_errno(_("could not rename git directory from '%s' to '%s'"),
>  			old_git_dir, new_git_dir);
>  
> -	connect_work_tree_and_git_dir(path, new_git_dir);
> +	c = point_gitlink_file_to(work_tree, git_dir);
> +	if (c < 0) {
> +		warning(_("tried to move the git directory from '%s' to '%s'"),
> +			old_git_dir, new_git_dir);
> +		warning(_("problems with creating a .git file in '%s' to point to '%s'"),
> +			work_tree, new_git_dir);
> +		if (c == -1) {
> +			warning(_("try to undo the move"));
> +			if (rename(new_git_dir, old_git_dir) < 0)
> +				die_errno(_("could not rename git directory from '%s' to '%s'"),
> +					new_git_dir, old_git_dir);
> +			return -1;
> +		} else if (c == -2) {
> +			warning(_("The .git file is still there, "
> +				"where the undo operation would move the git "
> +				"directory"));
> +			die(_("failed to undo the git directory relocation"));
> +		}
> +	};
> +
> +	if (set_core_work_tree_to_connect(work_tree, git_dir) < 0) {
> +		/*
> +		 * At this point the git dir was moved and the gitlink file
> +		 * was updated correctly, this leaves the repository in a
> +		 * state that is not totally broken.  Setting the core.worktree
> +		 * correctly would have been the last step to perform a
> +		 * complete git directory relocation, but this is good enough
> +		 * to not die.
> +		 */
> +		warning(_("could not set core.worktree in '%s' to point at '%s'"),
> +			git_dir, work_tree);
> +		return -1;
> +	}
> +
> +	free(work_tree);
> +	free(git_dir);
> +	return 0;
>  }
> diff --git a/dir.h b/dir.h
> index bf23a470af..86f1cf790f 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -336,7 +336,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
>  void add_untracked_cache(struct index_state *istate);
>  void remove_untracked_cache(struct index_state *istate);
>  extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> -extern void relocate_gitdir(const char *path,
> -			    const char *old_git_dir,
> -			    const char *new_git_dir);
> +extern int relocate_gitdir(const char *path,
> +			   const char *old_git_dir,
> +			   const char *new_git_dir);
>  #endif
> diff --git a/submodule.c b/submodule.c
> index 45ccfb7ab4..fa1f44bb5a 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1277,7 +1277,8 @@ static void relocate_single_git_dir_into_superproject(const char *prefix,
>  		prefix ? prefix : "", path,
>  		real_old_git_dir, real_new_git_dir);
>  
> -	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
> +	if (relocate_gitdir(path, real_old_git_dir, real_new_git_dir))
> +		die(_("could not relocate git directory of '%s'"), path);
>  
>  	free(old_git_dir);
>  	free(real_old_git_dir);
> -- 
> 2.11.0.rc2.53.gb7b3fba.dirty
> 

-- 
Brandon Williams
