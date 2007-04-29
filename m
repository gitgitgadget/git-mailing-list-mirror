From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 29 Apr 2007 11:26:49 -0700
Message-ID: <20070429182649.GD12375@untitled>
References: <m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org> <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org> <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <m2irbfqlze.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 20:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiE6w-0000EZ-1v
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030942AbXD2S07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030812AbXD2S07
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:26:59 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35318 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030942AbXD2S05 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:26:57 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1C8AB7DC0A0;
	Sun, 29 Apr 2007 11:26:56 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 29 Apr 2007 11:26:49 -0700
Content-Disposition: inline
In-Reply-To: <m2irbfqlze.fsf@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45827>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Seth Falcon <sethfalcon@gmail.com> writes:
> >> Junio C Hamano <junkio@cox.net> writes:
> >> ...
> >>> Then I suspect the following could be less invasive and more
> >>> efficient fix for the problem.  I do not have an access to MacOS
> >>> box, and I do not have a working sync with any SVN repository,
> >>> so I cannot test it myself, though...
> >>
> >> This also works as a fix for me on OS X and obviously is nicer than
> >> resorting to temp files.  Again, with this patch against git master
> >> the test case that Eric posted passes as does one of my own examples.
> >
> > Well, I think the sysseek should be done only when we did read
> > 'link ' from the beginning and not in other cases, so in that
> > sense my patch is very broken.  Probably the sysseek() needs to
> > be done inside the "if ($fb->mode_b} == 120000)" part, after it
> > checks for 'link '.
> 
> So I can confirm, unfortunately, that the suggested patch is indeed
> very broken and have a couple of corrupt git-svn based repositories to
> show for it -- in other words, I had the opportunity to learn a lesson
> the hard way :-\
> 
> Eric: is there any way to undo some of the svn revs that have been
> retrieved using git-svn fetch and then refetch them?  I naively tried
> out Junio's fix and ran fetch on a few repositories.  The data
> retrieved is bogus in a fun way that things work, but patches have
> been repatched to remove 5 chars, e.g.:
> 
>     -factor <- function (x = character(), levels = sort(unique.default(x),
>     +r <- function (x = character(), levels = sort(unique.default(x),

Assuming you're not using something crazy like noMetadata, you can just
use update-ref on the remote heads to the last known good revisions and
remove the associated .rev_db files.

Otherwise you'll have to delete entries from the .rev_db files, the
format is one line per-revision, the revision is the line number of the
file.

-- 
Eric Wong
