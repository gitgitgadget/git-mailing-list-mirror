Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6EBC433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiEYKFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbiEYKEw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2456B6E8ED
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e2so17781637wrc.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwcDN2nNxoVnG4m23bb8Qfy2kECmBICM1NIuw/Hu06w=;
        b=aY4BQAAzHYE174OgOuwWfbJfbWqTp5Oun+gHjyfXWmDTCX+KlRhKfQ7rOVsVouUwhk
         ey1HKhf974Eine3kUHMq0+muxz+QZuyog2LPyer7jmYx6lu4F8wEWtB7F04GlmIXe14O
         E9JWXR75wi1OAUPoW/kViHqSVWzFhUcTku0F9bSWbL8JrI6l1IDUkyiw3RVQiywB3O9j
         fztL4ijIUeT0TCPItOTjDc3LTggW82jYbMwXm4WRF3YgYc5pZdkM9RvR3aQY1uZRzm52
         ZiE21hmBMCdoL6iWoszSLBqqjra1bdInZPMJLJU1TDqlshTUQFfIngOHpCaqHFibLnzQ
         bKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwcDN2nNxoVnG4m23bb8Qfy2kECmBICM1NIuw/Hu06w=;
        b=0d7OMpeNVus18F6RWhQpvQsMO2daegjsb3q8sv7cgQvL01p1G8u9Qd6cf96KMhAw7R
         cu2yRz8NzaejeRWu+63/IBXiW4gTCGp6BYLUQ35/9gRUm6Dy7BoRUJ/Kw2D/n6h4pfiS
         0Odwp9PU5uZWEsuRoZCuw3hcUG/G+IXnPfWs33Dmiu/3VhTBuMif3S8y1ActLIKUsznN
         CrNPnrdMgLREjvZkLbuO0sYPwqLb7OtoAH3GD1OX7DIBpqnKI3aWSAdXa5JRx5lF3ThA
         EBooqWBi/njt9yojqIHDGzR4Mmlr7LOWxeP/lfFDTJaQrOfJxocIpmRl7I/p6GcEXFW/
         2XQg==
X-Gm-Message-State: AOAM531j9ZaYpHbALhWhG4WJNhHwsXy2hQrOZ8T7QNqcpZEI0KxT/Sqe
        2Hl6tWTpHDEcdY1d+hMiKLjpE3D8QMqaoQ==
X-Google-Smtp-Source: ABdhPJzx+HyhYIWUUxSu/XXVXp5HBSpeUil53gwyaWjJRHSMRdHFpbf12JL+9nLutFOwG1HlQQDpDQ==
X-Received: by 2002:a5d:678c:0:b0:20e:699d:1877 with SMTP id v12-20020a5d678c000000b0020e699d1877mr25549754wru.490.1653473089316;
        Wed, 25 May 2022 03:04:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 07/29] CI: don't have "git grep" invoke a pager in tree content check
Date:   Wed, 25 May 2022 12:03:46 +0200
Message-Id: <patch-v6-07.29-d0780ab4a96-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
directional formatting, 2021-11-04).

This didn't matter for the GitHub CI, but does when running the check
locally. A subsequent commit will start invoking it via a new check
from the top-level Makefile, and without this we'd visibly spawn a
pager when doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141aa..de8e6e486f0 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -23,5 +23,5 @@
 # U+2066..U+2069: LRI, RLI, FSI and PDI
 regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
 
-! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+! LC_CTYPE=C git -P grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
 	-- ':(exclude,attr:binary)' ':(exclude)*.po'
-- 
2.36.1.1045.gf356b5617dd

