Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A75C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85C56139A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGVMOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhGVMOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37045C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so1485007wmh.3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuVtsOO4hnTD3vqopvQUwXw3S4SfppFmBrouTaqNnU4=;
        b=fUFmheeeTp7pc28NkkZcZzzKewHWbGCE9A/sr3gnwyiRF2yZ03+/xaLAKxfn0kMl/8
         CRMkMXj3WY1kgrnQ0NKTd/xVdLkRIvdH3ehZqh2gt++C4RFNZ9PrH98pabw1A8MS2yWj
         bACbywVd7K1T6HCwaIeUYLtGTL5l9jicCG8tRsEB0Xx1idx794l4TiyERGm9Z+Cx4tmf
         tpRCNG4m79aUU5uH+r0XiFm/WliiweiwP56CHgRCmi0Lsnqof0TP/VEJyD7dd5PqVj6M
         lSNGrSTUUNFHN6oEdS1T6tIxv5/Sk1jMgc1280IUTzx/FTeX5XiLEw/i0gTBJ7TYerMF
         5jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuVtsOO4hnTD3vqopvQUwXw3S4SfppFmBrouTaqNnU4=;
        b=GveXtTYxL5Whs7/rpqCLp7yYIld+1v7Cneq/lMdxMzSLRzyX77/qyq4VVIsp8abFQR
         Z+65ob5kLKeOdwkKBenJZVDfFaz3LFU8dknm+0Ss6BrS4jAmnPDfCGcbUSMN1k4ziEUA
         V2kKRVZUCOgf4piQYDbgSHP5ZhytllB5Ok4ich+0d07qHdCy0FOAHSAOmkJZDAXmoTh3
         RcqPzX1sv6TJE1HcWa/iIROgbocgohrR2i2jAxtWPFsRp8ZXuSZsjszyR4BnvcNgew8j
         51krCAWtoChkKRc4x9kBGSWiNe992Mp/KFFb7J2wq5QGMOY25H+WPPO7tmUbqXLwAtUj
         CpWQ==
X-Gm-Message-State: AOAM532oSEgKnEQEDOdEd4KUvGSRIjcw+3S23FtSIi9Sc1MXEWGMJxWM
        OXw82GndMGW9k2UtAi7PIvonVmp0D+W7rw==
X-Google-Smtp-Source: ABdhPJwX3XiSyAaIL9otKWthgCn2Dpc8O5xUxLZ2eerKh3LQvPE4+213jqmDLfLeoqNVISfGKkDfSQ==
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr8909428wmq.62.1626958509553;
        Thu, 22 Jul 2021 05:55:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] progress: assert "global_progress" + test fixes / cleanup
Date:   Thu, 22 Jul 2021 14:54:58 +0200
Message-Id: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches were originally submitted as part of a much larger topic
at [1]. The add a "global_progress" "struct progress *" which we
assign/clear to as we start/stop progress bars.

This will become imporant for some new progress features I have
planend, but right now is just used to assert that we don't start two
progress bars at the same time. 7/8 fixes an existing bug where we did
that.

To get there I fixed up the test helper to be able to test this, moved
some code around, and fixes a couple of existing nits in 5/8 and 6/8..

See also [2] which is a re-submission of that larger topic, but the
two can proceed independently.

1. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  progress.c tests: make start/stop verbs on stdin
  progress.c tests: test some invalid usage
  progress.c: move signal handler functions lower
  progress.c: call progress_interval() from progress_test_force_update()
  progress.c: stop eagerly fflush(stderr) when not a terminal
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: add a missing stop_progress()
  progress.c: add & assert a "global_progress" variable

 pack-bitmap-write.c         |   1 +
 progress.c                  | 116 ++++++++++++++++++++----------------
 t/helper/test-progress.c    |  43 +++++++++----
 t/t0500-progress-display.sh | 103 +++++++++++++++++++++++++-------
 4 files changed, 178 insertions(+), 85 deletions(-)

-- 
2.32.0.957.gd9e39d72fe6

