Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBC2820CD
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288117; cv=none; b=GwdFA2GhYDluuZQJW7VCBaOfq/aXAUAmHXaUKZjCUH3/Ab4/S4BS8FNwnYA3W6F9G77BlgoQ2dOu22YZrae6De1gsJlKNTr5m2xu6C6fEm9DrEkr2Yelxu2Tk/DDTFpsFPFnXWr24hUe9hx1bcDiRUq7j957wdj6S33eJrj78Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288117; c=relaxed/simple;
	bh=so9AY4KaUAxFh1Zohxae4J6XFkavP5xeilWPr2jHoys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuSrRScJYOxxmP8b8r5HGIJnpRRBaBRTFNW53JRhoV5HDosuYZphdHLl20AyYURCDbRZdPKN+IBDmab/AIPAUPY8hM8al2swgWIOMzWQ0Tr/qDSLJijUPpxOyETqTXPmiJo/QXXItdP+tfI94H1aMN4po8E248TjmfUJDa1hhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKfn39wT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKfn39wT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288116; x=1781824116;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=so9AY4KaUAxFh1Zohxae4J6XFkavP5xeilWPr2jHoys=;
  b=EKfn39wT+6shIORkiVE2OQY+IedUiOzZmhJR2KO+OnMBsz4nZZFG3AgX
   pHJSXgLasnZ2tdn8803MtRMtGcmv0v0TgKRFDk2q/CHQdIXVxipPI/EWg
   Db2zhyt2s1elgNqXLBf8li44cIgi0GR01+Cs8yzquxqPiuO3ROExaffMU
   Xv97k0Hx9eXrg862pYjg9hxYr7tkLuRvzh2DUmfspmrXQxsKquGHy4Q+X
   QbpXON3YIT5UM28zU3mLv9VU4r8EGmuxxOB4s/QRyhOYRZAaNVrkfHR2b
   1w9ReQt+5vUzqJ2fiYQmA2EXUTEaKq+9s/Gb5ylQzV4p5fHKaSUusgQbw
   w==;
X-CSE-ConnectionGUID: T7XolD/STfmo62lZmJmk1w==
X-CSE-MsgGUID: T4c6iECxSZyDzfTRs0ULNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69966816"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="69966816"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:31 -0700
X-CSE-ConnectionGUID: Tf+bsAbiSPycmhFnTnvssg==
X-CSE-MsgGUID: +kQnyqYLTmmd35eYEABPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="156048564"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 16:08:18 -0700
Subject: [PATCH v3 4/7] remote: remove the_repository from some functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-jk-submodule-helper-use-url-v3-4-7c60f2679271@gmail.com>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
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
index e6f0721060a1ad6b119e5e45545c8c6ca94658af..f872fa5cf76ea3588079ddd84fe2c6dcd94c8dcd 100644
--- a/remote.c
+++ b/remote.c
@@ -334,11 +334,10 @@ static void warn_about_deprecated_remote_type(const char *type,
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
@@ -354,7 +353,7 @@ static void read_remotes_file(struct remote_state *remote_state,
 		strbuf_rtrim(&buf);
 
 		if (skip_prefix(buf.buf, "URL:", &v))
-			add_url_alias(remote_state, remote,
+			add_url_alias(repo->remote_state, remote,
 				      skip_spaces(v));
 		else if (skip_prefix(buf.buf, "Push:", &v))
 			refspec_append(&remote->push, skip_spaces(v));
@@ -367,12 +366,11 @@ static void read_remotes_file(struct remote_state *remote_state,
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
@@ -399,9 +397,9 @@ static void read_branches_file(struct remote_state *remote_state,
 	if (frag)
 		*(frag++) = '\0';
 	else
-		frag = to_free = repo_default_branch_name(the_repository, 0);
+		frag = to_free = repo_default_branch_name(repo, 0);
 
-	add_url_alias(remote_state, remote, buf.buf);
+	add_url_alias(repo->remote_state, remote, buf.buf);
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
 			frag, remote->name);
 
@@ -698,7 +696,7 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 					     branch, explicit);
 }
 
-static struct remote *remotes_remote_get(struct remote_state *remote_state,
+static struct remote *remotes_remote_get(struct repository *repo,
 					 const char *name);
 
 char *remote_ref_for_branch(struct branch *branch, int for_push)
@@ -717,7 +715,7 @@ char *remote_ref_for_branch(struct branch *branch, int for_push)
 					the_repository->remote_state, branch,
 					NULL);
 			struct remote *remote = remotes_remote_get(
-				the_repository->remote_state, remote_name);
+				the_repository, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -774,10 +772,11 @@ static void validate_remote_url(struct remote *remote)
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
 
@@ -791,9 +790,9 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
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
@@ -807,35 +806,33 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
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
@@ -1739,7 +1736,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	}
 }
 
-static void set_merge(struct remote_state *remote_state, struct branch *ret)
+static void set_merge(struct repository *repo, struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
@@ -1760,13 +1757,13 @@ static void set_merge(struct remote_state *remote_state, struct branch *ret)
 	}
 	ret->set_merge = 1;
 
-	remote = remotes_remote_get(remote_state, ret->remote_name);
+	remote = remotes_remote_get(repo, ret->remote_name);
 
 	for (i = 0; i < ret->merge_nr; i++) {
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (repo_dwim_ref(the_repository, ret->merge[i]->src,
+		if (repo_dwim_ref(repo, ret->merge[i]->src,
 				  strlen(ret->merge[i]->src), &oid, &ref,
 				  0) == 1)
 			ret->merge[i]->dst = ref;
@@ -1785,7 +1782,7 @@ struct branch *branch_get(const char *name)
 	else
 		ret = make_branch(the_repository->remote_state, name,
 				  strlen(name));
-	set_merge(the_repository->remote_state, ret);
+	set_merge(the_repository, ret);
 	return ret;
 }
 
@@ -1856,13 +1853,14 @@ static const char *tracking_for_push_dest(struct remote *remote,
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
@@ -1929,7 +1927,7 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 	if (!branch->push_tracking_ref)
 		branch->push_tracking_ref = branch_get_push_1(
-			the_repository->remote_state, branch, err);
+			the_repository, branch, err);
 	return branch->push_tracking_ref;
 }
 

-- 
2.48.1.397.gec9d649cc640

