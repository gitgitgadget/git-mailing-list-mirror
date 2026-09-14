Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366341441F
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397395; cv=none; b=sQkPV9PanyqAd3BN0NQWhQNEXRMLO4j8tdFe1ew9hvrhudmj1V1FJDvXBZ78D7bGFKQH0l+/TpVf8hQnu2nFvZWs7SJ/kUmGMpjAj/y08JjJj2RHU+Q5uTNG1flymNr9dbBCsss79C1Su5wsTFrEGYtbIOxAS0FATAsJcm8bRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397395; c=relaxed/simple;
	bh=iqQ/ZV+tnWSWYLfQid6pmirlpAFenn0k4Ceclzvc4D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fYCo6XjFSZS+iEJmsYx6gIsMfHglYGraiQqWFgkOFV+5p/720oOmzxatTQVUyjrn5TZe2lP1Emc1dOFHjpi3aoRu6zDqDLKhvzfcWODb1ddawLFG7tXdo247yejFRD+rjnP/XkXO/N8Nv4MhwVKpG0yN5dKRnBRWpfQeQu9PHuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOkWV9rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOkWV9rc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74D14C2BCB8;
	Mon, 14 Sep 2026 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789397394;
	bh=iqQ/ZV+tnWSWYLfQid6pmirlpAFenn0k4Ceclzvc4D0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=DOkWV9rc085WPWgrkPy5OgSCuUWHzulsHILKruTO5eJFCWCqm+3hSTwbrtG0SoBGU
	 cJge3/hGikSOXr0NyP18nYJcuN91qfhKy5gyzHs243ISEz6zR00lk/tVrZpz6GKEcc
	 J8+y34LA5p57vGPLCTFLd64/RLYfkN+HOpKjhM34QEb7S4ofgPIpjmkZxzpe33VCA8
	 PBgGHJftiBts0f33rIXsysejRkcNa/lqkSa20zBAu/+GRHeBJ0PocoseHcY2PTFqj3
	 Bae9v04h50bzwb1T/WXfYmTiVmkD0ZRNieOa9g83G7uq+uPbVraqwWWhTmX5iP+pPy
	 ZUhCRAxaN09YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD0AC88E75;
	Mon, 14 Sep 2026 14:49:54 +0000 (UTC)
From: Tanishq Singh via B4 Relay <devnull+hello.tanishqsingh.com@kernel.org>
Date: Mon, 14 Sep 2026 20:19:48 +0530
Subject: [PATCH] t7610: use test_path_is_* helpers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-t7610-test-path-helpers-v1-1-4824812314c7@tanishqsingh.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQ1NJSryIuYuevGZEaMqkIp
 Xc36vJbvLeRISuMTs1GGS81fS4V/tDQFMNyA6tUU+va3o2+4zL03nGBFU6hRI54JGRjf+wEMkg
 YZaZap4xZ37/z+fK3rdc7pvLd0b5/AIBU8Ft7AAAA
X-Change-ID: 20260914-t7610-test-path-helpers-134ded7da9df
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Tanishq Singh <hello@tanishqsingh.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5179;
 i=hello@tanishqsingh.com; h=from:subject:message-id;
 bh=SstEsXkP2a1L90sd/7PbUtydVPOMrk5Ds/4WWNG3HSw=;
 b=owEBCQL2/ZANAwAIAWLjgbfwh9eVAcsmYgBqqAmQJiRw03/ZzUDDtNruxWI00xzUlXK/GMS3X
 ARXKWkxwHCJAc8EAAEIADkWIQSEk2fht6OHepjEk9Ji44G38IfXlQUCaqgJkBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQYuOBt/CH15VPIAwAiSjwzV1Ys+CVFaWORP3xJFCboSPJdkY
 vt1N2KZrVHSYIkZiMdO6nWl3KmDpbwdPkw59MQc2O2iapXIOh8PzOuZSh9yAufBAsmugWshsGLR
 jbEcf71kHFxXxv2UYXMDhXkLyMgpZbcX0yPvP+ndW7A8LJT9Xi574bwVADL14Ac72K2SlAqejZb
 K7DKbgC3NuZFszaC3PZw8+PkRs9k5PAUuuTPkN+gu3gotR8grLpJgtuKtMMHd+uCC0j4UkvYIdF
 9fACef7kyy6D4pdJaNsYAQADVqCmCe94CzMeE271/IMf7i6ofrA0agoRjCk2LCOQFwqB6qIjITG
 jB6U5KMWyavDaa0lCwtoy2Mj9LPOHUdW55ddtX3NgvP5Tf+hRCbzm8Fqw4UCxQBw969b04HHQat
 q0HLN1VImQf+jiuy9bd1YOI0PrTXYsgD7cQoZvoYOSh/ASedLw4+uIpGKLLi15YzxgMBb5AN4U6
 Cx/WvYhDpJuJ5E8z1tAVZPBAeiYBZPV
