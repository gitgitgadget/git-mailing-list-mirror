Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A4C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0919820725
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 09:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLPJur (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:50:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36277 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLPJur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 04:50:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so6424328wru.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 01:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZBegw9ht/FYZeSa368BZlpgFtYuIYAYQCJH5XfgQHQ=;
        b=ukQOZ2XaKas7YMb2KSEB4gsiff3c4wFcFSZCCs9TvkcPopti4Iy1BJUVI1nQwF2A2L
         5xkcXi/WuEBQQTuRk63H/oU4qug2aDEL5LQsqJwcjPZ0MlEOli3Z9CtMk7JkbqRh36FR
         oF9XID/F7KSb9vdGCOp2MNVMULtrEPp/JnoFtaL9f2CdkBUBiREKB3fwn1IizWRIcc5l
         wvA4tqlvZWJBJGN5wg9NTd4+7BRRlwa7rrPJAWQIniIF2qhw1CkR4nXUJwF/5M69GLdx
         kXv3sE4RK6JhyBDkItaTwTosnBDbejOgSBsYDd9t5u6Gt01COgk52t6Lqhpz0llP2rej
         e9Vg==
X-Gm-Message-State: APjAAAXiU0RS4LDikEsq1JbLXn+0wkwrBvvAs26JaJIxuSNdEjiEJjz7
        sSZcjo2P1H2R5uAaTYSC/UcDO/jjynlSv6CnzGiOJ78A5Lw=
X-Google-Smtp-Source: APXvYqxxW0kwRQkdS7dZdZAIuoSc1xlIoMokL8YD/XLaSFGLxuxEZCkF8ULRfutvYhpyv6Ta00nHMovUijQkn/m14Yo=
X-Received: by 2002:adf:f789:: with SMTP id q9mr29848335wrp.103.1576489844091;
 Mon, 16 Dec 2019 01:50:44 -0800 (PST)
MIME-Version: 1.0
References: <CA+PLxnUR2skor9CGfDKfEEm8XTmoHwM2cDf5Kpgt-ppo=4zhbQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1912152209020.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1912152209020.46@tvgsbejvaqbjf.bet>
From:   Mikael Simonsson <m@mikaelsimonsson.com>
Date:   Mon, 16 Dec 2019 09:50:33 +0000
Message-ID: <CA+PLxnWLWckpZdjy8XQLbO0EVJ1khiyUYi1T=Mcy_rBkvbLpZA@mail.gmail.com>
Subject: Re: Bug? git commit fileA tries to delete fileB and other oddities
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I will try to recreate the problem with a new repository.

So far I think I've narrowed it down to a bug introduced in git 2.20.0.

Not buggy:
1.9.5
2.7.1
2.11.0
2.15.0
2.18.0
2.19.0
2.19.2
2.19.3

Buggy:
2.20.0
2.21.1
2.23.0 (Mac)
2.24.0
2.24.1

The buggy versions all try to delete fileX when running "git commit fileA":

% git commit fileA

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#       deleted:    fileX
#       modified:   fileA
#
# Changes not staged for commit:


Kind regards,
Mikael


On Sun, Dec 15, 2019 at 9:10 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Mikael,
>
> On Sat, 14 Dec 2019, Mikael Simonsson wrote:
>
> > I have the following problems with a local repository:
> >
> > * git commit fileA tries to delete fileX (fileX still exists).
> >
> > * git restore --staged fileX doesn't work, the file remains staged.
> >
> > * A commit from a few days back deleted 2 random files that I haven't
> > touched or staged in months and pulled in staged changes I didn't ask
> > for.
> >
> > git version: 2.24.0 and 2.24.1 (OS: FreeBSD 12)
> >
> > How can this happen? The repository has a local remote (on the same
> > filesystem) that is pushed to only. I tarred the project and copied it
> > to a Mac with git 2.23.0 and the problem persists.
>
> It would be good if you could come up with a minimal list of commands to
> recreate that problem. That way, we can turn it into a regression test and
> fix the problem.
>
> Ciao,
> Johannes
>
> >
> > For example (I've only changed the filenames):
> >
> > % git status
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > Changes to be committed:
> >   (use "git restore --staged <file>..." to unstage)
> >         modified:   fileA
> >         modified:   fileB
> >         modified:   fileC
> >
> > Changes not staged for commit:
> >   (use "git add/rm <file>..." to update what will be committed)
> >   (use "git restore <file>..." to discard changes in working directory)
> >         ...
> >
> >
> > % git commit fileA
> >
> > # Please enter the commit message for your changes. Lines starting
> > # with '#' will be ignored, and an empty message aborts the commit.
> > #
> > # On branch master
> > # Your branch is up to date with 'origin/master'.
> > #
> > # Changes to be committed:
> > #       deleted:    fileX
> > #       modified:   fileA
> > #
> > # Changes not staged for commit:
> >
> >
> > % git stash
> > Saved working directory and index state WIP on master: 488e7081 ...
> >
> >
> > % git status
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > Changes to be committed:
> >   (use "git restore --staged <file>..." to unstage)
> >         deleted:    fileX
> >
> > Untracked files:
> >
> >
> > % git restore --staged fileX
> >
> >
> > % git status
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > Changes to be committed:
> >   (use "git restore --staged <file>..." to unstage)
> >         deleted:    fileX
> >
> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> >
> >
> > Thanks,
> > Mikael
> >
