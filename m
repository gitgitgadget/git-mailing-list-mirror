Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA2C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiHCEvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:51:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F9FE26
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:51:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y15so15334627plp.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3xFq11mYsOa5n/vqJrs/GK9AwSqMXJuxwwrXIHqc88=;
        b=glA2IisI9vQHEQZJIcKzUxwi5EOKBJb4Awo4rZGz5fQZaXgDo33H6dfP7y+5tN6TbF
         vGwZ35vfrp3G26jl3b4et3zoHrGKgoAr07j/vJRxPVRQ6WLpR6L3RcaHDK+7JeJIK28r
         B/jFmf1ASkr7gUWEHcNlmNG02D2z9v1FQ/0ev7e2X0f4G4IlM+MKBTdACS+HzleW/4xf
         9A3he2EbKFNcgqbWGq/BBf00CR+L62WmkhhoziWieIUixft59NTVXY1eMQdJc1ggniid
         1sVvJZGWyAyA28S41nT8mx08fP/nKDYk7L9lSEqdQY611F1p6wlTZSmMqB5snifDbe1c
         y5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b3xFq11mYsOa5n/vqJrs/GK9AwSqMXJuxwwrXIHqc88=;
        b=VD3L7Xnn1LF109Kg/dVHNPbG39GMQGbMizcCFFrPvmdQcMk3Te9bOVRT2H/pbAgP5R
         GY7JTqmnXAiLRoDCWfvFRvGOy79aQRykinDRXiiz9upYl9PmmAB3+N7AOjZGg6ERNViF
         5vzr/1GiGD6AyiRxTACsTGJie5azltalZw5MKy9YZS+VVfpIfpTkWiFjoLBOy9skXYFw
         FDcvIAS19TtuXacoGUOR4/QRWJ4vEXzXyCYRlTO0nk4YvZB5SfzXE98MT7PkmnVdOpyh
         dg+QpwrATAtZIiEVfl+GwEZR52eZXcpwrEgcgBhxy8IKk4GYiKrZ7b44XDrB4x0Sz0yV
         W+Tw==
X-Gm-Message-State: ACgBeo0bLlBQiOpXYc9FoHKyCIoxVa5QdsvJlz8MVbF9dUXSqU1+T4Jh
        DW0P4ayv0YPAQDXwMBSXLQ+A2i02Poz+ys+3
X-Google-Smtp-Source: AA6agR4fQenXt1uihoC8uvHAO47LoCDWaFZFAfRiHikMwZtSyH6ZMWG2Xzk9JvOztxyvVUU3Y11wTg==
X-Received: by 2002:a17:902:7c0d:b0:16d:500b:1255 with SMTP id x13-20020a1709027c0d00b0016d500b1255mr24984912pll.98.1659502300016;
        Tue, 02 Aug 2022 21:51:40 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.71])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b0052e2a1edab8sm470211pfa.24.2022.08.02.21.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:51:39 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 0/4] rm: integrate with sparse-index
Date:   Wed,  3 Aug 2022 12:51:14 +0800
Message-Id: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turn on sparse-index feature within `git-rm` command.
Add necessary modifications and test them.

Shaoxuan Yuan (4):
  t1092: add tests for `git-rm`
  pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
  rm: expand the index only when necessary
  rm: integrate with sparse-index

 builtin/reset.c                          | 84 +---------------------
 builtin/rm.c                             |  7 +-
 pathspec.c                               | 89 ++++++++++++++++++++++++
 pathspec.h                               | 12 ++++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 73 ++++++++++++++++++-
 6 files changed, 180 insertions(+), 86 deletions(-)


base-commit: 350dc9f0e8974b6fcbdeb3808186c5a79c3e7386
-- 
2.37.0

