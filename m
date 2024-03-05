Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3512AAD1
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674001; cv=none; b=SUrkdGnt7QDnxCX0jD+ggUHPTTI1s66JrbMQgjCBCciF22ohREOsohdKtmQyWu+vDfCMC0+FxAIC4UZP/mUL0OWrZSBvY7WKa6Ch3bqdl9siuRa2Dkn9VNFa21jK6mqyYRzBpnlGbP+4+4E0o/l+txg7XjPfIuF0nqNcgTIKgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674001; c=relaxed/simple;
	bh=b9EAjqiUnNzNOBj2w/QZBJxXrKDtv+hUxrLayEYfGLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBlebvNKQ3oq1W6PbvWcBCWTuuHPkXJEUwp8GLTNQV6+CAdQu56nc+RJQ2mebJHTBlUKYHQMyteXmxfCgp05cOZWrXQs6p95ww7XTperssZIErYPBf7eF0bTXrZ1WdHb1UjhMCDxiGt2SnY1Q670EZBUlQcLaPX5JfkXziaEmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ3-000000002Rd-23z7
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:38 +0100
Received: from [10.20.10.232] (port=32894 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ2-006KdT-1F;
	Tue, 05 Mar 2024 22:26:36 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 16FB118012F;
	Tue,  5 Mar 2024 22:26:35 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:35 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 10/22] t/t5*: avoid redundant uses of cat
Date: Tue,  5 Mar 2024 22:25:09 +0100
Message-ID: <20240305212533.12947-11-dev+git@drbeat.li>
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
 t/t5100-mailinfo.sh                    | 2 +-
 t/t5317-pack-objects-filter-objects.sh | 2 +-
 t/t5534-push-signed.sh                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 654d8cf3ee00..c8d06554541c 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -70,7 +70,7 @@ test_expect_success 'respect NULs' '
 
 	git mailsplit -d3 -o. "$DATA/nul-plain" &&
 	test_cmp "$DATA/nul-plain" 001 &&
-	(cat 001 | git mailinfo msg patch) &&
+	git mailinfo msg patch <001 &&
 	test_line_count = 4 patch
 
 '
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 2ff3eef9a3b8..79552d6ef7f6 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -455,7 +455,7 @@ test_expect_success 'setup r1 - delete loose blobs' '
 	test_parse_ls_files_stage_oids <ls_files_result |
 	sort >expected &&
 
-	for id in `cat expected | sed "s|..|&/|"`
+	for id in `sed "s|..|&/|" expected`
 	do
 		rm r1/.git/objects/$id || return 1
 	done
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index b4bc24691c81..c91a62b77afc 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -303,7 +303,7 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 		EOF
 		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
 	) >expect.in &&
-	key=$(cat "${GNUPGHOME}/trustlist.txt" | cut -d" " -f1 | tr -d ":") &&
+	key=$(cut -d" " -f1 <"${GNUPGHOME}/trustlist.txt" | tr -d ":") &&
 	sed -e "s/^KEY=/KEY=${key}/" expect.in >expect &&
 
 	noop=$(git rev-parse noop) &&
-- 
2.44.0

