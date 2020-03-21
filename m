Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7222AC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336562072C
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 10:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw039LWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCUK3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:29:34 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:45446 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgCUK3d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 06:29:33 -0400
Received: by mail-qt1-f169.google.com with SMTP id z8so7327072qto.12
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzB6/HJuYK5r8TEpEKxzD/KKVkrA+rLtJBe3VcWCVmw=;
        b=cw039LWRK0sjoP6ietTtISLsg5sG0P7tiv9f8Qr4CfIcJQnVbGRu0/KAVwn88m9RDl
         st0U0CA4CXOfL7LfypY93z0VJ0WljW7LPFFa4BDJr3bINRbPzvoqRYeUbPjo2apgNFzl
         WWH4LaNrP99S0wyZWmL2q+Veu7vAKtKMp2QooM4Dx8Mm7xcTaSBbfkAJ1QgBv8XXd4+e
         LJZXNEnSzNoO4dQ4ghjtYUUQgo0ikp5M60FSJyXGIAPiuFFQAf7bcj+WhhyPif00ejoT
         PFAeSOi4jUHncByhMa1kt34sNJfZaVfpnTXqMOAPFpcWiy35Jv9CwvPijXVBT9sqmNkl
         +dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzB6/HJuYK5r8TEpEKxzD/KKVkrA+rLtJBe3VcWCVmw=;
        b=SPSdHrHJktm/UaIu+GeLGUncT7EuaEq+zDwvOK/5qMuMXO1wLC/22qY7Cl/X8RncVS
         CSlSUskfCfoAWi7YrdIls2nQFRLAm8wvGJ2C91eUnoMEcedAZMrRziKBogi6MoX1ekZF
         NTyMmz09V+K+stOP6VE07bUXJalby9wEUGUSR6RnePCHKSq6bhtm+i1vFuOtt55M1IkK
         YzFx1oMiMyW9RKIFzAyHCnqX+yvCHW64FavWNUJj8YUrWY6sXHx1BJfx0qvC2wGwTGQi
         b5Sd8D1k2SInjpYtNP/HpnoyhipMyn47phNDlRqEMKBXCLLG+cgP+bHzQ7NV6a0SF/pu
         QmDQ==
X-Gm-Message-State: ANhLgQ3LnO5HNpaanPrazqmnhaInM3z/MnbLuoWdBFWAN8OUz0tEMZYO
        ulwomQUd4fQ3ENaEmzIZiNPe19/3
X-Google-Smtp-Source: ADFU+vsZMBY9iwdXtNp0WLCmJX9d/YayzP1Ndol436hPVjudaD0E56k6uK/Yha5IBzx+mS4+81qYqw==
X-Received: by 2002:ac8:32f2:: with SMTP id a47mr13040685qtb.62.1584786572455;
        Sat, 21 Mar 2020 03:29:32 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id m92sm7101517qtd.94.2020.03.21.03.29.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 03:29:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] Lib-ify functions in builtin.h
Date:   Sat, 21 Mar 2020 06:29:21 -0400
Message-Id: <cover.1584786523.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In builtin.h, there exist a couple of functions that are very lib-ish.
Extract these functions into their own files which should make more
organizational sense.

Denton Liu (2):
  Lib-ify fmt-merge-msg
  Lib-ify prune-packed

 Makefile                |   2 +
 builtin.h               |  16 -
 builtin/fmt-merge-msg.c | 655 +---------------------------------------
 builtin/prune-packed.c  |  44 +--
 builtin/prune.c         |   1 +
 builtin/repack.c        |   1 +
 fmt-merge-msg.c         | 653 +++++++++++++++++++++++++++++++++++++++
 fmt-merge-msg.h         |  13 +
 prune-packed.c          |  43 +++
 prune-packed.h          |   9 +
 10 files changed, 724 insertions(+), 713 deletions(-)
 create mode 100644 fmt-merge-msg.c
 create mode 100644 prune-packed.c
 create mode 100644 prune-packed.h

-- 
2.25.0.114.g5b0ca878e0

