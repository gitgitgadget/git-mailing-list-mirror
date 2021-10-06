Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58077C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4185361130
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhJFJwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhJFJwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D8C061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z20so7469430edc.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkRng6rwKUSc6u+WMn9jRbAXM+wTzlJC9eOakFrs2ys=;
        b=KxZwVOj3jK00ZzK+n2E9mZs6n7pUOezM51EmpM2R16CTC7wz1GbWEKS9Ke3ojGQSM7
         90Fv7kC4WMMlwMvk91R5NpmKTiy7Dnfxvimizt4vFPiLSlJbyobhblHztHZE3hggrO7F
         JLE1M0POcpjyGIushyi0NPZLzxc2xdd6Yu+luw+0n9R6AIe755QW503v0eIrfaKFX6bd
         C7xWW5PRwOvDHpzFQ5nWeX9fFkXL9zUMraaQkZNxuvpytfS1yU61O6w3LikoCsc0+I/x
         LE+u3dLA1jcJWSVhX49LoVRac7kbS07bjY5s3KXfmT51PHoK90pMq3/lXaH8RAQtO/gs
         CP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkRng6rwKUSc6u+WMn9jRbAXM+wTzlJC9eOakFrs2ys=;
        b=RZnwCXLkGe3+wYaD4Ngx7Abev7wBZW/OtkUDJtrOxquOmDW2hmO1bd3RPoRgpIUAbo
         nGi5eHlhS9lRjBfnMdBWiSwkaM21YJ3ZkcuJ5FZqJy8pnDyFG+utGpfivCLRZAWL+Fwj
         Tl9MLA/NSxhsEOEHsez9VrMzChO91prHXx8zrMhRY6uo2tqRg9fjpzJajhTnpbPOzn+S
         yZdHJFXEu7KNm8SJ8kiDwrj2xykCdQyo55JHDrvLNZkbOr/LjDIHGdgkE6bFSJzANkE8
         Tqt39nR0DVpor9P/uMKVlbQHUaczQx/GklggCwxBFqi3hArrzxaIco0soo9XTXIegJGi
         vfrw==
X-Gm-Message-State: AOAM532o29BPrHR60IZfl2PSyydzyxyBneZxj2PbNPevUjFv+CL8cMJD
        K7D88PTzTQ9Ua9XhW7bDgK1rYm1jOMSJig==
X-Google-Smtp-Source: ABdhPJwBFMmw5miMQXcU9KP0ixWkiWOG7V4MqRMy2NPt1NmGZSPXs65im6gAjglaKJGmmQjKLwYrSQ==
X-Received: by 2002:a05:6402:3487:: with SMTP id v7mr33560567edc.191.1633513841500;
        Wed, 06 Oct 2021 02:50:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] leak tests: mark t0000-init.sh as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:30 +0200
Message-Id: <patch-03.10-3a7dd917d9f-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark "t000-init.sh" as passing when git is compiled with SANITIZE=leak.

It'll now be whitelisted as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0001-init.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df544bb321f..7603ad2f82b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -2,6 +2,7 @@
 
 test_description='git init'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
-- 
2.33.0.1441.gbbcdb4c3c66

