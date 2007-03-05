From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Tue, 6 Mar 2007 00:32:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060026340.13683@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <20070302091426.GA2605@diana.vm.bytemark.co.uk> <17896.9631.316001.869157@lisa.zopyra.com>
 <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070302162136.GA9593@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070305072323.GA31169@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.27067.247950.419438@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052014020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.30394.172067.743310@lisa.zopyra.com>
 <Pine.LNX.4.63.0703052143120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17900.36569.805689.922989@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051347490.3998@woody.linux-foundation.org>
 <17900.39124.763603.695942@lisa.zopyra.com>
 <Pine.LNX.4.64.0703051431130.3998@woody.linux-foundation.org>
 <17900.42415.750335.329874@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMfc-000824-43
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbXCEXcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXCEXcb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:32:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:33189 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751913AbXCEXca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:32:30 -0500
Received: (qmail invoked by alias); 05 Mar 2007 23:32:29 -0000
X-Provags-ID: V01U2FsdGVkX1/3M8oykN/3r6Yep+ZBxr62cQYiq3BrazVbXpEFWA
	ZwFccnRerSUOHo
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17900.42415.750335.329874@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41505>

Hi,

On Mon, 5 Mar 2007, Bill Lear wrote:

> On Monday, March 5, 2007 at 14:37:15 (-0800) Linus Torvalds writes:
> >On Mon, 5 Mar 2007, Bill Lear wrote:
> >> I edit sourcefile.c, compile it, then commit it with
> >> N=timestamp(sourcefile.c) on master.  N is <
> >> timestamp(.master/sourcefile.o).  I then switch to branchX.  N is
> >> stored by git for master:sourcefile.c.  No stored timestamp are on
> >> this branch, so the file gets the timestamp it gets on checkout
> >> M=timestamp(sourcefile.c).  I compile the file again, all is well.  I
> >> move back to master branch.  Git stores M as branchX:sourcefile.c Git
> >> checks out the file, and stamps it with N.  I do a make.  No
> >> recompilation happens.
> >
> >WHICH IS WRONG! You need to recompile, since the compile you did on the 
> >other branch DOES NOT MATCH in "sourcefile.c" any more. 
> 
> Well, I'll let it drop after this, but I think you're wrong.  I do NOT
> need it to recompile when I do the third make above.

Bill, maybe you don't want to hear it, but for all those following this 
thread, here is why you are wrong:

"make" does _not_ match the time stamps of xyz.c and xyz.o. After you 
"make", the only thing which is guaranteed is that if xyz.c is _newer_ 
than xyz.o, the compiler is started.

Example:

00:05 you pull upstream into your master branch, which has a newer xzy.c
00:07 you type make. xyz.o is built, because make sees that xyz.c is 
      newer than xyz.o
00:12 you checkout your side branch, xyz.c is updated.
00:13 you type make, and again xzy.o is built, because xyz.c is newer than 
      xyz.o
00:25 you switch back to your master branch.

Now, if your wish would be granted, and xyz.c has the same timestamp as 
before, then it _still_ is older than xyz.o. So make will not rebuild it.

BUT xyz.o is actually compiled from the side branch's version of xyz.c!

Hth,
Dscho
