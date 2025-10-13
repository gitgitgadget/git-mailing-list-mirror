Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E82FE045
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348561; cv=none; b=QlUJ7lcne+3CNDPXre3Q0e0YiSRj3FbeA4S2QxcBBfSUQ3yaQyuO1chasYgTF3KSeUwMUbEK1z1q2gKTpJw/VMqkY799pH6tSfg1qrElDIUTWQKrcT3CgU/qqZitl4d6M0b/J3F/gNSqCA2F8mUR8uG3w5R/iRMRt4418BGG8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348561; c=relaxed/simple;
	bh=4x1MOOtdmz7RMWpJUjGCVR3L2asPj04Yx57TqVoEV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF/JBwXNRi+Rd1wrY6TRwMQ8X1293GB+djDFibe6hpVR/FBzv7j7vIVyMT4Ig7uK+kACn2/zLiRFRjgOrVp4OiN/DQkgd520QNVkVY5ushxHEh4XjiY82W9H79S/783EmHXzvne+IUwf+ErQODDmvLKHPG7xN8bO36Tts27hJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=KD4FV6Um; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="KD4FV6Um"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760348557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=funmwQTeUahxi1dqvTV3DT4al8or7TiVy0XncOmMLaY=;
	b=KD4FV6Um7zbKv0DkDRfAoHeZ0i4p0yjN4AHj86eJLkB2eJJqT7VZ/CFVyi8cxtO3slouMU
	eqVlm1WHxwlA8x1LThq7bEGwbi3VaX3rpTt+Y5ytWjWyE8iNF3tXTaP5DuUFwCfRYKqetn
	kqDHmiS/Dkdfl3J+R7MU5A9wBzmEkjQE580q1g58TkULOcWj0K1Kj+9pttnV5TuwTtmylC
	t3XQyVTUYO+3hQntU9kiKiVnCDCJCkUW+HA3i3YKyXG+gnliIcbp6r1Iui+buE4M3sb/Ni
	UZR6D4k1wrSYMVrZ5ZFt1/w/QEn1sM1t/Ie/7o0IqYJmknDNo1ST/MeCk26fPA==
To: git@vger.kernel.org
Cc: Michael Lohmann <git@lohmann.sh>
Subject: [PATCH 1/5] setup: rename `ensure_safe_repository()` for clarity
Date: Mon, 13 Oct 2025 11:41:42 +0200
Message-ID: <20251013094152.23597-2-git@lohmann.sh>
In-Reply-To: <20251013094152.23597-1-git@lohmann.sh>
References: <20251013094152.23597-1-git@lohmann.sh>
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

