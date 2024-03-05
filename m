Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447912D778
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674005; cv=none; b=ieKQoF8ZkyDoWosDZVo2BYmp8xqmF6Szmuckc5RVerDTWSkZ92v+k22gfBVOEkRvtF3KcPkG/uqo3aIgKBBU//bvAu5ywCI49XzuFCzRDvvUndKyHN+C0EXIKlt4a1TG2v69uczULxgG1NDyljx3bKeEx6seuR/wChWnLTmJzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674005; c=relaxed/simple;
	bh=cnew7OjLZRXLoGzQx542dW2W8zwQSofBBxUR1M3a938=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHGwm1yzqTwqXJy3dOoDzXEVw5IMEqM8ocN+GUzFnVpQ3zqNjq9BZ5iKhQj+XV/r2nw2Y76HdWLuXVN3uAqPcdiF0xsvuHnLzFSpb69ZBr9LgyV9mYaRhIaIBsRMHXEjMm6wxVxa2kOyj6u/XvYavGh9AfxfZXdP1CJw7u9MKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ7-000000002Se-3y7D
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:42 +0100
Received: from [10.20.10.230] (port=32798 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ6-006KfP-2Y;
	Tue, 05 Mar 2024 22:26:40 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 70E3218012F;
	Tue,  5 Mar 2024 22:26:39 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:39 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 14/22] t/t9*: avoid redundant uses of cat
Date: Tue,  5 Mar 2024 22:25:13 +0100
Message-ID: <20240305212533.12947-15-dev+git@drbeat.li>
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
 t/t9300-fast-import.sh          | 10 +++++-----
 t/t9350-fast-export.sh          |  2 +-
 t/t9400-git-cvsserver-server.sh | 35 +++++++++++++++------------------
 t/t9802-git-p4-filetype.sh      |  2 +-
 t/t9807-git-p4-submit.sh        |  2 +-
 t/t9824-git-p4-git-lfs.sh       |  4 ++--
 6 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index dbb5042b0b8f..c03adbdd145f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -986,7 +986,7 @@ test_expect_success 'L: nested tree copy does not corrupt deltas' '
 	test_when_finished "git update-ref -d refs/heads/L2" &&
 	git fast-import <input &&
 	git ls-tree L2 g/b/ >tmp &&
-	cat tmp | cut -f 2 >actual &&
+	cut -f 2 <tmp >actual &&
 	test_cmp expect actual &&
 	git fsck $(git rev-parse L2)
 '
@@ -2012,7 +2012,7 @@ test_expect_success 'Q: verify first notes tree' '
 	100644 blob $commit2
 	100644 blob $commit3
 	EOF
-	cat expect.unsorted | sort >expect &&
+	sort expect.unsorted >expect &&
 	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
@@ -2053,7 +2053,7 @@ test_expect_success 'Q: verify second notes tree' '
 	100644 blob $commit2
 	100644 blob $commit3
 	EOF
-	cat expect.unsorted | sort >expect &&
+	sort expect.unsorted >expect &&
 	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
@@ -2091,7 +2091,7 @@ test_expect_success 'Q: verify third notes tree' '
 	cat >expect.unsorted <<-EOF &&
 	100644 blob $commit1
 	EOF
-	cat expect.unsorted | sort >expect &&
+	sort expect.unsorted >expect &&
 	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
@@ -2118,7 +2118,7 @@ test_expect_success 'Q: verify fourth notes tree' '
 	cat >expect.unsorted <<-EOF &&
 	100644 blob $commit2
 	EOF
-	cat expect.unsorted | sort >expect &&
+	sort expect.unsorted >expect &&
 	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index e9a12c18bbd3..d86d07a79d4f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -236,7 +236,7 @@ EOF
 
 test_expect_success 'set up faked signed tag' '
 
-	cat signed-tag-import | git fast-import
+	git fast-import <signed-tag-import
 
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 003c0b61d0ff..e499c7f95512 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -117,12 +117,12 @@ END VERIFICATION REQUEST
 EOF
 
 test_expect_success 'pserver authentication' '
-	cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
+	git-cvsserver pserver <request-anonymous >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'pserver authentication failure (non-anonymous user)' '
-	if cat request-git | git-cvsserver pserver >log 2>&1
+	if git-cvsserver pserver <request-git >log 2>&1
 	then
 	    false
 	else
@@ -132,17 +132,17 @@ test_expect_success 'pserver authentication failure (non-anonymous user)' '
 '
 
 test_expect_success 'pserver authentication success (non-anonymous user with password)' '
-	cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
+	git-cvsserver pserver <login-git-ok >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'pserver authentication (login)' '
-	cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
+	git-cvsserver pserver <login-anonymous >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'pserver authentication failure (login/non-anonymous user)' '
-	if cat login-git | git-cvsserver pserver >log 2>&1
+	if git-cvsserver pserver <login-git >log 2>&1
 	then
 	    false
 	else
