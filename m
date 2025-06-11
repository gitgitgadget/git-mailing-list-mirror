Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0D2AD2C
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603150; cv=none; b=hWkEh6+mLW/9VGXC/KlV0ApGoT1u1Z8SgDfOjKq8aN+d5LTUwsb6hJeeV42xafYtFFzdnautiNY0qBgv0VftjlUj9HCfpKw2A+cInuWBLG4YUEqQ+vIz3cEF9fm/VeibeEPoYu3xfUIKBfvebojHZjo+EuO/4Wm+qexTz0lIDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603150; c=relaxed/simple;
	bh=KIqVAb83EadSh7waL+8LGJnAVhxL9woTyJHdfkegF/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8XhrGnJEDYTFTpCd3o+kkwxvXDHbJtfJc7zSE8cNwob5CJqXXiiCpQKOV6bJMX9jSY4DHUJooXduN8sGPiOPkZuKhiLFLFNUz6AK+8VtCeMOhokEDi+G22ZgMP8lHUzVFse/R9YU/PESm/rk118EPNrjjTw6ytwGeCZzl+M3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgIuYIKA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgIuYIKA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749603149; x=1781139149;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KIqVAb83EadSh7waL+8LGJnAVhxL9woTyJHdfkegF/o=;
  b=QgIuYIKAx3bvoG2/c0ung9j0XZ8dXgRIlNkO46914Zk9YxUuihTmHZeH
   Za85RCLKF8y/goEwci59iLxi6G9oS/rH+luc2fhC4sTRHG5aibwXLw4lc
   6BENpGAuAcbVCX7vkAwu2MbhHolk2XL1hdvUctt2XYxP3xQY8cf/nDSk+
   4QWnDHZXc86ghF4lZcO/XwvAfSHlRIwOsn0alOPY6nAOUf4bJLw8nstov
   J2FZJIUJjwUk+cMIkxBNKIdmtbcudLVG2WP2pMyxhYfV3DC6ZbjJT43pF
   3i9hTJMaYrOmL6pTElzSf1tB6EECQpa4uFz9iVAx5CHoOGyue3ZJHZg9e
   w==;
X-CSE-ConnectionGUID: IwOVx2kYRVWQtUfMYWlIuw==
X-CSE-MsgGUID: CsjInY6eTRWCKuLlXiXvvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62012583"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62012583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:26 -0700
X-CSE-ConnectionGUID: tZkktnD7Rd6FwQ/+OrZYuA==
X-CSE-MsgGUID: vqAQDGGAQoiwuVBDrF1+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="170199736"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 17:52:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Jun 2025 17:52:16 -0700
Subject: [PATCH 2/6] remote: remove the_repository from some functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-jk-submodule-helper-use-url-v1-2-6d14c1504e91@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The remotes_remote_get_1 (and its caller, remotes_remote_get, have an
implicit dependency on the_repository due to calling
read_branches_file() and read_remotes_file(), both of which use
the_repository. The branch_get() function calls set_merge() which has an
implicit dependency on the_repository as well.

Because of this use of the_repository, the helper functions cannot be
used in code paths which operate on other repositories. A future
refactor of the submodule--helper will want to make use of some of these
functions.

Refactor to break the dependency by passing struct repository *repo
instead of struct remote_state *remote_state in a few places.

The public callers and many other helper functions still depend on
the_repository. A repo-aware function will be exposed in a following
change for git submodule--helper.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.c | 58 ++++++++++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/remote.c b/remote.c
index 4099183cacdc8a607a8b5eaec86e456b2ef46b48..7092b12209d93e20ce1ed3b7d9e4cbac058c57ff 100644
--- a/remote.c
+++ b/remote.c
@@ -317,11 +317,10 @@ static void warn_about_deprecated_remote_type(const char *type,
 		type, remote->name, remote->name, remote->name);
 }
 
