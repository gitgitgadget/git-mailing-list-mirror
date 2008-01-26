From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] t9400-git-cvsserver-server: Wrap setup into test case
Date: Sat, 26 Jan 2008 10:54:05 +0100
Message-ID: <12013412461111-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 10:54:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIhkI-0004HJ-7y
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 10:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYAZJyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 04:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbYAZJyK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 04:54:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:34312 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbYAZJyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 04:54:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0Q9s7cG002560
	for <git@vger.kernel.org>; Sat, 26 Jan 2008 10:54:07 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0Q9s6Zv008160;
	Sat, 26 Jan 2008 10:54:06 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71770>

The prefer to have the test setup in a test case.  The setup
itself may fail and having it as a test case handles this
situation gracefully.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t9400-git-cvsserver-server.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 641303e..1f2749e 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -33,13 +33,14 @@ CVS_SERVER=git-cvsserver
 export CVSROOT CVS_SERVER
 
 rm -rf "$CVSWORK" "$SERVERDIR"
-echo >empty &&
+test_expect_success 'setup' '
+  echo >empty &&
   git add empty &&
   git commit -q -m "First Commit" &&
   git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
-  GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
-  exit 1
+  GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log"
+'
 
 # note that cvs doesn't accept absolute pathnames
 # as argument to co -d
-- 
1.5.4.rc4.42.gacc73
