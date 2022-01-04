Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674EC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiADRhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbiADRhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B8C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l4so23745931wmq.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6m2WCFlbDEH3Qi6Apwp4WNApLrFFTqGiR5cvu5IYYvw=;
        b=Oex9vZkahlmHqldm3LzqORKW5JZe3TtDVEQolrzO0MMqfnFScRbpomIyrLeyDDctrw
         1DAFBc2wYmkljcQwDEGN38rkxgeOe78xxFwAUFA0scHTES2rLjGNsR79hdxywA6SogXP
         AvNwns4sLMzy/MGihRVhPq6z04q/ca6IETsHcHka5kQObYyLnTd2iLwBLgL8iC5o7ePz
         4z8HknwX3GKr2GeAL0seXSfqGvNxY7dMliW5tmmleShAZ+VirIoh/1wBQvAm+qZoNffd
         LI7lvVyeeRZq1/QtGBM795RRVE6ozo4YNYOaKBiTzbvhiyzVK8+EW1KfuZU+X4hPpauN
         w0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6m2WCFlbDEH3Qi6Apwp4WNApLrFFTqGiR5cvu5IYYvw=;
        b=4K4rDZbvh5S0fw24znpDt+vpLUjmf0QQytu+CIHrNA0X9Dp/xy70h9tOHZ0Cmtdfy2
         cBm+YTWuD3YDBupPE0sAYoBkls69qrxxMsYGom8rYXGklgZG/GUqb2+rAhB0W2HbvR0V
         YR4R8DxdhBMlZ1jSg0kdQeR9gAWAiQz6dj0zvu/D7e8AmnH7SSeyddkvri0f/E4+YGde
         hyUPXk7ea7RgDiivacSaxQ1W1MPuMh3rsWVLfYELspROy6orahsNDCQrbk+ApUpZAxoz
         Lafp8MV/eQq2052ZklBbWSrBvnLoeqdsgXTfWntYHN0h8DbG+9twDAv3mGheJQXiABos
         Aezg==
X-Gm-Message-State: AOAM530gSPc2zmXwX7r8x/FnF+PTNsUqQ7Km6e3xEUeMiT09s2nPFvQM
        7MM0gCJqi0fPvEvPaXEUIgQVcR1f+fA=
X-Google-Smtp-Source: ABdhPJy0OPGpqXTBaxmKrDki+lIbYRT636CU3JTrQ8tg05yz5hxHl/wMNu1LiS7UoUYMTsUfA4phpQ==
X-Received: by 2002:a05:600c:3844:: with SMTP id s4mr42700143wmr.124.1641317822717;
        Tue, 04 Jan 2022 09:37:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm5567wmd.37.2022.01.04.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:02 -0800 (PST)
Message-Id: <eefb6ab4c61460d21dca3877b83a0e6c2852c43c.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:52 +0000
Subject: [PATCH 1/9] reset: fix validation in sparse index test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update t1092 test 'reset with pathspecs outside sparse definition' to verify
index contents. The use of `rev-parse` verifies the contents of HEAD, not
the index, providing no real validation of the reset results. Conversely,
`ls-files` reports the contents of the index (OIDs, flags, filenames), which
are then compared across checkouts to ensure compatible index states.

Fixes 741a2c9ffa (reset: expand test coverage for sparse checkouts,
2021-09-27).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 49f70a65692..d5167e7ed69 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -596,13 +596,11 @@ test_expect_success 'reset with pathspecs outside sparse definition' '
 
 	test_sparse_match git reset update-folder1 -- folder1 &&
 	git -C full-checkout reset update-folder1 -- folder1 &&
-	test_sparse_match git status --porcelain=v2 &&
-	test_all_match git rev-parse HEAD:folder1 &&
+	test_all_match git ls-files -s -- folder1 &&
 
 	test_sparse_match git reset update-folder2 -- folder2/a &&
 	git -C full-checkout reset update-folder2 -- folder2/a &&
-	test_sparse_match git status --porcelain=v2 &&
-	test_all_match git rev-parse HEAD:folder2/a
+	test_all_match git ls-files -s -- folder2/a
 '
 
 test_expect_success 'reset with wildcard pathspec' '
-- 
gitgitgadget

