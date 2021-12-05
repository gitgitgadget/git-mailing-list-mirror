Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A87C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 08:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhLEIsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 03:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLEIsd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 03:48:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15824C061751
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 00:45:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d9so15610194wrw.4
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 00:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JwYDLwnTQB0dbYWWnNmQBfk4xvWlq8/219Igdd7La9s=;
        b=h1CFMVxcb6I5nv6wF2qMKOVrPxZnJsHoWtAIjLgD9RS+XriORk5MEZeIE1ov70xuTU
         zsOR1ReJFTWjK+DaZTdUpENWPRC1Rj4T07u+p+V4t41SmPuznirpUOVLbmBHGJitIiFd
         9qIslwAk4vaXxr9Zx7lE1+LALJSQThFJy3ghAdl93huSYaXYedIjexAOOLtU1n+fgQm1
         cxoMXSFAfr2E2Jp48RBx8O3k25/Fa8VHjrK6WRGOvd+xYjMRMMjm2ARzCMy1M5lm9Gev
         oOGUXj+NzgGM6Tg7SZNIasoXIIzkOoUIDDK7CuH4Df1fQNIHHnrTFD5580wffaL8d40D
         iU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JwYDLwnTQB0dbYWWnNmQBfk4xvWlq8/219Igdd7La9s=;
        b=lbPT+vpK2MXtgk+uln1XXdIrmt4e6G3mcHNRmTPohX2ARGcYzL8ivAs6Ere4mrssts
         NSCwqAra1t0zW+ekUYPwW7zH6V89MHcLxnl1RpSVk1unSwcxLGoj/Z5JExw3L3dtzHfL
         d+x7zaW2KncFj2uzRWSUtXbSh+8J/Y7F8E5hESJ8cAjTlnnvqpLah8KW/+q3jvVGH7LF
         TMg0Wi2g7nM136eJtb2cigLJJnjg2KAQ9kKGJaS0BF0xFdsk/fDXt1U/8GP2xjia0ijs
         qsdBhLIsTwVzwhWllJfQeu/ScMSPzGBgG5tBa5di1xbo7pK7ctpND32NSO1x3NVL9rW+
         pr6A==
X-Gm-Message-State: AOAM530pPIyNnteEhErse3WrkS882ZdPwmJah49AUxtAbH2zcVbrwFgU
        JRQDia/wvyOCIjZZPJPzzUwmdWb/9ro=
X-Google-Smtp-Source: ABdhPJwo4N2tEsy6dQLtR2IZ7NratZCh5yoVAd7f5MYntWPCgiE3fv48+mJlzCXBRQ97LmO4jdWGjw==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr34968541wri.439.1638693905610;
        Sun, 05 Dec 2021 00:45:05 -0800 (PST)
Received: from gmail.com (194-166-87-56.adsl.highway.telekom.at. [194.166.87.56])
        by smtp.gmail.com with ESMTPSA id m14sm10710927wrp.28.2021.12.05.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 00:45:05 -0800 (PST)
Date:   Sun, 5 Dec 2021 09:45:02 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: fix environment that 'exec' commands run under
Message-ID: <20211205084502.6sougq7zsbnhxlht@gmail.com>
References: <pull.1134.git.git.1636738973089.gitgitgadget@gmail.com>
 <20211114202123.b2zzcso4ne7hwjvi@gmail.com>
 <CABPp-BHUQQiGxfY+spGT3CShP4aaETwYJcFgknPBQ4XhBwKQ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHUQQiGxfY+spGT3CShP4aaETwYJcFgknPBQ4XhBwKQ2A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 09:48:03AM -0800, Elijah Newren wrote:
