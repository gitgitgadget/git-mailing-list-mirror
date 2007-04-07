From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/5] merge-recursive D/F conflict improvements
Date: Sat, 07 Apr 2007 07:39:21 -0700
Message-ID: <7vd52gckpy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaC4t-0003py-SI
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965888AbXDGOjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965898AbXDGOjX
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:39:23 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55737 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965888AbXDGOjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:39:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407143922.QQNY24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:39:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEfM1W00K1kojtg0000000; Sat, 07 Apr 2007 10:39:22 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43966>

This series is on top of my "read-tree-df" topic, which is in
'next'.

The part that are already in 'next' deal with switching branches
when the current branch has a file (or symlink) where the
switched-to branch has a directory (or vice versa), and is about
fixing "git-read-tree -m -u A B" 2-way merges.

This series deals with both "git-read-tree -m u O A B" 3-way
merges, and "git-merge-recursive".  It comes with tests, but
because these two programs are really central part of everyday
branch growing (the other important part is the revision walking
machinery which is obviously the central part of archaeology), I
would really need help from people who have worked in this area
for extra sets of eyeballs.

[PATCH 1/5]
t1000: fix case table.

	This one is immaterial; while working on 2/5, I wondered
	why threeway_merge() did not handle case #10, and tried
	to fix it by adding a case.  Obviously it broke existing
	tests and I recalled that contrary to the case table
	presented there, we decided that "stays in one side
	while the other side removes" case could be a sign of
	the path being renamed away and let the caller deal with
	it.  So this patch fixes the case table to match the
	design and the code.

[PATCH 2/5]
Treat D/F conflict entry more carefully in unpack-trees.c::threeway_merge()

[PATCH 3/5]
merge-recursive: do not barf on "to be removed" entries.

[PATCH 4/5]
merge-recursive: handle D/F conflict case more carefully.

[PATCH 5/5]
t3030: merge-recursive backend test.
