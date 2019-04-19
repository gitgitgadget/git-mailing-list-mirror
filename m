Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596CF20248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfDSTqw (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:46:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:35444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725860AbfDSTqw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:46:52 -0400
Received: (qmail 5873 invoked by uid 109); 19 Apr 2019 19:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Apr 2019 19:46:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12705 invoked by uid 111); 19 Apr 2019 19:47:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Apr 2019 15:47:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2019 15:46:49 -0400
Date:   Fri, 19 Apr 2019 15:46:49 -0400
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Exposing the states of sequencer, etc.
Message-ID: <20190419194649.GB28277@sigill.intra.peff.net>
References: <CABURp0p6RmwjW4BN4qPv5iBKC_kzZFGyKJxuWw=+pEpjZGtV_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0p6RmwjW4BN4qPv5iBKC_kzZFGyKJxuWw=+pEpjZGtV_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 19, 2019 at 10:57:33AM -0700, Phil Hord wrote:

> "Junio C Hamano via vger.kernel.org" writes:
> 
> > > When cherry-picking or reverting a sequence of commits and if the final
> > > pick/revert has conflicts and the user uses `git commit` to commit the
> > > conflict resolution and does not run `git cherry-pick --continue` then
> > > the sequencer state is left behind. This can cause problems later.
> > > ...
> > I've certainly seen this myself.  Do you use command line prompt
> > support to remind you of the operation in progress?  I do, and I
> > have a suspicion that it did not help me in this situation by
> > ceasing to tell me that I have leftover state files after a manual
> > commit of the final step that conflicted and gave control back to
> > me.
> 
> Is there some place today that we explain the many rules Git uses to
> determine the operations in progress?  I once had a patch to do this
> in code, but I think I let it die in committee.  It was something
> like:
> 
>      $ git status --show-progress-state
>      cherry-pick, conflicts, untracked
> 
> It would be helpful first to have an API for this, of course, though I
> think that's where I got mired before.
> 
> I'm willing to take it on again, if there's not already some alternative.

Grep for get_state and print_state in wt-status.c. I think we only do so
for the "long" status output, but it should be possible to define a
machine-readable version for the porcelain output.

-Peff
