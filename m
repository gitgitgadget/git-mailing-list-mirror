Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C578EB64DC
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 20:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjF3UYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjF3UYP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 16:24:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19CB44A0
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:23:58 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-528ab71c95cso1723961a12.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688156638; x=1690748638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjvjrM2solQaB/yRMs3mzirHvRh2EwQtgVo7BMlQxIU=;
        b=vCPq4ic95n/1fEwu0JyNePTiirt7kZ7ccJ5RocwfhZEATBZgR7A9sOww03sNG3cYsk
         D62JoR2X1GGf/FgXBNEyri6Iz8MjLxWK3WqYTHJirneVCs4ROT1i7noWkUq/vd+wyTN3
         jkG+BxuO714tuB/FAiafvYbzrH+D7ab61Uu2pDx6JlApCuC1pnUAwm98tk8ORkqcO+vb
         fNSKYAkEheP+k4hajN35R9UO+nANsL2cwL8jfy2f/CKH7w4TiWz/z0OZoiejl957RZIP
         XHnGt+sGTE0q7u1PMnhZjUI1QLfvug3SbOcAWVhac8NewISoqa0SvsuarLbN3Cm7P/U9
         Y0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156638; x=1690748638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjvjrM2solQaB/yRMs3mzirHvRh2EwQtgVo7BMlQxIU=;
        b=IzSO38TnSS8Xg03tpgnfjYvbpp+4pX1Z1PpgflME0X0/5o5pU6rZZYkdXljD2MR53K
         pB5etopVLMzaqTBXmaNhu5cspiTCurhsMDcB7UuASHx9u9dFpSThlIt4kDy5PsvdQj9Z
         7GQBu7aShc3fOrTLHojddr3TwR+4D9K002cHMxyW5ywzBciT1w7YzsrYfYqc/cTqekxl
         fGxZdp/2+vHkkQpQYk1E27iwslMIfV1PF5q1c/6mO63qpGphqp04vSDeq1eNdhB4o/i7
         7FhTmfoj7p8dhwy6c78aLc4tZOPRBZuR8xTHzDFYPt8y+PkRiryiWKXA7y9NOnZ+mPmO
         8Ohg==
X-Gm-Message-State: ABy/qLYUp7N90UlIGSCmoT13GK8Tz8H8cBpBmvswLo5iJwL1T5tJF31e
        W2QxjOZH7EMehjYQTzegAzEjRczB+szhQB3AMtJTyroZ6IgwIbFnS9yuJGGB4r2xLIKNGQa65+a
        ZEbGK5bVnkBhYBCdwpVHr7ijkwFOQdtOe2jWfRAAdL0lr4kuoRzROeS/7+PEXYYzMbg==
X-Google-Smtp-Source: APBJJlFOeknGhzCCJseGc5dScCuFsKaYAnTirup9suLRIC7vCDWsXR7RIirqgZ0zoUTh0Cb+DXgNufu71tdN0G0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:1251:0:b0:550:d2d6:525b with SMTP id
 17-20020a631251000000b00550d2d6525bmr1031242pgs.12.1688156637243; Fri, 30 Jun
 2023 13:23:57 -0700 (PDT)
Date:   Fri, 30 Jun 2023 20:23:44 +0000
In-Reply-To: <20230630202237.3069327-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230630202237.3069327-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630202346.3069950-4-calvinwan@google.com>
Subject: [PATCH v4 4/6] kwset: move translation table from ctype
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This table was originally introduced to solely be used with kwset
machinery (0f871cf56e), so it would make sense for it to belong in
kwset.[ch] rather than ctype.c and git-compat-util.h. It is only used in
diffcore-pickaxe.c, which already includes kwset.h so no other headers
have to be modified.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 ctype.c           | 36 ------------------------------------
 git-compat-util.h |  3 ---
 kwset.c           | 36 ++++++++++++++++++++++++++++++++++++
 kwset.h           |  2 ++
 4 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/ctype.c b/ctype.c
index fc0225cebd..3451745550 100644
--- a/ctype.c
+++ b/ctype.c
@@ -28,39 +28,3 @@ const unsigned char sane_ctype[256] = {
 	A, A, A, A, A, A, A, A, A, A, A, R, R, U, P, X,		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
-
-/* For case-insensitive kwset */
-const unsigned char tolower_trans_tbl[256] = {
-	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
-	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
-	 ' ',  '!',  '"',  '#',  '$',  '%',  '&', 0x27,
-	 '(',  ')',  '*',  '+',  ',',  '-',  '.',  '/',
-	 '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',
-	 '8',  '9',  ':',  ';',  '<',  '=',  '>',  '?',
-	 '@',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
-	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
-	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
-	 'x',  'y',  'z',  '[', 0x5c,  ']',  '^',  '_',
-	 '`',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
-	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
-	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
-	 'x',  'y',  'z',  '{',  '|',  '}',  '~', 0x7f,
-	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
-	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
-	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
-	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
-	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
-	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
-	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
-	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
-	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
-	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
-	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
-	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
-	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
-	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
-	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
-	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
-};
diff --git a/git-compat-util.h b/git-compat-util.h
index 5f916e1094..1832444fa2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1152,9 +1152,6 @@ static inline size_t xsize_t(off_t len)
 #define HOST_NAME_MAX 256
 #endif
 
-/* in ctype.c, for kwset users */
-extern const unsigned char tolower_trans_tbl[256];
-
 #include "sane-ctype.h"
 
 /*
diff --git a/kwset.c b/kwset.c
index 4b14d4f86b..bbfcf815a5 100644
--- a/kwset.c
+++ b/kwset.c
@@ -49,6 +49,42 @@ static void *obstack_chunk_alloc(long size)
 
 #define U(c) ((unsigned char) (c))
 
+/* For case-insensitive kwset */
+const unsigned char tolower_trans_tbl[256] = {
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
+	 ' ',  '!',  '"',  '#',  '$',  '%',  '&', 0x27,
+	 '(',  ')',  '*',  '+',  ',',  '-',  '.',  '/',
+	 '0',  '1',  '2',  '3',  '4',  '5',  '6',  '7',
+	 '8',  '9',  ':',  ';',  '<',  '=',  '>',  '?',
+	 '@',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
+	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
+	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
+	 'x',  'y',  'z',  '[', 0x5c,  ']',  '^',  '_',
+	 '`',  'a',  'b',  'c',  'd',  'e',  'f',  'g',
+	 'h',  'i',  'j',  'k',  'l',  'm',  'n',  'o',
+	 'p',  'q',  'r',  's',  't',  'u',  'v',  'w',
+	 'x',  'y',  'z',  '{',  '|',  '}',  '~', 0x7f,
+	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
+	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
+	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
+	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
+	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
+	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
+	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
+	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
+	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
+	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
+	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
+	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
+	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
+};
+
 /* Balanced tree of edges and labels leaving a given trie node. */
 struct tree
 {
diff --git a/kwset.h b/kwset.h
index f50ecae573..d42a793a30 100644
--- a/kwset.h
+++ b/kwset.h
@@ -26,6 +26,8 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */
 
+extern const unsigned char tolower_trans_tbl[256];
+
 struct kwsmatch
 {
   int index;			/* Index number of matching keyword. */
-- 
2.41.0.255.g8b1d071c50-goog

