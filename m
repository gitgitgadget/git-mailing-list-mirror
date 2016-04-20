From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/12] path.c: refactor and add worktree_git_path()
Date: Wed, 20 Apr 2016 20:24:46 +0700
Message-ID: <1461158693-21289-6-git-send-email-pclouds@gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 15:26:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass95-0004sf-8T
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbcDTN0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:26:14 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36368 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbcDTN0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:26:13 -0400
Received: by mail-pf0-f179.google.com with SMTP id e128so18319421pfe.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oi7GCkBLc+qDP6UIBdum53o1mo/JnlAudc8/JcCEXeY=;
        b=AW1Y1/2DcgTfIPchSlFi3fNysORw+DTFUI14A9aHCx17e4PFblOsB5DJKC2jnwkDKB
         g0gkIPtEr8gP8ws5u3iH4YQQvDZua1eJ5jShdR9G39ndWxmbH6WysHwy5TYPpCzLOykj
         oozc5RW7PcHYc5cwYrgidKNS/tzgOQnOpRf53B6KsRs4KtPCirUZ88CP3wA8cEfx18F2
         mW3ZOuWdWJCJnLLmjfN8cwqPu65hvxxbypecjvQ3FvROreye/fCMkWrEaq/V/TvQFQsX
         qNl4VWr+gRAfkvWJQFBNXpV17nJDzE7DzlcyPAw34XTD0Akrq/EKloOvldJ0U67jtE2p
         v6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oi7GCkBLc+qDP6UIBdum53o1mo/JnlAudc8/JcCEXeY=;
        b=PxofRxWzxTtg5vPvx8IUecurk9AdoDQsx5ViOuYtdiuQ5jun92SViweqO0oiy+JhAy
         Gx+SBVJJQFsRwsDqoHgkVylBR1x8inXiz1nohWXCvFsFUcT8DUEu9d3606lzWfQofEoJ
         D80Uk+sfB2PkdSz6zPt71AHC7uK7/59XaLmvDMci9AynEyuR/znv6HB5ODWuzBtu78AV
         verhgh6KuV6XhHAtogXB60GKD34prmsKMsrqU63mQ+tapcXEZBJrGvu9UjPRGYinIf5s
         d824p6ZZzDdLRzvwfJWZWQcUopCZcE5N7h/CIH4M3iCJyHgIAuLq6TSXw6EgYQlCz/fm
         BKSQ==
X-Gm-Message-State: AOPr4FVXdhVFOcDNgB3QFvafrLR6u8wiXU18is31kbCTm7Z71qwKyamAi3v7qD7IfEMGPA==
X-Received: by 10.98.22.193 with SMTP id 184mr7004906pfw.116.1461158772482;
        Wed, 20 Apr 2016 06:26:12 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id i7sm54430716pfc.47.2016.04.20.06.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:26:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:26:24 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292017>

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
index 625fb8d..9d2463e 100644
--- a/worktree.h
+++ b/worktree.h
@@ -43,4 +43,15 @@ extern void free_worktrees(struct worktree **);
 extern const struct worktree *find_shared_symref(const char *symref,
 						 const char *target);
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
