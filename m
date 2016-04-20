From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/12] path.c: add git_common_path() and strbuf_git_common_path()
Date: Wed, 20 Apr 2016 20:24:42 +0700
Message-ID: <1461158693-21289-2-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Apr 20 15:25:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ass8c-0004ar-UU
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbcDTNZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:25:45 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35734 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679AbcDTNZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:25:43 -0400
Received: by mail-pa0-f53.google.com with SMTP id fs9so18054701pac.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKY2947agBC15nsjrXuvCOH0PwsY2VuRaiR6MK79+hM=;
        b=ASY2E5sJyHwiDek7/3+gzGyjWeP9V9+LFcPmYlhTBaCzVpFFcv6hWOJLK6XiRlGKsg
         +o0uQ/c9Ir5tnaBenfvZJEYuToQZhpX5JT94QUdAIF/Z5oVvA1HIbUTf0VzeEedhZ3tX
         yl0kIwOJEbhMReXZzMA7bDH9OoV//3ey1OpVk5oltpYjYvsyQn/MxlILXPPJ1+vpGtCW
         L5AfN47U60t7nuWxnBQARzjCuaA0Jn4bqrPTjL3OpX4IYYGj1SvlP1B4rGW3ZnGjPKWa
         gHpLkAXW15nHElM4LZO/UNGu+Sq6rA/9j8fWz+aDTTaZHBt0uu5OOk0kECSONnw7V/wx
         J1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKY2947agBC15nsjrXuvCOH0PwsY2VuRaiR6MK79+hM=;
        b=FZuSCuUrRUedF628mjzNrdE7ZMSIFLFniweuBWbB3R0BB3C6lN0Nn5ICBJV98RVAhZ
         J5s7PAkdc5kwYm1th7EPf5ZciPk4E99e+L5U3bhti/UBCB/5wVXw/n74VpY/Qd+Q9NjZ
         iRMeBZu8pFTWSCLODEqzHAgQdvb9EeBkc6ZCxvYGhsxvC0K9dnFtKNEAaiRdGMmYSUqM
         2eRTl3xoH3BJbKTy51lWxA2E7l/BQWPJnjZDY2cK2/2r+RlU07bZn8+/vsmxPfAKElbi
         961h5sd0uCO57Dmy7/idg7Sm3v0wjI1BMvd++PtdqtGIYlDgdr25ChkduioNmIqKObHs
         OB2g==
X-Gm-Message-State: AOPr4FWB7qi1pb2Io/Z8A+r/ZIPiWiHMF/69EG12v5QNHKpl+oXIdJAQdrjVJuY9wT7Rbw==
X-Received: by 10.66.221.136 with SMTP id qe8mr12085360pac.7.1461158742356;
        Wed, 20 Apr 2016 06:25:42 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id a86sm57847895pfc.42.2016.04.20.06.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 06:25:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Apr 2016 20:25:54 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292010>

These are mostly convenient functions to reduce code duplication. Most
of the time, we should be able to get by with git_path() which handles
$GIT_COMMON_DIR internally. However there are a few cases where we need
to construct paths manually, for example some paths from a specific
worktree. These functions will enable that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  3 +++
 path.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/cache.h b/cache.h
index 2711048..c04a17f 100644
--- a/cache.h
+++ b/cache.h
@@ -799,11 +799,14 @@ extern void check_repository_format(void);
  */
 extern const char *mkpath(const char *fmt, ...) __attribute__((format =
(printf, 1, 2)));
 extern const char *git_path(const char *fmt, ...) __attribute__((forma=
t (printf, 1, 2)));
+extern const char *git_common_path(const char *fmt, ...) __attribute__=
((format (printf, 1, 2)));
=20
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+extern void strbuf_git_common_path(struct strbuf *sb, const char *fmt,=
 ...)
+	__attribute__((format (printf, 2, 3)));
 extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 extern void strbuf_git_path_submodule(struct strbuf *sb, const char *p=
ath,
diff --git a/path.c b/path.c
index bbaea5a..2ebb23d 100644
--- a/path.c
+++ b/path.c
@@ -503,6 +503,35 @@ void strbuf_git_path_submodule(struct strbuf *buf,=
 const char *path,
 	va_end(args);
 }
=20
+static void do_git_common_path(struct strbuf *buf,
+			       const char *fmt,
+			       va_list args)
+{
+	strbuf_addstr(buf, get_git_common_dir());
+	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
+		strbuf_addch(buf, '/');
+	strbuf_vaddf(buf, fmt, args);
+	strbuf_cleanup_path(buf);
+}
+
+const char *git_common_path(const char *fmt, ...)
+{
+	struct strbuf *pathname =3D get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	do_git_common_path(pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_git_common_path(sb, fmt, args);
+	va_end(args);
+}
+
 int validate_headref(const char *path)
 {
 	struct stat st;
--=20
2.8.0.rc0.210.gd302cd2
