From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Couple of read-tree questions
Date: Thu, 1 Sep 2005 02:16:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509010138370.23242@iabervon.org>
References: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
 <7vll2h4bc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 08:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAiKO-00021M-0u
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 08:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIAGMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 02:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVIAGMd
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 02:12:33 -0400
Received: from iabervon.org ([66.92.72.58]:27399 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965041AbVIAGMc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2005 02:12:32 -0400
Received: (qmail 10135 invoked by uid 1000); 1 Sep 2005 02:16:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Sep 2005 02:16:17 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll2h4bc8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7992>

On Wed, 31 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Is there any current use for read-tree with multiple trees without -m or 
> > equivalent?
> 
> I did not know it even allowed multiple trees without -m, but
> you are right.  It does not seem to complain.
> 
> I have never thought about using multiple trees without -m, and
> I do not remember hearing any plan nor purpose of using it to do
> something interesting from Linus.  I think its allowing multiple
> trees without -m is simply a bug.

I guess it was probably that its behavior was obvious and didn't require 
any extra code. It still follows entirely from one tree without -m, but it 
might be worth prohibiting unless someone has a reason to do it 
intentionally.

> > Why does --emu23 use I+H for stage 2, rather than just I? Wouldn't this 
> > just reintroduce removed files?
> 
> They are not "removed files", at least in the original context.
> 
> The original intention was that git was supposed to work without
> having _any_ files in the working tree.  The reason why
> multi-tree read-tree has so many special cases that says "must
> match *if* work file exists", is that not having a corresponding
> working file was supposed to be equivalent to having the file
> checked out *and* unmodified.

But they'd not only be missing from the working tree but also from the 
(pre-read-tree) index, which should only happen, assuming the index came 
from "read-tree H", if they were subsequently removed from the index. I'd 
understand treating index entries for files missing from the working tree 
as up to date.

(The thread you mention seems to say that we accept entries being missing 
from the index as if they were unchanged, but I don't see a good reason 
for this; you'd be dealing with the full set in the index for the merge, 
even if you don't have a populated working tree)

> I do not think anybody currently uses --emu23.  I did it because
> it has a potential of making the two-tree fast forward (which is
> used in "git checkout" to switch between branches) easier to
> manage when the working tree is dirty than doing straight
> two-tree merge, but that is just a theoretical potential never
> tested in the field.  Frankly, I do not mind, and I do not think
> anybody else minds, too much if you need to break or remove
> emu23 if that would make your code clean-up and redoing
> read-tree easier.

I should have asked sooner, then. :) There's a bunch of clutter to get it 
to work that I can remove if it's not actually necessary.

	-Daniel
*This .sig left intentionally blank*
