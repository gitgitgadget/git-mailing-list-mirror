From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 2/7] pull: migrate all the tests to pull.mode
Date: Thu,  1 May 2014 19:00:03 -0500
Message-ID: <1398988808-29678-3-git-send-email-felipe.contreras@gmail.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:11:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg14E-0000d3-A2
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbaEBALA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:11:00 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40912 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaEBAK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:10:59 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so4398377oac.16
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QSQBfXz2drvD/Y4wH+J9DtMt8/ir558vCOd9QeYH7fM=;
        b=n+XoG27GhwEwm7QiGOAzCTxJ235adD3Zum6GZaP3JJPFE8VRacv+/77IkM4I/9raO3
         9gk9aHXTsnvluh40N62h5Tm34ITSTZf7YZNNcSzpnyggmm54DEpK0qZtzNi5N2MBpWN7
         jBNgj+s7E+IGrx9D4hsD13QRWq+Cqum9OoUavoe+5Sdo5+iSMmgtz46jaq6DiI8i/1ha
         k1ioke+ecDzHZukeDzSdtIj2+CKZJVznN5iRzA8Qv6wt8Ckcu5hACnG2WzEgyc+NyqqP
         KQ7Wbrq2nDHs3vtbls656xUHVxyZrj2THpqJ/bxNAF5c20if+5WM5yjkhAHyaLmiiwfh
         a4rg==
X-Received: by 10.60.98.139 with SMTP id ei11mr13590121oeb.43.1398989459468;
        Thu, 01 May 2014 17:10:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm62686412obc.16.2014.05.01.17.10.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:10:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
In-Reply-To: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247903>

And branch.$name.pullmode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5505-remote.sh |  2 +-
 t/t5520-pull.sh   | 54 +++++++++++++++++++++++-------------------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..76376e4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -181,7 +181,7 @@ test_expect_success 'show' '
 		git branch -d -r origin/master &&
 		git config --add remote.two.url ../two &&
 		git config --add remote.two.pushurl ../three &&
-		git config branch.rebase.rebase true &&
+		git config branch.rebase.pullmode rebase &&
 		git config branch.octopus.merge "topic-a topic-b topic-c" &&
 		(
 			cd ../one &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 227d293..01ad17a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -123,26 +123,26 @@ test_expect_success '--rebase' '
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
-test_expect_success 'pull.rebase' '
+test_expect_success 'pull.mode=rebase' '
 	git reset --hard before-rebase &&
-	test_config pull.rebase true &&
+	test_config pull.mode rebase &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
 
-test_expect_success 'branch.to-rebase.rebase' '
+test_expect_success 'branch.to-rebase.pullmode=rebase' '
 	git reset --hard before-rebase &&
-	test_config branch.to-rebase.rebase true &&
+	test_config branch.to-rebase.pullmode rebase &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
 
-test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
+test_expect_success 'branch.to-rebase.pullmode should override pull.mode' '
 	git reset --hard before-rebase &&
-	test_config pull.rebase true &&
-	test_config branch.to-rebase.rebase false &&
+	test_config pull.mode merge &&
+	test_config branch.to-rebase.pullmode merge &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
@@ -150,7 +150,7 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 
 # add a feature branch, keep-merge, that is merged into master, so the
 # test can try preserving the merge commit (or not) with various
-# --rebase flags/pull.rebase settings.
+# --rebase flags/pull.mode settings.
 test_expect_success 'preserve merge setup' '
 	git reset --hard before-rebase &&
 	git checkout -b keep-merge second^ &&
@@ -160,48 +160,40 @@ test_expect_success 'preserve merge setup' '
 	git tag before-preserve-rebase
 '
 
-test_expect_success 'pull.rebase=false create a new merge commit' '
+test_expect_success 'pull.mode=merge create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase false &&
+	test_config pull.mode merge &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
 	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
 	test file3 = $(git show HEAD:file3.t)
 '
 
-test_expect_success 'pull.rebase=true flattens keep-merge' '
+test_expect_success 'pull.mode=rebase flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase true &&
+	test_config pull.mode rebase &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
 	test file3 = $(git show HEAD:file3.t)
 '
 
-test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
+test_expect_success 'pull.mode=rebase-preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase 1 &&
-	git pull . copy &&
-	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
-	test file3 = $(git show HEAD:file3.t)
-'
-
-test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
-	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.mode rebase-preserve &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
 	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
 '
 
-test_expect_success 'pull.rebase=invalid fails' '
+test_expect_success 'pull.mode=invalid fails' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase invalid &&
+	test_config pull.mode invalid &&
 	! git pull . copy
 '
 
 test_expect_success '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase true &&
+	test_config pull.mode rebase &&
 	git pull --rebase=false . copy &&
 	test $(git rev-parse HEAD^1) = $(git rev-parse before-preserve-rebase) &&
 	test $(git rev-parse HEAD^2) = $(git rev-parse copy) &&
@@ -210,7 +202,7 @@ test_expect_success '--rebase=false create a new merge commit' '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.mode rebase-preserve &&
 	git pull --rebase=true . copy &&
 	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
 	test file3 = $(git show HEAD:file3.t)
@@ -218,7 +210,7 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 
 test_expect_success '--rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase true &&
+	test_config pull.mode rebase &&
 	git pull --rebase=preserve . copy &&
 	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
 	test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
@@ -229,9 +221,9 @@ test_expect_success '--rebase=invalid fails' '
 	! git pull --rebase=invalid . copy
 '
 
-test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+test_expect_success '--rebase overrides pull.mode=rebase-preserve and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
-	test_config pull.rebase preserve &&
+	test_config pull.mode rebase-preserve &&
 	git pull --rebase . copy &&
 	test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
 	test file3 = $(git show HEAD:file3.t)
@@ -279,7 +271,7 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
 
 '
 
-test_expect_success 'pull --rebase dies early with dirty working directory' '
+test_expect_success 'pull --mode=rebase dies early with dirty working directory' '
 
 	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
@@ -287,7 +279,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	git rebase --onto $COPY copy &&
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
-	test_config branch.to-rebase.rebase true &&
+	test_config branch.to-rebase.pullmode rebase &&
 	echo dirty >> file &&
 	git add file &&
 	test_must_fail git pull &&
-- 
1.9.2+fc1.19.g85b6256
