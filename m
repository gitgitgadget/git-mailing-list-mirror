From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/14] remote-testgit: get rid of non-local functionality
Date: Fri,  2 Nov 2012 03:02:09 +0100
Message-ID: <1351821738-17526-6-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bA-0000fm-FK
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965784Ab2KBCCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965765Ab2KBCCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+tDkEXkQQryViHyTmRnYGsgD5sdMBB6MUQyquXzlLXI=;
        b=UllRZ1pFpbLoSFWTxS0FwmgkSumYzGxT9TBE9hWAjojWrmJINNTMcNJIOUz2m12kB+
         hK4hwEyG3i0xgKLrKCagOH4YPovRfndt8M6srjqkcLwiTjYid5+9lcRrHe2AnwrAnjmH
         wDIOT3AcsEqUntZBo6WKSJ1IbJKr5Dvj2pQ64c3PHMiONjAMO61ICmwg/iDoAbC4sGnl
         tHbu2M0CMd+sxTAIsSZ8iys+4wx5ViKxNCwGS4iYbskm9Iekw2cVUeVE5mNvnb2U6foP
         BIizM/7YJfulNwzDteDtfcTthEBSZQL/YCIGKA6kfat157RoJD0Ep/AMdxfDLeYnt3MV
         lY5w==
Received: by 10.204.9.3 with SMTP id j3mr27126bkj.15.1351821768694;
        Thu, 01 Nov 2012 19:02:48 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id r15sm5771236bkw.9.2012.11.01.19.02.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208899>

This only makes sense for the python remote helpers framework.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        |  3 ---
 t/t5801-remote-helpers.sh | 46 +++++++++++++++++-----------------------------
 2 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 6650402..b9810fd 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -4,9 +4,6 @@
 alias="$1"
 url="$2"
 
-# huh?
-url="${url#file://}"
-
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
 refspec="refs/heads/*:${prefix}/heads/*"
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 67bc8eb..2eca42e 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -28,11 +28,6 @@ test_expect_success 'cloning from local repo' '
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
@@ -45,11 +40,6 @@ test_expect_success 'pulling from local repo' '
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
@@ -71,19 +61,6 @@ test_expect_success 'pushing to local repo' '
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
@@ -97,6 +74,16 @@ test_expect_success 'fetch new branch' '
 	compare_refs public HEAD localclone FETCH_HEAD
 '
 
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
@@ -106,29 +93,30 @@ test_expect_success 'fetch multiple branches' '
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
1.8.0
