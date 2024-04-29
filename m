Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3233C7
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409560; cv=none; b=h0bVQzoI0Kg3AJVCZzsNZKLyKDwoRWoYOzLtVnFjpCKHyPs8dCF/fHfeL/1y0NU9sryWgjH3WQOm1PxrHqbtKr78J2q8fCPjdaMXdYpsTHGn08Kphui6YstUE1HlJAlPQqkfBgCc5d4cZoZ2BrmZL/lQAyiC/wWfGMlwugJNSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409560; c=relaxed/simple;
	bh=1djxXvxEB9KaD4L5pyk5dv8PE0vXkOiYcn5yWDSyKEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr/23wHoYooJPxoAWA0fSY7Pk9MbWI42WnfTxJSKc14kNQYYt9nz09VS8ycPPBPdxah4Fa69HfaweGdZhfPK7Rd1p4q3URTziNW/kP8ZbatXHkqJr4E2c4mU34rMeMU72aqYOQ+ujM7PG7/BQ4ewXHsmPZnQhlQ9NlMcNZVGMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s1UEv-000000007tn-1aji
	for git@vger.kernel.org;
	Mon, 29 Apr 2024 18:52:29 +0200
Received: from [10.20.10.231] (port=33256 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s1UEu-0069Y6-0p;
	Mon, 29 Apr 2024 18:52:28 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id E9D7D180197;
	Mon, 29 Apr 2024 18:52:26 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Mon, 29 Apr 2024 18:52:26 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/3] t/t4026-color: add test coverage for invalid RGB colors
Date: Mon, 29 Apr 2024 18:48:48 +0200
Message-ID: <20240429164849.78509-3-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429164849.78509-1-dev+git@drbeat.li>
References: <20240429164849.78509-1-dev+git@drbeat.li>
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

Make sure that the RGB color parser rejects invalid characters.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t4026-color.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 37622451fc23..0c39bd74a613 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -140,6 +140,15 @@ test_expect_success 'extra character after attribute' '
 	invalid_color "dimX"
 '
 
+test_expect_success 'non-hex character in RGB color' '
+	invalid_color "#x23456" &&
+	invalid_color "#1x3456" &&
+	invalid_color "#12x456" &&
+	invalid_color "#123x56" &&
+	invalid_color "#1234x6" &&
+	invalid_color "#12345x"
+'
+
 test_expect_success 'unknown color slots are ignored (diff)' '
 	git config color.diff.nosuchslotwilleverbedefined white &&
 	git diff --color
-- 
2.44.0

