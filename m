Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E2217F24
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592837; cv=none; b=ButJltrQZVQlUHJyf4cLUdRujkFbDY1v8J3rgyEjPlabFxSH6WsyvugQuSBCqy9tlx2oRQxC996jzRvGdbmbOHNJaF6gysEHWwGU9Q96pzTym0pfWcw5lK2LMMNw6xnkG9CtFpuOfsUE46YEiiLdCmz762iy1EYDt/9WPmmOYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592837; c=relaxed/simple;
	bh=D13boIHrSPudjuCYwI86/MT7xYBBeypkNoGoVSfSb1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsnIsecfthsE6KmP/I/+joqRrhKPgc2HbfuY4fAjZonlHN4gxJ96xlb5hiKNCEln4swAYwi5CxtWOmnOKEtm+Llv6yICmhut8Og5mnsaE2oevLdukDR7u5pmaLxrCa73ppTGL137fkPsDRy2XsTPUQNp8wUG7ZnHClSBFOsvPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=sVA81ySQ; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="sVA81ySQ"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760592825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mlyeSbAKvmF+HxKPgpJYqx3Ci73IUA+2I4ZZHuZ7bk=;
	b=sVA81ySQ73P44VAsQE4zPKMaJXrpI5Tn5fD+kM2tX+IztIJiYpqvklrywstQdt1KKILBB3
	+tRT3jm/WUHDasCCu4R9pMU5HHQdNuOaZnu8uuMfyIfKoVcIsqs0mW95iavHim+ITEOAad
	BOzwQ0eOxhr2qAbcR4S2MN1XBrIOCzusI7GIFzAdpVC0cyXuWIhEXwOapxaduQR/V/8ilf
	5tSQs780FKKvKwXgKQG1AtcoIhpHseigmm/FohMBmxFP0SCvvIc20YQ2hw2bzkyDAJGgQb
	U+2bwz7luq51Zp7RkaVlVPzhNtesLwNEl3TAdNWfSgIoTH92o1XRHtdx6j5T9Q==
To: git@lohmann.sh
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/5] setup: rename `die_upon_unsafe_repo()` to align with check
Date: Thu, 16 Oct 2025 07:33:19 +0200
Message-ID: <20251016053322.44495-3-git@lohmann.sh>
In-Reply-To: <20251016053322.44495-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
 <20251016053322.44495-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function dies if the repo in question is deemed to be unsafe and
the ownership is only part of the verification. In addition it already
checks for "safe.directory" config, making the name
`die_upon_dubious_ownership()` not expressive.
When additional options to check if a repository is considered to be
safe are added, this name is more indicative of the content.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
 builtin/clone.c | 2 +-
 path.c          | 4 ++--
 setup.c         | 2 +-
 setup.h         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c990f398ef..08b04f5cf2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -263,7 +263,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	 * operation as the hardlinked files can be rewritten at will by the
 	 * potentially-untrusted user. We thus refuse to do so by default.
 	 */
-	die_upon_dubious_ownership(NULL, NULL, src_repo);
+	die_upon_unsafe_repo(NULL, NULL, src_repo);
 
 	mkdir_if_missing(dest->buf, 0777);
 
diff --git a/path.c b/path.c
index 7f56eaf993..c2ea450304 100644
--- a/path.c
+++ b/path.c
@@ -810,7 +810,7 @@ const char *enter_repo(const char *path, unsigned flags)
 			return NULL;
 		gitfile = read_gitfile(used_path.buf);
 		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
-			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
+			die_upon_unsafe_repo(gitfile, NULL, used_path.buf);
 		if (gitfile) {
 			strbuf_reset(&used_path);
 			strbuf_addstr(&used_path, gitfile);
@@ -822,7 +822,7 @@ const char *enter_repo(const char *path, unsigned flags)
 	else {
 		const char *gitfile = read_gitfile(path);
 		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
-			die_upon_dubious_ownership(gitfile, NULL, path);
+			die_upon_unsafe_repo(gitfile, NULL, path);
 		if (gitfile)
 			path = gitfile;
 		if (chdir(path))
diff --git a/setup.c b/setup.c
index 2c41874774..c6e1204c05 100644
--- a/setup.c
+++ b/setup.c
@@ -1333,7 +1333,7 @@ static int ensure_safe_repository(const char *gitfile,
 	return data.is_safe;
 }
 
-void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
+void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
 				const char *gitdir)
 {
 	struct strbuf report = STRBUF_INIT, quoted = STRBUF_INIT;
diff --git a/setup.h b/setup.h
index 8522fa8575..3f7ef03bf9 100644
--- a/setup.h
+++ b/setup.h
@@ -51,7 +51,7 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
  * config settings; for non-bare repositories, their worktree needs to be
  * added, for bare ones their git directory.
  */
-void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
+void die_upon_unsafe_repo(const char *gitfile, const char *worktree,
 				const char *gitdir);
 
 void setup_work_tree(void);
-- 
2.51.1.476.g147428281d

