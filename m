Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA37208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 12:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbdHIMA2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:00:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752409AbdHIMA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:00:28 -0400
Received: (qmail 1770 invoked by uid 109); 9 Aug 2017 12:00:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:00:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26413 invoked by uid 111); 9 Aug 2017 12:00:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:00:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:00:25 -0400
Date:   Wed, 9 Aug 2017 08:00:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] dropping support for older curl
Message-ID: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resurrection of the thread from April:

  https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/

The general idea is that we should drop support for very old curl
versions, which already fail to compile. I'm sympathetic to the case
where people actually have systems with really old versions of curl. But
at the same time, I think we may be better off informing them that Git
isn't tested with these ancient versions at all (and I have a suspicion
that there are lurking bugs; see the commit messages or read that other
thread).

I've broken the changes into three patches. That helps a bit with
reviewing the diffs, but it also means we don't have to apply them all
at once (though I think we should; but it would likewise help if end up
wanting to revert one of them later).

The first cutoff is based on having more compilation breakages than the
other (and also just being incredibly old). The second is just a sweet
spot of bang-for-the-buck and age. In the absence of other data, it's
probably what I would suggest. The third one uses the existing compile
breakage from v2.12.0 as a guide.

  [1/4]: http: drop support for curl < 7.11.1
  [2/4]: http: drop support for curl < 7.16.0
  [3/4]: http: drop support for curl < 7.19.4
  [4/4]: http: #error on too-old curl

 Documentation/config.txt |   3 +-
 http-push.c              |  23 -------
 http-walker.c            |  12 ----
 http.c                   | 153 +----------------------------------------------
 http.h                   |  35 +----------
 remote-curl.c            |   7 ---
 6 files changed, 5 insertions(+), 228 deletions(-)

-Peff
