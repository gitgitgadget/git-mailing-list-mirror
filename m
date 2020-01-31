Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878DBC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FCC214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gySGl6JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAaUQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36200 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgAaUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so10171417wru.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NOixNBC7fdzNZ0Vh4Z4S7u1S7FIf/h5PVqWmfQdvx7U=;
        b=gySGl6JQBRlNp5DbysyOGCjgazaVqH2Gv6tCZlyoykgtJFDUIcdJnQECJyH06/60Lf
         BG4x82PjfrUCC46ocCFZxR0Fgoyz76kZYCR26mz5RMcWCwIZbN/ZeU2Wet6xrhDidHLM
         9NGb+KyO5rBVyRt72iemGgnfhRUv4iN1aLqg5zvw0AFZbVKDs22/lNvRrTC47B5zoxZA
         0l+pGc0NpGGA6T/WbAWNdmaO8QXIer1Lmna49JHXaWwUpfPbY5nwX9r9KoE1OtVxajJf
         gndqzlxncM9ewL8Ss0tF7FS7z7XBFqsG2k79cuNkELAiYTweT0hadj9dha3olDGSNAx5
         CCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NOixNBC7fdzNZ0Vh4Z4S7u1S7FIf/h5PVqWmfQdvx7U=;
        b=FbYD9+UqWOLIc6I9IJLS1XhLDk2qNnThQtcVIiykQILZBJzUqyuAacHqmjnxRLxLY/
         cHswgMwHwhXSJTv83bJsTg4+FxiWVjEt6xh64xnx2ze159ndIEDUWrlhvvca/lMDCthB
         xEEraOpUNsAEB4iE1ILEuVOYVjmyVHnl7V4XB/uORK1ojchZJiuLyzJHi8GiG2Wanb6Z
         tUwvrya6WWaEPU2omwlEpnCnCNkSbnedZasmGuqM0JU9aLsbes8CzHNwBZUQC5Ud24aP
         dWeMEdAYUXLx4UlNYQmsuYoJgReOY9SxZxo0A8WD13HJujnW+9+pQ4GvhMiEV6WV9ZDh
         amSw==
X-Gm-Message-State: APjAAAUrH7Q33QY6gpNb6F/oGJtkiZ/HOkY/SvMP1SrO8EXXGHB3J8C+
        7MMkLUVYYoTdw1QeJGRrnekcveH/
X-Google-Smtp-Source: APXvYqyFKjWGRMniKg+FJbV/3wwZUyshM+O9zwgIktsxgj/Oa1n4UbyX2M2No+HFSEkKMw6ZsJeDnA==
X-Received: by 2002:adf:978a:: with SMTP id s10mr124365wrb.69.1580501787251;
        Fri, 31 Jan 2020 12:16:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c141sm12319215wme.41.2020.01.31.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:26 -0800 (PST)
Message-Id: <5e9fcce75f37676613f6cb919249ce8afd51c825.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:15 +0000
Subject: [PATCH v4 15/15] sparse-checkout: fix cone mode behavior mismatch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The intention of the special "cone mode" in the sparse-checkout
feature is to always match the same patterns that are matched by the
same sparse-checkout file as when cone mode is disabled.

When a file path is given to "git sparse-checkout set" in cone mode,
then the cone mode improperly matches the file as a recursive path.
When setting the skip-worktree bits, files were not expecting the
MATCHED_RECURSIVE response, and hence these were left out of the
matched cone.

Fix this bug by checking for MATCHED_RECURSIVE in addition to MATCHED
and add a test that prevents regression.

Reported-by: Finn Bryant <finnbryant@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 12 ++++++++++++
 unpack-trees.c                     |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 37e9304ef3..7d982096fb 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,6 +305,18 @@ test_expect_success 'different sparse-checkouts with worktrees' '
 	check_files worktree a deep
 '
 
+test_expect_success 'set using filename keeps file on-disk' '
+	git -C repo sparse-checkout set a deep &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/a/
+	/deep/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	check_files repo a deep
+'
+
 check_read_tree_errors () {
 	REPO=$1
 	FILES=$2
diff --git a/unpack-trees.c b/unpack-trees.c
index 3789a22cf0..78425ce74b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1416,7 +1416,7 @@ static int clear_ce_flags_1(struct index_state *istate,
 						name, &dtype, pl, istate);
 		if (ret == UNDECIDED)
 			ret = default_match;
-		if (ret == MATCHED)
+		if (ret == MATCHED || ret == MATCHED_RECURSIVE)
 			ce->ce_flags &= ~clear_mask;
 		cache++;
 		progress_nr++;
-- 
gitgitgadget
