Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F119CC432BE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D667C60EB5
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGVUsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhGVUsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396E9C061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g15so212827wrd.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h6uXKl0tUCfl08p2NwWTeTQTNvBkftMiBGuKvpgJW90=;
        b=aNpMjbB3bt4ft5RouqSpeKaiidbZx+SWIJWNxOJeFz29/FSkJ7GzRF5DjzO8ahxhSd
         jbOs4BLRhiDIKAPKhdI/5JZ7hu01idkpll5LAcIWYYZfbY2iU0q4lXqfxZZCI6kJ4e26
         UoGkHwyCIfdjIEHWNrZSDFDbL5r7f/emVL/8h9gA3qkQqcG1H3tcFNg4ZcArDQO/pyiv
         54TmI1UhNfxE23c2vZ3K9c7TI6F/QZR51x1UwtwgX7/kwy50Mq8bYzF/0rcLbIuqow0T
         rbfI0BoQPsqiD6DsqgGzjVNdOAoYgICu1BwCTAD8NbCKJZYE8n7luJXqgnyQc6E6F93Y
         pLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h6uXKl0tUCfl08p2NwWTeTQTNvBkftMiBGuKvpgJW90=;
        b=bWnPQMX5KDH1g3ROyGAuV7QnVwmcVmDLafo+1gtZmkztx/O8uIZvPNIRkTxcFtoDi1
         AfsLwrdiotO7KE3A5Ok5or6ysMuxk0yYlxkuofqPoTCulRpq4Ys1kmwENpqu4XRYgQTt
         lrFDMvYBEBVkmmGUlFjDp7t3UiDoF61yCaqQszKVCqtPINzXT8iygDswb0y4hYv1oISX
         3Qoq7cB+/tzGLk7e8uM6kWw242hZg4yLvsSjcL+T1Uvdxa95O9/QyOZVBRPyTp8jVDWz
         uzTSRUyedgfTeD0XB5B6fjK2X9XK6+IH8kravsJFLW+XlUdWLk8//otwMdAvjNzXu4PL
         +4jA==
X-Gm-Message-State: AOAM5309nfxoSWJBzYox3A03n5DvXZD90vDnL/RDHKd009CmOc2y+4XR
        m5cIfVRXPJWmQ0zlhF94x47oLWndQ84=
X-Google-Smtp-Source: ABdhPJz7r20GrLrYKVxR4Rnh7NCrcjkMfFgbYLp5BYYWt4dpvg7T6Rt6KandusMgnE9JMy7syr+nBQ==
X-Received: by 2002:a05:6000:1867:: with SMTP id d7mr1901044wri.199.1626989330927;
        Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm29438251wrs.22.2021.07.22.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
Message-Id: <7b98d092811c3b479b41e5ef3327d795d794fde2.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:40 +0000
Subject: [PATCH v2 04/11] t3320: use git-symbolic-ref rather than filesystem
 access
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
 t/t3320-notes-merge-worktrees.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 052516e6c6a..6b2d507f3e7 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -46,8 +46,9 @@ test_expect_success 'create some new worktrees' '
 test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
 	git config core.notesRef refs/notes/y &&
 	test_must_fail git notes merge z &&
-	echo "ref: refs/notes/y" >expect &&
-	test_cmp expect .git/NOTES_MERGE_REF
+	echo "refs/notes/y" >expect &&
+	git symbolic-ref NOTES_MERGE_REF >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'merge z into y while mid-merge in another workdir fails' '
@@ -57,7 +58,7 @@ test_expect_success 'merge z into y while mid-merge in another workdir fails' '
 		test_must_fail git notes merge z 2>err &&
 		test_i18ngrep "a notes merge into refs/notes/y is already in-progress at" err
 	) &&
-	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
+	test_must_fail git -C worktree symbolic-ref NOTES_MERGE_REF
 '
 
 test_expect_success 'merge z into x while mid-merge on y succeeds' '
@@ -68,8 +69,9 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 		test_i18ngrep "Automatic notes merge failed" out &&
 		grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
-	echo "ref: refs/notes/x" >expect &&
-	test_cmp expect .git/worktrees/worktree2/NOTES_MERGE_REF
+	echo "refs/notes/x" >expect &&
+	git -C worktree2 symbolic-ref NOTES_MERGE_REF >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
gitgitgadget

