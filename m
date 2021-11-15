Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F477C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E9561A40
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbhKOXbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352975AbhKOXSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF3C03E03B
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso925011wmf.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUxIbsa31S0yxnDqQdQR377b6N8JDtQa12RrRehlSRg=;
        b=W5bSfH852kt+u0/kiDdlWtDZ/J++CHnAStFaktD2pGpBgsHVob+UsIlBr+U1gSORdw
         XXxVL4rJoisctoQbtwXrNLQAF4ct67MpEuZL5nlzODUBm4/iZ14uOuSs0Y7Xcr692lYy
         b3ZM5oD8PleTcJehIZW7EgZNJATsYVZWvxDSJEwv1gNmGiKARw17qAGzDQgH/XJ0igtH
         r3eQAYN8ooI+B/G/SMN6pdwIJRL0FZCleHJ5Qfo/77JZCYlxq3KCmDBYk2RUJPp1BBeP
         pJcyosZwXWniFi/kLgZZ7UAc7qBo9er2ZmlGVIMYFj2MeGcMutNJHP7vBqO5rOWPZSOB
         ozhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUxIbsa31S0yxnDqQdQR377b6N8JDtQa12RrRehlSRg=;
        b=IhnDllwyP2Xo5BhIA3uW25g9rKP12MYlUiLNpFQUaZD5FGC9lP+9VI2NhGj67oGW7D
         oirm+4SSOrZAAimaUWb44+mNiwQeJZL0CPV5G/mImeOX53qpvrp1HqCO4SIgRHXTrzSZ
         ZFOP7F1QfuAQuYzulp+SlUnqlLMYwpaCmP8dDulTqMU0sHvjLGj9jeQSnnC3ZKJozK7+
         A0rNYxzVUJV7UqavznFe0XJmlKY/t4x7SAwwebEe/GsTwn5gfeQS+V5WnxnDEfuh4k/1
         aC4JZI+NerqDzGsCtl4d/i8ZDHqqpCm6slgahP1EmBVweWOO5kDyKLXbBLL/BTM6KxYY
         zGlQ==
X-Gm-Message-State: AOAM533D1SIvBn0B2DB5aBlQyboF7NtlBcidCywkkqEfhNF6siOuZcQs
        47uXrzjtXZ8vFyUX/9qszeBJE1jwjXNYlQ==
X-Google-Smtp-Source: ABdhPJwyzKUH2YlQiGhAs66IR3GrI9WbA1yXV9Fxv5W7BFixkNeuxX/hGeLQG3EUhxX3oyjzIfG94g==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr15254715wmk.77.1637014724281;
        Mon, 15 Nov 2021 14:18:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 14/21] usage API: create a new usage.h, move API docs there
Date:   Mon, 15 Nov 2021 23:18:24 +0100
Message-Id: <RFC-patch-14.21-f553b790601-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 26c816a67de (Merge branch 'hw/doc-in-header', 2019-12-16)
and move the API docs for the usage.c API to a new usage.h, which is
included from "git-compat-util.h".

