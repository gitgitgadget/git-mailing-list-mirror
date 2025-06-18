Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086772820A8
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288117; cv=none; b=XIcuEPtlcEDEkGtlZtGDHhUAih1bGEv9UnP7Q6lGNVI5g4ykM4lEYVKKmTCXDuhIH2AS9y3DqjuZkqNCqyRkSL7Buvo/G7F1Re2HB/2COg2PCwP8DL/TAmohE53UP302/+B7woXGMcKDokjxEUTBtfKI9OQhBPNS9XuyMBEoZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288117; c=relaxed/simple;
	bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXsnNIvo0+SMBFk22v0oGB0ei5/OqGOl+484gzGWgEfDtdAN7jgduPCucfVrqkieOV1x+WYSHFG2HUALjPM1HsteGIL39K1qsYULOhHcwc5zEbdpLINc5J6xzyXwDCcWi0jjJPLcXAUED1nm4JCkWgHTYL90r0ob7monD4Mp2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7EYs1WE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7EYs1WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288116; x=1781824116;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aBXMBigi8uNmM74Gsd7x+ZZ9p6PVRtgYI72H3Yf5ai4=;
  b=k7EYs1WErDlmWGZnLoq1xT5yZe8AjfeVtuUiPVtMcPSmtQRjLzD+wSpS
   3AcOgc0gidLY7Dfenamc/TrO58pad4B1pcV13S0EuAT7YczwVIsuK2Jdj
   dPj+GCE7k/C4aM9Jl9AQpT7IogRM5lLdKh7KIVMfZvd4PA7XrYPWOgsBd
   u3imKIxAQr0xOi5B7YOTl+OhbFS0T4n2T3IjA/UQ/eIAPvzDNlH5/j5ko
   E9RDc4fK1MYr7PSSD+g/1+lIZ9IVbwSOzEffEpmUpdoZ6n+RLTuzcsPmn
   pdglTekdZEqrF/80QsBrIhPYNz3udjOcCn4S+7POyK0cBhb76SUW/aJB9
   w==;
X-CSE-ConnectionGUID: 8k5OLpXqRMyXxrs5zs85SQ==
X-CSE-MsgGUID: zFKLSoS8QgKc4DsG6rnhpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69966810"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="69966810"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:31 -0700
X-CSE-ConnectionGUID: pJTas4I+QVGlEW+h9osJrA==
X-CSE-MsgGUID: nE57LepXT1GNvb1kOImgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="156048563"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 16:08:17 -0700
Subject: [PATCH v3 3/7] dir: move starts_with_dot(_dot)_slash to dir.h
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-jk-submodule-helper-use-url-v3-3-7c60f2679271@gmail.com>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
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

