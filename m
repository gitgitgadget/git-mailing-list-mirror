Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A22727F6
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647229; cv=none; b=AO5L2dn9/cyhmZW7GAqdniNwhhxFBBl8cyrJJBWFBx2WiPPdoG2O51NJIGeCSdE6G2oCkLor/EHh/qmFn+2ncou2P174SwDvYvPkNCo/MgHf0Tdq7IcCzfyZrTm6CgDpYzDoTUX5du5OpUdlswQE626eYx512hTKr78Q8z6H3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647229; c=relaxed/simple;
	bh=dNaZKJhQcBmlzzWWTDJhuNSd7F9FEzbMF8toXAZSrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJwvLLrYmSKmVkS33cTCjn+53vb1mtQrAZ3dMzFo+1H3lJxTU4NV/YeK8QpRzDit/4EuYKPB8IW2yCZnpFjVzq7HE0b5mf4g0EkfqdXJ4tGxjb+wSeZO/xRtIjryPcEh5x6MA1WniKfnYvSs9rYNPTHrYn01t9j3kRm31Ohe9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pb+ksdEN; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pb+ksdEN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754647223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1j9bY4QSYnrPcWCH9mvAGqu5vqS7W8fNefe6M319MT0=;
	b=pb+ksdENz0U+7yA0JFZJefza2gu6RfclMG/WvBkF1KrMdB1jmjKw2y3ImFkXYvgA6ie5OT
	uUOXQfAs+wM3ErCdyaQYRVGGsOAGiQoBIJZMFoDJd7V1NFZugxp25tMaWFVkrzWFNpI4WJ
	ZY7gphHAVv+abrlRDdQ5d26f8RDkFqI=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 1/2] t0450: fix test for out-of-tree builds
Date: Fri,  8 Aug 2025 11:59:42 +0200
Message-ID: <20250808095943.3312265-2-toon@iotcl.com>
In-Reply-To: <20250804073002.1586332-1-toon@iotcl.com>
References: <20250804073002.1586332-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When using Meson, builds are out-of-tree and $GIT_BUILD_DIR gets set to
the path where the build output is landing. To locate the Documentation
sources, test 't0450' was using that path.

Modify test 't0450' to use `$GIT_SOURCE_DIR/Documentation` to find the
documentation sources.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/t0450-txt-doc-vs-help.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 2f7504ae7e..da2d0af5b0 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -41,7 +41,7 @@ help_to_synopsis () {
 }
 
 builtin_to_adoc () {
-       echo "$GIT_BUILD_DIR/Documentation/git-$1.adoc"
+       echo "$GIT_SOURCE_DIR/Documentation/git-$1.adoc"
 }
 
 adoc_to_synopsis () {
-- 
2.50.1.327.g047016eb4a

