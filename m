From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 16:18:01 -0400
Message-ID: <20110401201801.GA16602@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104011927.03366.j6t@kdbg.org>
 <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com>
 <201104012142.22065.j6t@kdbg.org>
 <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
 <20110401200537.GA15778@sigill.intra.peff.net>
 <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
 <20110401201714.GA16501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5knL-0005Vt-97
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab1DAUSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:18:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54625
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab1DAUSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:18:03 -0400
Received: (qmail 15558 invoked by uid 107); 1 Apr 2011 20:18:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 16:18:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 16:18:01 -0400
Content-Disposition: inline
In-Reply-To: <20110401201714.GA16501@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170616>

On Fri, Apr 01, 2011 at 04:17:14PM -0400, Jeff King wrote:

> > static inline int pthread_cancel(pthread_t thread)
> > {
> > 	SetEvent(thread.cancel_event);
> > 	CancelSynchronousIo(thread.handle);
> > }
> 
> There are a ton of cancellation points, not just I/O (e.g., sleep).
> However, interrupting a read would probably be sufficient for git's
> purposes.

Actually, I take that back. It would be sufficient for abort_async with
its current callers, but adding a pthread_cancel that is only partially
there may end up causing headaches down the road.

-Peff
