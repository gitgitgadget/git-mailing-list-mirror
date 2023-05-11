Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF16C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjEKTtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbjEKTtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:49:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30A8902D
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e5481a79fso5036144a91.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683834508; x=1686426508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGFHMA9sAR2kIlUALc9uQt1MXlYJJ61dDtMeOeckQsQ=;
        b=ANZTnw3rZM+XVY5aaGxuE0psZq84FlqZUPzCWDIVT+lpsBxKh/hyuW/nhmBVyco97A
         b/kU9TRMcGCI63Fj1G0H6vUFs7Q9naaWmauncnALqUj9SCTHzZw+LDKU2WuWhCVlYHPT
         bahbmi3YuYOC5aVdbkNm/yJsLk+Qm7AptMGiZDrd9XWMIKYvX2LQt2U31ckaGEmaxi6s
         zwngxg9mxrHKFXJ/PYHLwloRRqi0kMShjKmBn8Aoo6x8pMKf7/5XeqoWbcrABGIEAiCu
         ZSiIZwnLvqbWyGNEhhk5UaZ68xVvFUwbHlH6y2tNfBx+MmXB06v4wWp0LWaAeJ8QXC6M
         GpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834508; x=1686426508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGFHMA9sAR2kIlUALc9uQt1MXlYJJ61dDtMeOeckQsQ=;
        b=fjmTO2tITusJ1PdayON2CailZxO4N6Ksj8Gz2ihBTzm+NcWEfO4VUjCLkWVeCbU5SF
         SaQMw5sNpd8qYAJ0lnyHPEynE7I4YLTMJ7ZOJYrOAacEVP4qFQMfWobZ5mt0WXIP0ZZP
         XeeqotZ7eWuZSIuwIUcB428vcGbCM6iyCSkAhYGKIGSkfopQu0IsQhscA/MaWBGi6wra
         RGdbYl7J8JgG1+1lHX7k4XmkXHjmL8zZcP/VJcbhIxPT6dJWakEHjNjOEWZUVYykAr33
         0Wimc4G+ZD9ulKcq1IMubb3YSam3uMzRxawAonb1bUjLMHen1ZodGl1yeTlZr+bXwUO3
         yHwQ==
X-Gm-Message-State: AC+VfDwD5cwm4Cc5HjPuzEEBMCFaOhSmlEC1JSBPW0jaelPP1urA+ukU
        0XLdc/5aRFSyEvT0+5DqaIYOiC2JGvC6h+JbbZrEhC+SY30s8ASNTLp0rL0GJdMBW1cXq4T+/i1
        FiKSDk4Buf2XtH/tzpQa4sEzoqafD7ljEpxQ4Q5hzfOhhsJglD8ULfqkWKbNtt+iYCw==
X-Google-Smtp-Source: ACHHUZ6zWZy9UFKgBolCZIVsQH+DYB1SE1kZa0ac/2R4xSUIqP+C2lmwlabbNBv7JrY+kqG0tNJEDyeOSXJabWo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:4007:b0:24d:df34:a8f5 with SMTP
 id ie7-20020a17090b400700b0024ddf34a8f5mr6491040pjb.5.1683834508162; Thu, 11
 May 2023 12:48:28 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:17 +0000
In-Reply-To: <20230511194446.1492907-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511194822.1493798-2-calvinwan@google.com>
Subject: [PATCH v5 2/7] abspath: move related functions to abspath
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net,
        phillip.wood123@gmail.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move abspath-related functions from strbuf.[ch] to abspath.[ch] so that
strbuf is focused on string manipulation routines with minimal
dependencies.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 abspath.c  | 36 ++++++++++++++++++++++++++++++++++++
 abspath.h  | 21 +++++++++++++++++++++
 hook.c     |  1 +
 strbuf.c   | 37 -------------------------------------
 strbuf.h   | 22 ----------------------
 tempfile.c |  1 +
 6 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/abspath.c b/abspath.c
index d032f5dce5..1202cde23d 100644
--- a/abspath.c
+++ b/abspath.c
@@ -289,3 +289,39 @@ char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
 		return xstrdup(arg);
 	return prefix_filename(pfx, arg);
 }
