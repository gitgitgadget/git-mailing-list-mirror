From: Nicolas Pitre <nico@cam.org>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 15:29:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701131503110.2577@xanadu.home>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <7virfct737.fsf@assigned-by-dhcp.cox.net>
 <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
 <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
 <20070112210403.GB6262@xp.machine.xx>
 <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <87y7o6x60w.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0701131340040.2577@xanadu.home>
 <87wt3qwwm0.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 21:30:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5pVp-0001wD-7n
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 21:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbXAMU37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 15:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbXAMU37
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 15:29:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50375 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422786AbXAMU36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 15:29:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBT0022NQ9XY380@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 13 Jan 2007 15:29:57 -0500 (EST)
In-reply-to: <87wt3qwwm0.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36769>

On Sat, 13 Jan 2007, Carl Worth wrote:

> On Sat, 13 Jan 2007 13:54:20 -0500 (EST), Nicolas Pitre wrote:
> > The fact is that there is no strong reason why they shouldn't.  But
> > there are good reasons why they should.  The most important one being
> > that the user doesn't need to bother deciding which one of the two
> > commands should be used in any given situation.  And because a single
> > command can cover two _technically_ different cases transparently is a
> > pretty good reason for not imposing this technical issue to the user.
> 
> But that same reasoning could be extended to say there shouldn't be
> separate "add" and "rm", because a single command can transparently
> cover these two technically different cases transparently, (that would
> be update-index without --add and --remove safety checks). But nobody
> has been proposing that that would be a good direction to go.

If nobody has been proposing that then it must not be a good direction 
to go indeed.  This is however not the case for 'add' handling both new 
and existing files which I believe most people like.

> So there are at least three cases one could identify for updating
> content into the index:
> 
> 1. Adding content for a path that didn't previously exist in the index
> 
> 2. Updating content for a path that does already exist in the index
> 
> 3. Removing a path and its content from the index
> 
> As things stand currently, git's providing a first-class operation
> ("git add") that provides (1) and (2) and another operation ("git rm")
> for (3).
> 
> However, "commit -a" is implicitly performing operations from (2) and
> (3).
> 
> So the documentation of "commit -a" being implemented with "add" just
> plain doesn't make sense---and this is causing confusion.

OK if that is what your grip is about let's fix the documentation then.

> I'd love to see _something_ get accepted to resolve that
> confusion. What I was proposing was a command that did (1) and another
> that did (2) or (3), (and "commit -a" could then be documented as
> using this command).

No. The command set is sane.  Many people like it, and it does the work 
fine already, better than it used to.

You don't fix bad documentation by suiting the command set to it.  
You fix the bad documentation instead.

So what about this:

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index cb081cd..96917d4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -32,7 +32,7 @@ methods:
 
 4. by using the -a switch with the 'commit' command to automatically "add"
    changes from all known files i.e. files that have already been committed
-   before, and perform the actual commit.
+   before, and/or "rm" missing known files, then perform the actual commit.
 
 The gitlink:git-status[1] command can be used to obtain a
 summary of what is included by any of the above for the next

Nicolas
