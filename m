From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] imap-send: change msg_data from storing (char *,
 len) to storing strbuf
Date: Thu, 29 Nov 2012 18:43:40 -0500
Message-ID: <20121129234340.GA30107@sigill.intra.peff.net>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
 <1353841721-16269-7-git-send-email-mhagger@alum.mit.edu>
 <7vboegp04x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Nov 30 00:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeDm1-0007IF-8v
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab2K2Xno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 18:43:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996Ab2K2Xnn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 18:43:43 -0500
Received: (qmail 27928 invoked by uid 107); 29 Nov 2012 23:44:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Nov 2012 18:44:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2012 18:43:40 -0500
Content-Disposition: inline
In-Reply-To: <7vboegp04x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210883>

On Thu, Nov 29, 2012 at 01:30:54PM -0800, Junio C Hamano wrote:

> > For some reason, there is a bunch of infrastructure in this file for
> > dealing with IMAP flags, although there is nothing in the code that
> > actually allows any flags to be set.  If there is no plan to add
> > support for flags in the future, a bunch of code could be ripped out
> > and "struct msg_data" could be completely replaced with strbuf.
> 
> Yeah, after all these years we have kept the unused flags field
> there and nobody needed anything out of it.  I am OK with a removal
> if it is done at the very end of the series.

There's a bunch of unused junk in imap-send. The original implementation
copied a bunch of code from isync, a much more full-featured imap
client, and the result ended up way more complex than it needed to be. I
have ripped a few things out over the years when they cause a problem
(e.g., portability of /dev/urandom, conflict over the name "struct
string_list"), but have mostly let it be out of a vague sense that we
might one day want to pull bugfixes from isync upstream.

That has not happened once in the last six years, though, and I would
doubt that a straightforward merge would work after so many years. So
ripping out and refactoring the code in the name of maintainability is
probably a good thing at this point.

-Peff
