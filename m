Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB9EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 20:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjF3UYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjF3UYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 16:24:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F204494
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:23:56 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-668719b8945so1808570b3a.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688156636; x=1690748636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GG/ynIDIqdr5TiH5TSrgB3HMRA6tV2Zf6m3YMF8JHQM=;
        b=sLdHY9B0sV5uWJYlqfTSPlKTdI6CjJSHtVrKrkwdMRypznenIm3EXjSUBfi718YrbN
         kgFwTS27VzQNe8+VZ7vVGX9tqMf6jK0pDNJoGdLl+Sc9/lTj1ZM3a9a/cUmwJRgoxJWq
         hjdJloORbXnw4xukbMzeBcZk/N0pDfuYP36fa2aKKIcsb2MPEbZhCG1YA4z8a4oVDuJI
         +qsLmO8D6mofX71i9ImD1qagBY55ZmLYr7uYj06LAGdYUjg2HHlxwsZPCOzEPm+BK3ou
         f+PBrhYkyehyNgerjDaxUTV41DABiTyjwCSqGiKKNEmmb8igZdMGgDJIEqIC3EXRb87W
         o8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156636; x=1690748636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG/ynIDIqdr5TiH5TSrgB3HMRA6tV2Zf6m3YMF8JHQM=;
        b=P7bluRu7b7mH5nhTjHnaNz/SmuPXolou1+X6hxdB+fb94wq59aMt8HPNNnhWfUhFLp
         CieUYTJ3ZGVCEFax+MDrs6q3aIG4Ku79xFIHGMrP3JFJY7Nsb5wLIsGXEraRpMYYIi9P
         vVOeVNwB7yShvO/PcnqCsu74XRZdZVcxna/37xkhVi0ZGOvqE/WuFZQVFWl5mglzeAjn
         UmI2gBNCmRBi9HgnNc9qXn1YWkf8b089sFIHWoLCzYhB1nWYymn+CRvK0MGit9D1c+hm
         8hfgI56H7f31LwNq1YJm1K85wB4HAuwMlGej8cSnUkIgMj1vKbBnvRRE/mDuHa4SDPdm
         eulw==
X-Gm-Message-State: ABy/qLbjwkMXvUaJUiAUIao7IL9woKjbdzWh/3xCMRiLQXUtFjTFiwLM
        FaGwhTjHAkZ2LnDijlSTgXalHEeLOaRGPv73SB3FzeZ4L2wv7pviiW6qiEp/kJD5Pe4cd5ybCEm
        lPUeBv+aQm5qnQOkC0RXtbafTWyIHI1noks4Fx8o6ljCQPilk4lt2PKhpIZELNwYRPA==
X-Google-Smtp-Source: APBJJlFM653LvS0yH84RhJkj9xyWM7DUqDKLhuYNrThnZRrJDyq7u+GsCAYZvLRcAi9ealYXOoGpB0oZgzNoBvM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:b92:b0:66b:f900:c9cc with SMTP
 id g18-20020a056a000b9200b0066bf900c9ccmr4235638pfj.5.1688156635843; Fri, 30
 Jun 2023 13:23:55 -0700 (PDT)
Date:   Fri, 30 Jun 2023 20:23:43 +0000
In-Reply-To: <20230630202237.3069327-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230630202237.3069327-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630202346.3069950-3-calvinwan@google.com>
Subject: [PATCH v4 3/6] sane-ctype.h: create header for sane-ctype macros
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Splitting these macros from git-compat-util.h cleans up the file and
allows future third-party sources to not use these overrides if they do
not wish to.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 git-compat-util.h | 62 +-------------------------------------------
 sane-ctype.h      | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 61 deletions(-)
 create mode 100644 sane-ctype.h

diff --git a/git-compat-util.h b/git-compat-util.h
index 9140f43bbf..5f916e1094 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1155,67 +1155,7 @@ static inline size_t xsize_t(off_t len)
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
 
