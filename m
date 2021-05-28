Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78723C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412BC613B5
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhE1ULx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhE1ULw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:11:52 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DEC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so4577226otc.12
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEWS1XVNXhFxYVs6oX1w2/iBs2uHl+/LfyqG7CNnSPY=;
        b=BOLH3z6renVYuXGiaMjRxolD8JJzDZPTweX4fdEcOddX4fRCXEiMs2bTiRroVrOnBQ
         SszCKo6NDgUm8NhhBldFOI/b6BlU5x3lBzwXYrFVz1qRHDixEVj8DyP+PCnpnJlUC+Jn
         1EW5ftwRy4d5zcmCRdPUlolFSCJrdTkHTRvdd2tGULABDuvEjUoyRHkITcQaOv1/FcQ5
         L7qMzaY4kXCKFaSZg7sYK/XtwiySvrkFl1qFuamu+0kJiViVWdOmq/4bkwegHwCphu+4
         STPUJqozQ39fieZpPNNZevN2dnlChE/XESHQiOzA9m6sWRCO3Ly/DNPB6CKbG27LEwKZ
         kN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEWS1XVNXhFxYVs6oX1w2/iBs2uHl+/LfyqG7CNnSPY=;
        b=ckjvUDCDglkkJDGoI2MnEv6zMlecerlmLn1xYZgKSRB7HA+V3NE/IjEGlaAld0Qyx3
         6Utjz4O5AEvrh6DBkbiMBnTRP/ETI0hvLPYW7RC98vJ0nma7rxmZZY+Z2g8Eghk+SaVA
         M7Qxc5dRzexJI7SAPJDW+atpzNxW+E6PW6/o3XkS9c3mmkVJc24d20P1kTVqfnL/pziz
         8InfP2z+0ok1OykMmoHpv+UtANW2YpWcUQaOGCY20BkA3wtFgCRIO2lXhtc+sZh76sQ/
         1rZdM0N21wVg378pO+KBom5bigpW0iN+/lzN6/DL5aboJLRoqmh7/X9dFBZYJwtViZGG
         uICg==
X-Gm-Message-State: AOAM533sS7SHegxklpWOa3wE6Is+5tLV4tYlTXa9bCAZyhT6VQPUddnB
        9TMK63x1lG7sHPxmU8PVLGeq2EmJzZe7XQ==
X-Google-Smtp-Source: ABdhPJxQa8MaM4Tbbn4Z+suv4JYlJw7vDSXobbp4qW1ZEQxDiFLet32TXD/n3aWrj6TMY5nM7SbR5w==
X-Received: by 2002:a9d:8c2:: with SMTP id 60mr8678351otf.217.1622232616737;
        Fri, 28 May 2021 13:10:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w6sm1340565otj.5.2021.05.28.13.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/11] Unconvolutize push.default=simple
Date:   Fri, 28 May 2021 15:10:03 -0500
Message-Id: <20210528201014.2175179-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tired of jumping through hoops trying to understand what the "simple"
mode does, I decided to reorganize it up for good so it's crystal
clear.

There are no functional changes.

Basically the simple mode pushes the current branch with the same name
on the remote.

Except... when there's no upstream branch configured with the same name.

Now the code and the documentation are clear.

This has the additional advantage of making `current` based on `simple`,
rather than the other way around; `current` is basically `simple`
but assuming we are never in a centralized workflow.

Felipe Contreras (11):
  push: hedge code of default=simple
  push: move code to setup_push_simple()
  push: reorganize setup_push_simple()
  push: simplify setup_push_simple()
  push: remove unused code in setup_push_upstream()
  push: merge current and simple
  push: remove redundant check
  push: fix Yoda condition
  push: remove trivial function
  push: flip !triangular for centralized
  doc: push: explain default=simple correctly

 Documentation/config/push.txt | 13 +++++-----
 builtin/push.c                | 47 +++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 29 deletions(-)

-- 
2.32.0.rc0

