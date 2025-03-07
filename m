Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC121ABBC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357125; cv=none; b=uogGD5qPn4QNHIV20wZFquPp06Ha8TZNq1GOXSLUdLtJUP20nVzri0qv+D/3nguSH/Q91eDgcZ1sDT1zsQWcCQ58D+3/GQkXw6E/Fs3uAoCSLF6cAHzPSTczKeNRyjCZp22TNlMIPVAM0Xd5Vp/whvtKc9yDMVhX39BioW505yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357125; c=relaxed/simple;
	bh=tSoFKUdAy7w3VVnaIR2hnUkf/tbStHrf1ZJfWzvFP+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8dAgJ3jFwB73q4z1ZexHVcpw7a7SITSbC167YPknSanv5/YSWFZ1EO6ab+j3+Tcoy3lhswZBQqs8PApBNMO2rko0d1ITfAbfqLOS26j6GkiMYJU30Ftcgkl/bdRRcWYQfT9tHkQlpLXAYCGNrj7uvlIKPvjwC8MbtUSjRNsMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=JFn6UgZH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="JFn6UgZH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1741357120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97HzXVnb011C4+XsVIDJaz14iK+L3mkw35z1S+emLhw=;
	b=JFn6UgZHoLiTRc86qqLOFqFObOI/4vU5AGTJOweLR0V9TOJumQ4W5JKAd4s8rsso+/NVqy
	EmBez+5d+MytdOqIrr1o/+HZZlWJAPMlF1+aDq8xw5qAdvcmxEYepMR2yfCtwx5TxytSZ2
	nBJ6rBAACwdyHXTjB55w5p07mvzAFxg=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 07 Mar 2025 15:18:07 +0100
Subject: [PATCH 1/2] help: include git-zlib.h to print zlib version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-toon-zlib-git-version-v1-1-5e8069752bb9@iotcl.com>
References: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
In-Reply-To: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In 41f1a8435a (git-compat-util: move include of "compat/zlib.h" into
"git-zlib.h", 2025-01-28) some code was refactored to enable easier
linking against zlib-ng.

This removed `zlib.h` being indirectly included in `help.c`. As this
file uses `ZLIB_VERSION` to print the version number of zlib when
running git-version(1) with `--build-options`, this resulted in a
regression.

Include `git-zlib.h` directly into `help.c` to print zlib version
information. This brings back the zlib version in the output of
`git version --build-options`.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/help.c b/help.c
index 8d91afe851..707cd59b79 100644
--- a/help.c
+++ b/help.c
@@ -2,6 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "git-zlib.h"
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"

-- 
2.49.0.rc1.410.g72b47a15e9

