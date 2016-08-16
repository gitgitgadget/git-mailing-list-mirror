Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001E81F859
	for <e@80x24.org>; Tue, 16 Aug 2016 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbcHPWYT (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 18:24:19 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42000 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbcHPWYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 18:24:18 -0400
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 74199A80C8;
	Wed, 17 Aug 2016 00:24:15 +0200 (CEST)
Date:	Tue, 16 Aug 2016 15:24:14 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816222414.GA17195@cloud>
References: <20160816161838.klvjhhoxsftvkfmd@x>
 <20160816163145.mjc726til2daxl3d@sigill.intra.peff.net>
 <20160816173444.rpqlpsz2ognvlufy@x>
 <20160816182852.inyqzplee5m3wzt6@sigill.intra.peff.net>
 <20160816203150.GA16774@cloud>
 <20160816205426.dotqythoyn7zztma@sigill.intra.peff.net>
 <20160816211141.GA16922@cloud>
 <20160816211551.fjobjxcqvo2dfiry@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160816211551.fjobjxcqvo2dfiry@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 05:15:51PM -0400, Jeff King wrote:
> On Tue, Aug 16, 2016 at 02:11:41PM -0700, Josh Triplett wrote:
> 
> > > For HTTPS, I'd just as soon use HTTP-level features.
> > 
> > ALPN, used carefully, could potentially allow eliminating one round-trip
> > compared to HTTPS, and could also allow full-duplex communication.
> 
> I'd love to have a real full-duplex git-over-https. I looked into
> WebSockets at one point, but it looked non-trivial and I gave up.

WebSockets would be non-trivial, and require server configuration as
well, but it could work.

> But if we had a real full-duplex connection over https, I think there
> would be no reason for git:// to continue existing (we'd probably keep
> ssh as it's a useful protocol for authentication, though).

Agreed.

Using ALPN wouldn't actually end up using HTTPS; it would negotiate with
the server and end up connected directly to a git program speaking an
arbitrary protocol over TLS.  Many web servers already support ALPN to
negotiate HTTP/2, so this seems plausible.

Another alternative would be to define a framing for a full-duplex
git-upload-pack connection inside a single HTTP/2 connection; HTTP/2
already effectively allows full-duplex asynchronous conversations.

- Josh Triplett
