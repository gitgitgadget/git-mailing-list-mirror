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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4011C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BA961102
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhHBQxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhHBQxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C4C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so377339wmd.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+LQv9W/8FyW4BLvhS//TTXSTF5vhzAh80O5f8juX6TU=;
        b=gHGASDUeMqi9tpdHd0qgtVzWSif3Od4nOJWgCGC0eo1FwaXIPEnPeyNZX9YOoqkmD3
         51s5sQRodq9ZRM1LFfm5Wf3bOmPmwT3P1vEmbzQxWwSXy0PnBZZcC5rwh26nizcEoPgY
         h/d/3HRFWu9e62374XDXT2fHn5a07POkvrnOBE05Q+a3SgpNylmkdHX6/b2bLRvmQ97D
         tu01xbBHwBQ0f6NwGeaTM6Ik3IDoOUENm6JC7w8lvQnaZMoDGmBY+E4UKHaAktYo7M/d
         H6B22Ar4WDi4QDpQC46ga0lOLFAWbIf8DfW3Cf1IwIiXZiby7zoe0ZwjO0tcCob/RcQ0
         yFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+LQv9W/8FyW4BLvhS//TTXSTF5vhzAh80O5f8juX6TU=;
        b=uY4b2wwrsfwE/RNCxZQ4oJj7VMaQk6HlLsaqHd+0oiKXcgWDgJIeYg1PZ1As/wFu+9
         /t0UkVJSZiwLlbp3rcKsgDGW39cZN9/grAXi2vs/To9DO7iGeePPb0SkO7k2eeCueIyc
         bkeZkNW8rPFEOEbghdKxrCEmRd37LIIFmdJBHZ/P3tMxcsHWKCAx8Sqpx6xS+o2MmJhd
         FeCnqfJUM759DSOrcE4rviBVhH/K1niNyhJBT6dtoBq9cQb43erl3ia5K9cYXo/M9z78
         peMp48kfvEacLy0xxji8OfgTVRDzdinwog/dO0nKzZLJAMQr1/1h/RDoCJ1tw1YjFOK3
         xE+w==
X-Gm-Message-State: AOAM530D3dmjERnUvldnaT+hLZzC5rG7BcPWQx5OwLr4FiP1w/PI4lIL
        bTdpXZ/tCV9KMnzzM3uP6ckM7zIl13k=
X-Google-Smtp-Source: ABdhPJyXrjI287G2o+uIEuEc9K5BUeVmTlJodk1HFWQp94UTyMCGHvpnU81NX7DpDqQyZhET1czu1A==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr17926774wmi.86.1627923218200;
        Mon, 02 Aug 2021 09:53:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m64sm12703175wmm.41.2021.08.02.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:37 -0700 (PDT)
Message-Id: <ad9fd5700242a991edcd2801b85914da2fa54f44.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:26 +0000
Subject: [PATCH v3 01/11] t6050: use git-update-ref rather than filesystem
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
 t/t6050-replace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index e33d512ec11..2500acc2ef8 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -132,7 +132,7 @@ tagger T A Gger <> 0 +0000
 EOF
 
 test_expect_success 'tag replaced commit' '
-     git mktag <tag.sig >.git/refs/tags/mytag
+     git update-ref refs/tags/mytag $(git mktag <tag.sig)
 '
 
 test_expect_success '"git fsck" works' '
-- 
gitgitgadget

