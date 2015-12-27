From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] worktree: stop supporting moving worktrees manually
Date: Sun, 27 Dec 2015 10:43:16 +0700
Message-ID: <1451187796-31138-1-git-send-email-pclouds@gmail.com>
References: <xmqqmvuudfk6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, peff@peff.net,
	rappazzo@gmail.com, kyle@kyleam.com, sunshine@sunshineco.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:43:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD2Eu-00089V-Kn
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbbL0DnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:43:20 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35971 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbbL0DnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:43:19 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so1639566pab.3
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0z+hAdDJELurYOM3GgK5CNA2GDqYhHPzsyjnaOXhFsE=;
        b=wjzZcaroFcj7RCxFU2O0hk+ZWtDQb6osco7KZ54mkNVB5/YkoLAoHxefzvKe/c5qi6
         IaeQmq1lVyqkReqE/jlPFiLuoYSjyUQQkv7QRqUQJoYDeitTfe5rhnn6LuvaIT4Io+bd
         89dWsFV7NiCGBdQF4bYuIAC9oxvd3uG0NG2h9kzAhy9ghz4YyQHrY3rhER4q5nKTIGOl
         cmy1sHRKe7uWqUBwgcDtJU64zeW06asc75lGvSjigpCO6t5jBBAQfeBa3WdgVgAhaJJ5
         iRuT4mknP6O64iXcRCt2rU/RUbKcw2wdGjwfgT0fxjXyrKTCpZKni7yutaEotKg1prJS
         k4Kg==
X-Received: by 10.66.251.3 with SMTP id zg3mr69423435pac.145.1451187798462;
        Sat, 26 Dec 2015 19:43:18 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id sg4sm72816129pac.48.2015.12.26.19.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:43:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:43:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqqmvuudfk6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283017>

The current update_linked_gitdir() has a bug that can create "gitdir"
file in non-multi-worktree setup. Instead of fixing this, we step back =
a
bit. The original design was probably not well thought out. For now, if
the user manually moves a worktree, they have to fix up "gitdir" file
manually or the worktree will get pruned. In future, we probably will
add "git worktree mv" to support this use case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt |  6 ++----
 setup.c                        | 12 ------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 5b9ad04..4814f48 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -33,10 +33,8 @@ The working tree's administrative files in the repos=
itory (see
 clean up any stale administrative files.
=20
 If you move a linked working tree to another file system, or
-within a file system that does not support hard links, you need to run
-at least one git command inside the linked working tree
-(e.g. `git status`) in order to update its administrative files in the
-repository so that they do not get automatically pruned.
+within a file system that does not support hard links, you need to upd=
ate
+$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically p=
runed.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
diff --git a/setup.c b/setup.c
index d343725..6ee2b23 100644
--- a/setup.c
+++ b/setup.c
@@ -434,17 +434,6 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 	return ret;
 }
=20
-static void update_linked_gitdir(const char *gitfile, const char *gitd=
ir)
-{
-	struct strbuf path =3D STRBUF_INIT;
-	struct stat st;
-
-	strbuf_addf(&path, "%s/gitdir", gitdir);
-	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file(path.buf, "%s", gitfile);
-	strbuf_release(&path);
-}
-
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
@@ -514,7 +503,6 @@ const char *read_gitfile_gently(const char *path, i=
nt *return_error_code)
 		error_code =3D READ_GITFILE_ERR_NOT_A_REPO;
 		goto cleanup_return;
 	}
-	update_linked_gitdir(path, dir);
 	path =3D real_path(dir);
=20
 cleanup_return:
--=20
2.3.0.rc1.137.g477eb31
