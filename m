Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4460EC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB236199F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhC1C0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhC1C0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:26:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C62C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id d191so4853836wmd.2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9R9DCiU7sOZfsn6/dVTjc1/3ZImDCMzV9PoS2bl+fs=;
        b=fegSmNnNUFgQNOlif64b69sKWpdPl5SqMCIAxe0ph7ZDlmrsVfB8VXZyeQvUsEnOVq
         SpuwY79Yo89VJePQ8B9OXDAiy25GFKZ6VfyvyUfeMo7v68OAfenO3AKbmXBrdw+HBmvy
         XJKDY227BnpzwJ5AincWHQZbE0acxoVYySbDnQS89O6ncdx150xZGE6v/JhVN6UReCg8
         CVRNbrWxcRqmiHwob3Mcv1SpCmjFSurz+HB5NiGXgGtLGpXMKq5c1UGRpWDMP3cAGpg9
         fHOT8wAGJV522ZBY7Ay8lNvLPXHJVqhKGOrMRe4GS2Wqv8yyJt28nBePKFu4OYwOBRjm
         0Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9R9DCiU7sOZfsn6/dVTjc1/3ZImDCMzV9PoS2bl+fs=;
        b=tpvODovdpVxSvl5kNciLEhtH7Ege3y/dIXH4jtxnl7bBdeSLRlLpxYnDb+MWSdPddE
         Efte6wTsZs8LrXQkVumYHpcM0wohmZUuqRf6v6OU+MN3deyMFvI8MXhSGjuZtXIyvt7o
         fV/dYCCMTeLxdANyuTz43LLotP/Ofg7uxotWkb+zJhfsQSmjtcY5wXkxQiVgGbVRHNkR
         CtySNf5H5NpZs2MaBQP0fnejX1ae9zXXv2fr8grYAsrSp5pyroNlV5vxm6IklkqUrqt8
         RUGy/2eRklh2rGpeHqW85DGIZa+w3iYq5Fg4OzzVhhBX0cgxOvQzerT9hgD9ltqrO75g
         JvXg==
X-Gm-Message-State: AOAM530P/CyA9quA1P9PErAmO4D5P0J97FkDPEGEglCqJfjD20vzqVrH
        84dpBMbmz6msH6a6Yuvd1FG8Uq79lNFr1g==
X-Google-Smtp-Source: ABdhPJwGqZFOTDSDzft+bVfU7fYRcR1wo100+/5VbUP0L4Eu3JNKhYoT4j1gbVXSJm76+mz7FJozYg==
X-Received: by 2002:a1c:2587:: with SMTP id l129mr19014266wml.135.1616898377684;
        Sat, 27 Mar 2021 19:26:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11sm17887305wmi.3.2021.03.27.19.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:26:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] usage.c: add a non-fatal bug() + misc doc fixes
Date:   Sun, 28 Mar 2021 04:25:59 +0200
Message-Id: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix up some of the technical docs around error handling and add a
bug() function, as explained in 4/4 this is for use in some
fsck-related code.

This series does not make use of it, but I'll follow-up with one that
does. I wanted to peel of this small cleanup series from that.

I noticed some semi-related bugs in these error tracing functions to
do with the trace2 integration, noted in
https://lore.kernel.org/git/87mtuoo4ym.fsf@evledraar.gmail.com/ this
doesn't attempt to fix those.

Ævar Arnfjörð Bjarmason (4):
  usage.c: don't copy/paste the same comment three times
  api docs: document BUG() in api-error-handling.txt
  api docs: document that BUG() emits a trace2 error event
  usage.c: add a non-fatal bug() function to go with BUG()

 .../technical/api-error-handling.txt          | 16 ++++++-
 Documentation/technical/api-trace2.txt        |  4 +-
 git-compat-util.h                             |  3 ++
 run-command.c                                 | 11 +++++
 t/helper/test-trace2.c                        | 14 +++++-
 t/t0210-trace2-normal.sh                      | 19 ++++++++
 usage.c                                       | 46 ++++++++++++++-----
 7 files changed, 95 insertions(+), 18 deletions(-)

-- 
2.31.1.445.g91d8e479b0a

