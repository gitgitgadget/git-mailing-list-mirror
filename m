Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F38C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471C261391
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhHWMNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhHWMNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE87C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso1951185wmj.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeLyaNsauJdwnKKgFBf70fF4cz75GrlVuieEBksuVFA=;
        b=X2t/P5agktAdTc/HKWgqJSgVIbd0eCutVtCZfMH95YNimPQJpakoYjngsDuULXWre8
         AdDohTljNBPKg2gn3M3AHzP9zvvgJhxC/EFP93d2Anyj3ltFYq7FF1HEijBmLRkwV7ni
         EvTIA/CalZvDOwcrwi5+yZyRHDMNoRtu1Ki0q+4Lx2P6V569eR9U/WyzxLRGwpFmnOpS
         3GGG+hQIeC2uV50SfnpxONn67db9voQcq1BFGxGQC3OoGmXTD7CxLiMVKVyAhpcJnjHB
         poe35jstN7fxGst9nhGq5MPvMTF45PUZ2v+83OUBc2wov9jwC4KyyCgsWe3H2Exn+Qxd
         +kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeLyaNsauJdwnKKgFBf70fF4cz75GrlVuieEBksuVFA=;
        b=HpHMzvW9XhQJw33SCgKT8fH+TT1uKQ/rzTrNqgOmy22BQcrk8urrccN17V7UZTOA87
         zFr2ejkWdtqe5Tf6Srsy/ddM7QCt3W4R5PHx5Z9ua8oKy21otcByL0Qr5EAZUeTLy7S9
         PL+LtA1WBt3HeV/ssSPnuq8BsCQrpTl+9UKuZWUI85JnXeWaIbsaSKaWwNhICxtAn05Z
         fzue5cBJRqxbSoCbzCR8FTM30boQ1BkIxurhgDpGgXe0wU4L9F6DA+rH7RoX4SOoTgt7
         oPTfPNEdchGsPTYAZzSG1/v+sJJHfTin0IxJpyyRssivWWJ+zxqmClHOjowMn4bU7OlM
         lZZg==
X-Gm-Message-State: AOAM531OjYPoFvZBYJc6FsmB9YU9Ig/FAihfKtxWRtCrJMZIL0grJA8R
        8uQWEmSXNNNXAVPKVRefzembSXdvUOGcP/Ze
X-Google-Smtp-Source: ABdhPJxXNwMearYRLPhGGO2e5orJiCCItgOfRyUcFu760xtIJJ3FQVtVSDZgWmm70gtWte5gf94MYw==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr15840192wmn.78.1629720775845;
        Mon, 23 Aug 2021 05:12:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:12:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 01/28] hash.h: provide constants for the hash IDs
Date:   Mon, 23 Aug 2021 14:12:12 +0200
Message-Id: <patch-v4-01.28-295ccff312f-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 9b318eecb19..e8ca385a09c 100644
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
2.33.0.662.gbaddc25a55e

