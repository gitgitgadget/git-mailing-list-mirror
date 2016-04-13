From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/25] path.c: add git_common_path() and strbuf_git_common_path()
Date: Wed, 13 Apr 2016 20:15:31 +0700
Message-ID: <1460553346-12985-11-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKf1-0004G4-8x
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760639AbcDMNQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32999 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760633AbcDMNQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id e190so4120619pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLjwX4E3ExR8Nv2EgrRRDYv3xOrc7tLUzBtDTB2VgR0=;
        b=sdQOZ+FCnt3H7PMraFMJwdCVuHWuHabHHSQQ+zxmLzEMkrAkV13gxRbABrMe86jhv7
         alLAZuNefvKU5Vg/5StoFaL54CUbP++PFg2+PzKukPvDxbcKyIbiQPcUIO6IO22KT1YX
         k7aiEy4e01pwsdhyFVfdiBiP6fAu+s6Ne4NX8Ue/JIwrz8tKY2F/vLlQ+XMu5cGQSDgi
         I+NlmW0wb/58BK8NXMnJXkMS7LUubQbwVhnhOu/hpUSc7u3fr4HG5oR6sPl3olfYBSL+
         dfbapw4NQ5ZUBgvwOyMIUGUVSV0+tflp7rpEH1LaipOzY8XPzSMSqkn3NYVwHCIK5nZ/
         DtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLjwX4E3ExR8Nv2EgrRRDYv3xOrc7tLUzBtDTB2VgR0=;
        b=fIWsraAIGmVWoKp8CmpYqhxGzz3ucjfdNKz84+fPLJ9XEQdPwn8gRT/ShJoxtMEovL
         Bid4P9ArRqOvBY7WD6DVvE+BAxCP236JYgNXWEuQmd7Zhnx/yKokb2WczpTikn/8JvjZ
         VIWqwE7IbFRJkZt1HR+rxVZC6nwRfwYotAEfVKRIreihgjik/D3o6FRhv0MHN1PyvlUx
         DBYrtZ+VxjSkoEqtL10V7PHGRPX5DIHUJS3YlspDgXKYd4ORXqxx1jUgnxVodaTYEmFd
         r3Tv4Ol6Dn0FcNl+7iL8/psOVUEuQf79rkL2uO/0SE611iptE496H1mz2CcdyzETU4kn
         +iFQ==
X-Gm-Message-State: AOPr4FWA7afkNHbbCMNpTuhg6PFuUUl2sPwYX4wU2BXeV4seFEpi/Yl7WvY2jASoYbhqGg==
X-Received: by 10.98.71.86 with SMTP id u83mr12859223pfa.156.1460553401860;
        Wed, 13 Apr 2016 06:16:41 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id ud5sm51319485pac.11.2016.04.13.06.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291430>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  3 +++
 path.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/cache.h b/cache.h
index 213a8d3..c81f654 100644
--- a/cache.h
+++ b/cache.h
@@ -767,11 +767,14 @@ extern int check_repository_format(void);
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
index 969b494..e315dd6 100644
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
