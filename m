Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9771F1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfIWTkG (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:40:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:57540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726777AbfIWTkG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:40:06 -0400
Received: (qmail 29657 invoked by uid 109); 23 Sep 2019 19:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 19:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4026 invoked by uid 111); 23 Sep 2019 19:42:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 15:42:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 15:40:05 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923194004.GF21344@sigill.intra.peff.net>
References: <20190913205148.GA8799@sigill.intra.peff.net>
 <20190920170448.226942-1-jonathantanmy@google.com>
 <20190921014701.GA191795@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190921014701.GA191795@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 06:47:01PM -0700, Emily Shaffer wrote:

> """
> "Did You Mean..?"
> 
> There are some situations where it's fairly clear what a user meant to
> do, even though they did not do that thing correctly. For example, if a
> user runs `git commit` with tracked, modified, unstaged files in their
> worktree, but no staged files at all, it's fairly likely that they
> simply forgot to add the files they wanted. In this case, the error
> message is slightly obtuse:
> 
> $ git commit
> On branch master
> Changes not staged for commit:
> 	modified:   foo.txt
> 
> no changes added to commit
> 
> 
> Since we have an idea of what the user _meant_ to do, we can offer
> something more like:
> 
> $ git commit
> On branch master
> Changes not staged for commit:
> 	modified:   foo.txt
> 
> Stage listed changes and continue? [Y/n]
> 
> While the above case is a good starting place, other similar cases can
> be added afterwards if time permits. These helper prompts should be
> enabled/disabled via a config option so that people who are used to
> their current workflow won't be impacted.
> """

This is an interesting idea. At first I thought it might be too small
for a project, but I think it could be expanded or contracted as much as
the time allows by just looking for more "did you mean" spots.

I have mixed feelings on making things interactive. For one, it gets
awkward when Git commands are called as part of a script or other
program (and a lot of programs like git-commit ride the line of plumbing
and porcelain). I know this would kick in only when a config option is
set, but I think that might things even _more_ confusing, as something
that works for one user (without the config) would start behaving
weirdly for another.

I also think it might be an opportunity to educate. Instead of giving a
yes/no prompt, we can actually recommend one (or more!) sets of commands
to get the desired effect. I _thought_ we already did for this case by
default (triggered by advice.statusHints, which is true by default). But
it looks like those don't get printed for git-commit?

-Peff
