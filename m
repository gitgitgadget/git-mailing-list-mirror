From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/26] path.c: add git_common_path() and strbuf_git_common_path()
Date: Tue, 16 Feb 2016 20:29:12 +0700
Message-ID: <1455629367-26193-12-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfi5-00038d-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbcBPNa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:30:28 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36770 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350AbcBPNaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:20 -0500
Received: by mail-pf0-f181.google.com with SMTP id e127so105502600pfe.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=27Q9WIXFOXv+nbiUDTfHIs59uLSmm6gzshbzzcFEUbM=;
        b=sgvDFLK9XP1G6Hf09M38L4laNsGUXCK4foXtCzrQ0B2jt6pFWrGGRID6tuBMcoYrLj
         REmNcExCxsHrz3mpQfW+rsq4AWkJwVdozREPqTIjgz7MBg0RWQ1NCCPtzTyqqbrcMLwx
         vnn5LHbid/N9ZScokXyBa1z5Oyv86ESYYu9nVHuoJyWfi0gQ552l8LU/S1twzYmeRoiq
         +bzlZSX73z1lJcPuUF96xyREKS2yMZSApnMwM2xX7zJV9M0RC5vc2+w9aSw9T5Pe5uIG
         Aajwq+QGl+weChPi86ajG9ltwG9Yan1Fv76Naw8s/KfZyNJOMSqIeE4VJD7vZ7tcfN+E
         G2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=27Q9WIXFOXv+nbiUDTfHIs59uLSmm6gzshbzzcFEUbM=;
        b=EKS+UezDL5hdBKZcXFZ03QTz32c5Fb+W2Kk2tn1GHOc2gupIly5mPTumz6jOMNWyoa
         5oK3BCfV1t2c1AyPVTtDgiSTyb+lCN0k+JvsmpfU8GrqpfNdvZEj8EklCqmI2Nixl4WI
         ixr6ZH56/IsZyRPWyEomD7NK7/gzYctwzSyOnOCgOXWitqpUw3p0P5DubswdFmhML1Ph
         syoluD8TY/9j218T0d+12dXvr318ZjG2gqQs6RxmiF5PcQUXUTZwGeODMC9Q5T0gHd9W
         3ADxbuC1Y3a8/IWCKSaggepFi72ecoVdVD9wQciitIW4vuTtyP233CEWk1U5B4+HspaV
         Gg5g==
X-Gm-Message-State: AG10YOSp+ZXSEikHkZHhzi+9HNn1JlarDmWhU/MeIGZ3xNwfhzZjI/8sAY2IBQJu+kkPgg==
X-Received: by 10.98.68.73 with SMTP id r70mr31411363pfa.136.1455629420016;
        Tue, 16 Feb 2016 05:30:20 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id r26sm46020937pfb.21.2016.02.16.05.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:43 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286376>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  3 +++
 path.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/cache.h b/cache.h
index 30a2708..04818c2 100644
--- a/cache.h
+++ b/cache.h
@@ -765,11 +765,14 @@ extern int check_repository_format(void);
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
index 8b7e168..0c294a1 100644
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
2.7.0.377.g4cd97dd
