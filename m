Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557751FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 21:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbcLAVry (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 16:47:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:50249 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbcLAVrx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 16:47:53 -0500
Received: (qmail 19614 invoked by uid 109); 1 Dec 2016 21:47:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 21:47:53 +0000
Received: (qmail 4607 invoked by uid 111); 1 Dec 2016 21:48:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 16:48:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 16:47:50 -0500
Date:   Thu, 1 Dec 2016 16:47:50 -0500
From:   Jeff King <peff@peff.net>
To:     "Alfonsogonzalez, Ernesto (GE Digital)" 
        <ernesto.alfonsogonzalez@ge.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "Your branch is ahead of 'origin' by X commits"
Message-ID: <20161201214750.awin75rfums6mjrv@sigill.intra.peff.net>
References: <D465BDE6.B7DE%ernesto.alfonsogonzalez@ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D465BDE6.B7DE%ernesto.alfonsogonzalez@ge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 07:49:40PM +0000, Alfonsogonzalez, Ernesto (GE Digital) wrote:

> $ git diff origin/master
> $ git status
> On branch master
> Your branch is ahead of 'origin' by 108 commits.
>   (use "git push" to publish your local commits)
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)

The "master" we are talking about here must always be
"refs/heads/master", since it will have come from resolving the HEAD
symbolic ref.

But here:

> $ git show origin/master --oneline
> 92d392c Merge pull request #21 from org/branch
> 
> $ git show master --oneline
> 92d392c Merge pull request #21 from org/branch

The "master" in the second case could possibly find "master" as another
name. Is it possible you have a .git/master file (this may have been
created by accidentally running "git update-ref master" instead of "git
update-ref refs/heads/master")?

Or other things you could check:

  # see what's on HEAD, which we know points to refs/heads/master
  git show HEAD

  # or just check refs/heads/master itself
  git show refs/heads/master

  # or just ask what "master" resolves to
  git rev-parse --symbolic-full-name master

That last one actually seems to complain that "refname 'master' is
ambiguous' if you do have .git/master. I think that's a minor bug, as it
should presumably follow the normal disambiguation rules used for lookup
(in which .git/master always takes precedence over refs/heads/master).

-Peff
