From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-merge-recursive, was Re: [ANNOUNCE] Example Cogito Addon -
 cogito-bundle
Date: Sat, 21 Oct 2006 04:03:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
 <200610202047.11291.jnareb@gmail.com> <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
 <45391F1C.80100@utoronto.ca> <Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
 <4539318D.9040004@utoronto.ca> <Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 21 04:03:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb6Cq-0004R3-Se
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 04:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992772AbWJUCDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 22:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992790AbWJUCDV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 22:03:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:19160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S2992772AbWJUCDU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 22:03:20 -0400
Received: (qmail invoked by alias); 21 Oct 2006 02:03:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 21 Oct 2006 04:03:18 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29575>



On Fri, 20 Oct 2006, Linus Torvalds wrote:

> On Fri, 20 Oct 2006, Aaron Bentley wrote:
> > 
> > Agreed.  We start by comparing BASE and OTHER, so all those comparisons
> > are in-memory operations that don't hit disk.  Only for files where BASE
> > and OTHER differ do we even examine the THIS version.
> 
> Git just slurps in all three trees. I actually think that the current 
> merge-recursive.c does it the stupid way (ie it expands all trees 
> recursively, regardless of whether it's needed or not), but I should 
> really check with Dscho, since I had nothing to do with that code.

AFAIR yes, it does the dumb thing, namely it does not take advantage of 
trees being identical when their SHA1s are identical.

This will be a _tremendous_ speed-up.

> > > So recursive basically generates the matrix of similarity for the 
> > > new/deleted files, and tries to match them up, and there you have your 
> > > renames - without ever looking at the history of how you ended up where 
> > > you are.
> > 
> > So in the simple case, you compare unmatched THIS, OTHER and BASE files
> > to find the renames?
> 
> Right. Some cases are easy: if one of the branches only added files (which 
> is relatively common), that obviously cannot be a rename. So you don't 
> even have to compare all possible combinarions - you know you don't have 
> renames from one branch to the other ;)
> 
> But I'm not even the authorative person to explain all the details of the 
> current recursive merge, and I might have missed something. Dscho? 
> Fredrik? Anything you want to add?

Not me. Only that there is much potential for optimization (meaning 
performance, not the basic algorithm).

Ciao,
Dscho
