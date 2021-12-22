Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B49C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhLVD7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhLVD7v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE1C061401
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so2159995wrb.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8e8skhwx5TBhXXvs47KPPydWQNEhj5T/BSaFUM+zPwA=;
        b=jp1bGL/fR0lPeSvQSix7ZH9mBrm0/jawXd7HUPVlV8IgWzGFc+TEPxczAsDxarrlCC
         bQocURxQMJIaFNJtBPiJbYGEqGv/7uj3wn1OhTgRRYOrC7U/BEcF5aw9UyH+88KYcPmM
         VAinwX3bDfN+wZr30LO2S0kh0FZeBhzh6UtD8AFrO+jFNwPrHSY07iViNMpn5VzoyOzD
         9rX5nOr+0dvb/ONCqXVPKEIA7iZYv0Z4xmXmtE3f7k28EY69qYjgW6Nd3iii3jEuOBNb
         OWf/69F/ilyx5UoOdAeZIfbsRccsFcmMSTGvTUzWd4Z3/nzDqtz6E2GiHJbSewxbG/XD
         VhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e8skhwx5TBhXXvs47KPPydWQNEhj5T/BSaFUM+zPwA=;
        b=KSMwKQTu6g7PrTml/dntqyEEW0e3bI/CRuYlAxREfEbeMwu+mjQlHA1qrx5xPHKrZm
         c+KxBNhT5/g/7CpvJPhnxcr3aW2hy16WRtirRieHsdypq6CS1t4YmF45tET2K9kgjgVh
         CrFX5/EY/SIg0yPT3RYk77Kb9Z54RoYstoejGQKX1DXRPs1cMuTo7CclMHBq9inPkRSg
         MwVg1W9DdUaAJOoHzzFxVxHOIUcSE3wagELvLRFb9KOEc+sJ/EIyFjh8+GXjDBBhOpnq
         zrkB5KhndBWKonwHHQrToxFSUE2QTt/o5cqESz0tI0JP5BrzL8bnRikAqTeKNNzCYar9
         JScw==
X-Gm-Message-State: AOAM531zpyVA7Z3IVMXw2m011ZRux/KLDsEN4ZpGmB5Tc8/UmC/EU2Ry
        Y37bbq/6xewJ5KfMvW0sUUf6H6eGrFKfgQ==
X-Google-Smtp-Source: ABdhPJyEGogebxEykRPSNwVB4YOALTQzA5yLCqzlOENhj8SXckC2FVuESvv7AlOcnHXHaw/2M3pxMg==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr679294wrp.691.1640145589271;
        Tue, 21 Dec 2021 19:59:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/17] gc: use hook library for pre-auto-gc hook
Date:   Wed, 22 Dec 2021 04:59:29 +0100
Message-Id: <patch-v6-03.17-a4cca074bcb-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-auto-gc hook away from run-command.h to and over to the
new hook.h library. This uses the new run_hooks() wrapper.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcef6a4c8da..4bbc58aae5b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -394,7 +395,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc"))
 		return 0;
 	return 1;
 }
-- 
2.34.1.1146.gb52885e7c44

