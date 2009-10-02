From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: make all test files executable
Date: Fri, 2 Oct 2009 04:39:46 -0400
Message-ID: <20091002083946.GA8627@coredump.intra.peff.net>
References: <4AC55E78.7010109@mailservices.uwaterloo.ca>
 <20091002080134.GD27664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Fri Oct 02 10:42:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtdgI-0004ey-HQ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 10:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273AbZJBIjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 04:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755592AbZJBIjv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 04:39:51 -0400
Received: from peff.net ([208.65.91.99]:33369 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbZJBIjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 04:39:49 -0400
Received: (qmail 26722 invoked by uid 107); 2 Oct 2009 08:43:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Oct 2009 04:43:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2009 04:39:46 -0400
Content-Disposition: inline
In-Reply-To: <20091002080134.GD27664@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129432>

On Fri, Oct 02, 2009 at 04:01:34AM -0400, Jeff King wrote:

> >  0 files changed, 0 insertions(+), 0 deletions(-)
> >  mode change 100644 => 100755 t/t5531-deep-submodule-push.sh
> >  mode change 100644 => 100755 t/t9501-gitweb-standalone-http-status.sh
> > 
> > diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> > old mode 100644
> > new mode 100755
> > diff --git a/t/t9501-gitweb-standalone-http-status.sh
> > b/t/t9501-gitweb-standalone-http-status.sh
> > old mode 100644
> > new mode 100755
> 
> When applying via "am", I only got the first change in my tree. I'll see
> if I can confirm and make a test case.

Ah, nevermind. The problem is that your patch was word-wrapped, making
the second "diff --git" line bogus. It would have been nice to have it
print a warning instead of silently ignoring that bit of the patch.

I'm not sure if it is a good idea, though. git-apply sees that the "diff
--git" line is there but can't get a filename from it. Which _should_
cause it to barf when we get to the mode lines. But we first see the
wrapped filename and consider that patch section to be over (and the
mode lines just become cruft at the end of the patch, which we must
ignore).

And we must consider that patch section to be over when we see random
text, because we need to jump back to the outer parser looking for more
hunks. We could warn about a "diff --git" line that has no actual
changes associated with it, though that is certainly a user-visible
change. I also suspect it wouldn't help if there was a mode change
followed by some actual content changes.

Hmph.

-Peff
