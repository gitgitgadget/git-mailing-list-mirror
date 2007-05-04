From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 13:10:57 +0200
Message-ID: <20070504111057.GI4489@pasky.or.cz>
References: <loom.20070502T111026-882@post.gmane.org> <20070503010312.GF4489@pasky.or.cz> <200705040242.46156.jnareb@gmail.com> <200705040921.33443.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 04 13:11:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjvgo-0008Aa-Cc
	for gcvg-git@gmane.org; Fri, 04 May 2007 13:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767468AbXEDLLC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 07:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767494AbXEDLLB
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:11:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48427 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767468AbXEDLK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 07:10:59 -0400
Received: (qmail 31959 invoked by uid 2001); 4 May 2007 13:10:57 +0200
Content-Disposition: inline
In-Reply-To: <200705040921.33443.johan@herland.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46166>

On Fri, May 04, 2007 at 09:21:29AM CEST, Johan Herland wrote:
> On Friday 04 May 2007, Jakub Narebski wrote:
> > Besides I think it would be better to teach blame to ignore reversion
> > commits (for example based on first line of commit message) than to
> > mess with the history.
> 
> I'm starting to see a pattern where people would like to tell git about 
> more complicated relationships between commits, so that git can make 
> more intelligent decisions when doing merge, blame, pickaxe, etc.
> 
> Adding these relationships as part of the commit message seems like a 
> really stupid idea because git suddenly has to make sense of something 
> it has never parsed before, thus making all future and former git 
> commit messages a potential target for pattern (mis)matching by git. 
> Also, we seem to forget that we already have the perfect place to put 
> such information: The header fields preceding the commit message.
> 
> I therefore propose adding header field names to commit objects that 
> illustrate the relationships people want to tell git about.

  So I've looked it up, and the Linus' writeup on this is at

	http://news.gmane.org/find-root.php?message_id=<Pine.LNX.4.64.0604250758000.3701@g5.osdl.org>

> 1. "Reverts": Mark a commit as reverting another commit. This could be 
> used by git-log to cancel out pairs of commits, resulting in a cleaner 
> view of history. It can help blame/annotate. There are probably other 
> tools that can benefit from this information also.

  Actually I think git-log is the one tool which shouldn't cancel it
out. The number of reverts likely won't be overwhelming and reverting is
actually pretty important event - it says "this has been tried and we
decided it's not the way", also can have social meanings etc. It is an
important piece of history. And people still want to actually see the
change and possibly revive it. BTW, imagine their confusion if the
history looks like

	1abcd5 Feature X
	37efab Release 2.3.1
	724b9c Revert feature X

and git log would cancel out 1abcd5 and 724b9c. Feature X is part of
2.3.1 but not in the log..?!

  The point is that the reverting/reverted commit pairs don't affect
your current content (except maybe in an highly abstract way), and this
is why pickaxe and blame should skip it (by default).

  The question wrt. Linus' criteria is if "it has enough of a meaning",
and I wonder about that too. I think it does, though.


  For the other suggested headers, it should be already mostly obvious
from Linus' writeup why they shouldn't qualify, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
