Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A090C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23F761153
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhIKSW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhIKSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 14:22:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6BC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:21:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so7692623wrn.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NBCquTxcsROgQLePo9uU4rxpWdrM1bUpQZbq1ACW/I=;
        b=jGEMxPQojTHATYp6lXCyy55k7FTnnTDxJq+PVkFYRV2ek+EzxhPfARd/MZIddCOPyp
         HaoQzDSnjIfS62u7Yv1OlJxglBanuQQTeOrM8aauUNINQRO3Y0YAIBShPQYBbrOHavx6
         LDvs1d0NSZ8WcYNWlW1y7C0Yb8luTq2QszKiNxhtKQ/6IYZv8GHqp1d62WvlCpCR5FmQ
         r7SDvvdinTMQzdlP1kK+q1lXCkX+Xeap2iAUKcDwx6LWsQTnZa2d0FyEvU4ygV46qdvO
         IomsCHuRKNcjhhQ5DUOfHMTbc3vBUHFd5BSHb6LqMea+Z7fxrxWybcaSQ/v4x0tYLPIJ
         dLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6NBCquTxcsROgQLePo9uU4rxpWdrM1bUpQZbq1ACW/I=;
        b=2sqkGVBre0hrpJhEaCDxRbnIlJ4d8DYFZQCxdBP2aIM3VnY2jgAinnCvAD2TvyrwBY
         mhHDGLP8tugSbRTsBocCHHh1eDl6lzKpJO7V7KWVfq2V5FLGNnI4cwGGBEjLGoVx2p8h
         fvYIu2UVELmM1J76kbab2aQXzMTBUTcrQK1IjSq03Kf0Fdl8e3wAx7PcymMx9ZaOW48c
         mT/sIYGgYWchsoIBi57M9mjm9El720RfD2XwUlZMdV9tcgsDqY53of+5GjTAw0c8jV0w
         xPVD0UBV+UJc3dNqOhwvFf4Gg7YYPxhrimJC9YwVHX1DDYk0e3/Glztte//UurbvDo+E
         LCZQ==
X-Gm-Message-State: AOAM533I7+LpaXU79fZhA40ACFoLmHgP8BXR2PRzXi72kIZIojasK1QC
        zWQJM6Kkzu5tHYcstb9n+TBE3dydb7Kj+A==
X-Google-Smtp-Source: ABdhPJwd2tO+T1WwWQpHY5/Z/wPbA/9NLleOosOk9hdOoWqhb5YxEAOeT6zdaZ2Q3BtICua+efCdJw==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr4084521wru.249.1631384474722;
        Sat, 11 Sep 2021 11:21:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l10sm2491959wrg.50.2021.09.11.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 11:21:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] parse-options.c: remove OPT_ARGUMENT
Date:   Sat, 11 Sep 2021 20:21:10 +0200
Message-Id: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've only ever used parse-option.c's OPT_ARGUMENT() in one place, as
it turns out we can use an OPT_BOOL there instead. and get a net
reduction in code & complexity.

Ævar Arnfjörð Bjarmason (2):
  difftool: use "struct strvec" API in run_{dir,file}_diff()
  parse-options API: remove OPTION_ARGUMENT feature

 Documentation/technical/api-parse-options.txt |  5 --
 builtin/difftool.c                            | 50 +++++++++++--------
 parse-options.c                               | 13 -----
 parse-options.h                               |  3 --
 t/helper/test-parse-options.c                 |  1 -
 t/t0040-parse-options.sh                      |  5 --
 6 files changed, 28 insertions(+), 49 deletions(-)

-- 
2.33.0.995.ga5ea46173a2

