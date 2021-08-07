Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB0C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16D461040
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhHGU3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHGU3e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 16:29:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2CC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 13:29:16 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id e14so13948044qkg.3
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieQBfjW2X4++i8jKiIRxZ6nr0n4dKC/Q6mcOT2YNBys=;
        b=edlna+nzpcOjW1xtUjtMYfmPy5Q+VJNnVqIuFQG6baofiVka6y+FxGha1vwIQd1NAP
         UA7dGCRkrsLv4WVWcbss+tTI82ZnjoPV8XMiP0C3WhdRN4PQ90GQjknmXEmBvOV90TvG
         yUfPRDPPo8hE1uLzbrKkvXSvjwmTrVe7HshLIVEXnKX4YzIWm0m9Zw5Ew3vk/rC2K1Bp
         kKO3DL3lv6RC2k6V9SwofmAL17gszl1JkNyWxyNMA8ZO0e572Tc+6wY5XQAHNcQlBS02
         WesjjmuPuAXYFHxAaX7ALoRLl3ROhQio1fg8Tey8wWXVTu/9tRvXfOh15YHFjbgPIWzj
         XP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieQBfjW2X4++i8jKiIRxZ6nr0n4dKC/Q6mcOT2YNBys=;
        b=dYIyEUu/9g4p6xJT/yuWyEcQ+rgYX+S0pzSl7PkHd+kmRLmY4W/lR7YrIOYXTwAfTo
         9yHxvZYLKhzA8TDKEYNC72mtv4B7QTV4B7p5adMEw8H+9LiAYfC53GcDXvZ+kk9nUUs9
         zbiUmiI/f8U8+QnbLxh54cwu2HiFOGFa6bY+Vs60UBJVN28M+SDxz0Fm/k/Un0N741pK
         cFtHt5d6gaKYYwUivSOEPjkllGRzq4AH32wRS4IudggmN1dCgYLGT5ycQeAKnx1E2thz
         Jy/c1D9l++HOZaC2i/dgXhPWYy1FmBvIQv/ioI4QEmmDsrxSucFzxVpgfB9SR3XtdSKQ
         RpNw==
X-Gm-Message-State: AOAM533LHtB7osYkyWHxRGeI+gtk53qlb/RmdaJ/YcaGn96D4M267kr0
        Be5ObkFqVUEUeZFTW85ebw9QH8s5NsU=
X-Google-Smtp-Source: ABdhPJzS9yo+Vk/Fxd8Iu1AXJkzWZtka6ybV0eXPG7UmyXqpu4R4uusmO2lpk3CZP28TuZmI3Geyew==
X-Received: by 2002:a37:541:: with SMTP id 62mr3892367qkf.183.1628368155122;
        Sat, 07 Aug 2021 13:29:15 -0700 (PDT)
Received: from noah-XPS-13-9310.myfiosgateway.com (pool-173-48-203-160.bstnma.fios.verizon.net. [173.48.203.160])
        by smtp.gmail.com with ESMTPSA id i67sm6665653qkd.90.2021.08.07.13.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 13:29:14 -0700 (PDT)
From:   Noah Pendleton <noah.pendleton@gmail.com>
To:     git@vger.kernel.org
Cc:     Noah Pendleton <noah.pendleton@gmail.com>
Subject: [PATCH 0/1] blame: Skip missing ignore-revs file
Date:   Sat,  7 Aug 2021 16:29:01 -0400
Message-Id: <20210807202902.1279624-1-noah.pendleton@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting a global `blame.ignoreRevsFile` can be convenient, since I
usually use `.git-blame-ignore-revs` in repos. If the file is missing,
though, `git blame` exits with failure. This patch changes it to skip
over non-existent ignore-rev files instead of erroring.


Noah Pendleton (1):
  blame: skip missing ignore-revs-file's

 Documentation/blame-options.txt |  2 +-
 Documentation/config/blame.txt  |  3 ++-
 builtin/blame.c                 |  2 +-
 t/t8013-blame-ignore-revs.sh    | 10 ++++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.32.0

