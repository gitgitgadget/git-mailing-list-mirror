Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B022DA06
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720629; cv=none; b=CuLTrvImLt0zZlk7fosn5VZIjXW1TXzc1sCXz59TPZYSbptE39WbGZWeC4hNOTnrUuw7q5SufRuayKdQmo7fu4BQmcOjcdOQshQXVQm2O3aNgcPI30ekpVsEHyYtfuoZjS/mHj9a321MS99b1TH8jBp1z/EbV8E9fXCCEuBTcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720629; c=relaxed/simple;
	bh=revFBmeE2Dde2hNNmxcH8F3RaUpIshdr0ndxlhK19XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS9IfHJhQulrpvhD0qYCKKjf/VKzg6SQqJ0LIRoGHl7Ssjbac7+6ki351hYSTr7rQWN+2Hi28R0jbf0OIpyjVcdyCodynBpSsdZnlzEJh5JXbxe8kDNbsOAw/OS/163SdFFQPEAAvdehkyVge+Ud5NGPHj0CPpdKC00HdcTPpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmGW16LZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmGW16LZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720628; x=1782256628;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=revFBmeE2Dde2hNNmxcH8F3RaUpIshdr0ndxlhK19XA=;
  b=LmGW16LZCmFudnlozSH4mdiNwWz2DRdkwj/xFc10M+U7PLlzS0eKZrDi
   bJ+LSckHFrwp6BFiM2CIXj6n2P7vSCQMR1sszk9SyIZQlnLPZhib5OnM4
   vBnd3dqNmTWswbBOxHD2AXVRQyjXA002Ye5j+Y8QUuONlb+nK78+psoOd
   FNjpXTwAtRsm5/Vxvk/7XLxyTU9MI0EXW+O65CIRL6f4L9XJvysMytyub
   BaDHEr76U910WoidaZnZvV2Aj828zTKduEJIXXOYQHDad2ioDv8hhU2TX
   4F8+MtATwnh5b58Z3/GCIxTX8dNVKmB4dNdTYc7I1uL5g9h8soosiWBGe
   w==;
X-CSE-ConnectionGUID: S4qaCDMmRRehVq1cR3szsg==
X-CSE-MsgGUID: UrKK/LlHRc+R4QHhFmohkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084578"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:43 -0700
X-CSE-ConnectionGUID: fUpJA79PRtCNBLsBAdhEVw==
X-CSE-MsgGUID: EvZ03BNqTc2X7NL2TOeO0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888490"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 16:11:35 -0700
Subject: [PATCH v4 7/7] submodule: look up remotes by URL first
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-jk-submodule-helper-use-url-v4-7-133ef3d89569@gmail.com>
References: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
In-Reply-To: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The get_default_remote_submodule() function performs a lookup to find
the appropriate remote to use within a submodule. The function first
checks to see if it can find the remote for the current branch. If this
fails, it then checks to see if there is exactly one remote. It will use
this, before finally falling back to "origin" as the default.

If a user happens to rename their default remote from origin, either
manually or by setting something like clone.defaultRemoteName, this
fallback will not work.

In such cases, the submodule logic will try to use a non-existent
remote. This usually manifests as a failure to trigger the submodule
update.

The parent project already knows and stores the submodule URL in either
.gitmodules or its .git/config.

Add a new repo_remote_from_url() helper which will iterate over all the
remotes in a repository and return the first remote which has a matching
URL.

Refactor get_default_remote_submodule to find the submodule and get its
URL. If a valid URL exists, first try to obtain a remote using the new
repo_remote_from_url(). Fall back to the repo_default_remote()
otherwise.

The fallback logic is kept in case for some reason the user has manually
changed the URL within the submodule. Additionally, we still try to use
a remote rather than directly passing the URL in the
fetch_in_submodule() logic. This ensures that an update will properly
update the remote refs within the submodule as expected, rather than
just fetching into FETCH_HEAD.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.h                    |  1 +
 builtin/submodule--helper.c | 26 +++++++++++++++++++++++++-
 remote.c                    | 15 +++++++++++++++
 t/t7406-submodule-update.sh | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/remote.h b/remote.h
