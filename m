From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup: return correct prefix if worktree is '/'
Date: Fri, 25 Mar 2011 20:49:49 +0700
Message-ID: <1301060989-7246-1-git-send-email-pclouds@gmail.com>
References: <20110325100254.GH30350@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Fri Mar 25 14:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q37P6-0000d4-17
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 14:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab1CYNuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 09:50:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65414 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab1CYNuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 09:50:06 -0400
Received: by pzk9 with SMTP id 9so148891pzk.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IG+lnjAUqXYRYirwuM5vYTRMuuf1mn5okaF4dHKvVc4=;
        b=Wq1L4tkyoQjEwRin0EQncSlis80vYbZP/YiiQliM2lhTjABmCbVBjGK+LaKWMV23NM
         2ujxlTZQS8lLF6iayWo/OB8jKpCXzCJXJEGuSyeJLWXR9MYl4HHzl55Iev3sLtXab1wY
         HJAvwvHkw1NuyoOBeg6QsuxgkXdtsUyBVHYPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JTSCuLhYDFHTZ4SO+n9y+7E1exT8S0d5G176OA7nvCQHwT1WfnSiCe8eVffiRhzJNg
         I3QfdF39/nrG81o8sJn3Owki0w1/uFphBhiBNFl6ZaZXero+XWepi1Lxrn4p3UnJKtJI
         jCg9mfH251hc71UF9nx9gtaFPYHbCoH2PYetQ=
Received: by 10.143.84.9 with SMTP id m9mr653876wfl.54.1301061006125;
        Fri, 25 Mar 2011 06:50:06 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id y2sm1356273wfd.20.2011.03.25.06.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 06:50:03 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 25 Mar 2011 20:49:52 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <20110325100254.GH30350@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169986>

The same old problem reappears after setup code is reworked. We tend
to assume there is at least one path component in a path and forget
that path can be simply '/'.

Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    2 ++
 path.c  |   35 +++++++++++++++++++++++++++++++++++
 setup.c |    5 ++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index f765cf5..f579807 100644
--- a/cache.h
+++ b/cache.h
@@ -741,6 +741,8 @@ int longest_ancestor_length(const char *path, const=
 char *prefix_list);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
+int is_subdir_or_same(const char *subdir, const char *dir);
+const char *skip_dir(const char *dir, int skip);
=20
 /* Read and unpack a sha1 file into memory, write memory to a sha1 fil=
e */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 4d73cc9..9f77aea 100644
--- a/path.c
+++ b/path.c
@@ -662,3 +662,38 @@ int offset_1st_component(const char *path)
 		return 2 + is_dir_sep(path[2]);
 	return is_dir_sep(path[0]);
 }
+
+/* return 1 if subdir is either dir or inside dir */
+int is_subdir_or_same(const char *subdir, const char *dir)
+{
+	if (!*subdir || !*dir)
+		die("BUG: how can I compare a dir to empty?");
+
+	while (*dir && *subdir && *dir =3D=3D *subdir) {
+		dir++;
+		subdir++;
+	}
+
+	/* help/me vs hell/yeah */
+	if (*dir && *subdir)
+		return 0;
+
+	if (!*subdir)
+		return !*dir;	/* same dir */
+
+	/* foo/bar vs foo/ */
+	if (is_dir_sep(dir[-1]))
+		return is_dir_sep(subdir[-1]);
+
+	/* foo/bar vs foo */
+	return is_dir_sep(*subdir);
+}
+
+/* skip 'skip' chars and the trailing separator if any */
+const char *skip_dir(const char *dir, int skip)
+{
+	dir +=3D skip;
+	if (is_dir_sep(*dir))
+		dir++;
+	return dir;
+}
diff --git a/setup.c b/setup.c
index 03cd84f..79f8ea7 100644
--- a/setup.c
+++ b/setup.c
@@ -390,15 +390,14 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 		return NULL;
 	}
=20
-	if (!prefixcmp(cwd, worktree) &&
-	    cwd[strlen(worktree)] =3D=3D '/') { /* cwd inside worktree */
+	if (is_subdir_or_same(cwd, worktree)) {	/* cwd inside worktree? */
 		set_git_dir(real_path(gitdirenv));
 		if (chdir(worktree))
 			die_errno("Could not chdir to '%s'", worktree);
 		cwd[len++] =3D '/';
 		cwd[len] =3D '\0';
 		free(gitfile);
-		return cwd + strlen(worktree) + 1;
+		return skip_dir(cwd, strlen(worktree));
 	}
=20
 	/* cwd outside worktree */
--=20
1.7.4.74.g639db
