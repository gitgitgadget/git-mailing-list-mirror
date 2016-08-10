Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D068F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935654AbcHJSd2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:33:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933717AbcHJSd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:33:26 -0400
Received: (qmail 30756 invoked by uid 109); 10 Aug 2016 14:33:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 14:33:24 +0000
Received: (qmail 320 invoked by uid 111); 10 Aug 2016 14:33:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 10:33:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 10:33:21 -0400
Date:	Wed, 10 Aug 2016 10:33:21 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, mlbright@gmail.com, e@80x24.org,
	Johannes.Schindelin@gmx.de, ben@wijen.net
Subject: Re: [PATCH v5 02/15] pkt-line: call packet_trace() only if a packet
 is actually send
Message-ID: <20160810143321.q7mjirgr5ynml5ff@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-3-larsxschneider@gmail.com>
 <20160810131317.a4npld5hf2qk6wiq@sigill.intra.peff.net>
 <4111F00D-74A9-449D-BDE9-EE170DA4A403@gmail.com>
 <20160810133017.ovdx3a3ldqj5gl7q@sigill.intra.peff.net>
 <9BF0767F-6B10-42D5-9A72-2710A753E26A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9BF0767F-6B10-42D5-9A72-2710A753E26A@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:51:35PM +0200, Lars Schneider wrote:

> I guess my point is that I stumbled over the un-intutiive format_packet() behavior
> and I wanted to improve the situation in a way that others don't run into this
> trap. If you think that is no issue then it would be OK for me if we leave the
> current behavior as is.

I don't think the behavior as-is is a problem, and it would remain OK as
long as no callers are added who format a packet but don't write it (or
don't write it in a timely manner).

But most importantly, if you are going to refactor code, you can't
regress the existing callers. So even if we did want to change how this
worked, this patch is not acceptable as-is; it would need to fix up all
of the callers of packet_buf_write().

-Peff
