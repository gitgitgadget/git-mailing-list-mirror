Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E6163A9B
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194465; cv=none; b=R2HdUaePGAZ2NijdkNFcEaiandFbxWSycbCdbn3qKNqSWAKECMxHegQ+y8ZsLN51GQ4zKoMzDjWydgRhovwqWePhr3mCD6xszwS+II0dKieD+E1EinsuM63oT/M/WCx50+VaZPuR8a3++yAdqNu29AzEJxPjR+rUfm+2JvkbKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194465; c=relaxed/simple;
	bh=yncxUMvM1boNXQ72pQuqOxrJnH/46jpzD2MtAAEPkY8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9fJc65xiTpzxIr6l+XIQT2oUdMnrksKlo3/ZOIyolurr4/h1iqSGukHCDXEOCWzEpclab80W5v+rLbyMoZ9GA0RLUeR5Z/4aaOq+bU2ADpAzqsxsaBUxDGRFVCdzo0wEmIH9o3pxtmSZYEPgaLeUG0ELr8SjXXhMsm1k+1tLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oEFwsbgT; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oEFwsbgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728194462; x=1728453662;
	bh=MjkHgnxPKozAVrN1/nWuPp5mTSkkvWOxBWlf4QYeeNI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oEFwsbgTNw9F90WDVe2GMEu5u3ti5CZlSifal/kQPdYfig5blNQf1nQT3CioWze6K
	 M662GKFSIveUU21MafXvZQhTIRVmP/b4WsijQJ9pdHD852O5cVw/F0k49b/kjZTOZ0
	 H7xJYiVFH278Sp5zsHttHEG2XayMWXfO6g2iMQyDILUEOxo3+MEMYqAkhRZuk35PNG
	 f0kvE/bKDB8u8eEYYcIJ6g7Lx+FdPINKQTQVVeZxxiCnpT007k+qD9f/tzBK9SMxDp
	 pQsz6sPYeKBfa6DqzOkPbOkQ4UeilRZcqfrydNXVaQ1cu/Zsm4tgGb828fz/2OrQcO
	 bbcs46vf1CPew==
Date: Sun, 06 Oct 2024 06:00:57 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <20241006060017.171788-2-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-1-cdwhite3@pm.me>
References: <20241006060017.171788-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: a4be7a95a4e1e4f6fea8b43dcb2c53bd32a21fc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------cfa1ccd4d1fd431b3445a671fc5b23377fe10b73d1f0f5d1ddeb3a89994e9ab9"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------cfa1ccd4d1fd431b3445a671fc5b23377fe10b73d1f0f5d1ddeb3a89994e9ab9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Date: Sun,  6 Oct 2024 01:00:14 -0500
Message-ID: <20241006060017.171788-2-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006060017.171788-1-cdwhite3@pm.me>
References: <20241006060017.171788-1-cdwhite3@pm.me>
Reply-To: 20241006045847.159937-1-cdwhite3@pm.me
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


--------cfa1ccd4d1fd431b3445a671fc5b23377fe10b73d1f0f5d1ddeb3a89994e9ab9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAieYCRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADDzwf/bfaJhVBG6VXW5ql8nj9riB2ynE3v6ioT3T/94bTXMWu4hgnc
KhV45ukXXeMboQmdl5/ku5BkD/3S7GmpCtgLHQYgnhiC5UvUUC9wboBTKR3l
+5xdVOEQYfJ5i10MH9MPHDxIBlFRIH8quGwqqn9OcRcZLmZlKsVQl+6N5S0y
LVnmyRtK7Vu+J5Nntez0X+G3474/m+YuN5iimcW6EStDuTNt05SPiRt/DieU
QRUMjT172OzuggION3jjjPRMPMOAM2h0y53PobnU5+kjGU++DI1M1NRqVGwh
47hNiCuYDZ2ASwyn76uDi0/VlS3hv8z254MeMO46/hCzH118Ibh91w==
=4kvU
-----END PGP SIGNATURE-----


--------cfa1ccd4d1fd431b3445a671fc5b23377fe10b73d1f0f5d1ddeb3a89994e9ab9--

