Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B2EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGERJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGERJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:09:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177021996
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:09:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573cacf4804so67995897b3.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688576982; x=1691168982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPW0S1pVZ7gd/csz0VOSB2FkfCYxgxeMOYElZW3D0FI=;
        b=2qubk2v4YCwYdvurNVUCWYTNmlI10hRWW6Q0lLkVhoomlBk9vfLeAssT/Mu9h1Re8g
         Oml+4OBLsJEMNUVENMN71OMYNEAsgr7DijbqsBmNjaUQiU8rB+otH6b/KZxb/iWqWhA5
         NbtE1Q1GFW7UHvfDuvh8JAHwtrm7Ruq6+IfWjxuylFMT7A/dsGfN4aF1hgF1eYzPQxSw
         2ld1SOr8f7HN9ST2Buoj+87UBvGCG9O4gwdEZNGpo5Z9Q4p5HFF714IKLoetgTbA/7A3
         3UkcHex3n1g/CUo9uSvXWzWP0WaVaJifG4Bk9jmIPNJuWVml3LDd82blCEuH5DxYwbpE
         1sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576982; x=1691168982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPW0S1pVZ7gd/csz0VOSB2FkfCYxgxeMOYElZW3D0FI=;
        b=ermw7kGM/hgAUekOU1/vZFJ/kyRKgAqGRNeJBY2PcC/Q4Lspmd8ntopvkFkAJfkhIO
         wTtAMGNL998TbS7ZlQ8pb1wHU56y9vzrxDBQYcO/Xt4ugKTEV1Vw9cvzAZgGNBHLlePD
         LqiKeIF35qjwwNVk6WZv01nYGzXyfgXcycykLvVhKQG4T+PjkxxGmTq5MTctf3qwsDFo
         3FTkoVG94YCjrjkcUOkygnpphA1rYX5ajZR2RMq/BYlcxklYs5Sn+MUQLR5WhQ9KbLMi
         9a/OF2MTYnkNB2K5xA/8Zb9dn5RxwnIWFXfuKN25bZpgp78vVdZ7HT55hLtqW4//g4YM
         Wjgg==
X-Gm-Message-State: ABy/qLYImi50zUibIA6o3+QDDyRjb+9TQhwAl7yA7sCnyhliCeV7b4DM
        zEGrF4CR2GncBePr8sl1DEhUfYOF/bpWjR6/yZgz5HpRKDqKBYUPV6Oh+jQdorM3dTtWELxAfX8
        q6xC8jbaV6TfEVNt+LGDHXP+RbKf2fYR59uXxYIIqKch5WHYkjfK4+i05HWNDG4duCw==
X-Google-Smtp-Source: APBJJlEHEE4y8U1u/bWMcej0Rb66UP8/3JDb7NnTKQhMHuaj709BxlnRB1rzOxXCweuCjOW7cRWE0/dSyXtF5s8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:b321:0:b0:c65:8983:ac2 with SMTP id
 l33-20020a25b321000000b00c6589830ac2mr5848ybj.5.1688576982272; Wed, 05 Jul
 2023 10:09:42 -0700 (PDT)
Date:   Wed,  5 Jul 2023 17:09:20 +0000
In-Reply-To: <20230705170812.3833103-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230705170812.3833103-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705170924.3833828-2-calvinwan@google.com>
Subject: [PATCH v5 2/6] git-compat-util: move wrapper.c funcs to its header
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the functions in wrapper.c are widely used across the codebase,
include it by default in git-compat-util.h. A future patch will remove
now unnecessary inclusions of wrapper.h from other files.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 git-compat-util.h | 112 +---------------------------------------------
 wrapper.h         | 111 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 111 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 78a993c604..9140f43bbf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -627,7 +627,7 @@ static inline int git_has_dir_sep(const char *path)
 
 #include "compat/bswap.h"
 
-struct strbuf;
+#include "wrapper.h"
 
 /* General helper functions */
 NORETURN void usage(const char *err);
@@ -1047,36 +1047,6 @@ static inline int cast_size_t_to_int(size_t a)
 # define xalloca(size)      (xmalloc(size))
 # define xalloca_free(p)    (free(p))
 #endif
