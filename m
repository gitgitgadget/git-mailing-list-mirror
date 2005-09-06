From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multi-ancestor read-tree notes
Date: Tue, 6 Sep 2005 13:43:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509061228090.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
 <7virxeycod.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 19:41:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EChPg-0003QF-Jw
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 19:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVIFRjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 13:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVIFRjO
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 13:39:14 -0400
Received: from iabervon.org ([66.92.72.58]:10248 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750718AbVIFRjN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 13:39:13 -0400
Received: (qmail 31890 invoked by uid 1000); 6 Sep 2005 13:43:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2005 13:43:08 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virxeycod.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8135>

On Mon, 5 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I've got a version of read-tree which accepts multiple ancestors and does 
> > a merge using information from all of them.
> 
> After disabling the debugging printf(), I used this read-tree to
> try resolving the parents of four commits Fredrik Kuivinen gave
> us in <20050827014009.GB18880@c165.ib.student.liu.se> using
> their two merge bases, and compared the resulting tree with the
> tree recorded in the commit.  The results are really promising.
> 
> For the following two commits, multi-base merge resolved their
> parents trivially and produced the same result as the tree in
> the commit.  The current "best-base merge" in the master branch
> performed far worse and left many conflicts.
> 
>  - 467ca22d3371f132ee225a5591a1ed0cd518cb3d 
>  - da28c12089dfcfb8695b6b555cdb8e03dda2b690
> 
> Another one, 0e396ee43e445cb7c215a98da4e76d0ce354d9d7,
> multi-base merge left only one conflicting path to be hand
> resolved.  The best-base merge again performed far worse.
> 
> The other one, 3190186362466658f01b2e354e639378ce07e1a9, is
> resolved trivially with both algorithms.

Do you know if there's anything like case #16 in there? I'd be interested 
to know if there's anything that gets handled automatically in different 
ways depending on which single base is used, and doesn't require manual 
intervention with multiple bases, because that's probably wrong.

> > In case #16, I'm not sure what I should produce. I think the best thing 
> > might be to not leave anything in stage 1.
> 
> Because?  I know it would affect the readers of index files if
> you did so, but it would seem the most natural in git
> architecture to have merge-cache look at the resulting cache
> with such multiple stage 1 entries (and other stages) and let
> the script make a decision.

I didn't want to break the assumption of only one entry per stage in the 
initial version. I'm also not sure that listing the ancestors is 
particularly useful in this case. They have to be exactly the contents of 
stages 2 and 3, plus possibly more stuff that's not been kept by either 
side. What you actually want is a two-way merge (i.e., a diff between the 
two sides, presented in "merge" format), so you don't really need any 
ancestors, unless it would fit some more general case that way.

> > The desired end effect is that the user is given a file with a
> > section like:
> >
> >   {
> >     *t = NULL;
> >     *m = 0;
> > <<<<<<<<
> >     return Z_DATA_ERROR;
> > ========
> >     return Z_OK;
> >>>>>>>>>
> >   }
> 
> Sounds fine.
> 
> Anyway, I really am happy to see this multi-base merge perform
> well on real-world data, and you are certainly the git hero of
> the week ;-).

Great. Want me to send the patches with better organization, or are you 
set with what I've sent?

	-Daniel
*This .sig left intentionally blank*
