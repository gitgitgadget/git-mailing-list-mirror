From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] path.c: refactor and add worktree_git_path()
Date: Sun, 17 Apr 2016 19:59:21 +0700
Message-ID: <1460897965-486-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armJF-0007IL-Kt
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbcDQNAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 09:00:10 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34655 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbcDQNAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 09:00:07 -0400
Received: by mail-pa0-f67.google.com with SMTP id hb4so13792805pac.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wl3qENqXzL720j4wnhFoSY2oReEeO3gDz6BRZRE53nI=;
        b=V7kP3f+1/CI4rMmacZBKks9M1Cihn1dMfOTzGcPyX/ADCX4FlNbiOVG47yX6knlcZH
         ZGpD/zlFfymL4ZR1GLW8cAljyUTL6CpOYuaiJDitFyd0vUNY98aklpl8OnWaiEsZ9RCu
         E9VhgPH8Mitf+Rii3jvpy6pXzkc2lROhA3fIHJ/igUlZjiT6vfX0ULjMVheQQul/CYwd
         ATlCokbCM1XfCPYhhyxHuXB1jBMCSfDIPs+UWhrMuZ3G7988lfF+w7rxzB6EMitnk2DS
         maSMiB3tUkU0BE8o60DIKVm8fsrjg4Fx2ldz0QwdLCmZi+2kuwVMm3G+Vq4Ab6Pr5eVy
         17xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wl3qENqXzL720j4wnhFoSY2oReEeO3gDz6BRZRE53nI=;
        b=ZiY6gEdg/3Zf+oczmgwjz/WPz1MK1adQ3zJyfTpljNY4KU4Gtpv3ZucxhXhZ6QIqmE
         PX7kL12X8ghfB2G/LLJxWCi0kn6rZ+hg1pO9TevPVKkFJ+2XS7j10wTXdTOTSBxR3uBh
         Ne98yXW9pk5D781ZTsQFv4XkPgzyVJjWwPQFBonzsgwlprzzQrtK24vuhQ3eeDjktVi0
         fl2IWNvImGRa914RVwc+h1jre6uzty+hCVLuqW7Vea2S3ghLGjm6H06KXYSjxg+i2nMn
         HAxqI3JH+NqNJ5KuBvs7Hej530uuwh/D6m0+RIC3B+/jRNy6UJUYjU1v/ms3GuX5LiK7
         wa0w==
X-Gm-Message-State: AOPr4FUZYPgBlZ2EY7pf06XP+uWZuXk+85Uh4iOVCm7hm/UsrzXFND1AUBF5kosnvgYfxg==
X-Received: by 10.66.66.77 with SMTP id d13mr43191117pat.75.1460898006757;
        Sun, 17 Apr 2016 06:00:06 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id ez6sm77057444pab.12.2016.04.17.06.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 06:00:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:15 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291753>

do_git_path(), which is the common code for all git_path* functions, is
modified to take a worktree struct and can produce paths for any
worktree.

worktree_git_path() is the first function that makes use of this. It ca=
n
be used to write code that can examine any worktree. For example,
wt_status_get_state() will be converted using this to take
am/rebase/... state of any worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c     | 34 ++++++++++++++++++++++++++++------
 worktree.h | 11 +++++++++++
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index 2ebb23d..c421d37 100644
--- a/path.c
+++ b/path.c
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
+#include "worktree.h"
=20
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -383,10 +384,11 @@ static void adjust_git_path(struct strbuf *buf, i=
nt git_dir_len)
 		update_common_dir(buf, git_dir_len, NULL);
 }
=20
-static void do_git_path(struct strbuf *buf, const char *fmt, va_list a=
rgs)
+static void do_git_path(const struct worktree *wt, struct strbuf *buf,
+			const char *fmt, va_list args)
 {
 	int gitdir_len;
-	strbuf_addstr(buf, get_git_dir());
+	strbuf_addstr(buf, get_worktree_git_dir(wt));
 	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
 		strbuf_addch(buf, '/');
 	gitdir_len =3D buf->len;
@@ -400,7 +402,7 @@ char *git_path_buf(struct strbuf *buf, const char *=
fmt, ...)
 	va_list args;
 	strbuf_reset(buf);
 	va_start(args, fmt);
-	do_git_path(buf, fmt, args);
+	do_git_path(NULL, buf, fmt, args);
 	va_end(args);
 	return buf->buf;
 }
@@ -409,7 +411,7 @@ void strbuf_git_path(struct strbuf *sb, const char =
*fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(sb, fmt, args);
+	do_git_path(NULL, sb, fmt, args);
 	va_end(args);
 }
=20
@@ -418,7 +420,7 @@ const char *git_path(const char *fmt, ...)
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(pathname, fmt, args);
+	do_git_path(NULL, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
@@ -428,7 +430,7 @@ char *git_pathdup(const char *fmt, ...)
 	struct strbuf path =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(&path, fmt, args);
+	do_git_path(NULL, &path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -454,6 +456,26 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
=20
+const char *worktree_git_path(const struct worktree *wt, const char *f=
mt, ...)
+{
+	struct strbuf *pathname =3D get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	do_git_path(wt, pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+char *worktree_git_pathdup(const struct worktree *wt, const char *fmt,=
 ...)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	va_list args;
+	va_start(args, fmt);
+	do_git_path(wt, &path, fmt, args);
+	va_end(args);
+	return strbuf_detach(&path, NULL);
+}
+
 static void do_submodule_path(struct strbuf *buf, const char *path,
 			      const char *fmt, va_list args)
 {
diff --git a/worktree.h b/worktree.h
index 3198c8d..9ae2028 100644
--- a/worktree.h
+++ b/worktree.h
@@ -41,4 +41,15 @@ extern void free_worktrees(struct worktree **);
  */
 extern char *find_shared_symref(const char *symref, const char *target=
);
=20
+/*
+ * Similar to git_path() and git_pathdup() but can produce paths for a
+ * specified worktree instead of current one
+ */
+extern const char *worktree_git_path(const struct worktree *wt,
+				     const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern char *worktree_git_pathdup(const struct worktree *wt,
+				  const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
 #endif
--=20
2.8.0.rc0.210.gd302cd2
