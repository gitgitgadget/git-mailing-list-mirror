Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D72C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAC561029
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhFHMSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFHMSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:18:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5BDC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 05:16:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so1701138wmq.5
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U79hGVWsg4tt+MILSS577hno0S+wqh2CBgHya2eU0oI=;
        b=TZTrWi2StFPzE6slNBGVFjRp1fDlyzCrBH7sNsWUCVJZOx/3tIGbH46Rw6eqtYG54J
         dhVoVNrMhMbM8YHzhUt1FxzdmK2Ew8u4aAUlAjfZ/luAlL4WXTuPqDN3wCF/pMSvFxud
         HxwPOgC1lunUyuPtZK3g/X11oGMiWjZknnnAxSV2cEKUqsVrf9xrLtuTMzMM9S4NW3uP
         /VmVlckc8V35u9Z6b6ik6v1XFFk0++Yx/00mrAQXFYofmGgtNyePzD3va16YnbbvK//3
         9Zs3Ya0pvTV5gvZw6lRsfV+1pTzj5w07ZdAIbVpHaHvimZu+cIcDXjo8YGVrIzHfIuqH
         QyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U79hGVWsg4tt+MILSS577hno0S+wqh2CBgHya2eU0oI=;
        b=YVca9tmeVmCNPLFOkSyop1llEUErBYiiHWnpRD/G8IVhpGJ/RYX7jhA5X2Yx5awflC
         noNoQ4R7Xg0Vh+4hdupy378IuDyA6m5B3ewECxyYvQZ/mLqveV35E7AKt5BrNI0/7q72
         xsgcNtHrsptTm09qkctFx8u0fEED9ammsEolkyoB7/8Syb97xdtvOJu3eQ6b3rHFg6va
         Yf6679PYmDlOGnp2VM8nHibfOsCTpP7hZuzJuhcIGVXJjyKCTVkxU+4nY5OJ0riyob/2
         hk2gp6MuCgTX7ddfwT+fcpcbQkN5lhClUQaJOdDYQ4vBge7xdLDkutfzdsXqq6KJpqEw
         Hn+w==
X-Gm-Message-State: AOAM532I5CuKfmreQOcOsFPNJN8N5MNu32OfRmyOwYwHbAFUOIw1LRAJ
        ek9fVZagEbGteNqN3kOcsZGs/tdKNOP3UQ==
X-Google-Smtp-Source: ABdhPJwdb7zq+gRd0V3fSN+mmgFmo9OHpyT/XWwM62/N+EeRr3kWfNVg+ZJE2P+Q3ICRoXODWI099A==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr21374842wmc.127.1623154597554;
        Tue, 08 Jun 2021 05:16:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20sm12976378wmc.39.2021.06.08.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:16:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] pack-objects: use revision.c's --stdin parsing
Date:   Tue,  8 Jun 2021 14:16:26 +0200
Message-Id: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision.c handles the --stdin flag given to "git rev-list", and
various other commands use it to take rev-list-like arguments.

The pack-objects.c builtin made use of the revevisio.c API, and did
mostly the same handling of stdin, with a couple of minor differences.

This series extends the revision.c API to be flexible enough to handle
the pack-objects.c case, and moves pack-objects.c over to that new
API. The missing piece was to allow the definition of a
"handle_stdin_line" callback. This new callback allows for either
partially or entirely consuming the stdin before handing it off (or
not) to the revision.c logic.

I'm planning on submitting another series on top of this that'll make
further use of this new API, but wanted to send this part as a
stand-alone series first.

Ævar Arnfjörð Bjarmason (4):
  upload-pack: run is_repository_shallow() before setup_revisions()
  revision.h: unify "disable_stdin" and "read_from_stdin"
  pack-objects.c: do stdin parsing via revision.c's API
  pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS

 builtin/am.c           |  4 +--
 builtin/blame.c        |  2 +-
 builtin/diff-tree.c    |  2 +-
 builtin/pack-objects.c | 64 ++++++++++++++++++++----------------------
 builtin/rev-list.c     |  2 +-
 revision.c             | 35 ++++++++++++++++++++---
 revision.h             | 60 +++++++++++++++++++++++++++++++++++----
 sequencer.c            |  4 +--
 8 files changed, 123 insertions(+), 50 deletions(-)

-- 
2.32.0.rc3.434.gd8aed1f08a7

