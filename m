Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB1AC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E360461373
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhHWKa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhHWKa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:30:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDAFC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:29:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so13704121wme.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7Uy2wnGv+nUV7fiu2+2RJ6v1n4960jCCc/RHeypW9U=;
        b=WyngPCn2OHQ4xP/BmVKyHVtXUynpBqo8dR0HBmP2fqONu7but92ZQw07tGHqIGeQ9X
         x9pZSa3JnENrSWecmpkWhBBUGPrfoxMLmA6hBc2HyYrA/yCuFn6hDJtbzgwVnpqqFZrV
         rwDXrf2aFXmH1YzmMuDg97hEiM3efqD5giVm6qKKg3DRTcjg9jRwGTMcHatrq8K6zjeU
         SCV67zZhO4pOAFRDsH0xCi/YwyfkeYyrwZp6oacr851Rw9qkUSpmgmVDFDQivtfEhc2i
         kq0YUuBymEhJgaH2Q2vmrs1D1qDyHSf2NYvzgAiQW5niPFJqxu2fS8ZtDWvcsXV4p+ca
         rOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7Uy2wnGv+nUV7fiu2+2RJ6v1n4960jCCc/RHeypW9U=;
        b=AFn5a0y+IhtjuJGXrc8lk2Mhrvi9VmPaV+zFQFlX5+uovKh0Q7o977mH7ZqXqGZrDV
         IvlWSBInBTHkUoE14oOLHm9K0kOtMtVIIMM14Xs/IM+Q5ykjZPC3PQ7bC8jnLbJ9boEM
         j9wTUoMEL+MEMMnNPtPoMBRJReMfYXca0aeb6XByDbiPHqD304DPTrmdXIb7d3rhUBya
         K8YZJ2clzERaKpMKhgAEbQXlQm9JSjXTMyjyYQRyXXtAlzUfwNNRJMbZ72Ee6rRnaHP/
         xpk7QAZt+gX+a86hMDtSfMy2RKhtmdrlbn27Yvs3BD3mKI3Y3jLuBGrEbcTuuRSWrUi6
         iK5Q==
X-Gm-Message-State: AOAM530LBayKmtZPsbFESR0PEXddQTN/rhgyjfcBhXPZW0wtHALFDjtO
        zvLHqsc19KYjHaId1GptQMfih5ED/ZK9PrRA
X-Google-Smtp-Source: ABdhPJxjlgsHz07KxNqyo5yGJTc6TzDFs3g0Meper5jiSeBurIstISgt3hlDNbSdtlOOvoiKNhpJ9Q==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr15060242wmq.88.1629714584651;
        Mon, 23 Aug 2021 03:29:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y14sm14814383wrs.29.2021.08.23.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:29:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] progress.c API users: fix bogus counting
Date:   Mon, 23 Aug 2021 12:29:39 +0200
Message-Id: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
References: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes up some users of the progress.c API. See
https://lore.kernel.org/git/cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com
for v2.

In v3 the old 2/3 is ejected per feedback from Phillip Wood, see:
https://lore.kernel.org/git/87v94jzoxj.fsf@evledraar.gmail.com/

SZEDER Gábor (2):
  commit-graph: fix bogus counter in "Scanning merged commits" progress
    line
  entry: show finer-grained counter in "Filtering content" progress line

 commit-graph.c | 2 +-
 entry.c        | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

Range-diff against v2:
1:  bcb13be5006 = 1:  443374551ad commit-graph: fix bogus counter in "Scanning merged commits" progress line
2:  8e67712c480 < -:  ----------- midx: don't provide a total for QSORT() progress
3:  c70e554e461 = 2:  71c93f624ec entry: show finer-grained counter in "Filtering content" progress line
-- 
2.33.0.632.g78310755cd0

