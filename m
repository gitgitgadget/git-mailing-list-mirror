From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Tue, 5 Jun 2012 12:23:09 -0400
Message-ID: <20120605162309.GA20915@sigill.intra.peff.net>
References: <4FC7EFB7.4090704@steadfast.net>
 <20120601083537.GA32340@sigill.intra.peff.net>
 <7vtxyv2cft.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Stange <kevin@steadfast.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwXN-0001Dh-3J
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab2FEQXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:23:13 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43918
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab2FEQXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:23:12 -0400
Received: (qmail 21050 invoked by uid 107); 5 Jun 2012 16:23:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 12:23:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 12:23:09 -0400
Content-Disposition: inline
In-Reply-To: <7vtxyv2cft.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199256>

On Fri, Jun 01, 2012 at 10:01:58AM -0700, Junio C Hamano wrote:

> >> Request credentials from the user if none are already defined when a
> >> HTTP 401 is received on a restricted repository.  Then, resubmit the
> >> request and return the final result.
> >> 
> >> This allows all webdav transactions to obtain credentials without having
> >> to individually handle the case in each request.  Having push working
> >> with HTTP auth is needed for a use case I have where storing the
> >> credentials in .netrc or using SSH keys is inappropriate.
> >
> > We already do this at a higher level in http_request, which in turns
> > calls into finish_active_slot. So if we were going to go this route,
> > wouldn't we also want to remove the 401 handling in http_request?
> 
> Wouldn't the higher levels know a lot more about the context this
> request was made, though?  What problem does the patch try to solve?
> Some higher level callers missing the "if we got 401, then reset and
> retry" logic?  Wouldn't it be saner to fix the breakage there?

I don't know that the higher level really has much more context; the URL
is really the only context we use. I think the problem is adequately
solved in http_request; it is simply that the http-push code paths do
not use it. The patch solves that by pushing it to a lower level.

-Peff
