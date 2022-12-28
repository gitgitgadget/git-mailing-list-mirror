Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D36C3DA7A
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiL1SAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiL1SA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E83167C0
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so11761135wms.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdlEcxOUw1jyf5oaBIycdEUx/2wXFAHa8mBn0HR/ovk=;
        b=pSeA3ubh5Hq+4UU/bydqGaoEMvHvuSb/hk0Y0CeMKlDJZLbcT2O9MrBR6ETXWmCWHm
         zIFad5qPHYvE1of29gjl1izAFPX9tH7oZMdNdXZRYOtra01ChQcyczkuY88sFdklITc+
         fB3sYBPvFRPaQyciRIj7wwh7bph11gX8aRn0lwYSqYaKUGWQtByT6UE1OoGGZ8u2EJec
         Nk7Rmd8gRBAfx9dW8gc1vlLjfgFrdDPvWkWAQhGqwrhfa3Dy/ClhN8K0hyXfkkOLKl49
         RQHCKTA6YvpGwJFpOfc1yy3FZn4Egd1MuHXaeHUWencJAvWgF8veh0JSvMn4EUHLxFsF
         z1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdlEcxOUw1jyf5oaBIycdEUx/2wXFAHa8mBn0HR/ovk=;
        b=gUec8eZD9qXJGkudR4QHMfxSAZ/60RiQ4nKaLAtRqyHwBNRzqWy8Vt4jV7ywLnkopx
         TtFD/CqRBZ0zL479fSSukBNON3+pwhAtiuWYKN2nXzgSLw+C8dfg1rGqN1ueqJE8jYkw
         MCVSipFK8dMJbmGqPYbJTtB1snLBLXhKCJAl4VUhov8cob6MkmA3UlirrTyaI7vuLm99
         n122p6WW1AQ7co9K9DGQTjrkVYYSAfl2UZcfe2jEymXZG/qUXdPc4bnOL4cf2POaLxWg
         Au6OKCnktxQ6YFOGbbGxvm8LJRRVNkW6NMIyHzSI9Xqanw5MAVVSIIMoe5A+udH24Mky
         8o7A==
X-Gm-Message-State: AFqh2kqz8aQeRCReZQTlZF4BfttZj8TpzN1CMKJaaHJ3ystzVfPI1pyV
        uitYE/yQ1I0vX5nDIvjVsm4B9YsqQeBakQ==
X-Google-Smtp-Source: AMrXdXsZpxQgkUozviFtrrUOyDGKG9fn1WRHSCfuCxO1UJccI9M6lYhpYwwj+gqAKGMHUEIQ9NwvgA==
X-Received: by 2002:a05:600c:4e48:b0:3cf:69f4:bfd4 with SMTP id e8-20020a05600c4e4800b003cf69f4bfd4mr18799616wmq.7.1672250426991;
        Wed, 28 Dec 2022 10:00:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/20] t6021: mark as passing with SANITIZE=leak
Date:   Wed, 28 Dec 2022 19:00:01 +0100
Message-Id: <patch-01.20-84393ca3139-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test was recently added in 8c1bc2a71a7 (revision: add new
parameter to exclude hidden refs, 2022-11-17), but wasn't marked as
passing with "SANITIZE=leak".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6021-rev-list-exclude-hidden.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-hidden.sh
index 32b2b094138..11c50b7c0dd 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -2,6 +2,7 @@
 
 test_description='git rev-list --exclude-hidden test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.39.0.1153.gb0033028ca9

