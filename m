From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/25] worktree.c: store "id" instead of "git_dir"
Date: Wed, 13 Apr 2016 20:15:33 +0700
Message-ID: <1460553346-12985-13-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKfC-0004LM-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760513AbcDMNQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33932 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760651AbcDMNQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id d184so4104120pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nPuXVPavsJoStaKzWDNjBpsYMDVLx/jgoiGb+cklN8=;
        b=PrhnlCXA0qmA+adwLJkIQsp3bJJAspuVcf5ubcjcfvXZrgqa6zGvG0E6PPftfIUhQz
         w0u3fXKVYXf4nIc0HJuL/ZSLk1QdyZB0vDTxX/pVA6DoCne7/TTtjRNpKk/IYpez5H/B
         bNBHU9Re2t/5td5cfV+jAVWehXoSGHYS0vbGMMNmiRkF5QhoRlWs8cUDbswbotm3WL9C
         vAGn8AfGMxSBdOJ+W3W8OcEJW0hGtKvZPgl5yrzdkEPflTTlbHGFBR/F5AEzS+oI5DB1
         YRQHHeQWowOd5hRVkvtROqhIhhVujFRa+/0sH57AcKl3EwicsAD31a9YFLdGmKUNfxdU
         4p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nPuXVPavsJoStaKzWDNjBpsYMDVLx/jgoiGb+cklN8=;
        b=CgJ//iAEWpLP9wnSEe4sDT4OTGAl7Gp1EPnCej8Kcb+TddD3c5SsprcftNE0gQW/xW
         5b48rHpXHoWmsrTQ/rZuKYWIkM0f8KUd4x4w0XcPD/ja6/ziolgRdNqgmV0UidfttWt8
         2SsY/KnSyS+n/Ck4hLl+VGdTlC3z7uUu3YyxAE2Upz/frXcjjufQnoo4rbsSik5jtiHu
         0EZs8qzTdRMBxBjJ8Vl2PyzrpiYmliZGbUSbE+AuaRi2dLnx9Ix4++44mgVrLd7Q4i0Y
         aubapfE9loIJNodLP0DRJg6MV6RrMFcwApIdJfQSgVK4JxPcpQzcI7XztPnVSOEDWsC0
         XbCw==
X-Gm-Message-State: AOPr4FUa60W9KU71NsDe1OzMbgoMRjs0+qS0J4TgGnuoxFnS9kma/YTuXArDR4k0kIA6Gg==
X-Received: by 10.98.18.1 with SMTP id a1mr12976290pfj.39.1460553412496;
        Wed, 13 Apr 2016 06:16:52 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id m84sm51141525pfi.75.2016.04.13.06.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291433>

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
2.8.0.rc0.210.gd302cd2
