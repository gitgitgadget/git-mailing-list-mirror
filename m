From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/16] t/t5516-fetch-push: use test_config()
Date: Fri, 21 Jun 2013 16:42:32 +0530
Message-ID: <1371813160-4200-9-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKL-0003RE-8Z
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389Ab3FULQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:18 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:58312 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030336Ab3FULQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:15 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so7638986pbb.20
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PFFCeLhXnRhc0O9p4ftuSt1xP70TfhqsaW/bYPpnjyk=;
        b=M/AfX+uYBkIANTndcQS1EhUB0kZdKIMKRUys+dqVTb9Ns4rQ5yZsyCfy+ACfnFXv9G
         jUO/TlsQOEA5YquPi3dB87nZGqpeWc3OCYNSBjzb9i7XDhsfzdfF7FIcQFQ2g131opy5
         BwN5VZrp2HU4Tmlj5yLeBdAyKcsS1Gc3aomsgk73ZnU4gCdkiKMnXuIsuXaWrIiYpIIb
         NvVOT2b7qCjb47lyjaEX/NFMy/7qCjqbVKM9886ZVQfbcTAgVd3Ve8npHVqvbTEy48Bt
         FbI+1Cx5lZGr/DupuEFf2ykrq1NR12SKhgK7R+DI69x2vRjogT6nLyKqVkDQY48s6tCF
         OhmQ==
X-Received: by 10.66.139.227 with SMTP id rb3mr15804604pab.121.1371813375026;
        Fri, 21 Jun 2013 04:16:15 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228601>

Replace the 'git config' calls in tests with test_config for greater
robustness.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6e9fa84..afb25c4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -142,8 +142,8 @@ test_expect_success 'fetch with wildcard' '
 	mk_empty testrepo &&
 	(
 		cd testrepo &&
-		git config remote.up.url .. &&
-		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
+		test_config remote.up.url .. &&
+		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
 		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
@@ -157,9 +157,9 @@ test_expect_success 'fetch with insteadOf' '
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
-		git config "url.$TRASH.insteadOf" trash/ &&
-		git config remote.up.url trash/. &&
-		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
+		test_config "url.$TRASH.insteadOf" trash/ &&
+		test_config remote.up.url trash/. &&
+		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
 		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
@@ -173,9 +173,9 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
 	(
 		TRASH=$(pwd)/ &&
 		cd testrepo &&
-		git config "url.trash/.pushInsteadOf" "$TRASH" &&
-		git config remote.up.url "$TRASH." &&
-		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
+		test_config "url.trash/.pushInsteadOf" "$TRASH" &&
+		test_config remote.up.url "$TRASH." &&
+		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
 		git fetch up &&
 
 		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
@@ -780,7 +780,7 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
 
 test_expect_success 'allow deleting a ref using --delete' '
 	mk_test testrepo heads/master &&
-	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
+	(cd testrepo && test_config receive.denyDeleteCurrent warn) &&
 	git push testrepo --delete master &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
 '
@@ -809,7 +809,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 	(
 		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch warn
+		test_config receive.denyCurrentBranch warn
 	) &&
 	git push testrepo master 2>stderr &&
 	grep "warning: updating the current branch" stderr
@@ -820,7 +820,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
 	(
 		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch true
+		test_config receive.denyCurrentBranch true
 	) &&
 	test_must_fail git push testrepo master
 '
@@ -830,8 +830,8 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 	(
 		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch true &&
-		git config core.bare true
+		test_config receive.denyCurrentBranch true &&
+		test_config core.bare true
 	) &&
 	git push testrepo master 2>stderr &&
 	! grep "warning: updating the current branch" stderr
@@ -842,7 +842,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
 	(
 		cd testrepo &&
 		git checkout master &&
-		git config receive.denyCurrentBranch false
+		test_config receive.denyCurrentBranch false
 	) &&
 	git push testrepo master 2>stderr &&
 	! grep "warning: updating the current branch" stderr
@@ -918,7 +918,7 @@ test_expect_success 'push into aliased refs (consistent)' '
 		cd child1 &&
 		git branch foo &&
 		git symbolic-ref refs/heads/bar refs/heads/foo
-		git config receive.denyCurrentBranch false
+		test_config receive.denyCurrentBranch false
 	) &&
 	(
 		cd child2 &&
@@ -940,7 +940,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 		cd child1 &&
 		git branch foo &&
 		git symbolic-ref refs/heads/bar refs/heads/foo
-		git config receive.denyCurrentBranch false
+		test_config receive.denyCurrentBranch false
 	) &&
 	(
 		cd child2 &&
@@ -1006,7 +1006,7 @@ test_expect_success 'push --porcelain rejected' '
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
 		git reset --hard origin/master^
-		git config receive.denyCurrentBranch true) &&
+		test_config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
 	echo >>.git/foo "!	refs/heads/master:refs/heads/master	[remote rejected] (branch is currently checked out)" &&
@@ -1020,7 +1020,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
 		git reset --hard origin/master
-		git config receive.denyCurrentBranch true) &&
+		test_config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
 	echo >>.git/foo "!	refs/heads/master^:refs/heads/master	[rejected] (non-fast-forward)" &&
@@ -1052,7 +1052,7 @@ do
 		mk_test testrepo heads/master hidden/one hidden/two hidden/three &&
 		(
 			cd testrepo &&
-			git config $configsection.hiderefs refs/hidden
+			test_config $configsection.hiderefs refs/hidden
 		) &&
 
 		# push to unhidden ref succeeds normally
@@ -1078,7 +1078,7 @@ test_expect_success 'fetch exact SHA1' '
 	git push testrepo master:refs/hidden/one &&
 	(
 		cd testrepo &&
-		git config transfer.hiderefs refs/hidden
+		test_config transfer.hiderefs refs/hidden
 	) &&
 	check_push_result testrepo $the_commit hidden/one &&
 
@@ -1098,7 +1098,7 @@ test_expect_success 'fetch exact SHA1' '
 		# the server side can allow it to succeed
 		(
 			cd ../testrepo &&
-			git config uploadpack.allowtipsha1inwant true
+			test_config uploadpack.allowtipsha1inwant true
 		) &&
 
 		git fetch -v ../testrepo $the_commit:refs/heads/copy &&
@@ -1126,8 +1126,8 @@ test_expect_success 'fetch follows tags by default' '
 	(
 		cd dst &&
 		git remote add origin ../src &&
-		git config branch.master.remote origin &&
-		git config branch.master.merge refs/heads/master &&
+		test_config branch.master.remote origin &&
+		test_config branch.master.merge refs/heads/master &&
 		git pull &&
 		git for-each-ref >../actual
 	) &&
-- 
1.8.3.1.499.g7ad3486.dirty
