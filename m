Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740CC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51451600D4
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbhGNASl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbhGNASk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:18:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CCC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso2545119wme.0
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdDdcSIlBaVjBIYUujz1lNo/acIEwaq+qx742FsBxbY=;
        b=vSE0QeTZb8dj2OLBarelPVkLQFy+JTn/sVYdfrQg2CojZfri5249zgFZHeTRXH0Z9+
         1oi2JYS5BowAo9aAsnqrk4tEjJ33pnA2I4GdfLXXYwtp7VHpYGzWMxnNa/B5jkvVuhpY
         LMBoSqz0Yldt3xr9T+dkR7NdbLGhysLru3Q3IHu9bod3tYoag/R8JP+idI5mG6m47Tac
         t4cac8scJL3KfkZTwb3Bu4niIf0pd+Dzlzj7X7UQPMp3KfWgu+n0mqAXCATbuV1Dt6SO
         KZk1FpT0EzwYwZv//L91vu+2Tcm6kqCam34wXyDXesiJEnycEIQPPfb5kr79/3AvFwUk
         tUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdDdcSIlBaVjBIYUujz1lNo/acIEwaq+qx742FsBxbY=;
        b=cW9EvH0D7DxkVHiapa1rGS1Md4+NNrnT7oFxuUyYqILb1D0wci0OdFgZlkSnkiohhJ
         E/RX+kjYcwyxrVUMLUraAEL5EdAPC2emPBq6nMUbAx0rlBHlPWeuu8wz9kqj3V20Iv93
         eM9t7cEuHYee1DRHQEUV1ARVSW2Rmz90+cBnX1p9iGOsnEYP8cHcxSyvwUCswMaTX4hg
         g7Qe58blOzbTZUMMWSHRE6KDdrqx1GXzjlZjxedJsH0Le7XgX3JNT/yMlgcRVnmoKXCd
         uOVkwcsCNcaL+CVK+fbccyvymGczVSkluIq05SJNCfSuNbvKtbogcp/Hr+P79kYBTWqX
         x6ZQ==
X-Gm-Message-State: AOAM5329mUhqwdIQhY8PmBLgUn5/vp54TXESg/5CFz6LUgnp6f2Zhz3X
        GFkWmHFqnPtvvGJyrvcUhDKvq2UvXjd2okT/
X-Google-Smtp-Source: ABdhPJy6++lMXR2o5ArMkU4lS/E7y2T0j0rjzQOUleYTUoC50cMhIabs9vaFN4+UGtzv+/pQJduClw==
X-Received: by 2002:a1c:1bd0:: with SMTP id b199mr7798392wmb.108.1626221747454;
        Tue, 13 Jul 2021 17:15:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm2876518wmc.7.2021.07.13.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:15:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] add missing __attribute__((format))
Date:   Wed, 14 Jul 2021 02:15:39 +0200
Message-Id: <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds missing add missing __attribute__((format)) in various places,
which improves compile-time checking.

v3: Dropped the 6th patch per feedback from Jeff King. Yes, we can do
without that strftime() comment in strbuf.c.

v2 at: https://lore.kernel.org/git/cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  *.c static functions: don't forward-declare __attribute__
  sequencer.c: move static function to avoid forward decl
  *.c static functions: add missing __attribute__((format))
  *.h: add a few missing  __attribute__((format))
  advice.h: add missing __attribute__((format)) & fix usage

 add-patch.c                                   |  1 +
 advice.h                                      |  1 +
 builtin/am.c                                  |  1 +
 builtin/bisect--helper.c                      |  2 +
 builtin/index-pack.c                          |  4 +-
 builtin/receive-pack.c                        |  5 +--
 cache.h                                       |  1 +
 commit-graph.c                                |  1 +
 .../osxkeychain/git-credential-osxkeychain.c  |  1 +
 .../wincred/git-credential-wincred.c          |  1 +
 gettext.c                                     |  1 +
 imap-send.c                                   |  3 ++
 mailmap.c                                     |  1 +
 merge-ort.c                                   |  1 +
 merge-recursive.c                             |  1 +
 midx.c                                        |  1 +
 quote.h                                       |  1 +
 ref-filter.c                                  |  1 +
 sequencer.c                                   | 43 +++++++++----------
 server-info.c                                 |  1 +
 strbuf.h                                      |  1 +
 t/helper/test-advise.c                        |  2 +-
 worktree.c                                    |  1 +
 23 files changed, 47 insertions(+), 29 deletions(-)

Range-diff against v2:
1:  a855bfceb2 = 1:  a855bfceb2 *.c static functions: don't forward-declare __attribute__
2:  9c1492b006 = 2:  9c1492b006 sequencer.c: move static function to avoid forward decl
3:  e2e039f481 = 3:  e2e039f481 *.c static functions: add missing __attribute__((format))
4:  fd70d512b4 = 4:  fd70d512b4 *.h: add a few missing  __attribute__((format))
5:  a001e851d2 = 5:  a001e851d2 advice.h: add missing __attribute__((format)) & fix usage
6:  fe66e06754 < -:  ---------- strbuf.h: add a comment about "missing" strftime() checking
-- 
2.32.0-dev

