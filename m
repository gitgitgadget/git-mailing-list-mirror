Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D2EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjF3UYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjF3UX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 16:23:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA0421E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:23:53 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-262bf824505so1968588a91.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688156632; x=1690748632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ob14upf4D0bnNrCWxY7Ep2D9/LxzmK9pYe8MU7ky6Ts=;
        b=EAiUvkA2/1p3e8R7Q/PAmf3VX5tcBtF9fq5qtioLlTA7ZsLi7kskFqyXtaWCodPe5I
         IcR4bHoTtkT0oze8fGMnTU2kir1teBI93KanCkB1fKj+w+cx5ONogWrmg8G5JZiojL1f
         LxVptUANwpEPYVDuK7sI4mKobf1Yl+djXFFG4PrSxYUb4TiSydTUG5XLX6PgQJo7Re6s
         rusgPP84z+zzoLdpIvTQ8S5aiJPwSUBMyTaYZqIBXzC1fLWmiEtJmJFb9RmkcC/Suj6E
         GkLV5+PtFMzfw0Vc0KITJW6jEvLYObUVSrdnj11BRsoMf7jsADUOQSZSFSOXAawkkSfB
         Fe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156632; x=1690748632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob14upf4D0bnNrCWxY7Ep2D9/LxzmK9pYe8MU7ky6Ts=;
        b=NsMOb6TF5T4ROxUwRMCGbkGSHRwkkfkoaasf4WzEv/fxcgpc0X2/mqHEgq9if+0mj/
         R9bMPcwslHSZx6AxHWtjfSfjzffKkBxQpuQ4b+/F5nFX9I9n8aPZVfh4UAgwyA/SKV+a
         XPOirnKQ1GgMMMVsr4VIHWqn70cqRa6w41vjRzgCl0J4uIo3t8SDU+Yt2ZnbxrKZufHa
         xHCTLsfFJix8Ejs7jmdg0Jlob+ibji3pN0fqXylN2E6pQf9TJX4fJ+ZO7uwvNm/2Vo8N
         ofOzBMNdeyUm/xF9SEtt5hvaCIpHN6EMR0dr1QUPHa8N+SMk0n6ABpKNgJK6LEJMcd1L
         q/Ig==
X-Gm-Message-State: ABy/qLYNbVoLMH/wgqB2ZUlrAE0xFnXt0Lr4V7oKPZEkwiKxoFo7r4Yv
        NAIZ6mSRIygf3xzDd1v3S0a6+0TPj3PVNghopRsEj21oz2Tm13vuKmS3JBOC2NsFBBc1V99ecVZ
        DT08iKg9IBhrhNACFX1pdekHRJ9020D1QQvomFJJCDGkU5U+Kz7VYmq2r/OMr6kf1sA==
X-Google-Smtp-Source: APBJJlFNReK/SD/U9cBpTgxpkiMECdsTjQo0UfCyZ5MLp9S62S6KYjR9iTPFekKzwPjYb9kFrIYFJA0XDbXJY4k=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:f011:b0:262:d6ac:126 with SMTP
 id bt17-20020a17090af01100b00262d6ac0126mr2154348pjb.0.1688156632281; Fri, 30
 Jun 2023 13:23:52 -0700 (PDT)
Date:   Fri, 30 Jun 2023 20:23:41 +0000
In-Reply-To: <20230630202237.3069327-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230630202237.3069327-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630202346.3069950-1-calvinwan@google.com>
Subject: [PATCH v4 1/6] git-compat-util: move strbuf.c funcs to its header
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

