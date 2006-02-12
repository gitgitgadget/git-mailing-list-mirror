From: Junio C Hamano <junkio@cox.net>
Subject: ***DONTUSE*** Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 05:46:14 -0800
Message-ID: <7virrkbsgp.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virrli9am.fsf@assigned-by-dhcp.cox.net>
	<87accwlt8k.fsf@mid.deneb.enyo.de>
	<7vlkwgdbk6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 12 14:46:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8HYR-0006cu-Pw
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 14:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWBLNqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 08:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWBLNqR
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 08:46:17 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58008 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751055AbWBLNqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 08:46:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212134447.RKKU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 08:44:47 -0500
To: git@vger.kernel.org
In-Reply-To: <7vlkwgdbk6.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 12 Feb 2006 04:08:25 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15996>

I've pushed things out to "master" and "next" branch.

Quite a lot of things.

One thing that I expected to be there is not.  It is the
hashtable patch.  It is in "pu".

I once had it in my private "next", but dropped it before
pushing things out.

The problem does not seem to trigger with casual use, but I
found that with a clone from my primary repository with '-l -s'
(that is, a clone that uses alternates mechanism to borrow from
my primary repository), fsck-objects built with the patch seems
to report bogus things "missing".  I have not traced it fully;
instead I ended up spending most of the night (I noticed it at
around 01:30 and now it is 05:30 so that's about four hours)
recovering some of my refs and double checking if my primary
repository is not corrupt X-<.  At least, the primary repository
looks sane now.

With luck, I would muster enough energy to figure it out, but I
need some sleep first.

The problem seems to be very elusive.  I took a snapshot of the
two repositories involved, so that I can use them as an isolated
test case (the one is my primary repository and the other one is
the "-l -s" clone). The problem is repeatable, but the SHA1 of
the file the broken fsck-objects reports to be missing is
different from the one I observed in the first experiment with
the real repositories.  It appears it has something to do with
the directory listing order of fsck-objects, which in turn means
the reproduction of the problem is related to memory allocation
patterns, so maybe valgrind would help.  On the other hand, even
if I published a tarball of these two repositories somewhere,
other people (or myself) who extract the tarball would probably
not see the same SHA1 reported as missing X-<.

Anyway, I've pushed them out before crashing, after I double
checked that versions built from my "master" and "next" do not
seem to show the problem, while with the one in "pu", the first
patch after merging "next" in it being the said patch, exhibits
the problem.
