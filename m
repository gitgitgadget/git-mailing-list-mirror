From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/41] Add and use error_errno() and warning_errno()
Date: Tue,  3 May 2016 19:03:33 +0700
Message-ID: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:06:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ5m-0007yn-MA
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbcECMGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 08:06:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33556 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbcECMGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id xk12so8961564pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kVFrEAgGRUMenp1B5B9FfONjsTP7YIvoPyI0Nh1z9k=;
        b=EFNqY5aav9g/oGFdTfXR6Y6IQWNmYn8+5KjMh0tJlQFxO4dhr+PNYF8or14GNCWZc1
         /hTYug+iaubcIAAYm1Lzq6VO0dc/BK0Csyfj1ZyEMl86URbj2/GB7Tlede+1Iw91DYLQ
         GRxL/xhlSZOW4aHiySOHWypYNCcAx4vD4qGpzYPCLUP+HQV6nZJu9SA559gij8SICSZ2
         HDKzUWWaSsg3dz8FDKfQFHH7pIIxQbkksQJXE51okr9oqpSTFdji0tZeZVttEzO2RpzK
         bzhATMHTspR+IwLDpFVbEcTpLHzJFXs6NHXNCmaQRTwajI9RY2B7pN9ZwmWuJRNPMzJO
         5ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kVFrEAgGRUMenp1B5B9FfONjsTP7YIvoPyI0Nh1z9k=;
        b=VBSL8wXht+OhX9wkftutJJDgG6ahZaerXXmQtA8ARh+k9TBSEQRRBKWf0FaGQ5MqlJ
         Zcz5ljHP41SEVFd0yuggNgEptNl9aYCfNYYZ2XMI5fEtAfHSKpvuFVPQiyxiUOrEEKjI
         p9lIsJNg4J7nxFz07K3gPS2OkGXAyeG6KlxJ9yQPr8UrUAMlk/pHV0ItmLPj9wrdSihM
         KEzO7wYCgeZHQHKaiLk8YO5HOvnW5L8ZIePvSD0wumNrfDjq48j17BAQiUxxo7n+59mI
         +1XZb5y1uL9f06jzEy108eGKjQ5bI+1oPS7xkTWnm2O1sZjNtTR3pU1rywjc0CC0oKGu
         aWJA==
X-Gm-Message-State: AOPr4FUKMkB0XP4ayTVKMGLBkf8RQGTKQqwVJ4EaIxIjkkrBVOUKfQ7QN2oN1gqhXA6I+A==
X-Received: by 10.66.123.105 with SMTP id lz9mr2856157pab.37.1462277173032;
        Tue, 03 May 2016 05:06:13 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 5sm5490900pfn.46.2016.05.03.05.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:08 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293353>

Changes are in

  [01/41] usage.c: move format processing out of die_errno()
  [02/41] usage.c: add warning_errno() and error_errno()
  [12/41] builtin/update-index.c: prefer "err" to "errno" in process_lstat_error
  [17/41] compat/win32/syslog.c: use warning_errno()
  [27/41] grep.c: use error_errno()

12/41 is basically a revert with s/strerror(errno)/strerror(err)/.
Interdiff from v1

-- 8< --
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 0c539ed..b8b8522 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -251,11 +251,11 @@ static int remove_one_path(const char *path)
  *    succeeds.
  *  - permission error. That's never ok.
  */
-static int process_lstat_error(const char *path)
+static int process_lstat_error(const char *path, int err)
 {
-	if (errno == ENOENT || errno == ENOTDIR)
+	if (err == ENOENT || err == ENOTDIR)
 		return remove_one_path(path);
-	return error_errno("lstat(\"%s\")", path);
+	return error("lstat(\"%s\"): %s", path, strerror(err));
 }
 
 static int add_one_path(const struct cache_entry *old, const char *path, int len, struct stat *st)
@@ -382,7 +382,7 @@ static int process_path(const char *path)
 	 * what to do about the pathname!
 	 */
 	if (lstat(path, &st) < 0)
-		return process_lstat_error(path);
+		return process_lstat_error(path, errno);
 
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 1c2ae18..6c7c9b6 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -28,7 +28,7 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
 
 	if (str_len < 0) {
-		warning_errno("vsnprintf failed:");
+		warning_errno("vsnprintf failed");
 		return;
 	}
 
diff --git a/grep.c b/grep.c
index 87c1890..4f3779a 100644
--- a/grep.c
+++ b/grep.c
@@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_source *gs)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno != ENOENT)
-			error_errno(_("'%s'"), filename);
+			error_errno("'%s'", filename);
 		return -1;
 	}
 	if (!S_ISREG(st.st_mode))
diff --git a/usage.c b/usage.c
index af1b7d1..1dad03f 100644
--- a/usage.c
+++ b/usage.c
@@ -109,9 +109,8 @@ void NORETURN die(const char *err, ...)
 	va_end(params);
 }
 
-static const char *fmt_with_err(const char *fmt)
+static const char *fmt_with_err(char *buf, int n, const char *fmt)
 {
-	static char fmt_with_err[1024];
 	char str_error[256], *err;
 	int i, j;
 
@@ -129,12 +128,13 @@ static const char *fmt_with_err(const char *fmt)
 		}
 	}
 	str_error[j] = 0;
-	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
-	return fmt_with_err;
+	snprintf(buf, n, "%s: %s", fmt, str_error);
+	return buf;
 }
 
 void NORETURN die_errno(const char *fmt, ...)
 {
+	char buf[1024];
 	va_list params;
 
 	if (die_is_recursing()) {
@@ -144,16 +144,17 @@ void NORETURN die_errno(const char *fmt, ...)
 	}
 
 	va_start(params, fmt);
-	die_routine(fmt_with_err(fmt), params);
+	die_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
 	va_end(params);
 }
 
 int error_errno(const char *fmt, ...)
 {
+	char buf[1024];
 	va_list params;
 
 	va_start(params, fmt);
-	error_routine(fmt_with_err(fmt), params);
+	error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
 	va_end(params);
 	return -1;
 }
@@ -171,10 +172,11 @@ int error(const char *err, ...)
 
 void warning_errno(const char *warn, ...)
 {
+	char buf[1024];
 	va_list params;
 
 	va_start(params, warn);
-	warn_routine(fmt_with_err(warn), params);
+	warn_routine(fmt_with_err(buf, sizeof(buf), warn), params);
 	va_end(params);
 }
 
-- 8< --
--
Duy
