Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71337C433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 20:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiAWUd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 15:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiAWUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 15:33:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A22C06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 12:33:55 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v123so21619228wme.2
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWb/Biln8AEpRZ0jlxGzI094u/dWEeG+1EMbABsqioI=;
        b=foV9zf7A3cRg2MTUBoo0y2QXBwjgSyL0zFRC+09EkDd2XuMUMnG1/vaaJNaE006rYP
         UnmLu4vcDa6pDuelc3mPjvv2uxXic3lVpKvQpp04k3TiJJdaGGWm8rZF5ZQ0/ZqSSqCY
         NM5CTjMCfIa/Q1LQ/R5+1VGV7Sq2Fmkp/BMKitcABwseCG66FoSdY81wC/2VIPBCxa+3
         CV0MEas7jJtunycWrjeCNfQ/Ot4QOn4IK+UEPZBUxzhfqla9jmQo5Zbc7q/KIfKZGHK9
         WfZjck7dfY0wfLyfSMEe+l9PAc8VI7FZN4RNnwi+9wK9M7SbxIIOz3t9LQft196bSRqS
         wG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWb/Biln8AEpRZ0jlxGzI094u/dWEeG+1EMbABsqioI=;
        b=OpjmC0rMD/vXsk0BNGYBeONqqR0o5qNASY32PeLVexZVT0AeWGp0m9JJn03E1I/CoV
         gCFZKIIYvPoZ/3qBWov/YItF4BYCb+VusY3FjAQsVt+e052KnP8BlrwtHdoBjL0hpq0Y
         AZMQv1voqNlNKlnio7HLQ4I0SN8HjiyY+AOBnvtm+1E9qUZVJMs6VREpN/6HtQKCQXNg
         k9ajyRC9F5FNEB6j7ueS0mCHxucNswuqiBPev7l4XRXnjBkJBMk/rCc6TDASGEp4VlPV
         salRL5QtqbILUTC2U3TU8sv4p7RspNTp5Xt37Unu7Dbkgq4KeWKMGyKbe+IXOLNNPe1a
         VKaw==
X-Gm-Message-State: AOAM531dVFuPbj/Nf1ejHD8EEG+83CSF9PXFmU8+8bCJRHfBaeEi2/Ca
        4Xd4dDsOVjYlsg+aDFrVjGmRdDmsQCnEiu2P
X-Google-Smtp-Source: ABdhPJxXxSyGKYq5vDK8ROY+91SgVaYtM7qqLOkTuttWNgkUQmKf+SW0jJzc0qOvn6eYW4kR8QGCIQ==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr9194854wmj.15.1642970034579;
        Sun, 23 Jan 2022 12:33:54 -0800 (PST)
Received: from Jessicas-MacBook-Pro.localdomain (global-5-142.nat-2.net.cam.ac.uk. [131.111.5.142])
        by smtp.gmail.com with ESMTPSA id b12sm12487256wrj.23.2022.01.23.12.33.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jan 2022 12:33:54 -0800 (PST)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
        id 9F983C6F98C; Sun, 23 Jan 2022 20:33:52 +0000 (GMT)
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     git@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH v3] mem-pool: Don't assume uintmax_t is aligned enough for all types
Date:   Sun, 23 Jan 2022 20:33:47 +0000
Message-Id: <20220123203347.74869-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220123152458.72540-1-jrtc27@jrtc27.com>
References: <20220123152458.72540-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mem_pool_alloc uses sizeof(uintmax_t) as a proxy for what should be
_Alignof(max_align_t) in C11. On most architectures this is sufficient
(though on m68k it is in fact overly strict, since the de-facto ABI,
which differs from the specified System V ABI, has the maximum alignment
of all types as 2 bytes), but on CHERI, and thus Arm's Morello
prototype, it is insufficient for any type that stores a pointer, which
must be aligned to 128 bits (on 64-bit architectures extended with
CHERI), whilst uintmax_t is a 64-bit integer.

Fix this by introducing our own approximation for max_align_t and a
means to compute _Alignof it without relying on C11. Currently this
union only contains uintmax_t and void *, but more types can be added as
needed.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---

Changed in v3:
* Removed first "Currently" from commit message body
* Added explanation for _Alignof vs sizeof in comment

 mem-pool.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index ccdcad2e3d..599d8e895f 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -7,6 +7,26 @@
 
 #define BLOCK_GROWTH_SIZE (1024 * 1024 - sizeof(struct mp_block))
 
+/*
+ * The inner union is an approximation for C11's max_align_t, and the
+ * struct + offsetof computes _Alignof. This can all just be replaced
+ * with _Alignof(max_align_t) if/when C11 is part of the baseline.
+ * Note that _Alignof(X) need not be the same as sizeof(X); it's only
+ * required to be a (possibly trivial) factor. They are the same for
+ * most architectures, but m68k for example has only 2-byte alignment
+ * for its 4-byte and 8-byte types, so using sizeof would waste space.
+ *
+ * Add more types to the union if the current set is insufficient.
+ */
+struct git_max_alignment {
+	char unalign;
+	union {
+		uintmax_t max_align_uintmax;
+		void *max_align_pointer;
+	} aligned;
+};
+#define GIT_MAX_ALIGNMENT offsetof(struct git_max_alignment, aligned)
+
 /*
  * Allocate a new mp_block and insert it after the block specified in
  * `insert_after`. If `insert_after` is NULL, then insert block at the
@@ -69,9 +89,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 	struct mp_block *p = NULL;
 	void *r;
 
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
+	if (len & (GIT_MAX_ALIGNMENT - 1))
+		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
 
 	if (pool->mp_block &&
 	    pool->mp_block->end - pool->mp_block->next_free >= len)
-- 
2.33.1

