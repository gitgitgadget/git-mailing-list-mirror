From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/20] path.c: add is_git_path_shared()
Date: Wed,  3 Feb 2016 16:35:34 +0700
Message-ID: <1454492150-10628-5-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrO-0005GF-8K
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbcBCJgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:20 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36399 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:17 -0500
Received: by mail-pa0-f52.google.com with SMTP id yy13so10726439pab.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3lbhcglpKgJ4RhY9x1D2RJhKTBjUtsSEo9PQhsdFImE=;
        b=o1FNgWBSDj5AYtfB1bAm/PWl7AcRwy201M7HFsBmM+DfPNREv+fjQiElSLyaY8iikZ
         vwdXxCiq7o4sxJXSSVWWt3LoStYgkRyNB8zFZUAxbEP6CCoZRwM/xwbxI4uawa79i/As
         jc+9uDBuGqBdQ227NPglM870fZoX8o9UBebO0PHNo6dbNYo6Hyo9AX+T6mF9KbDRqFhq
         4K4N8hrX2sbVqzonPbiTe8JxUECDZ0d4BSgs4HUXoAlTx2wTfPBjbqSlE83c154Op6sg
         ucbveH66Uz9cXN/YqMkQEX3vhDo4tKb6jLVQ1oNy56zGwL342a0DqISAA4ia7QSn2sDW
         T7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3lbhcglpKgJ4RhY9x1D2RJhKTBjUtsSEo9PQhsdFImE=;
        b=SOnNisUsUnkOnVkJVli2IUJn3IUFTOXAmnOeAlwTNlteCZ7PLnLg1iqex3EflZXduj
         i5nCCX1wGdj2ZAKVzO56iyxWTk/0S0D+bZfCClfcFJz58/keXli+xKcVFms0ZSsERIOB
         AwLK4O+h8FMp4ouXlCWw6rMgO+ZlIUCIXnzzC4jMaoJA5T7w9HvCWUM1Vd2pSYHkeEDH
         6ZSF0hPi4a9iqnXUV9BWSYbQbCj1mWbTudT5Kq/N3Y7dBJCHSzkzj1PbRHyniGJFKK4X
         Rd1UuZ8uJo96D/llYxIPR31Vy8KtDHc8Alszk847pS1Z05g/SDbluODUYYAfi0q1ufif
         /X3Q==
X-Gm-Message-State: AG10YOR2lbazFsCtpKhfYiBRSj96I2oXN8ezoQQYZ0Y3jnbToG+BWFI/zF0paHIE8OB04Q==
X-Received: by 10.67.1.164 with SMTP id bh4mr719971pad.118.1454492176137;
        Wed, 03 Feb 2016 01:36:16 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id g10sm8313106pfd.92.2016.02.03.01.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:27 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285348>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  2 ++
 path.c  | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index ec71181..c75d13f 100644
--- a/cache.h
+++ b/cache.h
@@ -748,6 +748,8 @@ extern int check_repository_format(void);
 extern const char *mkpath(const char *fmt, ...) __attribute__((format =
(printf, 1, 2)));
 extern const char *git_path(const char *fmt, ...) __attribute__((forma=
t (printf, 1, 2)));
 extern const char *git_common_path(const char *fmt, ...) __attribute__=
((format (printf, 1, 2)));
+extern int is_git_path_shared(const char *path);
+
=20
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
diff --git a/path.c b/path.c
index 08ff346..9e350e7 100644
--- a/path.c
+++ b/path.c
@@ -335,15 +335,18 @@ static int check_common(const char *unmatched, vo=
id *value, void *baton)
 	return 0;
 }
=20
-static void update_common_dir(struct strbuf *buf, int git_dir_len,
-			      const char *common_dir)
+static int update_common_dir(struct strbuf *buf, int git_dir_len,
+			     const char *common_dir)
 {
 	char *base =3D buf->buf + git_dir_len;
 	init_common_trie();
 	if (!common_dir)
 		common_dir =3D get_git_common_dir();
-	if (trie_find(&common_trie, base, check_common, NULL) > 0)
+	if (trie_find(&common_trie, base, check_common, NULL) > 0) {
 		replace_dir(buf, git_dir_len, common_dir);
+		return 1;
+	}
+	return 0;
 }
=20
 void report_linked_checkout_garbage(void)
@@ -368,7 +371,7 @@ void report_linked_checkout_garbage(void)
 	strbuf_release(&sb);
 }
=20
-static void adjust_git_path(struct strbuf *buf, int git_dir_len)
+static int adjust_git_path(struct strbuf *buf, int git_dir_len)
 {
 	const char *base =3D buf->buf + git_dir_len;
 	if (git_graft_env && is_dir_file(base, "info", "grafts"))
@@ -380,7 +383,10 @@ static void adjust_git_path(struct strbuf *buf, in=
t git_dir_len)
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
 	else if (git_common_dir_env)
-		update_common_dir(buf, git_dir_len, NULL);
+		return update_common_dir(buf, git_dir_len, NULL);
+	else
+		return 0;
+	return 1;
 }
=20
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list a=
rgs)
@@ -532,6 +538,17 @@ void strbuf_git_common_path(struct strbuf *sb, con=
st char *fmt, ...)
 	va_end(args);
 }
=20
+int is_git_path_shared(const char *path)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	int ret;
+
+	strbuf_addf(&buf, ".git/%s", path);
+	ret =3D adjust_git_path(&buf, 5);
+	strbuf_release(&buf);
+	return ret;
+}
+
 int validate_headref(const char *path)
 {
 	struct stat st;
--=20
2.7.0.377.g4cd97dd
