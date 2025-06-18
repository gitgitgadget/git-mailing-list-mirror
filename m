Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8F28506D
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288119; cv=none; b=U7Fkvkwg2VHsqKRiSuhy+WtYdhUhQzdBiMzhizxEkFWCZuIis4wkPO0Db8ZlWbvPMbU7FjW57aaWnuOe0C5tbqRQM9ywu7igM4THd5ae35CFnS3Ml3SX7wIiL16Y2NTqq6gE1txMaEscOg1r1vNKUWclsb94S88NOhjwjtNaHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288119; c=relaxed/simple;
	bh=e7UBZCzcNAhJyC/IyCjnaF044IMv4+xNjOuI3+YU8kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxEQnNbdeheTNlaSHdWi6qILRCpGfVxzYA+lzvlB90NFgb9W5qu6qTcAVbcsvgd5eqUWInb3ZN62x0FF/u+n0JUVFoP5aG8aT1GgECinuSlNgN4vPF7An/sPtjt9BUX4K4em1MVy5fIHf+wN7R5eU2t4AuI6I6YzTZJTVwN3mgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7T1KeRl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7T1KeRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288118; x=1781824118;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e7UBZCzcNAhJyC/IyCjnaF044IMv4+xNjOuI3+YU8kM=;
  b=U7T1KeRlXJiUoW4I/cVsT0Y0fy7txgVUAfLBDdh44RajsISijb5aQ2xy
   DckwppGWjLChm+XT/RBgtFBfpWLfo8I3x7vlBvsB3ZEYGdsNNPYJXWxZj
   c/aDVhUdLff4a6HEfgdw0jbYAtRcd6nxxlrUzmEiJGzlo2uX0gPIYNo2c
   yCimHJ3zVy+gFfOsH+t3qK1JEFPPUastKzqqRO04VV8TRjpe3xN+1WLyJ
   pvdKXrbGYZrmKe1Q7k/GYu6S3+8/hW7oN4tFezU94iSMvss5wd0jP0Cax
   5RnLbohPppBkMwCR+DQ64mUlKIwusISEwSTc4jmckcXh4dT9m4ZAc1ik2
   g==;
X-CSE-ConnectionGUID: e42kOKevTyyAup6+q/samg==
X-CSE-MsgGUID: j3KHjvcYTcCnPXzuevLlhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69966828"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="69966828"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
X-CSE-ConnectionGUID: 4Q42xg+mTH+i9lm+SvyU3w==
X-CSE-MsgGUID: r0/gMvmCRCShw4nl3Fj+yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="156048568"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 16:08:21 -0700
Subject: [PATCH v3 7/7] submodule: look up remotes by URL first
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-jk-submodule-helper-use-url-v3-7-7c60f2679271@gmail.com>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
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
index 6db3db3cbfc2bb56cc477feaa34952e3f370e0f5..1850e8fa4e427f3902ce0dbbc643a653da061716 100644
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

