Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8722FC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjELRPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjELRPa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:15:30 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FADB5BBB
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-521262a6680so9391753a12.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911728; x=1686503728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFnto0lEqgjlzV9dZokGGsuipGyhoS/4Y7HPxI0S80s=;
        b=aaJ5hx9YFgabGhHkVKzHqbbLSvIZuTE5/Hr7MX/ag9yPLQk6VngENv7is1tiOBkYhQ
         NinL3ymwHPOSOF0VvQUU9FQYRzOkK7rGkElp2bbbQX9pT9Ax9lT0tNGCeE+x8SpqHrLw
         S2/Ldac64+T9Si0RPOIefJd+XQW4quJGJ2FKGpvgOSBEqr6d9p7X5BTBkbjrpyD0dBBf
         Ynho9h/94ZEqyEX2YHxuaRPiv11P73VY/3l+iUiCg/pzjB9jbVkB9gxBphqx8BLnlcw5
         D6nFPl+O9Ia917z85EhSoC1I0fB/zXIa/E7lp0ZXxX1K+C4cE2lvuLi/BmYy3yHayMAk
         EAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911728; x=1686503728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFnto0lEqgjlzV9dZokGGsuipGyhoS/4Y7HPxI0S80s=;
        b=Li3/Hzt7v9euLRyham0lx8Qu0wlGx/Jmbc+gP1P5qdG9Gr0l2e91kVcD2TNqtljw+S
         /o86D5s+pUnvBc+dTQt+I9dgLYvGVuUGVVc2Aa/3yGNUsR27WSsnAdHN6jFtL8wxb5jU
         pKD9u2XT/4Ee/BkVsdX6q6jeoMFVOI/UcDB1qStTD+VqKWqw8c1ZAxfBcX1p2uIK1iIo
         0H6o6E/UkvH2tyJix7SAYh3e8YtiR4W78QWNWk7O3wLQVvPSH9uc/azC0O7ArQYizPZ3
         lXvV2S+7hRcp9QepJSh1/ShzY/tBAZEx3tJoB7xXOcUF5HCgLAShxz+Vds0m5Ow22sbf
         D8ng==
X-Gm-Message-State: AC+VfDw0qJ7w8t+DC8rXQp9Kcgbx7QwFOlsL/aj7OHD6BtdEYW9fULjD
        Pju7uVCdEa6/0/wjrfwE+fiDN7hr9ox98j+nC5Sw/wRvxVYn+spg8jql+ibNkiEwMikzQFpXx9a
        15rwC2/uM5nz+q65hm65raWEobnZssMnFzwcpMmwKuGorVqx/jFh4d/JqTw5iRNLZ/A==
X-Google-Smtp-Source: ACHHUZ57LBePpV+wBnxqCKCiYTb/+nimKCXflSV8y0Ju0ht8uNWcwBpfF6eScZnHglWEGMXmOiUAudXYhcdC4zY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:e98:b0:24d:f3d9:48b5 with SMTP
 id fv24-20020a17090b0e9800b0024df3d948b5mr7692968pjb.3.1683911728442; Fri, 12
 May 2023 10:15:28 -0700 (PDT)
Date:   Fri, 12 May 2023 17:15:11 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171516.2203472-2-calvinwan@google.com>
Subject: [PATCH v6 2/7] abspath: move related functions to abspath
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
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
index 70778c6e10..207efb4f98 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -535,28 +535,6 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
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

