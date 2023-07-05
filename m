Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD85EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjGERJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGERJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:09:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621F1199F
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:09:44 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-553d42a7069so9019819a12.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688576984; x=1691168984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GG/ynIDIqdr5TiH5TSrgB3HMRA6tV2Zf6m3YMF8JHQM=;
        b=DgEwYbHdCTRQcV+KhqYdr4ejEF1csgJDhUKOmaoBwdb2iIfXcOuGYeHCp1uR33FQFW
         S3Jd4x0CReJYkiU+mNlV9Nw9XYyIaPduqN/b6Ru9hIkwscSPaWCZKzMeAhF1Hf1POciU
         vlpmJgziqhYKjYNMF65W9IhrfVP1lzxSiS4rk0WRyLG3CdrlmaP8qo+8xLE0w56O+k7n
         MV/MtlAvsgitZ9QzbeEePSu8Wr0UObMMN+9X8aHFN6pg8R0fTdY8LkHPg+PxlXuzo5Xs
         oIMLhBLWexSs1unW32Y7TbNm12ax37ftAmW0k/9ef/Ow6qqayQ3jjjkUy/BO3vnbE83R
         1ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576984; x=1691168984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG/ynIDIqdr5TiH5TSrgB3HMRA6tV2Zf6m3YMF8JHQM=;
        b=CmcVMuyD4n+dZt+r/m9SoQYfekDOEJkGUPgu0iY/35J70Fg3pHCWf9anPwhCMh1Ewm
         iy9si6T2Tq7MIcWkzt6xqqnrlJnbO31msI3nNzrzMJEfzvMpWecF0qcEAugINwXk3p9c
         VUEgBsacjnH64gApYTK9ET7MRsw1UfOB3CMv09YvjpRvebld4l1MmjYEqms7vBQUrCfh
         ZHWbV99IavMapX/Xxkw2TBedIpiDuf3KaTsFkHKNKascJfti9LFA/nH7sEQxeyyZQfjE
         fKzxuCrUEooCsvKZnlLAzMpFci2E4cVLJt7ML6n6RzeecBny8y5JM92RM0/bLJpHUpRt
         kz0w==
X-Gm-Message-State: ABy/qLYcPCaiVrwC/5NlLYBZLeHzujDC8y50b0ZVG8MDSGQ7ad+UdAZX
        arKuF+fqBNdkoSbK0CoyoegOUV2kQNrfwXQEgQwcotlqwR58euUX9P4Z834vdbhrzL7+FBjZ9YM
        i8/RkLGQHTip38EK8Uj0+piEjIWhi3X4CyI6Bl8P52psPiq0RM9OdDyzsfW38y9nWEA==
X-Google-Smtp-Source: APBJJlF/mlT+KV1uE8WfWLt9507NENhpkhpJqv8kUhI8oHMmqRu88Xxo8t7xZkaR2MNuYez3jzQ658yeLUSc1YQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:5c17:0:b0:55b:49a8:49bd with SMTP id
 q23-20020a635c17000000b0055b49a849bdmr9947400pgb.2.1688576983796; Wed, 05 Jul
 2023 10:09:43 -0700 (PDT)
Date:   Wed,  5 Jul 2023 17:09:21 +0000
In-Reply-To: <20230705170812.3833103-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230705170812.3833103-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705170924.3833828-3-calvinwan@google.com>
Subject: [PATCH v5 3/6] sane-ctype.h: create header for sane-ctype macros
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

