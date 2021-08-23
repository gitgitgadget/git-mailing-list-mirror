Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CCCC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA456126A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbhHWNI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbhHWNI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:08:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA31C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:07:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so26213373wrn.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABMnPUr50zuLwRK1Xx6T6XxXfA/buxrz0LNC0QRd0SA=;
        b=k0yx1rbgTayLXg+ByTu0SV3NWFHXvALcsFbgsnJZZNgec4QoDXEdgx23vpjqPcjwjp
         7LLEPUIHMSXHQ3kBGH/1eCU5wRyzF3dUSgxPmNbRSWQpq8RwxR4pBPJ5p2dbJuTVAyJ9
         GV8r8AWhM3djQIrUT/hmEQ8cWbU9W2Dci8wev36y/fjzGPI2/yxRawP9z8uAINZKBsO0
         942gNqN3GQGlQe+QoG+BUQGM9MZHLhfupR9dWTuB+hmCkZ/qZP6sdONa7N1MSEs48xBL
         Vy5mOXQ3WGaKo1M7h350NSA8tGUU4QKDCFQWytOQD8m1ArzpHubXwe4vLIxMf+aU7kP5
         8vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABMnPUr50zuLwRK1Xx6T6XxXfA/buxrz0LNC0QRd0SA=;
        b=mFr+MWEnZtBWaQN9OfcbrlbhjtVGdfMK8QZ8FoqwDunNbdlLY6955tVPUCzjcLC68l
         BvFumGf53yhf76naAnHgcLfXNlNAgwCylX4HwF08VytcckpdrscDEcxTFduzQEQBvC6F
         4B8CRGzkknX0svxgwRTjPkP8tbLRCS3dgivPNuPhIhVtmhweQ+rx9lrI9T7aajVX/W1X
         7/4mFEfUUX7itvxeJ+XXH7F2OPwg5P7u4zJImoPnw82VBQ0dMA7VOuL9ybvKLduto5sG
         dr5i5s428eGkWlh4uZmBoWGay4AYwhPnhS9y3prN+479rJPE+rQAUih/bUCzZdAgkWkS
         Xc7w==
X-Gm-Message-State: AOAM530u5eCXanJ8tLMr0datPoIqj9o8fE9iKFZoceWlMrOg6VclD1ky
        iOBAyZAnrBuKv/Jp2bx/+prn3yXzJ6jaencE
X-Google-Smtp-Source: ABdhPJzGS2x+Y8WLD/nR4pGpc6caUjdUCQDbfJ/GK3mw/cOkRyS3VlMVcDnCTpnzUVNCu0ChhOKRDA==
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr13549401wro.405.1629724062877;
        Mon, 23 Aug 2021 06:07:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n13sm13035687wmc.18.2021.08.23.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:07:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] rebase: emit one "fatal" in "fatal: fatal: <error>"
Date:   Mon, 23 Aug 2021 15:07:41 +0200
Message-Id: <patch-1.1-54eb94f6e7a-20210823T130724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The die() routine adds a "fatal: " prefix, there is no reason to add
another one. Fixes code added in e65123a71d0 (builtin rebase: support
`git rebase <upstream> <switch-to>`, 2018-09-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 33e09619005..66a0a0f0d03 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1918,7 +1918,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 						   &options.orig_head))
 			options.head_name = NULL;
 		else
-			die(_("fatal: no such branch/commit '%s'"),
+			die(_("no such branch/commit '%s'"),
 			    branch_name);
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
-- 
2.33.0.662.gbc81f8cbdca

