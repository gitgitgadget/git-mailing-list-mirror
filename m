From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 16:59:28 -0500
Message-ID: <20160119215928.GA6556@sigill.intra.peff.net>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:59:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLeJL-0004R0-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933191AbcASV7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:59:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:56492 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933185AbcASV7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:59:30 -0500
Received: (qmail 11133 invoked by uid 102); 19 Jan 2016 21:59:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 16:59:30 -0500
Received: (qmail 27093 invoked by uid 107); 19 Jan 2016 21:59:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 16:59:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 16:59:28 -0500
Content-Disposition: inline
In-Reply-To: <20160119215100.GB28656@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284385>

On Tue, Jan 19, 2016 at 04:51:00PM -0500, Jeff King wrote:

> Here's the patch I came up with. It takes the conservative choice (see
> the argument below), and shows the performance impact. I'll work up the
> non-conservative one on top, which I think can do even better than the
> original.

Oh, never mind. I had thought we could do away with _both_ rev-parses
and compare "foo^{tree}" to "foo^{tree}".

But of course that does not work. Because it is really "$commit^{tree}"
versus "$parent^{tree}" here. I need to update the commit message below.

We could get away "git diff --exit-code $1 $2" to do a single process
invocation (rather than two rev-parses), but I don't know if it is worth
the complexity.

-Peff
