From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] Introduce die_errno() that appends
	strerror(errno) to die()
Date: Tue, 9 Jun 2009 04:53:28 -0400
Message-ID: <20090609085328.GA25721@coredump.intra.peff.net>
References: <cover.1244299302.git.trast@student.ethz.ch> <5f43aa9d0b69e99600a73bddd4c93217608ab661.1244494647.git.trast@student.ethz.ch> <20090608220713.GB29942@sigill.intra.peff.net> <200906091022.31738.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDx5h-00045l-QM
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672AbZFIIxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 04:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758553AbZFIIxg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:53:36 -0400
Received: from peff.net ([208.65.91.99]:40750 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbZFIIxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 04:53:35 -0400
Received: (qmail 26881 invoked by uid 107); 9 Jun 2009 08:53:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Jun 2009 04:53:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jun 2009 04:53:28 -0400
Content-Disposition: inline
In-Reply-To: <200906091022.31738.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121158>

On Tue, Jun 09, 2009 at 10:22:30AM +0200, Thomas Rast wrote:

> > Aren't you assuming that strerror(errno) has no '%'-signs here, which is
> > what kicked off the whole discussion?
> 
> True, of course.  Hrm.
> 
> So do we go back to v2 (for 1/3) and ask future callers to never use
> custom formats with die_errno, or should I write a version that
> doubles the % characters while tacking the error message onto the
> format?

Personally, I think it is fine to assume that the format and arguments
to die(), die_errno(), and to the die_routine() are all
printf-compatible. That is how it has always been until now, and I don't
see any callers who would want to change that.

This is all internal to git.  It's not as if we are talking about a
library being called by arbitrary code, and we want to leave doors open
for arbitrary clients. libgit2 would probably take a different approach
(though I imagine their general strategy is never to die(), but to
always return an error condition, anyway).

> [It's a pity that it seems impossible to add an extra argument to the
> va_args...]

Agreed, but I think we are out of luck short of variadic macros (which
are a C99-ism, and even then have some issues).

-Peff
