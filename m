Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CB720281
	for <e@80x24.org>; Thu, 21 Sep 2017 06:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdIUGUq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:20:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:45700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751485AbdIUGUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:20:46 -0400
Received: (qmail 5894 invoked by uid 109); 21 Sep 2017 06:20:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 06:20:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19986 invoked by uid 111); 21 Sep 2017 06:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 02:21:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 02:20:43 -0400
Date:   Thu, 21 Sep 2017 02:20:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] appeasing -Wimplicit-fallthrough
Message-ID: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that gcc 7 ships with a new implicit-fallthrough warning that
tries to find accidental switch-case fallthroughs. It's enabled with
-Wextra, or you can turn it on separately. I don't think it finds any
real bugs in the current code, but it does seem like something that's
potentially worth paying attention to.

So here's a series that squelches the false positives. The first patch
is a real bug-fix that I found while poking around, and can be taken
separately.  The middle ones improve code readability, IMHO. And the
final one just annotates the code to shut up the compiler warning.

  [1/4]: cat-file: handle NULL object_context.path
  [2/4]: test-line-buffer: simplify command parsing
  [3/4]: curl_trace(): eliminate switch fallthrough
  [4/4]: consistently use "fallthrough" comments in switches

 apply.c                     |  3 ++-
 builtin/cat-file.c          |  5 +++--
 builtin/checkout.c          |  1 +
 builtin/remote-ext.c        |  2 +-
 builtin/submodule--helper.c |  1 +
 config.c                    |  1 +
 convert.c                   |  3 ++-
 fsck.c                      |  1 +
 http-push.c                 |  1 +
 http.c                      |  7 ++++---
 mailinfo.c                  |  1 +
 quote.c                     |  1 +
 read-cache.c                |  1 +
 send-pack.c                 |  2 +-
 t/helper/test-line-buffer.c | 32 +++++++++++---------------------
 t/t8010-cat-file-filters.sh |  5 +++++
 16 files changed, 37 insertions(+), 30 deletions(-)

