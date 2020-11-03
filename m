Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB5C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C86216C4
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ta0ioV+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgKCLsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgKCLsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 06:48:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67395C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 03:48:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so18178055wrg.12
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 03:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XfXPxVx6qUrN2+hCR8Xcy6GyIG84tNvNxfDCkj279lg=;
        b=ta0ioV+HR50NjSuyLPHCq5JgyxxNfbgBJSkUahPGwEJTucFKlP7YzR9JrMBFWoD5aE
         Ca8nvSQVDoTjRVIupYjeXylATYg9jdMBk+ERpNWBvD9WMEQSk4lu2NJXzEbEm1F4tg5V
         +Z88pF2d09w+rgmhyj3OBKmAu3laqGLjVzQm6nTB3YkfZjFhTn4c2XuhGy8Dx9MVgNim
         35C72P/a6OEwfI3fpsryLqyfEZzEIyPJA6fPg7TEiGK6IOzm8li0nK5ryGIkHmflGjvh
         6xrsCU8/KtMcDzgCwrVTJoHN9JXQBygHtyxBFmG/ze3T9GKzdap7NKmJOlmQtOwcaPxx
         /TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XfXPxVx6qUrN2+hCR8Xcy6GyIG84tNvNxfDCkj279lg=;
        b=TKXb/77UKbLh841v09Ho3tIsqb/PnyqkXxVI3IAMaCh8WTN0Upin3tXCks+3Qpmx6A
         vskvse38aGL0bIrIyE+L+w3kW20iHOlOvCKzHL4+HHek4asJGzuHrDSm5EVnH1sxKYdO
         5AGj3wYdmgWnjt+vBadzcxlm1iAsPXDhl1vkApP2D8yidfsdBCF1J3vKTp7KewIBakQ1
         sHhhq4WYczAiO7Fwjdx38ZXZfaR+pEdMnzgnCDKast0Svq4MRCdy+zulnWMRlWMz2Pzm
         VbNvjr4isOk+dzPTMvLMStaGeUfFOkc3iiwVh0QOHE730Uu2YGD+oOJyavqxKxVeyeOp
         tpXQ==
X-Gm-Message-State: AOAM530uxRS4QUOzOFZn4uNmFTMYE6jOJn7UuWIzC7XmFU1188ItDBoS
        b1D7tfgkm2GNxNRSMLs1Apj5w5T6fbQ=
X-Google-Smtp-Source: ABdhPJz0LSBfFBz44/J0BR9MIpZ1I2FssrH6ueDnJQz04Y8PrspChwLJaxQdALM35EqF/hqXwfCzBQ==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr26808051wrs.423.1604404088743;
        Tue, 03 Nov 2020 03:48:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm9993237wrn.55.2020.11.03.03.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 03:48:08 -0800 (PST)
Message-Id: <pull.777.git.1604404087749.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 11:48:07 +0000
Subject: [PATCH] t2402: fix typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c57b3367bed (worktree: teach `list` to annotate locked worktree,
2020-10-11), we introduced a test case that wanted to talk about
"worktrees" but talked about "worktress" instead. Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t2402: fix typo
    
    Just a fix for a typo introduced in c57b3367bed (worktree: teach list to
    annotate locked worktree, 2020-10-11).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-777%2Fdscho%2Ffix-worktress-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-777/dscho/fix-worktress-typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/777

 t/t2402-worktree-list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index b85bd2655d..795ddca2e4 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -61,7 +61,7 @@ test_expect_success '"list" all worktrees --porcelain' '
 	test_cmp expect actual
 '
 
-test_expect_success '"list" all worktress with locked annotation' '
+test_expect_success '"list" all worktrees with locked annotation' '
 	test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
 	git worktree add --detach locked master &&
 	git worktree add --detach unlocked master &&

base-commit: c57b3367bed488469d24a21446731e9e71846ded
-- 
gitgitgadget
