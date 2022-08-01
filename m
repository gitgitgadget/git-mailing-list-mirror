Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA832C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiHAVPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAVPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8917E09
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h205-20020a1c21d6000000b003a34ac64bdfso4910411wmh.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=y0ikwqI4+bZ5vxzFdi1ve/0YattRRjl9I9Sy/ybdMwY=;
        b=PijoQjSH1CFDHQwoS6oWQ5Zxyi7fskc8O61zKL6/UBeMhyuP188ny3dRd6xanc8xVY
         iGB/DQVFLxBXY03q8wbrOux5B/k5FPb5J71oz2st7cUmrZGSrJdgcNe+0lpaBaHXAY8u
         +MuYqTUqTCuKW+M+lrHvkd9DPpo7zPrzL6z81CYUudpFdtMoNaVU7LjgIC04QwmeCkZL
         SaCtryEMQlmvmxnOQF1xP416A2IniZX+5ywu8xfVXNjzAeOKzNL6UpOr8YFd6EIoZadL
         eghegONciH2bUUutfOKc9N6QZe3V1wwD/oSkFuPUE9PHbihhTA1fMJiRRirY5p/YmZAc
         3OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=y0ikwqI4+bZ5vxzFdi1ve/0YattRRjl9I9Sy/ybdMwY=;
        b=NemgjL0b/IU3tU2L4wlKClVQUdwjH70VOcN1txX0uFLiQApN0kjgSNSlIwMJ5wcNoa
         m6u4Ogfuqf/AuKnqPYvprLeXHladxf+y10fkMFteL35n5RrL1elfdfPIstN1aRMF12B9
         BdI9/AQZv1JypWJpk0M/fsJLEWMynM0kiSFN5LcZ/AUxB2AiHMJFgCPPpVB0YfL0a7M5
         VK0OYl+WwPnootakRwZWU7bw2UvF5np/AaXayrrWsXfB3fUovLZuPUc86udUWszcBPDk
         KiK2HSKsTP/D9LHfLhyyHKHMwLrIAGqnhvnl7dsVAgwMODbThT6XSIv2NGSIgNMZZ3Wf
         DXqQ==
X-Gm-Message-State: AJIora9/XeDY5lX6qYu5JPnQXk8z3YMmA20YUWWO1fJxk9/GVKeIunxq
        L9rIII/NrN1fQilAmjAYRkzkuKHtMxc=
X-Google-Smtp-Source: AGRyM1tGC0iboN6ndIZucECdAJqBwi+wQ8PZI7zosAUKD0IC2IszPr7ibtlizqJo1vuDTxfjnql0Tw==
X-Received: by 2002:a7b:c7d2:0:b0:3a3:209d:cdc6 with SMTP id z18-20020a7bc7d2000000b003a3209dcdc6mr12686972wmk.55.1659388499834;
        Mon, 01 Aug 2022 14:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm12885378wrn.109.2022.08.01.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:14:59 -0700 (PDT)
Message-Id: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:51 +0000
Subject: [PATCH 0/7] Generalize 'scalar diagnose' into 'git bugreport --diagnose'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the preparation for moving Scalar out of 'contrib/' and into Git,
this series moves the functionality of 'scalar diagnose' into a new option
('--diagnose') for 'git bugreport'. This change further aligns Scalar with
the objective [1] of having it only contain functionality and settings that
benefit large Git repositories, but not all repositories. The diagnostics
reported by 'scalar diagnose' relevant for investigating issues in any Git
repository, so generating them should be part of a "normal" Git builtin.

An alternative implementation considered was creating a new 'git diagnose'
builtin, but the new command would end up duplicating much of
'builtin/bugreport.c'. Although that issue could be overcome with
refactoring, I didn't see a major UX benefit of 'git diagnose' vs 'git
bugreport --diagnose', so I went with the latter, simpler approach.

Finally, despite 'scalar diagnose' now being nothing more than a wrapper for
'git bugreport --diagnose', it is not being deprecated in this series.
Although deprecation -> removal could be a future cleanup effort, 'scalar
diagnose' is kept around for now as an alias for users already accustomed to
using it in 'scalar'.

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/

Victoria Dye (7):
  scalar: use "$GIT_UNZIP" in 'scalar diagnose' test
  builtin/bugreport.c: create '--diagnose' option
  builtin/bugreport.c: avoid size_t overflow
  builtin/bugreport.c: add directory to archiver more gently
  builtin/bugreport.c: add '--no-report' option
  scalar: use 'git bugreport --diagnose' in 'scalar diagnose'
  scalar: update technical doc roadmap

 Documentation/git-bugreport.txt    |  17 +-
 Documentation/technical/scalar.txt |   9 +-
 builtin/bugreport.c                | 302 ++++++++++++++++++++++++++++-
 contrib/scalar/scalar.c            | 271 +-------------------------
 contrib/scalar/t/t9099-scalar.sh   |   8 +-
 t/t0091-bugreport.sh               |  29 +++
 6 files changed, 358 insertions(+), 278 deletions(-)


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1310%2Fvdye%2Fscalar%2Fgeneralize-diagnose-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1310/vdye/scalar/generalize-diagnose-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1310
-- 
gitgitgadget
