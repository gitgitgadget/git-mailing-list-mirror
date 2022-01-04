Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCDBC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiADVpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiADVpd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:45:33 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F058C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 13:45:33 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id kj16so35653885qvb.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/y+qZfnzMOVYB3v7ITlImnkJZ0BlsbHWH7N9LweFfQ=;
        b=eOWq3ZIOdJUBhTfUR8KTi/0md8Bx237rfPOxrmk9o2tOiSuRLCdQvnsVymXNzbvwlr
         r50/KLyYZErtvaigrlnnJN1Fhjc/89WVtZV8PgyBPobEVgj8hJPedzSGsCjkDPSIbseH
         MFK39qL2o0a0igx66/UvWaYh4RNpKJ154ijZ6gatT7BL956AMzq/9U0BUdoi02LBGkJh
         ZkxwynPkuGo7D4TomFrG9J+1P1shDGuEpZ/nW9xgQrbW6vAPZtlyRoq2N563JQCHt1qu
         dOW6APPS8CJtrWVkYQHhAXKws9p0vPfgtlD/eyfswZ3mAqlFqlvoV+UL8mIrP4AAO/E2
         a05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/y+qZfnzMOVYB3v7ITlImnkJZ0BlsbHWH7N9LweFfQ=;
        b=6wcINgwDn0+Yd4MV00//Crc1hvdD+IAUHNCneGMKA3/q/Ey8m5bIakBiKzrQVqvPR9
         gyg32gyxqvQ2tCO5ob1PnA9YwwhlHg47O6MOtsYHJlhw+OaMWkVVojcOBrqO7qhaLr8S
         ST40mcZk9K2dD2w9EhzYpfEVTb9pLaPGkFsqJkFaJkPFKIbgKaG4cne9TmRL8waJrT37
         u9277cxNzW+rkxBKyQUQsLg/wGNCPh0wuYsdLX4y/P236vA4D2KOo82zrwJwpneH32ru
         tWq9hJe7sawLD95aKfb7X2iNckaYx0EzLXYD4BYXkfEnGTFzSKCj+BNHCEoJ0RiFlsGc
         7MKA==
X-Gm-Message-State: AOAM532ailKsncNLCoe/pmO7RgqJRKup+88aNMmKDsJubzPdXVG1MArz
        sUcp09V7M1sz444kQctTyhMLc/wJdsKZmA==
X-Google-Smtp-Source: ABdhPJylVBP1JqwZv4z7P9f9x8RvZ/TfPgJuv7+Un43x80/OP8CRpjhI8XYAoV8vqfhl3QoG1n2YaQ==
X-Received: by 2002:ad4:5d62:: with SMTP id fn2mr47914459qvb.44.1641332732152;
        Tue, 04 Jan 2022 13:45:32 -0800 (PST)
Received: from Johns-MBP.myfiosgateway.com (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id i14sm34352164qko.9.2022.01.04.13.45.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Jan 2022 13:45:31 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Subject: [PATCH 0/1] Fix bug in pull --rebase not recognizing rebase.autostash
Date:   Tue,  4 Jan 2022 16:45:21 -0500
Message-Id: <20220104214522.10692-1-johncai86@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: this is my first patch I'm submitting through git send-email. Please let
me know if there is some convention that I'm missing. thank you in advance :)

A bug in pull.c causes merge and rebase functions to ignore
rebase.autostash if it is only set in the config.

There are a couple of different scenarios that we need to be mindful of:

--autostash passed in through command line
$ git pull --autostash

merge/rebase should get --autostashed passed through

--rebase passed in, rebase.autostash set in config
$ git config rebase.autostash true
$ git pull --rebase

merge/rebase should get --autostash from config

--no-autostash passed in
$ git pull --no-autostash

--no-autostash should be passed into merge/rebase

rebase.autostash set but --rebase not used
$ git config rebase.autostash true
$ git pull

--autostash should not be passed into merge but not rebase

This change adjusts variable names to make it more clear which autostash
setting it is modifying, and ensures --autostash is passed into the
merge/rebase where appropriate.

John Cai (1):
  builtin/pull.c: use config value of autostash

 builtin/pull.c          | 15 ++++++------
 t/t5521-pull-options.sh | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.34.1

