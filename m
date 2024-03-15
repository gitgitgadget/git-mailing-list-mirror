Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186054756
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532006; cv=none; b=nnRMu3diiWD/Z1+iSn9gAl98yxfWxJwnyvzrDRsCT/2Uk8TP5bQWyvvZRhXZJoQo9TEGu6mBxbn73BZN1o4W/qySfvZb1KdQoOC8Sh3y7aEVy5Ju7ptUuCorGsEAxh1YuW86+9r2VV3zIzwCpmwq9F49iadl57RjtfVjAO0T1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532006; c=relaxed/simple;
	bh=/4kQIjNj8lRUPyTRvJ665yaTf57jzk0wC+IWRZIZDqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a10NIzyCxmgiMv9+Rkqfpjh6gKlWW6AnOdj4DVLv1H4GPdYFxkrEthKTs/wy4UGYfjfPqbrmm9GgqOHSpLy1lyTJh6ocM2x+w/2IbEC+l0J+5/3VMMJkWnhwSG1UzE/xEPOmYx6hzcKXw2CzEbmaSHPn8uUa4fgRhuF2J5cJEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVi-0000000029l-1vui
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:34 +0100
Received: from [10.20.10.230] (port=54898 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVh-006ais-19;
	Fri, 15 Mar 2024 20:46:33 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 15BFE1800FD;
	Fri, 15 Mar 2024 20:46:32 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:32 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 02/22] contrib/subtree/t: avoid redundant use of cat
Date: Fri, 15 Mar 2024 20:45:59 +0100
Message-ID: <20240315194620.10713-3-dev+git@drbeat.li>
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

