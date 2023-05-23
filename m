Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09349C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjEWTab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEWTaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:30:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2388E4D
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:30:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56536dd5f79so1477687b3.3
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684870200; x=1687462200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVgMHtYITHlXRBlft+656Xm4l0ScYI4JRBN+se07l3o=;
        b=KuRR5tOJG41SHOphgB4lPtSQFvjmrkYiSokFlG6I7KM6Yrncg4K6aAFrE4wkr61wok
         tqOaQanxNl9kPmlytNWRECBwOYE2dKRpGyH1wh5STLMaDCUrZIIcG/5erq689fD3TPd5
         Gh2s/d6G7tesRBlRhrKqZNhExzTJQFXRi8l5qTvABbcJqUIjotVZEK2HxBqbKInbg89o
         DREQIT9EYam1rmO0gJWUTy4G9q759Tx2jSnqIhXohrV/u+upmio8ce7KkfjuRB6fCFcb
         Gmu42xoMPr/s2YyOC1QpFQWUbGo3n/eWj26Qy3R/2tp6RmmJSA2C9rqRCVGBlWT1hu0r
         nmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870200; x=1687462200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVgMHtYITHlXRBlft+656Xm4l0ScYI4JRBN+se07l3o=;
        b=Zfl3ibHcZSMX7aclPX0FL8N/i1dJDUJGAQV98JKg03iebxuhkLGbcFbfMC1+plHxXM
         QJ5VfEAK5pKWXXMcHwFIOYyY2l+J6Z1AFyc/owxJ2thEmlCS6vLXm3p8XybOtoDGW6Tj
         EaRl4NwzXk6v4R3aOD/+BFdWyTetaUGRyU/znl2OL4b4j3sgrPv2RmvVIjjQzmWJPPqV
         uCceXHl9+UU+0O5AX8Y2D/9mE+ByVHaFyZ281fQbi46FiSBaFJjxn+E8xtusg4eI+h1q
         HPs+a55Kgv4+vu4k+jB87LOS8Y1/y3DzdEgdfLT+ujWXiAGn6LGr+W+ZRJym8aNyOfmw
         Fyjw==
X-Gm-Message-State: AC+VfDzmdH6Te6UOpQKKGojzd0ZU2NivmOKIS8SYlnU4ZXMTqT8C6lLV
        Lfe1IIoBQWEI4xFVuETztRERWEG+yTcIPN2blvXRnH77Qfm0w+Hwg2nCnBuo5TaFmxDG4qLLTCJ
        sD0Hg3ZLVwqbx2LbEZrrpkcdlcbyy+5WrHTgu5Rc80qErZLE9vg4HrT+AdXtkKBUMAQ==
X-Google-Smtp-Source: ACHHUZ5zD/yP+ak9nkr3/52IOh6xgMn9eFY/gVZjuKM0ZSurBbvj/a0K/Zzct7js0M5Y5ywxPFa7H19fHTZAc7A=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ad58:0:b0:561:82e0:91b with SMTP id
 l24-20020a81ad58000000b0056182e0091bmr9736868ywk.6.1684870199917; Tue, 23 May
 2023 12:29:59 -0700 (PDT)
Date:   Tue, 23 May 2023 19:29:47 +0000
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230523192749.1270992-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523192949.1271671-5-calvinwan@google.com>
Subject: [PATCH v2 5/7] usage.h: move declarations for usage.c functions from git-compat-util.h
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
 git-compat-util.h | 55 -------------------------------------------
 usage.h           | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 55 deletions(-)
 create mode 100644 usage.h

diff --git a/common.h b/common.h
index 0f164c1071..e3b673847d 100644
--- a/common.h
+++ b/common.h
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "wrapper.h"
+#include "usage.h"
 
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
diff --git a/git-compat-util.h b/git-compat-util.h
index f73c8727d1..481dac22b0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -572,20 +572,6 @@ static inline int git_has_dir_sep(const char *path)
 
 #include "compat/bswap.h"
 
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
-
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
@@ -600,30 +586,6 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
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
@@ -942,23 +904,6 @@ int git_regcomp(regex_t *preg, const char *pattern, int cflags);
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
2.40.1.698.g37aff9b760-goog

