Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869E71FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936401AbcHJSm3 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:42:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:53036 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933745AbcHJSmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:42:25 -0400
Received: (qmail 25947 invoked by uid 109); 10 Aug 2016 13:15:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 13:15:43 +0000
Received: (qmail 32235 invoked by uid 111); 10 Aug 2016 13:15:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 09:15:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 09:15:41 -0400
Date:	Wed, 10 Aug 2016 09:15:41 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 03/15] pkt-line: add `gentle` parameter to
 format_packet()
Message-ID: <20160810131541.ovpvgwdxjibae5gy@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-4-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160810130411.12419-4-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:03:59PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> format_packet() dies if the caller wants to format a packet larger than
> LARGE_PACKET_MAX. Certain callers might prefer an error response instead.

I am not sure I agree here. Certainly I see the usefulness of gently
handling a failure to write(). But if you are passing in too-large
buffers, isn't that a bug in the program?

How would you recover, except by splitting up the content? That might
not be possible depending on how you are using the pkt-lines. And even
if it is, wouldn't it be simpler to split it up before sending it to
format_packet()?

-Peff
