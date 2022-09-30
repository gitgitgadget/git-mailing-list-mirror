Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD36EC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiI3OK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiI3OKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702037170E
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso5124486wma.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Bi2Spf34nGZiSZnHsAWaPYLa1iXdjZ4bifCHM5+qzio=;
        b=JN1ApLrZQ/RAMwDlMMwJO/zSFo3WAaJkbystn6BH/A/SvLoyVHiGDrzGwvy1JoIZaX
         MyoNGbOs5X9bBYnuxALvvOcqL5X4k6wCMeawhqUO+gg4Dl5n3HtXk5Q0YB6ZoRlFYjqM
         ZRRcm3PUCd+R7kClF8vUvTimeolEOxyfpRKsRvQhqUydB6lrkwf5h2Cna6oRL11tjJTl
         t4VnPF8Ajc5l6REgsQUCfn4FyN58UCyp+OgPvlmc0JoiQtiEnon4TqCID23flJn3AvbC
         Krw/AIZe94ISnL7MweAk+7JXG0ggjJPX80vRB1rDhr+qSfH2Yh3+7GxoezfrZY0aMsve
         +8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Bi2Spf34nGZiSZnHsAWaPYLa1iXdjZ4bifCHM5+qzio=;
        b=TCHL2f3IHtvUr8el6SlPI198dSgXRE1EKTvhLMmflMe8e+Grrxk/mhgZ7yIptQcFTw
         h3CC01fv/YX87So3qwahbX3nd6+2yagc1E2nVMkyb3LYIXDdm3CL/8AIVUlIL+U9fH8S
         CtZKE3d8eZELkUzrGkIY8Mp8cVpOHgw26IDk0aSChucY1MNIyAOAck5BcYpwTliAyAyC
         lY9XgCGgT41bcKqNB079shoEVUKTFQqi8lX/yITWxBYeay7u4c2X+jTka/LjghkSaX8s
         8ADwdv1RCNMEiCWo+mbWao7/jdFrLMwUowQpn/D/7qe7a56LQ/VgC8RpZyhCe8o/a34p
         cC/Q==
X-Gm-Message-State: ACrzQf1WoP+/NpO7Jcgk77BQoMC2EResmcYblWR10Ka9Fh8RMUAmiBY5
        V8UBzQYbdJ9D2+ndZ7H1v2FnAluSkvM=
X-Google-Smtp-Source: AMsMyM4gmdTMSlJXVNo1yETpCy/HOmzTpeKOQDkUHUgeU1R4OPlkdXzjXrXJzFbrLDf4crPuz5u3cg==
X-Received: by 2002:a05:600c:2d09:b0:3b4:7ff0:ae89 with SMTP id x9-20020a05600c2d0900b003b47ff0ae89mr5905123wmf.163.1664547014116;
        Fri, 30 Sep 2022 07:10:14 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d45c1000000b0022ac119fcc5sm2117911wrs.60.2022.09.30.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/6] rebase --update-refs: smooth out some rough edges
Date:   Fri, 30 Sep 2022 16:09:42 +0200
Message-Id: <20220930140948.80367-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of cleanups and fixes to a new 'git rebase --update-refs' feature
introduced in the current release cycle.


SZEDER Gábor (6):
  t2407-worktree-heads.sh: remove outdated loop
  t3404-rebase-interactive: mark a test with REFFILES prereq
  rebase -i: emphasize that 'update-ref' expects a fully-qualified ref
  sequencer: avoid empty lines after 'update-ref' instructions
  sequencer: duplicate the result of resolve_ref_unsafe()
  sequencer: fail early if invalid ref is given to 'update-ref'
    instruction

 rebase-interactive.c          |  6 ++--
 sequencer.c                   | 28 ++++++++++++---
 t/t2407-worktree-heads.sh     |  8 ++---
 t/t3404-rebase-interactive.sh | 64 ++++++++++++++++++++++++++++++++++-
 4 files changed, 91 insertions(+), 15 deletions(-)

-- 
2.38.0.rc2.542.g9b62912f7f

