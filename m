From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3] Use struct tree in diff-tree
Date: Tue, 31 Jan 2006 16:49:38 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601311626070.25300@iabervon.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
 <Pine.LNX.4.64.0601291405250.25300@iabervon.org> <Pine.LNX.4.64.0601310846380.7301@g5.osdl.org>
 <7virs0uma8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 22:47:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43LR-0008NO-Id
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWAaVrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWAaVrW
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:47:22 -0500
Received: from iabervon.org ([66.92.72.58]:270 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751542AbWAaVrW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 16:47:22 -0500
Received: (qmail 3062 invoked by uid 1000); 31 Jan 2006 16:49:38 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2006 16:49:38 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virs0uma8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15351>

On Tue, 31 Jan 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Sun, 29 Jan 2006, Daniel Barkalow wrote:
> >>
> >> It had been open-coding a tree parser. This updates the programs that
> >> call diff_tree() to send it the struct tree instead of a buffer and
> >> size.
> >
> > Please don't.
> > ...
> > Junio, please don't apply this.
> >
> > 		Linus
> 
> I haven't, and I won't.  From my gut feeling I did not even
> place it in "pu".  After timing it myself and then looking at
> the code I agree with your analysis.
> 
> The one to git-tar-tree I've already applied, mostly because I
> was not careful enough and especially I did not care enough
> about performance of that program.  On my slow machine the tip
> of kernel before you came back takes 9.2 seconds wallclock as
> opposed to 8.7 seconds to tar up, so the patch degrades the
> performance by about 5%.  Maybe we would want to revert that one
> as well.

Probably a better solution is to move the tree parser from tree-diff.c 
into tree.c, provide a clear API in tree.h, and use that in tar-tree. 
There's definitely no need to have another parser beyond the one 
currently in tree-diff and the struct tree one.

I think I should be able to change the struct tree API slightly to make it 
an iterator instead of a linked list, and get the efficiency benefits of 
the tree-diff parser while still having a nice API.

	-Daniel
*This .sig left intentionally blank*
