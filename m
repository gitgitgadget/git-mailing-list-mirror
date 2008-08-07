From: Jeff King <peff@peff.net>
Subject: Re: git blame and cherry-picking
Date: Thu, 7 Aug 2008 14:49:29 -0400
Message-ID: <20080807184929.GA11691@sigill.intra.peff.net>
References: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com> <20080807060940.GA15405@blimp.local> <20080807182256.GF11314@sigill.intra.peff.net> <AA6BDC98-8800-4031-8C8F-A4BD326BEC1E@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:50:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRAZO-00072S-Oz
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 20:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394AbYHGStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbYHGStb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 14:49:31 -0400
Received: from peff.net ([208.65.91.99]:4068 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938AbYHGSta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 14:49:30 -0400
Received: (qmail 15574 invoked by uid 111); 7 Aug 2008 18:49:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 07 Aug 2008 14:49:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Aug 2008 14:49:29 -0400
Content-Disposition: inline
In-Reply-To: <AA6BDC98-8800-4031-8C8F-A4BD326BEC1E@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91597>

On Thu, Aug 07, 2008 at 11:37:02AM -0700, Steven Grimm wrote:

> No, of course not. But one might want to show the original commit's  
> author instead of the name of the person who did the cherry pick. That's 
> mostly what I'm looking for here; knowing where the change originally came 
> from in terms of the revision graph is occasionally interesting but not 
> nearly as important.

OK. I think that is a cherry-pick -n issue, then, as you mention below.

> One could argue that the real issue here is that while "git cherry-pick" 
> preserves the original author and doesn't have the misattribution problem, 
> "git cherry-pick -n" discards the original commit's attribution (though it 
> does keep the commit message). Obviously git doesn't necessarily know 
> whether the cherry-picker made substantial changes before committing and 
> should truly be considered the author, but one of the use cases for the 
> "-n" option is a simple "make sure you don't commit totally broken 
> revisions" where there is little to no additional editing of the patch and 
> keeping the original author would support that use case better.

I don't think it would be hard to stuff the cherry-picked commit's info
somewhere and to pull it out during git-commit. git-am and git-rebase -i
are already doing something similar. The harder question is what should
be done with multiple "git cherry-pick -n" invocations with different
authors?

I haven't looked closely at the git-sequencer stuff, but I wonder if
some of this will come with it for free. My impression is that the
prototype is built on _top_ of cherry-pick, but that the C version will
not be, and that cherry-pick can then be implemented in terms of the
sequencer.

-Peff
