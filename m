Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320D71F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756475AbcJNNmS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:42:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:57391 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754789AbcJNNmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:42:17 -0400
Received: (qmail 2498 invoked by uid 109); 14 Oct 2016 13:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 13:42:16 +0000
Received: (qmail 5673 invoked by uid 111); 14 Oct 2016 13:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 09:42:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2016 09:42:14 -0400
Date:   Fri, 14 Oct 2016 09:42:14 -0400
From:   Jeff King <peff@peff.net>
To:     Petr Stodulka <pstodulk@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2]  infinite loop in "git ls-tree" for broken symlink
Message-ID: <20161014134214.z3jzlx36y57cdqhu@sigill.intra.peff.net>
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 03:16:50PM +0200, Petr Stodulka wrote:

> I have realized that this wasn't fixed after all when refs.c
> was "rewritten". Issue is caused by broken symlink under refs/heads,
> which causes infinite loop for "git ls-tree" command. It was replied
> earlier [0] and Michael previously fixed that in better way probably,
> then my proposed patch 2/2, but it contains more changes and I have not
> enough time to study changes in refs* code, so I propose now just my
> little patch, which was previously modified by Michael.
> 
> If you prefer different solution, I am ok with this. It is really
> just quick proposal. Patch 1/2 contains test for this issue. If you
> will prefer different solution with different exit code, test should
> be corrected. Basic idea is, that timeout should'n expire with
> exit code 124.
> 
> [0] http://marc.info/?l=git&m=142712669103790&w=2
> [1] https://github.com/mhagger/git, branch "ref-broken-symlinks"

I think I fixed this semi-independently last week; see the thread at:

  http://public-inbox.org/git/20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net/

I say semi-independently because I didn't actually know about your
previous report, but saw it in the wild myself. But I did talk with
Michael off-list, and he suggested the belt-and-suspenders retry counter
in my second patch.

The fix is at e8c42cb in Junio's tree, and it's currently merged to
'next'.

-Peff