-static void read_remotes_file(struct remote_state *remote_state,
-			      struct remote *remote)
+static void read_remotes_file(struct repository *repo, struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *f = fopen_or_warn(repo_git_path_append(repo, &buf,
 						     "remotes/%s", remote->name), "r");
 
 	if (!f)
@@ -337,7 +336,7 @@ static void read_remotes_file(struct remote_state *remote_state,
 		strbuf_rtrim(&buf);
 
 		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote_state, remote,
+			add_url_alias(repo->remote_state, remote,
 				      skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
@@ -350,12 +349,11 @@ static void read_remotes_file(struct remote_state *remote_state,
 	strbuf_release(&buf);
 }
 
-static void read_branches_file(struct remote_state *remote_state,
-			       struct remote *remote)
+static void read_branches_file(struct repository *repo, struct remote *remote)
 {
 	char *frag, *to_free = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *f = fopen_or_warn(repo_git_path_append(repo, &buf,
 						     "branches/%s", remote->name), "r");
 
 	if (!f)
@@ -382,9 +380,9 @@ static void read_branches_file(struct remote_state *remote_state,
 	if (frag)
 		*(frag++) = '\0';
 	else
-		frag = to_free = repo_default_branch_name(the_repository, 0);
+		frag = to_free = repo_default_branch_name(repo, 0);
 
-	add_url_alias(remote_state, remote, buf.buf);
+	add_url_alias(repo->remote_state, remote, buf.buf);
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -681,7 +679,7 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 					     branch, explicit);
 }
 
-static struct remote *remotes_remote_get(struct remote_state *remote_state,
+static struct remote *remotes_remote_get(struct repository *repo,
 					 const char *name);
 
 char *remote_ref_for_branch(struct branch *branch, int for_push)
@@ -700,7 +698,7 @@ char *remote_ref_for_branch(struct branch *branch, int for_push)
 					the_repository->remote_state, branch,
 					NULL);
 			struct remote *remote = remotes_remote_get(
-				the_repository->remote_state, remote_name);
+				the_repository, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -757,10 +755,11 @@ static void validate_remote_url(struct remote *remote)
 }
 
 static struct remote *
-remotes_remote_get_1(struct remote_state *remote_state, const char *name,
+remotes_remote_get_1(struct repository *repo, const char *name,
 		     const char *(*get_default)(struct remote_state *,
 						struct branch *, int *))
 {
+	struct remote_state *remote_state = repo->remote_state;
 	struct remote *ret;
 	int name_given = 0;
 
@@ -774,9 +773,9 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 #ifndef WITH_BREAKING_CHANGES
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
-			read_remotes_file(remote_state, ret);
+			read_remotes_file(repo, ret);
 		if (!valid_remote(ret))
-			read_branches_file(remote_state, ret);
+			read_branches_file(repo, ret);
 	}
 #endif /* WITH_BREAKING_CHANGES */
 	if (name_given && !valid_remote(ret))
@@ -790,35 +789,33 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 }
 
 static inline struct remote *
-remotes_remote_get(struct remote_state *remote_state, const char *name)
+remotes_remote_get(struct repository *repo, const char *name)
 {
-	return remotes_remote_get_1(remote_state, name,
-				    remotes_remote_for_branch);
+	return remotes_remote_get_1(repo, name, remotes_remote_for_branch);
 }
 
 struct remote *remote_get(const char *name)
 {
 	read_config(the_repository, 0);
-	return remotes_remote_get(the_repository->remote_state, name);
+	return remotes_remote_get(the_repository, name);
 }
 
 struct remote *remote_get_early(const char *name)
 {
 	read_config(the_repository, 1);
-	return remotes_remote_get(the_repository->remote_state, name);
+	return remotes_remote_get(the_repository, name);
 }
 
 static inline struct remote *
-remotes_pushremote_get(struct remote_state *remote_state, const char *name)
+remotes_pushremote_get(struct repository *repo, const char *name)
 {
-	return remotes_remote_get_1(remote_state, name,
-				    remotes_pushremote_for_branch);
+	return remotes_remote_get_1(repo, name, remotes_pushremote_for_branch);
 }
 
 struct remote *pushremote_get(const char *name)
 {
 	read_config(the_repository, 0);
-	return remotes_pushremote_get(the_repository->remote_state, name);
+	return remotes_pushremote_get(the_repository, name);
 }
 
 int remote_is_configured(struct remote *remote, int in_repo)
@@ -1722,7 +1719,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	}
 }
 
-static void set_merge(struct remote_state *remote_state, struct branch *ret)
+static void set_merge(struct repository *repo, struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
@@ -1742,7 +1739,7 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 		return;
 	}
 
-	remote = remotes_remote_get(remote_state, ret->remote_name);
+	remote = remotes_remote_get(repo, ret->remote_name);
 
 	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i = 0; i < ret->merge_nr; i++) {
@@ -1751,7 +1748,7 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (repo_dwim_ref(the_repository, ret->merge_name[i],
+		if (repo_dwim_ref(repo, ret->merge_name[i],
 				  strlen(ret->merge_name[i]), &oid, &ref,
 				  0) == 1)
 			ret->merge[i]->dst = ref;
@@ -1770,7 +1767,7 @@ struct branch *branch_get(const char *name)
 	else
 		ret = make_branch(the_repository->remote_state, name,
 				  strlen(name));
-	set_merge(the_repository->remote_state, ret);
+	set_merge(the_repository, ret);
 	return ret;
 }
 
@@ -1841,13 +1838,14 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
-static const char *branch_get_push_1(struct remote_state *remote_state,
+static const char *branch_get_push_1(struct repository *repo,
 				     struct branch *branch, struct strbuf *err)
 {
+	struct remote_state *remote_state = repo->remote_state;
 	struct remote *remote;
 
 	remote = remotes_remote_get(
-		remote_state,
+		repo,
 		remotes_pushremote_for_branch(remote_state, branch, NULL));
 	if (!remote)
 		return error_buf(err,
@@ -1914,7 +1912,7 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 	if (!branch->push_tracking_ref)
 		branch->push_tracking_ref = branch_get_push_1(
-			the_repository->remote_state, branch, err);
+			the_repository, branch, err);
 	return branch->push_tracking_ref;
 }
 

-- 
2.48.1.397.gec9d649cc640

