Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B6620773
	for <e@80x24.org>; Mon, 16 Jan 2017 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbdAPVWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:22:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:39836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750834AbdAPVWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:22:34 -0500
Received: (qmail 20058 invoked by uid 109); 16 Jan 2017 21:22:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:22:34 +0000
Received: (qmail 12281 invoked by uid 111); 16 Jan 2017 21:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:23:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:22:31 -0500
Date:   Mon, 16 Jan 2017 16:22:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/6] fsck --connectivity-check misses some corruption
Message-ID: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I came across a repository today that was missing an object, and for
which "git fsck" reported the error but "git fsck --connectivity-check"
did not. It turns out that the shortcut taken by --connectivity-check
violates some assumptions made by the rest of fsck (namely, that every
object in the repo has a "struct object" loaded).

And fsck being a generally neglected tool, I couldn't help but find
several more bugs on the way. :)

  [1/6]: t1450: clean up sub-objects in duplicate-entry test
  [2/6]: fsck: report trees as dangling
  [3/6]: fsck: prepare dummy objects for --connectivity-check
  [4/6]: fsck: tighten error-checks of "git fsck <head>"
  [5/6]: fsck: do not fallback "git fsck <bogus>" to "git fsck"
  [6/6]: fsck: check HAS_OBJ more consistently

 builtin/fsck.c  | 131 ++++++++++++++++++++++++++++++++++++++++++++------------
 t/t1450-fsck.sh |  70 ++++++++++++++++++++++++++++--
 2 files changed, 171 insertions(+), 30 deletions(-)

-Peff
