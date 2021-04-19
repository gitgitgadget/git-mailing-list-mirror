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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32404C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A60961157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhDSKy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbhDSKxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA06C06138F
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n4-20020a05600c4f84b029013151278decso6590018wmq.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TJJnDxSxMEo+4PIzixl1CAqWxv6z9UWK4OY0vzo3ayE=;
        b=UolRvqn76Qs+wCCAa6Mp2qBVOfaJcx48xUpmplUFDLqFLq0QQHItgVn80ELQHShnQ/
         tKEvWp0x/143tlKsAiAAtrumsoUDaK9gMRzigNlTQ1dE1L1IQ6QPWjtf0ipCfNTELGZb
         FRB2E5EpaktbF1JeYT0hGm26iyVsE6mnfmz+TmWeMMQjbboK8laHhdGPXi9IMXYwVpM3
         7tpqUMz1PY6NVFUqujzeuq4wH6a3y9SLOBgcweZ+IcH4ZGWt9/u1UbINMB3eGakYN/MY
         8yZdNj3dJ4xrOXd6QnGILoXRxqiFg2fLZ9mFr4oPGdrhFtpEibiZHpQFg/17PQdcR8KZ
         diAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TJJnDxSxMEo+4PIzixl1CAqWxv6z9UWK4OY0vzo3ayE=;
        b=LVRIb/yWSfHfK331Txdt3oL8KF03ufeQIiNjNloRenLsNtVnK9Bcp0s2ZEBNA4TbhR
         VL0co4aun5rIAp9w+9IiMf9kztP2M9Dhoar3P29i1IyY69WXXeTP54Re+hLKSgRVV8uO
         sy4Eu44Z9Hf61b2wHOBsfTOehyvKy4fKjnlML0vTBpPidBNR6APLBTh/eVc0sbg6TRRt
         ya5+EoKHl3mR3XwOdnxIgJhx/8jxRmSGVumn684JjhFJsnt2L9RAru3/38NCQUQb7gX6
         3mGMAkvjajbgCr+Pgy5ccgAAXoXCabXU/gQthgfnsM7dZ+khqBzwcDIL0/O9UXByPidg
         76GQ==
X-Gm-Message-State: AOAM531rprl8fF6K2D760kq9fCDBQuD5OPs5sj7Z8AgAkVwWZYGmZMDt
        GAGloJ2OxmEpgZAmmTup8tRPUD3IKpE=
X-Google-Smtp-Source: ABdhPJxtwFZe5XDNG8ZDg03s4EYVgrqCUYk3H1ROS6CElrLrH9xkh6jCf5lTZMz5OF+yKAAbRG5qWQ==
X-Received: by 2002:a1c:e407:: with SMTP id b7mr20552893wmh.75.1618829592761;
        Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm17680650wru.60.2021.04.19.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:12 -0700 (PDT)
Message-Id: <2b3021c4ba626033cde3b28dda7e5a83b85be2b1.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:53:00 +0000
Subject: [PATCH 15/18] t7900: mark pack-refs tests as REFFILES
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
 t/t7900-maintenance.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c006..6f2f55a6c51d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -343,7 +343,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	test_subcommand git multi-pack-index write --no-progress <trace-B
 '
 
-test_expect_success 'pack-refs task' '
+test_expect_success REFFILES 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do
 		git branch -f to-pack/$n HEAD || return 1
-- 
gitgitgadget

