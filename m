From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 21:35:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 03:35:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgvL0-0003F8-2a
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 03:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVK2CfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 21:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVK2CfM
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 21:35:12 -0500
Received: from iabervon.org ([66.92.72.58]:2310 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932337AbVK2CfK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 21:35:10 -0500
Received: (qmail 3859 invoked by uid 1000); 28 Nov 2005 21:35:39 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2005 21:35:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12914>

On Mon, 28 Nov 2005, Linus Torvalds wrote:

> On Mon, 28 Nov 2005, Daniel Barkalow wrote:
> > 
> > We really ought to keep track of what the current checked out tree is, 
> > independant of the head that it's supposed to match. Then it would be safe 
> > to push to a head that's checked out (it wouldn't update it, but the 
> > system would understand what's going on).
> 
> Well, that's what branches are all about. 
> 
> You really have two choices:
>  - do it all yourself
>  - use git branches
> 
> but if you use a special git branch for the checked-out state, then you 
> have to realize that nobody can push directly to it.

The idea is to have something which is private, to match the working tree, 
which is obviously private (because it doesn't even exist from the point 
of view of the database). Of course, you don't want most of the branch 
mechanism, with HEAD pointing to a file, because when you commit, you want 
to update something else, and when you check out, you want to check out 
something else. You want to use a normal git branch, but still have git 
keep track of what it thinks should be in your working tree, regardless of 
what the branch you're on does, so that checkout doesn't get confused if 
somebody's pushed to the branch you're on.

Then, if someone pushes to a branch that's checked out, git doesn't lose 
track of what it put in the working tree, so it can handle the "git 
checkout" that you do afterwards to update the working tree. Making 
everything work okay if multiple "git checkout"s happen at the same time 
is future work, and will definitely involve locking.

	-Daniel
*This .sig left intentionally blank*
