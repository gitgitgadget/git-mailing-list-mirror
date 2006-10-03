From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multiple checkouts of the same repository
Date: Mon, 2 Oct 2006 22:52:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610022234330.9789@iabervon.org>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com> 
 <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de> 
 <3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com> 
 <Pine.LNX.4.63.0610012116310.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <3bbc18d20610011404x52d8ba15ib51ac2a7060bd25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 04:52:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUaOa-0004Jv-Hp
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 04:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWJCCwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 22:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWJCCwd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 22:52:33 -0400
Received: from iabervon.org ([66.92.72.58]:46609 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030256AbWJCCwc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 22:52:32 -0400
Received: (qmail 18915 invoked by uid 1000); 2 Oct 2006 22:52:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Oct 2006 22:52:31 -0400
To: Matt McCutchen <hashproduct+git@gmail.com>
In-Reply-To: <3bbc18d20610011404x52d8ba15ib51ac2a7060bd25e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28242>

On Sun, 1 Oct 2006, Matt McCutchen wrote:

> On 10/1/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > The fact is, your setup is fragile, and I think that is hard to fix if you
> > do not make A and B git repositories in their own right.
> 
> I think my setup is much simpler than having two separate repositories
> that update each other using hooks.  What can go wrong, besides the
> scenario I mentioned where one working tree doesn't get updated when I
> commit through the other one?

It works fine, so long as you never modify in A the head that's checked 
out in B; if you do this, git will be very confused, because it doesn't 
record in the index what commit the index comes from. I did this for a 
while, but eventually switched to just having a single branch checked out 
at a time. (The other thing is that you probably want to have the 
non-symlinked repository be bare, i.e., not checked out, and have multiple 
sets of symlinks to its parts, so if you decide to discard a working 
directory, you don't accidentally delete the one with the repository 
actually in it.)

At one point, I was arguing for storing the information of what commits 
were the starting point of the current index in the index itself, instead 
of relying on external files and external links to refs, but I wasn't 
really working on git enough to argue for it effectively. Among other 
things, it would allow git to know what's going on if the head changes 
without the index getting updated. (Of course, all of the cases it 
supports are really ones where git should just tell you that you've done 
something wrong, because you can't really do non-linear work in a single 
head sensibly, because there's only one ref for the head, which can't jump 
sideways from the commit that's been pulled or generated elsewhere to the 
commit that's being generated from the index; if the head doesn't match 
the commit the index is from, there is no alternative to a 
merge-before-commit, which is frowned upon in the git world as a way of 
losing your recent work. This is why I couldn't convince people very 
well.)

	-Daniel
*This .sig left intentionally blank*
