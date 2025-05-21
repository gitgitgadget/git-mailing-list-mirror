Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632F23C50D
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870166; cv=none; b=FPxjkyTuYP/XRueCnY/hFANtmqqISfDlr+658HLbnxIfVQya+oWfNbn558+DMYK4BOxsJ/XXNLyhsDB439WV4QcDhe9t5cSt0bHvDyXNDvgmp8+DyQ4shuNaaLnF+WE0xFYyeJ0mKKdCZhNl9vURZgtaVOZSbrcMxvX9JytD75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870166; c=relaxed/simple;
	bh=Ptc0dydhuJjI6gTVclmglzC9OCrUqIAQG+Y2PGy4hRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/ggkCkXYG8IzYIj71OmjrGbrst3GPPgl80biPjhyG8Zx+Fal+RDSyajpbiAbwNdGn+SmH9lrsRyh3E06+f1g6k/o3nrvg+1A9M2Rg0MBs2Piq6215BNaF+jgwKtPEbOfDlTYA2ZFBsaNX7iP1VsqXmrWLQuQdOxm9XNucCnm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwnmVDaj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwnmVDaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870165; x=1779406165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ptc0dydhuJjI6gTVclmglzC9OCrUqIAQG+Y2PGy4hRg=;
  b=IwnmVDaj+dKhmnpYVAYbIWWC/KhjF3NyxbD9X74UbxIvY8hoTLKAltju
   jfDWcUxTL++4LdOym73jMwxYXyjztydnm98zcL+MLOTet+m7Nkdz74iHC
   JW19IpIS4eHyoWC04PJGeCd+0vTEXTwS8VGDOjHB7eCpKL3xjnvJ+LzVP
   JGpbJEY5eyH5jlctu+2TI0R9gDO7KDLnLGnqu0TwUnZzQqh17RKSv4Fa2
   73B3ffSBFBxvbzk/uiQYz0pdxp7RKAObKLFDLXmWyoe+eOm3m7/d3TGht
   Lfrj1Dpwok0Cmcl9IZ+Mv4oEXPxrW1JzGLU4OYOXo8d4L2WX6FTE2cGB1
   w==;
X-CSE-ConnectionGUID: vg+K4SS3S2mCm1iHf6B2tg==
X-CSE-MsgGUID: YFOfQ//kSt2MWFBlSoIKRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75271682"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="75271682"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:22 -0700
X-CSE-ConnectionGUID: b21u6XtuTzCBvZN+lDmaxg==
X-CSE-MsgGUID: xpHL6wG0TsylbiMiDSdurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140072361"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:29:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v4 2/3] pathspec: add flag to indicate operation without repository
Date: Wed, 21 May 2025 16:29:16 -0700
Message-ID: <20250521232917.2333291-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.48.1.397.gec9d649cc640
In-Reply-To: <20250521232917.2333291-1-jacob.e.keller@intel.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
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
index cda3eb5b91f7..5e3a6f1fe7b7 100644
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
index 86eb77b82a79..c8c869faed2b 100644
--- a/dir.c
+++ b/dir.c
@@ -397,9 +397,12 @@ static int match_pathspec_item(struct index_state *istate,
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