-char *xstrdup(const char *str);
-void *xmalloc(size_t size);
-void *xmallocz(size_t size);
-void *xmallocz_gently(size_t size);
-void *xmemdupz(const void *data, size_t len);
-char *xstrndup(const char *str, size_t len);
-void *xrealloc(void *ptr, size_t size);
-void *xcalloc(size_t nmemb, size_t size);
-void xsetenv(const char *name, const char *value, int overwrite);
-void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-const char *mmap_os_err(void);
-void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-int xopen(const char *path, int flags, ...);
-ssize_t xread(int fd, void *buf, size_t len);
-ssize_t xwrite(int fd, const void *buf, size_t len);
-ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
-int xdup(int fd);
-FILE *xfopen(const char *path, const char *mode);
-FILE *xfdopen(int fd, const char *mode);
-int xmkstemp(char *temp_filename);
-int xmkstemp_mode(char *temp_filename, int mode);
-char *xgetcwd(void);
-FILE *fopen_for_writing(const char *path);
-FILE *fopen_or_warn(const char *path, const char *mode);
-
-/*
- * Like strncmp, but only return zero if s is NUL-terminated and exactly len
- * characters long.  If it is not, consider it greater than t.
- */
-int xstrncmpz(const char *s, const char *t, size_t len);
 
 /*
  * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
@@ -1178,15 +1148,10 @@ static inline size_t xsize_t(off_t len)
 	return (size_t) len;
 }
 
-__attribute__((format (printf, 3, 4)))
-int xsnprintf(char *dst, size_t max, const char *fmt, ...);
-
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
 
-int xgethostname(char *buf, size_t len);
-
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
@@ -1427,72 +1392,6 @@ void bug_fl(const char *file, int line, const char *fmt, ...);
 #endif
 #endif
 
-enum fsync_action {
-	FSYNC_WRITEOUT_ONLY,
-	FSYNC_HARDWARE_FLUSH
-};
-
-/*
- * Issues an fsync against the specified file according to the specified mode.
- *
- * FSYNC_WRITEOUT_ONLY attempts to use interfaces available on some operating
- * systems to flush the OS cache without issuing a flush command to the storage
- * controller. If those interfaces are unavailable, the function fails with
- * ENOSYS.
- *
- * FSYNC_HARDWARE_FLUSH does an OS writeout and hardware flush to ensure that
- * changes are durable. It is not expected to fail.
- */
-int git_fsync(int fd, enum fsync_action action);
-
-/*
- * Writes out trace statistics for fsync using the trace2 API.
- */
-void trace_git_fsync_stats(void);
-
-/*
- * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Returns 0 on success, which includes trying to unlink an object that does
- * not exist.
- */
-int unlink_or_warn(const char *path);
- /*
-  * Tries to unlink file.  Returns 0 if unlink succeeded
-  * or the file already didn't exist.  Returns -1 and
-  * appends a message to err suitable for
-  * 'error("%s", err->buf)' on error.
-  */
-int unlink_or_msg(const char *file, struct strbuf *err);
-/*
- * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Returns 0 on success, which includes trying to remove a directory that does
- * not exist.
- */
-int rmdir_or_warn(const char *path);
-/*
- * Calls the correct function out of {unlink,rmdir}_or_warn based on
- * the supplied file mode.
- */
-int remove_or_warn(unsigned int mode, const char *path);
-
-/*
- * Call access(2), but warn for any error except "missing file"
- * (ENOENT or ENOTDIR).
- */
-#define ACCESS_EACCES_OK (1U << 0)
-int access_or_warn(const char *path, int mode, unsigned flag);
-int access_or_die(const char *path, int mode, unsigned flag);
-
-/* Warn on an inaccessible file if errno indicates this is an error */
-int warn_on_fopen_errors(const char *path);
-
-/*
- * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
- * may be racy. Do not use this as protection against an attacker who can
- * simultaneously create paths.
- */
-int open_nofollow(const char *path, int flags);
-
 #ifndef SHELL_PATH
 # define SHELL_PATH "/bin/sh"
 #endif
@@ -1632,13 +1531,4 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
-void sleep_millisec(int millisec);
-
-/*
- * Generate len bytes from the system cryptographically secure PRNG.
- * Returns 0 on success and -1 on error, setting errno.  The inability to
- * satisfy the full request is an error.
- */
-int csprng_bytes(void *buf, size_t len);
-
 #endif
diff --git a/wrapper.h b/wrapper.h
index f0c7d0616d..c85b1328d1 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -1,6 +1,42 @@
 #ifndef WRAPPER_H
 #define WRAPPER_H
 
