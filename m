From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t5000, t5003: simplify commit
Date: Sat, 05 Jul 2014 21:35:01 +0200
Message-ID: <53B85365.6070304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 05 21:35:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3VkG-0007ek-5m
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 21:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbaGETfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2014 15:35:32 -0400
Received: from mout.web.de ([212.227.17.11]:50659 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086AbaGETfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2014 15:35:31 -0400
Received: from [192.168.178.27] ([79.250.190.225]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MXpV5-1X9mhs2Qfn-00WmB5; Sat, 05 Jul 2014 21:35:27
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:n5vtABm1kkPA4eDfLyPUahXx2Y5VEnSpJb6Jze3nuaFZU/3oX5o
 ldcjkxPXASbIctuoqGjU/JcOidks/XZ1cwQ0/A2OnIIHscZvJOTrHn9oLu68pNhXPe8cLwA
 39Ys59IWILZ7yPAk5Jz3EzUZl/+QIT9WVjmFqBcjbCyWGYi2gLE6k4KGHElKeDEKp3s1jcW
 xxGrjq7IDI5I/ZL03r0Vg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252920>

Add the whole directory of test files at once using git add instead of
calling git update-index on each of them and use git commit instead of
the plumbing commands write-tree, update-ref and commit-tree to build
the commit.  This simplifies the code considerably.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t5000-tar-tree.sh    | 12 ++++--------
 t/t5003-archive-zip.sh | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 899c1c5..7b8babd 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -119,14 +119,10 @@ test_expect_success \
     'echo ignore me >a/ignored &&
      echo ignored export-ignore >.git/info/attributes'
 
-test_expect_success \
-    'add files to repository' \
-    'find a -type f | xargs git update-index --add &&
-     find a -type l | xargs git update-index --add &&
-     treeid=$(git write-tree) &&
-     echo $treeid >treeid &&
-     git update-ref HEAD $(TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
-     git commit-tree $treeid </dev/null)'
+test_expect_success 'add files to repository' '
+	git add a &&
+	GIT_COMMITTER_DATE="2005-05-27 22:00" git commit -m initial
+'
 
 test_expect_success 'setup export-subst' '
 	echo "substfile?" export-subst >>.git/info/attributes &&
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 21a5c93..c929db5 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -61,14 +61,10 @@ test_expect_success \
     'echo ignore me >a/ignored &&
      echo ignored export-ignore >.git/info/attributes'
 
-test_expect_success \
-    'add files to repository' \
-    'find a -type f | xargs git update-index --add &&
-     find a -type l | xargs git update-index --add &&
-     treeid=`git write-tree` &&
-     echo $treeid >treeid &&
-     git update-ref HEAD $(TZ=GMT GIT_COMMITTER_DATE="2005-05-27 22:00:00" \
-     git commit-tree $treeid </dev/null)'
+test_expect_success 'add files to repository' '
+	git add a &&
+	GIT_COMMITTER_DATE="2005-05-27 22:00" git commit -m initial
+'
 
 test_expect_success 'setup export-subst' '
 	echo "substfile?" export-subst >>.git/info/attributes &&
-- 
2.0.0
