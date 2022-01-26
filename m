Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824DC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiAZRlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiAZRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 12:41:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1751BC061756
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:41:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso559764ybg.15
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 09:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=11iAl32xss9rzRTqG6X32iDYf9aZQRTnunDPDQ/xBls=;
        b=ldWgFyqFRkmQXfoELQstk/vxJswwgC3KRqrOP9oT3RhBqjsgZin7QpJgskdqU2L7xH
         8G8Le60X12MEDEBChLm40RUDkVIVa5WAzZLLr7/RZZh9iPI8/7kNM1ySfpdrdi30o58U
         +UBKoH+RDi6HzWp0HcCa5PIPthIBaqHtMQQb/0qmHmgSfX7pZ3oqElJ/0I+2Zn0H2bI+
         Fj0BD7KP8xKLzbb/KVrc9wUrW9UZ7TNrRIy6EJX3m3BYBfH9BWYfkIKDJOc5ibg4Rbqo
         Z8ZirsKqsUGVZdCvl6xE9xzw/Gkmg/Z5JV3Wj+A9DcJxiwqdRZZjdHFGBKBdchx3/fQM
         Hsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=11iAl32xss9rzRTqG6X32iDYf9aZQRTnunDPDQ/xBls=;
        b=Ep5qTGg2x/FuH3mUZXY6BiCkGPjh3YJEzQd40G6V1dSUbOiz0yDikUeBBV80MO5TpE
         6yd7N6gnsuEOFSshsVWSlWI2fbQVUyiBMxi7OCdoUTWscUGp2M33Y+be9kVuUgHX2jy8
         1W9MIEnx1xhtGkTDYi0F75ZLkQM69n5PYQ0cjWcac/fTeWEpLkyUEkzkQgzhSdqxch4l
         cgoq0khaqMrzBKn+Igs2+h13glRIfroSFM8g4YjIPzbTuwSACoSSTHh/X5P7UDoKPUeG
         nuTzOBGQS/4r0vo2BwWElrMxjS962KwDz8srORnd+FywC6G+SyaDH+9MTWjOFdlu/IlG
         AJ0A==
X-Gm-Message-State: AOAM5336kz3joTa7Lu4aIEvHrQKeSD+t8AlnEwCMi6pWn/6cFw7l0poh
        NqDHUZPpLF3CPI04o61vpWursZcE0/pkTQ==
X-Google-Smtp-Source: ABdhPJzFRD0h0BpS2VIpiUD+q2i6zUq4ONk2ncvbOmMC/YFzcfCkHiXCQANC1F/BkYhKhFcI/+4ax7KIwfZBEw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:83c3:: with SMTP id
 v3mr41095330ybm.141.1643218871285; Wed, 26 Jan 2022 09:41:11 -0800 (PST)
Date:   Wed, 26 Jan 2022 09:41:09 -0800
In-Reply-To: <pull.1205.git.git.1643161426138.gitgitgadget@gmail.com>
Message-Id: <kl6l35la1jka.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1205.git.git.1643161426138.gitgitgadget@gmail.com>
Subject: Re: [PATCH] sequencer, stash: fix running from worktree subdir
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> In commits bc3ae46b42 ("rebase: do not attempt to remove
> startup_info->original_cwd", 2021-12-09) and 0fce211ccc ("stash: do not
> attempt to remove startup_info->original_cwd", 2021-12-09), we wanted to
> allow the subprocess to know which directory the parent process was
> running from, so that the subprocess could protect it.  However...
>
> When run from a non-main worktree, setup_git_directory() will note
> that the discovered git directory
> (/PATH/TO/.git/worktree/non-main-worktree) does not match
> DEFAULT_GIT_DIR_ENVIRONMENT (see setup_discovered_git_dir()), and
> decide to set GIT_DIR in the environment.  This matters because...
>
> Whenever git is run with the GIT_DIR environment variable set, and
> GIT_WORK_TREE not set, it presumes that '.' is the working tree.  So...
>
> This combination results in the subcommand being very confused about
> the working tree.  Fix it by also setting the GIT_WORK_TREE environment
> variable along with setting cmd.dir.
>
> A possibly more involved fix we could consider for later would be to
> make setup.c set GIT_WORK_TREE whenever (a) it discovers both the git
> directory and the working tree and (b) it decides to set GIT_DIR in the
> environment.  I did not attempt that here as such would be too big of a
> change for a 2.35.1 release.

As the commit message explains, GIT_DIR and GIT_WORK_TREE are closely
linked, and this interaction is subtle enough that we'd want to guard
against it instead of policing it manually. So, yes, setting them
together makes a lot of sense.

>  builtin/stash.c   |  6 +++++-
>  sequencer.c       |  5 ++++-
>  t/t3400-rebase.sh | 21 +++++++++++++++++++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1ef2017c595..86cd0b456e7 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1539,8 +1539,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  
>  			cp.git_cmd = 1;
> -			if (startup_info->original_cwd)
> +			if (startup_info->original_cwd) {
>  				cp.dir = startup_info->original_cwd;
> +				strvec_pushf(&cp.env_array, "%s=%s",
> +					     GIT_WORK_TREE_ENVIRONMENT,
> +					     the_repository->worktree);
> +			}
>  			strvec_pushl(&cp.args, "clean", "--force",
>  				     "--quiet", "-d", ":/", NULL);
>  			if (include_untracked == INCLUDE_ALL_FILES)
> diff --git a/sequencer.c b/sequencer.c
> index 6abd72160cc..5213d16e971 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4223,8 +4223,11 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>  
>  	cmd.git_cmd = 1;
>  
> -	if (startup_info->original_cwd)
> +	if (startup_info->original_cwd) {
>  		cmd.dir = startup_info->original_cwd;
> +		strvec_pushf(&cmd.env_array, "%s=%s",
> +			     GIT_WORK_TREE_ENVIRONMENT, r->worktree);
> +	}
>  	strvec_push(&cmd.args, "checkout");
>  	strvec_push(&cmd.args, commit);
>  	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 23dbd3c82ed..71b1735e1dd 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -416,4 +416,25 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
>  	mv actual_logs .git/logs
>  '
>  
> +test_expect_success 'rebase when inside worktree subdirectory' '
> +	git init main-wt &&
> +	(
> +		cd main-wt &&
> +		git commit --allow-empty -m "initial" &&
> +		mkdir -p foo/bar &&
> +		test_commit foo/bar/baz &&
> +		mkdir -p a/b &&
> +		test_commit a/b/c &&
> +		# create another branch for our other worktree
> +		git branch other &&
> +		git worktree add ../other-wt other &&
> +		cd ../other-wt &&
> +		# create and cd into a subdirectory
> +		mkdir -p random/dir &&
> +		cd random/dir &&
> +		# now do the rebase
> +		git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
> +	)
> +'
> +
>  test_done

Looks good :)

Reviewed-by: Glen Choo <chooglen@google.com>
