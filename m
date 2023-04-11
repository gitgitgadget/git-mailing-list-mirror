Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CACC7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 07:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjDKHnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDKHmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA782728
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so9983389pjo.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681198947; x=1683790947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sr0/7loLeIPg/lLlm/vRe8zIQkp16kWFK9iR8b0qkA=;
        b=gPLTgYSSNIw/y7CsPs8q2j0O1q7u9DM1TFaQKTzYrOGkbfqV1cyTnvAewWGdiRg75o
         ueULQrxItlc3YWLErw21szekjd68GWu1AHR/F1uTlaDIxbIUkAueXcXRqgKA7aE7pkNL
         rAjJaHq4eZ//khoWcv9ME523IGOj/ymJPjGAv0ZLRTQaYhGmZF+6RuXzNDNGXWI9BvLR
         5+EFhTV+aNuW4hY+Lj+InNA+R3SbU5ZdD5EfSHNjCdI8iQiki0OWF+i7Hs43mCTWpJJ0
         S71fqKGR1HVa3sOubOWlE2vd3y52Q5IcI2W4QVZSPZlkPg1KNR5ToHvhm4rvkb3N2PPh
         bUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198947; x=1683790947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Sr0/7loLeIPg/lLlm/vRe8zIQkp16kWFK9iR8b0qkA=;
        b=atDBsXegZq4bOeOEfrYxPeht8pW1yNyOLxjUUgutMpNpuKbeXWFEJTqoglFBezXG/K
         HUoIFWD1//JTDyibEwOVXnKCKy19jSDhg2J70GQn/xYv9WmvoZzE4AAypfrGmixundAq
         eNJJWO8flRV8E/8gUNSh2fWaf4BvBRkXNAJGDIHWbXdD2HMWM4IN/8Urk9yqVHeQ2EmT
         qHis3yVhEk0FOOjQxNA9F0z/2P5It02onmFiwnEy4LyUqLU9WD6twlecyNJL2NfdKHGm
         5Ky2gcVtUsPs9eWT8V/U5Z2W422eMWFjlfkh5wP0fEZW81mwRC73VmBDzXhpe/iC7PCR
         QYHA==
X-Gm-Message-State: AAQBX9cOQTdV9mGYQA6iqPrZI7v5kVP8ot/b7oiIGoFPtIkm2CiBIOzz
        gu+dpWowNJvhAiva6APrbK1vaIzUuo0=
X-Google-Smtp-Source: AKy350aIZsJ2eKWE1bUaPF41EcLxPGjr+d1uVHuNBnwGhFNMWSmrHWKdDwjR4xlM9MgodpQJIdzsuQ==
X-Received: by 2002:a17:903:24f:b0:1a4:fe85:ab1a with SMTP id j15-20020a170903024f00b001a4fe85ab1amr2388762plh.44.1681198946958;
        Tue, 11 Apr 2023 00:42:26 -0700 (PDT)
Received: from iron-rod.hsd1.ca.comcast.net ([2601:646:9e80:a0b0::f6a9])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001a1deff606fsm8992820plb.125.2023.04.11.00.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:42:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 16/23] editor: move editor-related functions and declarations into common file
Date:   Tue, 11 Apr 2023 00:41:57 -0700
Message-Id: <20230411074204.3024420-11-newren@gmail.com>
X-Mailer: git-send-email 2.40.0.172.g72fe1174621
In-Reply-To: <20230411074204.3024420-1-newren@gmail.com>
References: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
 <20230411074204.3024420-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cache.h and strbuf.[ch] had editor-related functions.  Move these into
editor.[ch].

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 add-patch.c          |  1 +
 builtin/add.c        |  1 +
 builtin/am.c         |  1 +
 builtin/branch.c     |  1 +
 builtin/bugreport.c  |  1 +
 builtin/commit.c     |  1 +
 builtin/config.c     |  1 +
 builtin/merge.c      |  1 +
 builtin/notes.c      |  1 +
 builtin/replace.c    |  1 +
 builtin/tag.c        |  1 +
 builtin/var.c        |  1 +
 cache.h              |  3 ---
 color.c              |  1 +
 editor.c             | 30 ++++++++++++++++++++++++++++++
 editor.h             | 34 ++++++++++++++++++++++++++++++++++
 pager.c              |  1 +
 rebase-interactive.c |  1 +
 sideband.c           |  1 +
 strbuf.c             | 28 ----------------------------
 strbuf.h             | 24 ------------------------
 21 files changed, 80 insertions(+), 55 deletions(-)
 create mode 100644 editor.h

diff --git a/add-patch.c b/add-patch.c
index b01ba8fa81d..8d770d203ff 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -2,6 +2,7 @@
 #include "add-interactive.h"
 #include "advice.h"
 #include "alloc.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
diff --git a/builtin/add.c b/builtin/add.c
index d3c51e28142..76cc026a68a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "lockfile.h"
+#include "editor.h"
 #include "dir.h"
 #include "gettext.h"
 #include "pathspec.h"
diff --git a/builtin/am.c b/builtin/am.c
index 0d7ee28bddc..f7a065e5290 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -9,6 +9,7 @@
 #include "advice.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 7c1c872708f..1fb11d55e65 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "editor.h"
 #include "environment.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 03fb0536911..daf6c236577 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "abspath.h"
+#include "editor.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "strbuf.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 682f47c8d5a..e67c4be2211 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -13,6 +13,7 @@
 #include "cache-tree.h"
 #include "color.h"
 #include "dir.h"
+#include "editor.h"
 #include "environment.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/config.c b/builtin/config.c
index fe79fb60c43..9401f1e5e3b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "color.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "ident.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 693f185d4d3..8da3e46abb0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -12,6 +12,7 @@
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 896140b9055..d5788352b6e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index f4b3a8efb23..981f1894436 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 88a25902309..7d189a4a5d4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,7 @@
 #include "advice.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/var.c b/builtin/var.c