> // Resending this email from 8 days ago; Dscho pointed that I accidentally
> // responded to the GitHub PR email instead of the original email, and
> // while Johannes already said he likes my V2, perhaps there are other
> // comments here that benefit other current or future reviewers
> 
> Hi Johannes,
> 
> Thanks for looking over the patch and commit message closely; very cool.
> 
> On Sun, Nov 14, 2021 at 12:21 PM Johannes Altmanninger
> <aclopte@gmail.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 05:42:52PM +0000, Elijah Newren via GitGitGadget wrote:
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > Commands executed from `git rebase --exec` can give different behavior
> > > from within that environment than they would outside of it, due to the
> > > fact that sequencer.c exports both GIT_DIR and GIT_WORK_TREE.  For
> > > example, if the relevant script calls something like
> > >
> > >   git -C ../otherdir log --format=%H --no-walk
> > >
> > > the user may be surprised to find that the command above does not show a
> > > commit hash from ../otherdir, because $GIT_DIR prevents automatic gitdir
> > > detection and makes the -C option useless.
> >
> > Yep. I've had a case where "git rebase -x 'make test'" would fail because
> > "make test" tries to run some Git commands in a temporary repo.  The workaround
> > was to unset all GIT_* environment variables, just like t/test-lib.sh does.
> >
> > I had the same problem when testing shell completion because git prepends
> > $(git --exec-path) to $PATH.  I don't see a good reason why "git rebase -x
> > cmd" passes a modified $PATH (and $GIT_EXEC_PATH) to cmd. The user is back in
> > control, so I'd expect the same environment as for the parent rebase process.
> >
> > AFAICT, the main purpose of changing $PATH is to ease (cross-language)
> > implementation, I don't think the user is meant to notice.
> > Of course, exporting GIT_EXEC_PATH is desirable for some commands like gc
> > that delegate to a bunch of git processes without user interaction, to make
> > sure all children are from the same build. c90d565a46 (Propagate --exec-path
> > setting to external commands via GIT_EXEC_PATH, 2009-03-21). But
> > I don't think the same applies for rebase -x.
> 
> Well, rebase does actually delegate to other git processes -- git
> commit (in some cases), git stash (if --autostash is specified), git
> merge (when a non-default, non-built-in strategy is selected), running
> the post-rewrite hook (if it exists), and indirectly through git
> commit all the various hooks it might call, and when calling git-stash
> the huge pile of subcommands it invokes.
> 
> Some of those should definitely be replaced with library calls instead
> of forking a subprocess.  And I'm sure the PATH/EXEC_PATH could be
> made specific to the places that really need it, but it's so much
> easier to just make one global replacement and it avoids people
> forgetting to do so before calling subcommands that then might run the
> wrong git version in a different setup.  So, I'm a bit conflicted
> about fixing PATH/EXEC_PATH right away.  Perhaps if we just modified
> those back to their original value just the for --exec'd command?

Yeah that sounds like a good approach, and it seems like a reasonable cleanup.

> That probably deserves a series all of its own, but might be
> interesting for someone else to look at.
> ...
> the following passes:
> 
> test_expect_success 'setup alternate GIT_DIR and GIT_WORK_TREE' '
>     git clone . other-copy &&
>     git worktree add other-worktree
> '
> 
> test_expect_success 'already exported GIT_DIR is passed on to rebase
> --exec commands' '
>     test_when_finished "rm other-worktree/actual" &&
> 
>     GIT_DIR=other-copy/.git GIT_WORK_TREE=other-worktree \
>         git rebase HEAD~1 --exec \
>         "printf %s\\\\n \"\$GIT_DIR\" \"\$GIT_WORK_TREE\" \"\$PWD\" >actual" &&
> 
>     cat >expect <<-EOF &&
>     $(cd other-copy && pwd -P)/.git
>     .
>     $(cd other-worktree && pwd -P)
>     EOF
> 
>     test_cmp expect other-worktree/actual
> '
> 
> I don't know if that's correct or buggy

Me neither.  I feel like the current behavior (exporting GIT_WORK_TREE=.) is
a bit better than dropping GIT_WORK_TREE from the environment of exec runs.

> but it's starting to stray
> from what I was intending to test so I might leave it out.
> 
> > I also wasn't sure about the behavior of --git-dir= Should it be the same as GIT_DIR=?
> > I think it's also conceivable that --git-dir= does *not* cause GIT_DIR to
> > be exported to exec commands, though that might break existing
> > scripts. Something like
> >
> >         git --work-tree=../other-worktree --git-dir=../other-worktree/.git \
> >                 rebase --exec "make generate-documentation && git commit -a --amend --no-edit"
> >
> > (needless to say that in this case "git -C ../other-worktree" is probably
> > what the user wants)
> 
> It sets the variables; the following passes (which differs from above
> only in using --git-dir and --work-tree rather than GIT_DIR and
> GIT_WORK_TREE):

Looking at this again, --git-dir is meant to be able to dominate $GIT_DIR,
so the current behavior where --git-dir exports that variable seems logical.
