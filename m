Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2109C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680F12237B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViDRquyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444164AbgJUSEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405153AbgJUSEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:04:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAB1C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c16so3554313wmd.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dDGBz1qsS12h2yBphriUyBjEPGNW9EQgAiBLysVKATo=;
        b=ViDRquyHFE5sVrf+TdSyqgwV0irzIUwhnbm70yqtAx5txa8y8/Z1L1KH4QSS21f/OX
         E1M64Nw9VAyTbTTHx/GfcaWAjvKxmehx081bE4n20WBY5kwio5xnX2ZW+Qu/SBFShZLo
         58qp/useTtMaGlwVBbLtUYJbO4n2lgr8PSZliPf0qcAte/npfd8Fd7I4NbOJ7QjS4ilg
         m6SP9srmrUMZzkohcjq8z8q8F6hgSdan8+O+PMUPY8EyJ0Qfc+xcI23lm5JT6Cpogy9N
         ibSQH4oBMh7HwS7wfUU5CayTxMqiBbhSO2mC8a/ilm6AZe+yd6BysslwYLpeGJthLzc+
         +ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dDGBz1qsS12h2yBphriUyBjEPGNW9EQgAiBLysVKATo=;
        b=A4L9fzwS8fsyhtLTbyNtji2djWoh+Y7XoIdgnVN/MBhY/fClEzc+ydJxP4QqIUwkUH
         g8UJGZA0jvcLtN8JQRemVdA9s3H6zMyHPA3TnpSrjszmlkrXX2JETG91aJjb59jBxtPx
         AEC2+z7Lts0Oz3kcZ/Z264GW72oqI+7GvpO/qXTE7XF+pz8NN7574Bsh7lNCb1bKN1s0
         R/64bo6iX0rPlI0f+BjydGCQPUi4QZcZAHibzmCZGf6btg+KU6A22oZBlw5++PDUeEfs
         dfpYjD8iUFuf6JxS3klN4X3yv9MF6Gq7X67SuZW4IW/kF/JXgBsc0r6Rmt8byE/VlYEk
         y37A==
X-Gm-Message-State: AOAM5309rRuMRJaTOR7q3H0P9ErpGxVIwdgl1Pf5yNKgY60FOz/T/oY4
        haG3gB150dr4r6OIjVHvUkUEJfx4GwM=
X-Google-Smtp-Source: ABdhPJwlAoRLOqOpBEe9cdtJYG7hLIB4Nz1PUx3LGXaGEGc3lXweRmY9z4vKmbMXqHnWgPs4SRIf/w==
X-Received: by 2002:a1c:3243:: with SMTP id y64mr4769600wmy.175.1603303476281;
        Wed, 21 Oct 2020 11:04:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm4484014wmm.4.2020.10.21.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 11:04:35 -0700 (PDT)
Message-Id: <pull.767.git.1603303474.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 18:04:32 +0000
Subject: [PATCH 0/2] fsmonitor inline / testing cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Credit to alexmv again - I'm rebasing these changes from a couple years ago
for contribution.

Full comments are available here -
https://public-inbox.org/git/01ad47b4-aa5e-461a-270b-dd60032afbd1@gmail.com/
To summarize the relevant points

Re: Inlining mark_fsmonitor_[in]valid peartben said

I'm fine with these not being inline.  I was attempting to minimize the 
performance impact of the fsmonitor code when it was not even turned on. 
  Inlineing these functions allowed it to be kept to a simple test but I 
suspect (especially with modern optimizing compilers) that the overhead 
of calling a function to do that test is negligible.

Re test-dump-fsmonitor peartben suggested keeping the +- syntax as well as
the summary counts dscho suggested dumping the invalid entries

Alex Vandiver (2):
  fsmonitor: stop inline'ing mark_fsmonitor_valid / _invalid
  fsmonitor: make output of test-dump-fsmonitor more concise

 fsmonitor.c                    | 19 +++++++++++++++++++
 fsmonitor.h                    | 18 ++----------------
 t/helper/test-dump-fsmonitor.c | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 18 deletions(-)


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-767%2Fnipunn1313%2Ffsmonitor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-767/nipunn1313/fsmonitor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/767
-- 
gitgitgadget
