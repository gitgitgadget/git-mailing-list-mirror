Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2A2F0C4C
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195859; cv=none; b=MfkpbNyAMjUvZCQGedLzevT4KwYJ88mUbTkH7S7wZCTk17Aw7AHc08MsjZ0NgjcWtgwaliRXEuGPOqzN4qW+fKHccxZS3DA3uc+buTjWWWaaU6lW4EdkB9T0zpN2fnL4UNGSL2pfBrNlF/PA2GdE3BVdMk3HJswaNAKU9tbxxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195859; c=relaxed/simple;
	bh=n1vQmI4mNad3FRf6tQkCZssIBl5zAkGcyWfg/zKpwLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJ0lEBagkd/2xLuUk4Y7Z9xnmEdFloX+scHNO4NME0mBikkhPUmHDBwKY4HAnL1RUSnD27gcElwYxYKByCw82tqUcenh9ElwF+XFpoCcS8HOpnpWIvrn0138dyINBBuPnXtAwREt5IY8QnSL0Ngpo949mnxojv8f6FAn0WzDeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuFQuFqg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuFQuFqg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750195857; x=1781731857;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=n1vQmI4mNad3FRf6tQkCZssIBl5zAkGcyWfg/zKpwLQ=;
  b=LuFQuFqgL/78FzB8V/rHerHyzG2m8Jl/eneXu+3SR3nr0v4PGK84luzc
   3sUMmmPLLAUFDi8SK1CZHZRlDgXxkcNPCMHmL1+IEZGulcLNKUJ0ERphp
   Wx7enFB4OmFiNT9aON757P/v29O1hR4yRJ5AsruAaex8zJf1jNAW1mKNk
   JGflFhUmqay5rw7zKquqqFsYvJ3Xw4btjghpttZdICWZO8wfACsIW0Z5J
   4z/qHqSRS6LSbfhwZsNqho/5OuwVyu+J4zXpegfpIiSKyu34mR8o0H1Bc
   XDJKN6oeBTYnbeyfbWYhXOLihx8pY33Ty59qsY4kOb9zm1HcL1p8cvUDq
   w==;
X-CSE-ConnectionGUID: 4z+5LvPCRauLHwU/rXMJhQ==
X-CSE-MsgGUID: B8ZdGXVlSZmsFbMaMCrgDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56195383"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="56195383"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:52 -0700
X-CSE-ConnectionGUID: SMmPRNzLTrK7gfgIobiyeg==
X-CSE-MsgGUID: bKo438MESTCp4hXlW0WxVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="153856675"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 14:30:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Jun 2025 14:30:43 -0700
Subject: [PATCH v2 3/6] remote: remove the_repository from some functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-jk-submodule-helper-use-url-v2-3-04cbb003177d@gmail.com>
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
In-Reply-To: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
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
index 538d0d24c832ffeb1cc14684eb166c62c42d719d..b3a9881a6eacf90bee71d6760858b37d68263502 100644
--- a/remote.c
+++ b/remote.c
@@ -327,11 +327,10 @@ static void warn_about_deprecated_remote_type(const char *type,
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
@@ -347,7 +346,7 @@ static void read_remotes_file(struct remote_state *remote_state,
 		strbuf_rtrim(&buf);
 
 		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote_state, remote,
+			add_url_alias(repo->remote_state, remote,
 				      skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
@@ -360,12 +359,11 @@ static void read_remotes_file(struct remote_state *remote_state,
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
@@ -392,9 +390,9 @@ static void read_branches_file(struct remote_state *remote_state,
 	if (frag)
 		*(frag++) = '\0';
 	else
-		frag = to_free = repo_default_branch_name(the_repository, 0);
+		frag = to_free = repo_default_branch_name(repo, 0);
 
-	add_url_alias(remote_state, remote, buf.buf);
+	add_url_alias(repo->remote_state, remote, buf.buf);
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -691,7 +689,7 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 					     branch, explicit);
 }
 
-static struct remote *remotes_remote_get(struct remote_state *remote_state,
+static struct remote *remotes_remote_get(struct repository *repo,
 					 const char *name);
 
 char *remote_ref_for_branch(struct branch *branch, int for_push)
@@ -710,7 +708,7 @@ char *remote_ref_for_branch(struct branch *branch, int for_push)
 					the_repository->remote_state, branch,
 					NULL);
 			struct remote *remote = remotes_remote_get(
-				the_repository->remote_state, remote_name);
+				the_repository, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -767,10 +765,11 @@ static void validate_remote_url(struct remote *remote)
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
 
@@ -784,9 +783,9 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
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
@@ -800,35 +799,33 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
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
@@ -1732,7 +1729,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	}
 }
 
-static void set_merge(struct remote_state *remote_state, struct branch *ret)
+static void set_merge(struct repository *repo, struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
@@ -1752,7 +1749,7 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 		return;
 	}
 
-	remote = remotes_remote_get(remote_state, ret->remote_name);
+	remote = remotes_remote_get(repo, ret->remote_name);
 
 	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i = 0; i < ret->merge_nr; i++) {
@@ -1761,7 +1758,7 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (repo_dwim_ref(the_repository, ret->merge_name[i],
+		if (repo_dwim_ref(repo, ret->merge_name[i],
 				  strlen(ret->merge_name[i]), &oid, &ref,
 				  0) == 1)
 			ret->merge[i]->dst = ref;
@@ -1780,7 +1777,7 @@ struct branch *branch_get(const char *name)
 	else
 		ret = make_branch(the_repository->remote_state, name,
 				  strlen(name));
-	set_merge(the_repository->remote_state, ret);
+	set_merge(the_repository, ret);
 	return ret;
 }
 
@@ -1851,13 +1848,14 @@ static const char *tracking_for_push_dest(struct remote *remote,
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
@@ -1924,7 +1922,7 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 	if (!branch->push_tracking_ref)
 		branch->push_tracking_ref = branch_get_push_1(
-			the_repository->remote_state, branch, err);
+			the_repository, branch, err);
 	return branch->push_tracking_ref;
 }
 

-- 
2.48.1.397.gec9d649cc640

