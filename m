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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3465C433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DEA227BF
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbhAEEob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE6EC0617A0
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m5so34833241wrx.9
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YdKJNJU+VGWKXDxEbhTBS+DhIooYcT8eg3fpuPnwn/Y=;
        b=cHP6HzfSLEer1PCitQ1GbpqZwg3l/kNojCEnAW4+9JRZPNRlBmhuZGRbMDgchdTzwJ
         /SU2uIlG0ZZ/3DqNgUotrLG+B3jK+BKs+H64jDXwltfEPbe5uiyQ1iyNLgf8Corjx2FM
         tLh/NI8Hyq2HDD0sZKz/NdI77qOeZW+jQj9/gKrb4bPXxXSV0vDAi/cvUhNSYYkshTD6
         Nb63KvLGmNGAiFDzslaief/QVwq9udxS1RfeR8TGHwwMuzM/dseXGye4SNqDGX64yIeM
         CdNPGQYdN0Fh8LPU2aS1DGWE0rrU859oTK9+FTljmCK2IfDfE/z3q8beIqkOTt9OKypo
         XSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YdKJNJU+VGWKXDxEbhTBS+DhIooYcT8eg3fpuPnwn/Y=;
        b=FCQYPmgex5AfQ0ouluI3VFCZFJA97pE8+4PG3V/ajnGcLKhjkHQW6/WMBdVFpvqXO/
         K0uwFKpDEWdJLY2YapzROzQ3yjQs2wO6uDYvgK12/GtSYIeShGrnCtH0mwlwkPBstjWo
         FYlLRbxNnDRMkYTVwPMa2w5VYXoRynMvkr8bw1WXmU8YcNT1ZggsxMs4wWMM30eJoyRO
         BdfGHwN/5FaAMnwVexNg3ayAwTXb69e4GWwJDwtU1bR5s0PCgG8TFbBkOnnme7W37lmP
         G0wlzHKjj8Dh1i2pWQzgV+qrJz3onlTuh2ouNP46iT2FRAxp7AbqwM9/uInfvl2rIkQ9
         sYcw==
X-Gm-Message-State: AOAM533qNFz7SxTGIEpEsM8BrZQ5p2ChtO3YLhOoxisifckE8Zp770tC
        anUgz4L5QxtzojNeqxE57sS6Vjsv+rU=
X-Google-Smtp-Source: ABdhPJzAaxU4k8fLbIToDo435g76RFDfDlP/vdpL9N07vMcpJiUTr6D/lxMpICw48Lbp3UhBZ0LeWw==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr82221806wrs.317.1609821791800;
        Mon, 04 Jan 2021 20:43:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm94710176wrx.86.2021.01.04.20.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:11 -0800 (PST)
Message-Id: <a1a9fb01b07727a55ddb64ee5a3d9d4311642952.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:57 +0000
Subject: [PATCH v2 08/14] update-index: use remove_file_from_index()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of remove_file_from_cache().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 096cbdfa8ac..aa859c4e018 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -252,7 +252,7 @@ static int remove_one_path(const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
-	if (remove_file_from_cache(path))
+	if (remove_file_from_index(istate, path))
 		return error("%s: cannot remove from the index", path);
 	return 0;
 }
@@ -386,7 +386,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		 * On the other hand, removing it from index should work
 		 */
 		if (!ignore_skip_worktree_entries && allow_remove &&
-		    remove_file_from_cache(path))
+		    remove_file_from_index(istate, path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -473,7 +473,7 @@ static void update_one(const char *path)
 	}
 
 	if (force_remove) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(istate, path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		return;
@@ -556,7 +556,7 @@ static void read_index_info(int nul_term_line)
 
 		if (!mode) {
 			/* mode == 0 means there is no such path -- remove */
-			if (remove_file_from_cache(path_name))
+			if (remove_file_from_index(istate, path_name))
 				die("git update-index: unable to remove %s",
 				    ptr);
 		}
@@ -671,7 +671,7 @@ static int unresolve_one(const char *path)
 		goto free_return;
 	}
 
-	remove_file_from_cache(path);
+	remove_file_from_index(istate, path);
 	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
-- 
gitgitgadget

