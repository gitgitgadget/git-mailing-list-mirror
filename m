Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF05473F
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532016; cv=none; b=kb/D/kf8buGzRSVF3eTU1y3XYShVKe9imHBJex1/zoMkBwcFrvaDYfpKfR9TsHkIDlkTO5Ih3rTLqIntmmzpJ+HCJ6IgQKxO6ylrTkLf9L5uoEZBY4x/BlZBuQy8YyNAQm/FHV9MxshsdVxbnhCXR+qAaoB7W5iKuwwYYfBzMNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532016; c=relaxed/simple;
	bh=W6CSeRMnqWYkGsMI4yWcPedcxD3QaYJoQgAqhvtBrms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+iGPaVIeNOJ/6sGNmWF6lH7VlSEgIoSiHi+/+XukUOhOg01pz8UN7TQQ44yWoVCE7D5j+Wf+FO6uMUDYp0D26oVotSoMCv4s+FobCA29yXE1lLftLZNI4Rxy+fNaf2Wnp5mgbm6EEhKFJwUnY4kPTHP7CO4bP+U/VyXlmUpZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVy-000000002FQ-3mGC
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:51 +0100
Received: from [10.20.10.231] (port=12132 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVx-006arG-2U;
	Fri, 15 Mar 2024 20:46:49 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 72A38180130;
	Fri, 15 Mar 2024 20:46:48 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:48 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 17/22] t/t4*: merge a "grep | sed" pipeline
Date: Fri, 15 Mar 2024 20:46:14 +0100
Message-ID: <20240315194620.10713-18-dev+git@drbeat.li>
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
 t/t4002-diff-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 7afc883ec374..cb3307010c1e 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -405,7 +405,7 @@ test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
 
 test_expect_success 'diff can read from stdin' '
 	test_must_fail git diff --no-index -- MN - < NN |
-		grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
+		sed "/^index/d; s#/-#/NN#" >.test-a &&
 	test_must_fail git diff --no-index -- MN NN |
 		grep -v "^index" >.test-b &&
 	test_cmp .test-a .test-b
-- 
2.44.0

