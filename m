Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFBC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiBXJdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiBXJds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C0279917
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j17so2055698wrc.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzOP65SSjnleu4bsPLWDPMAAulcEotSYv5F5/+WWYw8=;
        b=OerFsiCkzG8Hf6BEUXXXEwF2oRnBPmATnGYpu5RikUJcRDOVxB2uN4pUMourve6F0h
         o1q8rTSPT09UjszXgQWpP/kw8QjTHlItVwoOOe9l7P+tEwenJJ5u5CJ7hNfqi9CLKbhJ
         BGSQLklHBDWj5ofuzhcQ6NKVIsbAeTqv4lYkcztF4OS9StNWYDTzFsQO5DPxvDeSnH4I
         4VNto82W/cDurACeFRT0NrZ5OYeNssNLc8w9DiVYsRSGPMiPLqV9RgqiaB+nFKqnhAVQ
         Zuoga0HHRvlPfehP80J95jXNicsSCVXtg4MPw9rLdH9ePcJZ+GNQLxlvm5UM2cBP6J/b
         3xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzOP65SSjnleu4bsPLWDPMAAulcEotSYv5F5/+WWYw8=;
        b=7YC65lb2sH5mwnDMNUjcv+Lz6T1umNsTybk0VvrIghaX1Ds0WjDq4CvYcsLvp+pxIT
         00LvqOeJ6jrz3TpOVfqNoIdRD6NONOxkxBCNECd98z2FNEhsX57P+sJcEix6Z3KqFTt6
         5EPmfbB1yF2jK1i7+yLYL86PCGQU7OJKZWlidJevreFXGb2CxcEPDl847QxYQfVjzGBu
         vNO7igoXgMlea5xbntkRhjExDy/Lo2D0OPTcHtD0/8iE/CImtXDWwhUN8WcWFBsQQzNe
         eHXjslM8PAQYgW7zDH78g9hBnJ4bgrEYSBqohOplhjs7MA6F+z1iFO6kK5ftjbD+Hu1c
         SBBA==
X-Gm-Message-State: AOAM532mgv2NAtXhVVwqb3w3qd3yc9CPmCKpgCnOPTSIgGoZpKL6r7Pc
        KNcMZ6Ta/u0aYS/Mz6tRzFtrP3tLIU//lg==
X-Google-Smtp-Source: ABdhPJxUoo9bcCaj2/DK7cXoDK3M8BuRDywV+9R9KcGITLUwcj5bNxZazjIRT/tb7FfAmTGrVPOAFA==
X-Received: by 2002:a5d:504b:0:b0:1ed:f5b5:ed5c with SMTP id h11-20020a5d504b000000b001edf5b5ed5cmr1089064wrt.211.1645695196156;
        Thu, 24 Feb 2022 01:33:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/12] object-file: use designated initializers for "struct git_hash_algo"
Date:   Thu, 24 Feb 2022 10:33:01 +0100
Message-Id: <patch-06.12-1c213f2b403-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the preceding commit, change another file-level struct
assignment to use designated initializers.

Retain the ".name = NULL" etc. in the case of the first element of
"unknown hash algorithm", to make it explicit that we're intentionally
not setting those, it's not just that we forgot.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 78 +++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8be57f48de7..03bd6a3baf3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -167,49 +167,49 @@ static void git_hash_unknown_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
-		NULL,
-		0x00000000,
-		0,
-		0,
-		0,
-		git_hash_unknown_init,
-		git_hash_unknown_clone,
-		git_hash_unknown_update,
-		git_hash_unknown_final,
-		git_hash_unknown_final_oid,
-		NULL,
-		NULL,
-		NULL,
+		.name = NULL,
+		.format_id = 0x00000000,
+		.rawsz = 0,
+		.hexsz = 0,
+		.blksz = 0,
+		.init_fn = git_hash_unknown_init,
+		.clone_fn = git_hash_unknown_clone,
+		.update_fn = git_hash_unknown_update,
+		.final_fn = git_hash_unknown_final,
+		.final_oid_fn = git_hash_unknown_final_oid,
+		.empty_tree = NULL,
+		.empty_blob = NULL,
+		.null_oid = NULL,
 	},
 	{
-		"sha1",
-		GIT_SHA1_FORMAT_ID,
-		GIT_SHA1_RAWSZ,
-		GIT_SHA1_HEXSZ,
-		GIT_SHA1_BLKSZ,
-		git_hash_sha1_init,
-		git_hash_sha1_clone,
-		git_hash_sha1_update,
-		git_hash_sha1_final,
-		git_hash_sha1_final_oid,
-		&empty_tree_oid,
-		&empty_blob_oid,
-		&null_oid_sha1,
+		.name = "sha1",
+		.format_id = GIT_SHA1_FORMAT_ID,
+		.rawsz = GIT_SHA1_RAWSZ,
+		.hexsz = GIT_SHA1_HEXSZ,
+		.blksz = GIT_SHA1_BLKSZ,
+		.init_fn = git_hash_sha1_init,
+		.clone_fn = git_hash_sha1_clone,
+		.update_fn = git_hash_sha1_update,
+		.final_fn = git_hash_sha1_final,
+		.final_oid_fn = git_hash_sha1_final_oid,
+		.empty_tree = &empty_tree_oid,
+		.empty_blob = &empty_blob_oid,
+		.null_oid = &null_oid_sha1,
 	},
 	{
-		"sha256",
-		GIT_SHA256_FORMAT_ID,
-		GIT_SHA256_RAWSZ,
-		GIT_SHA256_HEXSZ,
-		GIT_SHA256_BLKSZ,
-		git_hash_sha256_init,
-		git_hash_sha256_clone,
-		git_hash_sha256_update,
-		git_hash_sha256_final,
-		git_hash_sha256_final_oid,
-		&empty_tree_oid_sha256,
-		&empty_blob_oid_sha256,
-		&null_oid_sha256,
+		.name = "sha256",
+		.format_id = GIT_SHA256_FORMAT_ID,
+		.rawsz = GIT_SHA256_RAWSZ,
+		.hexsz = GIT_SHA256_HEXSZ,
+		.blksz = GIT_SHA256_BLKSZ,
+		.init_fn = git_hash_sha256_init,
+		.clone_fn = git_hash_sha256_clone,
+		.update_fn = git_hash_sha256_update,
+		.final_fn = git_hash_sha256_final,
+		.final_oid_fn = git_hash_sha256_final_oid,
+		.empty_tree = &empty_tree_oid_sha256,
+		.empty_blob = &empty_blob_oid_sha256,
+		.null_oid = &null_oid_sha256,
 	}
 };
 
-- 
2.35.1.1157.g524e2d5a0db

