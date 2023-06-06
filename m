Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C52C7EE29
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbjFFRKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbjFFRKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:10:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459F121
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:10:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568ae92e492so104604577b3.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071410; x=1688663410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bq8XCugr8bieFYszoRT0g4VB6mhhChuT5wCt+QL7bs=;
        b=zCW/idf3AgxGNNVB8GVs8r8FA93yufIrTiCaNl92sy01mzr7vw4ktBIlplruUBDyyM
         aod79AoGlWbaqUMmnsIYyy+FehUBGv8OQSSikJqeX5qzIlyHBH++Snj7HCCezoU1GYJA
         q15fgoKpvTuRtO8tjtfo985z4zSsuNCsNHsJUVGZ8U0t16MxPTRZeRGTjJVQL/cEnFwt
         5fHNAVh57EttGZYMzMS6jS81IngZM/iJDHEfSu4UefDLYawjVBhEVfbtF98gtzbvsttk
         iLnzfQi4t7v5UbifBddwD8SmbFoGwfO0T00Qo2suzLRoSjLjOf3E0q3NprH/ezZazeDq
         YLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071410; x=1688663410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bq8XCugr8bieFYszoRT0g4VB6mhhChuT5wCt+QL7bs=;
        b=VXSnkzhgEmqRlvQeGX9NCnyQ3Y5JC1XKQ/njZHgjge7gOflYnhmEuKBZv2B5+lpX7k
         fM1Uq1yPvz2+ohYQGM1crR4MyigM5NizFBaoXIysuxgU4oALZOkEi6LZS6eZNHQiT91C
         kSJbGWt/b9sEbP42tnVn61D5dI2UgdjM0CsbysxHNH97tUhk7HDQaUPry9AxuAwZJRaJ
         iFOkt/g7uVOT1Gx2xXzadAGpXWUqEkLmaUDXuu3RrW4Tf8N/EnIeFizoM022H46IQJCe
         MClvS1GXMiBfXEYOqpRah+ivuFJYxGUxqmEXyHOJRaFDCB5QemOVY7dqWn7/gS1z9cPY
         19lw==
X-Gm-Message-State: AC+VfDzgEOwPSM1FtWInwP/7wQzMkDL8bt7vvadkBQHDhHjwzIK0wKfS
        avNqe+LjIWX/udrmIxP+HMgs51sYzP1IrwgN+xtqA4TKrO1ZFgzY8j4RLiL0/Vj20+wZj8sK11k
        1u1GhD4UdPLK0v7goz6LLPsbaNoDcTzSLMJN4y51+n8vwRn/pNHcV7GUHDIealnlB6A==
X-Google-Smtp-Source: ACHHUZ522ViNblYacKLmtZhtKrsYRZiupjs+5YxzMc5ThkGxZMDAxCRWNoHK/8Nh5mGzbc2TSB21CYCjNW04utI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:d84b:0:b0:54f:bb71:c7b3 with SMTP id
 n11-20020a81d84b000000b0054fbb71c7b3mr1301369ywl.9.1686071410362; Tue, 06 Jun
 2023 10:10:10 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:09:58 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606171002.914075-4-calvinwan@google.com>
Subject: [PATCH v3 4/8] kwset: move translation table from ctype
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
index 2151d8b437..9d3c21acbb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1150,9 +1150,6 @@ static inline size_t xsize_t(off_t len)
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
2.41.0.rc2.161.g9c6817b8e7-goog

