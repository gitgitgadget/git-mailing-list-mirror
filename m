Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEBDC7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjFFRKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjFFRKK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:10 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CAF18E
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-653bbc6e2fdso2351847b3a.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071409; x=1688663409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pXEHkQTV465tRVG7gPgicn5k/OJlSChLcC2rWOV9RU=;
        b=XENFz2sbl2d2cbGZ0vEtlilbC6rRDuPcN8fBADgGeocApHrNfuPOxiuAqvgXO11ZI5
         sUPHylB6P/tnU/SHPVlDCRZEZBersV2LU2PvsySPcZ9MtJspBCDuRthkNCN1jm+GKjoK
         pFlek1SI06rCS+vDYnO9DEsF83BxndySFOPPKbSY8rFbo3Fhc2+HdCiUL+iKWxvBrYuC
         lPvCVGr2RD2Ljt/Vw4v44+lkXUDYovChlwkLMSFQMj3i7EcFjDZDdeiPsasVVew2mpJY
         B0U7IXjyGnd5VG5XImAkZlMrxN/7H8fSo4c+72mTSHZNBHQPKYOiIqunbzsb1GVjlb+G
         PTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071409; x=1688663409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pXEHkQTV465tRVG7gPgicn5k/OJlSChLcC2rWOV9RU=;
        b=FNG/gWqLX+R2Cmx1U0afi5s5jLN3Y6H8x2FL2C93tJXvtEnsWmAw22g+q+/jQ79dih
         ehPgamXg3P3W9zgCcZYXn43eqIJuGYo5FCaSMLj+9+yD5cJNQT2qPHefxEnZmqBBHSzY
         ic72uwnbZue7mHYBKovruSYTIh6Yr2MBP4Xa0oZk771JaLYsbybi2wU+7A6ptN1TXrBs
         0Uc375VP04/v/PGrQ8NFM8nUVS+ERmCZNw2NRWa+paGDoUnnnyfaHtBr+yP83E37ApOr
         m9DHJvISxoGKb+wfWsT0IsnAepDm8Mo7SnwO3ckmr/BJD6BecCI9Ghelx7rU6eAC3s4l
         nG4w==
X-Gm-Message-State: AC+VfDza3OFO9YlD83nDmOTLKwPlTiAsuTgtiNv2wuJJMs4/IMPBxI54
        N+tZ2aeSjZpNBnXA9jTd8JuRjUkvYPWrXqrw4W4DUaKBINi2L8vhy9gjqMmSruWr/EgK/UKDEHr
        lcG4cpR1xt19iAEAkV7rEZnqIRMdaHTXeL5EQgcyDLuZVRk893dSQB5xd7hwS1E75IA==
X-Google-Smtp-Source: ACHHUZ6dhai9eendWYpw3H7vOb54ZhGbLJ/7mqwKcCyROQz2rm2hI3WNzZQuMS3Mo7+xaZNbARr98YruCbJHYws=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1ad3:b0:653:b2f2:6470 with SMTP
 id f19-20020a056a001ad300b00653b2f26470mr1216364pfv.2.1686071408646; Tue, 06
 Jun 2023 10:10:08 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:09:57 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-3-calvinwan@google.com>
Subject: [PATCH v3 3/8] sane-ctype.h: create header for sane-ctype macros
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
index f8e68baf29..2151d8b437 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1153,67 +1153,7 @@ static inline size_t xsize_t(off_t len)
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
2.41.0.rc2.161.g9c6817b8e7-goog

