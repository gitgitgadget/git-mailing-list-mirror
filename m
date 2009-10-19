From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 21:16:46 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910182045580.14365@iabervon.org>
References: <20091018144158.GA9789@gandalf.dynalias.org> <alpine.LNX.2.00.0910181727130.32515@iabervon.org> <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Mon Oct 19 03:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzgrl-0008M9-Lo
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 03:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZJSBQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 21:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZJSBQm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 21:16:42 -0400
Received: from iabervon.org ([66.92.72.58]:38111 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbZJSBQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 21:16:42 -0400
Received: (qmail 17586 invoked by uid 1000); 19 Oct 2009 01:16:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Oct 2009 01:16:46 -0000
In-Reply-To: <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130634>

On Mon, 19 Oct 2009, Norbert Preining wrote:

> Hi all,
> 
> thanks everyone for the nice feedback!
> 
> On So, 18 Okt 2009, Daniel Barkalow wrote:
> > It's possible as long as you don't think of the "version number" as a 
> > property of the commit, but rather a property that some commits get by 
> > virtue of having been at some time the commit that's what would be found 
> > on that particular server at that particular time. Even though the history 
> 
> Right! That is a good point. In fact I don't care about (local) commits,
> but about the pushes to the central server.
> 
> > of the *content* is non-linear, the sequence of values stored in 
> > refs/heads/master on your central server is linear, local, and easy to 
> > enumerate.
> 
> That is exactely what I need.
> 
> > Of course, when someone does a bunch of development in parallel with other 
> > people, does a final merge, and pushes it back to the server, this only 
> > increases the version by one, and only the final merge actually has a 
> 
> As it is now with svn, we have to live with that. The point is that we
> still would see many different commits pushed to the server, so 
> git log would show the single items, but the "versioning sequence number"
> is only increased by one. That would be *absolutely*perfect* for me!
> 
> > because the intermediate commits don't ever get packages created of them 
> > to need to be compared to other packages.
> 
> Right!
> 
> Now my follow-up questions:
> - how would one access this "sequence" number on the server

There isn't currently anything built in that counts up like that; however, 
it shouldn't be too hard to add something, because the reflog gets an 
entry at the same times the sequence number would increase. In fact, you 
could disable pruning the reflog, and use its length (in lines), except 
that would get slow and git doesn't expect you to care about the complete 
history there (in fact, you only care about the amount of history past 
some point).

> - is there a way to determine at which of this "sequence" numbers a specific
>   file has been changed last?

There isn't a built-in way, but you can find the current hash for a 
filename with "git ls-tree -r <branch> <filename>", and find the hash as 
of N changes ago with "git ls-tree -r <branch>@{<N>} <filename>". You're 
looking for the smallest N where they don't match. (And you probably 
don't want to be a binary search or the like, because that might miss that 
a file was most recently affected by having a change reverted; you'd want 
to be sure to report the version that reverted the change, not the version 
that introduced the content the later one returned to.

	-Daniel
*This .sig left intentionally blank*
