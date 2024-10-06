Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED82F2E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 04:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728190778; cv=none; b=dDG7FOLMWGCLlUoILE+EwglTtkaodsrSgPwWufOXasmP9NJcb/JnOU0K0hSqFxk4Cgen2xVuonWM0wPskuDbnOFgtq2hbmHD7fqsA/dTRumRwPUgfBGtRHLSKqrTzku3pnEaIL3KLuCNYLlaU/eiGJX1IrHpffZ3Of0FtiwLGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728190778; c=relaxed/simple;
	bh=C6b0FGEYXbo4iG5JH965og5m4XI4YpfLHmr4xchUQZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au96gKkD1phWLAOTVa3VSQqPFMKeDz3iAqzWrFGL81lP484qzlEorXnmJLDOa18flyJ4Txw4KUEzGLKpeGxpBF85An49Jqlflc8NSG7O6XPgqV6NQ5MSoBu5PWPWT0cSXBrJQuC1ZSrWJPyXzzbT8X3pMOgOfBfclHbBCqO4FHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=iG/84fTh; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="iG/84fTh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728190768; x=1728449968;
	bh=6mhAjx0mBruBlYyzu/SWMs6qyq2/BalaEXY7gPAdU+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iG/84fThlyj5QW/YaPT3ONZHDt1b0YTtx+W662Xyo2pwUxaQiWuOQjSJcrHtwy5bz
	 CZ6/LSudntuN8n1n76Q1e3LSmHY0ld9P1qSzs1OH0LzM+OumZvVW1oIbgW826dOnuj
	 DuGcBP2I+sXa1A5Zn/uLb/CgWP9KR72CXu5i4LfWXhDAUTqa7dkgsFnbxdZd99QYkL
	 M7BuUzsmdgqpr+ElBTxyFSmPgyDr4BA2M7xkym0Slt9ddg8h/Kkbalzd44FlRAps/A
	 lMa6obKMa4i7YYvqkUcz8QzergqCkf/fxm1JB0Vx65ZNn7gAXv+Q5H2jjAZjgc4qjR
	 98/YgFtDV4Y9A==
Date: Sun, 06 Oct 2024 04:59:21 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <20241006045847.159937-2-cdwhite3@pm.me>
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
References: <20241006045847.159937-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 8caf31f53bda8417e3ac1ffa60e57fe63459f1b0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------95471bff50f62dd0f99819f9f9da389b3c09c02cd95db7c3cca143969a41cdae"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------95471bff50f62dd0f99819f9f9da389b3c09c02cd95db7c3cca143969a41cdae
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 1/4] worktree: refactor infer_backlink() to use *strbuf
Date: Sat,  5 Oct 2024 23:58:39 -0500
Message-ID: <20241006045847.159937-2-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
References: <20241006045847.159937-1-cdwhite3@pm.me>
MIME-Version: 1.0

This refactors the `infer_backlink` function to return an integer
result and use a pre-allocated `strbuf` for the inferred backlink
path, replacing the previous `char*` return type.

This lays the groundwork for the next patch, which needs the
resultant backlink as a `strbuf`. There was no need to go from
`strbuf -> char* -> strbuf` again. This change also aligns the
function's signature with other `strbuf`-based functions.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/worktree.c b/worktree.c
index 0f032cc..c6d2ede 100644
--- a/worktree.c
+++ b/worktree.c
@@ -642,10 +642,9 @@ static int is_main_worktree_path(const char *path)
  * be able to infer the gitdir by manually reading /path/to/worktree/.git,
  * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
  */
-static char *infer_backlink(const char *gitfile)
+static int infer_backlink(st
ruct strbuf *inferred, const char *gitfile)
 {
 	struct strbuf actual = STRBUF_INIT;
-	struct strbuf inferred = STRBUF_INIT;
 	const char *id;
 
 	if (strbuf_read_file(&actual, gitfile, 0) < 0)
@@ -658,17 +657,16 @@ static char *infer_backlink(const char *gitfile)
 	id++; /* advance past '/' to point at <id> */
 	if (!*id)
 		goto error;
-	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
-	if (!is_directory(inferred.buf))
+	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
+	if (!is_directory(inferred->buf))
 		goto error;
 
 	strbuf_release(&actual);
-	return strbuf_detach(&inferred, NULL);
+	return 0;
 
 error:
 	strbuf_release(&actual);
-	strbuf_release(&inferred);
-	return NULL;
+	return 1;
 }
 
 /*
@@ -680,9 +678,10 @@ void repair_worktree_at_path(const char *path,
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf realdotgit = STRBUF_INIT;
+	struct strbuf backlink = STRBUF_INIT;
 	struct strbuf gitd
ir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
-	char *backlink = NULL;
+	char *git_contents = NULL;
 	const char *repair = NULL;
 	int err;
 
@@ -698,21 +697,23 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
-	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
+	git_contents = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
 	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-		if (!(backlink = infer_backlink(realdotgit.buf))) {
+		if (infer_backlink(&backlink, realdotgit.buf)) {
 			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
 			goto done;
 		}
 	} else if (err) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
 		goto done;
+	} else if (git_conte
nts) {
+		strbuf_addstr(&backlink, git_contents);
 	}
 
-	strbuf_addf(&gitdir, "%s/gitdir", backlink);
+	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
 	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
 		repair = _("gitdir unreadable");
 	else {
@@ -726,8 +727,9 @@ void repair_worktree_at_path(const char *path,
 		write_file(gitdir.buf, "%s", realdotgit.buf);
 	}
 done:
-	free(backlink);
+	free(git_contents);
 	strbuf_release(&olddotgit);
+	strbuf_release(&backlink);
 	strbuf_release(&gitdir);
 	strbuf_release(&realdotgit);
 	strbuf_release(&dotgit);
-- 
2.46.2


--------95471bff50f62dd0f99819f9f9da389b3c09c02cd95db7c3cca143969a41cdae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAhkoCRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAAqugf/UxDXDSnyNREBLMSetB1y8Ub/aBcEsV0kuJwF5zoX6NVKpvsa
Y5UcQTEoM3XcQ+VtWLPRlSO7GIimKwRuzYmHPeWRW1pXN4viJxGREz5i4gbz
DIWPQwJjV0zMmsROE8y3uuaIG7eiiWL0AILGuyTHoyUvjmY3MIaSWuNgRZi3
cJ5Q3cgFz5VE3VcUE/E2R0jec+Cqwz+1ODr0t+5aV9CYtPjwG0WUF+1AZpYZ
wMthHDuema6LmPNIka/2i8HUjJ397coly28dcLqG+r6enaoWRaf8h9hrRyfd
0/Am9rsj51a+vCj2LyuaX5pkJv4Ow4z0eI9Y+qit0s3oGSMv3gXUgg==
=KwEy
-----END PGP SIGNATURE-----


--------95471bff50f62dd0f99819f9f9da389b3c09c02cd95db7c3cca143969a41cdae--

