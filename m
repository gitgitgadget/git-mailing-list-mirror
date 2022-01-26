Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2FCC5AC75
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiAZANG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiAZAMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:12:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E61C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:12:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m11so66147203edi.13
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQ5KnMdbzGPOajrU8V8QvwbVGIGzma5DOx6BZv5cZQo=;
        b=X4t2xasB47AxUq44irkrxWsBd70bMBExB6svC0XAVCGielhIAOAkusDrb2HonsNCop
         IyegeDWSjmR2vgGF2CjQ8rRHFBZbIt8bW+YVdp0pxibQxeagKc4pGxuMKeSY5iDTCZXJ
         SPH+MFvBhwNImvJaYhN7MrLCndjbWdqRluSkB9cMU0MD1BxkxYacjNcoMc/A1L1YZFPZ
         OGvYDxeZUjpSTkhoC7XJTiNwxRRqXeohvqjaVv+ccZPPObDJ+2PvND+aVIX/0QHaEtGp
         Qm8orIkE+oNh1jrZZusVwkR8BVsgzubFgvzCL4qzyVk99retuete+XPClzs/7666bF5H
         H6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQ5KnMdbzGPOajrU8V8QvwbVGIGzma5DOx6BZv5cZQo=;
        b=A6OawawdqefMJMgZx22R7njB4tCQ9whvmEE06+rJ+U5dBowWjYDBrJVPcsUaCVJAfF
         o2QLTc7sMR9PZrcjOzUbI0fKb/0iHcdd1sjTH0Dfn6TdNfDGuQwliy3bhbycNS0wg5vQ
         jKF9Pfk4rxRe1N7oKLAFuFHR4S666mLSVC05iFIwIYKy6nlF27+G47H/dIMHcTpTjf7+
         iRfAyXgY5DzFmzguAfya/GrmfpxDZ5N5Dw6MaID0XLi9zXTxu7DXBDZa0icv09J5EfRK
         GFMK7iNjJEGunPGQYaPPi7Ob6VW+0/tUZpr/6Z+C8jjjmGyNsqBZxPmn4sNQttDsJ9d1
         eWuQ==
X-Gm-Message-State: AOAM532OAq4j0+zuFM9x+ThX0I0AS3yRZ/3mnXlR78Cef+gAUlr/FayP
        bHHir0A6wVqMAcF+Mxa0Yy2gmhxFHMzWgrg+gItEvLWjkWw=
X-Google-Smtp-Source: ABdhPJxfWsUIq5Hr/yWm1tjVG6sq8iGohGyEMmp9MjU2x1dxb1PLnr8w97tac7ig2KKQjUewqJL5YtrpiJRAzKiVBXY=
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr6903148edd.359.1643155970938;
 Tue, 25 Jan 2022 16:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20220125233612.46831-1-chooglen@google.com>
In-Reply-To: <20220125233612.46831-1-chooglen@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 16:12:39 -0800
Message-ID: <CABPp-BGkpjD=WFSFSY9g85MAZ2JUh+UCfi6NThevZ4RxZUxtVw@mail.gmail.com>
Subject: Re: [PATCH] sequencer.c: set GIT_WORK_TREE in run_git_checkout
To:     Glen Choo <chooglen@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like you beat me to sending out a patch.

On Tue, Jan 25, 2022 at 3:36 PM Glen Choo <chooglen@google.com> wrote:
>
> When rebasing in a subdirectory of a worktree, Git fails due to a dirty
> worktree:
>
>   error: The following untracked working tree files would be overwritten
> by merge:
>           a/b/c
>   Please move or remove them before you merge.
>
> This occurs because "git rebase" invokes a "git checkout" without
> propagating the GIT_WORK_TREE environment variable, causing the worktree
> to be assumed to be ".". This was not an issue until bc3ae46b42 (rebase:
> do not attempt to remove startup_info->original_cwd, 2021-12-09), when
> the .dir of the "git checkout" child process was changed such that it no
> longer runs at the root of the worktree.
>
> Propagate GIT_WORK_TREE to the "git checkout" child process and test
> that rebase in a subdirectory of a worktree succeeds.

