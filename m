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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3A8C432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E90C60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhHPUSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhHPURy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:17:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882AC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso278302wmb.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aEB8r79CMso5340lGInaYi5ju/WVMuCc8Yglbgl/Vmg=;
        b=i+ZCGcAhWY8oJgzU748yhwgq+9PnrFsDHSjuCsD2TYtHxD7dXTrklS65TqcVIO8v9r
         T6T+JArsli213Wpyhpw66gv57HxHEv7Dx2knQbFFbxsY3VXkG0cjq4/30TJEe/17CyDM
         HqLmKtWkZf2XvFzOOeqcx3p4IDXCE7Ay79oOouj2DcckiPQdQz8L4Kc/i2l+Y3ZC1+r3
         ZGrqTIh623mgSyQuBUxjfBzJ4w3KWic7lVsssmMz4hDzjwnymnWGkjUgPnEjchVoFnj5
         WZ8S8oEXgtTlnWuAtzYsgS2Lzk6Hmnh1BF2logZz44VaETFdCu3myX+X7oYWRA8iWms/
         h6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aEB8r79CMso5340lGInaYi5ju/WVMuCc8Yglbgl/Vmg=;
        b=O+/mgjAXxwsBe4sem+EyPeDJ2Bqz5yzGDr4mVabzR3NrAYntR2/g8fTkq7KqZWDIcX
         m2Fu0zmjg/8J8y2Yv+E8Dqd4ZogsUpTxl3bFXfwYWnTvJriylPkbTpJCTxogBmp1+Su2
         mohzMH4sx7rMUHm8AwGXJRT0VD9b1GcHK/a0ger3Uaof1EYQ+FRwY7QgZoHr4KaKFB4Y
         STgpbfl34vFJdezYqlTTzl1uSTO7ROeDFM74nvCHiV0QlmLhNQIeqV8K3SQs6K4BsBw5
         HJGDnyphW/fHCJJhqZzEnA61V6d1MypSsOS5IYO3Y3Ds3/2H3FQtwy1VFwvXRFKQdTYi
         uAjA==
X-Gm-Message-State: AOAM532ElFzFpRO9u4Vh2PpmBvYdDrnsVT5wWKeuPqaDo19Prfd67EUh
        lB7aABs1kttGeENoWdsLaafLRkCMrrE=
X-Google-Smtp-Source: ABdhPJzsMHe42qkbaqCykR8iMtg8UtvU3lBJC7yLP2SzSEwnF1pAjynL9riUxKdlFbEIz53mbV1FEg==
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr9558wmg.37.1629145040792;
        Mon, 16 Aug 2021 13:17:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h126sm199574wmh.1.2021.08.16.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:20 -0700 (PDT)
Message-Id: <c40393e83e1d57be9429211cdebcb715e9d319d8.1629145036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:16:52 +0000
Subject: [PATCH v2 01/25] hash.h: provide constants for the hash IDs
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
index 27a180248f9..f9e8d4b736c 100644
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

