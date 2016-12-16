Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9891FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757304AbcLPC3J (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:29:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:57388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLPC3H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 21:29:07 -0500
Received: (qmail 8636 invoked by uid 109); 16 Dec 2016 02:29:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 02:29:07 +0000
Received: (qmail 8510 invoked by uid 111); 16 Dec 2016 02:29:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 21:29:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 21:29:04 -0500
Date:   Thu, 15 Dec 2016 21:29:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
Message-ID: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
 <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
 <20161216013728.in2dazshtarrnnq3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161216013728.in2dazshtarrnnq3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 08:37:28PM -0500, Jeff King wrote:

> But if this case really is just "if (from_stdin)" that's quite easy,
> too.

So here is that patch (with some associated refactoring and cleanups).
This is conceptually independent of jk/no-looking-at-dotgit-outside-repo-final,
though it should be fine to merge with that topic. The BUG will actually
pass the new test, because it calls die, too. I wonder if we should die
with a unique error code on BUGs, and catch them in test_must_fail
similar to the way we catch signal death.

  [1/3]: t5000: extract nongit function to test-lib-functions.sh
  [2/3]: index-pack: complain when --stdin is used outside of a repo
  [3/3]: t: use nongit() function where applicable

 builtin/index-pack.c     |  2 ++
 t/t1308-config-set.sh    | 10 ++--------
 t/t5000-tar-tree.sh      | 14 --------------
 t/t5300-pack-object.sh   | 15 +++++++++++++++
 t/t9100-git-svn-basic.sh | 17 ++---------------
 t/t9902-completion.sh    |  7 +------
 t/test-lib-functions.sh  | 14 ++++++++++++++
 7 files changed, 36 insertions(+), 43 deletions(-)

-Peff
