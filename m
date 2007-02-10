From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 10:00:37 -0800
Message-ID: <7v1wkxki4a.fsf@assigned-by-dhcp.cox.net>
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
	<Pine.LNX.4.64.0702101154130.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:00:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFwWh-00053k-L3
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbXBJSAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbXBJSAk
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:00:40 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53628 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbXBJSAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:00:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210180039.JCWN21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 13:00:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Mu0d1W01J1kojtg0000000; Sat, 10 Feb 2007 13:00:38 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39248>

Nicolas Pitre <nico@cam.org> writes:

> You're making assumption about work flows and using that to justify 
> command implementation flaws.  This is not exactly "user friendly".

I do not necessarily agree that making the command to follow a
BCP workflow is "user unfriendly", but that does not pertain
what I will end up saying in this message, which is to agree
with you.

> But a command that is called "status" should provide a "status" even if 
> the file system is read-only nevertheless.  The index updating business 
> that is done behind the scene is and should be an opportunistic 
> optimization, but it should not prevent status reporting.

Fair enough.  That leaves us two options.

 (0) Do nothing.

 (1) We keep the current "git-status [-v] [-a] [[-i|-o] <paths...>]"
     command line and do the necessary index manipulation
     in-core without writing it out (see git-commit.sh for
     details of what it involves).  

 (2) We drop the support for any command line parameter from
     "git-status", apply my two patches for Marco to
     "git-runstatus", and rename "git-runstatus" to
     "git-status".

If I have to pick between the two, I would probably pick (2).
While (1) would essentially mean doing "git-commit" entirely
in-core without writing the index out until we really make the
commit, which is a good thing in itself in the longer term, it
is out of the question this late in the game for 1.5.0.

And now I think what Linus suggests also make sense -- we could
tweak (2) so that git-runstatus actually writes the refreshed
index out when it finds that it _can_ write it (and drop
subsequent internal refresh).

Now, I am heading out.
