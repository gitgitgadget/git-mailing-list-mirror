Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D392E11A6
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898149; cv=none; b=r8RHzAqnN9l5CkI2LdsWh3Yw5gNK+K7+IbZa7YAQqvpO54xg+lDyw8JLxZZMvADuCgp70qRXOsOonWsxyYGzqeqq7pqMg9P3VQPY/vD5sKKg82aIiJLIEs/pAv372jnV3b9Hn3cyLpKa0x9HJeMkZPw3v3JCet3Wtncm/7jyyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898149; c=relaxed/simple;
	bh=c541gyNMbl9C3OvIm8bV1t4wjESVnHmZIzrZhPDPRsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI0lJKm/tARi//2LW8O5lrlACTevt0j/Iki7Ns0Qh6EkIXmLw9vB/NfVFP/fwkRW7AuLhfF0uoJk6jkYux/p3Pv69w+ywQTEtgdk/wacmPgoVLYq+Bb/amHwmNpTOfdrPa1kVpxu1iU+SL/xaHUlZhIaSBJhXsA1eMiawU0qzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=axO/KYyN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="axO/KYyN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753898145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITB2pZjymR/elfX/FTJMUZVOnEwm2MTpG5unG+o+6po=;
	b=axO/KYyN20JmYkg9S+SzrYlwQI7bvsYYR70g1ZPdAuWjap1NeFG+3QFkzWWrMXdXIaF0Bd
	0TIRUHrfAWM9NVfYSQgTLCTPxggWAQnoXXlNi7+Au8FpYSHaN+oHSFGH89NeEDyNNvG4Ej
	4zumt4L4cd5Vie0QdG6a9xhP5ZOr11k=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 2/4] t/perf: add last-modified perf script
Date: Wed, 30 Jul 2025 19:55:08 +0200
Message-ID: <20250730175510.987383-3-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250716133206.1787549-1-toon@iotcl.com>
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
index 904455e3ab..b74125b047 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1155,6 +1155,7 @@ benchmarks = [
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

