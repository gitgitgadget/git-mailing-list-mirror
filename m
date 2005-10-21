From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I clear the directory cache
Date: Thu, 20 Oct 2005 21:09:30 -0700
Message-ID: <7vmzl34ikl.fsf@assigned-by-dhcp.cox.net>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
	<20051020085931.GW30889@pasky.or.cz>
	<2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 06:09:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESoDn-0005nX-PB
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 06:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVJUEJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 00:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVJUEJd
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 00:09:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8936 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750877AbVJUEJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 00:09:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021040857.GOCZ24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 00:08:57 -0400
To: eschvoca <eschvoca@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10415>

eschvoca <eschvoca@gmail.com> writes:

> Yes, ... is what I want (how do I do this with pure git?).

How do you do *what* with pure git is something not clear to me,
so let me try to rephrase you and see if I understood what you
want correctly, in pure git terms:

 0. Your last commit (.git/HEAD), your index file (.git/index)
    and the files in your working tree are in sync to begin
    with.

 1. Then you do random changes in the working tree (add, modify,
    remove) and do git-update-index on them without making a
    commit.  If your index file is fully in sync with your
    working tree, git-diff-files would say nothing after this.
    If you did git-update-index on some but not all, then
    git-diff-files would report unrecorded changes.

 2. But you want to revert these changes to the index file.  By
    "clearing the directory cache", you mean you want the index
    file to have what it had in step 0, but you want to keep
    what is on the filesystem intact.

If that is what you want, then:

	$ git-read-tree HEAD
        $ git-update-index --refresh >/dev/null

would reset the index to the tree recorded in your last commit.
You can see that

	$ git diff --name-status --cached HEAD

does not report any difference between HEAD and your index, while

	$ git diff --name-status

shows the differences between your index and your working tree.

HOWEVER, the index file does not record "intent to add", so you
would not see files you added in step 1. mentioned in the output
of the last command.
