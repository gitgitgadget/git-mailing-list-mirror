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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C3C43461
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F67E61157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhDSKxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhDSKxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64EC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so33477928wrw.10
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6tJDhCD7+nYF59s210KX3AFlvUqVEeHqvz7t9NDP7jE=;
        b=fZEFXKAXsX1PY6Z0mtitmZycJGm41JPUwyWXOA9r+IcblcbtcNYB0lF6qeRifzxosG
         wrtkg1LcfLfWvimapN7FnvSVuPyc9ktPzQYqeIJmqlUemL4FeqzWDL5k5Kj3qPGVzzfX
         FV0hHPcDwO8W2KI6c2N9dz9u1Qe/mThLQrG/3G/3pg/0S5PqtY5X8MiMMB+TFKdVc0+r
         c9Dnn/c9dRoLzQUV84ga5Sbs06EXMX/qbTIREtRlZYNONW67SBbe2ZtScWZziHSoHy6F
         arujEIGS4PpLfosgiO1MLB06U0mW5w1tnxsHd6p0RJhPqQat1E5j1bZiZ3+GW3BafNml
         2nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6tJDhCD7+nYF59s210KX3AFlvUqVEeHqvz7t9NDP7jE=;
        b=XYwxGbMb/5n/t0hi4W9hYTCfvmOpERLboXA/T2pkO9hrLrAfgyAl/AZ4lrj5nEmO4z
         1kBNAgzYiLOQYzZrq60BjIstzcZhvQjSOZqh7K7ws7quROo1adAd4YwZ5OnVXDau3AqB
         Zj3F1owyfpO/T+U6I066DCWJ4RoG3YEZFf+HxTsYBh3JDQuryIEkWxgPs53Gun7+5KaI
         xvyBTCWg6r9964B4iSUDXUVnr6IY4gtszYfu4xftkV034cCfU5dKuHa1nST8EPhtaQzv
         xTxDuNtOlIaYZBMizKe0ZqqYu5QdnwQHQewyVesg34j+AAdULwGpHs9s7geAOhcEXCzT
         Z3wA==
X-Gm-Message-State: AOAM533EWyzv0fj5afETI31VO8iHZ0RtYDou12OvgWU56MiFhbBiBWYo
        E9g8WVgo1rwftogJ+quauYP7mhqSE/I=
X-Google-Smtp-Source: ABdhPJyWebAEhBzvWH2Qes+wNP0T96SpbHDpH/fRCDaM3G85goYOY0ueiUsYgIbJ3KCHOhI6T/tIyA==
X-Received: by 2002:a5d:654e:: with SMTP id z14mr13743172wrv.414.1618829587349;
        Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm23376968wru.47.2021.04.19.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
Message-Id: <223583594c0089ef259e83f2f10c08fd94f55959.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:50 +0000
Subject: [PATCH 05/18] t1413: use tar to save and restore entire .git
 directory
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

This makes the test independent of the particulars of the storage formats.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1413-reflog-detach.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index bde05208ae6a..b699c2bb7c31 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 reset_state () {
-	git checkout main &&
-	cp saved_reflog .git/logs/HEAD
+	rm -rf .git && tar -xf .git-saved.tar
 }
 
 test_expect_success setup '
@@ -17,7 +16,7 @@ test_expect_success setup '
 	git branch side &&
 	test_tick &&
 	git commit --allow-empty -m second &&
-	cat .git/logs/HEAD >saved_reflog
+	tar -cf .git-saved.tar .git
 '
 
 test_expect_success baseline '
-- 
gitgitgadget