This is correct, but leaves the reader wondering why the failure to
set GIT_WORK_TREE fails when in a non-primary worktree, but does not
fail in the primary working tree.  Here's how I described it in the
patch I was about to send to the list:

"""
In commit bc3ae46 ("rebase: do not attempt to remove
startup_info->original_cwd", 2021-12-09), we wanted to allow the
checkout subprocess to know which directory the parent process was
running from, so that the subprocess could protect it.  However...

When run from a non-main worktree, setup_git_directory() will note
that the discovered git directory
(/PATH/TO/.git/worktree/non-main-worktree) does not match
DEFAULT_GIT_DIR_ENVIRONMENT (see setup_discovered_git_dir()), and
decide to set GIT_DIR in the environment.  This matters because...

Whenever git is run with the GIT_DIR environment variable set, and
GIT_WORK_TREE not set, it presumes that '.' is the working tree.  So...

This combination results in rebase failing when run from a subdirectory
of a non-main worktree.  Fix it by also setting the GIT_WORK_TREE
environment variable along with setting cmd.dir.

A possibly more involved fix we could consider for later would be to
make setup.c set GIT_WORK_TREE whenever (a) it discovers both the git
directory and the working tree and (b) it decides to set GIT_DIR in the
environment.  I did not attempt that here as such would be too big of a
change for a 2.35.1 release.
"""

(Another fix would also be making sequencer stop forking a "git
checkout" subprocess; it should be able to call a library function,
and then quit dropping and re-reading the index.  But that's also a
much bigger change...)

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> Here is a fix for the bug I found in [1]. I didn't look through the rest
> of the "preserve cwd" thread for other possible bugs pertaining to
> worktrees, but I didn't find any during a cursory glance at sequencer.c.

We'll need the same fix for stash due to 0fce211ccc ("stash: do not
attempt to remove startup_info->original_cwd", 2021-12-09) -- in that
case, though, it's calling git-clean rather than git-checkout.  But
the same idea.

> I'm also not sure if this is the idiomatic way to do it since, I assume,
> we'd always want to propagate GIT_WORK_TREE, but this is identical to
> how do_exec() sets GIT_WORK_TREE in the same file (perhaps this is
> something that should be refactored).

I'd rather only set GIT_WORK_TREE if something is also setting
GIT_DIR, but I don't think it hurts to set it in all cases.

> [1] https://lore.kernel.org/git/kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com
>
>  sequencer.c       |  2 ++
>  t/t3400-rebase.sh | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 83f257e7fa..e193dcf846 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4233,6 +4233,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>         strvec_push(&cmd.args, "checkout");
>         strvec_push(&cmd.args, commit);
>         strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> +       strvec_pushf(&cmd.env_array, "GIT_WORK_TREE=%s",
> +                    absolute_path(get_git_work_tree()));

struct repository *r already contains the path to the worktree in
r->worktree; I think it'd be better to use it.

>         if (opts->verbose)
>                 ret = run_command(&cmd);
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 23dbd3c82e..8b8b66538b 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -416,4 +416,33 @@ test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink'
>         mv actual_logs .git/logs
>  '
>
> +test_expect_success 'rebase when inside worktree subdirectory' '
> +       git init main-wt &&
> +       (
> +               cd main-wt &&
> +               git commit --allow-empty -m "initial" &&
> +               # create commit with foo/bar/baz
> +               mkdir -p foo/bar &&
> +               touch foo/bar/baz &&
> +               git add foo/bar/baz &&
> +               git commit -m "add foo/bar/baz" &&
> +               # create commit with a/b/c
> +               mkdir -p a/b &&
> +               touch a/b/c &&
> +               git add a/b/c &&
> +               git commit -m "add a/b/c" &&
> +               # create another branch for our other worktree
> +               git branch other &&
> +               git worktree add ../other-wt other &&
> +               (
> +                       cd ../other-wt &&
> +                       mkdir -p random/dir &&
> +                       (
> +                               cd random/dir &&
> +                               git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
> +                       )
> +               )
> +       )
> +'

Nice testcase.  You would have seen potentially even more confusing
results had some of these commits merely modified files rather than
introducing totally new files.
