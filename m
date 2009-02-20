From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/4] Test contents of entire cvsimported "master" tree contents
Date: Fri, 20 Feb 2009 06:18:12 +0100
Message-ID: <78a9942d20fa6315deb723316b757cc635292ee2.1235106222.git.mhagger@alum.mit.edu>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
 <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
 <c202fb4c8c1eb0121cc15df6ad4a600dc3074f21.1235106222.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 06:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNnv-00035N-P2
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 06:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZBTFSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 00:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZBTFSd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 00:18:33 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49828 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbZBTFSc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 00:18:32 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1K5IEtX005509;
	Fri, 20 Feb 2009 06:18:15 +0100
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <c202fb4c8c1eb0121cc15df6ad4a600dc3074f21.1235106222.git.mhagger@alum.mit.edu>
In-Reply-To: <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
References: <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110793>

Test added for completeness (it passes).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9600-cvsimport.sh |    2 ++
 t/t96xx/cvs-lib.sh   |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 66393ae..dad9d49 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -121,4 +121,6 @@ test_expect_success 'import from a CVS working tree' '
 
 '
 
+test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'
+
 test_done
diff --git a/t/t96xx/cvs-lib.sh b/t/t96xx/cvs-lib.sh
index 6738901..0136b36 100644
--- a/t/t96xx/cvs-lib.sh
+++ b/t/t96xx/cvs-lib.sh
@@ -32,3 +32,28 @@ case "$cvsps_version" in
 	exit
 	;;
 esac
+
+test_cvs_co () {
+	# Usage: test_cvs_co BRANCH_NAME
+	if [ "$1" = "master" ]
+	then
+		$CVS co -P -d module-cvs-"$1" -A module
+	else
+		$CVS co -P -d module-cvs-"$1" -b "$1" module
+	fi
+}
+
+test_git_co_branch () {
+	# Usage: test_git_co BRANCH_NAME
+	(cd module-git && git checkout "$1")
+}
+
+test_cmp_branch_tree () {
+	# Usage: test_cmp_branch_tree BRANCH_NAME
+	# Check BRANCH_NAME out of CVS and git and make sure that all
+	# of the files and directories are identical.
+
+	test_cvs_co "$1" &&
+	test_git_co_branch "$1" &&
+	diff -r -x .git -x CVS module-cvs-"$1" module-git
+}
-- 
1.6.1.3
