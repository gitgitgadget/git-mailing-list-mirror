Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC4C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 17:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbiBSRKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 12:10:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiBSRKX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 12:10:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2A123421
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:10:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x5so14847322wrg.13
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=5M9pSTWoWjk1wygGP+We676ZZGqGJQOnjsZV8bTQHQk=;
        b=dtjX31c1bXJq8PN1Va2yCNziUHjhVCg7uKWYE8oA1tG17gOtGmCN2zd7qNuffMST2p
         KpHgc/1fKOJgMgciQBqjgv8SsKDHG0EdJuPT1Cw6bL+m5WcBH0oO3dgZmWZCiRWSK29r
         zoWhlxEeu9S2gmaGjgY9ZMVSbs8Bf38M38J3D7GvxAcNSgFLnVHll+fY+PluzRbwjg3O
         gI8vEm0/wDXs183vwv604t81PZzMHr6YHVDVTtk3rYcuJlLpkkgdnJZ5CHogPLnZ55E0
         k+KBz+IZ+6wAqLLDUdxa4h9v8/zwe/1rhwbOzLLHDa/ZpgdpidQjYkFJfcb3V0DtHfpL
         1kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5M9pSTWoWjk1wygGP+We676ZZGqGJQOnjsZV8bTQHQk=;
        b=szb6W72wHBckPrZ+11c1TupEMafKjDk83pvJNel32xO2+Nz42Smn7bXAfwHiBUDlKg
         kSru7iGiou0urzukbVy734ftqqCAF1tlCpbUsF7OpcCzx+sU0t21XTBiLnkJWQEZnufY
         bxKf5qlcxefVH/9uWfSdpUIKDniCfHRUoPKzoh5MXx638u1U+tNGpGujE2CwmrYLIWrI
         J6Z3ie5mrC/FJcW+H0e9SSyWop1D7FHwEQSYshCv1P/E4zz0bdfeFDWNqNUSAda+kWcV
         8+MLTwhHnKvBa2o7Ldnsi0fu8iBI6mVHjydhiGKflwcOYtGeGjdxE2t4zi5nWkCeo9RT
         KXVQ==
X-Gm-Message-State: AOAM532U8Jw9JzmLowtUjs70OaYpQ/BtB9HMoMF2uE0DFOYWrXZje5js
        JdOBG/qv508TWSu8Y+1J3tqvrE7Mvjw=
X-Google-Smtp-Source: ABdhPJyvG1ZnMEemXpEoacMXkyGKAovOmzuwKj70IIdyTlHoz5sCGRy+qZ/P23VKMz3Ew8v9dpxK7w==
X-Received: by 2002:a5d:6482:0:b0:1e8:330e:e442 with SMTP id o2-20020a5d6482000000b001e8330ee442mr10071744wri.107.1645290603031;
        Sat, 19 Feb 2022 09:10:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q76sm2989085wme.1.2022.02.19.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 09:10:02 -0800 (PST)
Message-Id: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 17:09:58 +0000
Subject: [PATCH 0/2] Fix a couple small leaks in merge-ort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Off-list, Ævar reported a few small leaks in merge-ort to me that I missed
previously. Here's a couple fixes.

Elijah Newren (2):
  merge-ort: fix small memory leak in detect_and_process_renames()
  merge-ort: fix small memory leak in unique_path()

 merge-ort.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)


base-commit: e2ac9141e64e2cd3e690d1b5fc848949827c09b4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1152%2Fnewren%2Fmerge-ort-leak-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1152/newren/merge-ort-leak-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1152
-- 
gitgitgadget
