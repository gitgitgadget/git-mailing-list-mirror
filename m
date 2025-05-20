Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57B24888C
	for <git@vger.kernel.org>; Tue, 20 May 2025 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699298; cv=none; b=KzQdlHu3U1hFiFnb9TnYa5Yg4T4n6b17xul/EDtphHkW3/It9wwjQu12737tA2Ns7nzADCNnXdIZQ1oSKwUKxr0NuV/BLH6AAU9lSCr1ec3q/fuhRXv5cZQ3wo56ad477Euh+sDXA+Ykamnbz7luszbi3uNQd5w/JRO/oaSzWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699298; c=relaxed/simple;
	bh=9HV6ipnIafidB9vtRFkGdYwuc4WMeRmQxC0djUdnxeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjMYjMWtz6y2Epu2q4nC9SvD6PyGvlpKGV+vBFjlrn0JALHeJCGEHXFaG9Na+IY15Rzsmfdpae/i8lGFP2uv0JnrvdBXO9WaJj2b5VVT/9lBCditv7MY1cK02KI6htQGQxPTxcxmebl1djAREoD/xmfTUGS7me7y1ku4pdWmuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBoyvqlc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBoyvqlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699298; x=1779235298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9HV6ipnIafidB9vtRFkGdYwuc4WMeRmQxC0djUdnxeE=;
  b=IBoyvqlciFNd8hvTkzGo8Z0RFQhlKnMq81hQLh3G9FXT2AGOzvze08v3
   8a67mxJ2Kh97VFAd1WbkVZIC3ECKItIypZThO4iS39aPLT/l+A4v6WMjb
   1eu92x+PMLSrkSXdlvQQQsKisveKAf6vBS0MkVpEMGTMaV1q3H13RUIOY
   hlnxbAMLcTkvHPaw4+7PeniBJvJV5NMVTfbYZ+/R8rXehXxrFUm92KU7z
   v3IOsrmDl5YoxRJ0d/QmRl+CfT5p/eWNSmYrgrg7ZMy1U4G2Dt4RkllwR
   n5QJx95jyf/Ks9PYzGJsbKeCfVUniQe5nBBK6mWwSrbFsU7Kk4lRtCXFx
   g==;
X-CSE-ConnectionGUID: DlmN24uiSGSddLvKmxnpaQ==
X-CSE-MsgGUID: 7I88OUTdTOiKZH0MX4Ywcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72125825"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72125825"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:33 -0700
X-CSE-ConnectionGUID: xzuUhia8QhatdPz11bE7zg==
X-CSE-MsgGUID: 6xLyfs5DSU6COO/k75FDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139559140"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 3/4] pathspec: add flag to indicate operation without repository
Date: Mon, 19 May 2025 17:01:24 -0700
Message-ID: <20250520000125.2162144-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
In-Reply-To: <20250520000125.2162144-1-jacob.e.keller@intel.com>
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

A following change will add support for pathspecs to the git diff
--no-index command. This mode of git diff does not load any repository.

Add a new PATHSPEC_NO_REPOSITORY flag indicating that we're parsing
pathspecs without a repository.

Both PATHSPEC_ATTR and PATHSPEC_FROMTOP require a repository to
function. Thus, verify that both of these are set in magic_mask to
ensure they won't be accepted when PATHSPEC_NO_REPOSITORY is set.

Check PATHSPEC_NO_REPOSITORY when warning about paths outside the
directory tree. When the flag is set, do not look for a git repository
when generating the warning message.

Finally, add a BUG in match_pathspec_item if the istate is NULL but the
pathspec has PATHSPEC_ATTR set. Callers which support PATHSPEC_ATTR
should always pass a valid istate, and callers which don't pass a valid
istate should have set PATHSPEC_ATTR in the magic_mask field to disable
support for attribute-based pathspecs.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 pathspec.h | 5 +++++
 dir.c      | 9 ++++++---
 pathspec.c | 6 +++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/pathspec.h b/pathspec.h
index d22d4e80248d..2b47f9a2a213 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -76,6 +76,11 @@ struct pathspec {
  * allowed, then it will automatically set for every pathspec.
  */
 #define PATHSPEC_LITERAL_PATH (1<<6)
+/*
+ * For git diff --no-index, indicate that we are operating without
+ * a repository or index.
+ */
+#define PATHSPEC_NO_REPOSITORY (1<<7)
 
 /**
  * Given command line arguments and a prefix, convert the input to
diff --git a/dir.c b/dir.c
index 2f2b654b0252..45aac0bfacab 100644
--- a/dir.c
+++ b/dir.c
@@ -396,9 +396,12 @@ static int match_pathspec_item(struct index_state *istate,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
-	if (item->attr_match_nr &&
-	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
-		return 0;
+	if (item->attr_match_nr) {
+		if (!istate)
+			BUG("magic PATHSPEC_ATTR requires an index");
+		if (!match_pathspec_attrs(istate, name - prefix, namelen + prefix, item))
+			return 0;
+	}
 
 	/* If the match was just the prefix, we matched */
 	if (!*match)
diff --git a/pathspec.c b/pathspec.c
index 2b4e434bc0aa..a3ddd701c740 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -492,7 +492,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		if (!match) {
 			const char *hint_path;
 
-			if (!have_git_dir())
+			if ((flags & PATHSPEC_NO_REPOSITORY) || !have_git_dir())
 				die(_("'%s' is outside the directory tree"),
 				    copyfrom);
 			hint_path = repo_get_work_tree(the_repository);
@@ -614,6 +614,10 @@ void parse_pathspec(struct pathspec *pathspec,
 	    (flags & PATHSPEC_PREFER_FULL))
 		BUG("PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompatible");
 
+	if ((flags & PATHSPEC_NO_REPOSITORY) &&
+	    (~magic_mask & (PATHSPEC_ATTR | PATHSPEC_FROMTOP)))
+		BUG("PATHSPEC_NO_REPOSITORY is incompatible with PATHSPEC_ATTR and PATHSPEC_FROMTOP");
+
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
 		if (flags & PATHSPEC_PREFER_FULL)
-- 
2.48.1.397.gec9d649cc640

