Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18D5476B
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532009; cv=none; b=SbIO9Iu9vTwapptgoFpaB8NIVTO1j9jcWJe+jJFsZIHYQ9dG16AUm094XmGSwxUGfuLu/Boaf1DAEKB8lajbTm7Cs0qbtrERtAsv0RvOZfbA3DXHrzKNo8YhFkFAkPQMOvkwlc3WJeI8y+ir3R14SSBRjq2PCnw558HbNGWHaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532009; c=relaxed/simple;
	bh=pkGynKvFHmv3PcB6tolzFBptcZ8zfs3vSIFy0dC9LXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6LzcrwnSn8AAtNS5e1I+2mvaq7CdaNT+Fag7bbAgcvrTxAGKFqtyc4qifB42BE0DGpVRKPl3v+9zesciumreJwi9wX2ori/uvkoPPHW0iI+3HTVCjHq6YeUwfY9zCsPeGXUeCDHbgMBzLUkPLXvV5pdB0IFZoUoTVwrh0O2mdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVq-000000002CH-0dgM
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:42 +0100
Received: from [10.20.10.231] (port=8074 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVp-006alx-08;
	Fri, 15 Mar 2024 20:46:41 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id AB0B0180130;
	Fri, 15 Mar 2024 20:46:39 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:39 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 09/22] t/t4*: avoid redundant uses of cat
Date: Fri, 15 Mar 2024 20:46:06 +0100
Message-ID: <20240315194620.10713-10-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
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
 t/t4205-log-pretty-formats.sh    | 2 +-
 t/t4301-merge-tree-write-tree.sh | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index c1ac09ecc714..fdd865f7c38d 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -232,7 +232,7 @@ keep_only_cr () {
 test_expect_success 'external diff with autocrlf = true' '
 	test_config core.autocrlf true &&
 	GIT_EXTERNAL_DIFF=./fake-diff.sh git diff &&
-	test $(wc -l < crlfed.txt) = $(cat crlfed.txt | keep_only_cr | wc -c)
+	test $(wc -l <crlfed.txt) = $(keep_only_cr <crlfed.txt | wc -c)
 '
 
 test_expect_success 'diff --cached' '
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

