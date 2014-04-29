From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 2/6] pull: migrate all the tests to pull.mode
Date: Tue, 29 Apr 2014 06:17:02 -0500
Message-ID: <1398770226-9686-3-git-send-email-felipe.contreras@gmail.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 13:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6Cq-0004pG-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933906AbaD2L1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:27:52 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:45798 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbaD2L1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:27:50 -0400
Received: by mail-yh0-f42.google.com with SMTP id f73so41854yha.29
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3MTYCy0c6dAAk4iE+q2p9u8zjE+gmLpjkXIHre+3tAc=;
        b=XBnf70OiRRsSIx9IcKIINv7ft9Dq/zY/wlup1z8+VrlhO+ddkayAgsUeYT10F1PaNc
         7myYGO2m8yfQr+769frk6aR0JWamINWzuI9I+gb+KgfbqBfgH3qD5yjvSrO8yyhlNmbv
         t6wEd5cbxzBRci9+ddtAQOrwYKcbYQvY2x4mOTAUl8NY4VC9JzzPwNIoPhamZ9Xz6gzj
         7TV39NhzqfOd3mX9+PVeVLay5Yf5+ENhCTcfP4Bi4cUdylgYu68I1jbpaoO38g4jwES9
         GmJafzO9a9Y/D5L0C+afBchkRnlWxbM1K6zig1GOO5NzJ8inXxfxiOtMBY9U02XXHJqi
         7OJQ==
X-Received: by 10.236.0.200 with SMTP id 48mr46608084yhb.72.1398770869675;
        Tue, 29 Apr 2014 04:27:49 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g1sm28769963yho.37.2014.04.29.04.27.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:27:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247569>

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
1.9.2+fc1.3.gade8541
