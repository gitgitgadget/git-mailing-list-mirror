Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2644224240
	for <git@vger.kernel.org>; Fri, 23 May 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992858; cv=none; b=OGQFQo5ldxZ/7H64Q7LDpGIZ7rtWJtgT/HhrW++4dEyfJKOIKLBvsxOJ8Dr52Uy0NDHi5T4Etv/6F7x5kdGwUDm13jy3HHoLgwGx8CjLdOUxcOz9vjF3EAS8kUtKHbA1p+tHmW33Gub+ho32zAw1NFiksnT4kn0zzdufnMzHKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992858; c=relaxed/simple;
	bh=J7JP4I80YLQuL5IQT3FJLaeXfukhr7gaoxbkDSF5qV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXpKJN1SKa5bqp+p3/DXH4vdrVcpIPgWDNaulN8/hLS2Bz4ExgqgIgFBQyYyNdBXsUq/6HWvR5gx1BrOwRtspo+9ewuTeqV2OoKOC5d3Nzl5DfttCNc7EebzdyvHJm38Srag7xDf7dh24V9Qu9NbUwblrTkKyuaUY5C9/WS9eU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=dHqzdtC8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="dHqzdtC8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747992851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wvSn4wxNVaD8TDfHuDka/JBJac6/wv4zS1zb0sstrqo=;
	b=dHqzdtC8lC+PByQRbvEIePdTA/CehiusF+hAQUgGF6u4lGHOa/0B2b4Rd4JlTZWK0yZfp5
	tLel4lsVXRA6vs0sgbwQirhUE6vUUYYFvcvM2nmEttH2GitbYsfST5F0HhvjRCtf16nF/7
	clbKJTfOfQBxQP2L2EO70VcVwwO6fgw=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 23 May 2025 11:33:49 +0200
Subject: [PATCH RFC v2 2/5] t/perf: add last-modified perf script
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-toon-new-blame-tree-v2-2-101e4ca4c1c9@iotcl.com>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
In-Reply-To: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

This just runs some simple last-modified commands. We already test
correctness in the regular suite, so this is just about finding
performance regressions from one version to another.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/meson.build                 |  1 +
 t/perf/p8020-last-modified.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/t/meson.build b/t/meson.build
index be5a711375..4ac28c04fe 100644
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
index 0000000000..a02ec907d4
--- /dev/null
+++ b/t/perf/p8020-last-modified.sh
@@ -0,0 +1,21 @@
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
+	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)
+	git last-modified -r HEAD -- "$path"
+'
+
+test_done

-- 
2.49.0

