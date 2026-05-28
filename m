Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD51E5702
	for <git@vger.kernel.org>; Thu, 28 May 2026 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011081; cv=none; b=MtGhY6pIjqtFECOr98yJsxGYS9wfN/cEP416gGeNxd4YWP/e/ypnDOsMLr6p42Qv1fKC6LcH+lFKT4ljHVEwM7TY22+AjnzhTz9TVvlPBPuVxSSBJXq+v8dQFqBtHX+aNRWvqu+CX/WBFeqJWHDzZ7BtRdrjw45cB8hJdbWDCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011081; c=relaxed/simple;
	bh=nPwLjlfNAe8XvYnkAlVqMCKTOvjg5JBRBBVO6yBzZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ddlh7qe6VKBSUMuLITF2eGX9izJqlS+G4j3dLbKzKwkKcl9Pp7NMxR+WIRpdaat+TbPb3S+uLoiRYWFHMLSGc3IqHkPiKn1bbb7skXBl41tD0ua7McOBLlDGQXJUzxTEGmf0VtQ1y47QyeqpHrBNDAroXb0EUvgON+BNxOFNJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC629+1C; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC629+1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780011078; x=1811547078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nPwLjlfNAe8XvYnkAlVqMCKTOvjg5JBRBBVO6yBzZsY=;
  b=iC629+1CUQ8iqppBLZrwMqM/gbXKQEKpyCaQgF6kZUuZqGNPypxvwim1
   kbFu9VTEpe1XGwnkyB7u9UemzDgFF3bKaLiUITzexPVdYuHlJzWip3Lur
   WHJJgbb1TKGgkAb+HflhsiL1JYKQJwn2yV7qG482/g1cvlNy4XYGAohcd
   yUkLFxpJrzmF4EnTQu97dnt4UwYZ9TxycorZZXqvVes0qVzkAJC3/lfXk
   BlFJ3xlpOv2vFkFBThF66M/GCtHOx1d5mlK+YuQNmBP8/Izdi62Nqj77W
   Y4rNB3GlKRnHw2IOA14gMgLT02WT1V0YKapeFzZ5UlU7N4QTpWX2aEsLh
   w==;
X-CSE-ConnectionGUID: fCE0UoFGSU64+6yugRgTgA==
X-CSE-MsgGUID: hOCzrUAETjyxejoYWDx3iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91432001"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91432001"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 16:31:12 -0700
X-CSE-ConnectionGUID: LxDV1TFMR3Goci/opZ8hyg==
X-CSE-MsgGUID: FgUCrxevT5m97NNkphrVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="241861642"
Received: from orcnseosdtjek.jf.intel.com ([10.166.28.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 16:31:12 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH] describe: fix --exclude, --match with --contains and --all
Date: Thu, 28 May 2026 16:29:51 -0700
Message-ID: <20260528232950.187002-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.54.0.633.g0ded84c31b89
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

git describe --contains acts as a wrapper around git name-rev. When
operating with --contains and --all, the --match and --exclude patterns
are not properly forwarded to name-rev as --exclude and --refs options.

This results in the command silently discarding match and exclude
requests from the user when operating in --all mode.

We could check and die() if the user provides --contains, --all, and
--match/--exclude. However, its also straight forward to just pass the
filters down to git name-rev.

Notice that the documentation for --match and --exclude mention the
--all mode. It explains that they operate on refs with the prefix
refs/tags, and additionally refs/heads and refs/remotes when using
--all.

Fix the describe logic to pass the patterns down with the appropriate
prefixes when --all is provided. This fixes the support to match the
documented behavior.

Add tests to check that this works as expected.

Reported-by: Tuomas Ahola <taahol@utu.fi>
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

I was looking into reviving the patch that just added a simple die() and
realized that its actually pretty straight forward to just fix the support
instead. I'm open to either route, if we think this support isn't
necessary... I'm not sure if there are any gotchas or other issues with how
I implemented this.

 builtin/describe.c  | 18 +++++++++++++++---
 t/t6120-describe.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7c3..faaf44cec573 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -712,13 +712,25 @@ int cmd_describe(int argc,
 			     NULL);
 		if (always)
 			strvec_push(&args, "--always");
-		if (!all) {
+		if (!all)
 			strvec_push(&args, "--tags");
+
+		for_each_string_list_item(item, &patterns)
+			strvec_pushf(&args, "--refs=refs/tags/%s", item->string);
+		for_each_string_list_item(item, &exclude_patterns)
+			strvec_pushf(&args, "--exclude=refs/tags/%s", item->string);
+
+		if (all) {
 			for_each_string_list_item(item, &patterns)
-				strvec_pushf(&args, "--refs=refs/tags/%s", item->string);
+				strvec_pushf(&args, "--refs=refs/heads/%s", item->string);
 			for_each_string_list_item(item, &exclude_patterns)
-				strvec_pushf(&args, "--exclude=refs/tags/%s", item->string);
+				strvec_pushf(&args, "--exclude=refs/heads/%s", item->string);
+			for_each_string_list_item(item, &patterns)
+				strvec_pushf(&args, "--refs=refs/remotes/%s", item->string);
+			for_each_string_list_item(item, &exclude_patterns)
+				strvec_pushf(&args, "--exclude=refs/remotes/%s", item->string);
 		}
+
 		if (argc)
 			strvec_pushv(&args, argv);
 		else
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8ee3d2c37d02..f46e628d6a1a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -359,6 +359,35 @@ test_expect_success 'describe --contains and --no-match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --contains --all --match' '
+	echo "tags/A^0" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	test_must_fail git describe --contains --all --match="B" $tagged_commit >actual &&
+	git describe --contains --all --match="A" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe --contains --all --match branch' '
+	echo "branch_A" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	git describe --contains --all --match="branch*" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe --contains --all --match and --exclude' '
+	echo "branch_C~1" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	git describe --contains --all --match="branch*" --exclude="branch_A" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'describe --contains --all --exclude' '
+	echo "branch_A" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	git describe --contains --all --exclude="A" --exclude="c" --exclude="test*" $tagged_commit >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup and absorb a submodule' '
 	test_create_repo sub1 &&
 	test_commit -C sub1 initial &&
-- 
2.54.0.633.g0ded84c31b89

