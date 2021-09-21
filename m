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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF09C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA8760E54
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhIUKZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhIUKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9FDC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so37578904wra.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EKgIYMV65+pF8SWCbofzmd9DTdcc/w9+US6Qm8arifo=;
        b=Ge2jhTzSvTg7T/13FRbUj13s7ZH9y7Id9eQjsjqMhWhhhaM8K4+2GIXa6W5v0cMCP5
         u1+i3o3ULcs57AXmuSIMKlluZNkTqOZFZZYDBqbNE3V/GVnZ/uyI8FLoXTf5Q9051TcE
         a7ChvCKB1rJ2sDjzSLUYLYyqRrOh3cEZDkweT2BwYt7V3T72ixJRAOhJ7FBGUBdhYyR2
         OgRGRa6zdUf9T+v5pSYVbQ3LSBPKo8NG9JJs4OvKqodGHvJB4e2OlCHupIUhND/fZp5y
         2c6a0cYtCO7KYiKmd/TYT4guG20m3v8RdQMc+yKj11MXGMOt+5tPo90wy3ASypqtCglU
         B2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EKgIYMV65+pF8SWCbofzmd9DTdcc/w9+US6Qm8arifo=;
        b=HLDzd9ysWymc2ggsYlmslaV8kzy86C64EQPImDTy/Qi+BIHj7qoP2KPauULKxe00yF
         L9EgoE/B7PCoYURIDq8+pQc3numytP2t3u9nLvPCKuGkZLS2pdirVMG1t84QwL+PyQan
         Ra5AmaXWo+Bzxif7uvNJskjcYyCIldEIln7QoY/iSJUYD+YvOSpnJGTPD3T5kBHNTbTu
         8+9pQN2RqDZMDNamGjRI8rx3ja871pfDzoYMR2fd4iF3a+3PxyPxwedJinA33p1CTLZp
         pJh0zT+nS6E+2DkREaiBAEDP6BaefJkhRCd5FXhZrvWL1rRDOxEWcmBQ4zG6PhpV9ZJN
         GSuA==
X-Gm-Message-State: AOAM5332vx8xD9Du2VG147uucixG0ROxJxXQk6wIPaNnbVgg9cO3cXeL
        98sfriRmaBEdXiCsH6gaE+OEHEKsoNg=
X-Google-Smtp-Source: ABdhPJy2YHd/RczLXs3qCtAU0Zrs7BsNRyjqofITn9Zvpa0BnNOK8VQ2sjuZBtbCR6lxU4wnuwEYeA==
X-Received: by 2002:a7b:c7c6:: with SMTP id z6mr3735855wmk.190.1632219850675;
        Tue, 21 Sep 2021 03:24:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm18527143wrn.65.2021.09.21.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:10 -0700 (PDT)
Message-Id: <abfffb31a562cc3b896c0a94a1ef7456657e1268.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:23:59 +0000
Subject: [PATCH v3 02/10] t3407: use test_commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Simplify the setup by using test_commit. Note that this replaces the
branch "pre-rebase" with a tag of the same name. "pre-rebase" is only
used as a fixed reference point so it makes sense to use a tag rather
than a branch.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index c747bd31d76..0ad21966bc5 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -8,22 +8,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo a > a &&
-	git add a &&
-	git commit -m a &&
+	test_commit a a a &&
 	git branch to-rebase &&
 
-	echo b > a &&
-	git commit -a -m b &&
-	echo c > a &&
-	git commit -a -m c &&
+	test_commit b a b &&
+	test_commit c a c &&
 
 	git checkout to-rebase &&
-	echo d > a &&
-	git commit -a -m "merge should fail on this" &&
-	echo e > a &&
-	git commit -a -m "merge should fail on this, too" &&
-	git branch pre-rebase
+	test_commit "merge should fail on this" a d d &&
+	test_commit "merge should fail on this, too" a e pre-rebase
 '
 
 testrebase() {
-- 
gitgitgadget

