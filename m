Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D4FC77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbjFFRKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjFFRKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25010FA
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-259a5458a86so142362a91.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071407; x=1688663407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GyfJZbGlQtCwFI0EfD4USxQX3l+xHnP9HLpDUlpmx4s=;
        b=IrkzNlRQdLPXFoWtVj2JXOTK3lLEbsNOUZtiV/C3iAhq5u3BIbCWNX+klFqtnacnox
         g/S5oPClICJRvYZebu1mae0FgyrOX1OKDXedH7fWnL0ktzg0clS7f8YXoehwAAoitz+g
         vzNDa0kiyY2lLfBsPWfoeDa3llLlG7xUsQpLR4R4eWUOs1xVPrnXTzyE/yy0iSi2D9xN
         4Exubw3aVp7fsIz7cWiZiuOAPbeZMz3u8WS337KwNWegGkcfSyrPjsK/h3nJjTAegnm1
         savbQxdcEHoFPsut1ZiHwwtZAmazvE9rdaizLGOfhWBMr/1BSJcBqsKy/jJgqqcIe1gD
         mEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071407; x=1688663407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyfJZbGlQtCwFI0EfD4USxQX3l+xHnP9HLpDUlpmx4s=;
        b=HfKBUp0BUKCYEueRim1cs3yWqjs6IWHuIZ3a1x78DatZ0brRSPCZjQizENlmUGAoLi
         GF0hmNQICH0FWSwKFoTysZ3NWR6MQiGo1odpRYwBQuqf+CyJtr6XxNW2pHMx70BKSfdr
         KGjvO6VxHs8OFOlCgYUwEE4F5HduFq1/GO8MZhJ3RecExqx43Pdo6xhMkgZEhPuFub+z
         1LnVVquhHhUjum1Ef84Tmzq01ckI0Mg6cFo8FHH1Soj35v395QtAB47Fh5Fm9fWWCg8n
         m/CaB0J1OPZbM7to+rxg2dWLPaHEr6niBGwTcWlDkHtklUCPqg1AdeKbbO1fw9VgBspn
         4LLw==
X-Gm-Message-State: AC+VfDw9BdrcTr6Wolv3hV6LlVsTDMsXz/WGMjycHN1jqUE+4IQkK9E7
        7NVDivuasd2tyeci5A2RjLvOWNd3Qgs+M9tjLu8KRX0hTcyk96UrLIa5XnEFMAUHyGFjPnUp0pL
        uEr3XZHaTpAz7pMCyWYVNCXX+eWApOyzVL6ilzIhCItSsmrTDqWtPAwD6+tg5wIqUvA==
X-Google-Smtp-Source: ACHHUZ5FpQLV2Ynj82TCopsZsiknfFLN8MT1Ah5l9OVfWkNsQqoPUeew1nLzmWPDdl9s6RKfe7WtAPGGbNvkDKU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:f295:b0:257:4812:258c with SMTP
 id fs21-20020a17090af29500b002574812258cmr730776pjb.7.1686071407116; Tue, 06
 Jun 2023 10:10:07 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:09:56 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-2-calvinwan@google.com>
Subject: [PATCH v3 2/8] git-compat-util: move wrapper.c funcs to its header
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
index fe9e86bad0..f8e68baf29 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -625,7 +625,7 @@ static inline int git_has_dir_sep(const char *path)
 
 #include "compat/bswap.h"
 
-struct strbuf;
+#include "wrapper.h"
 
 /* General helper functions */
 NORETURN void usage(const char *err);
@@ -1045,36 +1045,6 @@ static inline int cast_size_t_to_int(size_t a)
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
@@ -1176,15 +1146,10 @@ static inline size_t xsize_t(off_t len)
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
 
@@ -1425,72 +1390,6 @@ void bug_fl(const char *file, int line, const char *fmt, ...);
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
@@ -1630,13 +1529,4 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
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
2.41.0.rc2.161.g9c6817b8e7-goog

