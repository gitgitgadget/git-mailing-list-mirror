Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D059CC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F78E206E9
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVblYEIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgF3MFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgF3MFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 08:05:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29BEC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so20267640ejq.6
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/yc34zP5H6Aoq9hFgqHYA++i37xl4/1yBXJvpRx9WxI=;
        b=FVblYEIBY++/WIoyhZeZr+Iq1LLxH8y45F/gZUE54YKlo3tGR3ou93jM+D+UcqXCfT
         DYnmLVtk/Z0F5I5vlxjrq4s4b6X13YCVhJefUMJ/eWzGNpmwheV/w3i/M6+pitkXQgUe
         RZue7hnvgfn/jyc5pbaJ8F70Izo15yecU2wmGzvl6Vxf25oD7ejgCyn7pP+qzkNMBxQD
         9VgvS+b5zYj4NGBv3u1Y1WKA57zjMEY3XDNtTxC8WpEgpLtUDiH4rzL7kQRMaXwTTT+H
         HOO/YyCyPsaiyf9/rmOTIFe1WyDJSPCcj/JNEjgmaH+GBnHsUHv5rRM0rXLmg/Sj3uIb
         NmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/yc34zP5H6Aoq9hFgqHYA++i37xl4/1yBXJvpRx9WxI=;
        b=LDYsVJ1Kx9/kqBG9vc0UNIdOecSKH5Gp9CTkPjSHWPYFG9G9ff+nvl8yv+OZBrlEZY
         RI14OhFnYJauCIhLdtP1vFf/td9GJOL4ZNI8D+POnyrvmA7mycT9VoOrupgUcbNPQdHZ
         oCoaUd4G/WanDrOIzX9ORJiX8A4ZZWh/js5LydpBPBPiHhf7jAYr+I+IV4s2L04+65nV
         SywARXaIPdiFRAm5z8QR9RfQTIccQOtUq80M1BP9GIByvZYxo4fnUxhw8jekKNpJmD7l
         rl4X6dwJPbEuDjiOemznIM5ECD7cByw0hwvfOsBEnLwV255t5x6lwCNaT5lIE/KkuRxS
         he6w==
X-Gm-Message-State: AOAM533u6Dmcvd5qhO92iiks0OweRSxgGKFudfbc9H6UHBNBc9MFDwIY
        pTak7o1nzrY0IPL1pZ0RtBZiPTJdrmY=
X-Google-Smtp-Source: ABdhPJwdGgd4dtqaODNNM8ReqhHLHHeD1nY6a61B/U7eN3qIuqNkBYqHHrheBtcHx8cEZQmu26EQBw==
X-Received: by 2002:a17:906:3fd2:: with SMTP id k18mr18987418ejj.387.1593518739598;
        Tue, 30 Jun 2020 05:05:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dm1sm2028128ejc.99.2020.06.30.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:05:39 -0700 (PDT)
Message-Id: <pull.669.git.1593518738.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Jun 2020 12:05:34 +0000
Subject: [PATCH 0/4] Preliminary fixes for reftable support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are assorted small fixes split out from the reftable topic.

Han-Wen Nienhuys (4):
  lib-t6000.sh: write tag using git-update-ref
  t3432: use git-reflog to inspect the reflog for HEAD
  checkout: add '\n' to reflog message
  Treat BISECT_HEAD as a pseudo ref

 builtin/bisect--helper.c       | 3 +--
 builtin/checkout.c             | 5 +++--
 git-bisect.sh                  | 4 ++--
 t/lib-t6000.sh                 | 5 ++---
 t/t3432-rebase-fast-forward.sh | 7 ++++---
 5 files changed, 12 insertions(+), 12 deletions(-)


base-commit: f402ea68166bd77f09b176c96005ac7f8886e14b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-669%2Fhanwen%2Fpreliminaries-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-669/hanwen/preliminaries-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/669
-- 
gitgitgadget
