From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 22:41:57 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910182140440.14365@iabervon.org>
References: <20091018144158.GA9789@gandalf.dynalias.org> <alpine.LNX.2.00.0910181727130.32515@iabervon.org> <20091019004447.GC11739@gamma.logic.tuwien.ac.at> <alpine.LNX.2.00.0910182045580.14365@iabervon.org>
 <20091019013320.GD17397@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Mon Oct 19 04:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MziCC-00006t-Nf
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 04:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbZJSCly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 22:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755473AbZJSClx
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 22:41:53 -0400
Received: from iabervon.org ([66.92.72.58]:45161 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440AbZJSClx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 22:41:53 -0400
Received: (qmail 23513 invoked by uid 1000); 19 Oct 2009 02:41:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Oct 2009 02:41:57 -0000
In-Reply-To: <20091019013320.GD17397@gamma.logic.tuwien.ac.at>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130638>

On Mon, 19 Oct 2009, Norbert Preining wrote:

> Hi Daniel,
> 
> On So, 18 Okt 2009, Daniel Barkalow wrote:
> > > - how would one access this "sequence" number on the server
> > 
> > There isn't currently anything built in that counts up like that; however, 
> > it shouldn't be too hard to add something, because the reflog gets an 
> > entry at the same times the sequence number would increase. In fact, you 
> 
> Ok.
> 
> > > - is there a way to determine at which of this "sequence" numbers a specific
> > >   file has been changed last?
> > 
> > There isn't a built-in way, but you can find the current hash for a 
> > filename with "git ls-tree -r <branch> <filename>", and find the hash as 
> > of N changes ago with "git ls-tree -r <branch>@{<N>} <filename>". You're 
> > looking for the smallest N where they don't match. (And you probably 
> > don't want to be a binary search or the like, because that might miss that 
> 
> That sounds like we cannot use that, because we have to do that for about
> 80k files and that on each (at least daily) rebuilt. That is not feasable.

It's likely to be much more efficient (and maybe sufficiently efficient) 
to do them all in a single pass. In fact, it should be easy enough to keep 
a cache of the latest numbers for the files, and update that to change the 
value for those files that differ between the old commit and the new 
commit in the post-update hook.

	-Daniel
*This .sig left intentionally blank*
