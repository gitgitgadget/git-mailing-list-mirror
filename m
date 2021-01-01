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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EF2C4332B
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F37E22241
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbhAANIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbhAANId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE2FC06179B
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 91so21949766wrj.7
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6ehXc0eDt9V2/mPFi4FPt3yADrxebTjUhthAuSsjhZ0=;
        b=nBtKNn+9EPQcnpmz5ApcjT7evxByRtzCHl/+/rLFFj5Z5yZTUyYHsG97QO6ueE25M/
         PoQyDjykl4cMn44GBBzDXfJXlJ8oW6Gh6TSqF7iA6a4FrVYDdmvdI59JoG+lOjn2QnQT
         fHBRjIRxs55MUSHn/7s5Tcd1zrHcii1xAJV8iy8KKgbabCBySw0UoIDRCwZ6Vkicav8C
         J/DjcaBbmlxmvPSi6nPX4QX7kScKk+LYsezFFHFG1R8oMCO5b6h8Q9plel5IL+i1zNnw
         nDy0H5h/UZnWM23k9qllGuNdTFqQGgQXSD2/XxZBm34sj6BcTkbVTshaLnStfD64Uqy3
         SG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6ehXc0eDt9V2/mPFi4FPt3yADrxebTjUhthAuSsjhZ0=;
        b=Y0eQTModH0BZAAp64rvxDDZz6y5jzMpTYI0ZkJn+QFc02kCDrXnCN+XF2/nGOTWEXP
         ypZBRC4VZE6PQNuXePQVxRj5RYMPIwaWCRoFrYhXmbF0MOBAWgPNEfroRYsit4uMkD+V
         /kVoXKDUKxDGoQp9rHZTBMBmRCoVkIsLjEhfNT+3475qXo+sEQAe9nBiWrH5czAMIC3m
         ORdxtCvN6TstDeKTnREnn+cHRLtdvg1mZizcbS8DlqZkTa38vGS1ovV961ddzYIgk8zC
         9ztu/G3oqaMvpxVIbTZeHoKN+5G5WmliOg+Tt5vZPqkRmAYarZyrwTnECDIgQePuczq8
         Yh2g==
X-Gm-Message-State: AOAM530QFW4RYMT8Th7S7vDBl5tOFQ76sdPDtxoVUjZwvdCNGeNzZJQU
        NX0IsgZTwqG9x2wfb4fW4BFx4Y9lIvw=
X-Google-Smtp-Source: ABdhPJzVGZI9dnHxEqvnLWsCZXPL7w6FQFFAazX03TtLKO/l4N1VHi643e2+AkRgaBL6bGasUSxzWQ==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr66691543wrj.79.1609506436935;
        Fri, 01 Jan 2021 05:07:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm17619167wme.11.2021.01.01.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:16 -0800 (PST)
Message-Id: <d2af7e21ca13c4c1b19ab363246cee5a395430de.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:04 +0000
Subject: [PATCH 08/12] update-index: use index_name_pos() over
 cache_name_pos()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a64f2f5a8f4..9e57779731f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -233,7 +233,7 @@ static int test_if_untracked_cache_is_supported(void)
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
-	int pos = cache_name_pos(path, namelen);
+	int pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		mark_fsmonitor_invalid(istate, istate->cache[pos]);
 		if (mark)
@@ -327,7 +327,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
-	int pos = cache_name_pos(path, len);
+	int pos = index_name_pos(istate, path, len);
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
@@ -377,7 +377,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
 
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(istate, path, len);
 	ce = pos < 0 ? NULL : istate->cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
@@ -437,7 +437,7 @@ static void chmod_path(char flip, const char *path)
 	int pos;
 	struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(istate, path, strlen(path));
 	if (pos < 0)
 		goto fail;
 	ce = istate->cache[pos];
@@ -634,7 +634,7 @@ static int unresolve_one(const char *path)
 	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
 
 	/* See if there is such entry in the index. */
-	pos = cache_name_pos(path, namelen);
+	pos = index_name_pos(istate, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
-- 
gitgitgadget

