Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05C2EAB90
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195857; cv=none; b=jjK61uQC5JkLCnv1WNueuGiR3KFbBqtZ4V+o7AesE6TeV/b8hovguo833Kn5oxR6e4aWRPsnaPlfKlK6J6zmYXZNVs5wjaYlfrDC4tFQU/RxmJ3PvDjFQk4CLcp5Ei5TYWT5RHZTZwvZFATQ2Igo93aPmXPVlUcvkwFVwdgDGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195857; c=relaxed/simple;
	bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwsqtHxEgG7Rg5+BVj7D5LmWSKX3UtmL5Nr6459LK18wjE6h0Pu/fTjQfIFCqWuJYgp6urMi+gFS4TX5lrCEg70tdznxtrkm9ZJpMy6x0TLMekHTb8JxKt2yqM8Nd9hu941ManA+5hqxH9DrBm0YUmrIhUsfci74BaRCD+NKIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNb4FxcT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNb4FxcT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195856; x=1781731856;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
  b=nNb4FxcT6vk1tBIbQPpS1jRubqKsmKFFTDmH13u8irEYpRt86B5J8nqd
   syGH6flSrR/sJEsnmzs5nGMPWZxqlMcpVmxhC+gaayZKqRzCey/YaYjbl
   zCLVRCIO4htz5pGZ1dOBk0vcMl3dqTjfTt/qLRAp5FmtIuoWW1vl5Jmr5
   8Mt+wLg2SNhwfcJvJwJnc1UrDBoyDX7LoVfUsiDs+SU70cWCJzFTDIPth
   Rz6zLCLhPNXnVvNMTtplZrs4zCX4BkuSPjYSMwOojxEpAWR14ZPSvIITp
   wYhWNVV4wgd3u9WOw5LS73gFxrJLCXg2uGoH+UzzOXyOkbIy0vgAHjCOI
   A==;
X-CSE-ConnectionGUID: dwKXSCL9TqmOCCh3KCM8Tg==
X-CSE-MsgGUID: fLCBhmzoShuGT7+QJhAyOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195380"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195380"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:52 -0700
X-CSE-ConnectionGUID: PiXnpXXgTOGJtUhvm4924Q==
X-CSE-MsgGUID: krMwrlceTJ+m1/LRGJilpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856673"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Jun 2025 14:30:42 -0700
Subject: [PATCH v2 2/6] dir: move starts_with_dot(_dot)_slash to dir.h
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-jk-submodule-helper-use-url-v2-2-04cbb003177d@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
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

