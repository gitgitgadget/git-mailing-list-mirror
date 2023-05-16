Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C76C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjEPRKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjEPRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:09:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B823AB9
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6439a13ba1eso13880168b3a.0
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684256996; x=1686848996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvgkj0sHxkS1idM09KjOEMb4AWf6SbSO2PJ5eVjUk64=;
        b=PoBuZlPj1mQhe5KFGC31t+T35cmgJ4fD6HufAriDYbyDp5pYdpH17k9+XVGND4XHKr
         MU11Tv9W/0r94FOlDRgCgG6s3DwFx2sXSu/mPbDHkE4IN55aYYG5ZdDwILTnQkbCuuG2
         ptJ/HU1h/h5Dh4okbXNh0NFO3IzCs1KRmKE++s02jg0vCjHfp296hv2BX9XXypNWy3l/
         EoPGQpF11rYRQMelDzlmbzO+AZaO3vYEh2O+Ykr3oqdVD1rgh7Kv5U7v8ZrmjFiTajqQ
         yT52ddPW+zTm16S4Ut/HynvAp9FZ4eMWelYIp8gtAPVWAI0UpK2BPYp6Q3QvlfxLeL2Z
         4yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684256996; x=1686848996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvgkj0sHxkS1idM09KjOEMb4AWf6SbSO2PJ5eVjUk64=;
        b=XcCwL6ZWa/HQKPTDoPU04AD+z4qLfRiS2FymzrWcxuJKXNY+YAQTmssv/0mw+vs0fc
         mLH7TT7sOn4Oo/gO5eZjHUfxoD9Dir/b04q0eWDa/1GdueBWCxwSQMMwOsks3s9rXx6P
         7HfJHztqFtgpqAPoqRWcVoMz4XDPOENJ0w/LEwTNSVuP58ZBun1eIDrZZz+sKuRKLEhF
         6CJH2/g0839KAbOanNjqfRiqfSa6dEEdY4+4Bi/oWO+0Q1sm4vAIFStkj3zchRmBJpB8
         WCFLl/Pe9XAzqeeqlACFyu7V0VBqK5QQgyZRsWQG6P0DhvyFn5kSRAjnD1K5Eixp7LWt
         /6fw==
X-Gm-Message-State: AC+VfDxADwtkn9yh+Ki6GIq20fOguc6k2dDhZds1T83CqhkRuw0m5p6G
        T/RqdPLbg4+zlywam6rT4Q+9xM6NJx5Y/S2ymPSpsI2Tc9MGcaUMyiX+j9Hfit/NV+5Lk5MrgN+
        4ZReptnNjfJimOOYYZ5RFH6uinNLQhc33etHAs8DIvgqmo9PI1Tr5h2m0ridCd6Mtng==
X-Google-Smtp-Source: ACHHUZ6Lcdx+MHvG8e5YOyp55JmbTVroycERiA79H99onF5JXI0I6JsTHXNGFzZWBWDBY//2y0s5fR+SspaMX1M=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2c4:b0:647:5400:a7cb with SMTP
 id b4-20020a056a0002c400b006475400a7cbmr5995486pft.3.1684256995785; Tue, 16
 May 2023 10:09:55 -0700 (PDT)
Date:   Tue, 16 May 2023 17:09:29 +0000
In-Reply-To: <20230516170932.1358685-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230516170932.1358685-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516170932.1358685-5-calvinwan@google.com>
Subject: [PATCH 4/6] usage.h: move declarations for usage.c functions from git-compat-util.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 common.h          |  1 +
 git-compat-util.h | 54 ------------------------------------------
 usage.h           | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 54 deletions(-)
 create mode 100644 usage.h

diff --git a/common.h b/common.h
index c0fdc5eb98..4aa99bc98b 100644
--- a/common.h
+++ b/common.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "wrapper.h"
+#include "usage.h"
 
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
diff --git a/git-compat-util.h b/git-compat-util.h
index c2b92a3033..bc543baa66 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -573,19 +573,6 @@ static inline int git_has_dir_sep(const char *path)
 #include "compat/bswap.h"
 
 #include "wildmatch.h"
-#include "wrapper.h"
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
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
@@ -601,30 +588,6 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 #include <openssl/rand.h>
 #endif
 
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
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
@@ -941,23 +904,6 @@ int git_regcomp(regex_t *preg, const char *pattern, int cflags);
 #endif
 #endif
 
-/* usage.c: only to be used for testing BUG() implementation (see test-tool) */
-extern int BUG_exit_code;
-
-/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
-extern int bug_called_must_BUG;
-
-__attribute__((format (printf, 3, 4))) NORETURN
-void BUG_fl(const char *file, int line, const char *fmt, ...);
-#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
-__attribute__((format (printf, 3, 4)))
-void bug_fl(const char *file, int line, const char *fmt, ...);
-#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
-#define BUG_if_bug(...) do { \
-	if (bug_called_must_BUG) \
-		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
-} while (0)
-
 #ifndef FSYNC_METHOD_DEFAULT
 #ifdef __APPLE__
 #define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
diff --git a/usage.h b/usage.h
new file mode 100644
index 0000000000..770076e684
--- /dev/null
+++ b/usage.h
@@ -0,0 +1,60 @@
+#ifndef USAGE_H
+#define USAGE_H
+
+#include "git-compat-util.h"
+
+/* General helper functions */
+NORETURN void usage(const char *err);
+NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int die_message_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+
+void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
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
+typedef void (*report_fn)(const char *, va_list params);
+
+void set_die_routine(NORETURN_PTR report_fn routine);
+report_fn get_die_message_routine(void);
+void set_error_routine(report_fn routine);
+report_fn get_error_routine(void);
+void set_warn_routine(report_fn routine);
+report_fn get_warn_routine(void);
+void set_die_is_recursing_routine(int (*routine)(void));
+
+/* usage.c: only to be used for testing BUG() implementation (see test-tool) */
+extern int BUG_exit_code;
+
+/* usage.c: if bug() is called we should have a BUG_if_bug() afterwards */
+extern int bug_called_must_BUG;
+
+__attribute__((format (printf, 3, 4))) NORETURN
+void BUG_fl(const char *file, int line, const char *fmt, ...);
+#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+__attribute__((format (printf, 3, 4)))
+void bug_fl(const char *file, int line, const char *fmt, ...);
+#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_if_bug(...) do { \
+	if (bug_called_must_BUG) \
+		BUG_fl(__FILE__, __LINE__, __VA_ARGS__); \
+} while (0)
+
+#endif /* USAGE_H */
-- 
2.40.1.606.ga4b1b128d6-goog

