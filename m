From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 17:48:58 -0500
Message-ID: <20160119224857.GD6556@sigill.intra.peff.net>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
 <20160119215928.GA6556@sigill.intra.peff.net>
 <20160119222802.GC6556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:49:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLf5G-0006Eg-5E
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 23:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736AbcASWtC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 17:49:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:56529 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757301AbcASWtA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 17:49:00 -0500
Received: (qmail 14626 invoked by uid 102); 19 Jan 2016 22:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 17:49:00 -0500
Received: (qmail 27468 invoked by uid 107); 19 Jan 2016 22:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 17:49:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 17:48:58 -0500
Content-Disposition: inline
In-Reply-To: <20160119222802.GC6556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284390>

On Tue, Jan 19, 2016 at 05:28:02PM -0500, Jeff King wrote:

> I dunno. I'm inclined to say that none of this is worth it to try to
> drop one or two processes. Writing filter-branch in a better language
> (or just using BFG) would probably be a more productive use of time.
> 20% looks like a lot, but that's because it's pretty fast in the first
> place.  The timings I showed earlier (and below) are for git.git, which
> is not that huge. But the savings from 348d4f2 are really about avoiding
> looking at the trees entirely; the bigger your tree, the more you save.
> Running it on linux.git should show that we're still reclaiming most of
> the original optimization.

In case anyone is curious, here are the linux.git numbers (re-wrapped,
because t/perf produces some really long lines; that might be worth
addressing):

348d4f2^ 295.32(269.61+14.36)
348d4f2    7.92(  0.85+ 0.72)    -97.3%
HEAD^      9.37(  0.87+ 0.80)    -96.8%
HEAD       7.71(  0.92+ 0.62)    -97.4%

So yes, the conservative fix costs us about 1.5 seconds, or 18%, over
the micro-optimized one.  But the original point was to save over 280
seconds, which we still do.

-Peff
