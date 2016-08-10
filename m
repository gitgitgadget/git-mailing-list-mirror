Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEAB1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934302AbcHJSkD (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:40:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53029 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932501AbcHJSkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:40:01 -0400
Received: (qmail 25799 invoked by uid 109); 10 Aug 2016 13:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 13:13:19 +0000
Received: (qmail 32220 invoked by uid 111); 10 Aug 2016 13:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 09:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 09:13:17 -0400
Date:	Wed, 10 Aug 2016 09:13:17 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 02/15] pkt-line: call packet_trace() only if a packet
 is actually send
Message-ID: <20160810131317.a4npld5hf2qk6wiq@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-3-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160810130411.12419-3-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:03:58PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The packet_trace() call is not ideal in format_packet() as we would print
> a trace when a packet is formatted and (potentially) when the packet is
> actually send. This was no problem up until now because format_packet()
> was only used by one function. Fix it by moving the trace call into the
> function that actually sends the packet.

It looks like there are two functions: packet_write() and
packet_buf_write().

Your patch only touches one of them, and it looks like we would fail to
trace many packets (e.g., see receive-pack.c:report(), which uses
packet_buf_write() and then write()s out the result).

-Peff

PS Also, s/send/sent/ in the commit message.
