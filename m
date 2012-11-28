From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 06/13] remote-testgit: remove non-local functionality
Date: Wed, 28 Nov 2012 23:11:02 +0100
Message-ID: <1354140669-23533-7-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdprr-0003JU-2W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794Ab2K1WLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:48 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932776Ab2K1WLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:45 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=y1OHl+cnN/R7IbmgWDUlugHyMBMb+vw+F3SESxpLw9M=;
        b=NfkGl+k5t0UU5hgCBqJAPk1ec4d/04x9kCMqZyXW9b9zlA1OqiSCqfNSEyvY+lIr1q
         ZpRIlXZsKkdcolH812cYJfgYPy0xHmYX4eooqWbOXFEEJVcGoXd7To3TWFu3otd7FsTD
         iNxLa+zZXLwuWTIaqSHuzHNGLDfEgeYmfEq4t+L7j0PVQ+GqCCTLsssUMdN6sPdBOoB4
         EGeasw8yItBStnVEYG6saoYNbXHWt6lSICym5Xkzn5VnbqCygJRu+2tbj6z5fqTBOO7v
         pjekgnEMIr9zw0jysPIt4QETJEZBuBvQ2Zvi/1tGANkv1G8i/mK24pMLd0gDsnwLm/iJ
         27NQ==
Received: by 10.204.9.139 with SMTP id l11mr6043173bkl.133.1354140704611;
        Wed, 28 Nov 2012 14:11:44 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id 18sm4560456bkv.0.2012.11.28.14.11.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:43 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210789>

This only makes sense for the python remote helpers framework. The tests
don't exercise any feature of transport helper. Remove them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testgit        |  3 ---
 t/t5801-remote-helpers.sh | 50 ++++++++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 5042f5a..5117ab5 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -4,9 +4,6 @@
 alias=$1
 url=$2
 
-# huh?
-url="${url#file://}"
-
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
 refspec="refs/heads/*:${prefix}/heads/*"
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f52ab14..2f7fc10 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -33,11 +33,6 @@ test_expect_success 'cloning from local repo' '
 	test_cmp public/file localclone/file
 '
 
-test_expect_success 'cloning from remote repo' '
-	git clone "testgit::file://${PWD}/server" clone &&
-	test_cmp public/file clone/file
-'
-
 test_expect_success 'create new commit on remote' '
 	(cd public &&
 	 echo content >>file &&
@@ -50,11 +45,6 @@ test_expect_success 'pulling from local repo' '
 	test_cmp public/file localclone/file
 '
 
-test_expect_success 'pulling from remote remote' '
-	(cd clone && git pull) &&
-	test_cmp public/file clone/file
-'
-
 test_expect_success 'pushing to local repo' '
 	(cd localclone &&
 	echo content >>file &&
@@ -76,19 +66,6 @@ test_expect_success 'pushing to local repo' '
 	compare_refs localclone2 HEAD server2 HEAD
 '
 
-test_expect_success 'synch with changes from localclone' '
-	(cd clone &&
-	 git pull)
-'
-
-test_expect_success 'pushing remote local repo' '
-	(cd clone &&
-	echo content >>file &&
-	git commit -a -m four &&
-	git push) &&
-	compare_refs clone HEAD server HEAD
-'
-
 test_expect_success 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
@@ -102,6 +79,20 @@ test_expect_success 'fetch new branch' '
 	compare_refs public HEAD localclone FETCH_HEAD
 '
 
+#
+# This is only needed because of a bug not detected by this script. It will be
+# fixed shortly, but for now lets not cause regressions.
+#
+test_expect_success 'bump commit in public' '
+	(cd public &&
+	git checkout master &&
+	git pull &&
+	echo content >>file &&
+	git commit -a -m four &&
+	git push) &&
+	compare_refs public HEAD server HEAD
+'
+
 test_expect_success 'fetch multiple branches' '
 	(cd localclone &&
 	 git fetch
@@ -111,29 +102,30 @@ test_expect_success 'fetch multiple branches' '
 '
 
 test_expect_success 'push when remote has extra refs' '
-	(cd clone &&
+	(cd localclone &&
+	 git reset --hard origin/master &&
 	 echo content >>file &&
 	 git commit -a -m six &&
 	 git push
 	) &&
-	compare_refs clone master server master
+	compare_refs localclone master server master
 '
 
 test_expect_success 'push new branch by name' '
-	(cd clone &&
+	(cd localclone &&
 	 git checkout -b new-name  &&
 	 echo content >>file &&
 	 git commit -a -m seven &&
 	 git push origin new-name
 	) &&
-	compare_refs clone HEAD server refs/heads/new-name
+	compare_refs localclone HEAD server refs/heads/new-name
 '
 
 test_expect_failure 'push new branch with old:new refspec' '
-	(cd clone &&
+	(cd localclone &&
 	 git push origin new-name:new-refspec
 	) &&
-	compare_refs clone HEAD server refs/heads/new-refspec
+	compare_refs localclone HEAD server refs/heads/new-refspec
 '
 
 test_done
-- 
1.8.0.1
