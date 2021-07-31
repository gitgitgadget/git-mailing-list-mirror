Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C9C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E6D60F48
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhGaCZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhGaCZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:25:18 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1919CC0613CF
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x12so6195931qvo.12
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PVSvhjZdEK5Sdu3J4l7fxAdfKiCIW75rqc/kwICupY=;
        b=CKuLc8e9ZTG8XHXG0bbiP0zy+OFAElSL4mFhSAyqQ1YNdD1A4Kh9bUYS2yIFumib5h
         ak3v9kk9sR95d9wnmBNNzGxxP8Ubj6GaafjFz96DyzlXURc1vOMaLTjk5aHBTGxPxtqk
         endeSnqMTL0j2NvU3e3/5ja7RFgJitdvTpxRCyrY2WbX8dmIAm0UlzWClZE43lSq3848
         jmObz6bGtlnQ+4MunZ4ijj9ZAteTV+sb9ad2n/x/2N70h4yIfenIy32Vh00/uOq6at3R
         2NKO+99ZLPmzBMdijCFOGsLXN6OlUD0EZ4sWOg79yKQq984WVHWEDW4xUmWM91HC1ZyD
         WzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+PVSvhjZdEK5Sdu3J4l7fxAdfKiCIW75rqc/kwICupY=;
        b=DUx2daZQjxnV9G1YXJNI0Jo/TcA+o0OsgLoRwStfrHJT4NTFD1T0DLjs0gcObqxjd2
         4URUETj5DYDJWFMnTFQp8805XoVrPbgryonjI+vjNWjimOdTbEiIbd9TGfW5+5CiOEUb
         EJ0trCPpv5Irq1fiE0fJJ+6hs5CXe22SYdwjYRiDaPJznmA9ZjUtfmPjCzAzGlj4QIyy
         NA0fmUrP3VXNX74gN7NIKzvpGucFpFAnOwsFDpYJHNmprhgntktKTxuIFbdK66rcxz7j
         Ln9c8F/aNNH8tITh4QLJlCRcg0aZoDxpKyv/cnge5+0iQ0pPAEoarppxGFxqBRiCa0q5
         fIAA==
X-Gm-Message-State: AOAM532NzAA++n7UOiDcr7im6/ZpmMISmRz44fOzkXJ9FITpLxsn+QE4
        q64l6Ei7W+GuvKvZtgXgbTxXj9HDBPN2Pg==
X-Google-Smtp-Source: ABdhPJxbPDOPWhIdrqPOc6CqfmkrLcesuMIwiMf91UOGjLJ8MUS9uGRjzCqp5G+pfqtPq1XtosyP9g==
X-Received: by 2002:a05:6214:a93:: with SMTP id ev19mr6143374qvb.27.1627698310638;
        Fri, 30 Jul 2021 19:25:10 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id z11sm1437963qtq.77.2021.07.30.19.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:25:09 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 0/4] advice: remove usage of `advice_*` global variables
Date:   Fri, 30 Jul 2021 22:25:00 -0400
Message-Id: <20210731022504.1912702-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When looking at global variable usage for my `branch.default*` settings,
I found the `advice_` variables which were simple enough to resolve.

--Ben

---

Ben Boeckel (4):
  advice: add a function to set the value of an advice type
  advice: add enum variants for missing advice variables
  advice: remove uses of global `advice_` variables
  advice: remove static global variables for advice tracking

 advice.c                    | 88 ++++---------------------------------
 advice.h                    | 38 +++-------------
 branch.c                    |  2 +-
 builtin/add.c               |  8 ++--
 builtin/am.c                |  2 +-
 builtin/checkout.c          |  6 +--
 builtin/clone.c             |  2 +-
 builtin/commit.c            |  4 +-
 builtin/fetch.c             |  2 +-
 builtin/merge.c             |  4 +-
 builtin/push.c              | 12 ++---
 builtin/replace.c           |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/submodule--helper.c |  2 +-
 commit.c                    |  2 +-
 editor.c                    |  2 +-
 notes-merge.c               |  2 +-
 object-name.c               |  2 +-
 remote.c                    | 12 ++---
 run-command.c               |  2 +-
 sequencer.c                 |  8 ++--
 unpack-trees.c              | 18 ++++----
 wt-status.c                 |  6 +--
 24 files changed, 68 insertions(+), 162 deletions(-)


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
-- 
2.31.1