All of the code and documentation is unchanged here, with the
following exceptions:

 * Added a short paragraph to the start of the comment in usage.h
   describing the API in general terms.

 * Prefixed comments with " * ", reformatted "+"-flowing lines away
   from that ASCIIDOC syntax.

 * Re-arranged the function definitions that were previously in
   "git-compat-util.h" to be grouped by task, and added short comments
   above each one. None of the code was changed.

 * There was an unrelated forward-declaration of "struct strbuf" that
   happened to be just above these usage functions. Move it down to just
   above "unlink_or_msg()" where it's needed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/api-error-handling.txt          |  92 ----------
 git-compat-util.h                             |  59 +------
 usage.h                                       | 161 ++++++++++++++++++
 3 files changed, 163 insertions(+), 149 deletions(-)
 delete mode 100644 Documentation/technical/api-error-handling.txt
 create mode 100644 usage.h

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
deleted file mode 100644
index 818489bc3d4..00000000000
--- a/Documentation/technical/api-error-handling.txt
+++ /dev/null
@@ -1,92 +0,0 @@
-Error reporting in git
-======================
-
-`BUG`, `bug`, `die`, `usage`, `error`, and `warning` report errors of
-various kinds.
-
-- `BUG` is for failed internal assertions that should never happen,
-  i.e. a bug in git itself.
-
-- `die` is for fatal application errors.  It prints a message to
-  the user and exits with status 128.
-
-- `usage` is for errors in command line usage.  After printing its
-  message, it exits with status 129.  (See also `usage_with_options`
-  in the link:api-parse-options.html[parse-options API].)
-
-- `error` is for non-fatal library errors.  It prints a message
-  to the user and returns -1 for convenience in signaling the error
-  to the caller.
-
-- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
-  returns -1 like error. The user should then call `BUG_if_bug()` to die.
-+
-This is for the convenience of APIs who'd like to potentially report
-more than one bug before calling `BUG_if_bug()`, which will invoke
-`BUG()` if there were any preceding calls to `bug()`.
-+
-We call `BUG_if_bug()` ourselves in on `exit()` (via a wrapper, not
-`atexit()`), which guarantees that we'll catch cases where we forgot
-to invoke `BUG_if_bug()` following a call or calls to `bug()`.
-
-- `warning` is for reporting situations that probably should not
-  occur but which the user (and Git) can continue to work around
-  without running into too many problems.  Like `error`, it
-  returns -1 after reporting the situation to the caller.
-
-These reports will be logged via the trace2 facility. See the "error"
-event in link:api-trace2.txt[trace2 API].
-
-Customizable error handlers
----------------------------
-
-The default behavior of `die` and `error` is to write a message to
-stderr and then exit or return as appropriate.  This behavior can be
-overridden using `set_die_routine` and `set_error_routine`.  For
-example, "git daemon" uses set_die_routine to write the reason `die`
-was called to syslog before exiting.
-
-Library errors
---------------
-
-Functions return a negative integer on error.  Details beyond that
-vary from function to function:
-
-- Some functions return -1 for all errors.  Others return a more
-  specific value depending on how the caller might want to react
-  to the error.
-
-- Some functions report the error to stderr with `error`,
-  while others leave that for the caller to do.
-
-- errno is not meaningful on return from most functions (except
-  for thin wrappers for system calls).
-
-Check the function's API documentation to be sure.
-
-Caller-handled errors
----------------------
-
-An increasing number of functions take a parameter 'struct strbuf *err'.
-On error, such functions append a message about what went wrong to the
-'err' strbuf.  The message is meant to be complete enough to be passed
-to `die` or `error` as-is.  For example:
-
-	if (ref_transaction_commit(transaction, &err))
-		die("%s", err.buf);
-
-The 'err' parameter will be untouched if no error occurred, so multiple
-function calls can be chained:
-
-	t = ref_transaction_begin(&err);
-	if (!t ||
-	    ref_transaction_update(t, "HEAD", ..., &err) ||
-	    ret_transaction_commit(t, &err))
-		die("%s", err.buf);
-
-The 'err' parameter must be a pointer to a valid strbuf.  To silence
-a message, pass a strbuf that is explicitly ignored:
-
-	if (thing_that_can_fail_in_an_ignorable_way(..., &err))
-		/* This failure is okay. */
-		strbuf_reset(&err);
diff --git a/git-compat-util.h b/git-compat-util.h
index 9b02a3e05ba..7a0b88a54c6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -462,20 +462,7 @@ static inline int git_has_dir_sep(const char *path)
 #include "compat/bswap.h"
 
 #include "wildmatch.h"
-
-struct strbuf;
-
-/* General helper functions */
-NORETURN void usage(const char *err);
-NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
-NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
-NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+#include "usage.h"
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
@@ -487,30 +474,6 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 #include <openssl/x509v3.h>
 #endif /* NO_OPENSSL */
 
