From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 11:31:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601231116550.25300@iabervon.org>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601222104120.25300@iabervon.org> <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 17:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F14Z9-0001P8-No
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 17:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWAWQ3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 11:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWAWQ3J
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 11:29:09 -0500
Received: from iabervon.org ([66.92.72.58]:1805 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751479AbWAWQ3I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2006 11:29:08 -0500
Received: (qmail 18855 invoked by uid 1000); 23 Jan 2006 11:31:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2006 11:31:11 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15085>

On Sun, 22 Jan 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> Switching branches
> >> ------------------
> >> 
> >> Along with the traditional two-way merge by `read-tree -m -u`,
> >> we would need to look at:
> >> 
> >> . `bind` lines in the current `HEAD` commit.
> >> 
> >> . `bind` lines in the commit we are switching to.
> >> 
> >> . subproject binding information in the index file.
> >> 
> >> to make sure we do sensible things.
> >
> > This is one place I think storing the bindings in the commit is awkward. 
> > read-tree deals in trees (hence the name), but will need information from 
> > the commit.
> 
> That's why it is 'along with'.  Dealing with binding information
> can be done between commits and index without bothering tree
> objects.  read-tree would not have to deal with it, and I think
> keeping it that way is probably a good idea.

I think it would be a lot more fragile if switching branches requires 
multiple programs interacting with the index file. If things get 
interrupted after the tree is read but before the bindings are changed, 
the user will probably generate an inconsistant commit or have to deal 
with figuring out what's going on. It is a nice property of the current 
system that the index file never exists under the usual filename without 
being consistant.

> In other words, I think the design so far does not require us to
> touch tree objects at all, and I'd be happy if we do not have to.
>
> One reason I started the bound commit approach was exactly
> because I only needed to muck with commit objects and did not
> have to touch trees and blobs; after trying to implement the
> core level for "gitlink", which I ended up touching quite a lot
> and have abandoned for now.

I think that the same thing that worked with the index file would work for 
minimizing the impact of the changes as far as the code sees. If the 
struct tree parser reported the tree at a path when it found a commit at a 
path, it would work just as if the original tree had used trees (like in 
your proposal).

	-Daniel
*This .sig left intentionally blank*
