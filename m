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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F672C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1696960FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbhHQNmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbhHQNmE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83BC061796
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j12-20020a05600c1c0c00b002e6d80c902dso2169574wms.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6nw2gGbgLgD/ItZe7r3+xcBp3zrwfuUcf5x285TXfC0=;
        b=okL0uHKl4GtWN4hEBgDqziARz3wZeRH+QDuACXUJ4GGVIlkozunoJSNVdVDLVljqnr
         u3FmO+A1Zbp1d0OGrEQPBnEslko2DBZw+qsZlYjiG3NOwJdgcdSmJX06fIDTjrcpXYsQ
         Lygas0kQyGwO3vISSc1Lq+uzcbbEJullMva9qSTqqWo7wLcwFkXHQXGCcSmpQiRpQvW+
         nDDNsf9l5aCVp8J7Boqk53e9G9lDd9Iy4QPD6VT8FIsGJLOmd6A/RTs6KzUzNHjBiO17
         vGiNHpE2i26yetyjXizoG+YsutXF4tomH5EHcFu9z/hvYemoLyxRmvHDMzuuUAk1yc6F
         KABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6nw2gGbgLgD/ItZe7r3+xcBp3zrwfuUcf5x285TXfC0=;
        b=pwvPujq9erQ1ISq5NhZcm9+eIgjoALTK7FcPh+EvdfjwyaemwjZfRxj7JBSJ4qB6yU
         PEzuYUkNOEeF3UL6nI3de9Uy9q3hzZP5G3T8xfMJL8isHBca/xeQ7g5bopu1M1sFGAV+
         O+hr49uI0A6HXINKfkDsLdRL5jUMHLxoA7VIcmSgvLpbsX9mBaj6i/DfKo53IXd1Wl3N
         vxCifPgI782APgyenEGZMNLdWM1VVObRRni2HwHLct3w4+cvKkeuvxg/17csHU92fZyV
         MCuCPMkU9qdtZIJDw+2uIFJ0hzo4xNZ0TcqUQZkn0LXU02C1roWe8pgrvkkkKIR132Ll
         DKqQ==
X-Gm-Message-State: AOAM533sShhr7uER6bGXDKNtn08SKZ2kUf7106yvoB1TroN8ZpNAlMX4
        7wFmK/acW7DmCyRqnOHWRkLW4XQToWk=
X-Google-Smtp-Source: ABdhPJw0qMop5usupbOXL1vMiUb2rypPdclFEID0HfLcVnztIaOw2ZaZMK4isO5SDXFDN96rLP+VFA==
X-Received: by 2002:a1c:2904:: with SMTP id p4mr3346825wmp.178.1629207611460;
        Tue, 17 Aug 2021 06:40:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm2037065wms.44.2021.08.17.06.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:10 -0700 (PDT)
Message-Id: <cad3c4835a2945cfecc66da161fefa53d9c19574.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:39:43 +0000
Subject: [PATCH v3 01/25] hash.h: provide constants for the hash IDs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

