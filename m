From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 06/15] remote-testgit: get rid of non-local functionality
Date: Sun, 11 Nov 2012 14:59:43 +0100
Message-ID: <1352642392-28387-7-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY62-0007lt-R0
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2KKOAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:00:53 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:00:52 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3NLjG1/N/towe04T/MHAQ5XI3GzBEkirx2ZR7QCEbQM=;
        b=WROyigc1ZNUNJOnHGLmFA64CJKBR+E7eG+27DF0XGIkIfFVinUF+8J5oB5HJEuL3ax
         9o6c/1hFyo0aXEdNX+hWdMDiB8RzOMg+YIGzPmG/w4ZLHHlGNhVX7dcyxqVv6zObAtmZ
         pUKuRqx/thKUMkpOGh21oetT1FJdZ2syfyS6McuLjs/58fm5IBKmzbKerCxAYqlk9DHe
         8KnZir9HY5jhWVhTqIIazFS9ZDCbGDYkJiB+yNaRBEQ/y3kL6Pro9vRORoFVfzDlroJI
         qFYaJSAR4bO21zM7YwcuyR3suONxuMSu45oupTdqFR6yoLbnQjsKJRvrPb8P6yRJGLOq
         34wg==
Received: by 10.204.6.17 with SMTP id 17mr5857205bkx.129.1352642451596;
        Sun, 11 Nov 2012 06:00:51 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id ia2sm1487920bkc.11.2012.11.11.06.00.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:50 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209361>

This only makes sense for the python remote helpers framework.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        |  3 ---
 t/t5801-remote-helpers.sh | 50 ++++++++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 83ccb86..fe73c36 100755
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
1.8.0
