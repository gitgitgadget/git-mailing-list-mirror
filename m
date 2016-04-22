From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/13] path.c: refactor and add worktree_git_path()
Date: Fri, 22 Apr 2016 20:01:29 +0700
Message-ID: <1461330096-21783-7-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ataix-0007IT-NI
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbcDVNCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:15 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35230 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbcDVNCP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:15 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so10261173pac.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MKu3MyzFkOfH5fkRhtffU7WT/dSmRUj/8riy34ggsow=;
        b=MyXTL6P/Sn3VNad4sPbV0whLWz56XKzEFvAJC/iQ3IEgAH0SMtjsnQXmZwP0fzSTxc
         /5PlB95pozh0KaQ+VsuSRu2HS5nFKmENjJ0rBi3mADJ+vFXM4hfOwV/lL0S1a+aCM7Yl
         a4HbwItl/oTbYBGd+V3MLNnhhL/JvI6YSYsNODOZMMoHlNPm9m54KfOqmxYj8PGKv7CS
         a4XXu9oM9TK+VmPwDTYFjXBwOlId+4qcoN5dS0Y7Z925VAF/mGrUzP+2LvIrOvPhkDZO
         CPf0gsG0RQTtFictLz092W5/dAbyh3ttQ3kbgE8+dDJkd22h+MhuwxaTXsgGNKn53Mnk
         IFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MKu3MyzFkOfH5fkRhtffU7WT/dSmRUj/8riy34ggsow=;
        b=Tmaa/2RgWETGo0398vwmWp4LV3pmEXhhohC4JRA0+ycsq+LkKJ9JWKXdrF+DCHH8nf
         yWwQIJJgkw7iwG/93oW0lajKfx3Zivi9swIY3+st/VdYG2dm8Sitv8DYZK7Aoe26rAeQ
         9tfZq4cB0T05seklUcf+DuvkIW2r2GKLNhmRqUZQnZOOleYwT9rCsZZIB7LiaColiohh
         kMy718leyO/HOjtGYxnZ526LpIyEAh1x/sxR3Z61igE6E0ESk5NrpwdnI1vux5Tbo+j9
         o04OR94FWCjpS23A7kqfdnt95lMoe2ft86IOktl8yDtJADjA8AmJgdWzu+qHgIVewVlJ
         LaOg==
X-Gm-Message-State: AOPr4FWX/sG5iXFuwhyemmDYViVAwn7wVKuyDZDhVfa0if0leYHigffTdBS59d2JUiWi7g==
X-Received: by 10.66.189.65 with SMTP id gg1mr28292693pac.148.1461330134187;
        Fri, 22 Apr 2016 06:02:14 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id t62sm8453334pfa.38.2016.04.22.06.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:02:26 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292195>

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
 path.c     | 24 ++++++++++++++++++------
 worktree.h |  8 ++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index 2ebb23d..8fdd187 100644
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
@@ -454,6 +456,16 @@ const char *mkpath(const char *fmt, ...)
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
 static void do_submodule_path(struct strbuf *buf, const char *path,
 			      const char *fmt, va_list args)
 {
diff --git a/worktree.h b/worktree.h
index ccdf69a..0da8c1f 100644
--- a/worktree.h
+++ b/worktree.h
@@ -42,4 +42,12 @@ extern void free_worktrees(struct worktree **);
 extern const struct worktree *find_shared_symref(const char *symref,
 						 const char *target);
=20
+/*
+ * Similar to git_path() but can produce paths for a specified
+ * worktree instead of current one
+ */
+extern const char *worktree_git_path(const struct worktree *wt,
+				     const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
 #endif
--=20
2.8.0.rc0.210.gd302cd2
