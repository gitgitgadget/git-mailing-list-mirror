From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Fri, 1 Apr 2011 17:41:15 -0400
Message-ID: <20110401214115.GA18679@sigill.intra.peff.net>
References: <201103311246.25645.johan@herland.net>
 <20110331190429.GC16981@sigill.intra.peff.net>
 <201104010329.05299.johan@herland.net>
 <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:41:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5m5q-0003j9-RJ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391Ab1DAVlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:41:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44345
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756799Ab1DAVlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 17:41:17 -0400
Received: (qmail 17338 invoked by uid 107); 1 Apr 2011 21:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 17:42:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 17:41:15 -0400
Content-Disposition: inline
In-Reply-To: <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170626>

On Fri, Apr 01, 2011 at 02:39:21PM -0700, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > While pushing to a remote repo, Git transiently adds a .keep file for the
> > pack being pushed, to protect it from a concurrent "git gc". However, the
> > permissions on this .keep file are such that if a different user attempts
> > a local cross-filesystem clone ("git clone --no-hardlinks") on the server
> > while the .keep file is present (either because of a concurrent push, or
> > because of a prior failed push that left a stale .keep file), the clone
> > will fail because the second user cannot access the .keep file created by
> > the first user.
> 
> While I am not sure if letting a clone proceed while there is a concurrent
> push is even a good idea to begin with, I agree that a stale .keep file is
> a problem.
> 
> I am kind of surprised that we are not using atexit(3) to clean them just
> like we do for lockfiles; wouldn't that be a better solution?

We definitely should do that, but it would also be nice if a power
failure, kill -9, or segfault in receive-pack didn't leave a repo
unusable.

-Peff
