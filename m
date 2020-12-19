Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B9C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D4123104
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 14:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLSO4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 09:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgLSO4n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 09:56:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA13C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:56:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v14so5565291wml.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 06:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4k6wTuLAwFd/xup04ly104089tbz7dSEy0ocnBItE98=;
        b=ock0BT5zMzPKcESucwgMcn32iCRqFfLAb08x9JOfqwIT0WBuON/YTWxuwt14KvXxvE
         H+AtN9cYJfPOW3M3IZuk6yFHRvdookjY6Od0IMyeDbx85tR2YeiClP5gQvOhOZJ8VTS4
         MiASZNjGO8EGGbi3UWR+GGgUjVrAZRlU6Abvm4busfZy41BGLK+8bNL1xQbdh/Ubst7w
         vNgeXwjnuG0OIj0J1b88XvivQUeHNFM2VW33fP1rNufBR1I7IbJs2zKJTxt4xy0KTQlG
         72MCDNqVRDTl7Tot+RyddBtuqKhvmmO4VR9HsH2Yl51QdnCptHroD180IkzhyNn5gZ5g
         qpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4k6wTuLAwFd/xup04ly104089tbz7dSEy0ocnBItE98=;
        b=aZ64mTqpyVu1/5gnWSDAB4kMryXXcCLK4Wz4BqpNj+htnAMxNs3vR9YOZCWS08yqGK
         4LPF6BX+TH5aGNNho9dHNjEeAsyso3Uf8t1vrlREPX6CZqpBhlkWr3I9LBrpIhfNikxU
         AOqts7WgWfEViwXWFRumji0AQ4x2MGC03pksQFxJ68/b4aGQ0srAEqUD3Jy0hSmqXHIM
         VK0H4IpTwGF60G1IbPypLSw4MI5ftLfo9Rx9aViMAi73yhPu7qEimIvgfFz7b+Nq5xN/
         hFcGkf1RtHz4wUUsXPgX2K9QBNePo77Riw9/NfU89TROSg654UAnp9gNHPqcLCYSIh4o
         GLzA==
X-Gm-Message-State: AOAM530g3gAsz+Vb4KBGHUXa6pNGngUVvOCc1lfSbgI6jULV4K+IZSe5
        4PwVJR4+uIHsCb6/N5FYKaF6R8DXXFg=
X-Google-Smtp-Source: ABdhPJzofHVtRWaL0YDHqB/kQwEFUzYt9lqJZUd0kxNFGzLyoIZkBjJzIpfWuIPWojfl0cnmkRN8nQ==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr8852845wmj.134.1608389761062;
        Sat, 19 Dec 2020 06:56:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4sm15333730wrw.42.2020.12.19.06.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 06:56:00 -0800 (PST)
Message-Id: <pull.819.git.1608389760050.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 14:55:59 +0000
Subject: [PATCH] checkout -p: handle tree arguments correctly again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This fixes a segmentation fault.

The bug is caused by dereferencing `new_branch_info->commit` when it is
`NULL`, which is the case when the tree-ish argument is actually a tree,
not a commit-ish. This was introduced in 5602b500c3c (builtin/checkout:
fix `git checkout -p HEAD...` bug, 2020-10-07), where we tried to ensure
that the special tree-ish `HEAD...` is handled correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    checkout -p: handle tree arguments correctly again
    
    I literally just ran into this segmentation fault after rebasing Git for
    Windows onto -rc1, and did not really think that the regression was
    introduced in the v2.30.0 cycle, but was proven wrong by my
    investigation: it was introduced by v2.30.0-rc0151^23.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-819%2Fdscho%2Fcheckout-p-empty-tree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-819/dscho/checkout-p-empty-tree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/819

 builtin/checkout.c        | 2 +-
 t/t2016-checkout-patch.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b82119129a..8b567b0424d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -482,7 +482,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * properly. However, there is special logic for the HEAD case
 		 * so we mustn't replace that.
 		 */
-		if (rev && strcmp(rev, "HEAD"))
+		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index d91a329eb31..abfd586c32b 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -123,4 +123,9 @@ test_expect_success PERL 'none of this moved HEAD' '
 	verify_saved_head
 '
 
+test_expect_success PERL 'empty tree can be handled' '
+	test_when_finished "git reset --hard" &&
+	git checkout -p $(test_oid empty_tree) --
+'
+
 test_done

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
