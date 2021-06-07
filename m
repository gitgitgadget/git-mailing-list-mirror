Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69780C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B28611AD
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGMBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:01:38 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36722 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFGMBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:01:37 -0400
Received: by mail-wr1-f50.google.com with SMTP id e11so7074853wrg.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uc9IJNVabms0ouZMd0ftIir+5lEUuEvF1t4TQjniP6A=;
        b=s2oi3KbmgSNvNpIGm2PJFyoP2dzOJNumot81FjN0PC8GkQbuHIm6Gvnb1m0AeDC8j2
         DE04PqSwLrnnOn6lKEIzrSYFpSBICD9TGSs+bsIfopCh3cdbC2UvlqMPukE3g42jaP0x
         b2mRJhql8yT1lq1AAHA8uyTiuQCyYuvQI4aNBgoVk28ZYRujwU1z8yMO9r1fugtRIluY
         6Tig740bTdp31z/MvDNYyEPmjelupcdPOO/U5nCg6fhs1cs+g+g/W74y0kwRk0O6JMNG
         YrxnxXIsqpl1qST9tNEdx0sqjGiGFD+B96yw6bvLD7kFco4y/6So4ffDJnDYzYnGeB02
         tCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uc9IJNVabms0ouZMd0ftIir+5lEUuEvF1t4TQjniP6A=;
        b=jldCrvQTcb9zDybL6uQlFJRt8sPlraS3OpYEFRKjkQD4VL9j9qL4NK/aXsg2xbG7jO
         5oyavsMr4+LPBTnq20FngFt+A1NEoh3E6zaNhtNZzvet2DpSPlmEtt94L1VNIbxaYl1a
         JiIMBA7GMvWxKHYHnukTk5CEzpRXWkhpzMx+cJT8NWUAwBB/kaEZ8U6Z2KvoeOVRVVC+
         Ae69YuCe2Cgh7cOk4OtNfr0EbwGk8qaARGteAr0o4ByVbYnW3X7HbM+SaQh/R8vBory1
         2/fLDcY9jlekHXjdIrvxwO8B5Gq8dQKxXMBbSkYaahS9ECvnzgr2z07KGUCU8Ff8oL+H
         CpSA==
X-Gm-Message-State: AOAM533TVWVls8XBB8VKqSIXQvuo+W5jk2eXfmhJS4PRr9X5QpjbA28J
        U8nR3B8TglvuBEH91DEd8rfZ999Ns1AOvQ==
X-Google-Smtp-Source: ABdhPJw8Yqxw4dSagux6vA8D/i3ebFh+SqL/PVwix9iKHqJ1bxkGxn31exe6BG13BGCqgFeGyYHwhw==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr16591536wrp.147.1623067113166;
        Mon, 07 Jun 2021 04:58:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 92sm17215166wrp.88.2021.06.07.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:58:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] test-tool: split up "read-cache" tool
Date:   Mon,  7 Jun 2021 13:58:23 +0200
Message-Id: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the sparse index topic was being discussed I suggested that the
t/helper/read-cache.c tool was getting to the point of doing too many
things and should be split up.

Since that series has landed on master here's that suggestion again in
the form of patches on top of master. The 4/4 patch is a "while I was
at it" addition of an extra perf test for index refreshing.

1. https://lore.kernel.org/git/20210317132814.30175-6-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (4):
  test-tool: split up test-tool read-cache
  test-tools: migrate read-cache-perf to parse_options()
  test-tools: migrate read-cache-again to parse_options()
  read-cache perf: add a perf test for refresh_index()

 Makefile                         |  2 ++
 t/helper/test-read-cache-again.c | 47 +++++++++++++++++++++++++++
 t/helper/test-read-cache-perf.c  | 47 +++++++++++++++++++++++++++
 t/helper/test-read-cache.c       | 56 +++++++++++++-------------------
 t/helper/test-tool.c             |  2 ++
 t/helper/test-tool.h             |  2 ++
 t/perf/p0002-read-cache.sh       |  7 +++-
 t/t7519-status-fsmonitor.sh      |  2 +-
 8 files changed, 130 insertions(+), 35 deletions(-)
 create mode 100644 t/helper/test-read-cache-again.c
 create mode 100644 t/helper/test-read-cache-perf.c

-- 
2.32.0.rc3.434.gd8aed1f08a7

