From: Nicolas Pitre <nico@cam.org>
Subject: Re: Making git disappear when talking about my code (was: Re: GIT vs
 Other: Need argument)
Date: Wed, 25 Apr 2007 14:07:23 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704251341280.12375@xanadu.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl>
 <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl>
 <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
 <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net>
 <87vefm7l6g.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
 <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <87mz0w7g3j.wl%cworth@cworth.org>
 <87k5w07dft.wl%cworth@cworth.org>
 <alpine.LFD.0.98.0704250751330.9964@woody.linux-foundation.org>
 <87fy6o770w.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 20:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hglu0-0005yC-BV
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 20:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423358AbXDYSHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 14:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161865AbXDYSHc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 14:07:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12278 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161808AbXDYSHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 14:07:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH200KHIFOB9F00@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Apr 2007 14:07:24 -0400 (EDT)
In-reply-to: <87fy6o770w.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45539>

On Wed, 25 Apr 2007, Carl Worth wrote:

> And I'd even follow that up to propose making "git checkout branch"
> (where branch doesn't exist but remote/<something>/branch does), do
> something new, (not detached head, nor creating a local tracking
> branch), that would allow the following:
> 
> 1. Using "git checkout branch" to examine the working-tree status of a
>    branch.
> 
> 	This functionality exists already, but with a fairly obnoxious
> 	detached head warning.

With all the safeties (reflogs, etc) this warning could be toned down 
even more now.

> 2. Subsequently using "git pull" to track that remote branch
> 
> 	This functionality is currently missing without creating a
> 	local branch first. This is an inconvenience compared to the
> 	pre-separate-remotes git where "git checkout next" followed by
> 	a sequence of "git pull" was enough to track a branch.
> 
> 	Now, old git also had the huge defect that it was too easy to
> 	screw everything up by committing to what should have been
> 	treated as a read-only tracking branch, which is where the
> 	next point comes in.
> 
> 3. Allow a commit from this state, by *then* creating the explicit
>    local branch setup to track the remote-tracking branch.
> 
> 	That is, under this proposal the command sequence of:
> 
> 		git checkout branch
> 		# hack
> 		git commit
> 
> 	Would get one to the exact same state as today's sequence of:
> 
> 		git branch --track branch origin/branch
> 		git checkout branch
> 		# hack
> 		git commit
> 
> 	Which to me just looks like making git easier to use.

I don't feel comfortable with that.

To me it looks like Git would perform some hardcoded magic without 
helping the user understanding what is going on.  Worse: it can perform 
all those operations even if that is not what you wanted.

I much prefer multiple simple commands that perform basic and 
understandable operations than a single complex one with more magic in 
it.  If it was just me I'd eliminate the pull command and a pull would 
always be a fetch followed by a merge...

I understand your desire for people to get at your code as quickly and 
easy as possible, but that conflicts with our desire for people to 
really understand the basics of Git.  Creating magic commands with 
hardcoded defaults for a one-click-does-all behavior isn't helping 
that understanding at all.

If you really want people to get at your code with no Git consideration 
what so ever, then just direct them at the corresponding gitweb and/or 
git-archive invocations with --remote=<repo> to store a local copy.

> 	Of course, git could complain politely if the branch name it
> 	wanted to create were taken already and instruct the user how
> 	to create a new name for the tracking branch before the
> 	commit.
> 
> Is that a totally insane idea? (The answer might very well depend on
> some details of the implementation---presumably .git/HEAD would have
> to store both the name of the remote-tracking branch as well as the
> sha1 to which it corresponded at the time of the checkout.)

And why again isn't detached head just fine for your usage scenario 
instead? Only the "obnoxious" warning?


Nicolas
