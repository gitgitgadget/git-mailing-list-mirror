From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends
	strerror(errno)  to die()
Date: Mon, 8 Jun 2009 08:36:08 -0400
Message-ID: <20090608123608.GG13775@coredump.intra.peff.net>
References: <200906061509.15870.trast@student.ethz.ch> <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch> <20090606221320.GB30064@coredump.intra.peff.net> <2325a7950906070412k3a440558h35db7511cc390e4b@mail.gmail.com> <7vzlck9e3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 14:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDe5R-0000JJ-EF
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 14:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZFHMgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 08:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbZFHMgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 08:36:16 -0400
Received: from peff.net ([208.65.91.99]:43469 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbZFHMgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 08:36:15 -0400
Received: (qmail 21418 invoked by uid 107); 8 Jun 2009 12:36:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Jun 2009 08:36:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 08:36:08 -0400
Content-Disposition: inline
In-Reply-To: <7vzlck9e3j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121070>

On Sun, Jun 07, 2009 at 09:57:04AM -0700, Junio C Hamano wrote:

> > This breaks theoretical usage of custom format string in custom die
> > routines:
> >         1. A custom die routine might not support %s.
> >         2. If the die routine adds a custom format specifier, vsnprintf
> >                 will fail.
> 
> I do not think that flies even as a theory.  The "custom" 39a3f5ea talks
> about is more about "Instead of sending it to stderr, let's pop up an info
> window and give the message there" kind of customization.
> 
> Existing die() that prints errno does so by giving strerror() to "%s", so
> no matter how custom your die routine is, you must support '%s' for its
> output to make sense to humans.  If you "not support %s", then you will
> ignore (or choke at) such strerror() result without this patch anyway.

More than that, you must support arbitrary printf format strings,
because the die routine is passed whatever goes to die() (a quick grep
revealed that we use at least %u and %c at various points). So it is an
undocumented requirement that the die routine process its parameters as
if it were from the printf family.

I think what Thomas posted is fine.

-Peff
