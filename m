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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB25C43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5087E64F97
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhCPVSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhCPVR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427CC061764
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g20so302925wmk.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZT0CBUkQNajBmstU5ybwqcXRwqQ64zM9gI8MnWWPvUM=;
        b=iq3rgMj3pohx42oAQLQSx5ZOU7gvQOfivzWX4gzRrPh0sXLaVPouHQpUjnlWn+8moG
         zQ6Gywu1MvfR4wjhrxLVLL1VKKP+wu/3XzWCUFjle9xqdqkJQvtJOeqy1S1jb6szubwN
         wDWI2eT3izsOT0Z4GBhH9GZmbKpRT9scBeA8rT7mQ/6bE/MaE9Af1nzjE/F3GHW3SZrY
         hZwbAt9O+KRNwVcupc9N1T605JqxVIZd2PJkx0cLg6nhzOL9NkidEI0IJSVXmPBwjByj
         dOyiD/QifrIfMbvyBrgAsger2b32C2f009B8zm4v4yjLbIWfrvwOU48GeMdpAmiAGs/C
         aFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZT0CBUkQNajBmstU5ybwqcXRwqQ64zM9gI8MnWWPvUM=;
        b=cdANY7BWe0IJAIzSvdqfteERu8suwWJwFzHZkL8pheSxT3d3zTktt4RJCnJFEne1xW
         VQToniSxXO4iOY+EJpCuCr+L9VW6c28wMyaTC98gICerkOiPB+244mNi5IuP0cpIeWCf
         abkCQ8wsP7nZ7Oisc9j3fdvSw+S44fI7HKNo/3Dxy+5aP+HZw+5J3zTf+em4BG4xnTkv
         06VC3z8FHwT4U4pvEoPleMl9qkUmHF+k8uuQ+9UD99SGfkHxhvtjhxhirgwGp0pnxCzl
         SydAIuMP7IODF6IEPuuaCPzZXLZd6mT6fv07rZIf//kwhSjqfhsJKF+ZtJoHh36PVXGC
         Lk2Q==
X-Gm-Message-State: AOAM531Om1UUQdX1rY42oj3RFV1PGqPTHldntbuIsVsYq3EuZrHlMJOi
        7n6vg8m2q3pCGPPTD4Aim1W1Td5xpSs=
X-Google-Smtp-Source: ABdhPJxyF1w/dKCSGvFBaYe0D9VgMvtCuL+Tx54tqqBaK89QC/7ovJRxNDB2F3iJAoF/hLhDaCkucg==
X-Received: by 2002:a1c:498b:: with SMTP id w133mr695179wma.134.1615929444254;
        Tue, 16 Mar 2021 14:17:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm563933wmd.41.2021.03.16.14.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:23 -0700 (PDT)
Message-Id: <988f7bd2d7364970a3c192bb229a21ea77803f26.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:58 +0000
Subject: [PATCH 10/27] fsck: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When verifying all blobs reachable from the index, ensure that a sparse
index has been expanded to a full one to avoid missing some blobs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 821e7798c706..524d3fca28f6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -883,6 +883,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 		read_cache();
+		ensure_full_index(&the_index);
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
-- 
gitgitgadget

