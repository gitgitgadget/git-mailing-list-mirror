Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3C1C433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217B36508F
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCERHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhCERHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2923C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 09:07:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w11so2850865wrr.10
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2diUhwvCWiHNAaC+JSCNpyqZt/6t66dUfoQR9mxpSQ=;
        b=DI376c195WuXVqqOkpz3bHn+MkNrnD2rHizdwRv9trgDmU5mJofLV0jIW77xTTy4yT
         PkX72lZRcN+EzynJDCa+o8HNwr2+TJCp3gPb8lo0xBcW/Ib7jCcalFrcAWjT5qxqFKQF
         nZsXQmWshvh68Ryo5/8NQ/c3wZpPF5NO2Kn0K8fjYML5HUAPSxbeMC05DMElwYkaUBlK
         OdwEmtHQm5L4Unwt706doTQrmpCTddPQAsy8dkKKXiAYNERUnQCJjI6AsfB2kSQ/u0rC
         jCNY2SyRcjm8PxowhokGf5B7nr8ux3X4aCYOV61F9bNTCUuLRXvz0CFM72/9OPtrGJ/k
         DuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2diUhwvCWiHNAaC+JSCNpyqZt/6t66dUfoQR9mxpSQ=;
        b=Qtm19qDFnr4AwOjxR9JhboGBLo7UcgjFslLIKhvcyGm0Olu8Mq8ZmzthcB0lq03eRR
         ZI33kfC2I6MnHfRvHLuZceDTLzXG+WLsoafQcHaks8Rzuft2O/OET23fP/FUCOEpSkFJ
         VPsvRtSdM8d+WYKvYDqMAVOxcgg+fu+0w1S46Aq9+sdmIRehQXwtzVQ/Z6ji5xg0CsrA
         EbfC/sodJulWeV0fPTDu4kSYgFTtq+O85ysA/Hg2hteoh2PUSSwDsze0jllmC8bK+hnR
         GhnqQrxEYun9LY2n+Vg8hI2Yna8874w8zJ/7+CfNjvfEEquCt+mFhdn7/z7noMBc7Oid
         HFMw==
X-Gm-Message-State: AOAM531HZzH/vxybex/tzhGdlnQSTVY6Qrdq07KOCiFn6xj65H4f3Scb
        D936V6e8yLzJZUcDJbav2J9py/4lduU=
X-Google-Smtp-Source: ABdhPJzLFyzlu0q34GQhqKb9OFyTWcRz0UtSgbz8Ti5JQVsMHtnSVGCO2nwRngOletwzYVNA36uS+A==
X-Received: by 2002:adf:f3c2:: with SMTP id g2mr10585692wrp.300.1614964062336;
        Fri, 05 Mar 2021 09:07:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4sm5115328wmq.12.2021.03.05.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:07:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
Date:   Fri,  5 Mar 2021 18:07:20 +0100
Message-Id: <20210305170724.23859-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210302205103.12230-1-avarab@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses feedback on v1:

 - The removal of the "cat $@.log" is gone.
 - Split up into N changes.
 - Explained why 960154b9c17 (coccicheck: optionally batch spatch
   invocations, 2019-05-06) broke things and produced duplicate hunks
   in 2/4: tl;dr: spatch does its own locking etc., xargs -n trips it
   up.
 - Set number of batch processes to 8, as suggested by Jeff King.

Ævar Arnfjörð Bjarmason (4):
  Makefile/coccicheck: add comment heading for all SPATCH flags
  Makefile/coccicheck: speed up and fix bug with duplicate hunks
  Makefile/coccicheck: allow for setting xargs concurrency
  Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8

 Makefile | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

Range-diff:
1:  3dfadacc255 < -:  ----------- Makefile: fix bugs in coccicheck and speed it up
-:  ----------- > 1:  b556c747afd Makefile/coccicheck: add comment heading for all SPATCH flags
-:  ----------- > 2:  031e3418491 Makefile/coccicheck: speed up and fix bug with duplicate hunks
-:  ----------- > 3:  88eab1af9a0 Makefile/coccicheck: allow for setting xargs concurrency
-:  ----------- > 4:  4b9679fcaba Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
-- 
2.31.0.rc0.126.g04f22c5b82

