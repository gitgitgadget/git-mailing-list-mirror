Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D294AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A65A2311B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgIYGpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:45:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:40368 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgIYGpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 02:45:01 -0400
Received: (qmail 13070 invoked by uid 109); 25 Sep 2020 06:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 06:45:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15777 invoked by uid 111); 25 Sep 2020 06:45:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 02:45:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 02:44:59 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Webster <chris@webstech.net>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
Message-ID: <20200925064459.GA3179383@coredump.intra.peff.net>
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net>
 <CAGT1KpVmeT+nT1-Pfwa_M8BptFYwRTL4ofM0k6UOOzkYh0kucw@mail.gmail.com>
 <20200924065129.GB1851751@coredump.intra.peff.net>
 <CAGT1KpU6zkvr9QQQqez6x1cVsvhxmkU9gG5T0QYC8yCgnOPN1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGT1KpU6zkvr9QQQqez6x1cVsvhxmkU9gG5T0QYC8yCgnOPN1Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 24, 2020 at 10:10:16PM -0700, Chris Webster wrote:

> > Definitely not worth
> > it compared to your solution for a PR, but maybe worth it if it lets us
> > do the same thing for arbitrary branches.
> 
> The PR solution works because fixed values are available from GitHub
> (both repos are present and accounted for).  A push action for
> branches could have issues with the state of the GitHub repo versus
> the local repo.  What happens if the base branch is not current on
> GitHub?  Is HEAD reliable? What if the branch has been re-used with a
> back-merge? How do you limit the check in this case?  Based on my
> demonstrated lack of knowledge these concerns may be addressable.

Hmm, good points. The case I was most worried about was branches based
on older points in history, but as long as master keeps moving forward,
we'd be OK there (at least in the local case where we have all of the
commits; not sure about the shallow-exclude I mentioned above).

And in the case of git.git, I think we're pretty safe. "master" gets
pushed along with "seen". But not necessarily so in other repositories.
If I base a new topic on Junio's "master" and then push it up, it may be
far ahead of my "master" (and in fact, I don't even have a "master" in
my personal repo).

GGG PRs figure this out because that repo is a fork of git/git, and it
looks at the master of the parent repo as the base for the PR. So
probably we could do something similar, but this is starting to get
rather tricky.

I think you've convinced me that it's not easy to just adapt this to
handle any branch. Let's punt on that idea for now (unless somebody
feels like digging further on it, of course) and move forward with doing
this for the PR case as your patch does.

-Peff
