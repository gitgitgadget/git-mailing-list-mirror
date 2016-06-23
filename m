Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D252F2018A
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbcFWQ3w (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34273 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbcFWQ3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:39 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so18868659lfl.1
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAxaui0iu007NHWdbv4DgTLXkiybkzQYgCtu2RpIaS8=;
        b=ON44xCJN/7tmNbPeyaIKkBk6BRQVmHXGkLmJO1xb9y2RnUVq4ZfMSWCMISNN2HkRco
         eUIY+OKaPwK8LXvrMzXIN6O5c87S7DqNrNmRyZKA/871wVJsKeERwkHmJlMLiTXQvP+u
         MUMgbX7AneuhtyLsiDdf+iJgl0cuqO0oGdMbVZB23bXGjhe8EuAr5CFfpoJGppNfksbT
         w33ywW6LfJxW96hJG++BqoXyvieR8e+mpMFlxbbJXSzylIK1HobDqDV7YZHcS76YosJ2
         DqC+wH1BaYo2PRto7XVMDLIwbWyenFQD/70TNJlaH6TPqSl4CD33/C+2sHUGNzNhdhsp
         uBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAxaui0iu007NHWdbv4DgTLXkiybkzQYgCtu2RpIaS8=;
        b=G7cKt6dwKMrJ1RrIdI1g6rqlVhxekVTmp8oglQwmXLMWsNQLygffCF7Fj++w8WG8ne
         EkTDv2+q7/+dUFIJdVvQdeP+9AYnaAwPx4RTm+58yYqKc1fmdDR04h9k7ddribnF9JBL
         lN+QaKqqUtR41nJRgj+qKL+kruarwO2spUy4b/buRNeYOB+NROQ+Jt4PbDkeQXP0BLt4
         nC/J8Q23Rkl9Ls+6NdmJDhRmtVjEmU6j17XO8Yfu8iS7zDCiI0Ra71odrLlB4OABT5po
         4BiCm2wqReY7TvGy5ZmNXVttTQBHYuXlCfGVNy/b8b68EPDbzaDCHYeJTaJxdpMZTBKj
         9BWw==
X-Gm-Message-State: ALyK8tJ80VDpw3MhV9/3AhWSf/LAtvwX4muKRULAXhnaZjMzkXDnbJ3RqzoR5X3XvX2NDg==
X-Received: by 10.25.166.129 with SMTP id p123mr12766374lfe.40.1466699376723;
        Thu, 23 Jun 2016 09:29:36 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:35 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/11] gettext: add is_utf8_locale()
Date:	Thu, 23 Jun 2016 18:29:03 +0200
Message-Id: <20160623162907.23295-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function returns true if git is running under an UTF-8
locale. pcre in the next patch will need this.

is_encoding_utf8() is used instead of strcmp() to catch both "utf-8"
and "utf8" suffixes.

When built with no gettext support, we peek in several env variables
to detect UTF-8. pcre library might support utf-8 even if libc is
built without locale support.. The peeking code is a copy from
compat/regex/regcomp.c

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
 
+static const char *charset;
+
 /*
  * Guess the user's preferred languages from the value in LANGUAGE environment
  * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
@@ -65,7 +67,6 @@ static int test_vsnprintf(const char *fmt, ...)
 	return ret;
 }
 
-static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
 	/*
@@ -172,8 +173,27 @@ int gettext_width(const char *s)
 {
 	static int is_utf8 = -1;
 	if (is_utf8 == -1)
-		is_utf8 = !strcmp(charset, "UTF-8");
+		is_utf8 = is_utf8_locale();
 
 	return is_utf8 ? utf8_strwidth(s) : strlen(s);
 }
 #endif
+
+int is_utf8_locale(void)
+{
+#ifdef NO_GETTEXT
+	if (!charset) {
+		const char *env = getenv("LC_ALL");
+		if (!env || !*env)
+			env = getenv("LC_CTYPE");
+		if (!env || !*env)
+			env = getenv("LANG");
+		if (!env)
+			env = "";
+		if (strchr(env, '.'))
+			env = strchr(env, '.') + 1;
+		charset = xstrdup(env);
+	}
+#endif
+	return is_encoding_utf8(charset);
+}
diff --git a/gettext.h b/gettext.h
index 33696a4..7eee64a 100644
--- a/gettext.h
+++ b/gettext.h
@@ -90,5 +90,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 #endif
 
 const char *get_preferred_languages(void);
+extern int is_utf8_locale(void);
 
 #endif
-- 
2.8.2.526.g02eed6d

