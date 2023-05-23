Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F885C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbjEWTa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbjEWTaY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 15:30:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA3126
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-556011695d1so1439717b3.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684870196; x=1687462196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt03LJsdP7nx9fgeMadivdqMRjcceTT443SeukE1cbo=;
        b=Tezr7XUDO9W6puqH3irL37ubyeZzeJcsFQ97HvlbfutXY4osxKZ9r+HTKGS0lD8S77
         HrO+PsvSKO8RtoP3/SGrUs4152zglNJ5BS1RW3q3KBL9lhX0i1N7idgx8WHt0uJM1M4i
         dtNNiUo65jFjfR6shm5UmDj0VsdJ9rkXJlHxWjdH7HRnqreDyT2sI5XKvAeUmCwlwhn/
         nWDshvf4QA/p5XE2nRUWbwkBuK1x6MdjhpniSGY2oaZD4Eq0ErM1mNxZ4kLM4Ug1/njM
         PhUvkx9EMNrs6RiMN2HPrkHtB/Q4kPNTx314ko3PgaVvM6cQEU1jXa5Vrw4QD3CfdS3C
         xguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870196; x=1687462196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt03LJsdP7nx9fgeMadivdqMRjcceTT443SeukE1cbo=;
        b=PXootaxbY1gVBjvMVGto6W7HRxq8OnlzBawub3Y/yC5KSo/VSoKxBCtveBRgPBPTU5
         rtzanDtcyeAvqrUh414W0pQJ+lU1qV/kLC2x12BAo1ddxwe5taIOuPMyrqjKLvUiGQox
         tctNmLg5mfKk2mrXN3UzmxDSZZbn2kpRCY9O1rtctZ6PtbJJUgz6vMxc7G/Mb2b+EijO
         3q8R+gDPxEWmJb8EKnE/SSI0y5vQAi9UZw1NYIGYxGHEH6k4TOJYKbCKdDxNHvYBEl10
         Q+Nnv8m3p1klbTAMxwPH1T4TibZyePknpMAEj7pUjjbG+1XugKnhiitk/RbndjHHaQ0M
         ZfPg==
X-Gm-Message-State: AC+VfDx57DgJIS8lwiI4s0EsNiW4PE5zlAifqivmWlzCt0YSFDIaDKoY
        YshAsx0iKm+aHRpRx24mgoYea69nnzoNAaw02HAoAGQ9SElZfox4UJSUQF0xCYl809zbG9SOCZy
        OsnHeqWTdiOfxep5pmaPjbU7RFEqQb2vYb3ElgDDC98T0D+dO7IExb7NVisccvHSP8w==
X-Google-Smtp-Source: ACHHUZ42Lu2EewKXdR5Vu3Bt3lq/JOlz2WI9UvLyki4D5vux8D5Rl2wjPfQB6nQ5pgZRsHp+XgTOW2iZD//WH74=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ae5b:0:b0:552:abfa:1e77 with SMTP id
 g27-20020a81ae5b000000b00552abfa1e77mr8695917ywk.5.1684870196590; Tue, 23 May
 2023 12:29:56 -0700 (PDT)
Date:   Tue, 23 May 2023 19:29:45 +0000
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230523192749.1270992-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523192949.1271671-3-calvinwan@google.com>
Subject: [PATCH v2 3/7] sane-ctype.h: move sane-ctype macros from git-compat-util.h
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Splitting these macros from git-compat-util.h cleans up the file and
allows future third-party sources to not use these overrides if they do
not wish to.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 git-compat-util.h | 65 +-------------------------------------------
 sane-ctype.h      | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 64 deletions(-)
 create mode 100644 sane-ctype.h

diff --git a/git-compat-util.h b/git-compat-util.h
index f8e68baf29..9d3c21acbb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1150,70 +1150,7 @@ static inline size_t xsize_t(off_t len)
 #define HOST_NAME_MAX 256
 #endif
 
-/* in ctype.c, for kwset users */
-extern const unsigned char tolower_trans_tbl[256];
-
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
index 0000000000..df06bcbe14
--- /dev/null
+++ b/sane-ctype.h
@@ -0,0 +1,69 @@
+#ifndef SANE_CTYPE_H
+#define SANE_CTYPE_H
+
+/* in ctype.c, for kwset users */
+extern const unsigned char tolower_trans_tbl[256];
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
2.40.1.698.g37aff9b760-goog