+
+void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
+{
+	if (!*path)
+		die("The empty string is not a valid path");
+	if (!is_absolute_path(path)) {
+		struct stat cwd_stat, pwd_stat;
+		size_t orig_len = sb->len;
+		char *cwd = xgetcwd();
+		char *pwd = getenv("PWD");
+		if (pwd && strcmp(pwd, cwd) &&
+		    !stat(cwd, &cwd_stat) &&
+		    (cwd_stat.st_dev || cwd_stat.st_ino) &&
+		    !stat(pwd, &pwd_stat) &&
+		    pwd_stat.st_dev == cwd_stat.st_dev &&
+		    pwd_stat.st_ino == cwd_stat.st_ino)
+			strbuf_addstr(sb, pwd);
+		else
+			strbuf_addstr(sb, cwd);
+		if (sb->len > orig_len && !is_dir_sep(sb->buf[sb->len - 1]))
+			strbuf_addch(sb, '/');
+		free(cwd);
+	}
+	strbuf_addstr(sb, path);
+}
+
+void strbuf_add_real_path(struct strbuf *sb, const char *path)
+{
+	if (sb->len) {
+		struct strbuf resolved = STRBUF_INIT;
+		strbuf_realpath(&resolved, path, 1);
+		strbuf_addbuf(sb, &resolved);
+		strbuf_release(&resolved);
+	} else
+		strbuf_realpath(sb, path, 1);
+}
diff --git a/abspath.h b/abspath.h
index 7cd3de5e9d..4653080d5e 100644
--- a/abspath.h
+++ b/abspath.h
@@ -30,4 +30,25 @@ static inline int is_absolute_path(const char *path)
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
 
+/**
+ * Add a path to a buffer, converting a relative path to an
+ * absolute one in the process.  Symbolic links are not
+ * resolved.
+ */
+void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
+
+/**
+ * Canonize `path` (make it absolute, resolve symlinks, remove extra
+ * slashes) and append it to `sb`.  Die with an informative error
+ * message if there is a problem.
+ *
+ * The directory part of `path` (i.e., everything up to the last
+ * dir_sep) must denote a valid, existing directory, but the last
+ * component need not exist.
+ *
+ * Callers that don't mind links should use the more lightweight
+ * strbuf_add_absolute_path() instead.
+ */
+void strbuf_add_real_path(struct strbuf *sb, const char *path);
+
 #endif /* ABSPATH_H */
diff --git a/hook.c b/hook.c
index 76e322f580..2d8706371e 100644
--- a/hook.c
+++ b/hook.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "gettext.h"
 #include "hook.h"
diff --git a/strbuf.c b/strbuf.c
index 729378ec82..c3b6d48797 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "abspath.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
@@ -899,42 +898,6 @@ void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
 	strbuf_humanise(buf, bytes, 1);
 }
 
-void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
-{
-	if (!*path)
-		die("The empty string is not a valid path");
-	if (!is_absolute_path(path)) {
-		struct stat cwd_stat, pwd_stat;
-		size_t orig_len = sb->len;
-		char *cwd = xgetcwd();
-		char *pwd = getenv("PWD");
-		if (pwd && strcmp(pwd, cwd) &&
-		    !stat(cwd, &cwd_stat) &&
-		    (cwd_stat.st_dev || cwd_stat.st_ino) &&
-		    !stat(pwd, &pwd_stat) &&
-		    pwd_stat.st_dev == cwd_stat.st_dev &&
-		    pwd_stat.st_ino == cwd_stat.st_ino)
-			strbuf_addstr(sb, pwd);
-		else
-			strbuf_addstr(sb, cwd);
-		if (sb->len > orig_len && !is_dir_sep(sb->buf[sb->len - 1]))
-			strbuf_addch(sb, '/');
-		free(cwd);
-	}
-	strbuf_addstr(sb, path);
-}
-
-void strbuf_add_real_path(struct strbuf *sb, const char *path)
-{
-	if (sb->len) {
-		struct strbuf resolved = STRBUF_INIT;
-		strbuf_realpath(&resolved, path, 1);
-		strbuf_addbuf(sb, &resolved);
-		strbuf_release(&resolved);
-	} else
-		strbuf_realpath(sb, path, 1);
-}
-
 int printf_ln(const char *fmt, ...)
 {
 	int ret;
diff --git a/strbuf.h b/strbuf.h
index 0256114002..e1c0c326f2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -536,28 +536,6 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
  */
 int strbuf_getcwd(struct strbuf *sb);
 
-/**
- * Add a path to a buffer, converting a relative path to an
- * absolute one in the process.  Symbolic links are not
- * resolved.
- */
-void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
-
-/**
- * Canonize `path` (make it absolute, resolve symlinks, remove extra
- * slashes) and append it to `sb`.  Die with an informative error
- * message if there is a problem.
- *
- * The directory part of `path` (i.e., everything up to the last
- * dir_sep) must denote a valid, existing directory, but the last
- * component need not exist.
- *
- * Callers that don't mind links should use the more lightweight
- * strbuf_add_absolute_path() instead.
- */
-void strbuf_add_real_path(struct strbuf *sb, const char *path);
-
-
 /**
  * Normalize in-place the path contained in the strbuf. See
  * normalize_path_copy() for details. If an error occurs, the contents of "sb"
diff --git a/tempfile.c b/tempfile.c
index 50c377134c..6c88a63b42 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -43,6 +43,7 @@
  */
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "path.h"
 #include "tempfile.h"
 #include "sigchain.h"
-- 
2.40.1.606.ga4b1b128d6-goog