X-Developer-Key: i=hello@tanishqsingh.com; a=openpgp;
 fpr=849367E1B7A3877A98C493D262E381B7F087D795
X-Endpoint-Received: by B4 Relay for hello@tanishqsingh.com/default with
 auth_id=1031
X-Original-From: Tanishq Singh <hello@tanishqsingh.com>
Reply-To: hello@tanishqsingh.com

From: Tanishq Singh <hello@tanishqsingh.com>

Replace 'test -f', 'test -d' and 'test ! -e' with the
test_path_is_file(), test_path_is_dir() and test_path_is_missing()
helpers. The helpers print the directory listing on failure, which
makes diagnosing a broken test easier than non-zero exit status
offered by 'test'.

Signed-off-by: Tanishq Singh <hello@tanishqsingh.com>
---
Verified with `cd t && ./t7610-mergetool.sh`,
and all tests pass.
---
 t/t7610-mergetool.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 0128b14452..92ac8f3fb6 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -382,15 +382,15 @@ test_expect_success 'mergetool delete/delete conflict' '
 	git checkout -b test$test_count move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
-	! test -f a/a/file.txt &&
+	! test_path_is_file a/a/file.txt &&
 	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	echo m | git mergetool a/a/file.txt &&
-	test -f b/b/file.txt &&
+	test_path_is_file b/b/file.txt &&
 	git reset --hard &&
 	test_must_fail git merge move-to-b &&
 	! echo a | git mergetool a/a/file.txt &&
-	! test -f a/a/file.txt
+	! test_path_is_file a/a/file.txt
 '
 
 test_expect_success 'mergetool produces no errors when keepBackup is used' '
@@ -400,7 +400,7 @@ test_expect_success 'mergetool produces no errors when keepBackup is used' '
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt 2>actual &&
 	test_must_be_empty actual &&
-	! test -d a
+	! test_path_is_dir a
 '
 
 test_expect_success 'mergetool honors tempfile config for deleted files' '
@@ -409,7 +409,7 @@ test_expect_success 'mergetool honors tempfile config for deleted files' '
 	test_config mergetool.keepTemporaries false &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
-	! test -d a
+	! test_path_is_dir a
 '
 
 test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
@@ -419,7 +419,7 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 	test_config mergetool.keepTemporaries true &&
 	test_must_fail git merge move-to-b &&
 	! test_write_lines a n | git mergetool a/a/file.txt &&
-	test -d a/a &&
+	test_path_is_dir a/a &&
 	cat >expect <<-\EOF &&
 	file_BASE_.txt
 	file_LOCAL_.txt
@@ -462,7 +462,7 @@ test_expect_success 'deleted vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
-	test ! -e submod &&
+	test_path_is_missing submod &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by deleting module" &&
@@ -476,8 +476,8 @@ test_expect_success 'deleted vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "r" | git mergetool submod &&
-	test ! -e submod &&
-	test -d submod.orig &&
+	test_path_is_missing submod &&
+	test_path_is_dir submod.orig &&
 	git submodule update -N &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
@@ -547,7 +547,7 @@ test_expect_success 'file vs modified submodule' '
 
 	git checkout -b test$test_count.c main &&
 	rmdir submod && mv submod-movedaside submod &&
-	test ! -e submod.orig &&
+	test_path_is_missing submod.orig &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
@@ -558,7 +558,7 @@ test_expect_success 'file vs modified submodule' '
 	git rm --cached submod &&
 	yes "c" | git mergetool submod~test19 &&
 	git mv submod~test19 submod &&
-	test -d submod.orig &&
+	test_path_is_dir submod.orig &&
 	git submodule update -N &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod &&
@@ -672,11 +672,11 @@ test_expect_success 'directory vs modified submodule' '
 	git reset --hard &&
 	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
-	test ! -e submod.orig &&
+	test_path_is_missing submod.orig &&
 	yes "r" | git mergetool submod~main &&
 	git mv submod submod.orig &&
 	git mv submod~main submod &&
-	test -d submod.orig &&
+	test_path_is_dir submod.orig &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod.orig/file16 &&
 	rm -r submod.orig &&
@@ -701,7 +701,7 @@ test_expect_success 'directory vs modified submodule' '
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	test ! -e submod.orig &&
+	test_path_is_missing submod.orig &&
 	yes "r" | git mergetool submod &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod/file16 &&
@@ -743,7 +743,7 @@ test_expect_success 'filenames seen by tools start with ./' '
 
 test_lazy_prereq MKTEMP '
 	tempdir=$(mktemp -d -t foo.XXXXXX) &&
-	test -d "$tempdir" &&
+	test_path_is_dir "$tempdir" &&
 	rmdir "$tempdir"
 '
 

---
base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
change-id: 20260914-t7610-test-path-helpers-134ded7da9df


