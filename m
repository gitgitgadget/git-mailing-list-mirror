From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 13:29:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161324490.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, barkalow@iabervon.org,
	raa.lkml@gmail.com, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:30:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhlYe-0002rl-Gd
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbXJPM3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757601AbXJPM3t
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:29:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:48631 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757523AbXJPM3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 08:29:48 -0400
Received: (qmail invoked by alias); 16 Oct 2007 12:29:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 16 Oct 2007 14:29:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EKtMKFgZE6t+zCEQYO3dCLXJ/S+d+FXiRq2jPaR
	VsYgvBix9sWSB/
X-X-Sender: gene099@racer.site
In-Reply-To: <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61153>

Hi,

[by explicit request culling make-w32 from the Cc list]

On Tue, 16 Oct 2007, Eli Zaretskii wrote:

> > Date: Tue, 16 Oct 2007 07:14:56 +0200
> > From: Andreas Ericsson <ae@op5.se>
> > CC: Daniel Barkalow <barkalow@iabervon.org>,  raa.lkml@gmail.com, 
> >  Johannes.Schindelin@gmx.de,  tsuna@lrde.epita.fr,  git@vger.kernel.org, 
> >  make-w32@gnu.org
> > 
> > > Sorry I'm asking potentially stupid questions out of ignorance: why
> > > would you want readdir to return `README' when you have `readme'?
> > > 
> > 
> > Because it might have been checked in as README, and since git is case
> > sensitive that is what it'll think should be there when it reads the
> > directories. If it's not, users get to see
> > 
> > 	removed: README
> > 	untracked: readme
> 
> This is a non-issue, then: Windows filesystems are case-preserving, so 
> if `README' became `readme', someone deliberately renamed it, in which 
> case it's okay for git to react as above.

No, it is not.  On FAT filesystems, for example, I experienced Windows 
happily naming a file "head" which was created under then name "HEAD".

This is the single reason why I cannot have non-bare repositories on a USB 
stick.

> > could be an intentional rename, but we don't know for sure.
> 
> It _must_ have been an intentional rename.

No.  It can also be the output of a program which deletes the file first, 
and then (since the filesystem is so "conveniently" case insensitive) 
creates it again, with a lowercase filename.

And don't you tell me that there are no such programs.  I have to use 
them, and they are closed source.

Sigh.

> > To be honest though, there are so many places which do the 
> > readdir+stat that I don't think it'd be worth factoring it out
> 
> Something for Windows users to decide, I guess.  It's not hard to 
> refactor this, it just needs a motivated volunteer.

You?

> > I *think* (correct me if I'm wrong) that git is still faster
> > than a whole bunch of other scm's on windows, but to one who's used to
> > its performance on Linux that waiting several seconds to scan 10k files
> > just feels wrong.
> 
> Unless that 10K is a typo and you really meant 100K, I don't think 10K
> files should take several seconds to scan on Windows.  I just tried
> "find -print" on a directory with 32K files in 4K subdirectories, and
> it took 8 sec elapsed with a hot cache.  So 10K files should take at
> most 2 seconds, even without optimizing file traversal code.  Doing
> the same with native Windows system calls ("dir /s") brings that down
> to 4 seconds for 32K files.

On Linux, I would have hit Control-C already.  Such an operation typically 
takes less than 0.1 seconds.

> On the other hand, what packages have 100K files?

Mozilla, KDE, OpenOffice.org, X.org, ....

Ciao,
Dscho
