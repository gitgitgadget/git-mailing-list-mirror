Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242C12E1EC
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674011; cv=none; b=OQP59UKtdqwz9qn90TnneScsDih3nZeDX33Jr2uQ5XkuOm5DMQ/JtZiwjcO6rQzYZtCzGLKhujZqNK7W9nfDyCg/cmzAC5VkznIEmO5ROANEa55uFsZkvjGtLjdkacG0ZnwWgYV6GWbNFyXAhNPoLex0m0YxlQxsRcxpX7hiFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674011; c=relaxed/simple;
	bh=RaiJBvfdwM0IBON5om0eZMvZqyxRk7w1In78tX1qsHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6/yHNd/nkk3mCrednGAFUR7tqS4C7hBnEAV/HUGHR6i1CCChpRI1TzNtkvOwWLw0R+Gk2s/mwAJ8DRpPrzYqk0wzfWu0SaEytMPs7udEu3C5pl9Zdjr4K1WmwjvuvIxGol96XPgLqtuEPTM0LCBEGS87aAQJ3SPtvGXfSnn3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJD-000000002UH-1J5A
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:47 +0100
Received: from [10.20.10.233] (port=56146 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJC-006Khn-0e;
	Tue, 05 Mar 2024 22:26:46 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id DDE82180036;
	Tue,  5 Mar 2024 22:26:44 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:44 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 19/22] t/t8*: merge "grep | sed" pipelines
Date: Tue,  5 Mar 2024 22:25:18 +0100
Message-ID: <20240305212533.12947-20-dev+git@drbeat.li>
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
 t/t8013-blame-ignore-revs.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 9a03b0f361ff..05213d13f30f 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -25,11 +25,11 @@ test_expect_success setup '
 
 	git blame --line-porcelain file >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse X >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
 	git rev-parse X >expect &&
 	test_cmp expect actual
 '
@@ -53,11 +53,11 @@ do
 	test_expect_success "ignore_rev_changing_lines ($I)" '
 		git blame --line-porcelain --ignore-rev $I file >blame_raw &&
 
-		grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+		sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
 		git rev-parse A >expect &&
 		test_cmp expect actual &&
 
-		grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+		sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
 		git rev-parse B >expect &&
 		test_cmp expect actual
 	'
@@ -79,10 +79,10 @@ test_expect_success ignore_rev_adding_unblamable_lines '
 	git rev-parse Y >expect &&
 	git blame --line-porcelain file --ignore-rev Y >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 3" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 3/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 4" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 4/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual
 '
 
@@ -92,11 +92,11 @@ test_expect_success ignore_revs_from_files '
 	git rev-parse Y >ignore_y &&
 	git blame --line-porcelain file --ignore-revs-file ignore_x --ignore-revs-file ignore_y >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse A >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
 '
@@ -106,11 +106,11 @@ test_expect_success ignore_revs_from_configs_and_files '
 	git config --add blame.ignoreRevsFile ignore_x &&
 	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse A >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual
 '
@@ -121,10 +121,10 @@ test_expect_success override_ignore_revs_file '
 	git blame --line-porcelain file --ignore-revs-file "" --ignore-revs-file ignore_y >blame_raw &&
 	git rev-parse X >expect &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 2" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 2/s/ .*//p" blame_raw >actual &&
 	test_cmp expect actual
 	'
 test_expect_success bad_files_and_revs '
@@ -279,11 +279,11 @@ test_expect_success ignore_merge '
 	test_merge M B &&
 	git blame --line-porcelain file --ignore-rev M >blame_raw &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 1" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 1/s/ .*//p" blame_raw >actual &&
 	git rev-parse B >expect &&
 	test_cmp expect actual &&
 
-	grep -E "^[0-9a-f]+ [0-9]+ 9" blame_raw | sed -e "s/ .*//" >actual &&
+	sed -Ene "/^[0-9a-f]+ [0-9]+ 9/s/ .*//p" blame_raw >actual &&
 	git rev-parse C >expect &&
 	test_cmp expect actual
 '
-- 
2.44.0

