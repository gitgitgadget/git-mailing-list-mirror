Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD16C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589F5610FB
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356368AbhGSRbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380088AbhGSR1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5030C061766
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d2so23186548wrn.0
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lvHwdy9rE59CVyvJ5nfZvFyTIKKxP8gj7MxdUetQth4=;
        b=StKwcPP761gRiXgLd4vxRHNMEDozC0h3RqAU+ZZL8xqG/WW6iklLU8t1q7Saq0SGlR
         8YWDkz++gaWIwpg43lWE8DkMEXxe4z05/J0k4yfOZRk7fh1QfnlNa60SWY/muYqokGJy
         yn5ZZY61lMf7eRO7DAEqSLoXOQD29V5h5SClYi+M1DVKTiWC8M4Jz926vcdhe6FliOmb
         3IIxlh+QLoEnSBtWDg5U3ULl4xQoWqY6/UfqtYNEDqtVSy0UQ5LCKBOmD5KdWGRWWD2h
         qYGAjwDTGXaIDI7CfdLqqrVDIjwBUyo5M3ALS90uLfZBTFNkheSToe9TKYOLyYC/Z8ao
         UJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lvHwdy9rE59CVyvJ5nfZvFyTIKKxP8gj7MxdUetQth4=;
        b=DOaCkGNbrxhaZN72orDRjVaY3NhGLV//EkGJDCAJBo0+QKqIbiZT0XmRqiQLg3qh9D
         kefQzgC25q8XkmXz+JQUBok27Yk9ahfr1+HTjX0klLZ6mahSKHd1gyd/L0Go4NRpppOp
         bWgG5odiWbfThrFxhN4xlk/2AX95LgSDW1ugnuT3x8sf5Kg25kMIf3cI4lqTbT52NEQP
         WtHIsxPjZTYmNsKtOZDTiSarFddyKBSKRxA01l7kFjG9IBVKVTHqsb8srqvdS5iTtGVo
         G1WxAwbgXqHS9Mannfc1u7ARB2nMYwaoDilJiHk6hGnLrAb95n/PQbWsrlC3qIshM2oL
         b9Bg==
X-Gm-Message-State: AOAM533cVQXuVDn28gj/ft9snEJWjHJzgrxo5IIMGsoW1ZI+elxRN5eq
        nSjtl0VhGRjFm4XceJXq7ognLxDLqhw=
X-Google-Smtp-Source: ABdhPJzfvubiR+/Eq7pLWOVw95XpXhxeAt6lIKCMwJh4yslBxNmRR5gTTRzQGOWJq0XgX0QuBww+Hw==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr30713348wrn.138.1626718053885;
        Mon, 19 Jul 2021 11:07:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13sm21576438wro.79.2021.07.19.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:33 -0700 (PDT)
Message-Id: <94d7e144f54c423c865dcd475b042469f07f4221.1626718050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:28 +0000
Subject: [PATCH 4/6] t7509: use git-update-ref rather than filesystem access
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7509-commit-authorship.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index ee6c47416ed..d568593382c 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -147,7 +147,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 	test_tick &&
 	git commit -am "cherry-pick 1" --author="Cherry <cherry@pick.er>" &&
 	git tag cherry-pick-head &&
-	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
 	echo "This is a MERGE_MSG" >.git/MERGE_MSG &&
 	echo "cherry-pick 1b" >>foo &&
 	test_tick &&
@@ -162,7 +162,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 '
 
 test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
-	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
 	echo "cherry-pick 2" >>foo &&
 	test_tick &&
 	git commit -am "cherry-pick 2" --reset-author &&
-- 
gitgitgadget

