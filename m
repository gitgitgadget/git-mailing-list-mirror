From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 14/16] Use prerequisites to skip tests that need unzip
Date: Sat, 21 Mar 2009 22:26:37 +0100
Message-ID: <a71ced1bacf2d05b1df6946d419331b8aa3e5a27.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8lj-0004Ii-5R
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbZCUV1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZCUV1b
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27967 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DFEDE2C4013;
	Sat, 21 Mar 2009 22:26:56 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E784B4279F;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114070>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0024-crlf-archive.sh |    6 +++---
 t/t5000-tar-tree.sh     |   16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index ae90d34..c7d0324 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -29,11 +29,11 @@ test_expect_success 'tar archive' '
 "$UNZIP" -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	say "Skipping ZIP test, because unzip was not found"
-	test_done
-	exit
+else
+	test_set_prereq UNZIP
 fi
 
-test_expect_success 'zip archive' '
+test_expect_success UNZIP 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 60a4b8d..7641e0d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -187,20 +187,20 @@ test_expect_success 'git archive --format=zip with --output' \
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	say "Skipping ZIP tests, because unzip was not found"
-	test_done
-	exit
+else
+	test_set_prereq UNZIP
 fi
 
-test_expect_success \
+test_expect_success UNZIP \
     'extract ZIP archive' \
     '(mkdir d && cd d && $UNZIP ../d.zip)'
 
-test_expect_success \
+test_expect_success UNZIP \
     'validate filenames' \
     '(cd d/a && find .) | sort >d.lst &&
      test_cmp a.lst d.lst'
 
-test_expect_success \
+test_expect_success UNZIP \
     'validate file contents' \
     'diff -r a d/a'
 
@@ -208,16 +208,16 @@ test_expect_success \
     'git archive --format=zip with prefix' \
     'git archive --format=zip --prefix=prefix/ HEAD >e.zip'
 
-test_expect_success \
+test_expect_success UNZIP \
     'extract ZIP archive with prefix' \
     '(mkdir e && cd e && $UNZIP ../e.zip)'
 
-test_expect_success \
+test_expect_success UNZIP \
     'validate filenames with prefix' \
     '(cd e/prefix/a && find .) | sort >e.lst &&
      test_cmp a.lst e.lst'
 
-test_expect_success \
+test_expect_success UNZIP \
     'validate file contents with prefix' \
     'diff -r a e/prefix/a'
 
-- 
1.6.2.1.224.g2225f
