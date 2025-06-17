Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5632F0C5E
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195859; cv=none; b=ltJVQC8EGKjSCYLPHI6qHGv8y91uJnKIH3pA4Y4KeRfXhDk+Mst25tNG1SnYOA5SGGBI0JymTzYLaTETkgY15EUnAlNr6tOiw9sRkQdZimkAOmweSmrF4QS+S/eLwTRqhyyHSb60mOvEPgI11BF87igzwoD72arXdgOzerJ9Kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195859; c=relaxed/simple;
	bh=aTosWpJP6QiKRHluwbcokWc/c/dT/No4gjaX2ZuTK2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ox0svTOW7J4fK5ccOFtKAFpZKih2Ujekz7lY5Rf1zhvjfqJduPB8rgKxunrW75UOHzfoDI00VOpN2mFF2jgrpWub0y1XphMZIuWyczj3w8e0ybvs0tAKUMLc27J/pLQLN/uYIsIQ8tN/qWynoBT5R7+aFVwuJ1wFML1NNRpGZFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVfk7S/R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVfk7S/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195858; x=1781731858;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aTosWpJP6QiKRHluwbcokWc/c/dT/No4gjaX2ZuTK2U=;
  b=FVfk7S/RvMh6CPH9Qd2eQlU+TpeiT6heRmYHaJRsTVSAfvEjx/Qi0iIs
   m/jQClhizxbMX2iYUcXHqMv6fq9JRfNMekCnisCeJxM9PXI5nuIbBwvcZ
   s9VztKnaDXTHMkN+/lYYi2lQeVESEfOCJHgWfRqMWv0BlZ4BTBkvi766H
   Ei/WUETgunkDby4TGMPjnwHqoH2cIcFyaINLh/xwGcK/NrwF448P0U8iX
   pyll5pohmOXuaheTtbtFL4vZ9dtYlm63HyXaeguoLyak/Zy5tnH8b1KWp
   Yz/Tlm4ZWx1d3mCMqbqDPvl1MzoGUEYkvNK76lSlMF6aDiOn43KNjyYAp
   g==;
X-CSE-ConnectionGUID: cbvBavQ9QyCbYjYUdJDNTQ==
X-CSE-MsgGUID: GFflrHkQSqKq4K4K/ppOTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195393"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195393"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
X-CSE-ConnectionGUID: 9B9Qm9QzSYmSENBG8bg0uQ==
X-CSE-MsgGUID: HOZUh7OqRLWoCLU0GGUT0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856677"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Jun 2025 14:30:45 -0700
Subject: [PATCH v2 5/6] submodule: move get_default_remote_submodule()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-jk-submodule-helper-use-url-v2-5-04cbb003177d@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
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

