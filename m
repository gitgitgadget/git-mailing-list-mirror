Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EBAC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874BF20729
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMKDy27O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKKJye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKJye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 04:54:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB37C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:54:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o15so1917243wru.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5LshmXoZrdntBcbmAVvrm3QbzPEi9KcX+4EwpxPEUs=;
        b=YMKDy27O33I660gH1BuxCT4z4VKIYiuT1iV/rRByH61sUapay7Z32utWhgAYlYXeKU
         I7jC2a6qKXCs4juv3sBC9itEIwYoq0AfhhirGVdSJeMuOVECz/HgtScvONImWnsP/cYa
         W1PL/h5CUACXYfW1/nien4wUSPvylFodjfgjhDt4f3HCnyeutfJa/QZLPtdFa5wWcuiK
         BD/Ym4DFo5zNJZSb5ZSWXyDFn5jTk1I1Zbv5sbCd6LsYzg3Br9912flUMu8toRbyUjVx
         RHFs2S+uMCvJx11gtLnkbSRtAlZr2Ojocr8kVX8g6Y0FxB3VVO1g8fy2Z9kEznPkQ7Oi
         7uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5LshmXoZrdntBcbmAVvrm3QbzPEi9KcX+4EwpxPEUs=;
        b=R1ef9YcGnJrqFDQU2qcXMGeCcJzez5hmwbErqY6UycnU+W1yrHL/Lz3PZEcg/UcL0W
         Q2AFX9vs/01wcmeyhiHkEOiGKNSEJ0yg0ONCwgu6i66Svxh7yJjIudWdqGj0blCRB8xx
         ZZcPgM6iZJZtPKPyfF5ic7hoyndVlGGoDpK925OhPc7zkOOqlD3FmcJB+ZhwCTy1WKl3
         YTTq0xeyZXj3M4j0ygONrA/9FW6ploEu1hOjDeQB5GTCmtdRppjwdNwpY1BpnrhWqGeB
         vRbJH9U/ftIQl0Z7NhgnsdJO9KN3+CtgEoxJ/R8amyOxsHdYlkWkhqldUrZJk9gUcCUD
         0DLA==
X-Gm-Message-State: AOAM533Gp7Bksnpj6s7tpZYtJXdshjTPsY70maMaf0UJGKJ7XfF7htCo
        wLMHBZINugRmeCaGA34/XOoqouvs2FE=
X-Google-Smtp-Source: ABdhPJyuZlOwbPBzhHgpEU11MB4R3sP4vsU1ehVN3RJgvWPxXQ/5KLcJX/HFLCBzYru/JIn/210fJA==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr16599930wrt.105.1605088472206;
        Wed, 11 Nov 2020 01:54:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g131sm1983374wma.35.2020.11.11.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:54:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Knight <james.d.knight@live.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] config.mak.uname: remove unused flags
Date:   Wed, 11 Nov 2020 10:54:18 +0100
Message-Id: <20201111095420.1446-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial cleanup series to remove flags we're not using anymore.

I don't think there's any more unsed flags, I looked with:

    for flag in $(grep -o -P '[A-Z0-9_]+(?= = )' config.mak.uname|sort|uniq); do echo $(grep -c $flag Makefile) $flag; done|sort -n

Ævar Arnfjörð Bjarmason (2):
  config.mak.uname: remove unused the NO_R_TO_GCC_LINKER flag
  config.mak.uname: remove unused NEEDS_SSL_WITH_CURL flag

 config.mak.uname | 8 --------
 1 file changed, 8 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

