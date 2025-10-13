Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5B2FA0F2
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391996; cv=none; b=SNeIaNMAmsfYMVWTVKQqdA0/9nCaLegfJfNgs6FbzPc6VjyUZGkayHaa319W1T/I3MoKoxvvQhe2osffPlr2vHqzap0+8OnJviA7kUxu3p4vhLMSStmE9jw+SttGv1kbQC3mCDchrgbGrDMqjqs6Sb3gcDghJCSVdN+RZ9s3464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391996; c=relaxed/simple;
	bh=4x1MOOtdmz7RMWpJUjGCVR3L2asPj04Yx57TqVoEV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NywEpt25Sm6HlRLOIP5oPFpILIFrjKce4ev2QrVbMAp9bEAymAWcPOTJMZpmGFQr6QAk9+6hdM9nut59tSP5pysaTEudf7SD+Tbygeu9PvkD3fK3KUlgCL1ckgF4sIj839ZCg8j9LhsmBdzCLInsfuDS1LoJD/GLdOmf5vX9A3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=XMT3my0K; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="XMT3my0K"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760391988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funmwQTeUahxi1dqvTV3DT4al8or7TiVy0XncOmMLaY=;
	b=XMT3my0KdxryaKcFVMWkvin106mf8nEm8t0VNGKD/FNet4jDgf4eaua8WprZzwDMMPJbxi
	L1q1+4pKHL8HGwhW8QYergCXKa16pCM+VgUxcrZdN5EjG+9WdRJUpBwny/fjEYgdDxeUF/
	MVQsMmR2gQwpKnv03hALnnNohxG1DIK1XdOd2UVjhoLIIBPZNMJq2AMxbl6vaI1mZcDdgH
	QiouhK8XfINxCqvj7E0M1jrRRanvU/8QoMzLMw097t0FzOBS6uHCJOMWuv++8q2rhrVfsc
	vHpmrO5VVHkzJ1UbYYONmc4756VbFiWMMgvBSfTwF9mNM4/ILSOxSf1BEpUEEg==
To: ben.knoble@gmail.com
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: [PATCH v2 1/5] setup: rename `ensure_safe_repository()` for clarity
Date: Mon, 13 Oct 2025 23:46:04 +0200
Message-ID: <20251013214608.33581-2-git@lohmann.sh>
In-Reply-To: <20251013214608.33581-1-git@lohmann.sh>
References: <CALnO6CBLr2iL0r+ywM4Vjw0=J2DNFv9Nhhq_PHuxt4eK=Z95ww@mail.gmail.com>
 <20251013214608.33581-1-git@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to ownership it checks for "safe.directory" config, making
the name `ensure_valid_ownership()` not expressive. This function
ensures that a repository is considered to be safe.
When additional options to check if a repository is considered to be
safe are added, this name is more indicative of the content.

Signed-off-by: Michael Lohmann <git@lohmann.sh>
---
 setup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 7086741e6c..2c41874774 100644
--- a/setup.c
+++ b/setup.c
@@ -1301,7 +1301,7 @@ static int safe_directory_cb(const char *key, const char *value,
  * config settings; for non-bare repositories, their worktree needs to be
  * added, for bare ones their git directory.
  */
-static int ensure_valid_ownership(const char *gitfile,
+static int ensure_safe_repository(const char *gitfile,
 				  const char *worktree, const char *gitdir,
 				  struct strbuf *report)
 {
@@ -1339,7 +1339,7 @@ void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
 	struct strbuf report = STRBUF_INIT, quoted = STRBUF_INIT;
 	const char *path;
 
-	if (ensure_valid_ownership(gitfile, worktree, gitdir, &report))
+	if (ensure_safe_repository(gitfile, worktree, gitdir, &report))
 		return;
 
 	strbuf_complete(&report, '\n');
@@ -1526,7 +1526,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 			const char *gitdir_candidate =
 				gitdir_path ? gitdir_path : gitdirenv;
 
-			if (ensure_valid_ownership(gitfile, dir->buf,
+			if (ensure_safe_repository(gitfile, dir->buf,
 						   gitdir_candidate, report)) {
 				strbuf_addstr(gitdir, gitdirenv);
 				ret = GIT_DIR_DISCOVERED;
@@ -1554,7 +1554,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT &&
 			    !is_implicit_bare_repo(dir->buf))
 				return GIT_DIR_DISALLOWED_BARE;
-			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
+			if (!ensure_safe_repository(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
 			return GIT_DIR_BARE;
-- 
2.50.1 (Apple Git-155)

