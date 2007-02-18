From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 17:20:43 -0800
Message-ID: <7vhctkp8gk.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<Pine.LNX.4.63.0702180105000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64a0qpa8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180151060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIajP-0002Fo-US
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbXBRBUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbXBRBUp
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:20:45 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56130 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030272AbXBRBUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:20:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218012043.DFHN1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 20:20:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QpLj1W0011kojtg0000000; Sat, 17 Feb 2007 20:20:43 -0500
In-Reply-To: <Pine.LNX.4.63.0702180151060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 01:53:52 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40047>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And I use git-apply to apply patches way more often than "patch" these 
> days. And I _think_ that it is a feature that it does not cd-up before 
> trying to apply the stuff. In git.git, I cannot think of a reasonable use 
> case for applying something not relative-to-root, but I had that use case 
> in some other (git-tracked) project.
>
> So my vote is to leave the cwd where it is in git-apply.

I strongly disagree from my recent day-job experience.  I was
feeding some changes to my co-worker's repository from my
uncommitted changes (because it was incomplete but the part
needed to unstuck him was ready).  The day job project is much
deeper than git.git, and the changes were to two files in a
directory somewhat deep.

So I went there and said "git apply --index P.diff", which
applied cleanly.  But the other "git apply --index Q.diff"
didn't.

So naturally I said:

	$ git apply --reject Q.diff
        error: filfre/frotz/nitfol.c: No such file or directory

I ended up editing filfre/frotz/ out of Q.diff in his editor.
Explaining why P.diff and Q.diff, both of which were about the
files in the same dirrectly, behaved differently was not pretty
to git uninitiated.

Leaving --index case and working-tree-only case inconsistent is
bad.  We really should fix it (I really wish I found it out
before 1.5.0 went out).