-/*
- * Let callers be aware of the constant return value; this can help
- * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
- * because other compilers may be confused by this.
- */
-#if defined(__GNUC__)
-static inline int const_error(void)
-{
-	return -1;
-}
-#define error(...) (error(__VA_ARGS__), const_error())
-#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
-#endif
-
-typedef void (*report_fn)(const char *, va_list params);
-
-void set_die_routine(NORETURN_PTR report_fn routine);
-report_fn get_die_message_routine(void);
-void set_error_routine(report_fn routine);
-report_fn get_error_routine(void);
-void set_warn_routine(report_fn routine);
-report_fn get_warn_routine(void);
-void set_die_is_recursing_routine(int (*routine)(void));
-
 int starts_with(const char *str, const char *prefix);
 int istarts_with(const char *str, const char *prefix);
 
@@ -1195,25 +1158,6 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #endif
 #endif
 
-/* usage.c: only to be used for testing BUG() implementation (see test-tool) */
-extern int BUG_exit_code;
-
-/* usage.c: if bug() is called we must have a BUG() invocation afterwards */
-extern int bug_called_must_BUG;
-
-__attribute__((format (printf, 3, 4))) NORETURN
-void BUG_fl(const char *file, int line, const char *fmt, ...);
-#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
-__attribute__((format (printf, 3, 4)))
-int bug_fl(const char *file, int line, const char *fmt, ...);
-#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
-#define BUG_if_bug() do { \
-	if (bug_called_must_BUG) { \
-		bug_called_must_BUG = 0; \
-		BUG_fl(__FILE__, __LINE__, "see bug() output above"); \
-	} \
-} while (0)
-
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
@@ -1226,6 +1170,7 @@ int unlink_or_warn(const char *path);
   * appends a message to err suitable for
   * 'error("%s", err->buf)' on error.
   */
