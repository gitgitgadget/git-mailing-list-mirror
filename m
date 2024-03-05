Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADE12CD8B
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674000; cv=none; b=OORq+cgGxT3Dr1QjGVcTqN/d8yLdQgNiltgQOnoHctS8mOBlHwhukZC6a+Lj/p4yGTMm6w8z1+2pqEi6Vix7P2VJKNKbV+WtdToiC36HcpKURqn/BKguG5r24G+azSpxJlCn3A7p8/fkexnGZ5/QKNvmyRzvGf42WtTnlQMxhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674000; c=relaxed/simple;
	bh=N/pdj6XusojQL4eU8krFGbCGtjURhu62+Yd/P4EVWtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/t6kl01ZXFsa1rkC9iPqzRt8lm3l1SK/ELolVHh0u72G6+KrwlH9EXqg2X1XO5xn2jd4Fwhh9jycW52kOnE/w9uIk01NBvy46s7uYBLGFvOcp5XH2d0JEQME97GzR/GWETZaNH9Tu2jbqehiBuCHxqtzwCUOY5OBCJcCPJ3tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ2-000000002RL-1oPE
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:36 +0100
Received: from [10.20.10.233] (port=51162 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ1-006Kd3-12;
	Tue, 05 Mar 2024 22:26:35 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 013C1180036;
	Tue,  5 Mar 2024 22:26:33 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:33 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 09/22] t/t4*: avoid redundant uses of cat
Date: Tue,  5 Mar 2024 22:25:08 +0100
Message-ID: <20240305212533.12947-10-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t4020-diff-external.sh         | 2 +-
 t/t4150-am.sh                    | 2 +-
 t/t4205-log-pretty-formats.sh    | 2 +-
 t/t4301-merge-tree-write-tree.sh | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index c1ac09ecc714..fdd865f7c38d 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -232,7 +232,7 @@ keep_only_cr () {
 test_expect_success 'external diff with autocrlf = true' '
 	test_config core.autocrlf true &&
 	GIT_EXTERNAL_DIFF=./fake-diff.sh git diff &&
-	test $(wc -l < crlfed.txt) = $(cat crlfed.txt | keep_only_cr | wc -c)
+	test $(wc -l < crlfed.txt) = $(keep_only_cr <crlfed.txt | wc -c)
 '
 
 test_expect_success 'diff --cached' '
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3b125762694e..080a07e9d414 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -786,7 +786,7 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	cat pine patch1 | git am &&
+	git am pine patch1 &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code main^..HEAD
 '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e3d655e6b8b5..1409eebcd855 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --pretty=oneline' '
 	for r in $revs
 	do
 		git show -s --pretty=oneline "$r" >raw &&
-		cat raw | lf_to_nul || return 1
+		lf_to_nul <raw || return 1
 	done >expect &&
 	# the trailing NUL is already produced so we do not need to
 	# output another one
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 12ac43687366..578641467753 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -313,7 +313,7 @@ test_expect_success 'rename/add handling' '
 		# First, check that the bar that appears at stage 3 does not
 		# correspond to an individual blob anywhere in history
 		#
-		hash=$(cat out | tr "\0" "\n" | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
+		hash=$(tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
 		git rev-list --objects --all >all_blobs &&
 		! grep $hash all_blobs &&
 
@@ -380,7 +380,7 @@ test_expect_success SYMLINKS 'rename/add, where add is a mode conflict' '
 		# First, check that the bar that appears at stage 3 does not
 		# correspond to an individual blob anywhere in history
 		#
-		hash=$(cat out | tr "\0" "\n" | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
+		hash=$(tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
 		git rev-list --objects --all >all_blobs &&
 		! grep $hash all_blobs &&
 
@@ -630,8 +630,8 @@ test_expect_success 'mod6: chains of rename/rename(1to2) and add/add via collidi
 		# conflict entries do not appear as individual blobs anywhere
 		# in history.
 		#
-		hash1=$(cat out | tr "\0" "\n" | head | grep 2.four | cut -f 2 -d " ") &&
-		hash2=$(cat out | tr "\0" "\n" | head | grep 3.two | cut -f 2 -d " ") &&
+		hash1=$(tr "\0" "\n" <out | head | grep 2.four | cut -f 2 -d " ") &&
+		hash2=$(tr "\0" "\n" <out | head | grep 3.two | cut -f 2 -d " ") &&
 		git rev-list --objects --all >all_blobs &&
 		! grep $hash1 all_blobs &&
 		! grep $hash2 all_blobs &&
-- 
2.44.0

