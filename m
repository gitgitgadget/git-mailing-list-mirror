From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 12:03:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702101154130.1757@xanadu.home>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
 <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
 <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 18:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFvdl-0001H8-Mj
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 18:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXBJRDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXBJRDy
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 12:03:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24266 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXBJRDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 12:03:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD900M5EBEGDDC0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Feb 2007 12:03:53 -0500 (EST)
In-reply-to: <7vmz3mj6yo.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39243>

On Sat, 10 Feb 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Sat, 10 Feb 2007, Junio C Hamano wrote:
> >
> >> Nicolas Pitre <nico@cam.org> writes:
> >> ...
> >> > Because git-status itself is conceptually a read-only operation, and 
> >> > having it barf on a read-only file system is justifiably a bug.
> >> 
> >> I do not 100% agree that it is conceptually a read-only operation.
> >
> > It is.  It's the technical issue that makes it not so.
> 
> I do not think so.  It is a workflow issue that user indicates
> the cache cleanliness information does not matter anymore.

You're making assumption about work flows and using that to justify 
command implementation flaws.  This is not exactly "user friendly".

> Is it wrong for "git-status" to be losing the cache cleanliness
> information?  The intended audience of that program is those who
> are about to make a commit in the repository, as they are asking
> "what would I be committing?"  Up to that point, they may have
> cared about the reminder they get from "git diff" that they
> edited a file and then ended up reverting the whole edit they
> did to that file (I find that empty diff from "git diff" often
> very useful, although I felt "Huh?"  when I was new to git).
> But when they ask "git status", they care more about the real
> change, and at that point (since they feel they may be ready to
> make a commit -- and that is the whole point of running
> "git-status") they do want to lose the cache cleanliness
> information.

I don't dispute that.  But git-status should certainly not be restricted 
_only_ to that usage pattern.

> So "git-status" to be read-write application to
> discard the cache-cleanliness information is probably a good
> thing.

It is... when the file system lets you write.  Like I said this is a 
technically good thing to do.

But a command that is called "status" should provide a "status" even if 
the file system is read-only nevertheless.  The index updating business 
that is done behind the scene is and should be an opportunistic 
optimization, but it should not prevent status reporting.

It is pretty expected that a "commit" command would fail if the file 
system is ro, but not a "status" command.  And this is true 
irrespectively of whatever workflow you might be most likely to use the 
"status" command for.


Nicolas
