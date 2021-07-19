Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE6C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A92E610FB
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbhGSRbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380086AbhGSR1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F1BC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g16so23136763wrw.5
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dkjFbKCqgkmzb3ALYM/j8lsueduBg9xjD6SXKLT3gIk=;
        b=aujQiGeCHEZrVzOOMPf572szVglVTAckByFeoDj7Q+F5via1fAqyBLwcG2R/HzBavP
         YDygIp4zSTCpRzMtRYornrpMS82z+4FuifpCu5wQg/3MlZgTqdrFXx+HVb7U/Cbekunz
         OblLy31Um5xGgkIjV852Icu6fN5baXLSG1YnninboVpr+Rr8MbfGnjvdyQOF4pilCWbS
         Nk+E1ewh1LgwJiK+n+yJcOgPK+F1aAiMFWYypl/d623f24thG5MQLtDqGRIt2aylWnmB
         OQG4lH5q3Lm7lYXy/AcmLVpZzpSaV5gPzGDnAVxdQP3xmPy6AEtoDq7pIaucfhD74cRw
         g+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dkjFbKCqgkmzb3ALYM/j8lsueduBg9xjD6SXKLT3gIk=;
        b=PJp0HhmZYROdpNYa8JilI4RK0n4+eMUGjh3jEqBP0Hn/tTywIa3KYMjcsFqwH3rDtt
         Tz3w5FmBW/IzY+eAc8bH5BMTe0x42EpdNlL4ZiSqPUiNwZvlNe142MFozqB1VlETu6Sx
         c6Nnq/xmf+9OvQV2rEYzdyKXLOfbekHfcsglz/Qrk9J1IW9AinqNJ+a6+9tQA8Q7gA3E
         3w5K0K7AYfDMTA4fAdb7AD49UiRz5CesfuqHSVzoS6LC5JNWeI4SB0kccDXfh+vJwY+C
         b9Oe7ry/TBV1Ol2LjBpbkYh01lmHVFqflbSlfsEKZW61TEJ478VhhY2hsVbpyuAArhSo
         4ACA==
X-Gm-Message-State: AOAM530nElc6jMnZeVbEpFmjXSl1WjA4bcv5i5BHpCPcmUoSqHFWyuAc
        RNHIa1yIAFVaTHxE23zoF5TLhQI0ziY=
X-Google-Smtp-Source: ABdhPJyjiKj2wOZYrg9DhPNsGm8ujcZnf3N7lkPZK70Bd0ucgX+Lls9JeDBitVG98VIN4vCJOXrLIA==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr25162840wrn.235.1626718052729;
        Mon, 19 Jul 2021 11:07:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 140sm17603539wmb.43.2021.07.19.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:32 -0700 (PDT)
Message-Id: <49994a0d154abd3e4cc7d8cf64044b8ab738819f.1626718050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:26 +0000
Subject: [PATCH 2/6] t1503: mark symlink test as REFFILES
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

