Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F217FA3742
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 03:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJ2DCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJ2DCV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 23:02:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15169CFD
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q9so17224187ejd.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9/1OrbZ4WCY4H+KrrL6nMAEq06U3+K5PFgT3MmZnW8=;
        b=hqAeBsvMzUlos3h1bxbQpHzIrxYs8Tb55J/tqhUn3mYS+4Mxi9SsVIFztvb7wuuBR7
         Cd+ytIGcXTa5X9MkmfLrbVROQSGLIoAaPvQeuJqB0VYzv+GhTv7qDzViDZFt7CD7jpWy
         LpifnYZd6//d6yg66YT0v9L5svzxTKIu9m/wq9sat3ty6wrT/ZCtivrsItEvudGoipCx
         /uSWLSDyHStMSc2dwkeJACm0tKK0+1JXofuLqI9ux2wvYevLyPUMhpalmjUoCpRwDe2h
         gb7N64fg9XcpV+7hj31wo5WqoilWcqnGMLMXzOpcNjsmkk5fyCl7+Y1CSd9U9nL95464
         Oydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9/1OrbZ4WCY4H+KrrL6nMAEq06U3+K5PFgT3MmZnW8=;
        b=wh9yobcyp1wg7HQE7gGiUv0zJoklnkHT8ZpRqIr/Jo4RVZLvvcaCrHteGifjuPIS3p
         ajxq6Fp+yjSf5O7ygeYq3P/ZmnGkvjp5sKaUS+evJUNqNcaGOIbfIvYtwh01ktuvdjJl
         0mKEc0Ood9/nwL9PsCz5YdBY/urtL/Bd9qLne/Ruws/O2grc0wQQYc0pQG2a4EfjcIPH
         V0/A8X+GyHP01qSK1D0LwaTwGnezDoGBZ+n9+EVvorUeHjOvdOFBqZdSKXkX8147VEws
         bzKYZV19gkZ0S7JEE0deys52TL9avMWcEndj4tfIhO/ljpJLJlTL1b9+5KnuzO8/4Sed
         BhaA==
X-Gm-Message-State: ACrzQf3U97T3f7vaVrzqo8Hi0apSsS/7Tz3e7+7Rz6aJuLO90pc5uTMB
        YfWSZCpNWHxPweqdqqZS6UomAtfH3fM=
X-Google-Smtp-Source: AMsMyM4bQnND7Z4vnh7jNNijyvGaY2+dUhMfT4WG3iXOweWGvChypF9xEkbRqbip2CkzsYospayXNA==
X-Received: by 2002:a17:907:9713:b0:78d:8e23:892c with SMTP id jg19-20020a170907971300b0078d8e23892cmr2126983ejc.449.1667012475108;
        Fri, 28 Oct 2022 20:01:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dy14-20020a05640231ee00b00461621cae1fsm195393edb.16.2022.10.28.20.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:01:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] hook tests: fix redirection logic error in 96e7225b310
Date:   Sat, 29 Oct 2022 04:59:45 +0200
Message-Id: <patch-1.3-1ba41a5842c-20221029T025520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests added in 96e7225b310 (hook: add 'run' subcommand,
2021-12-22) were redirecting to "actual" both in the body of the hook
itself and in the testing code below.

The net result was that the "2>>actual" redirection later in the test
wasn't doing anything. Let's have those redirection do what it looks
like they're doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1800-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 43fcb7c0bfc..2ef3579fa7c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -95,7 +95,7 @@ test_expect_success 'git hook run -- out-of-repo runs excluded' '
 test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 	mkdir my-hooks &&
 	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1 >>actual
+	echo Hook ran $1
 	EOF
 
 	cat >expect <<-\EOF &&
-- 
2.38.0.1280.g8136eb6fab2

