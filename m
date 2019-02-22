Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01C41F453
	for <e@80x24.org>; Fri, 22 Feb 2019 06:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfBVGTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 01:19:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:53816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725873AbfBVGTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 01:19:52 -0500
Received: (qmail 29124 invoked by uid 109); 22 Feb 2019 06:19:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 06:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19664 invoked by uid 111); 22 Feb 2019 06:20:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 01:20:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 01:19:49 -0500
Date:   Fri, 22 Feb 2019 01:19:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: [PATCH 0/3] prettier bisect output
Message-ID: <20190222061949.GA9875@sigill.intra.peff.net>
References: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
 <xmqq1s40u8gt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1s40u8gt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 01:39:46PM -0800, Junio C Hamano wrote:

> > git bisect good
> > 3a9388eef42efc87c78ce22158d55e69a278b4eb is the first bad commit
> >
> > git --version
> > git version 2.14.1
> 
> Are you sure (and if so how did you reach that conclusion) that the
> above difference comes from the last 'bad' vs 'good' you finished,
> and not comes from the difference between 77c044d8 vs 3a9388ee?
> 
> At the end of the bisection session, bisect.c::show_diff_tree() is
> called on that "culprit" commit.  Is it possible that 3a9388ee is a
> simple and trivial merge that does not have anything worth reporting
> for "git diff-tree"?

I've run across this many times, too. Since it's been bugging me for a
decade, I thought I'd finally try to address it. Here are some patches.

There was some discussion about a year ago about just using "git show"
for this output:

  https://public-inbox.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com/

Christian seemed generally OK with tweaking the output, but preferred
not to move all the way to running an external "git show". I'm not sure
I completely agree, but it was easy enough to get the results I wanted
just by fiddling the current code a bit. ;)

  [1/3]: bisect: use string arguments to feed internal diff-tree
  [2/3]: bisect: fix internal diff-tree config loading
  [3/3]: bisect: make diff-tree output prettier

 bisect.c                    | 19 +++++--------------
 t/t6030-bisect-porcelain.sh |  6 +++---
 2 files changed, 8 insertions(+), 17 deletions(-)

-Peff
