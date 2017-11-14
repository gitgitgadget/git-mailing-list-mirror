Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369A01F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755699AbdKNULT (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:11:19 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:33844 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdKNULK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:11:10 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:40982 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEhY5-00087X-5c; Tue, 14 Nov 2017 15:11:09 -0500
Date:   Tue, 14 Nov 2017 15:10:34 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: some apparent inaccuracies in "man git-worktree"
In-Reply-To: <CAPig+cRc7Yqeys=oPEgPnyR4qT7qKYLbH1ifnp+6F6N+mSzNVA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1711141509280.3970@localhost.localdomain>
References: <alpine.LFD.2.21.1711140324580.12112@localhost.localdomain> <CAPig+cRc7Yqeys=oPEgPnyR4qT7qKYLbH1ifnp+6F6N+mSzNVA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Nov 2017, Eric Sunshine wrote:

> On Tue, Nov 14, 2017 at 3:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > from "man git-worktree", there seem to be some inaccuracies in the
> > SYNOPSIS regarding the "add" subcommand:
> >
> >   git worktree add \
> >     [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
> >
> >   first, there's no mention of "-B" in that SYNOPSIS, even though it's
> > explained further down the man page.
>
> Omission of "-B" from the synopsis was intentional. From cbdf60fa18
> (worktree: add -b/-B options, 2015-07-06):
>
>     worktree: add -b/-B options
>
>     One of git-worktree's roles is to populate the new worktree, much like
>     git-checkout, and thus, for convenience, ought to support several of the
>     same shortcuts. Toward this goal, add -b/-B options to create a new
>     branch and check it out in the new worktree.
>
>     (For brevity, only -b is mentioned in the synopsis; -B is omitted.)
>
> Whether or not the omission was actually a good decision is
> questionable. The thinking, at the time, may have been that users
> already familiar with "-b" in 'git checkout' would likewise be
> familiar with (and be able to infer) "-B", thus it wasn't important to
> state its existence explicitly in the synopsis, which was already
> getting lengthy. Of course, that decision does not assist newcomers,
> so adding "-B" to the synopsis would help the page better stand on its
> own.
>
> >   next, the SYNOPSIS seems misleading as it doesn't make clear that
> > the options -b, -B and --detach are mutually exclusive, which is made
> > clear in the worktree.c source:
> >
> >     if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
> >             die(_("-b, -B, and --detach are mutually exclusive"));
>
> Failure to update the synopsis to indicate mutual exclusion appears to
> be a simple oversight in ab0b2c53ed (worktree: make --detach mutually
> exclusive with -b/-B, 2015-07-17) in response to:
> https://public-inbox.org/git/55A8F4B1.9060304@drmicha.warpmail.net/
>
> >   finally (and maybe i'm just not reading carefully enough), it's not
> > clear what happens if you add a worktree at a given commit without
> > specifying *any* of -b, -B or --detach. the obvious result should be a
> > new worktree checked out at a detached HEAD and, interestingly, if i
> > do that, then from the main tree, i see:
> >
> >   $ git worktree list
> >   /home/rpjday/k/git   516fb7f2e73d [master]
> >   /home/rpjday/k/temp  c470abd4fde4 (detached HEAD)
> >   $
> >
> > but from within the worktree, if i ask for the status, i see only:
> >
> >   $ git status
> >   Not currently on any branch.
> >   nothing to commit, working tree clean
> >   $
> >
> > where i would normally have expected to see "detached HEAD", is there
> > a reason that's not displayed?
>
> Someone more familiar with this bit can correct me if I'm wrong, but I
> believe that the "HEAD detached at/from <branch>" you normally see
> with 'git status' is derived from the reflog, and if it can't find the
> information in the reflog, it instead shows the generic "Not currently
> on any branch" (which is the equivalent of the "(detached HEAD)" you
> see in "git worktree list").
>
> Each worktree has its own newly-created reflog, which does _not_
> contain enough information for 'git status' to present the more
> detailed "detached" message, thus it falls back to the generic one.
> Perhaps seeding the worktree's reflog with a bit more information at
> creation time would be a good #leftoverbits task.

  i'm not sure what i can add to this, but i'm going to leave it to
folks higher up the food chain than me to resolve any of the above.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