index 8dc5cfa49ef78808348a84c9b3f416b31cd3bbd7..0ca399e1835bf1829054d8937d95e5625c38d881 100644
--- a/remote.h
+++ b/remote.h
@@ -340,6 +340,7 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit);
 char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 const char *repo_default_remote(struct repository *repo);
+const char *repo_remote_from_url(struct repository *repo, const char *url);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1aa87435c2000e94f43da94c5ef88a307f6f3f4a..84a96d300d9489706fb16280f03aea02f87f1657 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,16 +72,40 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
+	const struct submodule *sub;
 	struct repository subrepo;
+	const char *remote_name = NULL;
+	char *url = NULL;
+
+	sub = submodule_from_path(the_repository, null_oid(the_hash_algo), module_path);
+	if (sub && sub->url) {
+		url = xstrdup(sub->url);
+
+		/* Possibly a url relative to parent */
+		if (starts_with_dot_dot_slash(url) ||
+		    starts_with_dot_slash(url)) {
+			char *oldurl = url;
+
+			url = resolve_relative_url(oldurl, NULL, 1);
+			free(oldurl);
+		}
+	}
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
 				null_oid(the_hash_algo)) < 0)
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
 
-	*default_remote = xstrdup(repo_default_remote(&subrepo));
+	/* Look up by URL first */
+	if (url)
+		remote_name = repo_remote_from_url(&subrepo, url);
+	if (!remote_name)
+		remote_name = repo_default_remote(&subrepo);
+
+	*default_remote = xstrdup(remote_name);
 
 	repo_clear(&subrepo);
+	free(url);
 
 	return 0;
 }
diff --git a/remote.c b/remote.c
index e35cf7ec61ac946d1e84c5a0ae309e63c66d0335..60b4aec3dee3847b3a7b5be0f1acd9a52c60c71d 100644
--- a/remote.c
+++ b/remote.c
@@ -1801,6 +1801,21 @@ const char *repo_default_remote(struct repository *repo)
 	return remotes_remote_for_branch(repo->remote_state, branch, NULL);
 }
 
+const char *repo_remote_from_url(struct repository *repo, const char *url)
+{
+	read_config(repo, 0);
+
+	for (int i = 0; i < repo->remote_state->remotes_nr; i++) {
+		struct remote *remote = repo->remote_state->remotes[i];
+		if (!remote)
+			continue;
+
+		if (remote_has_url(remote, url))
+			return remote->name;
+	}
+	return NULL;
+}
+
 int branch_has_merge_config(struct branch *branch)
 {
 	return branch && branch->set_merge;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 748b529745a5121f121768bb4e0cbc11bc833ea4..c09047b5f441a73a02a9fc4197e9a0ea8f39b529 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1134,6 +1134,38 @@ test_expect_success 'setup clean recursive superproject' '
 	git clone --recurse-submodules top top-clean
 '
 
+test_expect_success 'submodule update with multiple remotes' '
+	test_when_finished "rm -fr top-cloned" &&
+	cp -r top-clean top-cloned &&
+
+	# Create a commit in each repo, starting with bottom
+	test_commit -C bottom multiple_remote_commit &&
+	# Create middle commit
+	git -C middle/bottom fetch &&
+	git -C middle/bottom checkout -f FETCH_HEAD &&
+	git -C middle add bottom &&
+	git -C middle commit -m "multiple_remote_commit" &&
+	# Create top commit
+	git -C top/middle fetch &&
+	git -C top/middle checkout -f FETCH_HEAD &&
+	git -C top add middle &&
+	git -C top commit -m "multiple_remote_commit" &&
+
+	# rename the submodule remote
+	git -C top-cloned/middle remote rename origin upstream &&
+
+	# Add another remote
+	git -C top-cloned/middle remote add other bogus &&
+
+	# Make the update of "middle" a no-op, otherwise we error out
+	# because of its unmerged state
+	test_config -C top-cloned submodule.middle.update !true &&
+	git -C top-cloned submodule update --recursive 2>actual.err &&
+	cat >expect.err <<-\EOF &&
+	EOF
+	test_cmp expect.err actual.err
+'
+
 test_expect_success 'submodule update with renamed remote' '
 	test_when_finished "rm -fr top-cloned" &&
 	cp -r top-clean top-cloned &&

-- 
2.48.1.397.gec9d649cc640

