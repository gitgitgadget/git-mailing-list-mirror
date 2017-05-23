Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A020284
	for <e@80x24.org>; Tue, 23 May 2017 12:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936059AbdEWMUx (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 08:20:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:56661 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934248AbdEWMUv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 08:20:51 -0400
Received: (qmail 4867 invoked by uid 109); 23 May 2017 12:20:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 12:20:48 +0000
Received: (qmail 31315 invoked by uid 111); 23 May 2017 12:21:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 08:21:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 08:20:46 -0400
Date:   Tue, 23 May 2017 08:20:46 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Monov <logixoul@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: How do I see =?utf-8?B?4oCcbWVyZ2Ug?= =?utf-8?B?ZXZlbnRz4oCd?=
 in history?
Message-ID: <20170523122046.xfxudxqof726vzuj@sigill.intra.peff.net>
References: <CAJtFkWu25RkiKm0O__W2My+Adi9pxZ3YtjZW4eb+2U+wpNS3yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJtFkWu25RkiKm0O__W2My+Adi9pxZ3YtjZW4eb+2U+wpNS3yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 03:07:40PM +0300, Stefan Monov wrote:

> I use the GitHub web interface and the git cli. Answers for either or
> both are appreciated.
> 
> Sometimes, when I merge a branch into another branch, I see a commit
> with a message like "Merge branch 'master' into other_branch" in the
> GitHub history. But not always. So how do I see all "merge events",
> inside the history?

The simple answer is that to see all merges, you can run "git log
--merges". But I think that's not quite what you're asking.

Your "but not always" makes me think you are wondering why sometimes
when you run "git merge" (or "git pull), it results in a merge commit
and sometimes not, and whether you can see evidence of the times when it
was "not".

When a merge is a "fast forward", i.e., when the thing you are merging
is strictly a descendent of your current branch, then Git omits the
merge commit and simply updates your current branch tip to the thing
you're merging. This can happen if you forked a branch, and then when it
came time to merge it back, nothing had happened on the original branch.

In a fast forward merge, there's no evidence at all of the merge command
in the resulting history graph. So there's nothing to find via "git
log".

For some workflows you'd rather see a commit for such merges, even if it
could fast-forward. For example, when merging a topic branch, you may
want the graph to reflect that the work was done on a side branch, even
if nothing happened on "master" in the interim. You can use "git merge
--no-ff" for this.

> Even better if I can get a view with vertical lines showing branches
> and merges (like a graph).

Try "git log --oneline --decorate --graph". It will show you the graph
structure and annotate the tips of any branches.

-Peff
