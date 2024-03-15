Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF195476B
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532020; cv=none; b=PE2oGq54PJf4ZR2aWywVlRRaTiPIe/enWtBN0kVLyALuEVh8StoTbU1yHEZGg9Pp8mVX3QQHyAGgcEm5XAD9VzfFZ+ZZfd/svJrgd82kKT1HnT4cVbYy2BZrLU4jQ7LVmdcOiC2QhxgbSJKwG8SfY/57vRZAtkUKyLHurq+QHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532020; c=relaxed/simple;
	bh=00qYA7JTXb+lUKMTo/3W3A/ZOBd5zgZTElU8QNd1h1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OegRUX5d+SnaaU5KNMpoQXjIE8xqpyKhqthdG+thCVEWuSAB3+yVa1zuIpMDTgfPVkJlcCdkvZZt0iLMpb/OLIFnCdDxh62WepdDQZQlwtJ9s/EFd+U9M0rbXKnZMnuV/PQDaqRa6xbozSaLQPGO75nVKA+LzTS5JaenzJDd8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW1-000000002Fx-0NBY
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:53 +0100
Received: from [10.20.10.233] (port=35382 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVz-006asC-39;
	Fri, 15 Mar 2024 20:46:51 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id A027A180130;
	Fri, 15 Mar 2024 20:46:50 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:50 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 19/22] t/t8*: merge "grep | sed" pipelines
Date: Fri, 15 Mar 2024 20:46:16 +0100
Message-ID: <20240315194620.10713-20-dev+git@drbeat.li>
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
 t/t8013-blame-ignore-revs.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 9a03b0f361ff..dbfbd86e83a7 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -25,11 +25,11 @@ test_expect_success setup '
 
 	git blame --line-porcelain file >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse X >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
 	git rev-parse X >expect &&
 	test_cmp expect actual
 '
@@ -53,11 +53,11 @@ do
 	test_expect_success "ignore_rev_changing_lines ($I)" '
 		git blame --line-porcelain --ignore-rev $I file >blame_raw &&
 
-		grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
 		git rev-parse A >expect &&
 		test_cmp expect actual &&
 
-		grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+		sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
 		git rev-parse B >expect &&
 		test_cmp expect actual
 	'
@@ -79,10 +79,10 @@ test_expect_success ignore_rev_adding_unblamable_lines '
 	git rev-parse Y >expect &&
 	git blame --line-porcelain file --ignore-rev Y >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 3" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 3/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 4" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 4/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual
 '
 
@@ -92,11 +92,11 @@ test_expect_success ignore_revs_from_files '
 	git rev-parse Y >ignore_y &&
 	git blame --line-porcelain file --ignore-revs-file ignore_x --ignore-revs-file ignore_y >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse A >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
 '
@@ -106,11 +106,11 @@ test_expect_success ignore_revs_from_configs_and_files '
 	git config --add blame.ignoreRevsFile ignore_x &&
 	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse A >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
 '
@@ -121,10 +121,10 @@ test_expect_success override_ignore_revs_file '
 	git blame --line-porcelain file --ignore-revs-file "" --ignore-revs-file ignore_y >blame_raw &&
 	git rev-parse X >expect &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual
 	'
 test_expect_success bad_files_and_revs '
@@ -279,11 +279,11 @@ test_expect_success ignore_merge '
 	test_merge M B &&
 	git blame --line-porcelain file --ignore-rev M >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 9" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 9/s/ .*//p" blame_raw >actual &&
 	git rev-parse C >expect &&
 	test_cmp expect actual
 '
-- 
2.44.0

