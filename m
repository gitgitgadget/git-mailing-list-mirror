From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 09/15] remote-testgit: exercise more features
Date: Sun, 11 Nov 2012 14:59:46 +0100
Message-ID: <1352642392-28387-10-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6E-0007s4-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab2KKOBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:07 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:04 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FW6zHheh8D6mCoH5J7QonG+AyPCi+0VTcKmyeeZlNCk=;
        b=Xkwy7Q9PkbRugNeiXdwIACOU5ru3ar9SUsqcuwONJSabjQ8SnMOaU9EZBREDiXVqIX
         FROTpxGMyCzZqpgnyW/Asoz9KloNZLe3Om5XGOhDZzWj4kvHnNYkASCoIpTkSKVs4Vlg
         UE19WElLgjbqgYvqU0zi+fGvh4kQUVcjIPptjkMyfaYCq99rBY4TyVNJhOhKsJ65AbQ9
         /5GaOpEQnWjWbYhP6cBQ/eVARRzpFohA1XucP0YspFP4Ub7X/zSuq4rB4CR/V1Yz/zct
         cS5EwRiX1qD+yRXbxaq3tsAlk7SvomWqNzseOZj5uR2DxY3fSPKG5JXWWMiANKxFFFTW
         uNVQ==
Received: by 10.204.148.214 with SMTP id q22mr5768962bkv.128.1352642463779;
        Sun, 11 Nov 2012 06:01:03 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id go4sm1147162bkc.15.2012.11.11.06.01.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:02 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209365>

Unfortunately they do not work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 18 +++++++++++++----
 t/t5801-remote-helpers.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)
 mode change 100755 => 100644 t/t5801-remote-helpers.sh

diff --git a/git-remote-testgit b/git-remote-testgit
index fe73c36..31c7533 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -6,24 +6,34 @@ url=$2
 
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
-refspec="refs/heads/*:${prefix}/heads/*"
+
+default_refspec="refs/heads/*:${prefix}/heads/*"
+
+refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
 
 gitmarks="$dir/git.marks"
 testgitmarks="$dir/testgit.marks"
 
+test -z "$refspec" && prefix="refs"
+
 export GIT_DIR="$url/.git"
 
 mkdir -p "$dir"
 
-test -e "$gitmarks" || > "$gitmarks"
-test -e "$testgitmarks" || > "$testgitmarks"
+if [ -z "$GIT_REMOTE_TESTGIT_NO_MARKS" ]; then
+	test -e "$gitmarks" || > "$gitmarks"
+	test -e "$testgitmarks" || > "$testgitmarks"
+else
+	> "$gitmarks"
+	> "$testgitmarks"
+fi
 
 while read line; do
 	case $line in
 	capabilities)
 		echo 'import'
 		echo 'export'
-		echo "refspec $refspec"
+		test -n "$refspec" && echo "refspec $refspec"
 		echo "*import-marks $gitmarks"
 		echo "*export-marks $gitmarks"
 		echo
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
old mode 100755
new mode 100644
index bc0b5f7..31940c9
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -110,4 +110,53 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_failure 'cloning without refspec' '
+	GIT_REMOTE_TESTGIT_REFSPEC="" \
+	git clone "testgit::${PWD}/server" local2 &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pulling without refspecs' '
+	(cd local2 &&
+	git reset --hard &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without refspecs' '
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pulling with straight refspec' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing with straight refspec' '
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pulling without marks' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without marks' '
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
 test_done
-- 
1.8.0
