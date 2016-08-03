Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682221F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcHCVyQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:54:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:54274 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754597AbcHCVyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:54:15 -0400
Received: (qmail 18671 invoked by uid 102); 3 Aug 2016 21:27:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:27:22 -0400
Received: (qmail 6076 invoked by uid 107); 3 Aug 2016 21:27:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:27:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 17:27:18 -0400
Date:	Wed, 3 Aug 2016 17:27:18 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
Message-ID: <20160803212718.cdqhd2zfzce7mqfa@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-2-larsxschneider@gmail.com>
 <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
 <20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803211221.t2zdhvwjum2baeqs@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 05:12:21PM -0400, Jeff King wrote:

> The alternative is to hand-code it, which is what send_sideband() does
> (it uses xsnprintf("%04x") to do the hex formatting, though).

After seeing that, I wondered why we need set_packet_header() at all.
But we do for the case when we are filling in the size at the start of a
buffer, because xsnprintf() will write an extra NUL that we do not care
about. send_sideband() is happy to then overwrite it with data, but
code (like format_packet) that computes the buffer, then fills in the
size, must avoid overwriting the first byte of the buffer.

-Peff
