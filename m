Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9D27F4D4
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288119; cv=none; b=k44ABKFp/FCtY6hB3ETTZlT4RQopDitKRStapdQDA0Smr/pV9QmAxkKHX492BVZBK2mRYoT2M8lgIxX+untk25HcgkJODhIGOnWcQ5K42f92ctUb7sG/PH++2nHWrN3cZs6FAOME4YPxEyxOH/wHv00RTuS8QZcYfa6Ne6ywzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288119; c=relaxed/simple;
	bh=aTosWpJP6QiKRHluwbcokWc/c/dT/No4gjaX2ZuTK2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j8dvE77Vu4C+c0JDEtP+8YvxcCvWEzR0k+nLKUIrGObtmHgf8gU49J3Wq9qR05ilEjSH4naOQS7oQwqgUB+REaJjQX1NGFi3Y9lYskehle4a3YY79Wktf/x3WFYVif6XNbsszW6LQSSOrX6eIWpDNyidq8x/LSXE3SZeNMrWgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gozn7X7e; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gozn7X7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288117; x=1781824117;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aTosWpJP6QiKRHluwbcokWc/c/dT/No4gjaX2ZuTK2U=;
  b=Gozn7X7eJvyoySkvB+dc/lAfqSULPyyvEmK+nTtpUUa3NP/vQ6BeF8Is
   5DLlEThzmTFq2UhGdRLVM030wZ34bowYgFECa6DXZVJhvwPRrCMoWiO1M
   s+EVUoEU8RZsNGTJQ6o6YOYI+Za+0QUOfvxtobU/hgUvHwCBa+77bfE0w
   aVYq8ChXIMQx2IJn35QM/dQceLPvoB8TNPNUY4QMjKQmt6A1GOm8zs3uS
   OsUXCHby2DeEklCHKu/r4kcb3kv7AmV89GFnw9VNeIG1N4quE3wWiuVQq
   mqMI0uGxwIOwNGm2Ignws2hNIROaq5aF1hgy6tS8CAvptzzL6me093ABX
   g==;
X-CSE-ConnectionGUID: UlA027qzSVu28Z96mA8ofw==
X-CSE-MsgGUID: /oFfu2hGQCm8Pq35eabZhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69966824"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="69966824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
X-CSE-ConnectionGUID: dMsbBHW7RA6JvX1DnI+YLQ==
X-CSE-MsgGUID: ND7cjZMIQxOjgg4Hlf2n5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="156048566"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 16:08:20 -0700
Subject: [PATCH v3 6/7] submodule: move get_default_remote_submodule()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-jk-submodule-helper-use-url-v3-6-7c60f2679271@gmail.com>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
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

