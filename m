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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B9C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F9161077
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhDSKzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbhDSKxv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4218C061343
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z6so112741wmg.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dp8makdTS/NHjMfdBIkDs+dxCfZ8wwmWyjvTcQeCVEs=;
        b=GCOjwrCm7g7JKdo10iFJSv6ydH7MuYa1vMNHM6T8uIz1xQBX+U4ZJqgyMnwWiaWM9L
         JdCmK6ubfglRjoRR8/etAduY8FOSEndOcrGNt4HieQetXRufs9Nz48S3MHkiHMYFJmiQ
         jyeNEUeooUBIpsbV1l2YJ4SeJOc3gTK820y38xIK+tl1K1upXLrYwangd3gHv0ZLdIMd
         2f1a3oYVcRe1Ysie7BqwWd1EvPB33VHc+pSL+/qu3e6Y3R8egjJdMG0O2Q++PgsPihgj
         yjBw10tGgyGOMZzNbzK+fGJ4qdXSY38f8nK2YlkScN3yOIUx7meFDAgezELeD2q3Ct/o
         gsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dp8makdTS/NHjMfdBIkDs+dxCfZ8wwmWyjvTcQeCVEs=;
        b=P79oDjQtVVu51NX7zdK6XWRlYXOMiuTGNJai2DhzQEYan2JnireXnd+aNzNX5gjSjc
         GjcFFQDjGCbVX8IT/kVDIP492ipgQBf5hjlUui0egR0ljgtye6469n25KuS2rD5rQgUl
         Qcsp3pDSuItkzOnknj6oQC3F5snDosIutBwOa/2x5+A9lP9kjEW6PixBufctglGKU9Y5
         KMGpDPsT3qe3WtqfkD+zIKou0WbyOM12F5boPIEBFN7sZ1STyc6kOZnMllc3HiOcjbY9
         ljvNYjsqppBZYfu8Y0+hH0G+eNSu70GsuoD4nZfuYZII+i3M6N7iEBK9vrovnzCzK9FF
         ARFQ==
X-Gm-Message-State: AOAM532dCrVmwJ08r/tbnTfM4uIyVL2hTFMQpCD1HgzCZ0FD8d0yRn+C
        ooEKAbKzrLe2evUlIxQoEu/apx5d2no=
X-Google-Smtp-Source: ABdhPJxkAdUe263V+UyjPP/BsvvuiCwEE+r/cQcVBzFhR47pppBYJRuaoHwT4bmiMJDr+dfFjZVubw==
X-Received: by 2002:a05:600c:365a:: with SMTP id y26mr20398260wmq.102.1618829593718;
        Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm23134905wrr.26.2021.04.19.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:13 -0700 (PDT)
Message-Id: <a2cce772d44f5939475a1dfddc1a55ab9bbb8ac5.1618829584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:53:02 +0000
Subject: [PATCH 17/18] t4202: mark bogus head hash test with REFFILES
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

In reftable, hashes are correctly formed by design

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t4202-log.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index c575deaad4fb..ed6d4ecd3a28 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1834,7 +1834,7 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
-test_expect_success 'log diagnoses bogus HEAD hash' '
+test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
 	git init empty &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep does.not.have.any.commits stderr &&
-- 
gitgitgadget

