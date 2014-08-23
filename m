From: Jeff King <peff@peff.net>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Sat, 23 Aug 2014 01:46:46 -0400
Message-ID: <20140823054646.GA18256@peff.net>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com>
 <20140822154151.GK20185@google.com>
 <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
 <20140822184515.GL20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 07:47:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL4AA-0001rt-Fg
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbaHWFqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:46:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:57266 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752199AbaHWFqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:46:48 -0400
Received: (qmail 14729 invoked by uid 102); 23 Aug 2014 05:46:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:46:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:46:46 -0400
Content-Disposition: inline
In-Reply-To: <20140822184515.GL20185@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255734>

On Fri, Aug 22, 2014 at 11:45:15AM -0700, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> >                implication of which is that the 'at least one slash'
> > rule was to expect things are 'refs/<anything>' so there will be at
> > least one.  Even back then, that <anything> alone had at least one
> > slash (e.g. heads/master), but the intention was *never* that we
> > would forbid <anything> that does not have a slash by feeding
> > <anything> part alone to check-ref-format, i.e. things like
> > "refs/stash" were designed to be allowed.
> 
> Now I'm more confused.  Until 5f7b202a (2008-01-01), there was a
> comment
> 
> 		if (level < 2)
> 			return -2; /* at least of form "heads/blah" */
> 
> and that behavior has been preserved since the beginning.
> 
> Why do most old callers pass a string that doesn't start with refs/
> (e.g., see the callers in 03feddd6, 2005-10-13)?  Has the intent been
> to relax the requirement since then?

Yeah, this weird "do not allow refs/foo" behavior has continually
confused me. Coincidentally I just noticed a case today where
"pack-refs" treats "refs/foo" specially for no good reason:

  http://thread.gmane.org/gmane.comp.version-control.git/255729

After much head scratching over the years, I am of the opinion that
nobody every really _meant_ to prevent "refs/foo", and that code
comments like the one you quote above were an attempt to document
existing buggy behavior that was really trying to differentiate "HEAD"
from "refs/*". That's just my opinion, though. :) I'd be happy if all of
the special-treatment of "refs/foo" went away and check_refname_format
always got the full ref.

-Peff
