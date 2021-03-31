Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD3C43460
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 13:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E6660D07
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 13:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhCaNvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:51:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:58055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhCaNvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 09:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617198678;
        bh=A8Gp3zeR/bQ1qGL+jsNovf7IUr0kaDDEZPmBKsCKj5k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W5kQ95RpW9R1EwkXJ3imo7Qqfj8ctW+hlhS81+GsBM22T6msEDYTbCqxyEmIvRRrD
         1CGUryMfZgINBf0Z5BBV1p6V9jtWyX46/toDvA7FgmAt5GEI50+K1aunepvnt1LH97
         EMeV5lCFSD4FTfUmcPUlZh3yAZcAv+fv4aqGZcVU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.127.121] ([213.196.212.198]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1lGE2508Lf-00QEI8; Wed, 31
 Mar 2021 15:51:18 +0200
Date:   Wed, 31 Mar 2021 15:48:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: unifying sequencer's options persisting, was Re: [PATCH v2] sequencer:
 fix edit handling for cherry-pick and revert messages
In-Reply-To: <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com> <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HnX8E9zxgTYIyvL5xrpU9V8AL4HMsFyO7C3bHvjEeVh9Xko9a7a
 +5s1J14rEEGRf8Y66wmE69j6wvWE9gON9/RksU/YQqbdvRrf8hFUAEzaiGHukIhR/GcMl+u
 P3LcIGbdRFRym26VHdUjB3RJb1ec2M3iRmuvbiwEAAo/dhssNdwOMKmJlvX/uRXn8WSI+WU
 UbpYmtWrm3rEcLbozw5KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rri3aBxRcW4=:xf9HtnnOYb8fKEufVC8a6O
 Hb3y/Xjb+w/QFZRBsaYfWisjbH+NaGaSddLm6WjdghiM4EJtU8vhBMokCXs3pIEu2Zj6x1Y2F
 q8nMsXo0pdNRaqu6kZwPFTXeKBBPbbr+ej+jibV1ejv/aqKs+Co9s/nek3+y+QBELEtpJtCG8
 KyTnbkA9fSXmjdDSfUpfrDJzdj1aQjJaXaNXTyRmlgS6Jbpr3LpMFCPr/33xNhotSz58Haw/i
 3jQefM35xZsbT2nXYXA/qr4zymsHkzIPpttnMnwly3zzuYb0x2mFpQ1pSzFE5x2RwZK0yVb1x
 S5JJBL5gngWa2mXUWPHINFG7RTGoKxMgKkUAQTmL07H/5TufKr7YUbVeHHdwPMSXRf9QHE/Q/
 cW7aIlH1r9+O5N5Rp6p4paeLlZVTOWwLuTD0aJGiffaxFJh19vJCpD7LdaP5bMyN8WJunMolk
 XG/q32pBry36VaLPYFbrVG3ICZ0QkJb5PSdc+ydUe81snwEi/zDWAo4py2nyvYnMaaJbp6vm6
 A6bx9mOApXl+dr82n3381izZzEfgU/fs5Sp/AXRtieVG1vpFkm52KYT7GlQCgLX4rOCE2E0/J
 3ljDZH1myQBfxd/heFHBBdiy3W5yy/wNpyH1wv55wsEsRsiwFpZ4lccLkFdsnkHXhisXq/bY1
 auOzBiiXDtDBsFnJKyJcaHR7zF5UbncsPbZBIvsnE+vu3jLYn2kOzrSqBbFKiJ5Jc4GxSd+9T
 Nlh4UauJwgNSn8X7MVqMxeD84NOAtggeaMmetTDOuIKy37jAF3cXzpgzf7qXJj5A87stWIl5u
 WGvU7XchYrqLoOIoMYXI7ikG+tBb2aSgUCtY3+9gn1JF+7FRX+YIeeZX5RojH/FsXY+ZNf6h8
 m95RoUz6Htp2RwEyucIInBNVXiMZa8OWOZOLKdyY3TV3SMk054cCupPwseyotqXdQl0jZn6Wl
 Mq8z6ToG3mnNrWOj7drv6QthScOy2E4pACxZIxiP756m9oSqDze7YNWCCFDiLVWKr7NIm7O0a
 WhmCNDp4xt644tPW3MspScqOirxiSzmKsE6aVlQZwRPLHEcft6uQ27sysfEOiQOk32e1Ik6Ld
 qJ5N73qAdbhRq9tFucnKYU7bk7aLElXkszUnnkzcT5IL5G/zFcGuuWAzXWkFmJljpVyUy1oOB
 tG4y5pXt4NZWRaeOAfOvIZ7J4XujOf3ARFvv77SEOw6A4/VppJzca0XLlg5JfwbFXP2Xzvbwa
 +WKskqhUHjel72Qu5
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 30 Mar 2021, Elijah Newren wrote:

> On Tue, Mar 30, 2021 at 3:13 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > I'll allow myself one tangent: the subject of the sequencer's Unix
> > shell script heritage seems to come up with an increasing frequency,
> > in particular the awful "let's write out one file per setting"
> > strategy.
> >
> > I would _love_ for `save_opts()` to write a JSON instead (or an INI
> > via the `git_config_*()` family of functions, as is done already by
> > the cherry-pick/revert stuff), now that we no longer have any shell
> > script backend (apart from `--preserve-merges`, but that one is on its
> > way out anyway).
> >
> > The one thing that concerns me with this idea is that I know for a
> > fact that some enterprisey users play games with those files inside
> > `<GIT_DIR>/rebase-merge` that should be considered internal
> > implementation details. Not sure how to deprecate that properly, I
> > don't think we have a sane way to detect whether users rely on these
> > implementation details other than breaking their expectations, which
> > is not really a gentle way to ask them to update their scripts.
>
> Ooh, I'm glad you took this tangent.  May I follow it for a second?
> I'd really, really like this too, for three reasons:
>
> 1) I constantly get confused about the massive duplication and
> difference in control structures and which ones affect which type of
> operations in sequencer.c.  Having them both use an ini-file would
> allow us to remove lots of that duplication.  I'm sure there'll still
> be some rebase-specific or cherry-pick-specific options, but we don't
> need a separate parallel structure for every piece of config.
>
> 2) In my merge-ort optimization work, rebasing 35 commits in linux.git
> across a massive set of 26K upstream renames has dropped rename
> detection time from the top spot.  And it also dropped several other
> things in the merge machinery from their spots as well.  Do you know
> what's the slowest now?  Wasted time from sequencer.c: the unnecessary
> process forking and all the useless disk writing (which I suspect is
> mostly updating the index and working directory but also writing all
> the individual control files under .git/rebase-merge/).  And this
> stuff from sequencer.c is not just barely the slowest part, it's the
> slowest by a wide margin.
>
> 3) I also want to allow cherry-picking or rebasing branches that
> aren't even checked out (assuming no conflicts are triggered;
> otherwise an error can be shown with the user asked to repeat with the
> operation connected to an active working directory).  For such an
> operation, the difference between "cherry-pick" and "rebase" is nearly
> irrelevant so you'd expect the code to be the same; every time I look
> at the code, though, it seems that the control structures are
> separating these two types of operations in more areas than just the
> reading and writing of the config.

Excellent, we're in agreement, then.

The remaining question is: how do we want to go about it? Do we just want
to codify the notion that these are internal details that are nobody's
business, and if they are using the exact file system layout of the
current sequencer, then it's their responsibility to adapt?

Ciao,
Dscho
