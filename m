Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB947DA95
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603152; cv=none; b=n84knWz1aB1eWBHh7pTQVaKpdYTzeLeOnnebntUydPoN1htamGgzJso44Qo8s0/hX7W7z3eP7F33tOpPoeSRLqlLx7Ue+efgxYjFxkK4+Hif2kBkYgGJY4uLIMlK0JIZHgEw1rvqwpwLr3fhqX0F/1FyOTN/EdIYjmQEN1ZjsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603152; c=relaxed/simple;
	bh=VgmckuIc4fWXa0H3BgTzGvg7JpxW7uDo3NnxJlGLoXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfGlPRNtVcur+TaRoI6nyrzeD4RDp5pvzT0F6lo9PLiSA/BE5nGcSNOqp+NeMqY0d1V5xYjtYBcKd05p0ET9wh92JIiB06Heogw/3AWpAjT7Xwqmi83+N1UsljtihvtkDmQaXJ36BznCCQZYJXwyY6G5peCWBXFFyoDRlyV/CSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGWoAGsS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGWoAGsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603151; x=1781139151;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VgmckuIc4fWXa0H3BgTzGvg7JpxW7uDo3NnxJlGLoXo=;
  b=cGWoAGsSms0GuB+zgTtqqVuBpwpBB4x32a1T6cQzM2seGaCHCI59LwuG
   G2Rn7XRlUGLzOyLNzz79JD1tUvCMt5Y60DyQTd3Txob8n0lnM6c2VhBUg
   SfaHKcZnPyHAwOTfSP4ayCw2NGIQvMhUKXHrjcHl70NlFJIkNMXOYIF9q
   NqtiLmxG3ZFn7Wj7bSr7GDhwBxhS/CJz+vZtcG1cGpiG9/MGxFrnyviYb
   heE8FIp3Cwn1dNBa3hlDRgVG1yXZV88dqETBxu7AHkeXszyT8GrNGK+wj
   ZpIoz5A7tXQVGF8hV/UQ770XqohJCy0+mUNdp72VJnnb4C2Yg9l0mrpLD
   g==;
X-CSE-ConnectionGUID: 15yk/0/zSp+SXYdNHj616A==
X-CSE-MsgGUID: 6i86PcUGRMysR1cFJvPphA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012595"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012595"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:27 -0700
X-CSE-ConnectionGUID: ig2lWGY4SM63ZVGwKetJRA==
X-CSE-MsgGUID: 8nW4H6qeQf+JDwaOS/q07Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199747"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Jun 2025 17:52:19 -0700
Subject: [PATCH 5/6] submodule: move get_default_remote_submodule()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-jk-submodule-helper-use-url-v1-5-6d14c1504e91@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

A future refactor got get_default_remote_submodule() is going to depend on
resolve_relative_url(). That function depends on get_default_remote().

Move get_default_remote_submodule() after resolve_relative_url() first
to make the additional functionality easier to review.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/submodule--helper.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ef3ff65a80f398c5ac35660288290ad92c7132c7..5542b403217b979d6da92c79d89d0991e980f692 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -60,21 +60,6 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 	return 0;
 }
 
-static int get_default_remote_submodule(const char *module_path, char **default_remote)
-{
-	struct repository subrepo;
-	int ret;
-
-	if (repo_submodule_init(&subrepo, the_repository, module_path,
-				null_oid(the_hash_algo)) < 0)
-		return die_message(_("could not get a repository handle for submodule '%s'"),
-				   module_path);
-	ret = repo_get_default_remote(&subrepo, default_remote);
-	repo_clear(&subrepo);
-
-	return ret;
-}
-
 static char *get_default_remote(void)
 {
 	char *default_remote;
@@ -110,6 +95,21 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	return resolved_url;
 }
 
+static int get_default_remote_submodule(const char *module_path, char **default_remote)
+{
+	struct repository subrepo;
+	int ret;
+
+	if (repo_submodule_init(&subrepo, the_repository, module_path,
+				null_oid(the_hash_algo)) < 0)
+		return die_message(_("could not get a repository handle for submodule '%s'"),
+				   module_path);
+	ret = repo_get_default_remote(&subrepo, default_remote);
+	repo_clear(&subrepo);
+
+	return ret;
+}
+
 /* the result should be freed by the caller. */
 static char *get_submodule_displaypath(const char *path, const char *prefix,
 				       const char *super_prefix)

-- 
2.48.1.397.gec9d649cc640

