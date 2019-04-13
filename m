Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9C920248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfDMFva (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:51:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:57158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725308AbfDMFva (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:51:30 -0400
Received: (qmail 27670 invoked by uid 109); 13 Apr 2019 05:51:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:51:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12498 invoked by uid 111); 13 Apr 2019 05:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:51:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:51:28 -0400
Date:   Sat, 13 Apr 2019 01:51:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/7] some fetch reachability-error fixes
Message-ID: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few minor bugs around clients trying to fetch
unreachable commits, along with a few associated cleanups.

There's a minor conflict in t5516 when merging with next, since that
adds GIT_TEST_PROTOCOL_VERSION, causing a few textual conflicts. The
resolution should be fairly clear.

Where appropriate, I took GIT_TEST_PROTOCOL_VERSION into account so that
after merging with next, all tests should still pass even with it set to
"2" (well, all the tests that do not already fail on vanilla 'next' with
that setting).

  [1/7]: t5516: drop ok=sigpipe from unreachable-want tests
  [2/7]: t5530: check protocol response for "not our ref"
  [3/7]: upload-pack: send ERR packet for non-tip objects
  [4/7]: pkt-line: prepare buffer before handling ERR packets
  [5/7]: fetch: use free_refs()
  [6/7]: remote.c: make singular free_ref() public
  [7/7]: fetch: do not consider peeled tags as advertised tips

 fetch-pack.c                 | 16 +++++++++-------
 pkt-line.c                   |  9 +++++----
 remote.c                     |  6 +++---
 remote.h                     |  4 +++-
 t/t5516-fetch-push.sh        | 18 +++++++++++++++---
 t/t5530-upload-pack-error.sh | 18 +++++++++++++++---
 upload-pack.c                | 11 ++++++++---
 7 files changed, 58 insertions(+), 24 deletions(-)

-Peff
