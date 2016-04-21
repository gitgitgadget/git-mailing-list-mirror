From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] run-command: teach async threads to ignore SIGPIPE
Date: Thu, 21 Apr 2016 01:18:57 -0400
Message-ID: <20160421051856.GA23270@sigill.intra.peff.net>
References: <20160419223945.GA18055@sigill.intra.peff.net>
 <20160419224941.GB18255@sigill.intra.peff.net>
 <571861EE.1080202@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 07:19:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at718-0004BJ-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 07:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbcDUFTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 01:19:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:53384 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbcDUFTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 01:19:01 -0400
Received: (qmail 8699 invoked by uid 102); 21 Apr 2016 05:19:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 01:19:00 -0400
Received: (qmail 5966 invoked by uid 107); 21 Apr 2016 05:18:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 01:18:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Apr 2016 01:18:57 -0400
Content-Disposition: inline
In-Reply-To: <571861EE.1080202@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292094>

On Thu, Apr 21, 2016 at 07:15:26AM +0200, Johannes Sixt wrote:

> Am 20.04.2016 um 00:49 schrieb Jeff King:
> >This is our first use of pthread_sigmask, and I think Windows will have
> >to come up with something for this in compat/. I don't know how SIGPIPE
> >works there at all, so it's possible that we can just turn this into a
> >noop. Worst case it could probably block SIGPIPE for the whole process.
> 
> There is no SIGPIPE on Windows. write() always returns EPIPE as if SIGPIPE
> was ignored.
> 
> We'll have to make pthread_sigmask() a no-op.

Great, thanks for clarifying. We can also #ifdef out the whole block
there if it's easier, but it looks like you already have noop
implementations for sigset, et al. So adding a noop pthread_sigmask()
should be enough.

-Peff
