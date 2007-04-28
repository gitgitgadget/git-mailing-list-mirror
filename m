From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 15:43:37 -0700
Message-ID: <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
	<m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
	<m2k5vwfbf6.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 00:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhvdq-0006AX-1y
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 00:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031155AbXD1Wnj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 18:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031289AbXD1Wnj
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 18:43:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58834 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031155AbXD1Wni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 18:43:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428224338.NTIE1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 18:43:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id smjc1W00E1kojtg0000000; Sat, 28 Apr 2007 18:43:37 -0400
In-Reply-To: <m2k5vwfbf6.fsf@ziti.fhcrc.org> (Seth Falcon's message of "Sat,
	28 Apr 2007 14:15:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45799>

Seth Falcon <sethfalcon@gmail.com> writes:

> Junio C Hamano <junkio@cox.net> writes:
> ...
>> Then I suspect the following could be less invasive and more
>> efficient fix for the problem.  I do not have an access to MacOS
>> box, and I do not have a working sync with any SVN repository,
>> so I cannot test it myself, though...
>
> This also works as a fix for me on OS X and obviously is nicer than
> resorting to temp files.  Again, with this patch against git master
> the test case that Eric posted passes as does one of my own examples.

Well, I think the sysseek should be done only when we did read
'link ' from the beginning and not in other cases, so in that
sense my patch is very broken.  Probably the sysseek() needs to
be done inside the "if ($fb->mode_b} == 120000)" part, after it
checks for 'link '.

By the way.

I admit I have never given a serious look at the code of
git-svn.perl until now.

It has comparison with 120000 and 100644 all over with ==/!=.
Even though these originally come from parse result of textual
output from ls-tree and diff-tree, and the code never treats
$mode strings as octal integer, I would feel better if the
literals were quoted and comparison done with eq/ne.
