From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] worktree.c: store "id" instead of "git_dir"
Date: Sun, 17 Apr 2016 19:59:20 +0700
Message-ID: <1460897965-486-3-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armJ8-0007Et-MB
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbcDQNAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 09:00:03 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36635 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbcDQNAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:00:02 -0400
Received: by mail-pa0-f65.google.com with SMTP id i5so82373pag.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIPXFduN3maJVhpyxLc0qujPYKx6k0A+/y/hLSbECDQ=;
        b=RkDgSVbZulMJOovnrMf2N/uL4XrNcmTzx31LlbhgPCSqQn2KYgZerZqSvEw4DI1hkM
         4URxSN2AdVF2xxtfdORU3V/4xr12qnqsXDgV/zp+qneMQNkyLWYQEB2yO8H9yppPjVZi
         d16zaD6qIiUiku+hUXRfWqCy877HWXj/qEmaVtzf0Nqqa5IkTC3oCAz3zWrD0cIhXW/x
         YIBLt8zfW9qelSCd4UTO1LNjxvYNkjcZmxcwopb+aIqmuMBIX2dDBuskGUJmsGG0Uj7E
         9jshdkQ8Pp9bj0OsnJySqbRQ0fAKlzDJAvYZ3WO5+uNahQuNX6PFZ4nFwbvvYWGz+UUH
         oJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIPXFduN3maJVhpyxLc0qujPYKx6k0A+/y/hLSbECDQ=;
        b=SmQ2lGFmxGPD+CiFPJ3oI4ldINm8x/OOdTdew1j15wAo4/Ri7+exTNNuYMznyujNV4
         i9lyQmDXHK26skm2vWHtXIFRAcp6YpPGMsGYcL6kICpIZPq31lkxIVo3IJu96KxCbHb1
         LHYHLsptythoHmeMI8FngrZGOdlT9SXN4Nq1jk9KySUB5MhwJHQj04QGgo4bF2FwG5G1
         xT4TGyTT1o+nGVPVv9xdOqfLS2GBQrPTe7l6VVyw1XRDfe60TBtHb6QSg1NSSlHx6713
         DJKlEpOBEzcQ7861+sVfwawVGp8zoHueir5reRgnCsSv8Viv5Ev66Rgl64ifM9cfLdqv
         PSIA==
X-Gm-Message-State: AOPr4FUqN6pQx1SyWT1ewkqnu+8OJPBP+DN4lzadpuE0yq/H38ukQzylv6Hfe7UP5L0g/g==
X-Received: by 10.66.246.165 with SMTP id xx5mr42861239pac.87.1460898000882;
        Sun, 17 Apr 2016 06:00:00 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id tn5sm77083827pac.32.2016.04.17.05.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 05:59:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:10 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291752>

We can reconstruct git_dir from id quite easily. It's a bit hackier to
do the reverse.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 31 ++++++++++++++++++-------------
 worktree.h |  8 +++++++-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/worktree.c b/worktree.c
index 6181a66..5ae54f0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -9,7 +9,7 @@ void free_worktrees(struct worktree **worktrees)
=20
 	for (i =3D 0; worktrees[i]; i++) {
 		free(worktrees[i]->path);
-		free(worktrees[i]->git_dir);
+		free(worktrees[i]->id);
 		free(worktrees[i]->head_ref);
 		free(worktrees[i]);
 	}
@@ -74,13 +74,11 @@ static struct worktree *get_main_worktree(void)
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
@@ -92,7 +90,7 @@ static struct worktree *get_main_worktree(void)
=20
 	worktree =3D xmalloc(sizeof(struct worktree));
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
-	worktree->git_dir =3D strbuf_detach(&gitdir, NULL);
+	worktree->id =3D NULL;
 	worktree->is_bare =3D is_bare;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
@@ -100,7 +98,6 @@ static struct worktree *get_main_worktree(void)
=20
 done:
 	strbuf_release(&path);
-	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
 	return worktree;
@@ -111,16 +108,13 @@ static struct worktree *get_linked_worktree(const=
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
@@ -140,7 +134,7 @@ static struct worktree *get_linked_worktree(const c=
har *id)
=20
 	worktree =3D xmalloc(sizeof(struct worktree));
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
-	worktree->git_dir =3D strbuf_detach(&gitdir, NULL);
+	worktree->id =3D xstrdup(id);
 	worktree->is_bare =3D 0;
 	worktree->head_ref =3D NULL;
 	worktree->is_detached =3D is_detached;
@@ -148,7 +142,6 @@ static struct worktree *get_linked_worktree(const c=
har *id)
=20
 done:
 	strbuf_release(&path);
-	strbuf_release(&gitdir);
 	strbuf_release(&worktree_path);
 	strbuf_release(&head_ref);
 	return worktree;
@@ -188,6 +181,16 @@ struct worktree **get_worktrees(void)
 	return list;
 }
=20
+const char *get_worktree_git_dir(const struct worktree *wt)
+{
+	if (!wt)
+		return get_git_dir();
+	else if (!wt->id)
+		return get_git_common_dir();
+	else
+		return git_common_path("worktrees/%s", wt->id);
+}
+
 char *find_shared_symref(const char *symref, const char *target)
 {
 	char *existing =3D NULL;
@@ -199,7 +202,9 @@ char *find_shared_symref(const char *symref, const =
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
index b4b3dda..3198c8d 100644
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
@@ -23,6 +23,12 @@ struct worktree {
 extern struct worktree **get_worktrees(void);
=20
 /*
+ * Return git dir of the worktree. Note that the path may be relative.
+ * If wt is NULL, git dir of current worktree is returned.
+ */
+extern const char *get_worktree_git_dir(const struct worktree *wt);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
--=20
2.8.0.rc0.210.gd302cd2
