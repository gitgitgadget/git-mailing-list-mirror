From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 13:59:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711201336530.32410@iabervon.org>
References: <20071120155922.GA6271@pvv.org> <20071120173350.GA2261MdfPADPa@greensroom.kotnet.org>
 <20071120181932.GA20705@pvv.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:00:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuYKI-0006hs-Ef
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761510AbXKTS7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761444AbXKTS7o
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:59:44 -0500
Received: from iabervon.org ([66.92.72.58]:55271 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863AbXKTS7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:59:43 -0500
Received: (qmail 11258 invoked by uid 1000); 20 Nov 2007 18:59:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 18:59:41 -0000
In-Reply-To: <20071120181932.GA20705@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65567>

On Tue, 20 Nov 2007, Finn Arne Gangstad wrote:

> On Tue, Nov 20, 2007 at 06:33:50PM +0100, Sven Verdoolaege wrote:
> 
> > Just "submodule init" and "submodule update" these submodules and
> > it looks like you would get what you want...
> > 
> > > If I make a branch on submodule71, the branch is made in all submodules &
> > > the supermodule.
> > 
> > ... except this one.
> > It's not clear why you would even want this.
> 
> I'll try to boil this down to the simplest case possible. If
> submodules can do this I'll be really happy :)
> 
> Developer A makes a change in submodule1 and in submodule2
> Developer B makes a change in submodule2 and in submodule3
> 
> A and B don't know about eachother. They send their modifications
> somewhere (push to a shared repository with a well chosen branch name,
> for example), or send a mail "please pull from my repo" to the patch
> queue manager.
> 
> It is absolutely crucial that for each developer, either both their
> modifications go in, or none of them. Git should make picking only
> one of their modifications hard.

This is the case; if developer A changes 2 from 2-O to 2-A, and developer 
B changes 2 from 2-O to 2-B, merging both supermodule commits gets a 
conflict, which requires a merge in submodule 2 before the supermodule 
merge can be committed.

On the other hand, 3-B will sort of enter the history of submodule 3 
without the submodule 2 merge getting done; however, there's no way for 
anybody to find it if it's not referenced by any supermodule commit yet 
and people don't look at the individual histories of submodules.

One thing that might be an issue is that, if developer A of supermodule I 
makes a commit that changes submodule 1 and submodule 2, and developer B 
on supermodule II decides to merge supermodule I's submodule 1, and 
supermodule II also includes submodule 2, but developer B doesn't care 
about it, supermodule II could end up with only half of developer A's 
change.

> Also - it would be very good if the history in the master repo would
> match the history in all developers' repositories (as the
> modifications are merged in by the patch queue manager). I.e. - you
> should see a "gif support" feature branch, see the commits on it, and
> finally the merge.

This is independant of submodule support, and depends on the patch queue 
manager's policy. In some cases, it's desirable to simplify the history of 
the feature branch when it's being merged into the master repo, so that 
the master repo gets an idealized version of the feature branch (i.e., 
bugs introduced early in the development of the branch and fixed later, 
but never affected the master repo, are not introduced in the first place; 
also, the historical accident of the work on the topic being started 
before other features but completed after them can be smoothed over, with 
the resolution of merge conflicts distributed back to the sites where the 
second set of changes was made). If the patch queue manager does this sort 
of thing, the master repo's history will be different from the feature 
branch's history as it appeared to the developers at the time, but the 
feature branch also generally goes away at this point anyway, so it 
doesn't matter too much.

	-Daniel
*This .sig left intentionally blank*
