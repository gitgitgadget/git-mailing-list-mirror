From: Jeff King <peff@peff.net>
Subject: Re: Interleaved remote branch update problems
Date: Thu, 5 Apr 2012 20:37:10 -0400
Message-ID: <20120406003710.GC14224@sigill.intra.peff.net>
References: <201204051549.14397.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxB4-00017z-TC
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 02:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2DFAhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 20:37:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49407
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab2DFAhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 20:37:14 -0400
Received: (qmail 29354 invoked by uid 107); 6 Apr 2012 00:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 20:37:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 20:37:10 -0400
Content-Disposition: inline
In-Reply-To: <201204051549.14397.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194826>

On Thu, Apr 05, 2012 at 03:49:14PM -0600, Martin Fick wrote:

> I have noticed that git push --force does not reliably force 
> a push to remote branches.  In particular, it will not 
> update a remote branch if that branch has been updated since 
> the beginning of the push.  Is this normal, is this 
> expected?

Yes, that's expected. --force means "it's OK to push something that will
rewind history", not "it's OK to clobber somebody else who is pushing at
the same time". The determination for the former happens on the client
side, and for the latter on the server side.

If you want the latter, you would need a protocol extension, I think;
I'm pretty sure the client doesn't transmit the force flag at all to the
server (and I don't think this should be tied to the force flag
automatically; they are two different cases, and you may be in a
situation where it is safe to do the former but not necessarily the
latter).

-Peff
