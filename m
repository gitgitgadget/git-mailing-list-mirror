Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CA8C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 08:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDNIOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDNIOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 04:14:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DED2738
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:13:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h8so2145409ljf.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681460036; x=1684052036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2unZZ0tkwjTB6Nef/MJvYMRgoZQUGroeYnEdH+E8r0=;
        b=WkTsHgs9h1euc5/xe8IIHi/5TdGIgHMyyoIAm+3qPhJgejBMIMDlPvf9OoIpZwj/jY
         8ZrAqPvPVkxJxVfp53FUQGWe9bXfZS4AvLNs2gpJX2gFbApqt1JerQR6GmTfPSnpeJ6s
         bFR/g2FUR6GsyhVmEp7U/VPXRTlLX7rWoxRXV+PxP0Dex+Ol7pcdtxf9ELQ82WCmlw+X
         R6HanDwFKrcES045DbFeHehi+zm4dXPv03ISvhU5GxjV1IN6OIfLIOqmIfriAyGEnWyE
         JhqaDESJerxAhloaT9T9NuORe9TWcEeS8dvyRGKKsY6eKm/Y9gIPybFGr0nH/EMWNXzp
         BTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460036; x=1684052036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2unZZ0tkwjTB6Nef/MJvYMRgoZQUGroeYnEdH+E8r0=;
        b=Ge1gV3OizNBwnIAwldsemk+QTWwdWWivG4orXpvAeUV6lKCGs3dOshRQCn/pGuZ/Rb
         il4HLBpsKm6CFpt26jsKZ5zL3GgpFeO9nZf24cgZo9VuE0N8Dan6iU0wxsIfPmZitD13
         3soGBUtG+Ap9gczSXLcJwBx/jYw2WwWHooV13MReztJYflxKT/5lBakvMBE6X59/lb7B
         0k9ey9ei2cCaQiq6McbIR6sfdNy0u1FEWIio7Sy5bioXL2muDda3P4IqE8J1hbrHrPIU
         Hwv+cVa7eSizlBHcLagywRHcZYK9tWzqNVIVN1DMBS9S/JKAQ2j7vniBmJTSTGcI77SU
         usAQ==
X-Gm-Message-State: AAQBX9c1ouRUTY3w4P0kcisEJAV0l3tSOS78rVCMqbNEmtbBG7c8uTQQ
        dEzTu+iB1uKeyhA3U9AgIgn7/WGyVkT34i1ezkw=
X-Google-Smtp-Source: AKy350Y/XQeOC46BLU/0pubAzRchZoDatNjdbBSsDc3zCvX/+FDe642RS5McDifhJHChMPtvokIUSw==
X-Received: by 2002:a2e:b0db:0:b0:29f:390:6647 with SMTP id g27-20020a2eb0db000000b0029f03906647mr1773862ljl.18.1681460036597;
        Fri, 14 Apr 2023 01:13:56 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e3309000000b002a76f63a657sm657506ljc.105.2023.04.14.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 01:13:56 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 1/2] t1300: drop duplicate test
Date:   Fri, 14 Apr 2023 10:13:51 +0200
Message-Id: <20230414081352.810296-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414081352.810296-1-rybak.a.v@gmail.com>
References: <7a5de047-3535-3b87-f023-43c400d57131@gmail.com>
 <20230414081352.810296-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two almost identical tests called 'git config ignores pairs
with zero count' in file t1300-config.sh.  Drop the first of these and
keep the one that contains more assertions.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2575279ab8..696dca17c6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1458,13 +1458,6 @@ test_expect_success 'git config ignores pairs without count' '
 	test_must_be_empty error
 '
 
-test_expect_success 'git config ignores pairs with zero count' '
-	test_must_fail env \
-		GIT_CONFIG_COUNT=0 \
-		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one
-'
-
 test_expect_success 'git config ignores pairs exceeding count' '
 	GIT_CONFIG_COUNT=1 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-- 
2.40.0

