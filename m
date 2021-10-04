Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B0FC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CEB6124C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhJDCAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhJDCAU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:00:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D0C061781
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:58:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so27868592wri.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxTEtWaBN/vuEBl0WG4WPjLiWGe+T1qB9CNWeU2zUV4=;
        b=VOQJH4NqKWMaheS9IN0VibD82WZOcv7HQEtdJ6BEqm9dMbrxPMOMjENNpnsqiBhva+
         IiTB5yL1rB1BsIvPlsGR85lCAZcHolSCcToo9spBMDppRl2Re2Mjs+k+cNV1rtCej4dL
         cXTw2NuW0njgR81Tpaa7GuUBlCMtO0djjY15DC1B3lbCegEVy2N2AC8JfR65waGu0mMC
         qXbgwiTpekM1WliwVGoDPvjccvdtictjoEWNpc5rEYCtB25CC+YlLoF8CiE43vulmoQv
         B7VKQ/lOfSc/aHdv17l194YaQee7N5VAzjjT/Zfl2r1EOMapPwO5tnPCHZaqH4vnQgqx
         TGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxTEtWaBN/vuEBl0WG4WPjLiWGe+T1qB9CNWeU2zUV4=;
        b=noYmkOSzDgMO6eqCM+h3fHfucJJl8EIG0iMm8gcibc0deZ+ok5PToOpMSeUj4jX0ij
         HfGbUNgh0n9/bSJhyjJYvXuQoBLitzaBj+dMbhps/vn3SepsO4yrcFwo/huNvDzjgDa6
         SlPLoLqLtVopVMjpwynnTpnDC4kxQjSjrEnHcAb/wxEvyv3v22Srp5YIHh0dF8aQ2yvW
         iwNV1Bby+AE1S7/Cci6wnfx3nMYkVX7Vem/PgmgTuzUjaEt3f3KN9bzcswRf0MLkm4Jc
         YWIV6qZZMokQITwl8+40lkbZlll2dmGz4YE0OExPqECZvInfdYcki53UPAfq/a9ToXpD
         NJvA==
X-Gm-Message-State: AOAM530wR161nEcjFU1vzxjKFHl3a0uf4mZxpQSSwGowqehZf4cQ6d5+
        yuehq0m0v0TjUvGegTNSZpRSh4YqAhnYBg==
X-Google-Smtp-Source: ABdhPJw612PJzfSoRFM4YKFFSRunvxT2Q+D+0SKVszPrPGq77yAQrKDLBe+UNsscAVWxb2Of6kXVOQ==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr10904832wri.80.1633312710256;
        Sun, 03 Oct 2021 18:58:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y23sm15349355wmi.16.2021.10.03.18.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:58:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] advice.[ch]: sort enum fields in alphabetical order
Date:   Mon,  4 Oct 2021 03:58:24 +0200
Message-Id: <patch-5.5-171153d421e-20211004T015432Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These fields have slightly drifted out of order, let's re-order them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c | 2 +-
 advice.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index f7cedac7549..e0ee8ca4f2f 100644
--- a/advice.c
+++ b/advice.c
@@ -51,9 +51,9 @@ static struct {
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "advice.pushAlreadyExists" },
 	[ADVICE_PUSH_FETCH_FIRST]			= { "advice.pushFetchFirst" },
 	[ADVICE_PUSH_NEEDS_FORCE]			= { "advice.pushNeedsForce" },
-	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "advice.pushRefNeedsUpdate" },
 	[ADVICE_PUSH_NON_FF_CURRENT]			= { "advice.pushNonFFCurrent" },
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "advice.pushNonFFMatching" },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "advice.pushRefNeedsUpdate" },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "advice.pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "advice.pushUpdateRejected" },
 	[ADVICE_RESET_QUIET_WARNING]			= { "advice.resetQuiet" },
diff --git a/advice.h b/advice.h
index ab25c6ba9a0..a6aca9684c7 100644
--- a/advice.h
+++ b/advice.h
@@ -31,9 +31,9 @@ enum advice_type {
 	ADVICE_PUSH_NEEDS_FORCE,
 	ADVICE_PUSH_NON_FF_CURRENT,
 	ADVICE_PUSH_NON_FF_MATCHING,
+	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
-	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_RESET_QUIET_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
-- 
2.33.0.1404.g7bcfc82b295

