Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C1C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B176102A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhFQKDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhFQKDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:03:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5CC061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id di5so2640930ejc.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnCIsZcCarYFjTzD0J2h8t6mRFcXg0pdidnzJxw9K84=;
        b=h8s63ZH7egDTxiVygeVg4r2ok31PDbpNzoQAEO+T6epqNfpPFTbNa2Hta5lIdeKnHk
         AqJ479QdSmOSeXfBlAvBkRKCBlXJDg6dHjFSKl4KOuBcrtzTrCMH8tkDw4h1ln1mckk3
         7m0RLSLV1eg1ePZcP8KLTb2zrwjV0wCTkoFsKhgVGTU03U/u4DS4n9iP69kAh2nvj6zM
         VU3nqYQv7T/3elCsLmj2tPOT0+UKr7JcNUHsjZiclSZ7mHvbRXGDzCwUgveI5KaPWNCI
         X9GI2CoRRyjJJI00NstkkfQdWxUbm45l2vhA81VPzAKAEIUAfxdrFSX6SZC2LjnfIJDt
         MlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnCIsZcCarYFjTzD0J2h8t6mRFcXg0pdidnzJxw9K84=;
        b=FFL2w2V7ftoDC5ra/wjvV0oypyI3AsXRjU2R5y/j/qrvM7jvr1NXe52TIISKT+ooT/
         l7uLTvpwUD6KerSFAm7crmjbCgPZZFK4PmOEcfINMYO4GMqRuey79oOV+POuzEb/JNXT
         yfmaQrbOmxg3ddKSDqzADYG+3TEdP4fe8kIGlttIf+21IFlQUfp/ESFwbzFc4+eM/xy2
         n8LeuIOgUHMEkrQASEyYg6HuYmC0XjLtq6GaI0KgWYtbcUhdiF1FB85QqvL1APMkSHLC
         PvSjvYo5jlBlS/OM3wziDGUN/rRBTByFlChiO9pKAvjCKT98rld1Zr5b3e4vV1zCwRej
         wyjA==
X-Gm-Message-State: AOAM533JgvlS3GP8cfLo8hopkDSo2QSb7b6xTZEP/7dauK57qls1+53a
        X29IvFDToPUxW3rObEAztSB7xFEmYiX4Yw==
X-Google-Smtp-Source: ABdhPJwj8C+YXUGo6T8y3Z93OfsxvluHBlRZO1o++/atmpMkux1UzVsJCQgFp4cUUSEsq/yV30m/OQ==
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr4330660ejb.40.1623924100873;
        Thu, 17 Jun 2021 03:01:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7sm3827031edc.46.2021.06.17.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:01:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] Makefile: misc trivial fixes
Date:   Thu, 17 Jun 2021 12:01:35 +0200
Message-Id: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm re-rolling ab/config-based-hooks-base to deal with (among other
things) a vcbuild failure. This doesn't fix that, but allows me to fix
that in one place, instead copy/pasting things all over the place.

The reason I'd need to do that is because we define GENERATED_H, but
then proceed not to use it when we should. This small series fixes
that in 2/3, and fixes a couple of adjacent trivial issues in 1/3 and
3/3.

Ævar Arnfjörð Bjarmason (3):
  Makefile: mark "check" target as .PHONY
  Makefile: stop hardcoding {command,config}-list.h
  Makefile: remove an out-of-date comment

 Makefile              | 13 +++++--------
 compat/vcbuild/README |  2 +-
 config.mak.uname      |  6 +++---
 3 files changed, 9 insertions(+), 12 deletions(-)

-- 
2.32.0.576.g59759b6ca7d

