From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] grep: let grep_buffer callers specify a binary flag
Date: Wed, 1 Feb 2012 19:52:09 -0500
Message-ID: <20120202005209.GA6883@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RskuP-0005VA-Vf
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab2BBAwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 19:52:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52557
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab2BBAwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 19:52:13 -0500
Received: (qmail 15289 invoked by uid 107); 2 Feb 2012 00:59:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 19:59:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 19:52:09 -0500
Content-Disposition: inline
In-Reply-To: <7vhaza12ol.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189565>

On Wed, Feb 01, 2012 at 04:47:38PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The caller of grep_buffer may have extra information about
> > whether a buffer is binary or not (e.g., from configuration).
> > Let's give them a chance to pass along that information and
> > override our binary auto-detection.
> 
> Hrm, I would have expected a patch that turns "const char *name" into a
> structure that has name and drv as its members, so that later we can tell
> the function more about the nature of the contents. Or a separate pointer
> to drv in place of your "binary" flag word.

Hmm. Yeah, I would be OK with that, as it's really encapsulating the
idea of "stuff we want to tell grep about this buffer".

What I really didn't want to do was pass the userdiff driver directly,
as that feels way too much like an implementation detail (and while it
can be used to avoid further lookups, it doesn't seem to make a
difference in practice -- see the following patch). And passing it
around became a big messy chore.

But if it were a "struct grep_context" that encapsulated those things, I
think it would be much nicer (it could even carry a pointer to "struct
grep_opt" in it, making the code _more_ pleasant to read, not less).

I'll take a look at re-working it that way.

-Peff
