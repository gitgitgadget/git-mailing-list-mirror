Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC311C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiCYRda (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiCYRd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:33:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993E11A998
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:31:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so7234031wra.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7Koa5XJBp92rHbd6oKPPKoQznvRkGZdEugZ8XqERPI=;
        b=KEOWHUDUriYphbTxZJy6O80sez/aCt/GoVQDzyrXFpFsFTZkTZ+A0+F/D2guc+RsOv
         iSg5tC5jC6tL4s0VOxu2MQJknP7OmkMI48Iirlh/adT5AfrDLZgFq6Kq76uWXa1bnYXG
         4xIdhwWMa3chxEJEAzDontjehrxfCGLejnyiDiox00yaqVaMa5Gld4mtrh3ttP18wuhf
         yvgxdhUISIMJPOTif5HKEsS25pNKSzXLnXe6pOdfiYiBjDmv4zhl54KHIUyZI2VbkFUT
         WVXhGJtGNpyfXqMy/rOxI1MNQicr7/2k3tEyv2+vcg79bKhCeBwSQKa0MrrQCMt/XOIE
         63cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7Koa5XJBp92rHbd6oKPPKoQznvRkGZdEugZ8XqERPI=;
        b=rvJa9r9qOjB06Y+aHNhGtAPZVhO+RlfJrH72ry9lemnhnSzVGLbGUHEsNS17ZVQEWc
         co/fOqZ16F0Y1zezPGk2U7/hrZlBeIYhTkQTOsSCDpBOSQkRywzIi59o8HQIqUQnFflH
         FxpZaxC4cxwi6ON1vHuvwx10AVQII2SCw49iKZ+9ypzgNNnjL2VP3VYu2jk/U41wVXZt
         f8trlVL0iXXQRRA0YrNXAamxzbUH8jOECDYhSX0rVCT8c2Y1WHjL0S6HQUkiZZnLRKD/
         Bk1ZPMewgcla0bIjg1tXt8PvovqZwroPLemo9hK/X9LF4WfHhKHocUueUGDq/Psc1ePe
         /+ig==
X-Gm-Message-State: AOAM532EAq4Ds4OsMY9mN4Z+2rsHWaQYqoPLj8K0WPlu5EKWH50VizIf
        7pV5+/060j2ObRVOwvh139tCUKAM0aZKjw==
X-Google-Smtp-Source: ABdhPJwyu8TjM+Fw1lJKk+uHE6ls3nQ003kDnlPsquljWzj6pB9JB6a2FcgiEAdPZTUypk6Bhu8VxQ==
X-Received: by 2002:adf:d1c2:0:b0:205:7f2f:5043 with SMTP id b2-20020adfd1c2000000b002057f2f5043mr10172173wrd.238.1648228786834;
        Fri, 25 Mar 2022 10:19:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/27] revisions API: have release_revisions() release "commits"
Date:   Fri, 25 Mar 2022 18:18:40 +0100
Message-Id: <patch-v3-16.27-0a5662a9f67-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"commits" in the "struct rev_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 895bba9ae57..84b47552a3e 100644
--- a/revision.c
+++ b/revision.c
@@ -2933,6 +2933,7 @@ static void release_revisions_commit_list(struct rev_info *revs)
 
 void release_revisions(struct rev_info *revs)
 {
+	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
 }
 
-- 
2.35.1.1509.ge4eeb5bd39e

