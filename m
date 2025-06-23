Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F322A807
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720626; cv=none; b=EhehBPhz9P7PsTPbM/zD27TqKPI/DPGUrgefJKr7XHg0SBLSwOx7G4/HBR2TpLPFHEQaaxN1jQ8djSv9yEhvqhnkq8BDxnqNdwmC6vruZd+raBdH5cM1mybGyOTJevJbXdsZx9xx7VArnk8gQNDB90BYcK6X1yGNqpxb0fmBeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720626; c=relaxed/simple;
	bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/SD4T6k95z3/Azm+7ID1r1HKMfGJLhDcszq1iPFfZx06zf49dWmOxL7XIoUHjqQ7h8xrcoruECQM8s0Z+T5U0809gA4lEATanJ3jol/JVUMz9xB9w/9U5ppg7gBKY8V13aeYT1EIFVuP8+ERQRlYPv3x0z9K5Biyj+Z8eiUbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvnzueO6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvnzueO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720625; x=1782256625;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
  b=CvnzueO6jr5m0Qfxwluq0slWuYHFMUjpY/dUX1tsMa2rdOWuyTrs8+Vo
   y4O7uR+a0trhvtsTdN9bt6BlSVzb3D8nt7vOF4YD0mMulQPQxhy8kNxGP
   WjHpmdMjKXzL+iwPImyO8cc37HhK1/GMSj3czhl6YpHT7o4/kksRvP3Kc
   l2hanXm7bFqkFdsGGFZCdLxg0I/Ffq9KPIdcuPmMmWNA5Bkr4IGHxdq5I
   IOuYwrIy84G9wfNhXRknLaD3+VCysNxJlxNrUvqLyiDASBevy1mN9rVR+
   xbONK0TTIc9YtoFbyHZSGkHaltf0opxUXUcO1sTaPDj+hN+Z1+BOkc6E4
   A==;
X-CSE-ConnectionGUID: 6VhLpWo8SFW2tQnuhoA3Dw==
X-CSE-MsgGUID: 8sAfml4URqqnTYOtasVJiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084562"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084562"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
X-CSE-ConnectionGUID: 13QmswE4S7+ggkgzBJmwpg==
X-CSE-MsgGUID: IAUwDaiVSyGZrF2zdAfrfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888468"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:41 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 16:11:31 -0700
Subject: [PATCH v4 3/7] dir: move starts_with_dot(_dot)_slash to dir.h
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-jk-submodule-helper-use-url-v4-3-133ef3d89569@gmail.com>
References: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
In-Reply-To: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

Both submodule--helper.c and submodule-config.c have an implementation
of starts_with_dot_slash and starts_with_dot_dot_slash. The dir.h header
has starts_with_dot(_dot)_slash_native, which sets PATH_MATCH_NATIVE.

Move the helpers to dir.h as static inlines. I thought about renaming
them to postfix with _platform but that felt too long and ugly. On the
other hand it might be slightly confusing with _native.

This simplifies a submodule refactor which wants to use the helpers
earlier in the submodule--helper.c file.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 dir.h                       | 23 +++++++++++++++++++++++
 builtin/submodule--helper.c | 12 ------------
 submodule-config.c          | 12 ------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/dir.h b/dir.h
index d7e71aa8daa7d833e4c05e6875b997bc321c6070..fc9be7b427a134e46bcd66c8df42375db47727fc 100644
--- a/dir.h
+++ b/dir.h
@@ -676,4 +676,27 @@ static inline int starts_with_dot_dot_slash_native(const char *const path)
 	return path_match_flags(path, what | PATH_MATCH_NATIVE);
 }
 
+/**
+ * starts_with_dot_slash: convenience wrapper for
+ * patch_match_flags() with PATH_MATCH_STARTS_WITH_DOT_SLASH and
+ * PATH_MATCH_XPLATFORM.
+ */
+static inline int starts_with_dot_slash(const char *const path)
+{
+	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_SLASH;
+
+	return path_match_flags(path, what | PATH_MATCH_XPLATFORM);
+}
+
+/**
+ * starts_with_dot_dot_slash: convenience wrapper for
+ * patch_match_flags() with PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH and
+ * PATH_MATCH_XPLATFORM.
+ */
+static inline int starts_with_dot_dot_slash(const char *const path)
+{
+	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH;
+
+	return path_match_flags(path, what | PATH_MATCH_XPLATFORM);
+}
 #endif
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116ddf576bc565b29f043e8b703b8b1563b..9e8cdfe1b2a8c2985d9c1b8ad6f1b0d1f9401714 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -438,18 +438,6 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
-static int starts_with_dot_slash(const char *const path)
-{
-	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
-				PATH_MATCH_XPLATFORM);
-}
-
-static int starts_with_dot_dot_slash(const char *const path)
-{
-	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
-				PATH_MATCH_XPLATFORM);
-}
-
 struct init_cb {
 	const char *prefix;
 	const char *super_prefix;
diff --git a/submodule-config.c b/submodule-config.c
index 8630e27947d3943e1980eb7a53bd41a546842503..d64438b2a18ed2123cc5e18f739539209032d3e9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -235,18 +235,6 @@ int check_submodule_name(const char *name)
 	return 0;
 }
 
-static int starts_with_dot_slash(const char *const path)
-{
-	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
-				PATH_MATCH_XPLATFORM);
-}
-
-static int starts_with_dot_dot_slash(const char *const path)
-{
-	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
-				PATH_MATCH_XPLATFORM);
-}
-
 static int submodule_url_is_relative(const char *url)
 {
 	return starts_with_dot_slash(url) || starts_with_dot_dot_slash(url);

-- 
2.48.1.397.gec9d649cc640

