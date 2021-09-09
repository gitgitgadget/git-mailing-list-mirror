Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C988C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F2A610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhIIStC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbhIISs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F9EC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s24so2052645wmh.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6nw2gGbgLgD/ItZe7r3+xcBp3zrwfuUcf5x285TXfC0=;
        b=BFzYgpkWg1tboamSe2QUC7zbdp8MD8sOU9Hw3IK4grBTQACrNDuRb77p5wKnaBzv5Z
         fgRtJzM/XIp+I03j8t9jYUsT3u7S494t5yajhtvEbRLL3eDnlQQgkQKx6R8r8MBVD8f+
         NICbpDHgBnsxvXNauQ8jhFS/eiIGIkXYCUnqRz4Wey8tfeB6BOIXr88Jp4J2mY9k/kRk
         adTbgONNiIi3h1miGzISRGJ1T29VzngYndHaAusfkRbK/h2dUoeJ5+TfQkUaa/vjILUn
         uujBhFaCRucyzw//uipZk3iGcEb2AJAHaZLC27U1YxzLaG02gJcO9dvVb5WurVHt+6N9
         jgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6nw2gGbgLgD/ItZe7r3+xcBp3zrwfuUcf5x285TXfC0=;
        b=vAEGfbr/Ysf143mtRyLFpSoXjexCN+qFF6DL20bV84tA/mX5OOVEiTaSJTCsMhpKeQ
         kcegeF4wU5xktb1LwK0KAPY9JCyO4W8asDtk/gxVkKbRdgLWgE4Tuv9ASgNnyE1KQe3M
         f1SNbb0TnGrYa3swr3HzYsy7Bl1BLZpSvdGsljTCUS02rPadS6zHCcfrFxrlfZjBO8Fq
         OUPtB0F+VFh8OJNHGruj7dwfTDxor3XNaf3CAuJisjkL1YlFk4YFWViA4mI8H0YyyxX7
         pNGJXxx7wrW0OBuS0iCx9xATCERh3jadhMNybwxMld0ywv28UgJvKFkAQ9awyPYRfWFM
         bULA==
X-Gm-Message-State: AOAM531BG+JYVZKaqXGH8lHyqPuuhUwLpSCVHzbwLhWOiBCu9Quo/ZFF
        l/8NGS3b26txqMJlpxxUppWzKaY0yG0=
X-Google-Smtp-Source: ABdhPJxVfj7sfdwsReUAivwkw0TbLg++rwwYkpCHQRpQf3FJ8ha8S7TmIvRy4QfYqqHCsx28+jPLmw==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr4459658wmi.80.1631213266993;
        Thu, 09 Sep 2021 11:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm2425311wrw.17.2021.09.09.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:46 -0700 (PDT)
Message-Id: <8534c69cf84e2e4d39f57d5cafa4dec22d82ee7d.1631213265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
        <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:26 +0000
Subject: [PATCH v2 01/19] hash.h: provide constants for the hash IDs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will simplify referencing them from code that is not deeply integrated with
Git, in particular, the reftable library.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 hash.h        | 6 ++++++
 object-file.c | 7 ++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hash.h b/hash.h
index 9e25c40e9ac..5d40368f18a 100644
--- a/hash.h
+++ b/hash.h
@@ -95,12 +95,18 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 
+/* "sha1", big-endian */
+#define GIT_SHA1_FORMAT_ID 0x73686131
+
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 /* The block size of SHA-1. */
 #define GIT_SHA1_BLKSZ 64
 
+/* "s256", big-endian */
+#define GIT_SHA256_FORMAT_ID 0x73323536
+
 /* The length in bytes and in hex digits of an object name (SHA-256 value). */
 #define GIT_SHA256_RAWSZ 32
 #define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
diff --git a/object-file.c b/object-file.c
index a8be8994814..7bfd5e6e2e9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -164,7 +164,6 @@ static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	BUG("trying to finalize unknown hash");
 }
 
-
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
 		NULL,
@@ -183,8 +182,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha1",
-		/* "sha1", big-endian */
-		0x73686131,
+		GIT_SHA1_FORMAT_ID,
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
 		GIT_SHA1_BLKSZ,
@@ -199,8 +197,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	},
 	{
 		"sha256",
-		/* "s256", big-endian */
-		0x73323536,
+		GIT_SHA256_FORMAT_ID,
 		GIT_SHA256_RAWSZ,
 		GIT_SHA256_HEXSZ,
 		GIT_SHA256_BLKSZ,
-- 
gitgitgadget

