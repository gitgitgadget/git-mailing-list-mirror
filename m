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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C3C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFC4610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhGTQYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhGTQYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49777C061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u1so26832446wrs.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6RpFJu2vjGaQd/XxCqy3glY6M+uGGVu+N+4X/7oK2bY=;
        b=lobke5gH3DKryrZjVcQcxkT1IMTOw/MsLFbQEoTkAhtLtKAkeSem6GaiALXOSBc0gV
         48xtOLyNbz2pRsmR6+oE+SUKXUp+2ETeQZQUcxczuEuT1dHQeoZ7a0Sj0L8cwenvB7FW
         6dhCxrwtDBzLI0UvJi8SvWt5aNYSlXwoeOu48cYu+lGeT7p4y7f0ncyE0dbD83Yu5QlP
         I2WE/mVdsqtCVIk7rpJvqLKf8oxthOXnCdKD+blWx/s7nFaCG8FuhKE9dQeNXbx/jWsF
         /2WWMdcitb2M4JqwW/bayyQ7FlBmqNX1NZSHQglSIrCJ2GdlNze+sj1jV4hpk0Fll1v1
         dMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6RpFJu2vjGaQd/XxCqy3glY6M+uGGVu+N+4X/7oK2bY=;
        b=l0ZxectRrmnkCWtBNV4QNVok9YLMIbqJh1rm8FUInYZGHsb+1lvZjro0/d31tUACwL
         gYcIAJBuo7LFcwD3q7T8b28sTcKQRc2iJCagGiKyh72OIwdgWfpM30cRl2oSoVV/ddiW
         7HbWizVjdHTpsiX464qfnbJHD7bZJceKyc4oIn0FXENRWlPSotuC/bPjwx9BJaO5Sil4
         bWMeOkt4ZUSShXrpvYoCcHqkNJnzRmeYTokaXClxXInkeewQvveUUT4i05puq7ewbtR4
         qktr6mqhGZhDTCYoMOvcSwNt5H6gARPN13Ea+nUmyGdO/ZonzU4TKLgzjzCFg1Sc4hLg
         8T0g==
X-Gm-Message-State: AOAM5329JyHx0UxTx/rvdToPoq0ayFQHyXATiyvlcSunaG4OEbeGI0Ue
        NmLD1rS3DUpulLtxv5bwHNbnFPOs/YY=
X-Google-Smtp-Source: ABdhPJw6SfVYVjFpWNxPDjTzOoX7yTQJNAfPDbReI471AHhgkhverjQ/o8+Fz91vZhqaXkIWeeBeuA==
X-Received: by 2002:adf:f908:: with SMTP id b8mr5153822wrr.302.1626800688873;
        Tue, 20 Jul 2021 10:04:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm29292363wrw.36.2021.07.20.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:04:48 -0700 (PDT)
Message-Id: <dc24dccf041d78d9d50dcd25aa7f2cdfe960f916.1626800686.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:21 +0000
Subject: [PATCH 01/26] hash.h: provide constants for the hash IDs
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
index 9c6df4d9527..45b207f37cc 100644
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
index ecca5a8da00..5f2b271e8bd 100644
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

