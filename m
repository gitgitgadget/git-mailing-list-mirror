Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D926AA93
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386472; cv=none; b=t6kOh+GeS7asl+XqAmZgnIvhnuGrk4x4O+1BpKfh2mljMPazT5O5tif5Ug+l0LDk1eYOVELrYTBna73G21gYjeo9rP2AC1ngjGTXu4j35/LRtrmNjKTfsaT0QHTlsBgAQ8mcr5QEM2zz2eR4Mm4L+FmXmJR6PCtBLy0KY2XU1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386472; c=relaxed/simple;
	bh=eaniNIHgMEZ/hM/+UgpEN26mYzC2pUuwa/6CUz+7anA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jg5fnthd+soLTelCHGxyRkkfOvWRW51VgF0426UgKQ8TQBRA1KvESTmK4zs2AXoGQUJSQZd/jpa58tMHwCctQZkVB493PuKEynVZyG6ZIt/prkZbqakkqZEmy2i2B4frt2LUy6XhiCJ0zhAz0+xX0Ni2qjXamQURxMUYMynMYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ORXZ/mud; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ORXZ/mud"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754386468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnBZka2lh94S38TEajaN3tfUpeEq0gCWLRlYhnip6qE=;
	b=ORXZ/mudkgES7bSKJhlNBEHpDHAnBgfwj3mC92a1tjj+2LI+iaOCWcr8sCX8H2vu6LsoXb
	Ek+tvl8bp41EZIGogyIDY34JkRQKTgXYDPSg1IxFVEuMVyhsX4xjqa6qJZQYjPZ6ubZfOy
	DsRjrJPfoh2Ua0zOwT5S5Ks8KTmMawg=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v7 2/3] t/perf: add last-modified perf script
Date: Tue,  5 Aug 2025 11:33:57 +0200
Message-ID: <20250805093358.1791633-3-toon@iotcl.com>
In-Reply-To: <20250730175510.987383-1-toon@iotcl.com>
References: <20250730175510.987383-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This just runs some simple last-modified commands. We already test
correctness in the regular suite, so this is just about finding
performance regressions from one version to another.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/meson.build                 |  1 +
 t/perf/p8020-last-modified.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100755 t/perf/p8020-last-modified.sh

diff --git a/t/meson.build b/t/meson.build
index 68656fe08a..21d5e99bf5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1140,6 +1140,7 @@ benchmarks = [
   'perf/p7820-grep-engines.sh',
   'perf/p7821-grep-engines-fixed.sh',
   'perf/p7822-grep-perl-character.sh',
+  'perf/p8020-last-modified.sh',
   'perf/p9210-scalar.sh',
   'perf/p9300-fast-import-export.sh',
 ]
diff --git a/t/perf/p8020-last-modified.sh b/t/perf/p8020-last-modified.sh
new file mode 100755
index 0000000000..cb1f98d3db
--- /dev/null
+++ b/t/perf/p8020-last-modified.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='last-modified perf tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_perf 'top-level last-modified' '
+	git last-modified HEAD
+'
+
+test_perf 'top-level recursive last-modified' '
+	git last-modified -r HEAD
+'
+
+test_perf 'subdir last-modified' '
+	git ls-tree -d HEAD >subtrees &&
+	path="$(head -n 1 subtrees | cut -f2)" &&
+	git last-modified -r HEAD -- "$path"
+'
+
+test_done
-- 
2.50.1.327.g047016eb4a

