From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: fix possible null pointer access
Date: Fri, 4 Dec 2015 18:32:55 -0500
Message-ID: <20151204233255.GD15064@sigill.intra.peff.net>
References: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
 <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
 <46311B14CC814F54AC34764F2520947A@PhilipOakley>
 <xmqq610ete8x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Stefan Naewe <stefan.naewe@gmail.com>, git@vger.kernel.org,
	Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:33:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4zqY-0000Vh-Kn
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 00:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbbLDXc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 18:32:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:37616 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755356AbbLDXc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 18:32:58 -0500
Received: (qmail 13004 invoked by uid 102); 4 Dec 2015 23:32:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 17:32:58 -0600
Received: (qmail 30356 invoked by uid 107); 4 Dec 2015 23:33:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 18:33:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 18:32:55 -0500
Content-Disposition: inline
In-Reply-To: <xmqq610ete8x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282019>

On Fri, Dec 04, 2015 at 07:39:10AM -0800, Junio C Hamano wrote:

> > But you can't do that computation (in the error case under
> > consideration). Null can't be added to anything (as far as the
> > implications of the standards go). These are horrid gotchas because
> > they go against the grain of all that binary arithmetic and
> > simplifications we learnt long ago.
> 
> Yeah, but in that hunk that does check !tree, because the function
> can be fed a NULL, the computed result assigned to object, which is
> undefined, is never used ;-)
> 
> Of course, there used to be exotic platforms that are still standard
> compliant that triggered a trap when such a pointer computation was
> made (rather, such a bogus pointer was assigned to a pointer
> variable).  I do not think anybody attempted to port Git to such a
> platform, but I agree that it is better to "fix" such a codepath, if
> only to stop wasting time dealing with them discussing with language
> lawyers ;-)

FWIW, I'd worry much more about compilers which do aggressive
optimizations based on language-lawyering (e.g., removing the null-check
as dead code, which is legal according to the standard because after you
computed the pointer based on it, it's all undefined behavior).

I don't think that changes your conclusion, though:

> So as I said in my review, the first hunk is a reject, the second
> one is OK.

-Peff
