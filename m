Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B4C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCLUJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjCLUJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:09:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B118156
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:08:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e9-20020a056830200900b00694651d19f6so5679110otp.12
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4I3psHM3w8JcpUtMWypHP6Ez5npDIvPAF/XvjeuLWVY=;
        b=otU6/FHbev4BeFhGl4CndBb9CL6+gF294CCQ3wvNF/A0fso2i0u4nGRrMGUjG28J4Z
         YZX+CABf5uxPu82jmsPW/CSYjiCg7D1fSRNXsh54EsT9AfJAiBIKJNwSGoHCcVlMrmyT
         GCk37Ju3fzrKcSxbBLQaizU+kqvHDcu8Mejvy5FEzOONJjFjwJcAurd96nJl3zSIzYkj
         pHE+AOGO9fRh/fIFjRHgtigZYCufr8UyqBGAEKjpje064oCN1INj/aSYfr4sXVNdSs+u
         v9eAKDnRhix6mzhXpawNjTKVdj2LNg13CeTLnGbUJ18GOmwnEwOwgaaMEVd5Nk4v1ou6
         nnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I3psHM3w8JcpUtMWypHP6Ez5npDIvPAF/XvjeuLWVY=;
        b=jZdpXfVaiKbTGJJlTQZ5L1Pxx3YGYG+Vw52F3i41tIOxxEcC6uS5sxer5FWFAHoEmp
         dbiZXNAEk+phE8W9E5LQn6lauc1bOz2/LAt0XC/i321eq62aWC16qobOjzPzTzmBjWho
         6FJfbo8/vlcvA+qp+x301B/I73bi5PZY/NXd4MSaOLHIfWdAXxZPC/Vl8Kz1P04/tQmS
         fcNhlmmxm1WE95BP35jiZiU/pKLaHOrxtfgqWg32HEpuem9zIY4Uf6pwQdT/ndmOs5pW
         4b8SMcS+O4IcoiKQ1smxhyx4k7JFsEcmr6uFNxBY5dp2h+Z5glI7N3qD/xh+OaM94sWX
         sRig==
X-Gm-Message-State: AO0yUKWkv3ZgEcCAVcoFspJQSVf2JiXr+2LdFcy7RNQ4Lz0xpeiujTFF
        b7+bnohCJHqLBA32K6OWb+/uXN3ZTWE=
X-Google-Smtp-Source: AK7set8oJXWpqgN7041G++Z9uReOkYpjdtcxbiECjeNz81VK65/e0sBZzadL/1utevOU6AYo9PssFQ==
X-Received: by 2002:a9d:75ca:0:b0:693:db45:8b71 with SMTP id c10-20020a9d75ca000000b00693db458b71mr15606411otl.8.1678651737615;
        Sun, 12 Mar 2023 13:08:57 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g37-20020a9d12a8000000b0069417e65acasm2474694otg.45.2023.03.12.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:08:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] perf: fixes and cleanups
Date:   Sun, 12 Mar 2023 14:08:51 -0600
Message-Id: <20230312200856.323688-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just for the sake of it I tried to `make perf` for the first time and it
didn't work. What follows are some fixes and cleanups I found along the
way.

One problem should have prevented this target to build since six months
ago, I'm surprised nobody has seen it. Maybe more people should try
`GIT_PERF_REPEAT_COUNT=1 make perf` just to make sure it builds.

Felipe Contreras (5):
  perf: sparse: remove grep --sparse option
  perf: grep: fix prereqs
  perf: grep: don't check PRCE twice
  perf: grep: avoid unused prereq
  perf: aggregate: check if subtest exists

 t/perf/aggregate.perl                  |  1 +
 t/perf/p2000-sparse-operations.sh      |  2 +-
 t/perf/p4220-log-grep-engines.sh       |  2 +-
 t/perf/p4221-log-grep-engines-fixed.sh |  2 +-
 t/perf/p7820-grep-engines.sh           | 11 +++--------
 t/perf/p7821-grep-engines-fixed.sh     | 15 +++++----------
 t/perf/p7822-grep-perl-character.sh    |  7 +------
 7 files changed, 13 insertions(+), 27 deletions(-)

-- 
2.39.2.13.g1fb56cf030

