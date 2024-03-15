Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478154770
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532022; cv=none; b=go1CtjyM4ievK5fAIKw1uzRdeUDj76ObvdxhzpsDWj2qOG2QcZmbaS5YvIhQ8F1QTDmPgcdhs2CHf41DYpMUk7GNaK+oSx1DKW2oRxEkYNlWmVqsYXPUuHrMePS7JjvnQ0rpGByLR4SKwTwQYk937lJ1lS8k86qjPoAnGo9XOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532022; c=relaxed/simple;
	bh=dNPRDkkM4IUwytFXl8H1utciOM4OELyXwXUoSQgllzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUXqnzrrM307jxAv+TwQ5WMQ2pV8X3ua8gYrajnQVJ1S8x63Hb85mF3jhiQFKU+S/Vy3EGbD3tCtnbcGIUE+rvI8WO7Sf9b9TKfrmjHBJW4GGyQoNxLnbuS1gLon8PjVEI3Lhjdt745sG/MU+RygXx6Kb9Feo80Ie9jo2MidtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW4-000000002I2-1f8K
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:56 +0100
Received: from [10.20.10.231] (port=14578 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW3-006ath-0t;
	Fri, 15 Mar 2024 20:46:55 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id EA5681800FD;
	Fri, 15 Mar 2024 20:46:53 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:53 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 22/22] git-quiltimport: avoid an unnecessary subshell
Date: Fri, 15 Mar 2024 20:46:19 +0100
Message-ID: <20240315194620.10713-23-dev+git@drbeat.li>
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

Use braces for the compound command.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 git-quiltimport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index e3d390974331..eb34cda4092a 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -148,7 +148,7 @@ do
 	if [ -z "$dry_run" ] ; then
 		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
-		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
+		commit=$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
 done 3<"$QUILT_SERIES"
-- 
2.44.0

