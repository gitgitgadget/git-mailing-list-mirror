Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C369C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356654AbiFVEVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiFVEVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:21:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2B117A
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:21:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w17so21569380wrg.7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QeJs9HI0zDrU2aqaAUtfKUsamYQ2+rST9RPPMuset3M=;
        b=NsmaQjj8/w9tCNVpAfahmbsi5XJdvs+pr8u44qQzgY//ei9KvYHfXs+8rXuYPp2wcV
         m6IT5kBYlwP09kwrBgqNs8M9Lxi+E4b9g6/6bDGTNBL4h4MtSji1TkePzRvVHooxj8Ws
         2OMjsRpZ44XMEbunheIln46o/14JwMq2Kkm35aEz7NdEhzE6Kf/1WH2fdBF42Fti+ITb
         txaeVh7WaoLONAaInGiZY8FD3br2PiNu2/CluVgrkn3hvH9lbZqSx+oyyNWqS6MECrKs
         u2H1LiqaEtD8aD6zIeTRnwCiexRSN8vEqBfI1Un+BS8QtITqRbO/pz5OtDQDQu5MCTlg
         YJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QeJs9HI0zDrU2aqaAUtfKUsamYQ2+rST9RPPMuset3M=;
        b=rL5HSyzDgr1Axwk8wn05lG0Y+sn9k1kWX/6Pfu+eit0BrxlNBEvAdqLNY+Iclq6xlo
         0eWgL4RcQ71NLH22qeWK1l9FWyJbqd2U+fRMM4+YSF76h7Dw7VT/QTh5TdTLAz9o4i62
         drhK4/+f5ZuWBnfZPGx4AvCTXbmDnEqn8o6mjDtCSDB/y/x2i1jPigpJyhjLijadcOwt
         lzSbd6MJnN74J5ZmQn7CIFpSlDgLsWfK9PVUM7+nPBQYnOez3/IcZ1mHEnVpI2E/Zllq
         Eyz6xplEuBmRU0cjVxxbL9IIZgK1ZcDc8VkXqydS8Q2C/CQzg1AkLpiQOWWmRWziQM4h
         cHKQ==
X-Gm-Message-State: AJIora9dAOWSHTxeWvUKxM0Q09GEc4HehcQK2Dixn8MATt5GFmP7N6Ux
        MFnkc1JWURF3UuhK+bLEgo71aVgIXRb33Q==
X-Google-Smtp-Source: AGRyM1ue6kMwisH4sHqR/twiuMF+22GHEF1AXa39aReRLQ6QOT/b/OfX+2qU3E8IOwbz9zsSCYS5Gg==
X-Received: by 2002:a5d:64ad:0:b0:215:c26f:f53c with SMTP id m13-20020a5d64ad000000b00215c26ff53cmr1153669wrp.22.1655871670059;
        Tue, 21 Jun 2022 21:21:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b0039c5b9e9142sm20638282wms.17.2022.06.21.21.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:20:58 -0700 (PDT)
Message-Id: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 04:20:48 +0000
Subject: [PATCH 0/3] Fix dual rename into each other plus conflicting adds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds some testcases based on the tensorflow repository issue
reported by Glen Choo at [1], demonstrating bugs in both the ort and
recursive strategies. It also provides a fix for the ort strategy.

[1]
https://lore.kernel.org/git/kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com/

Elijah Newren (3):
  t6423: add tests of dual directory rename plus add/add conflict
  merge-ort: shuffle the computation and cleanup of potential collisions
  merge-ort: fix issue with dual rename and add/add conflict

 merge-ort.c                         |  60 ++++++++++------
 t/t6423-merge-rename-directories.sh | 102 ++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 20 deletions(-)


base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1268%2Fnewren%2Ffix-dual-rename-into-each-other-plus-conflicting-adds-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1268/newren/fix-dual-rename-into-each-other-plus-conflicting-adds-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1268
-- 
gitgitgadget
