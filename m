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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7BC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C46601FD
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhGFSuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhGFSuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:50:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F8C06175F
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:48:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t15so114789wry.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JIB+1km6EWjMMFFaaWR5vadVaIArlv80FSJFhNW8g6E=;
        b=OKFOrw5gyinpmDRFpwLU2iQeD7O84mIACHeiHIF+spelvS89JEezZwdow+CU0Zg4wI
         jCJkLhDtppJWzeA/7TmLQi0Ae9FFHmVqC5oDzS++LbJhMtzOg2z+CRzNGp0lC2UpDKeh
         Qlx0GOTCof1llz481HmMnTgbERWQP7mhFOrdOAgZj0nGc1tUraOnqgtLth3beUJDfdqL
         aBd11VpZFQnzpLF7Ed6W7UKkgo7vFx6q0IeSh4d061oClhXI535J8Dg84/g25QQaGw1u
         2TPnwxMOa8MsA81+FbXusIsEGykYIjm3hVYsnlVQdi9YaeSCvYxzzlAxI17wDQLA8b+N
         HzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JIB+1km6EWjMMFFaaWR5vadVaIArlv80FSJFhNW8g6E=;
        b=hMWHTR6AJ1bZANtZEB+yFSoH2oZSUjAb2mljontJJiLwU1ujgyrZ+wNcOI71uyR9kI
         0sDKJOMQ28DfhLb78aqkSbMpf7zhk80zy7jfjYDlJz9N1bHimcI9HNLOZxnG+6iFf3gd
         LeCIStyy2QPkt0WUx3M9VrzdDhY5VdCxRTb5AxyMzf44W4qexut+t9vONBicCq4/vf7q
         AJBK7oZTO+cKXyZ6xiCi/Po2j5ftMdYf/dd5909hBJT9P8KjQbc8vQpJZYC+d+Slw0BE
         X1szeVQJKoqeoJzjVFGmixCSolYm7rPou7RYXsHaVsA61lbjCzJDJ4UyyaKlco9r/Wfj
         hTaw==
X-Gm-Message-State: AOAM530xynLorvsydMKqg8Bj8PjXZ4raZzRAaAGSqd3exWK+q5SqovJo
        45GAKtMkb48npsvH2ZL0SPrsMHBIsP4=
X-Google-Smtp-Source: ABdhPJw6QtvEQ7NVbg1nOQi7IfpoxANxW59AqDWv0ktzwKplAt3r+fkqZ3UDEbmBjiuDAi/TEOhL8w==
X-Received: by 2002:adf:9466:: with SMTP id 93mr23767986wrq.340.1625597279086;
        Tue, 06 Jul 2021 11:47:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm18186359wrm.48.2021.07.06.11.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:47:58 -0700 (PDT)
Message-Id: <ae77c605a0bb156303e5739290c96dafb2d825a8.1625597277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com>
References: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:47:56 +0000
Subject: [PATCH 1/2] t1415: avoid direct filesystem access for writing refs
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
 t/t1415-worktree-refs.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 7ab91241ab7..011a1a5e5e3 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -37,9 +37,8 @@ test_expect_success 'resolve main-worktree/HEAD' '
 '
 
 test_expect_success 'ambiguous main-worktree/HEAD' '
-	mkdir -p .git/refs/heads/main-worktree &&
-	test_when_finished rm -f .git/refs/heads/main-worktree/HEAD &&
-	cp .git/HEAD .git/refs/heads/main-worktree/HEAD &&
+	test_when_finished git update-ref -d refs/heads/main-worktree/HEAD &&
+	git update-ref refs/heads/main-worktree/HEAD $(git rev-parse HEAD) &&
 	git rev-parse main-worktree/HEAD 2>warn &&
 	grep "main-worktree/HEAD.*ambiguous" warn
 '
@@ -51,9 +50,8 @@ test_expect_success 'resolve worktrees/xx/HEAD' '
 '
 
 test_expect_success 'ambiguous worktrees/xx/HEAD' '
-	mkdir -p .git/refs/heads/worktrees/wt1 &&
-	test_when_finished rm -f .git/refs/heads/worktrees/wt1/HEAD &&
-	cp .git/HEAD .git/refs/heads/worktrees/wt1/HEAD &&
+	git update-ref refs/heads/worktrees/wt1/HEAD $(git rev-parse HEAD) &&
+	test_when_finished git update-ref -d refs/heads/worktrees/wt1/HEAD &&
 	git rev-parse worktrees/wt1/HEAD 2>warn &&
 	grep "worktrees/wt1/HEAD.*ambiguous" warn
 '
-- 
gitgitgadget

