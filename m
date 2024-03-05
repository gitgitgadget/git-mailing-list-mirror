Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4D12A153
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673994; cv=none; b=UzuQLKIdNNbLST3ECPDIj99Iqsd/UYuOhbnxzrrU1IhZ7s40aEN3xmbP9YPXdS3EKfXmulGRhtZ8vpb0hrHrT3fmHTjLIwkteQwxMSOIKMoGrmJfTM7UI9KtvUaUPdKUsx/aqb5jhaQcdoZPqhOWGX4oFlndvgMUVTSaiBWkvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673994; c=relaxed/simple;
	bh=zeF7UP34ynW6WksuNgeb+X47YU21XHAm4VZdawEE5+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLLqfovdbpcsI9QmlvkOmWEo1qTWFRiLr2VydFCx8l90FB3r5omI6BDMjrOEYAmjA57QzU2fXztSPmZ1oSrsbsSsefdSreJDEfCKJmIn4f1AHjsumrYwzojgSVRP4upe4DFP96uxG5rCRle0idtMp/rQUA94wXmcsNhE3M+mSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIv-000000002PO-3k6i
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:30 +0100
Received: from [10.20.10.232] (port=30144 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIu-006KZy-2T;
	Tue, 05 Mar 2024 22:26:28 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 75A85180036;
	Tue,  5 Mar 2024 22:26:27 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:27 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 03/22] t/lib-cvs.sh: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:02 +0100
Message-ID: <20240305212533.12947-4-dev+git@drbeat.li>
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
 t/lib-cvs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 32b347337908..57b9b2db9b3f 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -71,8 +71,8 @@ test_cmp_branch_tree () {
 		find . -type d -name .git -prune -o -type f -print
 	) | sort >module-git-"$1".list &&
 	test_cmp module-cvs-"$1".list module-git-"$1".list &&
-	cat module-cvs-"$1".list | while read f
+	while read f
 	do
 		test_cmp_branch_file "$1" "$f" || return 1
-	done
+	done <module-cvs-"$1".list
 }
-- 
2.44.0

