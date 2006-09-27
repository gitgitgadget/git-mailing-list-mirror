From: Jeff King <peff@peff.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 01:52:16 -0400
Message-ID: <20060927055216.GA28490@coredump.intra.peff.net>
References: <20060926233321.GA17084@coredump.intra.peff.net> <20060927002745.15344.qmail@web51005.mail.yahoo.com> <20060927033459.GA27622@coredump.intra.peff.net> <BAYC1-PASMTP0819E6B1CBE028BD171598AE1A0@CEZ.ICE> <7v3badkj4k.fsf@assigned-by-dhcp.cox.net> <20060927010437.5fa57ed0.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 07:52:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSSLL-0001db-Hn
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965339AbWI0FwT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbWI0FwT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:52:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:9370 "HELO
	peff.net") by vger.kernel.org with SMTP id S965339AbWI0FwS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 01:52:18 -0400
Received: (qmail 17888 invoked from network); 27 Sep 2006 01:52:16 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Sep 2006 01:52:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2006 01:52:16 -0400
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060927010437.5fa57ed0.seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27877>

On Wed, Sep 27, 2006 at 01:04:37AM -0400, Sean wrote:

> Well, yes.  And all of my examples have assumed the example of
> Linus' repository where there is only one branch.  So yes, in the
> case where there are more than one branch, you want to be able
> to ask the more specific question, when did this commit arrive
> into this repo-branch.

Yes, that is what I was trying to point out by making the branch/repo
distinction in my previous mail.

> If we do agree on that point, then the rest is just the details
> of how plausible it is to provide those answers.   Shawn has made
> it clear that the reflog doesn't really have all the information
> we need yet.  On top of which it would be expensive to compute
> etc.

We should be able to make a naive space-time tradeoff: whenever a ref is
updated from X to Y at time T, for each commit C in X..Y, mark the tuple
(ref, C) with time T. Assuming a reasonably packed format (20 bytes of
SHA1, 4 bytes of time, sorted into .git/time-cache/master) the git
repository would require less than 1M per branch. Updating the ref
becomes much more expensive, but looking up the value is quite cheap.

Of course, rewinding would make this more complicated. I'm still not
convinced this approach is worth the effort.

-Peff
