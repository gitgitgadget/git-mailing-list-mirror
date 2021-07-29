Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69CC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C3A60ED4
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhG2M1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhG2M1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 08:27:52 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2704C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 05:27:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b7so6721175wri.8
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jA3qillG+yqTXt9CqbJuNjyeAh0BQ5QdUvHZjUkEbN8=;
        b=fNtRmUvriXZvinvlY9AY/rFkGZHhGA0RuijWBLLkPtbW1b9P19gzFnSVBULtHsl/u+
         RCvfhc9EDuDRveqS0kmJBqMwLsY958of9TPivNBSZo5C7jcGpIMQMaq+OJ2Iroaoxp+z
         0l0VWHiWsbvoNoH8jl09xnZsdyrNM1n9M7Qfoko1pTqvv4lBPu/ycIscZMu1EyjoPLDD
         x/WRJsspUNKyo7i7jv+DJMCud1FmlvYzez1cXe5wFW/MQai9ktwz/Ia4zSUS0NQE8Y4B
         MBhkcfyMSx2D4QrCOrRb76dBJhzoztNHHHJjhLr3Wc0aI3KbJ2OMd22/ETMRfwqdc3zY
         kzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jA3qillG+yqTXt9CqbJuNjyeAh0BQ5QdUvHZjUkEbN8=;
        b=laVvrs+X8H3E3jUPhDdzZ8Ht9aGgIWnh44Ol4l6qbA/5D9zE6gO5QKhK9NHdiJKlJD
         qf2iHVUbNGJF8Tka7pK0FGKUwCuMEgrShsNYNGK2R7zt5nz0wZxGdwtEQPN9bxju5qh9
         rncFbPBlqAwAUCsaWB08MxhvRCu/bkHWZtHHzTf8hQ5m3flp4egR8eN0JE0yzSHryljn
         kRKCCT9W7Gqa7P/whlzqvLouCxlPME6o3lJSF1ynPwSwzt1V9n8Fm39iKZ8DzrBSrLo8
         vrUOO68NMlap2YcgevsdXF6kr7n2fHqVvDlJkSUBgRUTcHyuCElDvBW+ee+woGoAHp/m
         CIaA==
X-Gm-Message-State: AOAM533Rs+sRd1z3hogFm/Kaithr268KF2Orztycflm5Dx5FecxXzVBU
        h8mA9Ov8996KwuH5b1pWEoCQnd26zwM=
X-Google-Smtp-Source: ABdhPJyuZ08jyEwoqAKuBeNfzsKPd3P1rGg96PxH2KjunV2+YCcRX41T1yVqyS7HAc4hxS4VdNuMQw==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr765316wru.142.1627561667605;
        Thu, 29 Jul 2021 05:27:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm3343461wrx.7.2021.07.29.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 05:27:46 -0700 (PDT)
Message-Id: <pull.1007.git.1627561665.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 12:27:42 +0000
Subject: [PATCH 0/2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes the bug when git cherry-pick is used with environment
variable GIT_CHERRY_PICK_HELP, and makes git chery-pick advice message
better.

v2:
https://lore.kernel.org/git/pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com/

v2-->v3:

 1. Add hidden option --rebase-preserve-merges-mode to git cherry-pick.
 2. Split print_advice() into itself and
    check_need_delete_cherry_pick_head().
 3. Only allow git cherry-pick skip check_need_delete_cherry_pick_head().
 4. Use better git cherry-pick advice message.

ZheNing Hu (2):
  [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
  [GSOC] cherry-pick: use better advice message

 builtin/revert.c                |  2 ++
 git-rebase--preserve-merges.sh  |  2 +-
 sequencer.c                     | 45 +++++++++++++++++++++++----------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 44 +++++++++++++++++++++-----------
 5 files changed, 64 insertions(+), 30 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1007%2Fadlternative%2Fcherry-pick-help-fix-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1007/adlternative/cherry-pick-help-fix-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1007
-- 
gitgitgadget
