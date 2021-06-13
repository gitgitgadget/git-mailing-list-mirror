Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361CC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552C46124B
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhFMXAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFMXAm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:00:42 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DEEC061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:58:40 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id z14-20020a4a984e0000b029024a8c622149so1714355ooi.10
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeH5NRBuQdQs3tKDpDDGzYUKGB/e9UlWE5ZXsGX0oew=;
        b=X0Gv5OCXNrdYRpyiJa6c12+SzUke/lmPrg6LkNE9zNy8S3MU5SxmfFkIP/93n6HpSY
         5zddgijL2ZNBdDgIKo9OnnYA66sVb1CDeksTIS+jNmDlP9Fn85DokwAbqQYSfAoJO3mp
         +bIMrMS65lr6CZ4fHVV9PZL+7TVfbLMhRe9K1Shs5aL0CkxRg3cRzKKPIzxnLXHvHNcA
         YOltvU+vnqrcCOH52wQ8cHFXTXMwV6oE2D1I4ReTD90LFe2FWa02t/WiKsxUCDP9++Cl
         zYmoZy90clLT6YiEosS8DlkVSE9+nULo9cic4HkdxcIVdRHUPlUWNSS8qdruu5kr7LyO
         nQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeH5NRBuQdQs3tKDpDDGzYUKGB/e9UlWE5ZXsGX0oew=;
        b=LPxSX9iw/SgMLAJZfWt1WUFVZR/LrmF73YB98yzhIMiV8xeUpd+Pdn5Tbtbg5cJCcI
         Nk2oS0/QccjGkzpRondBoeBrUGavyY3HV2w5QbjhZTm0PUsTLuEPVLCWpeRYwnCxn1Ah
         /k3aBGS9uTpo3i4h2m6uxC9oelwgWySJtlhwaqaqcJzTBCDg+Xyt+Gk9/6PvQbWDMV6g
         oVCEqsIKStVtj5nZ/rBagq0OL5qmTD2ovW1wv0kVZ4WujU8V8KbrU1KAhoYI0QOlgaCH
         ZAhJXfW8FCZyEXBBlUSlhL1EiJ5dgAxlfyeEL8bY7dmAEWV8Yqr0+ECZ0wPc2pXQBzvc
         H5wQ==
X-Gm-Message-State: AOAM530zDGtEymGxCZyFNxfNrK4C8NfCjLPXLf8hehv42s5/6N6E5eza
        2vhxA4BoUC6jmAkjTSuiHYC+zrjUH6gLqA==
X-Google-Smtp-Source: ABdhPJy6LZWCFImH4ZRz6JPQfaP+54ZdgYI+KE3z+BLH7XLzXwItK/0t7EIsU12BdunsfIiiTlz9uA==
X-Received: by 2002:a4a:e0d2:: with SMTP id e18mr11129812oot.3.1623625118139;
        Sun, 13 Jun 2021 15:58:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f25sm2925253oto.26.2021.06.13.15.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:58:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] merge: cleanups and fix
Date:   Sun, 13 Jun 2021 17:58:32 -0500
Message-Id: <20210613225836.1009569-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Investigating a crash with the proposed zdiff3 [1] I found some easy
improvements in the merge/xmerge code and one crash fix.

These should not cause any functional changes, even the fix doesn't
affect any current code-paths.

[1] https://lore.kernel.org/git/YMYnVWSEgxvKRU9j@coredump.intra.peff.net/

Felipe Contreras (4):
  merge: simplify initialization
  merge: fix Yoda conditions
  xdiff/xmerge: simplify xdl_recs_copy_0
  xdiff/xmerge: fix chg0 initialization

 builtin/merge-file.c |  8 ++------
 xdiff/xmerge.c       | 30 ++++++++++++++++--------------
 2 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.32.0

