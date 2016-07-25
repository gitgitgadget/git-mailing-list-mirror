Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C4F203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbcGYStm (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:49:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:48733 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752835AbcGYStl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 14:49:41 -0400
Received: (qmail 9812 invoked by uid 102); 25 Jul 2016 18:49:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:49:41 -0400
Received: (qmail 27446 invoked by uid 107); 25 Jul 2016 18:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jul 2016 14:50:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2016 14:49:38 -0400
Date:	Mon, 25 Jul 2016 14:49:38 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 0/2] speed up "Counting objects" when there are many packs
Message-ID: <20160725184938.GA12871@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We sometimes see cases at GitHub where repository maintenance has fallen
behind, and you get a large number of packs. The solution is to repack,
but that process is itself made a lot slower by the number of packs.

We've experimented a bit with fast "just cat all the packfiles together"
type approaches, but they have some downsides, so I have nothing to show
there yet.

However, there are a few easy optimizations we can do to cut out some
unnecessary computation in common cases (e.g., when you have no .keep
files and when you have no upstream alternates storage). Both of these
patches have been in production at GitHub for about 6 months.

  [1/2]: pack-objects: break out of want_object loop early
  [2/2]: pack-objects: compute local/ignore_pack_keep early

-Peff
