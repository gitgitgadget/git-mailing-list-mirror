From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/13] path.c: add git_common_path() and strbuf_git_common_path()
Date: Fri, 22 Apr 2016 20:01:25 +0700
Message-ID: <1461330096-21783-3-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 22 15:01:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ataiT-0006rB-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbcDVNBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:01:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36525 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbcDVNBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:01:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id p185so9851973pfb.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKY2947agBC15nsjrXuvCOH0PwsY2VuRaiR6MK79+hM=;
        b=DqgHaUfpGWMsIKyWq6Ssu5pOh2K6rOBYDx+nhGMRgKruiXN2kXAs6z7++xUJLuzx7h
         PX9I+nSIAl+iNwoA16+dpKIgCEqfJpaiZEkENFMKiZpSREs5fuPjn22wqSUuDhKPbfD/
         MANVeuwXN0ZYKq/yabYaurPLb+3v9QaNVVNNt2Tjm+CMBSSJWro14CC7911bH8VaMnlw
         /oJ3jTv0OSByZ3NVr907eGnDSHp6XhaIYpOlLosyMNVj5DLgtYykrODZII1k/qpO5R7d
         aWQKDMiVwlpnHmKHz3YFO9mVxc7NhIvXlGMHw1n13EGyn5DBoUzQgTZJWRSTHGO2/838
         OhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKY2947agBC15nsjrXuvCOH0PwsY2VuRaiR6MK79+hM=;
        b=DlyWRLSNGZ64hSQKDrsQf8T2Ctr2aUtA9PnKrBRC9DM6HJhU+eBISjbMFHByO9FRpo
         gH0bQDH15hwf9D4Tkd0IhbF47p3YzTibaPucNw+hvnVll7HFyQLvaAlGYNnQEwiysd8/
         7LIyJ71Iso7FrF2k1F16sbtiTcaTSdCsAFComoNo7XxhDPPq2pEwhCj/+3+5FhEUk1WM
         1U05EXMj+i8siluoas1DspDRZM13TlINj/qBRe1w3S2uetjGEf9sC6Bv9W9NnvyjR0bE
         0zCKAH+xQtCRICJk2DfSyNdPaWVG1fTUGelz9b57E3OYnU1dZCRmNxTiZKb1cWEvttrs
         uLHw==
X-Gm-Message-State: AOPr4FWrmPWNQoIaC7iJmU8gN8psFo/hVDlK1NUdc6o66/jxc5tI5Wx/q8Ia/rNklI28/A==
X-Received: by 10.98.92.71 with SMTP id q68mr28412795pfb.70.1461330098920;
        Fri, 22 Apr 2016 06:01:38 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id rw2sm9617374pab.30.2016.04.22.06.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:01:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:01:51 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292192>

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
