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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCE7C43216
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B7A61101
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbhHJJcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbhHJJcX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675EFC061799
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q11-20020a7bce8b0000b02902e6880d0accso1491733wmj.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dk4EAwLez775ImkoNIaO+FLgpogSAdnpH1lEkejMEgs=;
        b=p4+jCjHFgHwgGSGYcpoRhXaP73OFDOGEax4+K4X9ob1P3jUbySuhFKqahqWVQBswiA
         B/U9IeeSkXHuGyCDkhrgIBe6Qrk1KTnsOLNSwP2TRGricwEdFw2s7GH2bgQUb+HaGmd/
         CjaOldOM7+c2GA8rPex8hpV6yj83FpGOVqYjXRjB+7BW6GK+hLmjGearyiUp8c4TmvhI
         rj+2NTc7M5cKSHBXEmbFVdMkSzlaQwZPuJl0lklIP1K3qU1XLIQvF8TYGVYWvhfAumiJ
         +oPaSTQHRV9kCeZ9CZTl6wnppFIn/zupgyQA8QWjhUaMidydtwc6n/G0BowuhwPa0ozn
         0I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dk4EAwLez775ImkoNIaO+FLgpogSAdnpH1lEkejMEgs=;
        b=l1bZoM8Ef6RBZ9/44SCzMMQ2DhOnu4Pt/+BQbiQuW6JAF/jAWiLD6YcmjBv/t2mIhA
         PA04YI9SrMM3ccFR3vrsaUcxp1S48IGKWOzWG5CtkZGs/UFwqr9fChNJ4wYLfInSTmZV
         2K3jEK37ntVX5RkKRT3zfoC/E2iiuFVFSOUjhCGgKf1bf/H9a+8B4ny0KaQV9ogBT8xd
         8seQuCctPAdfcoKbqHhD1EcaV39uG+YpJtpA1Nt3L4GFeamenqTde0Sm0xRTL+Xbz2+O
         tI+66tpsYYkBWN8ZGUCqz19n89c9BCzh26M/BA9WrHZCo/HBYniWA2zfUPUE0qwjq1hl
         i3Yg==
X-Gm-Message-State: AOAM531MvfUC7sOa90nJQ7V6hnExYP5do+2OZI/hKQyvn+auc7Ke3ui4
        I3XWiIefKY0ziiK1uFLXCtmAXH3C93w=
X-Google-Smtp-Source: ABdhPJxf3V4k4Y4NXWHwifPsl/LCG/c6QlzOzu5/x3txSpai7IxUzyGDedXC03DbPtfhWpxOHBK3Tg==
X-Received: by 2002:a1c:2202:: with SMTP id i2mr3700404wmi.78.1628587919879;
        Tue, 10 Aug 2021 02:31:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm2189012wmj.41.2021.08.10.02.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:31:59 -0700 (PDT)
Message-Id: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 09:31:54 +0000
Subject: [PATCH 0/3] rebase --continue: remove .git/MERGE_MSG
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victor Gambier <vgambier@excilys.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user removes all the changes from the worktree without running git
reset then it rebase --continue leaves behind .git/MERGE_MSG which will then
seed the message of the next commit. While working on this I noticed a
couple of fixups for the test files I was adding to, I've cc'd Elijah in
case my reasoning for patch 2 is off. Thanks to Victor for the bug report.

Phillip Wood (3):
  t3403: fix commit authorship
  rebase --apply: restore some tests
  rebase --continue: remove .git/MERGE_MSG

 sequencer.c                |  3 +++
 t/t3403-rebase-skip.sh     | 13 +++++++++++--
 t/t3418-rebase-continue.sh | 14 ++++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)


base-commit: 2d755dfac9aadab25c3e025b849252b8c0a61465
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1013%2Fphillipwood%2Fwip%2Frebase-remove-merge-msg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1013/phillipwood/wip/rebase-remove-merge-msg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1013
-- 
gitgitgadget
