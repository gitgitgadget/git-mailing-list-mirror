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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE0FC432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A0B610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHBQx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhHBQxv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73580C0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so344932wmd.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h6uXKl0tUCfl08p2NwWTeTQTNvBkftMiBGuKvpgJW90=;
        b=HZf0n0KNT7Gn2sAUcdi8Y0/EKcyD6fQARMarOXLZXykgxsOkDKUKcbRIUo935Nk/Rk
         nopqV2GNcUzCuCyJ/R0UYdez/VHFtxIoUw0CvBT9LkIdq8Apt0E4dc4hZhlOMs7YlPD9
         g5EBTl3wzZinZv8jPYiO5he9Rx0qZ1Cn8ev+umpnyhogjw/4+ZYgv26+bBVEQNaNEy5T
         yX18iHfAqS32DzjZiBWmFmMZr+eQLuWyBCmO0Czm48QlhwPKENPY6xTOHYDhuGvt2B6P
         KyQaFM9lWbNJyCVZdMQGbs8p6VGX/5PoApLFUah+D46xzrDFMGM4hNNjYj1oro3HbxKT
         HX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h6uXKl0tUCfl08p2NwWTeTQTNvBkftMiBGuKvpgJW90=;
        b=nc2c9YUyfA0ti6NRrPVULUfFAClZO+VeEshz4Bc8uZKyZ+qIUxXSlTkyLnBvVRcjOD
         AV76FZWDz17OK1bJ/IfschLJfZAR1H1L3Fyt1KCqx8bBjATP4zuiEfuNu8/fbP6yEHdf
         o2Glkn5L3jLaxmzAqlHV6HtgmMytYBweFkPFCOUpONOG/1t0/5MYcl6k1nGSi47aGhVO
         MnpiG3hGv21I7zu1Y+5YYKY/6nw8pmgC/JRjPDz7PoT9uACIakYXyxiv5QKjjsXl9x3g
         NDW1qFYwwILpy8h6PBWhg1sefBceuA2R9Vzk4qPXJz2QX7qwXe+E8kjbumfemzIOtvS8
         ZRDg==
X-Gm-Message-State: AOAM532D44RQaPWr99DwUVgxLnizi5bhRYNFzBkv7OdApziT4aaCiEHr
        CVghPesJRVGou/SphdRe4f/W5meCY60=
X-Google-Smtp-Source: ABdhPJzmOe5dBjQp583H6lwut08HEcNWElg2pjvTb5DDz6FeOhocHQfjKWurhY5kSN+fEXTVQJJwRA==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr17611391wmb.170.1627923220125;
        Mon, 02 Aug 2021 09:53:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l41sm11739698wmp.23.2021.08.02.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:39 -0700 (PDT)
Message-Id: <22bff0b0791ffa402b6cfb79ecaa589bf0617d85.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:29 +0000
Subject: [PATCH v3 04/11] t3320: use git-symbolic-ref rather than filesystem
 access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

