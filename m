Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB015C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4FC20702
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLOIrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgLOIrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 03:47:02 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0BAC06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:21 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id t23so4630381oov.4
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olp6XFGR/Y7joQIdWHlLseRFU5eoibbZOYvhWvUt2rc=;
        b=mRYSlmhAc+jvdutCcas5rC9BbUOc3g1batijBa9ugVxa9sDQaWMkelOEw5+dA29Wpm
         RcJa5E459173BjQNSUgKi+socRtJN7HKFD5srk8/jKJreANofCwlzHYmH/PGwLvxScwm
         7DASKXUfdVpprnjyWB37MgFrDXw/8mdSvqQt5aXUEa1pFSU/EgqNZk3zXgDnedCHcawg
         S2FPYUbKHTVsL4/h6x/e5IkHkleXbyuIjEpgJD6tGMHtsmvyHfjjGpv9uIhCwyR7xdjY
         pzGHzDHES2s54dA/eCXzugc7ytlR4FzuafyKB3Qz5WUgG1L/9sYXapqiXg1daQqR66qh
         BvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olp6XFGR/Y7joQIdWHlLseRFU5eoibbZOYvhWvUt2rc=;
        b=k5fYjMmtPaszI/qeq+s+ex42wdCdbLc98WprJfQ3uvwIr8CSi+yXXa57rcqDpFoiXR
         i6S1hwdne4iF1OXgFGhV4MitKXcAKM35Eqjp3sEc55MSlI5A5XI7quQ4sbmMgL3IdYUT
         JISLikZGMCctvukyqH+j5FVyNvv/bL9/FztTVNA/oGbcVvlPTWtuOnnzmznuUEukp3yH
         zWo9zXimni2DJp7D+LN0epAdDhmt7meXLJrsMs0pPiduDjOPpt90kOF+rSPdMcjgrIhu
         K0X0JzWhEFUoQ9/vnmsXxt8M1acj0JvDU5M5UPiEEgJNvgUS88F96KHbSI2rwcJH+2ZZ
         FR4A==
X-Gm-Message-State: AOAM531Zho4xJCiwHHt7CvTaHUVNGC0fJF5HrE36Uh9of6QX8wRlTXSd
        mt7+Z3BKi8QlgHlpgReqeuy79qGe46wfXw==
X-Google-Smtp-Source: ABdhPJybJ9uGGOnxDbHUmiBbDOZU0JoxH9ozdpJCFBSmOADpn1sDfj+UaphCSYM6wON2qHoql4bhcw==
X-Received: by 2002:a4a:364a:: with SMTP id p10mr4417010ooe.48.1608021981024;
        Tue, 15 Dec 2020 00:46:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 65sm279143otp.35.2020.12.15.00.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 00:46:20 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 0/3] pull: warning improvements part 2
Date:   Tue, 15 Dec 2020 02:46:16 -0600
Message-Id: <20201215084619.1631180-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series goes on top of fc/pull-merge-rebase, however, I don't
know how I should communicate that clearly, so I'm sending this as RFC
to avoid any possible merging issues. It's not really an RFC, and in
reality this is not v1, but the end result of many iterations, simply
rebased on top of Junio's changes.

While updating the documentation (yet again) I noticed it didn't follow
from one paragraph to the next (not a good story). So I decided to
rewrite it adding a lot more detail.

The warning has also been changed completely taking into consideration
the imput Jeff King shared with us in 2013 from GitHub trainers.

And finally one low-hanging fruit patch.

I have many more in the queue though.


Felipe Contreras (3):
  doc: pull: explain what is a fast-forward
  pull: improve default warning
  pull: cleanup autostash check

 Documentation/git-pull.txt | 38 +++++++++++++++++++++++++++++++++-----
 builtin/pull.c             | 38 +++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 24 deletions(-)

-- 
2.29.2

