From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 19:31:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510311916150.25300@iabervon.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com>
 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 01:32:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWk4V-0007aJ-Gg
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVKAAcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVKAAcM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:32:12 -0500
Received: from iabervon.org ([66.92.72.58]:23813 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964928AbVKAAcL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 19:32:11 -0500
Received: (qmail 23827 invoked by uid 1000); 31 Oct 2005 19:31:50 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 19:31:50 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051031224246.GP11488@ca-server1.us.oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10909>

On Mon, 31 Oct 2005, Joel Becker wrote:

> 	So, I have a git repository that is my For-Linus repository.
> It's got a clean history.  What's my workflow?
> 
> 	1) Clone the repo to a Work tree.
> 	2) Create and test fix X, with perhaps some >1 number of commits.
> 	3) Bring that fix back to the For-Linus repository.
> 
> 	This is a small change.  It's not something that needs stepS, as
> you put them.  But my history in the Work tree is "dirty," so I cannot
> just pull from Work to For-Linus.
> 	As the tools currently stand, I need to hand-diff and patch my
> commits.  Neither git nor cogito have a command to do this first-class
> "the way you should do it" common operation. 

I actually have a set of scripts that I use for this, which I've been too 
lame to clean up properly and send in. The basic idea is:

 (1) "git branch clean mainline"
 (2) "git checkout clean"
      (now I'm looking at the clean history, which doesn't have anything 
       yet)
 (3) "git refine dirty"
      (this says I'm trying to match the content of the head with the 
       dirty history)
 (4) editor window pops up with the diff between the working tree and 
      dirty
 (5) edit the patch, removing hunks which go later in the series, or which 
      I don't want to do at all and forgot to revert.
 (6) it applies the patch; if there are rejects, it goes back to (4)
 (7) normal thing for committing happens
 (8) if there is any difference between the working tree and dirty, it 
      goes back to (4) for the next in the series

I still need to correct the flow control and make it invoke the editor 
automatically and such, and provide some way out of the middle if you want 
to give up or stop without reaching the end, and I have to detect the done 
condition. But the general method does work, provided you're at least 
somewhat comfortable editing patches (with the safety net that nobody else 
will ever see the patch, so it doesn't matter too much if you screw it 
up).

If somebody else wants to clean this up, I can post my version; dunno when 
I'll get around to making it really right.

	-Daniel
*This .sig left intentionally blank*
