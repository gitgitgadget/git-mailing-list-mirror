Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D44C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhKWRvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhKWRvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:51:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAACC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:48:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so95528923eda.12
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qQM0M1yn1z90raApNqVzV2RrWbEqvgPpDBuaAdFrK8=;
        b=m30ByfWUeBalTU57M+EeiYXPzuAL7FdJan8PcFY4nWdC5iHm7C3Z1N3qwxfTVk3kyt
         r6FowZMy7zAsRG8VPsogsDi9tSlkrOxw8Q/kOn68kCM0ct61zlqgFGLfM1tTj+dMvtKZ
         oVf4f8utnzvBgy6UnGuav6zGl7NSFNzve/QsZCNvvhivXlc0Rs3mFHhjH9UmqMAhYZLz
         NxlU6FGD+T3jvCU3fv/ZI34Xz3roRTx6cVg9TPQgPKlx1caNcvjvrXZW+j6HkhYsNLcA
         sugwGCoMQA26/UbBb8AGIvdqLzXAd9TrkyFT6i3v5zQ/PfgayzQDjYplsE4x0VQxzylr
         NesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qQM0M1yn1z90raApNqVzV2RrWbEqvgPpDBuaAdFrK8=;
        b=tohrus3omb8CrOaiQ7HEeADoh1gT6lt3kIm8lqsUZUaY7KcJT5sVQmfukvmSIOotCE
         eA1pr2AokLAZfZcjZ6GI3nGkAlbx8wGeczY4bTpxmgAqVlIsjO9q0sf4vtiPMr4QlM9z
         5g9pC/gCFPyxiKCgrf79+C3wsHWPy+GvFV9Ky0c/xqgADG3D5WbfAZT//C6Cv1aATSHr
         n7tEOLucKk3uCR+qkTZzZB7yeLCDh4M7kV2JLk48zWfuS7f3vM5cAn22LRmlevbXhImR
         hgkhJOCtQthgZcPUvcI0PK5MtG3bdDL9PEVEEH6lSMePsw3zrobdzjX0U3I3TSOMVbgq
         OvUg==
X-Gm-Message-State: AOAM5305+w7xupRH/ehOZ0N4iefbRSmMbcR1IG7OlRIkBDcAfrannbg8
        cee87+0cD7leijzs4SB+cKa2nbkClx1NoOaS2lnKO6tcJ98=
X-Google-Smtp-Source: ABdhPJwjBlLEQQU3/hKhQSnft7AA/mb2UPH6hRW4rrBhykldY1j+9WSm+Vdl1c1jO3KYAQ7Y4cdBh5qsJKlNMHNWovM=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr12023935edv.62.1637689694195;
 Tue, 23 Nov 2021 09:48:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1134.git.git.1636738973089.gitgitgadget@gmail.com> <20211114202123.b2zzcso4ne7hwjvi@gmail.com>
In-Reply-To: <20211114202123.b2zzcso4ne7hwjvi@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 09:48:03 -0800
Message-ID: <CABPp-BHUQQiGxfY+spGT3CShP4aaETwYJcFgknPBQ4XhBwKQ2A@mail.gmail.com>
Subject: Re: [PATCH] sequencer: fix environment that 'exec' commands run under
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

// Resending this email from 8 days ago; Dscho pointed that I accidentally
// responded to the GitHub PR email instead of the original email, and
// while Johannes already said he likes my V2, perhaps there are other
// comments here that benefit other current or future reviewers

Hi Johannes,

Thanks for looking over the patch and commit message closely; very cool.

