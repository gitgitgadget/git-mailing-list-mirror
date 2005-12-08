From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] use "git init-db" in tests
Date: Thu, 8 Dec 2005 21:25:55 +0100
Message-ID: <20051208202555.GA3046@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 21:28:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkSLZ-0005ps-Vv
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 21:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVLHU0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVLHU0X
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 15:26:23 -0500
Received: from devrace.com ([198.63.210.113]:60683 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932344AbVLHU0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 15:26:16 -0500
Received: from tigra.home (p54A0D4D7.dip.t-dialin.net [84.160.212.215])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jB8KPx4h005913;
	Thu, 8 Dec 2005 14:26:00 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EkSKz-0001H3-00; Thu, 08 Dec 2005 21:25:57 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EkSKy-00028P-IK; Thu, 08 Dec 2005 21:25:56 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13372>

Unless there was a special reason to use git-init-db from $PATH, could
the patch below be accepted? It makes the test suite use git-init-db
from the "the binaries we have just built".

The reason, why we need the patch even if the $PATH is set, will be
better explained by glibc's sources: the lookup does not stop if the
file exists but has no execute permission.

See file posix/execvp.c, the loop iterating over elements in $PATH:

          switch (errno)
            {
            case EACCES:
              /* Record the we got a `Permission denied' error.  If we end
                 up finding no executable we can use, we want to diagnose
                 that we did find one but were denied access.  */
              got_eacces = true;
                 ...
              break;
            ...
            }
      ...
      /* We tried every element and none of them worked.  */
      if (got_eacces)
        /* At least one failure was due to permissions, so report that
           error.  */
        __set_errno (EACCES);

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

 By the same reason, the whole testsuite should be reviewed to use 
 "git <command>" notation.

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

4417503d10870c913cff4f635acf274b7da75864
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0539dac..3704e5f 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -190,8 +190,8 @@ test=trash
 rm -fr "$test"
 mkdir "$test"
 cd "$test"
-git-init-db --template=../../templates/blt/ 2>/dev/null ||
-error "cannot run git-init-db"
+git init-db --template=../../templates/blt/ 2>/dev/null ||
+error "cannot run git init-db"
 
 mv .git/hooks .git/hooks-disabled
 
-- 
0.99.9.GIT
