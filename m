From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 12:14:35 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251149030.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0901251916010.14855@racer> <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
 <alpine.DEB.1.00.0901252016590.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn O Pearce <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBOx-0005XK-LI
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbZAYUOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZAYUOv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:14:51 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:37337 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbZAYUOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:14:50 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0PKEaP1015679;
	Sun, 25 Jan 2009 12:14:36 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0PKEZ0g015676;
	Sun, 25 Jan 2009 12:14:35 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0901252016590.14855@racer>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107091>

On Sun, 25 Jan 2009, Johannes Schindelin wrote:

> What about my scripts I have here locally?  Do you want to change them, 
> too?

Someone who already wrote local scripts probably won't use the diff.primer 
feature, or if he does, he'll be thoughtful about the consequences and modify 
his scripts.  diff.primer has no effect unless you use it.  It is totally 
personal.

> > I fact, by introducing the cpp macro DIFF_MACHINE_FRIENDLY() and the 
> > command-line options "--machine-friendly" and "--no-primer", I made such 
> > protection declarative.  Don't you find it preferable that existing programs 
> > and scripts would explicitly declare their desire for machine-friendly 
> > output?

> No.  We made a promise long time ago that plumbing (and "git diff" is 
> pretty much plumbing, except for the configurable colorness) would not 
> change behind scripts' backs.
> 
> And since Shawn uses plumbing for that very reason, your diff.primer patch 
> would not be allowed to make a difference.  Ever.

I fixed up every single place where gitk and git-gui internally call diff.  
Before I ever got there, Shawn already protected himself by passing --no-color 
to "git diff" (git-gui/lib/diff.tcl line 279).  My changes are in a good spirit 
because they enhance the declarativeness and explicitness of the code.  I added 
meaningful information.

> Now, if you would have changed only the UI diff things (i.e. git diff, but 
> not git diff-files), I could have accepted the diff.primer patch for 
> different applications than "git gui", but from cursory reading of your 
> patch it does not appear so.
> 
> Speaking of appearance (or for that matter, explaining why it was only a 
> cursory reading): did it not occur to you that your coding style is 
> utterly different from the surrounding code?
> 
> Just to number a few things that would definitely prohibit this patch from 
> being applied:
> 
> - space instead of tabs,
> - horrible lengths of spaces within the line,
> - no space after if, but after the parenthesis.

You are right, I should mimic the existing conventions.  If we reach consensus 
about the functionality of the patch, I would be happy to redo all the white 
space to match what's already there.  In case you are curious, I put whitespace 
in lines in the name of readability, to make tokens line up with each other.  
Again, it is right to mimic local convention and I have no problem making that 
revision.

> Besides, it seems you did a lot of "fixes" on the side that I do not like at 
> all.  Simple example: if the original code cleared the DIRSTAT_CUMULATIVE 
> flag, it is not acceptable for you to introduce an unnecessary if(), testing 
> if the CUMULATIVE flag was set to begin with.

I appreciate that you noticed this little detail.  You are extremely thorough 
and I take your criticism very seriously.  The reason for that little if() is 
that, with the enhanced declarativeness of the code in diff.h, calling the cpp 
macro DIFF_OPT_SET() is now more meaningful that just flipping a bit.  It is now 
the equivalent of saying "I intend to set this bit, and I want my intention 
recorded and honored later."  The purpose of the piece of code where I 
introduced the if() is only to setup the right defaults, not to declare user 
intention.  Therefore, IOW, if the default is already in place, do nothing.

c is only one of many languages I write.  Designers of newer languages emphasize 
meangingfulness, explicitness, declarativeness of code, e.g. the DRY principle, 
etc.  c is very flexible, so it does not prevent us from following these 
beneficial practices in c.  After all, the first c++ compilers simply emitted c 
and then called a c compiler, right?

With thanks,
Keith
