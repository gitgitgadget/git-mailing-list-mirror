Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E912D219
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674005; cv=none; b=j1IhAPav7XFLQvhjfzFyiZOC0HORdmgp0MNS2SANe0Kri4aH13civSRsJuFPHO8vwHC3ZDCFKGt/kTvqitnUQyDupoJwqcfNzCMEfLzr9No9QypzDtTiXGUgr8DMOXWOCLjWzg1yytrjRjD5KLHh9nIF2K0160fgkpTz/biHQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674005; c=relaxed/simple;
	bh=JovhWDeiCpwd158IsnVIofnu9jLKY4GQWGMRZfKoGC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Exh6tIK/K8CW42LdA26DmnUkcST/HSziqUyMrPmkaerP28fsrgO/vOl1cLfiKxbsBv4kSRVaUeKE8M8wh6E6gY2HuuSquoWy9g4iq8Kxa7DBg9Dx16oXIdgP0vEAZhvfIzzrlBma3H9k+My6X444j2xNblrT3bg2SBeCwRc2iNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ4-000000002Rp-2Se5
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:38 +0100
Received: from [10.20.10.233] (port=52108 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ3-006Kdy-1Y;
	Tue, 05 Mar 2024 22:26:37 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 2BF6B180036;
	Tue,  5 Mar 2024 22:26:36 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:36 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 11/22] t/t6*: avoid redundant uses of cat
Date: Tue,  5 Mar 2024 22:25:10 +0100
Message-ID: <20240305212533.12947-12-dev+git@drbeat.li>
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
 t/t6112-rev-list-filters-objects.sh | 2 +-
 t/t6413-merge-crlf.sh               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 52822b9461a1..43e1afd44c9b 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -670,7 +670,7 @@ test_expect_success 'rev-list W/ --missing=print' '
 	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	for id in `cat expected | sed "s|..|&/|"`
+	for id in `sed "s|..|&/|" expected`
 	do
 		rm r1/.git/objects/$id || return 1
 	done &&
diff --git a/t/t6413-merge-crlf.sh b/t/t6413-merge-crlf.sh
index b4f4a313f486..647ea1e83829 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -34,14 +34,14 @@ test_expect_success setup '
 test_expect_success 'Check "ours" is CRLF' '
 	git reset --hard initial &&
 	git merge side -s ours &&
-	cat file | remove_cr | append_cr >file.temp &&
+	remove_cr <file | append_cr >file.temp &&
 	test_cmp file file.temp
 '
 
 test_expect_success 'Check that conflict file is CRLF' '
 	git reset --hard a &&
 	test_must_fail git merge side &&
-	cat file | remove_cr | append_cr >file.temp &&
+	remove_cr <file | append_cr >file.temp &&
 	test_cmp file file.temp
 '
 
-- 
2.44.0

