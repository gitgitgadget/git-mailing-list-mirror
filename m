Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4B5DF23
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406525; cv=none; b=IFLMXEhz/n17B1fNHYy+JUbGasv+xhx3n9zMvg4ZjdtJx35j0q2pkVGsgPUlc2ZIbCDHV+jiJLOQGvBkJbjBmQ18kMiHahXQzPme5s0CS+0fxJ7tnSQ81RgQZ2PJrJZm+iT6oZEoV/YmvZRrs5JO4VQXdTA3fXG48ALXwIYMeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406525; c=relaxed/simple;
	bh=ZLA3JWhLnzWsLvG7/oi8b8P0w1LjrJJrfzXdEp+ngRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfJzZLmzfKNPIeUEPTo+BMlEpN2KowzyOPFB8bTqVkngeDOg+JllvIhe+ynkBb5dcY6HYc+YiA148iI+Zhr+/2RZVaPoEWGxODKn8nvqkAOfJD/Dp1qQdPIy7NtqIcm4taqJv/l3zNBe3MF5I8ichWYNoJ633G4kUl2zXP0EnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rkgrt-000000007fE-3n33
	for git@vger.kernel.org;
	Thu, 14 Mar 2024 09:55:18 +0100
Received: from [10.20.10.233] (port=11052 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rkgrs-009lgq-2X;
	Thu, 14 Mar 2024 09:55:16 +0100
Received: by drbeat.li (Postfix, from userid 1000)
	id 632FF180130; Thu, 14 Mar 2024 09:55:16 +0100 (CET)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] t0006: add more tests with a negative TZ offset
Date: Thu, 14 Mar 2024 09:55:12 +0100
Message-ID: <20240314085512.1827031-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.42.0.583.ga47b40fd90
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

This test doesn't systematically check a negative timezone offset. Add a
test for each format that outputs the offset to improve our test
coverage.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t0006-date.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d228a981e..3031256d14 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -70,6 +70,14 @@ check_show 'format:%s' '123456789 +1234' 123456789
 check_show 'format:%s' '123456789 -1234' 123456789
 check_show 'format-local:%s' '123456789 -1234' 123456789
 
+# negative TZ offset
+TIME='1466000000 -0200'
+check_show iso8601 "$TIME" '2016-06-15 12:13:20 -0200'
+check_show iso8601-strict "$TIME" '2016-06-15T12:13:20-02:00'
+check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 12:13:20 -0200'
+check_show default "$TIME" 'Wed Jun 15 12:13:20 2016 -0200'
+check_show raw "$TIME" '1466000000 -0200'
+
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
 check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-- 
2.42.0.583.ga47b40fd90

