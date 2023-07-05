Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD6EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGERJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGERJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:09:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AFD198A
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:09:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262ecb0c44fso9530747a91.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688576980; x=1691168980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob14upf4D0bnNrCWxY7Ep2D9/LxzmK9pYe8MU7ky6Ts=;
        b=vzBYrTIssH3rsLMB7XHt/GWul3+qqafbd2JO6VSlVJX+T5hvcSXzYY2822m511lJL3
         pwAzHY2itjR7PeXTk1tEOr6TGavLU+90HE7D+HN1x9yf5s5B2EfHYMrl81OkeYTkfQZL
         7t9ux1SWH1baZcQI0S1oIDmZ/QyFfGZlq584qi3vfvzmIdWwpdEhWAGw4vEArT2t22YZ
         1FgDOZ5w/ONZhD3icriTin0pxhuflehrzSwy87QisTtFO8/sfc4q37I/1p2gAG4zXnld
         xkXflXKWJOp4AmtYiEN22jN450b5qjwj9TSkRs6UYDhEhWwHxWV9H66d6Dn97FT9f3AR
         8BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576980; x=1691168980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob14upf4D0bnNrCWxY7Ep2D9/LxzmK9pYe8MU7ky6Ts=;
        b=YXS7cuuphYAKQ4ilDa3LAO+2rietqp2kvWQH6gZyWEjH/jjKameAKcMYrUy+aJNnWK
         gwQqeqqLECWTCOCsWPyQdz6WyU9rBO3sfps6jbYCfuQkz88ZqiyHCdyB47XDyjIuWRkv
         jKs8li+cYJmOR8saPcrisAsJy8eo/5Buajk4Fl2e6krwufnsBgae4Ezia+FloKYuPwzg
         MXjjf6tyartSyig/aaE4F/hs/XJKP1DqsVoz0dgrNP5quhU8qtdPXSh4kZtq0W9zYH/A
         zYPFI6dCaFgbUc2a1WiLSopluFC3Qcve1pyfd8aJpbBG7yjoFCHRHXdmnFWHT5kkdMJ/
         zeCg==
X-Gm-Message-State: ABy/qLaI5lYA0EsldcKfXl8v9VxRKv8XdtRR4G6pFHutP8cYSusDR6Xx
        HubsMX3PHmeO+k/f2AIXH0tzubTTjwVqFlVzkkoLp1X+pyy25ixHpcfzL0f1AWBxLJSJai82Sby
        fsxPIcncgz8g6DgxD5ny03vRxHT6jfP1O7hqxu79EQ9m/tcowIuSn1SwfrY3x32uw2Q==
X-Google-Smtp-Source: APBJJlHzGGeevQjqMCsDacTqSKjlj5nMFsMOvzemDZyXktaFMVt8LIciEpNUM6AzSHcMJ9NrcvD3VklZ9IebWGM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:a60c:b0:263:95f5:e163 with SMTP
 id c12-20020a17090aa60c00b0026395f5e163mr11309413pjq.2.1688576980615; Wed, 05
 Jul 2023 10:09:40 -0700 (PDT)
Date:   Wed,  5 Jul 2023 17:09:19 +0000
In-Reply-To: <20230705170812.3833103-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230705170812.3833103-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705170924.3833828-1-calvinwan@google.com>
Subject: [PATCH v5 1/6] git-compat-util: move strbuf.c funcs to its header
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While functions like starts_with() probably should not belong in the
boundaries of the strbuf library, this commit focuses on first splitting
out headers from git-compat-util.h.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/symbolic-ref.c   |  1 +
 builtin/unpack-objects.c |  1 +
 git-compat-util.h        | 32 --------------------------------
 strbuf.h                 | 32 ++++++++++++++++++++++++++++++++
 versioncmp.c             |  1 +
 5 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index a61fa3c0f8..c9defe4d2e 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 static const char * const git_symbolic_ref_usage[] = {
 	N_("git symbolic-ref [-m <reason>] <name> <ref>"),
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1979532a9d..84b68304ed 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -12,6 +12,7 @@
 #include "blob.h"
 #include "commit.h"
 #include "replace-object.h"
+#include "strbuf.h"
 #include "tag.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index ae88291976..78a993c604 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -679,9 +679,6 @@ void set_warn_routine(report_fn routine);
 report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
-int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
-
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
  * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
@@ -710,29 +707,6 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
-/*
- * If the string "str" is the same as the string in "prefix", then the "arg"
- * parameter is set to the "def" parameter and 1 is returned.
- * If the string "str" begins with the string found in "prefix" and then a
- * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
- * (i.e., to the point in the string right after the prefix and the "=" sign),
- * and 1 is returned.
- *
- * Otherwise, return 0 and leave "arg" untouched.
- *
- * When we accept both a "--key" and a "--key=<val>" option, this function
- * can be used instead of !strcmp(arg, "--key") and then
- * skip_prefix(arg, "--key=", &arg) to parse such an option.
- */
-int skip_to_optional_arg_default(const char *str, const char *prefix,
-				 const char **arg, const char *def);
-
-static inline int skip_to_optional_arg(const char *str, const char *prefix,
-				       const char **arg)
-{
-	return skip_to_optional_arg_default(str, prefix, arg, "");
-}
-
 /*
  * Like skip_prefix, but promises never to read past "len" bytes of the input
  * buffer, and returns the remaining number of bytes in "out" via "outlen".
@@ -777,12 +751,6 @@ static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
 	return strip_suffix_mem(str, len, suffix);
 }
 
-static inline int ends_with(const char *str, const char *suffix)
-{
-	size_t len;
-	return strip_suffix(str, suffix, &len);
-}
-
 #define SWAP(a, b) do {						\
 	void *_swap_a_ptr = &(a);				\
 	void *_swap_b_ptr = &(b);				\
diff --git a/strbuf.h b/strbuf.h
index 0528ab5010..fd43c46433 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -671,4 +671,36 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
+int starts_with(const char *str, const char *prefix);
+int istarts_with(const char *str, const char *prefix);
+
+/*
+ * If the string "str" is the same as the string in "prefix", then the "arg"
+ * parameter is set to the "def" parameter and 1 is returned.
+ * If the string "str" begins with the string found in "prefix" and then a
+ * "=" sign, then the "arg" parameter is set to "str + strlen(prefix) + 1"
+ * (i.e., to the point in the string right after the prefix and the "=" sign),
+ * and 1 is returned.
+ *
+ * Otherwise, return 0 and leave "arg" untouched.
+ *
+ * When we accept both a "--key" and a "--key=<val>" option, this function
+ * can be used instead of !strcmp(arg, "--key") and then
+ * skip_prefix(arg, "--key=", &arg) to parse such an option.
+ */
+int skip_to_optional_arg_default(const char *str, const char *prefix,
+				 const char **arg, const char *def);
+
+static inline int skip_to_optional_arg(const char *str, const char *prefix,
+				       const char **arg)
+{
+	return skip_to_optional_arg_default(str, prefix, arg, "");
+}
+
+static inline int ends_with(const char *str, const char *suffix)
+{
+	size_t len;
+	return strip_suffix(str, suffix, &len);
+}
+
 #endif /* STRBUF_H */
diff --git a/versioncmp.c b/versioncmp.c
index 74cc7c43f0..45e676cbca 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "versioncmp.h"
 
-- 
2.41.0.255.g8b1d071c50-goog

