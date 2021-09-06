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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57232C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B4861039
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhIFEkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIFEkI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:40:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3193C061757
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:39:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso3956933wms.3
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=pukPdOB4fTIlQoMVdAi39qwp4qJ+3PR74q5krKOajC9ZjqZLCZZjIqqhUqUXrO8E24
         F6yE+fUPPOlvC2BCLn3Xix+8ebIWNZQuipElgEVkEVUWx/L+T4zpSVnMfhZ/SPM+aJW1
         9e45uDw9RBAW9BysweUm746ceB4pgTgpr6EloSpyCUepjEmWXQH0zcxoBK8+u16/HtoB
         ztqf+IJZttjlZ7gfboElRK84DPRoqYBn8vWIzubuRTsf9CWWPAIWZ4Nf2Fg4oYENWGuY
         HdsyDVcK29kyjVmPo9f4K55g75mFG88TaU+YGdRAOyscAN5dxehMy5AqFeDWGEUX1iEd
         vphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=X72Y2JXlkRf06MadaeInEifKFENsLmUYZCAf8FbSmSA=;
        b=NjX4DTfS+YaGAhwTLnwPO4i7jjJkug1THMVolCndV9DslPYeDTUlDjNBy6Ciul5ZE5
         zEIKbqLMBLnh59Xmq9tt59NMQdUzNly/raaFuZexoXxdwORrBrG66K0PDCBlZRuphOpJ
         Fn4k/vSz3CrbumIc559FC1ww51yAYp3PNEmdiTdWIbA4wepgdSLHhFScRXGp9XrvwCor
         5h6EQnm5iSYIebRVW15NIIfqD/Xk1BNl8X6GE2mwekLMbc+Yk/0AZgVLP6DtGaygNOtT
         Tw5vTJE3heOH/lF/SVI42px+Ajis35/FfPs1nWeFyC5HNSDZwfGgmxc+Hpvtuq7IWIcP
         aTrA==
X-Gm-Message-State: AOAM532AcmCPFsLWI/kLWcV8q43E1o4iO3RVbB42X/kmO23Bo947XoBa
        zQLDS2jgPebLSXWZT+p4gmP7xSExU4s=
X-Google-Smtp-Source: ABdhPJyxSFu3oZ72M2kDN9tZhGAcLoHoMwGrGgsXT4Thk4nGN7dZIyGJBlTFrDjFAN9mhuEc9YyiZg==
X-Received: by 2002:a05:600c:3213:: with SMTP id r19mr9442754wmp.11.1630903142554;
        Sun, 05 Sep 2021 21:39:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm6578420wrc.31.2021.09.05.21.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:39:02 -0700 (PDT)
Message-Id: <2f566f330e01ed4249edad54671e98301dbeec5a.1630903140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
References: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
        <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:38:58 +0000
Subject: [PATCH v5 1/3] test-lib-functions: use 'TEST_SHELL_PATH' in
 'test_pause'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08)
made it easy to use a different shell for the tests than 'SHELL_PATH'
used at compile time. But 'test_pause' still invokes 'SHELL_PATH'.

If TEST_SHELL_PATH is set, invoke that shell in 'test_pause' for
consistency.

Suggested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e28411bb75a..1884177e293 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -139,7 +139,7 @@ test_tick () {
 # Be sure to remove all invocations of this command before submitting.
 
 test_pause () {
-	"$SHELL_PATH" <&6 >&5 2>&7
+	"$TEST_SHELL_PATH" <&6 >&5 2>&7
 }
 
 # Wrap git with a debugger. Adding this to a command can make it easier
-- 
gitgitgadget

