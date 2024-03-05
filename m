Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDE12AAD1
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673996; cv=none; b=kL45CINS/yGog+h25N94N3cPSvXphapYBVFz6k1DQowj8cYGQtrtUCwkJwtQ8/cGB65oB0PHKU7LyeneE80bCJeMIXSc0eC8MSi1WPWI1lbgYJfOpE5qvJ1QuqUAxRlWHVmD/B1tZRsfbPB83h/L4WISl1Mf4J1Ape6efFuZm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673996; c=relaxed/simple;
	bh=/4kQIjNj8lRUPyTRvJ665yaTf57jzk0wC+IWRZIZDqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1jGhMQYDeHMpyi/a/kfmXLcy24TiFGMn95PsyNfMEwakhFJkKJdEiY+5UXPCnE34SkZmk8XK8fmwXnqXOpy1nUvsk356wA8YQ8gJlNG0RFBlVDC6PMLGW+Tr99B11POryDDDEb65QErulT5WDUOmv2TlG4JBzSqnRLqcira7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIu-000000002P9-3Ks7
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:29 +0100
Received: from [10.20.10.231] (port=45740 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIt-006KZe-2F;
	Tue, 05 Mar 2024 22:26:27 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 5E85C18012F;
	Tue,  5 Mar 2024 22:26:26 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:26 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 02/22] contrib/subtree/t: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:01 +0100
Message-ID: <20240305212533.12947-3-dev+git@drbeat.li>
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
 contrib/subtree/t/t7900-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ca4df5be8324..c3bd2a58b941 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -63,7 +63,7 @@ test_create_pre2_32_repo () {
 	git -C "$1" log -1 --format=%B HEAD^2 >msg &&
 	test_commit -C "$1-sub" --annotate sub2 &&
 	git clone --no-local "$1" "$1-clone" &&
-	new_commit=$(cat msg | sed -e "s/$commit/$tag/" | git -C "$1-clone" commit-tree HEAD^2^{tree}) &&
+	new_commit=$(sed -e "s/$commit/$tag/" msg | git -C "$1-clone" commit-tree HEAD^2^{tree}) &&
 	git -C "$1-clone" replace HEAD^2 $new_commit
 }
 
-- 
2.44.0

