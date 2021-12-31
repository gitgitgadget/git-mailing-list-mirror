Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77668C433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhLaFPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLaFPG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:15:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B3C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:15:05 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l4so16787579wmq.3
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tufa0Sn+FeBVfuVB+0KCKNe7HHVgONAHZMYyTjzP7Ls=;
        b=PIFYUmu+yjqirCTHiH/shHOoP0y9ARUz+O0ZhE3t8lCu9swSAwKpeG6suA36oCLwDP
         kQI7G/rSDgnJbWEJDKLcKxYZJKMc5BfQLYvUtosqT0HCNGp4+w6+ZL6fYtzXR6ZStY/M
         DLrzdjyJbArfkyTUg6HaRdl2lwsd9HJ3KzdjdkHDrPk2Bq9YtD8YcUPCs8QmmBl1eYAi
         QAU/A3sm98xYh85tCmwCLFH7ZqeBeM5HO7HyL/IrJQPkjONdz9a8z0aDYWQ6vXTXr+P/
         4wu1HwBsQuqHoCUPs2ev7nes8eyvl81SecAfIsa8WOQFV110mmqm+gb8E7MphUaKgXZv
         ekiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tufa0Sn+FeBVfuVB+0KCKNe7HHVgONAHZMYyTjzP7Ls=;
        b=M0xe5HyjvPDPyW+IZT2xc3OrhfgTtNhrfrVwuDY6Ww1yZsW3ZC4T4t0IZIkADNnLJ4
         cYy/vJc/z7nrIWBWCboF0pu5lCohIEQ6CAAhbalfJBQPGbNGrI/EltAJ3+XVgQT8WYc4
         h0ZvkoHHibo3ku6WQZ6s/44MuWqE7qcxyUupEmCV+qRBYMs9nvVtbjRGn71nEobA3I6R
         bZBO2/qc4pJWD30750Mt8TXiAzcgxHcv+CM3rpWyetn+U8HCFhJGPN7LHBYLG3uqHbkR
         Yu8/shPKbiUIGKq4Vs8HLCRXPD43aYs5DXFgbQySgNMyBmgb3I+ptga37Fl4CyJjM9ru
         U1EQ==
X-Gm-Message-State: AOAM530IPt03ANDtihxkSVlqfMWAgGNVMAAzX0Q59vlQQZkF2PYgeWEO
        GiJd/17W0YaNc77XkjAAp7et+fX3M50=
X-Google-Smtp-Source: ABdhPJzKTtMLcgg03dHqynrn+x6VvSwfvO+NVVvNKM5fB3zjRMnThermreL24kND6pk0FvSepn6AVA==
X-Received: by 2002:a7b:c253:: with SMTP id b19mr13605690wmj.89.1640927703950;
        Thu, 30 Dec 2021 21:15:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm26352905wri.67.2021.12.30.21.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:15:03 -0800 (PST)
Message-Id: <pull.1177.git.git.1640927702745.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:15:02 +0000
Subject: [PATCH] t4126: this test does not pass SANITIZE_LEAK; quit claiming
 it does
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t4126: this test does not pass SANITIZE_LEAK; quit claiming it does
    
    My builds in several different topics keep running into this, and I'm
    sure it's a false positive -- I didn't change anything affecting this
    test. I've just been ignoring it and submitting anyway, and I suspect
    others are too.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1177%2Fnewren%2Ft4126-apply-empty-is-not-leak-free-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1177/newren/t4126-apply-empty-is-not-leak-free-v1
Pull-Request: https://github.com/git/git/pull/1177

 t/t4126-apply-empty.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 82284d2f45d..ebbac79f20e 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -3,7 +3,6 @@
 test_description='apply empty'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '

base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
-- 
gitgitgadget
