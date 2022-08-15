Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E52C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiHOPL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiHOPL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:11:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769591A3B3
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r16so187533wrm.6
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=nfH18Yn/VsI9rEPCNq9/T7ONtScns2bLwD0rYA0WZcc=;
        b=jJeuofhGnJCdja0Hx1aAc45AkYcd6L4zaewX0bYjHLTJqPOFCSefZ0p05Ej+wEnS6e
         O0oQ3S2BxbaGF14g7xo7FWHbTI6L/+Fs32HPQDeXgw7RJiEB4GTNk19qCpx0ZmC1RaIV
         WZo0OfmcPZRxZ+K6FZkPv73xluUltbKbbquL5AqbpAAgTSuSJavWW8lDeZOzYzq5U3yY
         fP0t37EUQQl8RSV9TdM49zMtdbGeqDtkM7/khsonPtO5Q6KP4bVmhIlnRrKBxGql7k2B
         O8IZsmvvd+Se2xIkuiVmf7jmvffcbldZXVs/i0yR4Q5dyTexAYnVhgv7jeSVUFSyVi4M
         nfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=nfH18Yn/VsI9rEPCNq9/T7ONtScns2bLwD0rYA0WZcc=;
        b=dGziHKDVspRHSsuImRxfcOiSKRcq56xIdp9zIarZdtGh70Eph2aT26G4W0h1qBAeNN
         XQm3mHIW2JX1Bbk97mZwWKzXVh5GC6/EevdqSqj6fvhT4Sbs0xF4fwbdA+j1EA0wQ8V5
         wU3Iv3ybDao7uUGKdCzqauiX8LwEFxmVV/k7tOkQ9CCoMejWll4WsBiKU129xAeX3go7
         vV9jR3XhnwpImh/vR+ropnnnvNi0MuhCmhD5vhCeRw24gsn1oRGZjy/FR43Xx1kwjNYV
         Pm+J/3YmqXR6nUCiAmcP6CZPHY8qQREPPkWg82ar+g58OwDF2yrr08iYqggKlaBG0Qz/
         KvSQ==
X-Gm-Message-State: ACgBeo0j7WCEDhLGflobu/ibRl/2cOK6GtVh+32mNF4VWHVT7lizDwLi
        89iBe5B2PUaovV/nQYCZ30r1OVtsZXo=
X-Google-Smtp-Source: AA6agR7xPi8CVUNzUy8/JWldPhTJTx8kiU7Fkm+aDRhw0Mmbym65waaMtsWEOhJhDq+gT4zcbCafgQ==
X-Received: by 2002:a05:6000:1152:b0:220:6421:ccdc with SMTP id d18-20020a056000115200b002206421ccdcmr8942854wrx.61.1660576284851;
        Mon, 15 Aug 2022 08:11:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c478600b003a30fbde91dsm9301285wmo.20.2022.08.15.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:11:24 -0700 (PDT)
Message-Id: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:11:18 +0000
Subject: [PATCH 0/5] rebase --keep-base: imply --reapply-cherry-picks and --no-fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while a go Philippe reported [1] that he was surprised 'git rebase
--keep-base' removed commits that had been cherry-picked upstream even
though to branch was not being rebased. I think it is also surprising if
'--keep-base' changes the base of the branch without '--fork-point' being
explicitly given on the command line. This series therefore changes the
default behavior of '--keep-base' to imply '--reapply-cherry-picks' and
'--no-fork-point' so that the base of the branch is unchanged and no commits
are removed.

The first 3 patches are preparatory cleanups and refactorings, the last 2
patches then implement the new defaults for --keep-base.

[1]
https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/

Phillip Wood (5):
  t3416: set $EDITOR in subshell
  rebase: store orig_head as a commit
  rebase: factor out merge_base calculation
  rebase --keep-base: imply --reapply-cherry-picks
  rebase --keep-base: imply --no-fork-point

 Documentation/git-rebase.txt     |   2 +-
 builtin/rebase.c                 | 116 +++++++++++++++++++------------
 t/t3416-rebase-onto-threedots.sh |  52 +++++++++++---
 t/t3431-rebase-fork-point.sh     |   2 +-
 4 files changed, 114 insertions(+), 58 deletions(-)


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1323%2Fphillipwood%2Fwip%2Frebase--keep-base-tweaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1323/phillipwood/wip/rebase--keep-base-tweaks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1323
-- 
gitgitgadget
