Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87134248865
	for <git@vger.kernel.org>; Tue, 20 May 2025 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699297; cv=none; b=Rs4oxHyRRLLbq1eQJoHcIKqRbeEw+xMGtJQ373ERAjTYaCTo7OqQ7nsO2IgNLc/gx937A4h1e4UwtMkmgOhz1wna0e6yDdRXv1Wyh6FXPIZE5W5yp4PXedCjqrz/+nWiNq3SzNGPc8DAh17mYuvbIj8JxRLkgFwMJc7wHZRj1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699297; c=relaxed/simple;
	bh=+lbUn/4YGEzDCckkGaSE/sQtBhg7seOvn3PwL9vOJ5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPX1e9JbsYtyYXlEhfwLA3m3bzSaeoXVNpAtBse56/WS9d/QOxcS5oh4pXm+R69Rk5Xo5nJo9CkdRrseJc4LbuQSmyrwR8QAv5Yh8x7fg5bc36IIrgcoTbglm4C64jcrl45MjVuAQYYC7gTpJ3KDuAI1QpQIATNpw4nerQz+6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3bD7fUW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3bD7fUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699296; x=1779235296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+lbUn/4YGEzDCckkGaSE/sQtBhg7seOvn3PwL9vOJ5U=;
  b=B3bD7fUWQMTyfnWmaRNMvV1mLtROI8NVrnM6i+SvpM6kf1Mj9nb+hBR6
   NwojirT1+3+rNsWNGkPQXw2+bdKW9XJlgSo2L+yKBF/jNfrC+xrCEuOgZ
   0bCh7zRggirdfM1RkCytV198q0JKYSsoUEl0cbckD8ESXQRRzW0Lo6jdn
   t/lbgNJobwZIxvQsQP4pmvcu51GdOfItrwHmqMlAD0jB2F+DCSENm3I8E
   mw8cBh/G5uVI0kpPQFpnxr5jvGzm6+bvuc8iEcr+yG9cBzvqrpPz8zSot
   cYlXyZODfp70LngIzWVjZTProS+lgKV7FQajL4SiRtG0vSGIpQIH+eri7
   Q==;
X-CSE-ConnectionGUID: fWgo/lg8SJeVaICP39cttg==
X-CSE-MsgGUID: RrMWvgqWQQyzI8FDRBgXwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="72125822"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="72125822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:33 -0700
X-CSE-ConnectionGUID: 8T8aTuTjT7mfZe2vNcxjBA==
X-CSE-MsgGUID: QKUDbu6lQXydk8l+viHQwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139559137"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:01:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 2/4] pathspec: expose match_pathspec_with_flags
Date: Mon, 19 May 2025 17:01:23 -0700
Message-ID: <20250520000125.2162144-3-jacob.e.keller@intel.com>
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

The do_match_pathspec() function has the DO_MATCH_LEADING_PATHSPEC
option to allow pathspecs to match when matching "src" against a
pathspec like "src/path/...". This support is not exposed by
match_pathspec, and the internal flags to do_match_pathspec are not
exposed outside of dir.c

Make match_pathspec_with_flags public, and expose the
DO_MATCH_LEADING_PATHSPEC and DO_MATCH_DIRECTORY flags. The
DO_MATCH_EXCLUDE flag is kept private in dir.c

This will be used in a an extension to support pathspec matching in git
diff --no-index.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 pathspec.h |  8 ++++++++
 dir.c      | 11 +++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/pathspec.h b/pathspec.h
index de537cff3cb6..d22d4e80248d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -184,6 +184,14 @@ int match_pathspec(struct index_state *istate,
 		   const char *name, int namelen,
 		   int prefix, char *seen, int is_dir);
 
+#define DO_MATCH_DIRECTORY (1<<1)
+#define DO_MATCH_LEADING_PATHSPEC (1<<2)
+
+int match_pathspec_with_flags(struct index_state *istate,
+			      const struct pathspec *ps,
+			      const char *name, int namelen,
+			      int prefix, char *seen, unsigned flags);
+
 /*
  * Determine whether a pathspec will match only entire index entries (non-sparse
  * files and/or entire sparse directories). If the pathspec has the potential to
diff --git a/dir.c b/dir.c
index a374972b6243..2f2b654b0252 100644
--- a/dir.c
+++ b/dir.c
@@ -329,9 +329,8 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 	return 1;
 }
 
+// DO_MATCH_EXCLUDE is not public
 #define DO_MATCH_EXCLUDE   (1<<0)
-#define DO_MATCH_DIRECTORY (1<<1)
-#define DO_MATCH_LEADING_PATHSPEC (1<<2)
 
 /*
  * Does the given pathspec match the given name?  A match is found if
@@ -551,10 +550,10 @@ static int do_match_pathspec(struct index_state *istate,
 	return retval;
 }
 
-static int match_pathspec_with_flags(struct index_state *istate,
-				     const struct pathspec *ps,
-				     const char *name, int namelen,
-				     int prefix, char *seen, unsigned flags)
+int match_pathspec_with_flags(struct index_state *istate,
+			      const struct pathspec *ps,
+			      const char *name, int namelen,
+			      int prefix, char *seen, unsigned flags)
 {
 	int positive, negative;
 	positive = do_match_pathspec(istate, ps, name, namelen,
-- 
2.48.1.397.gec9d649cc640

