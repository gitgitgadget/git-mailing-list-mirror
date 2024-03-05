Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DE12DDB0
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674007; cv=none; b=CD/cjePoRL/FT5GpDU87vW94hrZxJRNZVcXr2cvLh5ZyXv2LOX1XBz+zpMxPImi4+SRsAHNuVnFSCPDJU7s2zmqaxSAto2UkrB06ba5YvXjhi49jQJwkqteV2WZEJiLL07/H9Go9/5ASrCHU2AeLZUiG9DUgQyw7tYL5xd4OLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674007; c=relaxed/simple;
	bh=T2rlWkZRvk88WPmyYUMhc6a8x+L+IwxMEMnTVvd4zF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho6F+xcDRKlEQmrGXgkGKwxDFNUYRQ/jSs+YM1M0d0Ln0BBrIyh+wf3OwKjyrNvjQUj/g7Fo61MBTWlL7hSf2hb0p05NjZEq/0CvjBd6s1zFkPMUbMzNBjamX05CAo4e2/VgXUPOFCDr8a6zIVdZHEBU//0n+gKM8KTyKHSVTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJA-000000002Td-0HOf
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:44 +0100
Received: from [10.20.10.232] (port=35456 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ8-006KgM-35;
	Tue, 05 Mar 2024 22:26:42 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 9E81218012F;
	Tue,  5 Mar 2024 22:26:41 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:41 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 16/22] t/t3*: merge a "grep | awk" pipeline
Date: Tue,  5 Mar 2024 22:25:15 +0100
Message-ID: <20240305212533.12947-17-dev+git@drbeat.li>
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
 t/t3920-crlf-messages.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 5eed640a6825..50ae222f0842 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -97,7 +97,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
 	git branch -v >tmp &&
 	# Remove first two columns, and the line for the currently checked out branch
 	current=$(git branch --show-current) &&
-	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
+	awk "/$current/ { next } { \$1 = \$2 = \"\" } 1" <tmp >actual &&
 	test_cmp expect actual
 '
 
-- 
2.44.0

