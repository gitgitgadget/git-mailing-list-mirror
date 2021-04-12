Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F194C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E19961352
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhDLTM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbhDLTM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:12:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEEAC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:12:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so2058620wrm.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kbWCiHuf18/aY7JDGHycU3ZBYXdsb+efZGqV5hrDq20=;
        b=XGMF9T1Py2V0o9XiuDVamIQFOwUmkmDD6Ud16giFIODFLtDhsEPJAIPhcWSoNUg+iX
         2Dfo5hryCc36l3QlHg91eBnEfWNgFVLZZHgpmXp03jPDrV1VwLhSlxjTX85pTRAE9rMx
         saWVn3P9uXzdHT1qUIbtDrkX6PNUrojCqtVsegCwxGpryniszsuao7IV0Ljb2eS2TetC
         3M+6I8BfGBfJ+t4dRBE2rZnimHbMwlNkrlixYaKK/ZiBqVZadQa9KYYif0Koava3soXz
         cFwKem4+1YjaH1IU2gq3frNcDDGUqSDjT2mv2Nqjl1LyNFraNDxw5ftGCjsofCp5p3d3
         xnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kbWCiHuf18/aY7JDGHycU3ZBYXdsb+efZGqV5hrDq20=;
        b=LtWRN2iHSto/ibW4GzoGhXLfIH7VnnrwzCs2QcfLkGcXaSydHqit5NFMsIifPgTzk0
         FIIk6svQNRYuYeq6WNnsKd86UquH92C8kZRLSldTHXi17KH6z5K12EQIhsFjvBkojnom
         0ucYV5kRHiUgqYedH2vW43SuuiNr99X+NKvDjt7+x2sjTRSXnmdNzu8E9O7DjxJ/pFM2
         4xZ+4gWj0Ch7W64V9ioFMl0L8YrRbFnWXLP8XADgKbHMZy6mWtesWNf2b88KIwuBzBnz
         GlmVHcJZFa995vQxYj6NAl7muvTvvFm5eh+rLzIjKTrfiK3wnaEVYWr0AmqTzgJr9Mln
         3vyw==
X-Gm-Message-State: AOAM533j/xu/LKnQQCZyxZdlukah1kqmbaDNUCh+hl7WxQePWHWGpfDA
        401V73bc5wPjzKH82AtVjiAAiYKLjwE=
X-Google-Smtp-Source: ABdhPJzna1PRw/yhkmddQLOdCLhzx3YbMfPXmCbkZNBYUkx63NWec3yhIgw4UxbMfVhYQC+mShdZeg==
X-Received: by 2002:a05:6000:10c7:: with SMTP id b7mr33046947wrx.143.1618254758224;
        Mon, 12 Apr 2021 12:12:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm266942wmc.38.2021.04.12.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:12:37 -0700 (PDT)
Message-Id: <pull.1001.git.git.1618254757074.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:12:36 +0000
Subject: [PATCH] reftable: document an alternate cleanup method on Windows
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

The new method uses the update_index counter, which isn't susceptible to clock
inaccuracies.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    reftable: document an alternate cleanup method on Windows
    
    The new method uses the update_index counter, which isn't susceptible to
    clock inaccuracies.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1001%2Fhanwen%2Fwindows-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1001/hanwen/windows-2-v1
Pull-Request: https://github.com/git/git/pull/1001

 Documentation/technical/reftable.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 3ef169af27d8..d7c3b645cfb0 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -1011,8 +1011,13 @@ reftable stack, reload `tables.list`, and delete any tables no longer mentioned
 in `tables.list`.
 
 Irregular program exit may still leave about unused files. In this case, a
-cleanup operation can read `tables.list`, note its modification timestamp, and
-delete any unreferenced `*.ref` files that are older.
+cleanup operation should proceed as follows:
+
+* take a lock `tables.list.lock` to prevent concurrent modifications
+* refresh the reftable stack, by reading `tables.list`
+* for each `*.ref` file, remove it if
+** it is not mentioned in `tables.list`, and
+** its max update_index is not beyond the max update_index of the stack
 
 
 Alternatives considered

base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
-- 
gitgitgadget
