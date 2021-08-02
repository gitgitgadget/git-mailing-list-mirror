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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B86C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3662610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhHBQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhHBQxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB5C06179B
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so377420wmd.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GxdkICMfkJfONoA52legBp7SYC+/2dCgdEj9w1NHQXQ=;
        b=f6rrCB09wgSkRdD8RnR41SSidXg8eZgTeJ56XmLM+qY21KtEfHMjIzC2+VCWEfRJVT
         0m0pnRanjD4CB30SdW5b7z/YrhCCOfHYj0znl2KrNwvoABovH+t5a0RRsa/sgf4incLy
         Rc1JhzOriKBfODbK3W5EUH/35adKjLz8CrD5saQIg0+wgNkQ8ZxpuOdHyIMF3QhWnOst
         GjseLMMEYPSSrccUmehMV4imw0YawXatzw4eN9oFQj6jKM4aGHein2qSdGzNzVZVW/Fl
         jFz37F6DV40h7GUFJXol14lcS+B0BCUb5i1mafGBps72Zc2o+rzEKtRbc2zdrdsfQhIm
         iaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GxdkICMfkJfONoA52legBp7SYC+/2dCgdEj9w1NHQXQ=;
        b=VhZPf8GSfzSGAKxYf9ANTo2kEuDtKc6VV7YGfjkhjooSO7j563jraHGANgRuWLKBfz
         NrEQYL65gaZcyfwu7s1hUQBfRCDy4birbpvWREr0hI2WNdw6thjGpH5IWPhEd0NfWotw
         udGFRt+As4Z+bTXuQ+ekE6N4ci7FaV2+DNtVFkf7TCx+BqadNrguXqCzdsXI16nQ/0Af
         tzGvHdcS7610mP27XB8P+j8N9QW9LczFk5nbFQ0iVPUb7UIPYv+6IYo95qL9nz8V5l+r
         p9fptuBHeRZ/6uN6M99G+zFT/jm/bIexHAAuD57j4JhkE5Q1e7yAA3OLxNxP3/O2kctV
         RRTw==
X-Gm-Message-State: AOAM531S5ZlXrL/qK0l493CsWzCSxRY9Erzj7S846T+8j/hl9lOUaVTl
        p8pGWSDrj9SgLIIhz/wrgLCbm9eJVok=
X-Google-Smtp-Source: ABdhPJyQFxts8yHHuXyKfEKLvBvZFqsTepb4F/DA3LQXpuO2IXbpKrD+CoWsiQbIFoZVZe3iISF0hQ==
X-Received: by 2002:a05:600c:3795:: with SMTP id o21mr17537337wmr.90.1627923221454;
        Mon, 02 Aug 2021 09:53:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm11905645wrn.79.2021.08.02.09.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:41 -0700 (PDT)
Message-Id: <add97ad8d0bd72178db3aede79c6d34331d3d1da.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:31 +0000
Subject: [PATCH v3 06/11] t1405: use 'git reflog exists' to check reflog
 existence
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

This fixes a test failure for reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a237d9880ea..92b04873247 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -98,12 +98,12 @@ test_expect_success 'reflog_exists(HEAD)' '
 
 test_expect_success 'delete_reflog(HEAD)' '
 	$RUN delete-reflog HEAD &&
-	! test -f .git/logs/HEAD
+	test_must_fail git reflog exists HEAD
 '
 
 test_expect_success 'create-reflog(HEAD)' '
 	$RUN create-reflog HEAD 1 &&
-	test -f .git/logs/HEAD
+	git reflog exists HEAD
 '
 
 test_expect_success 'delete_ref(refs/heads/foo)' '
-- 
gitgitgadget

