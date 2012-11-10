From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sat, 10 Nov 2012 17:08:11 -0500
Message-ID: <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
References: <20121109192336.GA9401@sigill.intra.peff.net> <87a9uq5tql.fsf@Niukka.kon.iki.fi> <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us> <871ug15k5c.fsf@Niukka.kon.iki.fi> (sfid-20121110_143603_791021_9FCF0770)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:08:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXJE2-0000F8-Mh
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 23:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab2KJWIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 17:08:13 -0500
Received: from colo.foxharp.net ([166.84.7.52]:37844 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab2KJWIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 17:08:12 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id 8F8D0540E4;
	Sat, 10 Nov 2012 17:05:19 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 406)
	id DC6A42E8B68; Sat, 10 Nov 2012 17:08:11 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id DB6FB2E8985;
	Sat, 10 Nov 2012 17:08:11 -0500 (EST)
In-reply-to: <871ug15k5c.fsf@Niukka.kon.iki.fi> (sfid-20121110_143603_791021_9FCF0770)
Content-ID: <23518.1352585291.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209310>

kalle olavi niemitalo wrote:
 > Paul Fox <pgf@foxharp.boston.ma.us> writes:
 > 
 > > when i implemented the change, i wondered if some twisted emacs
 > > workflow would be an issue. ;-)  and i almost blocked SIGQUIT as
 > > well -- the two programs i looked at for precedent (CVS and MH) both
 > > block both SIGQUIT and SIGINT when spawning an editor.
 > >
 > > but since emacs users must have dealt with CVS for a long time before
 > > dealing with git, how might they have done so?
 > 
 > I think I usually ran CVS via vc.el, which prompts for a commit
 > message in Emacs before it runs cvs commit.  So CVS did not need
 > to run $EDITOR.
 > 
 > I just tried emacsclient with CVS 1.12.13-MirDebian-9, and it
 > behaves somewhat differently from Git with pf/editor-ignore-sigint.
 > When I tell Emacs to send SIGINT to the *Shell* buffer, CVS prompts:
 > 
 > cvs commit: warning: editor session failed
 > 
 > Log message unchanged or not specified
 > a)bort, c)ontinue, e)dit, !)reuse this message unchanged for remaining dirs
 > Action: (continue) 

you're sending SIGINT to the cvs commit command, and that causes the
editor to die right away?  that's surprising.  i can replicate your
described behavior by setting $VISUAL to a script that just sleeps, and
sending SIGTERM to the cvs commit process.  but not by sending SIGINT.

well, i'm not sure what to say.  there's a real problem when using the
current code and traditional editors.  i thought that the patch in
pf/editor-ignore-sigint reflected standard practice, and indeed it
accomplishes exactly the right thing with those editors.  you've shown
a particular work flow involving emacsclient that won't work anymore
with the change made, though there are workarounds.  perhaps there's
something the other editors themselves should be doing differently,
but i don't know what that might be.

paul

 > 
 > and then I can choose to abort.
 > 
 > With strace, it looks like CVS sets SIG_IGN as the handler of
 > SIGINT and SIGQUIT only in the parent process after forking, not
 > in the child process that executes the editor.
 > 
 > CVS also temporarily blocks signals by calling sigprocmask, but
 > it undoes that before it forks or waits for the child process.

=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 45.5 degrees)
