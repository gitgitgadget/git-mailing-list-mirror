Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B3C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiG2I0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiG2I0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2228712
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so2933271wrd.5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wWZeOr+kJ23glTg/NpMT9QYRUyRn3ILzuF/LeSnGAF8=;
        b=B1q9NTwEo0k7JwcAn1EWCXxMkoY0mycrf6uzrlIqOGF+qH8W2GdWAfsX3ul30CfI81
         NLVAmqKwRrE+rFjpz8HBUizsusHojND8WP46g2CHoJs0VXlSTk1mghn/Fnqi2yV5MStw
         slGF5VONmwDCDmETHot1V5iNeMF6EWP2RK+Ubti4yI7TSL83sjqRd4byrDJoq6EetVHV
         FP6bqR/RdajVqp6+AY+4oG6evwXEkTMECa0oPm58LQlfoDz7Byh9loRBVHTbCvcrcAgd
         nY/eDuJMXcfnArzXx1VC39INyxZ1ReQl8za+3qIdH13sXIqmltN6Ms39Rki/HcZZif28
         +tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wWZeOr+kJ23glTg/NpMT9QYRUyRn3ILzuF/LeSnGAF8=;
        b=xIr9Xf7ZicPyMZLGmpms3Cf9/rV2WtEEUbDfgp6F4udEO0gYRysYpkBqh1WehwGupZ
         Sln0IeXpRojUOx0whmUFT4/HjlPhPmACuPlX1lcoIGaB5Gl5hnqS6CM+4kP1Mj62X/la
         2/1ZZkUnUHLU0Vq/6ELM5XzphMy42x63aCc8Q8vU3T8yLO9+Z0RrjqS2pbuyhWAYhmin
         X19uCX3kXZEaDfqJXcaEqGhjP8bVLXp1LrJfT6aI9r8bd0xbo0MZVID00MfsP2CSZGmO
         oygJ3vx6D0hUB9yABkHOcaU2FYynx52eJxkufj5D0qLQwZ6R4IWpsEdUAnNRO8rUr9m3
         w4+A==
X-Gm-Message-State: ACgBeo0BvA+++pQgJmn5aO3Ip8pibddnQU5HZGwwJlM7OVurlcLXLQHd
        uuUBjEguGvFAQk3w434RxTqq6Fs3Ou0W1Q==
X-Google-Smtp-Source: AA6agR6vur5+vjbr3mv+vqMPP/oAm3oWD+nZXAEILIRlH4w15UasxtL8mHQPEdOVINnX1qbzM5qhBg==
X-Received: by 2002:a5d:47a8:0:b0:21d:b690:9273 with SMTP id 8-20020a5d47a8000000b0021db6909273mr1533161wrb.242.1659083160910;
        Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] apply docs: de-duplicate configuration sections
Date:   Fri, 29 Jul 2022 10:25:50 +0200
Message-Id: <patch-v2-4.9-b9750ae43e1-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The wording is not identical to Documentation/config/apply.txt, but
that version is better.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-apply.txt | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b6d77f42068..1d478cbe9b5 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -263,13 +263,9 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
 
-apply.ignoreWhitespace::
-	Set to 'change' if you want changes in whitespace to be ignored by default.
-	Set to one of: no, none, never, false if you want changes in
-	whitespace to be significant.
-apply.whitespace::
-	When no `--whitespace` flag is given from the command
-	line, this configuration item is used as the default.
+include::includes/cmd-config-section-all.txt[]
+
+include::config/apply.txt[]
 
 SUBMODULES
 ----------
-- 
2.37.1.1196.g8af3636bc64

