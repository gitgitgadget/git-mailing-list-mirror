Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40163CF
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603149; cv=none; b=qVpUkzgEWr9pxhGTBPkZcj3Zu+m91v22+uwC+ZqljBOPs0SgR2nP7Vi4lJiENKdtuHAQ/UOhQIk/bM7pL9TCnsOs1usNhxb+6F1tywWXB8hM9mZ9/HHVN548fJCTZ1jHh2zKq+YtgVAnFzF+y4DbqRbfwtOhMkCrFLnhpoEuVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603149; c=relaxed/simple;
	bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsZXYpq02YFK4gDxCqDLFdMXA1GQIf8VHDhXJhbTbst9sJ9cj0kk8wkc+tcc/ImhhAewJh88IUm8z4HJ5VxrGohWaomw8s1fdvb0UX8lpETsAX3OyVGPcOaY+W6cptv2Y3X/HutNDtSCbq0dn+9T5elnG1ndX3+4IiRl4waIm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PB5wC42e; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PB5wC42e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603148; x=1781139148;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
  b=PB5wC42etN5hlEmtKGb1t5UMZ10B1ZXmjcLcnjgbspt1uANgR01dt1zm
   iFyVwfip0gRZDmbp0OkOzUtniwlZe67YtgCaf2G5CvGOmPKsBRCoI8Xmp
   csIgU4GG55REyFmeSiPHzcKaWCPb0B96QW6u4K7BngaLEgq15TCDrSE3i
   1SDWmvMrE0RhiQkIiZOCKoq/7lQqLe+ZzoSZjWYKs+mZvByzJVnGAG0NG
   8O3nByNqhzQm+eXaPjTlZiIb9zJ1qJaVoC61+tKZ5v0DRMGXtG6GKmSaD
   5Qm2LsRprDLVBFgrBATbRkp0Jt7/9VjupaogRfABreqqTS476egrYPg4B
   Q==;
X-CSE-ConnectionGUID: XXDDUqzXRxiiTxW4DIVA4A==
X-CSE-MsgGUID: 40f/rCkPSGSWpRERyywW1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012579"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:26 -0700
X-CSE-ConnectionGUID: P8iiGUl/RzGkZAedTOt8Iw==
X-CSE-MsgGUID: d01nW53kT3eDFTzUO3ngBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199735"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Jun 2025 17:52:15 -0700
Subject: [PATCH 1/6] dir: move starts_with_dot(_dot)_slash to dir.h
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-jk-submodule-helper-use-url-v1-1-6d14c1504e91@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
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