+char *xstrdup(const char *str);
+void *xmalloc(size_t size);
+void *xmallocz(size_t size);
+void *xmallocz_gently(size_t size);
+void *xmemdupz(const void *data, size_t len);
+char *xstrndup(const char *str, size_t len);
+void *xrealloc(void *ptr, size_t size);
+void *xcalloc(size_t nmemb, size_t size);
+void xsetenv(const char *name, const char *value, int overwrite);
+void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+const char *mmap_os_err(void);
+void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+int xopen(const char *path, int flags, ...);
+ssize_t xread(int fd, void *buf, size_t len);
+ssize_t xwrite(int fd, const void *buf, size_t len);
+ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
+int xdup(int fd);
+FILE *xfopen(const char *path, const char *mode);
+FILE *xfdopen(int fd, const char *mode);
+int xmkstemp(char *temp_filename);
+int xmkstemp_mode(char *temp_filename, int mode);
+char *xgetcwd(void);
+FILE *fopen_for_writing(const char *path);
+FILE *fopen_or_warn(const char *path, const char *mode);
+
+/*
+ * Like strncmp, but only return zero if s is NUL-terminated and exactly len
+ * characters long.  If it is not, consider it greater than t.
+ */
+int xstrncmpz(const char *s, const char *t, size_t len);
+
+__attribute__((format (printf, 3, 4)))
+int xsnprintf(char *dst, size_t max, const char *fmt, ...);
+
+int xgethostname(char *buf, size_t len);
+
 /* set default permissions by passing mode arguments to open(2) */
 int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
@@ -33,4 +69,79 @@ void write_file(const char *path, const char *fmt, ...);
 /* Return 1 if the file is empty or does not exists, 0 otherwise. */
 int is_empty_or_missing_file(const char *filename);
 
+enum fsync_action {
+	FSYNC_WRITEOUT_ONLY,
+	FSYNC_HARDWARE_FLUSH
+};
+
+/*
+ * Issues an fsync against the specified file according to the specified mode.
+ *
+ * FSYNC_WRITEOUT_ONLY attempts to use interfaces available on some operating
+ * systems to flush the OS cache without issuing a flush command to the storage
+ * controller. If those interfaces are unavailable, the function fails with
+ * ENOSYS.
+ *
+ * FSYNC_HARDWARE_FLUSH does an OS writeout and hardware flush to ensure that
+ * changes are durable. It is not expected to fail.
+ */
+int git_fsync(int fd, enum fsync_action action);
+
+/*
+ * Writes out trace statistics for fsync using the trace2 API.
+ */
+void trace_git_fsync_stats(void);
+
+/*
+ * Preserves errno, prints a message, but gives no warning for ENOENT.
+ * Returns 0 on success, which includes trying to unlink an object that does
+ * not exist.
+ */
+int unlink_or_warn(const char *path);
+ /*
+  * Tries to unlink file.  Returns 0 if unlink succeeded
+  * or the file already didn't exist.  Returns -1 and
+  * appends a message to err suitable for
+  * 'error("%s", err->buf)' on error.
+  */
+int unlink_or_msg(const char *file, struct strbuf *err);
+/*
+ * Preserves errno, prints a message, but gives no warning for ENOENT.
+ * Returns 0 on success, which includes trying to remove a directory that does
+ * not exist.
+ */
+int rmdir_or_warn(const char *path);
+/*
+ * Calls the correct function out of {unlink,rmdir}_or_warn based on
+ * the supplied file mode.
+ */
+int remove_or_warn(unsigned int mode, const char *path);
+
+/*
+ * Call access(2), but warn for any error except "missing file"
+ * (ENOENT or ENOTDIR).
+ */
+#define ACCESS_EACCES_OK (1U << 0)
+int access_or_warn(const char *path, int mode, unsigned flag);
+int access_or_die(const char *path, int mode, unsigned flag);
+
+/* Warn on an inaccessible file if errno indicates this is an error */
+int warn_on_fopen_errors(const char *path);
+
+/*
+ * Open with O_NOFOLLOW, or equivalent. Note that the fallback equivalent
+ * may be racy. Do not use this as protection against an attacker who can
+ * simultaneously create paths.
+ */
+int open_nofollow(const char *path, int flags);
+
+void sleep_millisec(int millisec);
+
+/*
+ * Generate len bytes from the system cryptographically secure PRNG.
+ * Returns 0 on success and -1 on error, setting errno.  The inability to
+ * satisfy the full request is an error.
+ */
+int csprng_bytes(void *buf, size_t len);
+
 #endif /* WRAPPER_H */
-- 
2.41.0.255.g8b1d071c50-goog

