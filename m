Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74378C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E95661B3C
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhJBUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUSI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:18:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7007C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:16:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o20so3528471wro.3
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTfaFzR3PcJ8ud9tTCLMiG6jHBoXBBj0QEOtpabXPK8=;
        b=mlxsPX2CgPwo/yWf75x3Y1ZgQepvM8LYki7/iLek4A4kU7frLGjJxEocpiZcGsxdxh
         CkOak7+Ia4FOQyWh6qxL2VilvidCwxklE8rk17OZULCMu59rDeStfVG8GaCS9yPSyyGB
         /xzij4EgGV81jZh0m/GtTN0VsoILMKPR1K1STlnoUAR7RWfWcuuzmhBl63GJVQnqW3+O
         p9dSHKj9hYbTzjG/Q3I+Wy09ntyaypuPUH77gxL9KP+XnJVM96pa1aaDcnLWYhyzwpxr
         fBbeWB4QPe4EBFyuyOrMZKCrKuFCp7P2fSfwKrnSGOwmi1s7zmORICLkHBhfieyc94yR
         IAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTfaFzR3PcJ8ud9tTCLMiG6jHBoXBBj0QEOtpabXPK8=;
        b=OqW9mJZlhUR+CTHMlfgfFkIOdkLiRJnT6HeCIM03Uv5gqcTC+d53ZcjYV+r3qAKeCB
         fZ0z3YwPkqjl7ARmM6O+41/5kEUHGiNOnv8N9GC0//ut3dWnh5GJoVJ/uCwFWToiWLBG
         5JSBBrHEqyoMo48ksER9sWFHur9oy4fH2jTcfFWr3QSLGoR1fEI5FJEKx+iaptLpkw+X
         n6oXLpyg6+K2x3CP3X7UCg+mya0rNFIcQlqN41vinuPdD4TiQOGnVmC74UO/eY031INj
         jbOHnDdbFm2At6ERYxm8U+ZtN9VaYL8Ol5EwaCyWcNBkaO72DX+FXqgUghQ4Zeb72BVD
         iAWw==
X-Gm-Message-State: AOAM533TW8JENUGLTVniVihbFGUu3vNusooNh7mKCBnEPjxHW/0FPDD7
        R7l+Cn5iSau1tQ0wGoP16yfxHZKaHrEd8w==
X-Google-Smtp-Source: ABdhPJyI3WB8UWs+MMSElOQPdNXdL2bi+HHJI2ciOXbI8BnIX2lQ2nmVvLu3g6xFeaoORJ+t9heTZQ==
X-Received: by 2002:adf:b350:: with SMTP id k16mr4895482wrd.368.1633205780039;
        Sat, 02 Oct 2021 13:16:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g2sm9946009wrb.20.2021.10.02.13.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:16:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] Non-trivial designated initializer conversion
Date:   Sat,  2 Oct 2021 22:16:12 +0200
Message-Id: <cover-v4-0.5-00000000000-20211002T201434Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
In-Reply-To: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See
http://lore.kernel.org/git/cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com
for the v1 & goals, and
https://lore.kernel.org/git/cover-v2-0.5-00000000000-20210927T125715Z-avarab@gmail.com/
for the v2 and
https://lore.kernel.org/git/cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com
for the v3.

I ejected teh "UNPACK_TREES_OPTIONS_INIT" patch. I'll just propose
that as some alternate/fixup for en/removing-untracked-fixes
instead. It makes more sense as a lead-in to wider unpack-trees.c
fixes.

Ævar Arnfjörð Bjarmason (5):
  daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
  builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
  urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
  builtin/remote.c: add and use a REF_STATES_INIT
  builtin/remote.c: add and use SHOW_INFO_INIT

 builtin/blame.c  |  30 ++++++-------
 builtin/config.c |   2 +-
 builtin/remote.c | 111 +++++++++++++++++++++++------------------------
 credential.c     |   2 +-
 daemon.c         |  19 +++-----
 http.c           |   2 +-
 urlmatch.h       |   4 ++
 7 files changed, 82 insertions(+), 88 deletions(-)

Range-diff against v3:
1:  8f3f3f97fcb = 1:  8f3f3f97fcb daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
2:  ced1d581f15 = 2:  ced1d581f15 builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
3:  266948e604c = 3:  266948e604c urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
4:  41fcb0a45e5 = 4:  41fcb0a45e5 builtin/remote.c: add and use a REF_STATES_INIT
5:  25fec54877b = 5:  25fec54877b builtin/remote.c: add and use SHOW_INFO_INIT
6:  18358f5d57a < -:  ----------- unpack-trees.[ch]: define and use a UNPACK_TREES_OPTIONS_INIT
-- 
2.33.0.1380.g193143c62ce

