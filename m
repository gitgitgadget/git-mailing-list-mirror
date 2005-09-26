From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Sun, 25 Sep 2005 17:01:48 -0700
Message-ID: <7v1x3cn1cj.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
	<200509252143.23905.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 02:02:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJgRQ-0005p0-Lo
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 02:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbVIZABy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 20:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVIZABx
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 20:01:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34557 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751567AbVIZABx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 20:01:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926000150.OMAD9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Sep 2005 20:01:50 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9295>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> Does that mean I have missed some step along the way to get the maint branch 
> position moved to the new tag?

To recap, you did:

    (before 0.99.7d propagated to the mirrors)
    $ git clone http://kernel.org/pub/scm/git/git.git git-src
    $ cd git-src

    (after 0.99.7d propagated to the mirrors)
    $ git fetch origin tag v0.99.7d
    $ git checkout -f maint

The 'fetch origin tag v0.99.7d' step should have left
the new file .git/refs/tags/v0.99.7d _after_ downloading all the
objects necessary to reconstruct the history to get there.  

Ah, you are right.  My instruction did not update other branches
for you.  My bad.

Assuming people stay on their "master" branch, and have the
recommended .git/remotes/origin contents in my previous message,
then the steps "after 0.99.7d propagated to the mirrors" would
just be:

    $ git fetch

which would fetch all the branches mentioned in the remotes
file, and then:

    $ git checkout -f maint

which would switch your working tree to maint branch.

NOTE NOTE NOTE.  The above assumes you are on your "master"
branch when you run 'git fetch' --- if you are on any of the
branches that is being updated (you can check which branch you
are on with 'git branch' without argument, or just with 'ls -l
.git/HEAD') 'git fetch' will complain because doing so without
updating them to match the updated branch head would make your
index file and working tree inconsistent with your .git/HEAD,
but 'git fetch' is supposed to be only fetching without touching
the working tree.
