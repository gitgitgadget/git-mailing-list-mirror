From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect gives strange answer
Date: Sun, 07 Aug 2005 10:06:19 -0700
Message-ID: <7vvf2hy8vo.fsf@assigned-by-dhcp.cox.net>
References: <20050804192838.GB26714@mars.ravnborg.org>
	<E1E14Hj-0001Nt-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 19:07:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1obe-0001fB-E5
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 19:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbVHGRGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 13:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbVHGRGV
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 13:06:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55715 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752369AbVHGRGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 13:06:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807170620.QFWH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 13:06:20 -0400
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
In-Reply-To: <E1E14Hj-0001Nt-00@skye.ra.phy.cam.ac.uk> (Sanjoy Mahajan's
	message of "Fri, 05 Aug 2005 16:38:59 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk> writes:

> I will redo those tests but rebuilding in place after each bisection
> (with -f added to all the git checkout uses in git-bisect-script) and
> see whether I get the same results.  If I don't, it could be due to
> git or git-bisect (but not so likely with the -f switch) or to the
> build system.  Will keep you and Junio posted.

I thought the lack of '-f' was a plausible explanation, but here
is what I just did.  The same bisect sequence in your example,
making sure the state of working tree matches what the commit
being tested:

    $ git bisect start
    $ git bisect good 17af691cd19765b782d891fc50c1568d0f1276b3
    $ git bisect bad c101f3136cc98a003d0d16be6fab7d0d950581a6
    Bisecting: 42 revisions left to test after this
    $ cat .git/HEAD
    b2f571026594884e7a2a3f8bc6ad5c92e0703330
    $ git bisect good; cat .git/HEAD; git-diff-cache -r bisect
    Bisecting: 30 revisions left to test after this
    450008b5a62bb09445ae05c4d01d510386c9435d
    $ git bisect good; cat .git/HEAD; git-diff-cache -r bisect
    Bisecting: 15 revisions left to test after this
    a9df3597fec5472d0840fbfdc2a3fac5268f7d08
    $ git bisect bad; cat .git/HEAD; git-diff-cache -r bisect
    Bisecting: 8 revisions left to test after this
    28e8c3ad9464de54a632f00ab3df88fa5f4652d1
    $ git bisect bad; cat .git/HEAD; git-diff-cache -r bisect
    Bisecting: 4 revisions left to test after this
    c774e93e2152d0be2612739418689e6e6400f4eb
    $ git bisect bad; cat .git/HEAD; git-diff-cache -r bisect
    Bisecting: 2 revisions left to test after this
    b4634484815e1879512a23e4f59eef648135c30a

So it does not appear to me that lack of '-f' is a problem.
Without the flag, checkout does "read-tree -m -u" which means to
update the working tree to match the new tree being read (this
includes the removal of files from the working tree that were
registered in the original index file that are not in the next
tree).
