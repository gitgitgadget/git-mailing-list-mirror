From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/20] worktree.c: store "id" instead of "git_dir"
Date: Wed,  3 Feb 2016 16:35:37 +0700
Message-ID: <1454492150-10628-8-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrl-0005Vw-Cl
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbcBCJgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:35 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36540 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:33 -0500
Received: by mail-pa0-f47.google.com with SMTP id yy13so10730323pab.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tUL9m/Jyvsjq7/XKGBz7J6ketgHyHWyBTr7CLY1n3Eg=;
        b=UrGdFba9TPdNnVzLmRW2X+t+N+VGZJcfpZff8J8W7wq7ruHbC0BgWMEJq5spJVoMm8
         ebMxd0DQh/NYrNiNsziPnosyNm4pGfSKbNTWd2HYf62Iqx7Lhn8pvQBC3t7Gc/hGJ2Wz
         ddv6UJ3s2S7oKuJ2GkmvCpwFiacMP+m7kE+swFU/VN7mxjnZ7xvHd8iVnLdlTYx121SS
         yPvGaNVIqRC4lUQiyJEO2XRnT7RSNbNiWksaXnc2vEB56K2Z4xvN7asQ5GdGgCjPk1KK
         LFmldoSsYYrkaLerrjbrc+bQ9BN0yuvdXAXsexGElvHFUm7B37v+rcyk96CqVHyPjdCb
         V5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tUL9m/Jyvsjq7/XKGBz7J6ketgHyHWyBTr7CLY1n3Eg=;
        b=PviX3b9SHTlWnxZzOOIFoitfILSmYRAo3aFenWLZHZ0biFZFbL0V5H1PI7Su67cW6d
         SpTqdPHYf75uFlRVf7K5ZLT1jYjOnNwiO+ajqTPsKRtm2T4/+5Pss1qH3qUqMlvHZ5av
         y+U+goD7thUHaxABZX6F+4b1g+RTWiRwAr1SSrPfj4cZ0zf9EI4VEHomWuQEeDSGLdni
         idvMY4cPTMC7znv3Mr1W+EMIFOrrE0wy3t9cVfnD2BoRtWpL9uBVW0zqDRb3PgQH/20w
         1I/5Z69v6UmQwDingYtx3T89moLCXswh6ggYepAYI9naMT5x1ThvLLRA5weXXlPKEVBB
         h5rQ==
X-Gm-Message-State: AG10YOTbn4Lm+zzqn0ByPvPyKt9XJ4YmFq0Ms8czNK2Z01vGYbfXHbBB9aXRdPyqicNaMA==
X-Received: by 10.67.24.104 with SMTP id ih8mr721195pad.124.1454492193129;
        Wed, 03 Feb 2016 01:36:33 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id h65sm8390412pfh.43.2016.02.03.01.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:44 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285350>

We can reconstruct git_dir from id quite easily. It's a bit hackier to
do the reverse.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 29 ++++++++++++++++-------------
 worktree.h |  7 ++++++-
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/worktree.c b/worktree.c
index ddb8cb7..4c38414 100644
--- a/worktree.c
+++ b/worktree.c
@@ -10,7 +10,7 @@ void free_worktrees(struct worktree **worktrees)
=20
 	for (i =3D 0; worktrees[i]; i++) {
 		free(worktrees[i]->path);
-		free(worktrees[i]->git_dir);
+		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
 		free(worktrees[i]);
 	}
@@ -75,13 +75,11 @@ static struct worktree *get_main_worktree(void)
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
 	struct strbuf worktree_path =3D STRBUF_INIT;
-	struct strbuf gitdir =3D STRBUF_INIT;
 	struct strbuf head_ref =3D STRBUF_INIT;
 	int is_bare =3D 0;
 	int is_detached =3D 0;
=20
-	strbuf_addf(&gitdir, "%s", absolute_path(get_git_common_dir()));
-	strbuf_addbuf(&worktree_path, &gitdir);
+	strbuf_addstr(&worktree_path, absolute_path(get_git_common_dir()));
 	is_bare =3D !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
@@ -93,7 +91,7 @@ static struct worktree *get_main_worktree(void)
=20
 	worktree =3D xmalloc(sizeof(struct worktree));
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
-	worktree->git_dir =3D strbuf_detach(&gitdir, NULL);
+	worktree->id =3D NULL;
 	worktree->is_bare =3D is_bare;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
@@ -101,7 +99,6 @@ static struct worktree *get_main_worktree(void)
=20
 done:
 	strbuf_release(&path);
-	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
 	return worktree;
@@ -112,16 +109,13 @@ static struct worktree *get_linked_worktree(const=
 char *id)
 	struct worktree *worktree =3D NULL;
 	struct strbuf path =3D STRBUF_INIT;
 	struct strbuf worktree_path =3D STRBUF_INIT;
-	struct strbuf gitdir =3D STRBUF_INIT;
 	struct strbuf head_ref =3D STRBUF_INIT;
 	int is_detached =3D 0;
=20
 	if (!id)
 		die("Missing linked worktree name");
=20
-	strbuf_addf(&gitdir, "%s/worktrees/%s",
-			absolute_path(get_git_common_dir()), id);
-	strbuf_addf(&path, "%s/gitdir", gitdir.buf);
+	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <=3D 0)
 		/* invalid gitdir file */
 		goto done;
@@ -141,7 +135,7 @@ static struct worktree *get_linked_worktree(const c=
har *id)
=20
 	worktree =3D xmalloc(sizeof(struct worktree));
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
-	worktree->git_dir =3D strbuf_detach(&gitdir, NULL);
+	worktree->id =3D xstrdup(id);
 	worktree->is_bare =3D 0;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
@@ -149,7 +143,6 @@ static struct worktree *get_linked_worktree(const c=
har *id)
=20
 done:
 	strbuf_release(&path);
-	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
 	return worktree;
@@ -189,6 +182,14 @@ struct worktree **get_worktrees(void)
 	return list;
 }
=20
+const char *get_worktree_git_dir(const struct worktree *wt)
+{
+	if (wt->id)
+		return git_common_path("worktrees/%s", wt->id);
+	else
+		return get_git_common_dir();
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
@@ -200,7 +201,9 @@ char *find_shared_symref(const char *symref, const =
char *target)
 	for (i =3D 0; worktrees[i]; i++) {
 		strbuf_reset(&path);
 		strbuf_reset(&sb);
-		strbuf_addf(&path, "%s/%s", worktrees[i]->git_dir, symref);
+		strbuf_addf(&path, "%s/%s",
+			    get_worktree_git_dir(worktrees[i]),
+			    symref);
=20
 		if (parse_ref(path.buf, &sb, NULL)) {
 			continue;
diff --git a/worktree.h b/worktree.h
index b4b3dda..e89d423 100644
--- a/worktree.h
+++ b/worktree.h
@@ -3,7 +3,7 @@
=20
 struct worktree {
 	char *path;
-	char *git_dir;
+	char *id;
 	char *head_ref;
 	unsigned char head_sha1[20];
 	int is_detached;
@@ -23,6 +23,11 @@ struct worktree {
 extern struct worktree **get_worktrees(void);
=20
 /*
+ * Return git dir of the worktree. Note that the path may be relative.
+ */
+extern const char *get_worktree_git_dir(const struct worktree *wt);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
--=20
2.7.0.377.g4cd97dd
