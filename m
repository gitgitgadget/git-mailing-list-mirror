Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A785C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjEWTa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbjEWTaU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:30:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B618D
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56552a72cfbso1379947b3.3
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684870193; x=1687462193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pix5txEqGA/cjv47uoPcj2vDcSrGlRnMdSBFz/2e5Sk=;
        b=edS2GGE2wJrqto0rAJO9/w795h14TchCLepbumWiyUL32H8Wl6tyexjsmoCtaOji3p
         wPDw0wO7xq8At1kv2zUIXDxqPqcSe1nIcKRFPvER5WvP4MODSZVhTAGNE5pPdwAybuJO
         p9+37c4M+1dR1zt44W5fNMZ9qscyQnOkrrhgXSBVaGomwXQFzfumaeb53DDUvhSFhXaf
         uGgMlXU/AqcQf1VtlwkKTpplqToWKEiqHcfQ3jjVAX/j7np6+AVxLyFRFlO0jjN1XnXG
         jc/18SuRp1t7JayYOMByD9XPRrdjVmXhUR+PY4kvXSe/dc2xVBveWNnCKv8BONDQpuAy
         /Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870193; x=1687462193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pix5txEqGA/cjv47uoPcj2vDcSrGlRnMdSBFz/2e5Sk=;
        b=PIeyUBR2KfS1L6Te295FfEZaRm5FJOdw+Q+7mziiVwLdbuHzBGm46ETxZBELZY5uEA
         NMY0/ftzfVwW9Xq2xAYfkec/pSJ1mOithgVUclrWkVf9m33mNX+QKYf8WF1/kTYAUAEy
         17Mc4Rm1bRIoOpWtgieXUm6EOhSZ7j/OM0CRJJ+rLh5CRhi2fk49ZEOVmHkGx0wq4tvL
         CPU1p/TdkaS8KqaUZCoruFIzbIhmQjFbVnnvxIvQ/z13tXRrtF/lhZXwwUFKm6Cx76vS
         AQzpxaLdmSHc37rLpUNW1ysgnrLGK0ppfSgfx0G3KaID4hVbuqRSrzGV60wh22xxNHui
         Dj6A==
X-Gm-Message-State: AC+VfDxU3zfisEaz9aIr68Ephh7M0eDCyg8bIeRKKiEg62/EkyPCPgWY
        6jgbEAvbx85B4BBgZejIzzymKpY4+s49kpHcawX9MSmaZtyChDmecQr9lucNDA3mRqS6+wgScN0
        zz+pq2airgW+4wGz770eS/D3jWxJQe0dh2DbpojXIhmB2eDpyy7Mx5fCUrqp5aUNvOQ==
X-Google-Smtp-Source: ACHHUZ4GPWG+Y4Yaa2oXc5abH75YYqDdIBBLiXsh6oMt+P56LbOe1FhsznADaEdlDdn1W0QoQidWyFDS8qPJKhg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ae09:0:b0:55a:8930:b13 with SMTP id
 m9-20020a81ae09000000b0055a89300b13mr9423076ywh.9.1684870193630; Tue, 23 May
 2023 12:29:53 -0700 (PDT)
Date:   Tue, 23 May 2023 19:29:43 +0000
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230523192749.1270992-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523192949.1271671-1-calvinwan@google.com>
Subject: [PATCH v2 1/7] strbuf.h: move declarations for strbuf.c functions
 from git-compat-util.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
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
index b4b46ae729..0510e60e6e 100644
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
index 1889da7986..fe9e86bad0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -677,9 +677,6 @@ void set_warn_routine(report_fn routine);
 report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
-int starts_with(const char *str, const char *prefix);
-int istarts_with(const char *str, const char *prefix);
-
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
  * The "out" parameter is set to "str + strlen(prefix)" (i.e., to the point in
@@ -708,29 +705,6 @@ static inline int skip_prefix(const char *str, const char *prefix,
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
@@ -775,12 +749,6 @@ static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
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
index 8903195416..28b3038e83 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -698,4 +698,36 @@ char *xstrvfmt(const char *fmt, va_list ap);
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
2.40.1.698.g37aff9b760-goog

