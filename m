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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6748C4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAEC610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhHBQxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHBQxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27620C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j2so22185147wrx.9
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dkjFbKCqgkmzb3ALYM/j8lsueduBg9xjD6SXKLT3gIk=;
        b=rhv+2A8YwKNfDifPi3kuz6dpUTGMNr5zlB664pmV091Ib6nPNrxgIpA9UUfMNarP9Q
         gFzubIfu6zal5qkjJqxol47O2veJBHZZEGBNR7EzKh0a3xuzUOnu8BU24ify0ALl5u/L
         EKSEXkKI69P3ZkR1IDQjXNTwPGsWKa3fP/D41BPJ8gtwf47BeRCy3rv23ImMFM+uSGAY
         SStlfFMBmY/aArrhtttsFPVBfmHrH7dpum6+n7++kRomLH9pzWA756tQocCx01bXPuEW
         3sPlYZ4D2vTs60ITvvbr8AdSUkMlrQ8Swwlg0GGNbGjZ3HYRZv3XKYWohl5y5gCsEAGM
         klvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dkjFbKCqgkmzb3ALYM/j8lsueduBg9xjD6SXKLT3gIk=;
        b=XBYvariIPmeLDZtTzLIoDKXWm7R8xQ3dpCIgRbSSzazY65oZGqvky8DwH3F0iBHvNN
         uOunxxciF8WeTKUQkeu2SdDM+mmdv6JxsdtMqxTPdH1IzzG3+0FTxDHCbokpJNaMsecx
         rdmlKfoDtDCi01IeJsZBsvX3aveqiofrxBWH1bhT0qY7+d9elVX1AqyhuOLGv+NeFFmZ
         fM1z0p7AdApj1KAUXssozFZoiwccxA3lUHvDMt+7qwfbTXxchs89l+yAhIb0cheTvpu0
         3B2SoDacUaGidBmlOK08852VVAkq09Ai6amIV7A6hL4mDkBShS3XL0HWeSjRE8zrXw5F
         gh+Q==
X-Gm-Message-State: AOAM5331J2PeRmTSCuxsvHjKqfY3aW4DZOdpYBHhMOdjkvs7Yq2qkKLp
        EQdKBeGwHzvJ72dZ1CRSFGMDCmlCt9s=
X-Google-Smtp-Source: ABdhPJw4CMsLfsI4n7cx8mXP6ZF6SYfms3txPaWjUGdZmeG4f1bMOGbZojB3Udv+GcK6M4rpc0iNiQ==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr19280559wri.63.1627923218797;
        Mon, 02 Aug 2021 09:53:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm11855194wrq.15.2021.08.02.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:38 -0700 (PDT)
Message-Id: <b03be9ede7f1462f35e5dcaf24a8c82cfc4d780f.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:27 +0000
Subject: [PATCH v3 02/11] t1503: mark symlink test as REFFILES
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
 t/t1503-rev-parse-verify.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index bf081023917..40958615ebb 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -142,7 +142,7 @@ test_expect_success 'main@{n} for various n' '
 	test_must_fail git rev-parse --verify main@{$Np1}
 '
 
-test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
+test_expect_success SYMLINKS,REFFILES 'ref resolution not confused by broken symlinks' '
 	ln -s does-not-exist .git/refs/heads/broken &&
 	test_must_fail git rev-parse --verify broken
 '
-- 
gitgitgadget

