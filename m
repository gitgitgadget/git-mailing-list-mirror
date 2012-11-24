From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 06/14] remote-testgit: remove non-local functionality
Date: Sat, 24 Nov 2012 04:17:06 +0100
Message-ID: <1353727034-24698-7-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
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
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fw-0001zJ-EG
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab2KXDRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:51 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2KXDRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:49 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6C77W4IVjNBkv4J9iZEPT6sERcw83iuR+Zd5Tx91nfs=;
        b=VD2Ew/ZROoplnXbRQsiSfowkfxtN4XtQaOPUX4F5i9xr0r9/bh8iw+omg0XM4TIp/Q
         Iv6rRYJD2FpCNU/BX9qYBMCGRq42ks/G0k0ThcA+Jf012Mm3ZZNIUvCfyu6FosI7tDWI
         NNjj7+D+w+8rzTJOIzIRrguPYS6/BHVdFFs8xO4kLXxZ7xpIOmZT7lRMZpUMt0yUF0zY
         JujdPj4aWscvu6TdvVHrLSQw0SyPaPT32KULulXrfHiS3sRSG0nft5j1fwic03CLrQHg
         wR0Y3n3mlRtGfx4f7kRPMVip/kyEDsjEMWSHETKXDGKrC58CnF1B1TAwG0dhuUDzHXzp
         Ycaw==
Received: by 10.204.147.79 with SMTP id k15mr1650146bkv.55.1353727068590;
        Fri, 23 Nov 2012 19:17:48 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id l17sm5465104bkw.12.2012.11.23.19.17.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:47 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210290>

This only makes sense for the python remote helpers framework. The tests
don't exercise any feature of transport helper. Remove them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        |  3 ---
 t/t5801-remote-helpers.sh | 50 ++++++++++++++++++++---------------------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index a50d6f1..bf4d22c 100755
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
