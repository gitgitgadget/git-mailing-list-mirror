Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C430C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 07:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8B56101C
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 07:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGaHBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 03:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhGaHB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 03:01:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BFC0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 00:01:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h14so14160525wrx.10
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QwXDxQME29mTUDPLPDcsro5RlTRRCit22XTF7vdUXL4=;
        b=Qv0aDrHIl+BjAnyDL2xr+QNWYPSNsFge3SwBKo7QDqj2ltwWeCuLdOaUoWZeg/9lb6
         k+Ho8cTLiMY1MvNTYtCU0y/ge+SC0+za6WMuQFIKWCKOTvAqKdi2sgQPp1ESGCVZkNuJ
         TvuDnVw8kexTESqcbXFg9jKXnA8bHkWVS2kT0yWvaXeqSke5MUoXTt5t5SmKijb20weY
         v5DrP+crg+JHN+NOpmpvoVUgJKvPqtSgCmI9k83JGge2vKjm4hN2/EF8Mh8woMPeJ38z
         46u32WD2HST2DB/NYJbh80U/QpJSmPKEv4C9ShruLw3MYOz7jCzL9+QQksPF7lsOboGt
         hUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QwXDxQME29mTUDPLPDcsro5RlTRRCit22XTF7vdUXL4=;
        b=T7DLpO5eA0v3vANxiD+COmUTgAAMK95pM0MtuNlA0dUetHBGZ/Ye/SXyaHBeX0rn6v
         S0SNkQLwdyFHHukohXADIQy0XR5pAVFKzKLeF1s9Rc4DYGSc2YTVg81wS8Vase2HWOgg
         W9+O7SErMTOdeD+meF3ysExZEq8yooj15WKjP6ge5qtb6g0Rr+AbV4L9DqX9aIiklDyt
         dP0+LOa2X1yxyZKyyjNflBuiz7YdEenhKYYzhcBQ6udc0E5t+8GPgyRKUo7rPNLs0SZL
         DjCATgSJerLzFTdi/pjHwTR1mqhKZdRFE1v/Bgtyx7pC28muLiRwzqHIXV7JMLhn6bh9
         oY5A==
X-Gm-Message-State: AOAM5312eX3rYSj6kADKjbqY6qDFBMGlcnnYdAUqQe87cx07xCqpYtQ4
        Th9yLDWPfna6sudgwT3Y1mkKPWyxFD8=
X-Google-Smtp-Source: ABdhPJym/ZYmUfDg3P70y278mWZmeoQNiyZ6v0tjzdcZvcjaQNa3ixUzALh/QyyVbjPmIfT3ysAOgQ==
X-Received: by 2002:a5d:5412:: with SMTP id g18mr6972482wrv.301.1627714880490;
        Sat, 31 Jul 2021 00:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n186sm4478665wme.40.2021.07.31.00.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 00:01:19 -0700 (PDT)
Message-Id: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 07:01:15 +0000
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

v3:
https://lore.kernel.org/git/pull.1007.git.1627561665.gitgitgadget@gmail.com/

v3-->v4:

 1. Add hidden option --delete-cherry-pick-head to git cherry-pick wihch
    used to delete CHERRY_PICK_HEAD when conflict occurs.
 2. add delete_cherry_pick_head flag to struct replay_opts and struct
    rebase_options.
 3. Split print_advice() into print advice and delete CHERRY_PICK_HEAD two
    part.
 4. Use better git cherry-pick advice message.

ZheNing Hu (2):
  [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
  [GSOC] cherry-pick: use better advice message

 builtin/rebase.c                |  3 +++
 builtin/revert.c                |  2 ++
 git-rebase--preserve-merges.sh  |  2 +-
 sequencer.c                     | 37 +++++++++++++++++-------------
 sequencer.h                     |  1 +
 t/t3507-cherry-pick-conflict.sh | 40 ++++++++++++++++++++-------------
 6 files changed, 53 insertions(+), 32 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1010%2Fadlternative%2Fcherry-pick-help-fix-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1010/adlternative/cherry-pick-help-fix-3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1010
-- 
gitgitgadget
