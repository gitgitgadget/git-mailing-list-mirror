Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F42F2701
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195861; cv=none; b=nEPrXNawhc//rH9LRwqGcGeEbeMjfZ9Zp/906v/qU+dm2TcyLGV2H+j+I0xLr/0Xe2jbdvb+KVRGLM0EkXsjVLarT6f3hdTKotv4oB3+4OMWTxykh0zFu1Njt5Mf/SD3lvU6ONPU4Bvw7trjPsBtFpf4867aRVhDM6t/Z25RoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195861; c=relaxed/simple;
	bh=3P6QOPtdxySR0SviCyU8RY2xbRl0zEtzRk4slmEyxrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ii8uoyt+kdA2X5U6SnjGS+VU0KRT3A4Qg2RkwHGShAW04RWc9lvV1P2TOkhCmZgDqWLwfiM7xJpDO4LI7i1qWV5Qs3HGp/X2+SMlwAsALDNCFKznhSFSrUMyhfXPXNruKZsOXvS9k2REyZ9A5EeGjhq4vj5VZg7hLf57kS+6ovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjfSDpZw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjfSDpZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195859; x=1781731859;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3P6QOPtdxySR0SviCyU8RY2xbRl0zEtzRk4slmEyxrE=;
  b=BjfSDpZwQOPta2X+kZ9DcwafGidcVGX19V9RARrQKE7tjcTFJ8u42mok
   WqtR5rDai8cC+u5mO5cuZtnC8/1ZryyZQe4Ge+DpPBonqrYMo4Hw+FrKS
   ckmtJMAd9Gvm6LKhF/i4MHHT8N7b3ZjF3LUYSECl3xKtXPtelJ0v+FmF0
   XByUcprlKmTzstHvpDGe83k3mlkR5iaNYMPu2GP1fBF3v8tWRogNYFX/h
   aqJ0a5s3KOQHzwR1DJfmfbg89tBAAVcCvlUPGGKu9rKVXCO2YLZ9CL8X3
   1GxnKdjmLAlndOn4woHi94W7EozE/8w4UC/c8CfnmxIAm0slAYk9wEd1J
   Q==;
X-CSE-ConnectionGUID: 9YnTYaFHQ9u8/KCoF0kg3w==
X-CSE-MsgGUID: 1Wu1mYEcTx2l7/6Kbf1Fwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195395"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195395"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
X-CSE-ConnectionGUID: TqriFwyvRXCxjUPsrv4PRw==
X-CSE-MsgGUID: JvmIlVc2RXeEUDO8F3rYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856678"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Jun 2025 14:30:46 -0700
Subject: [PATCH v2 6/6] submodule: look up remotes by URL first
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-jk-submodule-helper-use-url-v2-6-04cbb003177d@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
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
index 672e8e893b8243c09145c340f412aa0eae8d562f..59033d5d82dd81d79174f265c1d501ee5653a6ec 100644
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
index 94b31f4c23057a247a968fc0ebe2e5170e99614d..706c25af0c27aaa9090197e93e87c2a612497172 100644
--- a/remote.c
+++ b/remote.c
@@ -1796,6 +1796,21 @@ const char *repo_default_remote(struct repository *repo)
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
 	return branch && !!branch->merge;
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

