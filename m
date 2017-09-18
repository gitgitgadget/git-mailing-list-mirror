Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDEF2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbdIRPvD (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 11:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753519AbdIRPvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 11:51:02 -0400
Received: (qmail 22497 invoked by uid 109); 18 Sep 2017 15:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Sep 2017 15:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26787 invoked by uid 111); 18 Sep 2017 15:51:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Sep 2017 11:51:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Sep 2017 11:51:00 -0400
Date:   Mon, 18 Sep 2017 11:51:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] fix read past end of array in alternates files
Message-ID: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a regression in v2.11.1 where we might read past the
end of an mmap'd buffer. It was introduced in cf3c635210, but I didn't
base the patch on there, for a few reasons:

  1. There's a trivial conflict when merging up (because of
     git_open_noatime() becoming just git_open() in the inerim).

  2. The reproduction advice relies on our SANITIZE Makefile knob, which
     didn't exist back then.

  3. The second patch does not apply there because we don't have
     warn_on_fopen_errors(). Though admittedly it could be applied
     separately after merging up; it's just a clean-up on top.

It does apply on the current "maint".

  [1/2]: read_info_alternates: read contents into strbuf
  [2/2]: read_info_alternates: warn on non-trivial errors

 sha1_file.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

-Peff