@@ -172,7 +172,7 @@ Root $WORKDIR
 EOF
 
 test_expect_success 'req_Root failure (relative pathname)' '
-	if cat request-relative | git-cvsserver pserver >log 2>&1
+	if git-cvsserver pserver <request-relative >log 2>&1
 	then
 		echo unexpected success
 		false
@@ -183,28 +183,26 @@ test_expect_success 'req_Root failure (relative pathname)' '
 '
 
 test_expect_success 'req_Root failure (conflicting roots)' '
-	cat request-conflict | git-cvsserver pserver >log 2>&1 &&
+	git-cvsserver pserver <request-conflict >log 2>&1 &&
 	tail log | grep "^error 1 Conflicting roots specified$"
 '
 
 test_expect_success 'req_Root (strict paths)' '
-	cat request-anonymous | git-cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
+	git-cvsserver --strict-paths pserver "$SERVERDIR" <request-anonymous >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'req_Root failure (strict-paths)' '
-	! cat request-anonymous |
-	git-cvsserver --strict-paths pserver "$WORKDIR" >log 2>&1
+	! git-cvsserver --strict-paths pserver "$WORKDIR" <request-anonymous >log 2>&1
 '
 
 test_expect_success 'req_Root (w/o strict-paths)' '
-	cat request-anonymous | git-cvsserver pserver "$WORKDIR/" >log 2>&1 &&
+	git-cvsserver pserver "$WORKDIR/" <request-anonymous >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
-	! cat request-anonymous |
-	git-cvsserver pserver "$WORKDIR/gitcvs" >log 2>&1
+	! git-cvsserver pserver "$WORKDIR/gitcvs" <request-anonymous >log 2>&1
 '
 
 cat >request-base  <<EOF
@@ -217,27 +215,26 @@ Root /gitcvs.git
 EOF
 
 test_expect_success 'req_Root (base-path)' '
-	cat request-base | git-cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
+	git-cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" <request-base >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'req_Root failure (base-path)' '
-	! cat request-anonymous |
-	git-cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" >log 2>&1
+	! git-cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" <request-anonymous >log 2>&1
 '
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
 test_expect_success 'req_Root (export-all)' '
-	cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
+	git-cvsserver --export-all pserver "$WORKDIR" <request-anonymous >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
 test_expect_success 'req_Root failure (export-all w/o directory list)' '
-	! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
+	! (git-cvsserver --export-all pserver <request-anonymous >log 2>&1 || false)'
 
 test_expect_success 'req_Root (everything together)' '
-	cat request-base | git-cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
+	git-cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" <request-base >log 2>&1 &&
 	sed -ne \$p log | grep "^I LOVE YOU\$"
 '
 
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 2a6ee2a46787..bb236cd2b57a 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -175,7 +175,7 @@ test_expect_success 'keyword file create' '
 		cp k-text-k k-text-ko &&
 		p4 add -t text+ko k-text-ko &&
 
-		cat k-text-k | iconv -f ascii -t utf-16 >k-utf16-k &&
+		iconv -f ascii -t utf-16 <k-text-k >k-utf16-k &&
 		p4 add -t utf16+k k-utf16-k &&
 
 		cp k-utf16-k k-utf16-ko &&
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index af4b286f9d51..6ae7ced51be1 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -418,7 +418,7 @@ test_expect_success 'description with Jobs and values on separate lines' '
 			marshal_dump job0 <change &&
 			marshal_dump job1 <change
 		) | sort >jobs &&
-		cat jobname1 jobname2 | sort >expected &&
+		sort jobname1 jobname2 >expected &&
 		test_cmp expected jobs
 	)
 '
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index a28dbbdd566c..fd430403d716 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -17,8 +17,8 @@ test_file_in_lfs () {
 	sed -n '2,2 p' "$FILE" | grep "^oid " &&
 	sed -n '3,3 p' "$FILE" | grep "^size " &&
 	test_line_count = 3 "$FILE" &&
-	cat "$FILE" | grep "size $SIZE" &&
-	HASH=$(cat "$FILE" | grep "oid sha256:" | sed -e "s/oid sha256://g") &&
+	grep "size $SIZE" "$FILE" &&
+	HASH=$(grep "oid sha256:" "$FILE" | sed -e "s/oid sha256://g") &&
 	LFS_FILE=".git/lfs/objects/$(echo "$HASH" | cut -c1-2)/$(echo "$HASH" | cut -c3-4)/$HASH" &&
 	echo $EXPECTED_CONTENT >expect &&
 	test_path_is_file "$FILE" &&
-- 
2.44.0

