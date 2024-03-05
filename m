Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EB12E1E8
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674010; cv=none; b=URL9DU/FkuA9C09J8IfiMbooWo8fCfaSHN6VZKB31izl0XQqaTfUS5yfD+K7tqUCmffyWr3DanxQyWgLPK1PhcIBtEYsBvx11Vge6O2c+Ho60BkPyvGiarh9XrNZIohfdpO/h4aS2GuvDQgxscYSEO+Jh2eaQWeMLsnsymOjPaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674010; c=relaxed/simple;
	bh=FBGYtMBE46md7xXtSfID/c9wLA56bu8LZllXBqjvfuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6AP3HFwpIEGrLuJ82qa7aiRFJJ3yMNX2M9PN3Qx1IXnhFqMalg8/RUnun1lQhqurXsyjpTMZyX2QP9YJO8tUbRR6S1pWJmPd1aoJLekEG56st8YJJ5Sg1bLepLq+NVZSj66CHddyX89Lg7CNKr411/pqY26atE4O/lspDhvEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJC-000000002Tz-11u3
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:46 +0100
Received: from [10.20.10.230] (port=35122 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJB-006KhG-0R;
	Tue, 05 Mar 2024 22:26:45 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id CBA2418012F;
	Tue,  5 Mar 2024 22:26:43 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:43 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 18/22] t/t5*: merge a "grep | sed" pipeline
Date: Tue,  5 Mar 2024 22:25:17 +0100
Message-ID: <20240305212533.12947-19-dev+git@drbeat.li>
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
 t/t5401-update-hooks.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 8b8bc47dc0b9..d8cadeec7331 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -123,7 +123,7 @@ remote: STDOUT post-update
 remote: STDERR post-update
 EOF
 test_expect_success 'send-pack stderr contains hook messages' '
-	grep ^remote: send.err | sed "s/ *\$//" >actual &&
+	sed -n "/^remote:/s/ *\$//p" send.err >actual &&
 	test_cmp expect actual
 '
 
-- 
2.44.0

