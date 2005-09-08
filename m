From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] A new merge algorithm, take 3
Date: Thu, 8 Sep 2005 11:27:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509081101471.23242@iabervon.org>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0509071409470.23242@iabervon.org> <20050908060651.GA22734@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Sep 08 17:25:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDOFY-0008MH-UH
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 17:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVIHPXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 11:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIHPXi
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 11:23:38 -0400
Received: from iabervon.org ([66.92.72.58]:26131 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932649AbVIHPXh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 11:23:37 -0400
Received: (qmail 9990 invoked by uid 1000); 8 Sep 2005 11:27:35 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Sep 2005 11:27:35 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050908060651.GA22734@c165.ib.student.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8201>

On Thu, 8 Sep 2005, Fredrik Kuivinen wrote:

> On Wed, Sep 07, 2005 at 02:33:42PM -0400, Daniel Barkalow wrote:
> > On Wed, 7 Sep 2005, Fredrik Kuivinen wrote:
> > 
> > > Of the 500 merge commits that currently exists in the kernel
> > > repository 19 produces non-clean merges with git-merge-script. The
> > > four merge cases listed in
> > > <20050827014009.GB18880@c165.ib.student.liu.se> are cleanly merged by
> > > git-merge-script. Every merge commit which is cleanly merged by
> > > git-resolve-script is also cleanly merged by git-merge-script,
> > > furthermore the results are identical. There are currently two merges
> > > in the kernel repository which are not cleanly merged by
> > > git-resolve-script but are cleanly merged by git-merge-script.
> > 
> > If you use my read-tree and change git-resolve-script to pass all of the 
> > ancestors to it, how does it do? I expect you'll still be slightly ahead, 
> > because we don't (yet) have content merge with multiple ancestors. You 
> > should also check the merge that Tony Luck reported, which undid a revert, 
> > as well as the one that Len Brown reported around the same time which had 
> > similar problems. I think maintainer trees are a much better test for a 
> > merge algorithm, because the kernel repository is relatively linear, while 
> > maintainers tend more to merge things back and forth.
> 
> Junio tested some of the multiple common ancestor cases with your
> version of read-tree and reported his results in
> <7virxeycod.fsf@assigned-by-dhcp.cox.net>.

Oh, right. I'm clearly not paying enough attention here.

> The two cases my algorithm merges cleanly and git-resolve-script do
> not merge cleanly are 0e396ee43e445cb7c215a98da4e76d0ce354d9d7 and
> 0c168775709faa74c1b87f1e61046e0c51ade7f3. Both of them have two common
> ancestors. The second one have, as far as I know, not been tested with
> your read-tree.

Okay, I'll have to check whether the result I get seems right. I take it 
your result agrees with what the users actually produced by hand?

> The merge cases reported by Tony Luck and Len Brown are both cleanly
> merged by my code.

Do they come out correctly? Both of those have cases which cannot be 
decided correctly with only the ancestor trees, due to one branch 
reverting a patch that was only in one ancestor. The correct result is to 
revert that patch, but figuring out that requires looking at more trees. I 
think your algorithm should work for this case, but it would be good to 
have verification. (IIRC, Len got the correct result while Tony got the 
wrong result and then corrected it later.)

> You are probably right about the maintainer trees. I should have a
> look at some of them. Do you know any specific repositories with
> interesting merge cases?

Not especially, except that I would guess that people who have reported 
hitting bad cases would be more likely to have other interesting merges in 
their trees. You might also try merging maintainer trees with each other, 
since it's relatively likely that there would be complicating overlap that 
only doesn't cause confusion because things get rearranged in -mm. For 
that matter, I bet you'd get plenty of test cases out of trying to 
replicate -mm as a git tree.

	-Daniel
*This .sig left intentionally blank*
