Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65AC4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A251B60462
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhH3O64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhH3O6x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:58:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80591C061760
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:57:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g135so9000803wme.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6nw2gGbgLgD/ItZe7r3+xcBp3zrwfuUcf5x285TXfC0=;
        b=d33BB/6bmnWGE4hii88fmG8iub9xQVyXwIwIwDBFOMuKiAmAh2JJ2ZVQKlylF8HUAo
         agTSBDtV+TR1EOtqnysDsdHOyqM4wuTb2bQbb+08w7/assRAK/LItIAKyFsLmsALgB76
         fr6Lbf0+gx7br3sTV+BGJ7PKUTy5LyKP1V1/cxLm5W8qZY0gf7zeef0REIsvKsH1RhcN
         6FmvOK9TZnmTmsQAD9hXHnJTRPOCGyuIDlif1CfgnAUUKmrd+Rbqv881W3JfGCOcCw9y
         /7l54YLxAjuhrrG3SGjADztBaQ0A630NRlWztOpE9iVNmkkyDVsQdvFdJotRa48/XkjR
         LHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6nw2gGbgLgD/ItZe7r3+xcBp3zrwfuUcf5x285TXfC0=;
        b=E9BYKDY9OyRPk6yMN3SoJksTsKBYtO6ipTKyS1qTvbVoVMYAJfdmw3fPFQeFsgXpc+
         yCzSSpcKM5iUi7/ed3GcoowBWTXS+5T0SsbRwdrnzLZsARX9CVIIARyRuA4ESoefMk+l
         JgDOeCjiGMmrQ7HQvXzvWZ/rvO8kSWXQntU8V1y09CpOZ/A9k5gutPWFX6E7TGrSsPUz
         bEE87VwmORL6gnatacj9CNnnTJlR8rFVqxZZSeNrA4z39eIUOenvBGqwaaG2S4lQJDGa
         xx5piDIdRVE+dX62oA+PUAa2z3Y+zHYgxKgcSOVuGfL9EyDX1TnKj2Ee5HFZSIZR6jtr
         dPgQ==
X-Gm-Message-State: AOAM530XcnlRixLvUghq/AQJJaG95Q6kox8a8Tix0ShgJCaPxuR26VrA
        FhjtYF2eMX7lb2Tq+OEuPbsMVMT8HNI=
X-Google-Smtp-Source: ABdhPJxdjFwM0JnPG0AgDqwT3DcUmP/vHgLWeZX79bHLPRLjGx5GDcwy/sjDLmi8EAHVxNTYkBsMjQ==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr22449793wmc.7.1630335478160;
        Mon, 30 Aug 2021 07:57:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z126sm14506135wmc.11.2021.08.30.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:57:57 -0700 (PDT)
Message-Id: <b9ee8cd8e9fd030910fd0cee37c01fd9a44dd430.1630335476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:57:37 +0000
Subject: [PATCH 01/19] hash.h: provide constants for the hash IDs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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

