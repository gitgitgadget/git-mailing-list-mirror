Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997391FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbcFUVcr (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 17:32:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:58175 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbcFUVcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 17:32:45 -0400
Received: (qmail 6200 invoked by uid 102); 21 Jun 2016 21:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 17:04:56 -0400
Received: (qmail 28753 invoked by uid 107); 21 Jun 2016 21:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 17:05:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 17:04:54 -0400
Date:	Tue, 21 Jun 2016 17:04:54 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] archive-tar: write extended headers for file sizes
 >= 8GB
Message-ID: <20160621210454.GC4747@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043733.GA18323@sigill.intra.peff.net>
 <57687413.3030609@web.de>
 <20160621155920.GA7549@sigill.intra.peff.net>
 <5769A6CC.9030001@web.de>
 <5769AA47.4020806@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5769AA47.4020806@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 10:57:43PM +0200, René Scharfe wrote:

> Am 21.06.2016 um 22:42 schrieb René Scharfe:
> > The value 120 is magic; we need it to pass the tests.  That's
> > because prepare_header() is used for building extended header
> > records as well and we don't create extended headers for extended
> > headers (not sure if that would work anyway), so they simply
> > vanish when they're over the limit as their size field is set to
> > zero.
> 
> So how about something like this to make sure extended headers are
> only written for regular files and not for other extended headers?

This is quite similar to what I wrote originally, but I moved to the
ustar_size() format to better match the mtime code (which needs
something like that, because we pass around args->time).

I think you could drop ustar_size() completely here and just put the
"if" into write_tar_entry().

-Peff
