From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 29 Apr 2007 11:31:36 -0700
Message-ID: <20070429183136.GE12375@untitled>
References: <20070414201003.GA28389@muzzle> <m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org> <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org> <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 20:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiEBj-000255-TA
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030812AbXD2Sbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031001AbXD2Sbo
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:31:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35328 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030812AbXD2Sbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:31:43 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4D4DF7DC0A0;
	Sun, 29 Apr 2007 11:31:42 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 29 Apr 2007 11:31:36 -0700
Content-Disposition: inline
In-Reply-To: <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45828>

Alexander: please don't drop me from the Cc next time, thanks.

Junio C Hamano <junkio@cox.net> wrote:
> Seth Falcon <sethfalcon@gmail.com> writes:
> > Junio C Hamano <junkio@cox.net> writes:
> > ...
> >> Then I suspect the following could be less invasive and more
> >> efficient fix for the problem.  I do not have an access to MacOS
> >> box, and I do not have a working sync with any SVN repository,
> >> so I cannot test it myself, though...
> >
> > This also works as a fix for me on OS X and obviously is nicer than
> > resorting to temp files.  Again, with this patch against git master
> > the test case that Eric posted passes as does one of my own examples.
> 
> Well, I think the sysseek should be done only when we did read
> 'link ' from the beginning and not in other cases, so in that
> sense my patch is very broken.  Probably the sysseek() needs to
> be done inside the "if ($fb->mode_b} == 120000)" part, after it
> checks for 'link '.

Yes, don't add the new sysseek there.  All the reads and seeks in that
block of code should probably be sysreads and sysseeks instead.  Feel
free to patch and test this as I don't have time at the moment.

> By the way.
> 
> I admit I have never given a serious look at the code of
> git-svn.perl until now.
> 
> It has comparison with 120000 and 100644 all over with ==/!=.
> Even though these originally come from parse result of textual
> output from ls-tree and diff-tree, and the code never treats
> $mode strings as octal integer, I would feel better if the
> literals were quoted and comparison done with eq/ne.

It works either way as stringifying those would be unambiguous,
although I understand strings can be considered better style...
Feel free to change this.

-- 
Eric Wong
