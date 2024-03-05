Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730912AAD1
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674004; cv=none; b=YcQROEwM0qMFPFq2hNP23Z5Fqxiq9B/xEHm76uMR3KhOWrPpo//AVK6GN32pbaHrHeV85Xmlt64fN/jKSj/EI59wPM62CPcPwQg1MR5jn9gk2mB28xIMTLnMuV04oqxGHpOB8edep8GnPOcL/1uzEbXO0a8QpoWOTvfAACNM6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674004; c=relaxed/simple;
	bh=RSvInp4Al1RjKCnYUljvLkIgcE9/RogQHK9lhjNNaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJprzckH84vpnn4FLSmVm1SMDqPwlLDjzMVDjM9JXKELCmE5EAujVcMs6GzzYgz6Kh9QdzjDOCCzo/4Nw1SVYTEtiuOC4yeysIYT+Phw5DjSc8XcPBqQ2BWboBf1E9dYXi7Hrr+dkcru8JMPKtmiG2z356fMHXgeOeIx3BcqH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ6-000000002SP-3CAH
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:41 +0100
Received: from [10.20.10.233] (port=53062 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ5-006Kev-29;
	Tue, 05 Mar 2024 22:26:39 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 598C3180036;
	Tue,  5 Mar 2024 22:26:38 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:38 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 13/22] t/t8*: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:12 +0100
Message-ID: <20240305212533.12947-14-dev+git@drbeat.li>
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
 t/t8010-cat-file-filters.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index ca04242ca016..eb64b766bdfa 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -43,7 +43,7 @@ test_expect_success 'cat-file --textconv --path=<path> works' '
 	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
 	git cat-file --textconv --path=hello.txt $sha1 >rot13 &&
-	test uryyb = "$(cat rot13 | remove_cr)"
+	test uryyb = "$(remove_cr <rot13)"
 '
 
 test_expect_success '--path=<path> complains without --textconv/--filters' '
-- 
2.44.0