On Sun, Nov 14, 2021 at 12:21 PM Johannes Altmanninger
<aclopte@gmail.com> wrote:
>
> On Fri, Nov 12, 2021 at 05:42:52PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commands executed from `git rebase --exec` can give different behavior
> > from within that environment than they would outside of it, due to the
> > fact that sequencer.c exports both GIT_DIR and GIT_WORK_TREE.  For
> > example, if the relevant script calls something like
> >
> >   git -C ../otherdir log --format=%H --no-walk
> >
> > the user may be surprised to find that the command above does not show a
> > commit hash from ../otherdir, because $GIT_DIR prevents automatic gitdir
> > detection and makes the -C option useless.
>
> Yep. I've had a case where "git rebase -x 'make test'" would fail because
> "make test" tries to run some Git commands in a temporary repo.  The workaround
> was to unset all GIT_* environment variables, just like t/test-lib.sh does.
>
> I had the same problem when testing shell completion because git prepends
> $(git --exec-path) to $PATH.  I don't see a good reason why "git rebase -x
> cmd" passes a modified $PATH (and $GIT_EXEC_PATH) to cmd. The user is back in
> control, so I'd expect the same environment as for the parent rebase process.
>
> AFAICT, the main purpose of changing $PATH is to ease (cross-language)
> implementation, I don't think the user is meant to notice.
> Of course, exporting GIT_EXEC_PATH is desirable for some commands like gc
> that delegate to a bunch of git processes without user interaction, to make
> sure all children are from the same build. c90d565a46 (Propagate --exec-path
> setting to external commands via GIT_EXEC_PATH, 2009-03-21). But
> I don't think the same applies for rebase -x.

Well, rebase does actually delegate to other git processes -- git
commit (in some cases), git stash (if --autostash is specified), git
merge (when a non-default, non-built-in strategy is selected), running
the post-rewrite hook (if it exists), and indirectly through git
commit all the various hooks it might call, and when calling git-stash
the huge pile of subcommands it invokes.

Some of those should definitely be replaced with library calls instead
of forking a subprocess.  And I'm sure the PATH/EXEC_PATH could be
made specific to the places that really need it, but it's so much
easier to just make one global replacement and it avoids people
forgetting to do so before calling subcommands that then might run the
wrong git version in a different setup.  So, I'm a bit conflicted
about fixing PATH/EXEC_PATH right away.  Perhaps if we just modified
those back to their original value just the for --exec'd command?

That probably deserves a series all of its own, but might be
interesting for someone else to look at.

> > This is a regression in behavior from the original legacy
> > implemented-in-shell rebase.  It is perhaps rare for it to cause
> > problems in practice, especially since most small problems that were
> > caused by this area of bugs has been fixed-up in the past in a way that
> > masked the particular bug observed without fixing the real underlying
> > problem.
>
> Really interesting that we added multiple workarounds, when we just needed
> to stop polluting the environment.  The fact that our test suite
> unsets most GIT_* variables also masks potential problems.
>
> >
> > How we arrived at the current situation is perhaps merited.  The setting
>
> This sounds weirdly penitent if read the wrong way. I guess
> "An explanation how we arrived ... "?

Indeed, thanks for catching.

> > of GIT_DIR and GIT_WORK_TREE done by sequencer.c arose from a sequence
> > of historical accidents:
> >
> > * When rebase was implemented as a shell command, it would call
> >   git-sh-setup, which among other things would set GIT_DIR -- but not
> >   export it.  This meant that when rebase --exec commands were run via
> >       /bin/sh -c "$COMMAND"
> >   they would not inherit the GIT_DIR setting.  The fact that GIT_DIR
> >   was not set in the run $COMMAND is the behavior we'd like to restore.
> >
> > * When the rebase--helper builtin was introduced to allow incrementally
> >   replacing shell with C code, we were in an implementation that was
>
> More correct to say "we were in an (implementation) state" or better:
> "we had an implementation"?

Yes, that'd be better.

