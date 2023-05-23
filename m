Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF61C7EE23
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjEWTa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbjEWTaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:30:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1118F
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56561689700so254557b3.2
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684870195; x=1687462195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=04VFOfLRNd5vmWBRZYRtI+VXViPIpMDXz/zmRSB4+KI=;
        b=oETNQnBngy5KJ4lPEqvkpcCEDpghvmRPkEwPoAUBaGTaNTf5r299ega0ub+yFUZN7E
         PIG3EdkcTHwQqfX6JUFQ0IJgfjF3fVMn3DgEyNcGE9kDGktE7q9sK5buddoAZJ6iVNf3
         Yyx0NBygXQ2QmcVYO0Xhjxxq5Qc2+U0Z9C5l/XVtCp5TWCsJV4U+/J3Z+xYiGSmsNdFw
         Kv4ISgbNa2RR0Lzg0bGsw4d4XPQT2RbEosdJ27M0Y8ctjMvlsEE+kNG3yMmU8YDPZbaA
         7RvsSainR1F+hfJBF8QqiB+LcSp+Gf/XajesTJcWxoiRNIlWcrzTp9qL/Zlcmtuno2pQ
         spvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870195; x=1687462195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04VFOfLRNd5vmWBRZYRtI+VXViPIpMDXz/zmRSB4+KI=;
        b=OKFkZvBaSV0N4Ogy0Q+z+2ulfArBMOri76HR9pIc35PTFORZmF6390cqZoAO+d6LUC
         SdwkC0pzL5TQQnapiBNOQ/zAgb7DAb3zqK1Ri/ZV3TTynQ8wbmRoKV6Rvo7vJDD5NqKJ
         FnqrtDqCrfTAZmTqXCoqRqsufOfOXxxUHDFn/mWezLG+fDJ0ZDeH9l/RVBUNYOYrxl86
         2oSiKB7GvfWlu6pWLUUrL8cvO3hJtwBu37rUttmpJnLc8zcTfbLnKQiC2WiWz8VBF1wR
         i0I4L3obEMwlf9/0ieS81tmv2ckVTNBa94CkpYDZHAhiKGJ2bZ2AX/Yj7K76+hBizVZM
         Qckg==
X-Gm-Message-State: AC+VfDwHwiC6S2qbtI+WSb0ha+kqItFoRLq4UNWMDGJx59CctN/zxetf
        R/iX/FNqO9g8vd4+Ff4yQcnkjxekt8PdB4sOKO+pz8FfUB8QcXS3icMkvns+S3LqeR7SnNONbHL
        rP3p5myrNPFMggOd+l+qN1WAeN2HejAqYy8FS3pm0EI/7zkM0r906pyzKfvYu6tPmmw==
X-Google-Smtp-Source: ACHHUZ7uX76j0FYroAfDHP7YNM7it9btCKhQ+qP/7H7t3bVsuSPkiprLcyQ1fA1GZ5fb3USwQIiDq6nCH3uVlfo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:b717:0:b0:560:d237:43dc with SMTP id
 v23-20020a81b717000000b00560d23743dcmr9533409ywh.3.1684870195221; Tue, 23 May
 2023 12:29:55 -0700 (PDT)
Date:   Tue, 23 May 2023 19:29:44 +0000
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230523192749.1270992-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523192949.1271671-2-calvinwan@google.com>
Subject: [PATCH v2 2/7] wrapper.h: move declarations for wrapper.c functions
 from git-compat-util.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
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
2.40.1.698.g37aff9b760-goog

