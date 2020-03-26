Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A5AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 03:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3732B2051A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 03:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMDAkNjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgCZDhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:37:35 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40441 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgCZDhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 23:37:35 -0400
Received: by mail-ot1-f52.google.com with SMTP id e19so4453002otj.7
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbTw5nWOrGF+Fp0DkZ6ZOUiXB63j7o2vi+vK+KDYY4U=;
        b=GMDAkNjltJOUiNaLd54xcnjDzBuZjqAh/hgjbpc1ivPJDNoyT+fBaRC7qufL+dflru
         aq6Dp42tGvCP3Pz+XZX77boyTD1OWcto4GvETzm3Ho2u1ByjNcFm7zF8CxgLsrMOiABJ
         J5xxTDSsViXIuFv5nCF8M5BnS0hUJ8By5IqTvtHVB0hy5y5NEGzJ28xmXhq7XTGpO1v0
         ILY9RUCUbHMUgMvJMpty8ncesmic0H3HjAvX8uvoztA5kFmsaTxkbbj+qpg913UMadt0
         FQ4D1r9/WFGcOjj01bCWCinurH25MYjUunP8rBluTeU6M8/2IiswJRe85UpR4VoVOQ3B
         7ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbTw5nWOrGF+Fp0DkZ6ZOUiXB63j7o2vi+vK+KDYY4U=;
        b=c3oNOHVEjWjeuf+SWVNMyDeAgM4EjrxXahPDAvqgg59ZNFrQZifn6ipeJAaGMHxSxT
         r+gL7DvleBvES55sTPWB/MhxcsdPXN8h2IQG2TVqQ5xRzTq9rCQvvQ+gIC8pkhdsZBGT
         npjhPaoMvLKzON9Q8oLZaNzTwO745+YFy9kC+U4GHxMNnVttwGo/DtVkdwUN6AYYOeuW
         FrsxLDq16zV1S1AvUNX+2AiuTtCDseTEMb/VNccS5I/w+750qWMw1mSY73lWLlpZkXPD
         finmzrR8ViIvYXwY5eNDVrkwKtBu4QnqtsOZqEp06rJtey9p4IkZghPhJLFA63v1YEqB
         1aRw==
X-Gm-Message-State: ANhLgQ1EizbLWLmSO/FW4f5UztuCwYzVRYs61OBMOLe0Civ6q0HDGS3n
        A3woEA1pW4+MJAsrzvh1EBUNgQs5je7CxZ76fN8=
X-Google-Smtp-Source: ADFU+vtn37HtZZpsaXQBk/kaVBIMxC94qE1bCwgdlFFAPJnBcPQLwIMazW5PQmQ42OLaMNpb456bJz3EZv09L7yzdfc=
X-Received: by 2002:a4a:a88a:: with SMTP id q10mr3262259oom.17.1585193853015;
 Wed, 25 Mar 2020 20:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net> <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
 <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com> <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
In-Reply-To: <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Mar 2020 20:37:22 -0700
Message-ID: <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
Subject: Re: "git rebase" behavior change in 2.26.0
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ooh, the plot thickens...

On Wed, Mar 25, 2020 at 6:46 PM Norbert Kiesel <nkiesel@gmail.com> wrote:
>
> Here is a concrete example:
>
> lt-nkiesel:~Platform(nextrelease)% git -c rebase.backend=merge -c
> pull.rebase=false -c branch.nextrelease.rebase=true pull

So pull.rebase is false for the general case, but it should be true
when on the nextrelease branch.  Your prompt seems to imply you are on
the nextrelease branch, but I'm not so sure because...

> remote: Enumerating objects: 1, done.
> remote: Counting objects: 100% (1/1), done.
> remote: Total 1 (delta 0), reused 0 (delta 0)
> Unpacking objects: 100% (1/1), 279 bytes | 279.00 KiB/s, done.
> From msgit.rnd.metricstream.com:platform/Platform7
>    d008080d3f2..db4042856da  nextrelease -> origin/nextrelease
> Updating d008080d3f2..db4042856da
> Fast-forward

"Fast-forward" is a message from builtin/merge.c, it implies that
rebase is not invoked at all.  (rebase with the merge backend calls
merge-recursive.c, not builtin/merge.c)  This suggests that
pull.$branch.rebase isn't working as we intended.

>  modules/bpcsfw/src/main/java/com/metricstream/systemi/client/servlet/servant/BaseViewController.java
> | 54 +++++++++++++++++++++++++-----------------------------
>  modules/bpcsfw/src/main/java/com/metricstream/util/HttpUtils.java
>                                |  5 +++++
>  2 files changed, 30 insertions(+), 29 deletions(-)

Diffstats are also off by default for rebases, so unless you've set
rebase.stat in some config somewhere, this also suggests that a merge
was used.


Now, when I try to duplicate, just for fun I added some 'die("You ran
a merge!")' and 'die("You ran a rebase!")' lines early in
builtin/{merge,rebase}.c, just so I could verify what was run.  Then I
tried to use a command line similar to yours:

$ git -c rebase.backend=merge -c pull.rebase=false -c
branch.master.rebase=true pull
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 250 bytes | 250.00 KiB/s, done.
From /home/newren/floss/git/testing/pull-rebase-orig-head/repo
   c911eef..2ccdb90  master     -> origin/master
fatal: You ran a merge!
fatal: You ran a rebase!


Say, WAT?!?  This attempted to run both a merge and a rebase?  That
appears to be yet another bug.

> Successfully rebased and updated refs/heads/nextrelease.
> lt-nkiesel:~Platform(nextrelease)% git rev-parse ORIG_HEAD
> db4042856da8338f183c831fca92cf63da7988bd
> lt-nkiesel:~Platform(nextrelease)% git rev-parse HEAD
> db4042856da8338f183c831fca92cf63da7988bd
> lt-nkiesel:~Platform(nextrelease)%
>
> As you can see, git said "Fast-forward" (i.e. no need to rebase) but
> nevertheless after that pull ORIG_HEAD is identical to HEAD

When I remove the die() calls that I added, here's what I see:

$ git -c rebase.backend=merge -c pull.rebase=false -c
branch.master.rebase=true pull
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), 251 bytes | 251.00 KiB/s, done.
From /home/newren/floss/git/testing/pull-rebase-orig-head/repo
   100c273..c911eef  master     -> origin/master
Updating 100c273..c911eef
Fast-forward
 numbers | 1 +
 1 file changed, 1 insertion(+)
Current branch master is up to date.

$ git log --oneline --reverse
9691d52 initial
1d5a4c1 add another
0da5805 add another
ccea292 add another
100c273 add another
c911eef (HEAD -> master, origin/master, origin/HEAD) add another

$ git rev-parse --short ORIG_HEAD
100c273

In other words, ORIG_HEAD does not match HEAD, it correctly points at
the old commit.  So, we found a couple bugs, but I still can't
duplicate the bug you're reporting.  What else is different about your
setup?  What's in your .git/config, and in your $HOME/.gitconfig?
What hooks do you have setup in .git/hooks/ -- do any of them do a
reset --hard?