> >   half shell, half C.  In particular, commit 18633e1a22 ("rebase -i: use
> >   the rebase--helper builtin", 2017-02-09) added calls to
> >       exec git rebase--helper ...
>
> Ok I guess this was a good reason for adding the exec-path to the environment
> of exec steps.
>
> >   which caused rebase--helper to inherit the GIT_DIR environment
> >   variable from the shell.  git's setup would change the environment
> >   variable from an absolute path to a relative one (".git"), but would
> >   leave it set.  This meant that when rebase --exec commands were run
> >   via
> >       run_command_v_opt(...)
> >   they would inherit the GIT_DIR setting.
> >
> > * In commit 09d7b6c6fa ("sequencer: pass absolute GIT_DIR to exec
> >   commands", 2017-10-31), it was noted that the GIT_DIR caused problems
> >   with some commands; e.g.
> >       git rebase --exec 'cd subdir && git describe' ...
> >   would have GIT_DIR=.git which was invalid due to the change to the
> >   subdirectory.  Instead of questioning why GIT_DIR was set, that commit
> >   instead made sequencer change GIT_DIR to be an absolute path and
> >   explicitly export it via
> >       argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> >       run_command_v_opt_cd_env(..., child_env.argv)
> >
> > * In commit ab5e67d751 ("sequencer: pass absolute GIT_WORK_TREE to exec
> >   commands", 2018-07-14), it was noted that when GIT_DIR is set but
> >   GIT_WORK_TREE is not, that we do not discover GIT_WORK_TREE but just
> >   assume it is '.'.  That is incorrect if trying to run commands from a
> >   subdirectory.  However, rather than question why GIT_DIR was set, that
> >   commit instead also added GIT_WORK_TREE to the list of things to
> >   export.
> >
> > Each of the above problems would have been fixed automatically when
> > git-rebase become a full builtin, had it not been for the fact that
>
> s/become/became/

Yep; will fix.

> > sequencer.c started exporting GIT_DIR and GIT_WORK_TREE in the interim.
> > Stop exporting them now.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     sequencer: fix environment that 'exec' commands run under
>
> Maybe: sequencer: do not export GIT_DIR and GIT_WORK_TREE to exec

Works for me.

> (assuming that $PATH also needs fixing)

I'll leave that to someone else.  :-)

> >
> >     I'm not sure if the added regression tests make sense
>
> They are simple and correct.
> We still pass on values from --git-dir= and GIT_DIR=. git.
> Those are /probably/ right.
>
> >     or if t3409 is the best place to put them (taking over a recently
> >     removed t3409 that was used for the deprecated preserve merges option).
>
> Looks like there is no t/t34*-rebase-exec.sh yet. Most tests of --exec are
> in t/t3404-rebase-interactive.sh, but we don't need the interactive bit here.

Yeah, I didn't want to add to t3404, because (a) there's a comment at
the top of the file saying all files are about a certain type of test
setup that just isn't applicable to my new test, (b) t3404 is already
one of the slowest tests.

Also, I considered naming it rebase-exec.sh, but (1) there are more
tests of that in t3404 already and (2) I thought folks might have
reason to add additional environment related tests and this would be a
good place for all those tests.  The fact that you brought up
additional environment variables suggests that might indeed be a good
track.

> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1134%2Fnewren%2Ffix-rebase-exec-environ-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1134/newren/fix-rebase-exec-environ-v1
> > Pull-Request: https://github.com/git/git/pull/1134
> >
> >  sequencer.c               |  9 +--------
> >  t/t3409-rebase-environ.sh | 23 +++++++++++++++++++++++
> >  2 files changed, 24 insertions(+), 8 deletions(-)
> >  create mode 100755 t/t3409-rebase-environ.sh
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index ea96837cde3..9afdbe3e3d1 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3495,17 +3495,12 @@ static int error_failed_squash(struct repository *r,
> >
> >  static int do_exec(struct repository *r, const char *command_line)
> >  {
> > -     struct strvec child_env = STRVEC_INIT;
> >       const char *child_argv[] = { NULL, NULL };
> >       int dirty, status;
> >
> >       fprintf(stderr, _("Executing: %s\n"), command_line);
> >       child_argv[0] = command_line;
> > -     strvec_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
> > -     strvec_pushf(&child_env, "GIT_WORK_TREE=%s",
> > -                  absolute_path(get_git_work_tree()));
> > -     status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
> > -                                       child_env.v);
> > +     status = run_command_v_opt(child_argv, RUN_USING_SHELL);
> >
> >       /* force re-reading of the cache */
> >       if (discard_index(r->index) < 0 || repo_read_index(r) < 0)
> > @@ -3535,8 +3530,6 @@ static int do_exec(struct repository *r, const char *command_line)
> >               status = 1;
> >       }
> >
> > -     strvec_clear(&child_env);
> > -
> >       return status;
> >  }
> >
> > diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
> > new file mode 100755
> > index 00000000000..83ffb39d9ff
> > --- /dev/null
> > +++ b/t/t3409-rebase-environ.sh
> > @@ -0,0 +1,23 @@
> > +#!/bin/sh
> > +
> > +test_description='git rebase interactive environment'
>
> maybe test_description='git rebase --exec environment'

Yep, I need to remove 'interactive' here and it probably makes sense
to mention --exec unless someone adds a test to it for environment
variables with some other part of rebase.

> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +     test_commit one &&
> > +     test_commit two &&
> > +     test_commit three
> > +'
> > +
> > +test_expect_success 'rebase --exec does not muck with GIT_DIR' '
> > +     git rebase --exec "printf %s \$GIT_DIR >environ" HEAD~1 &&
> > +     test_must_be_empty environ
> > +'
> > +
> > +test_expect_success 'rebase --exec does not muck with GIT_WORK_TREE' '
> > +     git rebase --exec "printf %s \$GIT_WORK_TREE >environ" HEAD~1 &&
> > +     test_must_be_empty environ
> > +'
>
> I guess we could add a test for existing GIT_DIR in the environment, even
> if it's not affected
>
>         test_expect_success 'already exported GIT_DIR is passed on to rebase --exec commands' '
>                 GIT_DIR=.git GIT_WORK_TREE=. git rebase HEAD~1 --exec \
>                         "printf %s\\\\n \"\$GIT_DIR\" \"\$GIT_WORK_TREE\" >actual" &&
>                 cat >expect <<-EOF &&
>                 .git
>                 .
>                 EOF
>                 test_cmp expect actual &&
>                 cat actual
>         '
>
> (I tried to use non-default values lik ./.git and ./. but the weird thing
> is that git canonicalizes the worktree but not the git dir, so meh)

It also changes the current working directory to the specified work
tree, which makes the test start testing stuff other than I was
expecting; the following passes:

test_expect_success 'setup alternate GIT_DIR and GIT_WORK_TREE' '
    git clone . other-copy &&
    git worktree add other-worktree
'

test_expect_success 'already exported GIT_DIR is passed on to rebase
--exec commands' '
    test_when_finished "rm other-worktree/actual" &&

    GIT_DIR=other-copy/.git GIT_WORK_TREE=other-worktree \
        git rebase HEAD~1 --exec \
        "printf %s\\\\n \"\$GIT_DIR\" \"\$GIT_WORK_TREE\" \"\$PWD\" >actual" &&

    cat >expect <<-EOF &&
    $(cd other-copy && pwd -P)/.git
    .
    $(cd other-worktree && pwd -P)
    EOF

    test_cmp expect other-worktree/actual
'

I don't know if that's correct or buggy, but it's starting to stray
from what I was intending to test so I might leave it out.

> I also wasn't sure about the behavior of --git-dir= Should it be the same as GIT_DIR=?
> I think it's also conceivable that --git-dir= does *not* cause GIT_DIR to
> be exported to exec commands, though that might break existing
> scripts. Something like
>
>         git --work-tree=../other-worktree --git-dir=../other-worktree/.git \
>                 rebase --exec "make generate-documentation && git commit -a --amend --no-edit"
>
> (needless to say that in this case "git -C ../other-worktree" is probably
> what the user wants)

It sets the variables; the following passes (which differs from above
only in using --git-dir and --work-tree rather than GIT_DIR and
GIT_WORK_TREE):

test_expect_success 'specialized --git-dir/--work-tree and rebase
--exec commands' '
    test_when_finished "rm other-worktree/actual" &&

    git --git-dir=other-copy/.git --work-tree=other-worktree \
        rebase HEAD~1 --exec \
        "printf %s\\\n \"\$GIT_DIR\" \"\$GIT_WORK_TREE\" \"\$PWD\" >actual" &&

    cat >expect <<-EOF &&
    $(cd other-copy && pwd -P)/.git
    .
    $(cd other-worktree && pwd -P)
    EOF

    test_cmp expect other-worktree/actual
'
