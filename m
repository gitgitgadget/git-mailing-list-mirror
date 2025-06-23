Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42622CBFE
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720628; cv=none; b=Xvm8kJbmAjSJ+gMi3wDHkmMOpxPG/HnsIxFRNFihjFGxl5+LWouj/rKEfr9vnA0gynbjf7JznmQlhX3A/DfU4qrmg+amcqv+/UVxlDCotkeFnRiR6i+gH3YPjVNzfIXtWHQRMsOo18yl20as1U00PLWKePc67oZb642ZHGVWo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720628; c=relaxed/simple;
	bh=aTosWpJP6QiKRHluwbcokWc/c/dT/No4gjaX2ZuTK2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoQk8YXT13czCDLGkKMguo4gom1Pa7VeI7oKO8E2ejrnKs5HLP4551h59H5Ps8MO+22hBwsN6TiApxnHhXXnOEx+XvG/NRWcYDDfwLSTLYNkTqO9i/Af9ay2E3CMsf55+wtzUzDOEsTgTnaBRaZLh6N+Nlln6XkIWiaWRiCL6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlswhzQL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlswhzQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720627; x=1782256627;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aTosWpJP6QiKRHluwbcokWc/c/dT/No4gjaX2ZuTK2U=;
  b=OlswhzQLCxcZHNpcNaRC7RcpCTwyM3wZSWYLBsyVuilBO4R0flc1//03
   I7SToIQOTTrt17saIRIHWqAN+w3zGuoZlgMRj95PTXtJNK/2hq0guvj9N
   z+ltgq1rsfbGasebxndQ9Fy9OH6Z0JTsdcuaPOKZ3uoB7xkgs3a7hCtUC
   j3T7NntLlOVTng3QletwsPC+/TheGwCdQjJjavrllQpQ+Q4JwQrpyU5XF
   UhRIwFl57DT429AM8OPaBwFO5yyOdJ5FtvayfkXu/eIWdqb41fnV8DtIk
   +hQabFJbcOTGWyoW37aKFfzVRUcywE/2XNcgXRMFtdYkAYgOZQESsSzu+
   Q==;
X-CSE-ConnectionGUID: 5a2dF4zcRw2jZxqIwSI7Pw==
X-CSE-MsgGUID: YR8KoPN6ThewLjtb74RCQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084574"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084574"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:43 -0700
X-CSE-ConnectionGUID: rHM4s2fPRl68P6W9Exdg0Q==
X-CSE-MsgGUID: BR3ADe+WTCyDz/KaX8fgDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888482"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 16:11:34 -0700
Subject: [PATCH v4 6/7] submodule: move get_default_remote_submodule()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-jk-submodule-helper-use-url-v4-6-133ef3d89569@gmail.com>
References: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
In-Reply-To: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

A future refactor got get_default_remote_submodule() is going to depend on
resolve_relative_url(). That function depends on get_default_remote().

Move get_default_remote_submodule() after resolve_relative_url() first
to make the additional functionality easier to review.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/submodule--helper.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4aa237033a526fca29cce2926419462179d40ee3..1aa87435c2000e94f43da94c5ef88a307f6f3f4a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -41,22 +41,6 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static int get_default_remote_submodule(const char *module_path, char **default_remote)
-{
-	struct repository subrepo;
-
-	if (repo_submodule_init(&subrepo, the_repository, module_path,
-				null_oid(the_hash_algo)) < 0)
-		return die_message(_("could not get a repository handle for submodule '%s'"),
-				   module_path);
-
-	*default_remote = xstrdup(repo_default_remote(&subrepo));
-
-	repo_clear(&subrepo);
-
-	return 0;
-}
-
 static char *get_default_remote(void)
 {
 	return xstrdup(repo_default_remote(the_repository));
@@ -86,6 +70,22 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	return resolved_url;
 }
 
+static int get_default_remote_submodule(const char *module_path, char **default_remote)
+{
+	struct repository subrepo;
+
+	if (repo_submodule_init(&subrepo, the_repository, module_path,
+				null_oid(the_hash_algo)) < 0)
+		return die_message(_("could not get a repository handle for submodule '%s'"),
+				   module_path);
+
+	*default_remote = xstrdup(repo_default_remote(&subrepo));
+
+	repo_clear(&subrepo);
+
+	return 0;
+}
+
 /* the result should be freed by the caller. */
 static char *get_submodule_displaypath(const char *path, const char *prefix,
 				       const char *super_prefix)

-- 
2.48.1.397.gec9d649cc640

