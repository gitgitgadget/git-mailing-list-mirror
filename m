Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38DB201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 08:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbdKNIoX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 03:44:23 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:46999 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdKNIoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 03:44:22 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:39876 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEWpR-0002n2-N4
        for git@vger.kernel.org; Tue, 14 Nov 2017 03:44:21 -0500
Date:   Tue, 14 Nov 2017 03:43:48 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: some apparent inaccuracies in "man git-worktree"
Message-ID: <alpine.LFD.2.21.1711140324580.12112@localhost.localdomain>
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


  more annoying pedantry (but you're used to that by now, right?) ...
from "man git-worktree", there seem to be some inaccuracies in the
SYNOPSIS regarding the "add" subcommand:

  git worktree add \
    [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]

  first, there's no mention of "-B" in that SYNOPSIS, even though it's
explained further down the man page.

  next, the SYNOPSIS seems misleading as it doesn't make clear that
the options -b, -B and --detach are mutually exclusive, which is made
clear in the worktree.c source:

    if (!!opts.detach + !!opts.new_branch + !!new_branch_force > 1)
            die(_("-b, -B, and --detach are mutually exclusive"));

and, to some extent, further down the man page:

  "If <branch> is omitted and neither -b nor -B nor --detach used,
   then, as a convenience, a new branch based at HEAD is created
   automatically, as if -b $(basename <path>) was specified."

  finally (and maybe i'm just not reading carefully enough), it's not
clear what happens if you add a worktree at a given commit without
specifying *any* of -b, -B or --detach. the obvious result should be a
new worktree checked out at a detached HEAD and, interestingly, if i
do that, then from the main tree, i see:

  $ git worktree list
  /home/rpjday/k/git   516fb7f2e73d [master]
  /home/rpjday/k/temp  c470abd4fde4 (detached HEAD)
  $

but from within the worktree, if i ask for the status, i see only:

  $ git status
  Not currently on any branch.
  nothing to commit, working tree clean
  $

where i would normally have expected to see "detached HEAD", is there
a reason that's not displayed?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
