From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 07/11] t2100: use test_ln_s_add to remove SYMLINKS prerequisite
Date: Sat,  1 Jun 2013 11:34:26 +0200
Message-ID: <e232ae3efc6f7b282d4402e6e6976b34d34ab3e7.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:35:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiDK-0002Bb-AX
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900Ab3FAJet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:34:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:17837 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756242Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 48BF7A7EB7
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8721919F5E7
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226113>

One converted case expects 'git update-index' to fail. We cannot use
'test_must_fail test_ln_s_add ...', because that would mistakenly pass
if a command other than the final git-update-index of test_ln_s_add
failed. Hence, use test_ln_s to create the symbolic link and keep
the explicit 'test_must_fail git update-index'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t2100-update-cache-badpath.sh | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index a3f9255..47a9b05 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -28,12 +28,7 @@ test_expect_success 'git update-index --add to add various paths' '
 
 	mkdir path2 path3 &&
 	date >path0 &&
-	if test_have_prereq SYMLINKS
-	then
-		ln -s xyzzy path1
-	else
-		date >path1
-	fi &&
+	test_ln_s_add xyzzy path1 &&
 	date >path2/file2 &&
 	date >path3/file3 &&
 	test_when_finished "rm -fr path0 path1 path2 path3" &&
@@ -62,12 +57,7 @@ test_expect_success 'git update-index to add conflicting file path2 should fail'
 
 test_expect_success 'git update-index to add conflicting symlink path3 should fail' '
 
-	if test_have_prereq SYMLINKS
-	then
-		ln -s xyzzy path3
-	else
-		date >path3
-	fi &&
+	test_ln_s xyzzy path3 &&
 	test_must_fail git update-index --add -- path3
 '
 
-- 
1.8.3.rc1.32.g8b61cbb
