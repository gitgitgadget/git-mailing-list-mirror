Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EF5C433EF
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 06:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiDXG3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 02:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiDXG3S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 02:29:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9815834
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:26:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso230139wms.2
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wepOkOVeJ58wOXnp+KYuWepMWiQtZFeMF+Oo9oKMkUI=;
        b=R09J/aI4DEKecLAO6vioGRs7zQqsHh0WZVHxSVhsHISVdUbrBa1G2dipBezVwLI9bh
         JPLu7gBCi2XOLicBWWUZyKVGe2x1ZcMdCkYsBq2z866FQVr+GRoLBWenA/m1boUStE39
         DLk1+FcOPlZmhkccwkzY8xlrQtxZxoUYnfMntEXtzRMC32HTcj4PZkq7d7vl5zFXJtEl
         BEMC9qyMN1bS12m8MJuRp3i5uKZMjOlUGabg7ah4r+zqE7H89wLsjgVseCNHWpPlhGWM
         SWN1+hxKRdAt3COswY6/x6+Lf9XyejV6EWLHsTfRKLAgK1pFMXYuluBYcsG7M9OJnUpb
         Xwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wepOkOVeJ58wOXnp+KYuWepMWiQtZFeMF+Oo9oKMkUI=;
        b=6zkP+eakP9BQIgIp61bF8DGwXctUg7WsDI6/J2wgWm/F7N/IOroU7M7NCW1ViJyZCy
         IxoZkULKbaW2wAi+EBDV0X7WdSG6wE7H3oIypIpdIzDQ9jfUPRQiwE8rp9SvJ1lDHM07
         dxdrE2NnyKDPox8iZ3dmSsKxhLH09eSiXZLA3N5n2u/eYqVLd7a1D2hF+aTk7KdLTpfh
         XEC/BEOtugrxyczexjy3bcfIOuevGADsQqM40br4F3HkKhhHU6HRbpyj5t5xhumtwASm
         nddBUDswo8tVKOgU+blJVUhMbYPfDLYYdA5cU0LVlsUldggZDcdqsTAvg2bSuqi5AntN
         xGvw==
X-Gm-Message-State: AOAM533JuRm0TJarwJpnTVssA08M9lAoOSkrfCU3hVbRBymMRHRtD1kl
        FpuIpXciFHsQ0LLe/kqzJBXFiivC3mA=
X-Google-Smtp-Source: ABdhPJylPoKneMeU9bpuAE2ksZlNBxwurdJVPBxqlxY5spi7xZ0ZLn5/LVYQoy477LbnJPmQkj4bNg==
X-Received: by 2002:a05:600c:3d88:b0:391:7aa1:792b with SMTP id bi8-20020a05600c3d8800b003917aa1792bmr20726215wmb.8.1650781576392;
        Sat, 23 Apr 2022 23:26:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b00393eb0d01f7sm239916wmq.23.2022.04.23.23.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:26:15 -0700 (PDT)
Message-Id: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Apr 2022 06:26:15 +0000
Subject: [PATCH] submodule--helper: fix initialization of
 warn_if_uninitialized
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

This field is supposed to be off by default, and it is only enabled when
running `git submodule update <path>`, and path is not initialized.

Commit c9911c9358 changed it to enabled by default. This affects for
example git checkout, which displays the following warning for each
uninitialized submodule:

Submodule path 'sub' not initialized
Maybe you want to use 'update --init'?

Amends c9911c9358e611390e2444f718c73900d17d3d60.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    submodule--helper: fix initialization of warn_if_uninitialized
    
    This field is supposed to be off by default, and it is only enabled when
    running git submodule update <path>, and path is not initialized.
    
    Commit c9911c9358 changed it to enabled by default. This affects for
    example git checkout, which displays the following warning for each
    uninitialized submodule:
    
    Submodule path 'sub' not initialized
    Maybe you want to use 'update --init'?
    
    
    Amends c9911c9358e611390e2444f718c73900d17d3d60.
    
    Signed-off-by: Orgad Shaneh orgads@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1258%2Forgads%2Fsub-no-warn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1258/orgads/sub-no-warn-v1
Pull-Request: https://github.com/git/git/pull/1258

 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c87ef9364f..b28112e3040 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2026,7 +2026,7 @@ struct update_data {
 	.references = STRING_LIST_INIT_DUP, \
 	.single_branch = -1, \
 	.max_jobs = 1, \
-	.warn_if_uninitialized = 1, \
+	.warn_if_uninitialized = 0, \
 }
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,

base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
-- 
gitgitgadget
