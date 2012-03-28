From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 15:40:45 -0400
Message-ID: <20120328194045.GC29019@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <7v62dowpdu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyjl-00017O-A2
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab2C1Tks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:40:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36282
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259Ab2C1Tkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:40:47 -0400
Received: (qmail 20633 invoked by uid 107); 28 Mar 2012 19:41:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 15:41:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 15:40:45 -0400
Content-Disposition: inline
In-Reply-To: <7v62dowpdu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194173>

On Wed, Mar 28, 2012 at 11:29:17AM -0700, Junio C Hamano wrote:

> > That sounds sensible to me. I think it involves writing our own
> > execvp, though, right? If we use stock execvp, we can't tell the
> > difference between the two cases.
> 
> The stock exec*p() will not hit "/bin/ls" in either case, so we will give
> "'ls' is not a git command", without having to differenciate it.  That is
> what I meant by "we follow the usual rule to ignore it".
> 
> We already have the code necessary to enumerate the possible commands from
> components of the PATH in order to give suggestion, so we can run it
> after seeing exec*p() failure to see if we did not see any "ls", or we saw
> "ls" but it was not executable.  No need to penalize the normal case, no?

Yes, we can differentiate after the fact. Though I think it ends up
being almost the same code as just implementing execvp in the first
place.

-Peff
