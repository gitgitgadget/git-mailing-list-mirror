From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 08/12] gettext: add is_utf8_locale()
Date: Sun, 14 Feb 2016 18:49:52 +0700
Message-ID: <1455450596-11904-9-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:52:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDe-0001TQ-8G
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbcBNLv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:58 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34498 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcBNLv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:57 -0500
Received: by mail-pf0-f195.google.com with SMTP id 71so6245115pfv.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nHQ8hbRWITf3hclBmB90siyRvdFS02t/f4dPX1sLvto=;
        b=egXCWzGfGHJHcnuPpGJ18a+fg4pYMpNiLgwzRDuhcVH59Q8drDAAQ7zNjMhg9ueKZj
         K5fYu3kaJi01tVCY5JORPhV5tb6rvW1RgTsdrFVNBwsQgQy+NyjGpCkEmPDehzweud0H
         /CUIwYvZpY5CEQHF4z6wpd/gJYmXfpLaeLGZ83QSBJBQ6OImdb/sewlLXS6tbNEhlCvo
         2a06kX+kUmI4sOZgf42atYlEuHwV882NaU4tcaV1hmxmh0XDJxQ1QmoKsWb415XtJJw2
         8GCpVpKn5qBd7/In19+9Bz3RmDEoCkiy10XjDf1PBUGCwDYAv3K4+1fhuoJ6jXXww4G+
         0zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nHQ8hbRWITf3hclBmB90siyRvdFS02t/f4dPX1sLvto=;
        b=dakwGmyeCgHSwiOzuP0fBhYW3zILraBfujy6fdps6fGErZaGmdYKFpxqTSxt9eimz5
         zLypCpFwjV8CS/pbvTWsKEbODGxQmwToOlMPpvC+LZMZJdrh/jbp6xjxXPbfu7mQoZw1
         9FFDwzjaQEwBgHpFErRuJhtuZpovWCG5lNLUk/YMAOHdOBV98J5LW/R2hXDfmBEXxaJw
         mBCvW9kg78efkMcVSJk2CM635D9Uo7beTwWrKTP3HsxkR4LnO7aGlDDlDZc5ncCtBZgU
         geSxxapHPu64Lqc+MD1ofydowU/y2x6tRmgasyllUBX9P77WidVa8dZW4JksjVnc9o0R
         pS9Q==
X-Gm-Message-State: AG10YORrpBENBOu1x2CG3o0j44uURx2r9Pca0e6DuaKzTJsCp7MMDWHpOdol5FNz/lyuXg==
X-Received: by 10.98.13.154 with SMTP id 26mr15883300pfn.164.1455450716788;
        Sun, 14 Feb 2016 03:51:56 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id wh9sm31358494pab.8.2016.02.14.03.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:52:17 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286143>

This function returns true if git is running under an UTF-8
locale. pcre in the next patch will need this.

is_encoding_utf8() is used instead of strcmp() to catch both "utf-8"
and "utf8" suffixes.

When built with no gettext support, we peek in several env variables
to detect UTF-8. pcre library might support utf-8 even if libc is
built without locale support.. The peeking code is a copy from
compat/regex/regcomp.c

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gettext.c | 24 ++++++++++++++++++++++--
 gettext.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gettext.c b/gettext.c
index a268a2c..db727ea 100644
--- a/gettext.c
+++ b/gettext.c
@@ -18,6 +18,8 @@
 #	endif
 #endif
=20
+static const char *charset;
+
 /*
  * Guess the user's preferred languages from the value in LANGUAGE env=
ironment
  * variable and LC_MESSAGES locale category if NO_GETTEXT is not defin=
ed.
@@ -65,7 +67,6 @@ static int test_vsnprintf(const char *fmt, ...)
 	return ret;
 }
=20
-static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
 	/*
@@ -172,8 +173,27 @@ int gettext_width(const char *s)
 {
 	static int is_utf8 =3D -1;
 	if (is_utf8 =3D=3D -1)
-		is_utf8 =3D !strcmp(charset, "UTF-8");
+		is_utf8 =3D is_utf8_locale();
=20
 	return is_utf8 ? utf8_strwidth(s) : strlen(s);
 }
 #endif
+
+int is_utf8_locale(void)
+{
+#ifdef NO_GETTEXT
+	if (!charset) {
+		const char *env =3D getenv("LC_ALL");
+		if (!env || !*env)
+			env =3D getenv("LC_CTYPE");
+		if (!env || !*env)
+			env =3D getenv("LANG");
+		if (!env)
+			env =3D "";
+		if (strchr(env, '.'))
+			env =3D strchr(env, '.') + 1;
+		charset =3D xstrdup(env);
+	}
+#endif
+	return is_encoding_utf8(charset);
+}
diff --git a/gettext.h b/gettext.h
index 33696a4..7eee64a 100644
--- a/gettext.h
+++ b/gettext.h
@@ -90,5 +90,6 @@ const char *Q_(const char *msgid, const char *plu, un=
signed long n)
 #endif
=20
 const char *get_preferred_languages(void);
+extern int is_utf8_locale(void);
=20
 #endif
--=20
2.7.0.377.g4cd97dd