index d9943be9afd..90616cf65a2 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "editor.h"
 #include "ident.h"
 #include "refs.h"
 
diff --git a/cache.h b/cache.h
index 394e8d01254..97ddf4094a3 100644
--- a/cache.h
+++ b/cache.h
@@ -621,10 +621,7 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-const char *git_editor(void);
-const char *git_sequence_editor(void);
 const char *git_pager(int stdout_is_tty);
-int is_terminal_dumb(void);
 
 struct cache_def {
 	struct strbuf path;
diff --git a/color.c b/color.c
index 672dcbb73a6..a8e8d5202ab 100644
--- a/color.c
+++ b/color.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "editor.h"
 #include "gettext.h"
 #include "hex.h"
 
diff --git a/editor.c b/editor.c
index 3bea3ef72f7..12025dfec37 100644
--- a/editor.c
+++ b/editor.c
@@ -2,12 +2,14 @@
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "wrapper.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -130,3 +132,31 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
 {
 	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
 }
+
+int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+			      const char *const *env)
+{
+	char *path2 = NULL;
+	int fd, res = 0;
+
+	if (!is_absolute_path(path))
+		path = path2 = xstrdup(git_path("%s", path));
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		res = error_errno(_("could not open '%s' for writing"), path);
+	else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
+		res = error_errno(_("could not write to '%s'"), path);
+		close(fd);
+	} else if (close(fd) < 0)
+		res = error_errno(_("could not close '%s'"), path);
+	else {
+		strbuf_reset(buffer);
+		if (launch_editor(path, buffer, env) < 0)
+			res = error_errno(_("could not edit '%s'"), path);
+		unlink(path);
+	}
+
+	free(path2);
+	return res;
+}
diff --git a/editor.h b/editor.h
new file mode 100644
index 00000000000..8016bb5e00b
--- /dev/null
+++ b/editor.h
@@ -0,0 +1,34 @@
+#ifndef EDITOR_H
+#define EDITOR_H
+
+struct strbuf;
+
+const char *git_editor(void);
+const char *git_sequence_editor(void);
+int is_terminal_dumb(void);
+
+/**
+ * Launch the user preferred editor to edit a file and fill the buffer
+ * with the file's contents upon the user completing their editing. The
+ * third argument can be used to set the environment which the editor is
+ * run in. If the buffer is NULL the editor is launched as usual but the
+ * file's contents are not read into the buffer upon completion.
+ */
+int launch_editor(const char *path, struct strbuf *buffer,
+		  const char *const *env);
+
+int launch_sequence_editor(const char *path, struct strbuf *buffer,
+			   const char *const *env);
+
+/*
+ * In contrast to `launch_editor()`, this function writes out the contents
+ * of the specified file first, then clears the `buffer`, then launches
+ * the editor and reads back in the file contents into the `buffer`.
+ * Finally, it deletes the temporary file.
+ *
+ * If `path` is relative, it refers to a file in the `.git` directory.
+ */
+int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+			      const char *const *env);
+
+#endif
diff --git a/pager.c b/pager.c
index b66bbff2785..6367e8ef867 100644
--- a/pager.c
+++ b/pager.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "editor.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "alias.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 6ff12d7be2d..789f4073617 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "commit.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "sequencer.h"
diff --git a/sideband.c b/sideband.c
index 0af582858bf..25e2a185716 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "color.h"
 #include "config.h"
+#include "editor.h"
 #include "gettext.h"
 #include "sideband.h"
 #include "help.h"
diff --git a/strbuf.c b/strbuf.c
index b2e3735ba8a..729378ec824 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1180,34 +1180,6 @@ int strbuf_normalize_path(struct strbuf *src)
 	return 0;
 }
 
-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env)
-{
-	char *path2 = NULL;
-	int fd, res = 0;
-
-	if (!is_absolute_path(path))
-		path = path2 = xstrdup(git_path("%s", path));
-
-	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0)
-		res = error_errno(_("could not open '%s' for writing"), path);
-	else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
-		res = error_errno(_("could not write to '%s'"), path);
-		close(fd);
-	} else if (close(fd) < 0)
-		res = error_errno(_("could not close '%s'"), path);
-	else {
-		strbuf_reset(buffer);
-		if (launch_editor(path, buffer, env) < 0)
-			res = error_errno(_("could not edit '%s'"), path);
-		unlink(path);
-	}
-
-	free(path2);
-	return res;
-}
-
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
 	char *path_sep = find_last_dir_sep(sb->buf);
diff --git a/strbuf.h b/strbuf.h
index b980f9edc6d..3dfeadb44c2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -640,30 +640,6 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
-/**
- * Launch the user preferred editor to edit a file and fill the buffer
- * with the file's contents upon the user completing their editing. The
- * third argument can be used to set the environment which the editor is
- * run in. If the buffer is NULL the editor is launched as usual but the
- * file's contents are not read into the buffer upon completion.
- */
-int launch_editor(const char *path, struct strbuf *buffer,
-		  const char *const *env);
-
-int launch_sequence_editor(const char *path, struct strbuf *buffer,
-			   const char *const *env);
-
-/*
- * In contrast to `launch_editor()`, this function writes out the contents
- * of the specified file first, then clears the `buffer`, then launches
- * the editor and reads back in the file contents into the `buffer`.
- * Finally, it deletes the temporary file.
- *
- * If `path` is relative, it refers to a file in the `.git` directory.
- */
-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env);
-
 /*
  * Remove the filename from the provided path string. If the path
  * contains a trailing separator, then the path is considered a directory
-- 
2.40.0.172.g72fe1174621