+struct strbuf;
 int unlink_or_msg(const char *file, struct strbuf *err);
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
diff --git a/usage.h b/usage.h
new file mode 100644
index 00000000000..a2567a609fc
--- /dev/null
+++ b/usage.h
@@ -0,0 +1,161 @@
+#ifndef USAGE_H
+#define USAGE_H
+
+/**
+ * The usage.h is an API for error reporting in git, errors are
+ * reported both to the user, to Trace2 (see "trace2.h"), and possibly
+ * to custom callbacks via "report_fn" callbacks.
+ *
+ * `BUG`, `bug`, `die`, `usage`, `error`, and `warning` report errors of
+ * various kinds.
+ *
+ * - `BUG` is for failed internal assertions that should never happen,
+ *   i.e. a bug in git itself.
+ *
+ * - `die` is for fatal application errors.  It prints a message to
+ *   the user and exits with status 128.
+ *
+ * - `usage` is for errors in command line usage.  After printing its
+ *   message, it exits with status 129.  (See also `usage_with_options`
+ *   in the link:api-parse-options.html[parse-options API].)
+ *
+ * - `error` is for non-fatal library errors.  It prints a message
+ *   to the user and returns -1 for convenience in signaling the error
+ *   to the caller.
+ *
+ * - `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
+ *   returns -1 like error. The user should then call `BUG_if_bug()` to die.
+ *
+ *   This is for the convenience of APIs who'd like to potentially report
+ *   more than one bug before calling `BUG_if_bug()`, which will invoke
+ *   `BUG()` if there were any preceding calls to `bug()`.
+ *
+ *   We call `BUG_if_bug()` ourselves in on `exit()` (via a wrapper, not
+ *   `atexit()`), which guarantees that we'll catch cases where we forgot
+ *   to invoke `BUG_if_bug()` following a call or calls to `bug()`.
+ *
+ * - `warning` is for reporting situations that probably should not
+ *   occur but which the user (and Git) can continue to work around
+ *   without running into too many problems.  Like `error`, it
+ *   returns -1 after reporting the situation to the caller.
+ *
+ * These reports will be logged via the trace2 facility. See the "error"
+ * event in link:api-trace2.txt[trace2 API].
+ *
+ * Customizable error handlers
+ * ---------------------------
+ *
+ * The default behavior of `die` and `error` is to write a message to
+ * stderr and then exit or return as appropriate.  This behavior can be
+ * overridden using `set_die_routine` and `set_error_routine`.  For
+ * example, "git daemon" uses set_die_routine to write the reason `die`
+ * was called to syslog before exiting.
+ *
+ * Library errors
+ * --------------
+ *
+ * Functions return a negative integer on error.  Details beyond that
+ * vary from function to function:
+ *
+ * - Some functions return -1 for all errors.  Others return a more
+ *   specific value depending on how the caller might want to react
+ *   to the error.
+ *
+ * - Some functions report the error to stderr with `error`,
+ *   while others leave that for the caller to do.
+ *
+ * - errno is not meaningful on return from most functions (except
+ *   for thin wrappers for system calls).
+ *
+ * Check the function's API documentation to be sure.
+ *
+ * Caller-handled errors
+ * ---------------------
+ *
+ * An increasing number of functions take a parameter 'struct strbuf *err'.
+ * On error, such functions append a message about what went wrong to the
+ * 'err' strbuf.  The message is meant to be complete enough to be passed
+ * to `die` or `error` as-is.  For example:
+ *
+ * 	if (ref_transaction_commit(transaction, &err))
+ * 		die("%s", err.buf);
+ *
+ * The 'err' parameter will be untouched if no error occurred, so multiple
+ * function calls can be chained:
+ *
+ * 	t = ref_transaction_begin(&err);
+ * 	if (!t ||
+ * 	    ref_transaction_update(t, "HEAD", ..., &err) ||
+ * 	    ret_transaction_commit(t, &err))
+ * 		die("%s", err.buf);
+ *
+ * The 'err' parameter must be a pointer to a valid strbuf.  To silence
+ * a message, pass a strbuf that is explicitly ignored:
+ *
+ * 	if (thing_that_can_fail_in_an_ignorable_way(..., &err))
+ * 		// This failure is okay.
+ * 		strbuf_reset(&err);
+ */
+
+/**
+ * External but private variables, don't use these except for
+ * implementation details of this API itself.
+ */
+/* Only to be used for testing BUG() implementation (see test-tool) */
+extern int BUG_exit_code;
+/* If bug() is called we must have a BUG() invocation afterwards */
+extern int bug_called_must_BUG;
+
+/* General helper functions */
+NORETURN void usage(const char *err);
+NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+
+/* General helper functions invoked via macro wrappers */
+__attribute__((format (printf, 3, 4))) NORETURN
+void BUG_fl(const char *file, int line, const char *fmt, ...);
+__attribute__((format (printf, 3, 4)))
+int bug_fl(const char *file, int line, const char *fmt, ...);
+
+/* General helper macros */
+#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_if_bug() do { \
+	if (bug_called_must_BUG) { \
+		bug_called_must_BUG = 0; \
+		BUG_fl(__FILE__, __LINE__, "see bug() output above"); \
+	} \
+} while (0)
+
+/* Setting custom handling routines */
+typedef void (*report_fn)(const char *, va_list params);
+void set_die_routine(NORETURN_PTR report_fn routine);
+report_fn get_die_message_routine(void);
+void set_error_routine(report_fn routine);
+report_fn get_error_routine(void);
+void set_warn_routine(report_fn routine);
+report_fn get_warn_routine(void);
+void set_die_is_recursing_routine(int (*routine)(void));
+
+/*
+ * Let callers be aware of the constant return value; this can help
+ * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
+ * because other compilers may be confused by this.
+ */
+#if defined(__GNUC__)
+static inline int const_error(void)
+{
+	return -1;
+}
+#define error(...) (error(__VA_ARGS__), const_error())
+#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
+#endif
+
+#endif
-- 
2.34.0.rc2.809.g11e21d44b24

