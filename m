From: Jeff King <peff@peff.net>
Subject: Re: msysgit with git protocol to linux server
Date: Fri, 18 May 2012 19:57:46 -0400
Message-ID: <20120518235746.GA765@sigill.intra.peff.net>
References: <jp69f2$gir$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVX3T-0006OB-O2
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967068Ab2ERX5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:57:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48856
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965463Ab2ERX5t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:57:49 -0400
Received: (qmail 9699 invoked by uid 107); 18 May 2012 23:58:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:58:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:57:46 -0400
Content-Disposition: inline
In-Reply-To: <jp69f2$gir$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197995>

On Fri, May 18, 2012 at 02:55:13PM -0500, Neal Kreitzinger wrote:

> If my pc is on the same vpn as the linux server can I use git
> protocol instead of ssh for better speed?

Yes, you can, but no, it will probably not be faster.

> I have instructions on how to setup msysgit with ssh.  (I'm new to
> msysgit and ssh.)  On the linux servers we've been using git protocol
> since they are on the same vpn.  My understanding is that git
> protocol is faster than ssh.

It's exactly the same protocol. The only reason it would be faster is
if your machine is so slow that the encryption overhead of ssh is a
bottleneck.

Note that git-over-http can be slightly slower than the regular git
protocol, because there may be more round-trip latency during the commit
negotiation (but once you are actually getting the pack from the server,
it should be the same, and that time tends to dominate, anyway).

I'm not sure why you care about the vpn, unless:

  1. You are worried about man-in-the-middle attacks fetching via
     git://, which you can presumably disregard over the vpn.

  2. You want to allow pushes over git:// instead of ssh. I wouldn't
     recommend this, but you can do so by setting daemon.receivepack in
     the config.

-Peff
