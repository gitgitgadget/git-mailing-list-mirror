Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D13FFAC4
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538971; cv=none; b=Tgw1Vx2zDO/iEweds++PX3jusN+XsxjbQOMrnAWvjE95Ha9pAMcPBLhmopGl1FPYUBPA59ApIsdbB5BVslhpte88hGqWEc3ZMmXgF+szwMVfmeA1dFPCXQtRBLfrHdSfRpVgf7fBNBYQJe7IEj3a2NR+63KQaNg4qal5y5fismc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538971; c=relaxed/simple;
	bh=rYU3/1bHD/DCCuXKLXsR0HipeHE+cE+8/JvzSK/ZiSc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmC+y1r6Vcxud0LOV3VsF4+rYOuS7n6dxVmO+y8ZyWOrKjXt8ZdjLVWQMEnLtpN8Hm2k5BGVPvI8mEzOhz8W3ofhwAKx/G1+6TF9m+RjK/gmI0JGooC8otgW8StEML90aoGO6SC5sQ60eceIoflU1YIM3lkR9Z7c49zDlWCMHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=reBs24JV; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="reBs24JV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538578;
	bh=PqRq3nmHezxClQU6TSGw3Vs0G6pOLSjNoT6taLqUx1E=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=reBs24JVlO/S4mbvet+j+o+7rjhPN9qn9r8oTDnH6hUGQr72fI5fWYUkdFxVkeBgb
	 BUTqj5rIDw8Kreg4yyrheohiSsaM/LNBHSSkmHdWb5HkOxDYCWMAnqSNdY8PHuePAu
	 HFbJWFoVi9OCys/ulDK8qEyN1qgifU4H+uBwzdxHr6DnWzYHTAUOYFHbydpoxK+4V/
	 04eysMjaHFznsCSCP0gEES1iyV+KRMonHbb6yTv8bY9yqrL3KMq8tYhAdK04Eo1/mw
	 5gBkh9cEqjPV3FfToT0DMid01tW8PJ2l0PmkguOxgJ5O+iJehIe7+CPzWj7L/dHo6q
	 6bCezI67auE1A==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 4/6] do not discard const: declare const where we stay const
Date: Thu, 26 Mar 2026 16:22:50 +0100
Message-ID: <5325f5cfb25765252c2aa197b239cd99a72d3f28.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
References: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This may sound like the easiest case, but for non ISOC23 with non-const
strchr() this involves an implicit cast to const.
---
 convert.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index a34ec6ecdc..eae36c8a59 100644
--- a/convert.c
+++ b/convert.c
@@ -1168,7 +1168,8 @@ static int ident_to_worktree(const char *src, size_t len,
 			     struct strbuf *buf, int ident)
 {
 	struct object_id oid;
-	char *to_free = NULL, *dollar, *spc;
+	char *to_free = NULL;
+	const char *dollar, *spc;
 	int cnt;
 
 	if (!ident)
-- 
2.53.0.1195.g771ffcb452

