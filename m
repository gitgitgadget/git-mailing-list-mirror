Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24E218AA0
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592837; cv=none; b=Zfk2pt7iXMQXwUEKEflcvqqsTzAqby4j7dMbW5E84nOmB9K7ANpNtlPYWo4lR7XqFOaPjUj0H53RYzcSwQQM/yx7e5FhmzCoVFTib39a4yzF9dgvoeYV4morQg5IkzQOQ/kFYELgneAmTrn/kw569gGtHun7PHa5vdstgjpMvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592837; c=relaxed/simple;
	bh=A4NPypRPfh9Dfz5pvFpdQj/N2P/kIQCyoYKnu9FSsJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ps43IamiuRUB9X7b7nX4OJpfHzQS5LRYXlbLzEJxYNuvqPBsocYlQMTr8+iY3Ss6WyZBpa6LT1/hw5MNCVbSf+m4xi7xpPDqRaKljeIiLe3JbUrU+H7I0MvOkr3GuYH7zfOfO80zv6zB3rtjnvphMiM1lWqgtqyeA1lOZIJxIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=DS5qBSko; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="DS5qBSko"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760592825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyI2fuvcJpUQGuKQylP00lmSb2xMkkwPnFDPj7zPzQw=;
	b=DS5qBSkopns1YlIUenhZ6s8O76piG8LZkYRSTSi7IqWM8vaNT3Ds3+azuLncEo0suJeky7
	RAuuZXCbo+TvW+oBJH4aosx0iM6xpC3Tk0AuTPTqm0nxMGr1hR4wuvdNAjbTQ0MtXd7EA2
	MoinvjWCbiGbmrnMsc/zYKsvMIRZgnRtYzURRmC6O9wGNPrxlkQP4vokwacoKa4zqN5yLL
	UpCSqvMOKegFbYvfW228tEAdEACfgSTNH9H1ro7DuSa8mhgY1BVlyaDolHno+YbyzJF2rd
	DPA5bmlZH+N5qkEQ1avFDYpFGP8JUhR/Fi+XlpEFSSOf8nqAs7N57/fcEG/bYw==
To: git@lohmann.sh
Cc: git@vger.kernel.org
Subject: [PATCH v3 1/5] setup: rename `ensure_safe_repository()` for clarity
Date: Thu, 16 Oct 2025 07:33:18 +0200
Message-ID: <20251016053322.44495-2-git@lohmann.sh>
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
2.51.1.476.g147428281d

