Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D56C7EE37
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjFFTtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjFFTs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177418E
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6530a0823d8so1635146b3a.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080930; x=1688672930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKwO+A+pzoDvN+IgHHmp+Gqw0htYhDVzxEzOCQqikIg=;
        b=xaCMP91cI2TuynuZ20ggMDoUaSJs/xEgVIiByX93webYTfJIZy4ywSOFVat3NByseD
         lJGKkI8Peohbfldry10aPQFSUZbIMoUOi3hWUh+soGQ3Q/h8SUM0WayiCFCUFobFI6Fu
         akvItkwynZ8Et+EKE3OEJNSHYjvcBA+0IBBXHk27NiF5Mpx51dVniRa7iNuc+AB4K9Pn
         0PzERFE7Fubad1iOSMJBAmNg1DsVlG7RGuhuP/c/wPQlwrMyQbGn8IXAFhdYG3tNbFrO
         6fTF4kQLovSrbB4SUKeWV80WxFfq3HKLLBFDdZblaKX+ixpwcy8Cv7mhYXd4yHtj9IFg
         O1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080930; x=1688672930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKwO+A+pzoDvN+IgHHmp+Gqw0htYhDVzxEzOCQqikIg=;
        b=mAB/02v5G4wknqPYUSQrhQhUX7lvr0CAfy7v0h/fxiI0vTKwypGY7xzGV1s29mB73r
         KjgYvKlKjrCK3bpMp2XpySQg2r/MtIPJkCCQqexqHWG6fcycGO3OzkxXSByFgK1FyC/L
         QQBd0OS+uap3y/UZOzqlGspPuVApv6oa9BdXX9GqfdltGbdRJwPhRVmZqvsoqMTUnNSp
         ytHYSsXBsyQ88tyJexh3G03w3560bNGnqu9kg1W+6rVxYPFBmDIiM3lXq42pFp90ur8e
         ngDzleaMK8BLAuXAf/T6MAjI8N8t+1/R+PXeEMCIqgS2dvW1j9R+1tjdLO88aWfnZSNj
         ksaQ==
X-Gm-Message-State: AC+VfDxoXv1sMiL/zDeJbpuzL7U8jg4msoh60c+s9KPbTu/61tB0r0b+
        VoUC8g0gaCmvDjW+1DSTMw2B/l+X14L5H/juhLHccMhKvnWFTGQeAcbSx2UwFruIP89aoSASqem
        mdchzvwIgErhnbG8tzy7GS5biQshVzTuHv36ni0NXzciOzS+UuSndlA3fHW622TKbqg==
X-Google-Smtp-Source: ACHHUZ4AgnsjHKnqx3Jay+zdEBvKyO8tHIgtmeY+IzAPwb6Btf6SZQCn3lHuBF4qkpLcbCUp5k/NzhF3AVwRtUM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2d24:b0:64f:4614:e0a1 with SMTP
 id fa36-20020a056a002d2400b0064f4614e0a1mr1133960pfb.3.1686080930050; Tue, 06
 Jun 2023 12:48:50 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:39 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-3-calvinwan@google.com>
Subject: [PATCH v7 3/7] abspath: move related functions to abspath
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
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
index 3ca5e60895..f6306d72b3 100644
--- a/hook.c
+++ b/hook.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "gettext.h"
 #include "hook.h"
diff --git a/strbuf.c b/strbuf.c
index f5dfd093a0..a2249ae7ed 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "abspath.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
@@ -900,42 +899,6 @@ void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
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
2.41.0.162.gfafddb0af9-goog

