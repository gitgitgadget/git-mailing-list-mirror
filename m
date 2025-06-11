Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E982899
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603152; cv=none; b=i4GoPdYkL+YJ4FyrQJFYfPzwZakY7LA2ZcJHDuby805f/njDyaFzVZzici0MmKhvJ0mEdol4bL35wHjbJROv2qta4MgmoRi+tfwqB1FCDY3Rc6TDkDk3/9WNfH78dbVKqpHEQbcwV9lhzr1pdNvvD9dWR5hJYz7HINA7f8pKoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603152; c=relaxed/simple;
	bh=tvLmFkl2TsbY7cnsQ3BuHI49Sv4MIU7V2TCny8EDE+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaMO3+ZVxwZ3ZKpjzBQzxCXsYpFQuijRVD/4LZy+P/IbHqMvcpjliyZ6HN/a3fZIhW90TGJqf7rMDYgVZdyrW06LktxxWdlEd+CxxnXo8zJjM2QakmTJZEu2X/yFmn2+5dTnsk8e5j17iZnyO/wUlIcGOTRM2vH6Uv9KX2l8VO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dP8iloap; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dP8iloap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603151; x=1781139151;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tvLmFkl2TsbY7cnsQ3BuHI49Sv4MIU7V2TCny8EDE+4=;
  b=dP8iloapqft9mIq8nqbQgog7pxCh9rGufY6tV7A+4jz+WBsX71FpB5lo
   937ggqUGHUoQkEi8kqucKvahcQR0aAcpVIcsK7h0mYPXgbHY0S5pxvjGK
   CCaaIUtiOQcBzFdJjxldV3ObN4JwRamVP1FhuRZmNUzh+WyY81TGxtn7J
   sqYQy1sTewLxUOtct7K0vVKjcFfjIhmHlSvqHQazhSqActV34McF33UXk
   rC0EGfUryMKPRgUU7krMEdzsRIVy/fvjTNpSpEDRLdcWGUWG2TmMDqMei
   EbnUnHMKHcxnvabc1mcVoTvl31DSdOti1JObJNSwXP/7JzyRTxnBtShfm
   Q==;
X-CSE-ConnectionGUID: 77nzOIycSX2XbuZCG3Sfvw==
X-CSE-MsgGUID: e7zW7+h1QI2beJriHMmKCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012596"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012596"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:27 -0700
X-CSE-ConnectionGUID: 76dc3IPyToOu5+q+qGY9Tg==
X-CSE-MsgGUID: t1Opt91wRsqZKQHvaw8q9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199749"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Jun 2025 17:52:20 -0700
Subject: [PATCH 6/6] submodule: look up remotes by URL first
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-jk-submodule-helper-use-url-v1-6-6d14c1504e91@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
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

Refactor repo_get_default_remote to take an optional url parameter. If
its set, first attempt to use repo_remote_from_url(), before attempting
to use the existing logic.

Refactor get_default_remote_submodule to find the submodule and get its
URL. If a valid URL exists, then pass this to repo_get_default_remote,
ensuring that we prioritize using a remote with the matching URL if it
exists.

The fallback logic is kept in case for some reason the user has manually
changed the URL within the submodule. Additionally, we still try to use
a remote rather than directly passing the URL in the
fetch_in_submodule() logic. This ensures that an update will properly
update the remote refs within the submodule as expected, rather than
just fetching into FETCH_HEAD.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.h                    |  1 +
 builtin/submodule--helper.c | 43 ++++++++++++++++++++++++++++++++++++-------
 remote.c                    | 15 +++++++++++++++
 t/t7406-submodule-update.sh | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/remote.h b/remote.h
index ef0de4aa64e9ccd32cc2eea076c00386dcba1161..8b8ece50b1cd684969fbb8a9d695fb3002a3f3f5 100644
--- a/remote.h
+++ b/remote.h
@@ -339,6 +339,7 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit);
 char *remote_ref_for_branch(struct branch *branch, int for_push);
 
 const char *repo_default_remote(struct repository *repo);
+const char *repo_remote_from_url(struct repository *repo, const char *url);
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5542b403217b979d6da92c79d89d0991e980f692..432fe5d14f78756b64cf1770c174ce49bc2978f9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -41,15 +41,25 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static int repo_get_default_remote(struct repository *repo, char **default_remote)
+static int repo_get_default_remote(struct repository *repo,
+				   const char *url,
+				   char **default_remote)
 {
-	struct ref_store *store = get_main_ref_store(repo);
-	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
-						      NULL);
+	struct ref_store *store;
+	const char *refname;
 
+	if (url) {
+		const char *remote_name = repo_remote_from_url(repo, url);
+		if (remote_name) {
+			*default_remote = xstrdup(remote_name);
+			return 0;
+		}
+	}
+
+	store = get_main_ref_store(repo);
+	refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL, NULL);
 	if (!refname)
 		return die_message(_("No such ref: %s"), "HEAD");
-
 	if (strcmp(refname, "HEAD") &&
 	    !skip_prefix(refname, "refs/heads/", &refname))
 		return die_message(_("Expecting a full ref name, got %s"),
@@ -63,7 +73,7 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 static char *get_default_remote(void)
 {
 	char *default_remote;
-	int code = repo_get_default_remote(the_repository, &default_remote);
+	int code = repo_get_default_remote(the_repository, NULL, &default_remote);
 
 	if (code)
 		exit(code);
@@ -97,16 +107,35 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
+	const struct submodule *sub;
 	struct repository subrepo;
+	char *url = NULL;
 	int ret;
 
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
+
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
 				null_oid(the_hash_algo)) < 0)
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
-	ret = repo_get_default_remote(&subrepo, default_remote);
+	ret = repo_get_default_remote(&subrepo, url, default_remote);
 	repo_clear(&subrepo);
 
+	if (url)
+		free(url);
+
 	return ret;
 }
 
diff --git a/remote.c b/remote.c
index fcda185ecfab5102afbe8918fed65c74971ef8c2..bf2ebfcf06a87ddf1fecadc3e408427d0a83c479 100644
--- a/remote.c
+++ b/remote.c
@@ -1788,6 +1788,21 @@ const char *repo_default_remote(struct repository *repo)
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

