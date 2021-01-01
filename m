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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347B8C433E6
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E66322241
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAANIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbhAANIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B396C06179C
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c124so8961677wma.5
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VqEsoAWSkWPZlMY4KuBUTheEtiHnE5bdR1GomA46H8A=;
        b=R9EbXgNW98FH6mNlkSfuSXjI0D913U1pZ2WDf6IT3kRTkwasy/8ahaF3zHh0rXHcwS
         Jo+oH93zdonp50FTIsTAXUS33hcWD9/YaqivjH7HGmsdJSeWgBpSEWvgQ7lAJbbP2X9w
         pEqdNtb5QLftJ1xjCb+COCo9OQGrf1KthsGuxl0dSh+YZagIoTVaeEMIL6Yr4VgltHJg
         gM/6Y6ewwSp/wZWKVP/9GsRaVqW9WrTfGzYTsH+KwK3nCGAGEIAIv2Klm3LDmKUCOzoR
         Hw3MKypmXtPHvyIddKSUzFpHJ9+5Bj6v1BqPg1p5BIeVD0J5rEjgHSTndh5sXg5DhcZa
         hnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VqEsoAWSkWPZlMY4KuBUTheEtiHnE5bdR1GomA46H8A=;
        b=M26XCVZJakV2KRe/B0hWSne7aJ3GvbTsYsc/zPMInzDJsVwLkzfPsHPd0mY+efrntS
         55jzQOA9Es14dVabbs+7D1Z/13orsPKgzCLvKCmxu4TWKx/cNMwMbCNtJW2pgy4i7CRV
         iz8QenWcyW2n+rr4m+FSjnaeR/r+RgCsHLJ8opoEdNq2Zk+3XOyGIXYovCXDKBMHHHlO
         7gA/5PnWhuuDBPpswVfVCzSyLKXRYV1qssY/zyeo3YCgx8fwPuOZdqIOddcUhqpv901G
         UBh+KIADOhGVBlqwJNtXILKGjLHP/onGZKaMbt3Ypn38bmYVbB7UXc2Bf6sVjK92ksKE
         U6IA==
X-Gm-Message-State: AOAM533E7TQzA3TTMepao/eXaVcaVCAd5t6jHMn5fEJro8GypHCxST+B
        Qfvh1ztRMgIabZuRK0uZGrXpLaJ9p+c=
X-Google-Smtp-Source: ABdhPJwKjW2OWu5aDNJBbJgCahzohkna6ujKQbIQm7ZemgV/qqmXnRvjhenkrY1LSweFVvgbhx23kw==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr16279421wml.155.1609506437792;
        Fri, 01 Jan 2021 05:07:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm15955306wmi.36.2021.01.01.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:17 -0800 (PST)
Message-Id: <c576e2d96762eefd714def45b49fb5742cee28f6.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:05 +0000
Subject: [PATCH 09/12] update-index: use remove_file_from_index()
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

This is a mechanical replacement of remove_file_from_cache().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 9e57779731f..6f51fb4a14e 100644
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
@@ -484,7 +484,7 @@ static void update_one(const char *path)
 	}
 
 	if (force_remove) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(istate, path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		return;
@@ -567,7 +567,7 @@ static void read_index_info(int nul_term_line)
 
 		if (!mode) {
 			/* mode == 0 means there is no such path -- remove */
-			if (remove_file_from_cache(path_name))
+			if (remove_file_from_index(istate, path_name))
 				die("git update-index: unable to remove %s",
 				    ptr);
 		}
@@ -682,7 +682,7 @@ static int unresolve_one(const char *path)
 		goto free_return;
 	}
 
-	remove_file_from_cache(path);
+	remove_file_from_index(istate, path);
 	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
-- 
gitgitgadget

