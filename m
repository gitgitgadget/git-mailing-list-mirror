From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] t5710: fix two thinkos.
Date: Thu, 31 Aug 2006 17:07:08 -0700
Message-ID: <7vmz9k78lv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri Sep 01 02:06:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIwXx-00054i-Pk
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 02:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWIAAGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 20:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWIAAGE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 20:06:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40950 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932494AbWIAAGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 20:06:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901000601.LTAZ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Thu, 31 Aug 2006 20:06:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Go611V00R1kojtg0000000
	Thu, 31 Aug 2006 20:06:01 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26292>

The intention of the test seems to be to build a long chain of
clones that locally borrow objects from their parents and see the
system give up dereferencing long chains.  There were two problems:

 (1) it did not test the right repository;
 (2) it did not build a chain long enough to trigger the limitation.

I do not think it is a good test to make sure the limitation the
current implementation happens to have still exists, but that is
a topic at a totally different level.

At least this fixes the broken test.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Spotted this after the fix to git-fsck-objects by Linus not
   to require a valid HEAD.

 t/t5710-info-alternate.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 2e1b48a..b9f6d96 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -58,6 +58,8 @@ test_expect_failure 'creating too deep n
 git clone -l -s D E &&
 git clone -l -s E F &&
 git clone -l -s F G &&
+git clone -l -s G H &&
+cd H &&
 test_valid_repo'
 
 cd "$base_dir"
-- 
1.4.2.g2782
