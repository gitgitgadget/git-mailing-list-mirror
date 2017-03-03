Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8E220133
	for <e@80x24.org>; Fri,  3 Mar 2017 13:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdCCNrz (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 08:47:55 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35503 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbdCCNrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 08:47:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id 67so5579462pfg.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8kNTGs8UEoDbQB2IC8QRfPUxBzH4KWggzRiAWnGJ8TE=;
        b=DOP8dq0AQx26iGYs2+UNs4ezLfjo6PV/QD88WEwrpAm/ylA6eBtjpuXwoQvv8vTd9B
         ZXzmd8GoPL5FXRyySKfXFNtWJyZQTxFB5z0bTrg7jI9iWEJKbWfsZXKZuBTXm9lQdf5f
         rfofevZohQJdywkksRpxP1+JALOECNRnpqrN7+YqcdIJqI/c1Ys438JUGSyDMvsIMYh5
         EEQQh22XbQMg5ppFhGYP4zf1LZhMul9t8mvQg9QgL14qbXel3I//y5B1W+Pb3FHtZZT+
         P4/ivgRr86w3LkUWpnrZ3ntEx5moc3gH49ExbWttfSVD5a1nrV5fjJJHw7ppEEubiNwf
         hfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8kNTGs8UEoDbQB2IC8QRfPUxBzH4KWggzRiAWnGJ8TE=;
        b=C58noZoIf9JlS+xCrqOeGEJBRztE12+pQimTZBQlMa4FC3Vi6XHwHoTb2tKmg6sYwV
         UjYWXyjsm66yBerNa/f5ybN47vODZ5pXO1im6+xPYyhe0KL7sHxVH5nOOeiEg3eOBBeV
         xFRVWXTNzDmKH5wjAM62YpGBdp8G/2tv0ZnwXSSysm+Hfk/WK3URy9VTRVKaFVRzl+OC
         HTqU/CWrLv2nHjvGybPKYnzewWJmKyiPptmWozi0y1+8jcI8k8PPS0Nhx4B9hrJcz0mO
         ejiN10meZ5iMnU/mOkatGAXHra5jhr0T5KKHH+JjcrF/sEmLnzCXRFzyfsSTXWmdaWsr
         u/gA==
X-Gm-Message-State: AMke39mQDnLNWdJihvYQlm5dZ5ixfjsFcPR45mnocNJhLiVspHtrxZFdWx1SPQoN2bg9ow==
X-Received: by 10.98.14.81 with SMTP id w78mr3645799pfi.9.1488548418456;
        Fri, 03 Mar 2017 05:40:18 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id b83sm23691036pfe.12.2017.03.03.05.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 05:40:17 -0800 (PST)
Date:   Fri, 3 Mar 2017 05:40:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 1/5] Detect merges specifically in test t7610-mergetool
Message-ID: <20170303134015.GA6235@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to this, the test cases would use 'test_expect_failure' to detect
a merge conflict. This changes the test case to use 'test_expect_code 1'
which is more specific.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 76 ++++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 381b7df45..a9e274add 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -130,7 +130,7 @@ test_expect_success 'custom mergetool' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master >/dev/null 2>&1 &&
+	test_expect_code 1 git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool file1 file1 ) &&
 	( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
@@ -153,7 +153,7 @@ test_expect_success 'mergetool crlf' '
 	# test_when_finished is LIFO.)
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
-	test_must_fail git merge master >/dev/null 2>&1 &&
+	test_expect_code 1 git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
@@ -176,7 +176,7 @@ test_expect_success 'mergetool in subdir' '
 	git submodule update -N &&
 	(
 		cd subdir &&
-		test_must_fail git merge master >/dev/null 2>&1 &&
+		test_expect_code 1 git merge master >/dev/null 2>&1 &&
 		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
 		test "$(cat file3)" = "master new sub"
 	)
@@ -188,7 +188,7 @@ test_expect_success 'mergetool on file in parent dir' '
 	git submodule update -N &&
 	(
 		cd subdir &&
-		test_must_fail git merge master >/dev/null 2>&1 &&
+		test_expect_code 1 git merge master >/dev/null 2>&1 &&
 		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
@@ -207,7 +207,7 @@ test_expect_success 'mergetool skips autoresolved' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
@@ -222,7 +222,7 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
-		test_must_fail git merge master &&
+		test_expect_code 1 git merge master &&
 		( yes "r" | git mergetool ../submod ) &&
 		( yes "d" "d" | git mergetool --no-prompt ) &&
 		test "$(cat ../file1)" = "master updated" &&
@@ -241,7 +241,7 @@ test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 	rm -rf .git/rr-cache &&
 	(
 		cd subdir &&
-		test_must_fail git merge master &&
+		test_expect_code 1 git merge master &&
 		( yes "r" | git mergetool ../submod ) &&
 		( yes "d" "d" | git mergetool --no-prompt ) &&
 		test "$(cat ../file1)" = "master updated" &&
@@ -259,7 +259,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	rm -rf .git/rr-cache &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master >/dev/null 2>&1 &&
+	test_expect_code 1 git merge master >/dev/null 2>&1 &&
 	( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
 	( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
 	git submodule update -N &&
@@ -275,7 +275,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 	git stash &&
 
 	git checkout --detach stash2 &&
-	test_must_fail git stash apply &&
+	test_expect_code 1 git stash apply &&
 
 	test -n "$(git ls-files -u)" &&
 	conflicts="$(git rerere remaining)" &&
@@ -286,7 +286,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 	git commit -am "save the stash resolution" &&
 
 	git reset --hard stash2 &&
-	test_must_fail git stash apply &&
+	test_expect_code 1 git stash apply &&
 
 	test -n "$(git ls-files -u)" &&
 	conflicts="$(git rerere remaining)" &&
@@ -300,7 +300,7 @@ test_expect_success 'mergetool takes partial path' '
 	test_config rerere.enabled false &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 
 	( yes "" | git mergetool subdir ) &&
 
@@ -310,15 +310,15 @@ test_expect_success 'mergetool takes partial path' '
 test_expect_success 'mergetool delete/delete conflict' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
-	test_must_fail git merge move-to-b &&
+	test_expect_code 1 git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
 	git reset --hard &&
-	test_must_fail git merge move-to-b &&
+	test_expect_code 1 git merge move-to-b &&
 	echo m | git mergetool a/a/file.txt &&
 	test -f b/b/file.txt &&
 	git reset --hard &&
-	test_must_fail git merge move-to-b &&
+	test_expect_code 1 git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt
 '
@@ -327,7 +327,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepBackup true &&
-	test_must_fail git merge move-to-b &&
+	test_expect_code 1 git merge move-to-b &&
 	: >expect &&
 	echo d | git mergetool a/a/file.txt 2>actual &&
 	test_cmp expect actual &&
@@ -338,7 +338,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries false &&
-	test_must_fail git merge move-to-b &&
+	test_expect_code 1 git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -d a
 '
@@ -348,7 +348,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	test_when_finished "git clean -fdx" &&
 	git checkout -b test$test_count move-to-c &&
 	test_config mergetool.keepTemporaries true &&
-	test_must_fail git merge move-to-b &&
+	test_expect_code 1 git merge move-to-b &&
 	! (echo a; echo n) | git mergetool a/a/file.txt &&
 	test -d a/a &&
 	cat >expect <<-\EOF &&
@@ -368,7 +368,7 @@ test_expect_success 'deleted vs modified submodule' '
 	git rm --cached submod &&
 	git commit -m "Submodule deleted from branch" &&
 	git checkout -b test$test_count.a test$test_count &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -385,7 +385,7 @@ test_expect_success 'deleted vs modified submodule' '
 	mv submod submod-movedaside &&
 	git checkout -b test$test_count.b test$test_count &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -399,7 +399,7 @@ test_expect_success 'deleted vs modified submodule' '
 	mv submod-movedaside submod &&
 	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
-	test_must_fail git merge test$test_count &&
+	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -415,7 +415,7 @@ test_expect_success 'deleted vs modified submodule' '
 
 	git checkout -b test$test_count.d master &&
 	git submodule update -N &&
-	test_must_fail git merge test$test_count &&
+	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -439,7 +439,7 @@ test_expect_success 'file vs modified submodule' '
 	git add submod &&
 	git commit -m "Submodule path becomes file" &&
 	git checkout -b test$test_count.a branch1 &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -455,7 +455,7 @@ test_expect_success 'file vs modified submodule' '
 
 	mv submod submod-movedaside &&
 	git checkout -b test$test_count.b test$test_count &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -471,7 +471,7 @@ test_expect_success 'file vs modified submodule' '
 	rmdir submod && mv submod-movedaside submod &&
 	test ! -e submod.orig &&
 	git submodule update -N &&
-	test_must_fail git merge test$test_count &&
+	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -487,7 +487,7 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.d master &&
 	rmdir submod && mv submod.orig submod &&
 	git submodule update -N &&
-	test_must_fail git merge test$test_count &&
+	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both>/dev/null 2>&1 ) &&
@@ -544,7 +544,7 @@ test_expect_success 'submodule in subdirectory' '
 	git add subdir/subdir_module &&
 	git commit -m "change submodule in subdirectory on test$test_count.b" &&
 
-	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
+	test_expect_code 1 git merge test$test_count.a >/dev/null 2>&1 &&
 	(
 		cd subdir &&
 		( yes "l" | git mergetool subdir_module )
@@ -555,7 +555,7 @@ test_expect_success 'submodule in subdirectory' '
 	git reset --hard &&
 	git submodule update -N &&
 
-	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
+	test_expect_code 1 git merge test$test_count.a >/dev/null 2>&1 &&
 	( yes "r" | git mergetool subdir/subdir_module ) &&
 	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
@@ -573,14 +573,14 @@ test_expect_success 'directory vs modified submodule' '
 	git add submod/file16 &&
 	git commit -m "Submodule path becomes directory" &&
 
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "l" | git mergetool submod ) &&
 	test "$(cat submod/file16)" = "not a submodule" &&
 	rm -rf submod.orig &&
 
 	git reset --hard &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
 	( yes "r" | git mergetool submod ) &&
@@ -596,7 +596,7 @@ test_expect_success 'directory vs modified submodule' '
 
 	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
-	test_must_fail git merge test$test_count &&
+	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "l" | git mergetool submod ) &&
 	git submodule update -N &&
@@ -604,7 +604,7 @@ test_expect_success 'directory vs modified submodule' '
 
 	git reset --hard &&
 	git submodule update -N &&
-	test_must_fail git merge test$test_count &&
+	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
 	( yes "r" | git mergetool submod ) &&
@@ -618,7 +618,7 @@ test_expect_success 'directory vs modified submodule' '
 test_expect_success 'file with no base' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	>expected &&
 	test_cmp both expected
@@ -629,7 +629,7 @@ test_expect_success 'custom commands override built-ins' '
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
 	echo master both added >expected &&
 	test_cmp both expected
@@ -641,7 +641,7 @@ test_expect_success 'filenames seen by tools start with ./' '
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
 	grep ^\./both_LOCAL_ actual >/dev/null
 '
@@ -658,7 +658,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-	test_must_fail git merge master &&
+	test_expect_code 1 git merge master &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
 	! grep ^\./both_LOCAL_ actual >/dev/null &&
 	grep /both_LOCAL_ actual >/dev/null
@@ -672,7 +672,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 	test_config mergetool.myecho.trustExitCode true &&
 	echo b >order-file &&
 	echo a >>order-file &&
-	test_must_fail git merge order-file-side1 &&
+	test_expect_code 1 git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
 		b
@@ -695,7 +695,7 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	test_config mergetool.myecho.trustExitCode true &&
 	echo b >order-file &&
 	echo a >>order-file &&
-	test_must_fail git merge order-file-side1 &&
+	test_expect_code 1 git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
 		a
@@ -707,7 +707,7 @@ test_expect_success 'mergetool -Oorder-file is honored' '
 	git reset --hard &&
 
 	git config --unset diff.orderFile &&
-	test_must_fail git merge order-file-side1 &&
+	test_expect_code 1 git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
 		b
-- 
2.12.0.5.gfbc750a84