-/* Sane ctype - no locale, and works with signed chars */
-#undef isascii
-#undef isspace
-#undef isdigit
-#undef isalpha
-#undef isalnum
-#undef isprint
-#undef islower
-#undef isupper
-#undef tolower
-#undef toupper
-#undef iscntrl
-#undef ispunct
-#undef isxdigit
-
-extern const unsigned char sane_ctype[256];
-extern const signed char hexval_table[256];
-#define GIT_SPACE 0x01
-#define GIT_DIGIT 0x02
-#define GIT_ALPHA 0x04
-#define GIT_GLOB_SPECIAL 0x08
-#define GIT_REGEX_SPECIAL 0x10
-#define GIT_PATHSPEC_MAGIC 0x20
-#define GIT_CNTRL 0x40
-#define GIT_PUNCT 0x80
-#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
-#define isascii(x) (((x) & ~0x7f) == 0)
-#define isspace(x) sane_istest(x,GIT_SPACE)
-#define isdigit(x) sane_istest(x,GIT_DIGIT)
-#define isalpha(x) sane_istest(x,GIT_ALPHA)
-#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
-#define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)
-#define islower(x) sane_iscase(x, 1)
-#define isupper(x) sane_iscase(x, 0)
-#define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
-#define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
-#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
-#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
-		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
-#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
-#define tolower(x) sane_case((unsigned char)(x), 0x20)
-#define toupper(x) sane_case((unsigned char)(x), 0)
-#define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
-
-static inline int sane_case(int x, int high)
-{
-	if (sane_istest(x, GIT_ALPHA))
-		x = (x & ~0x20) | high;
-	return x;
-}
-
-static inline int sane_iscase(int x, int is_lower)
-{
-	if (!sane_istest(x, GIT_ALPHA))
-		return 0;
-
-	if (is_lower)
-		return (x & 0x20) != 0;
-	else
-		return (x & 0x20) == 0;
-}
+#include "sane-ctype.h"
 
 /*
  * Like skip_prefix, but compare case-insensitively. Note that the comparison
diff --git a/sane-ctype.h b/sane-ctype.h
new file mode 100644
index 0000000000..cbea1b299b
--- /dev/null
+++ b/sane-ctype.h
@@ -0,0 +1,66 @@
+#ifndef SANE_CTYPE_H
+#define SANE_CTYPE_H
+
+/* Sane ctype - no locale, and works with signed chars */
+#undef isascii
+#undef isspace
+#undef isdigit
+#undef isalpha
+#undef isalnum
+#undef isprint
+#undef islower
+#undef isupper
+#undef tolower
+#undef toupper
+#undef iscntrl
+#undef ispunct
+#undef isxdigit
+
+extern const unsigned char sane_ctype[256];
+extern const signed char hexval_table[256];
+#define GIT_SPACE 0x01
+#define GIT_DIGIT 0x02
+#define GIT_ALPHA 0x04
+#define GIT_GLOB_SPECIAL 0x08
+#define GIT_REGEX_SPECIAL 0x10
+#define GIT_PATHSPEC_MAGIC 0x20
+#define GIT_CNTRL 0x40
+#define GIT_PUNCT 0x80
+#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
+#define isascii(x) (((x) & ~0x7f) == 0)
+#define isspace(x) sane_istest(x,GIT_SPACE)
+#define isdigit(x) sane_istest(x,GIT_DIGIT)
+#define isalpha(x) sane_istest(x,GIT_ALPHA)
+#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define isprint(x) ((x) >= 0x20 && (x) <= 0x7e)
+#define islower(x) sane_iscase(x, 1)
+#define isupper(x) sane_iscase(x, 0)
+#define is_glob_special(x) sane_istest(x,GIT_GLOB_SPECIAL)
+#define is_regex_special(x) sane_istest(x,GIT_GLOB_SPECIAL | GIT_REGEX_SPECIAL)
+#define iscntrl(x) (sane_istest(x,GIT_CNTRL))
+#define ispunct(x) sane_istest(x, GIT_PUNCT | GIT_REGEX_SPECIAL | \
+		GIT_GLOB_SPECIAL | GIT_PATHSPEC_MAGIC)
+#define isxdigit(x) (hexval_table[(unsigned char)(x)] != -1)
+#define tolower(x) sane_case((unsigned char)(x), 0x20)
+#define toupper(x) sane_case((unsigned char)(x), 0)
+#define is_pathspec_magic(x) sane_istest(x,GIT_PATHSPEC_MAGIC)
+
+static inline int sane_case(int x, int high)
+{
+	if (sane_istest(x, GIT_ALPHA))
+		x = (x & ~0x20) | high;
+	return x;
+}
+
+static inline int sane_iscase(int x, int is_lower)
+{
+	if (!sane_istest(x, GIT_ALPHA))
+		return 0;
+
+	if (is_lower)
+		return (x & 0x20) != 0;
+	else
+		return (x & 0x20) == 0;
+}
+
+#endif
-- 
2.41.0.255.g8b1d071c50-goog

