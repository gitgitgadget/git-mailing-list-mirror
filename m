Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0034A33E
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074492; cv=none; b=qOYM95AdSZ5L2i7ekz+wdSRyLGW+5/hBnhdQaxUrjdyn8hMgeYr72TmSEO4b9A3vuf2XuJnsAbR3EgAHb1QpEc8fCzqxY4axkzCJzfaQyLAI9yn1ZENPwKTSQhigh1ePrwLWCSDVaXxmGsAipnRyvS4XNcTEVJb3zmI1Frwkf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074492; c=relaxed/simple;
	bh=pWemv2R22h3mHstTjGUKEInvA3sVZnzqEy6DtxphwNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HylBnOAk9kMIFhPReA3BDHXpzK4xrzHBR1C2R7TSzKwLMjAcrtPDGDuU/Kd5FpAt4TMoIoG76/s+FmekS0YTK22EfgoWbClH0QBBKqoGff35Bz8tQdyz9fQ1jNauFzbu4OPTu+PuXHldLVxRJhMYrgIAYKLyamOVHGH8icO0C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uuVL4-0000K7-QA; Fri, 05 Sep 2025 14:14:46 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 05 Sep 2025 14:14:38 +0200
Subject: [PATCH] GIT-VERSION-GEN: Use standard versioning suffix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAC3UumgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNT3eLU3LLUIl2jVMtEIEw2N09NUwIqLihKTcusABsUHVtbCwBUlSj
 WWAAAAA==
X-Change-ID: 20250905-semver-2e9a9a9c77ef
To: git@vger.kernel.org
Cc: gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-5bfae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=pWemv2R22h3mHstTjGUKEInvA3sVZnzqEy6DtxphwNU=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjYdcVMJCE1aHfW7ymb9Pc8NeNe7v/93Yo+xWXy761CU
 84972ju6ShlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExE1IeR4fUfu91Hj299eaL2
 xXNOm6QfrZr/1ddqHbvyZpHw4fOqG3czMlzoYetT/aj39+P1QI5rOwRX77XLaw/tEDeo+Lqx5XN
 DATcA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

In snapshot builds of git, git-version uses a modified variant of the
git-describe output, e.g. 2.51.0.178.g2462961280 instead of
2.51.0-178-g2462961280 for seemingly historical reasons.

This is not semver compliant which makes the output harder to parse in
tooling such as b4, which currently errors out when using a snapshot
build of git.

For snapshot builds, use as version string the unmodified git-describe
output with only the leading v stripped from the tag.

Fixes: 5c7d3c9507f7 ("Allow building of RPM from interim snapshot.")
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b16db85e77..99e04588f3 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -52,7 +52,7 @@ then
 		*$LF*) (exit 1) ;;
 		esac
 	then
-		VN=$(echo "$VN" | sed -e 's/-/./g');
+		: # use VN as set by git describe
 	else
 		VN="$DEF_VER"
 	fi

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250905-semver-2e9a9a9c77ef

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

