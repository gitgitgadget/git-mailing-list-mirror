From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: allow {--amend|-c foo} when {HEAD|foo} has empty
 message
Date: Tue, 28 Feb 2012 14:59:32 -0500
Message-ID: <20120228195931.GE11260@sigill.intra.peff.net>
References: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch>
 <20120228090540.GB5757@sigill.intra.peff.net>
 <20120228091422.GC5757@sigill.intra.peff.net>
 <87haybco1j.fsf@thomas.inf.ethz.ch>
 <7vr4xe27sq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2TD2-0004mX-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965990Ab2B1T7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:59:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60458
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965145Ab2B1T7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:59:34 -0500
Received: (qmail 14166 invoked by uid 107); 28 Feb 2012 19:59:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 14:59:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 14:59:32 -0500
Content-Disposition: inline
In-Reply-To: <7vr4xe27sq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191779>

On Tue, Feb 28, 2012 at 09:21:09AM -0800, Junio C Hamano wrote:

> Thomas Rast <trast@inf.ethz.ch> writes:
> 
> > So either there's a lot to be fixed, or fsck needs to catch this.
> 
> Your experiment with hash-object aside (that is like saying "I can write
> garbage with a disk editor, and now OS cannot read from that directory"),

Yes, but the difference between "OS cannot read from that directory" and
"OS segfaults" might be worth noticing. :)

> if somebody manages to create a commit without any body, it is clear that
> the user wanted to record no body.  I think all code that tries to run
> strstr("\n\n") and increment the resulting pointer by two to find the
> beginning of the body should behave as if it found one and the result
> pointed at a NUL.  Rejecting with fsck does not help anybody, as it
> happens after the fact.

Yeah, I agree that treating it like an empty body is reasonable
(possibly with a warning). But given that nobody has actually seen this
in the wild, maybe it is simpler to mark it with fsck, and to just die()
when we see it. That would hopefully alert the author of the broken tool
early, before the tools is made public. If it turns out that such
commits do end up in the wild, then we can relax the behavior then.

-Peff
