Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A147C20899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbdHBWY2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:24:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:56254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751206AbdHBWY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:24:27 -0400
Received: (qmail 3414 invoked by uid 109); 2 Aug 2017 22:24:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:24:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14031 invoked by uid 111); 2 Aug 2017 22:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:24:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:24:25 -0400
Date:   Wed, 2 Aug 2017 18:24:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] handling empty inputs in the revision machinery
Message-ID: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that:

  git log --tags=does-not-exist

will show all of HEAD, which is rather confusing. This fixes it, and
also hits several other cases that were marked as expect_failure for
rev-list. There is one case it doesn't handle: --stdin. It's not clear
to me what the right behavior is there. I'll follow up with more
discussion.

  [1/4]: t6018: flesh out empty input/output rev-list tests
  [2/4]: revision: add rev_input_given flag
  [3/4]: rev-list: don't show usage when we see empty ref patterns
  [4/4]: revision: do not fallback to default when rev_input_given is set

 builtin/rev-list.c       |  3 ++-
 revision.c               |  3 ++-
 revision.h               |  7 +++++++
 t/t4202-log.sh           |  6 ++++++
 t/t6018-rev-list-glob.sh | 20 +++++++++-----------
 5 files changed, 26 insertions(+), 13 deletions(-)

-Peff
