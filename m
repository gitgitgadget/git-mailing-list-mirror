Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA3342C80
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357063; cv=none; b=dNyNeRYw2571D1kMPNlZYyJWSWJOJeMhVRrtAyilZQlTMw6eSw0NJ75DkohHurOwFooBw/BJg9dfOwRdS0N9sx3kyX6W577V5gN5kcZQviWxYnanTgrbEbEzrcnUep5GlPawMobvHYAVjA7qAEqW+izuzpNA4BMYn+4hdCdTamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357063; c=relaxed/simple;
	bh=/DkT1Z3pYyuOYD3IHLMnRD3ojINle86djGiN7lPhxKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9BnYqiPLU1M0T79v9rlwSL+Jx2IuPE2hpNFL5Rhm6v5xigmnkp1qtLKQpwV1PMZn87aKFcwxbYBZrJ6ZNK7hkKljAL5wOizihd1NVkaKfM+hNYDODL+Hjb3Gr0Svps2M6plqTc8vEHx87G/jbq6gWI79YFjrWalItlMjfw0btU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKArz2tt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKArz2tt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780357062; x=1811893062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/DkT1Z3pYyuOYD3IHLMnRD3ojINle86djGiN7lPhxKE=;
  b=mKArz2tt0qcsFjIIW0Ofgl/MN2RdI9jvDD2wvMJIWRL94arMUimEWXHJ
   mLjPGFJ/KElw+ne8YFdn7fVBsV2fnWrXSyaXuSZNX0deJgZ2N6vKg2etc
   C/8EXxDceg30p3jfB4KOpIpgMd3k3AoVYVcjVEn2nTGaxzWna+FmR/YL3
   KU2uL7ubkUbwASk9uFjue3VKCJUiU1OZ7oOvzYpx68hmhXkOZ6wHP/mel
   73AUqk2gLkhumJKx+X5IJzsK0KaNWj4eHc4HcAbcE7RkmO5mCkThJ9Be4
   3iho/q8u3s611nqNM6BFL03SqDcVqSNpe+1fKWmvL2yhmX/sxR3NEnDv9
   w==;
X-CSE-ConnectionGUID: oUv43nq/T6eYYA+dx4m5JA==
X-CSE-MsgGUID: JU5fD9ZcRZqufS3QsssQzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81186974"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81186974"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 16:37:41 -0700
X-CSE-ConnectionGUID: usovppdHTQiu/7309D+r6A==
X-CSE-MsgGUID: xMryM4VYSjGJqvSNwF2xQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="273992496"
Received: from orcnseosdtjek.jf.intel.com ([10.166.28.109])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 16:37:42 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2] describe: fix --exclude, --match with --contains and --all
Date: Mon,  1 Jun 2026 16:36:08 -0700
Message-ID: <20260601233727.43558-1-jacob.e.keller@intel.com>
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
Changes in v2:
* Use check_describe for tests.
* Fix test which could return multiple answers by adding an additional
  exclude.
* Add a few additional tests around origin remote.

 builtin/describe.c  | 18 +++++++++++++++---
 t/t6120-describe.sh | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

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
index 8ee3d2c37d02..4d72033e391d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -359,6 +359,28 @@ test_expect_success 'describe --contains and --no-match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --contains --all --match no matching commit' '
+	echo "tags/A^0" >expect &&
+	tagged_commit=$(git rev-parse "refs/tags/A^0") &&
+	test_must_fail git describe --contains --all --match="B" $tagged_commit
+'
+
+check_describe "tags/A^0" --contains --all --match="A" $(git rev-parse "refs/tags/A^0")
+
+check_describe "branch_A" --contains --all --match="branch*" $(git rev-parse "refs/tags/A^0")
+
+check_describe "branch_C~1" --contains --all --match="branch*" --exclude="branch_A" $(git rev-parse "refs/tags/A^0")
+
+check_describe "branch_A" --contains --all \
+	--exclude="A" --exclude="c" --exclude="test*" --exclude="origin/remote_branch_A" \
+	$(git rev-parse "refs/tags/A^0")
+
+check_describe "remotes/origin/remote_branch_A" --contains --all --match="origin/remote*" $(git rev-parse "refs/tags/A^0")
+
+check_describe "remotes/origin/remote_branch_C~1" --contains --all \
+	--match="origin/remote*" --exclude="origin/remote_branch_A" \
+	$(git rev-parse "refs/tags/A^0")
+
 test_expect_success 'setup and absorb a submodule' '
 	test_create_repo sub1 &&
 	test_commit -C sub1 initial &&
-- 
2.54.0.633.g0ded84c31b89

