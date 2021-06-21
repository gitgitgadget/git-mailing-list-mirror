Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41095C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28690610C7
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUPF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUPF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:05:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9D6C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:03:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b3so9796963wrm.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qt8thn7COh3psvrsL+P95Q2eNhHEMd+Z4xzgbj7c1Xw=;
        b=MnkExvzTRrV3VuoeV0FNXEXdKbeD8l6WD4mjFpYr5w/FgqHQke9Y2sVdUTs7tLUV3u
         A2O/1Ky5XSjvqchQ8CEs1RYza1IoYepW5Ub2DXFZDh6ATEFY66mmShA/+4zItk9R/OGp
         c8ByHsnY5HtaKEGNFdgGp9A4EVSEeJe0hAOH7ChXcFU8M68vAsoeS5o2mexaObVAtAVg
         oeK0DODn2eD9cyVQ0gE0qwBLKzDck4uSj2snk91ch+GBdBj5a/mWSc4b31l1afbHwRTi
         KT8PvNKvnRxhHAE+h5EOU1rjhOxgDsOfvqpZ0Lf368uGicu3ctKHPuoAeoupOWTb8qxB
         Skqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qt8thn7COh3psvrsL+P95Q2eNhHEMd+Z4xzgbj7c1Xw=;
        b=AKTRoSPMXdRjwEtSzDlju5y7TlCK4Fxw1clCsh0dRuGlLFTHwiejM0FN7L0p4ajLij
         70Gjr8xX+kyGp1yw+CUbhGgMwVvI2yyvdESM/3EQq0Wd3goRbSvJh7ipKorp16uvDJkH
         vtPpy5A0Y9eNrrpf97pwG6sIwTok84yb5++g4wMwlGlRycWZhfmQ0qK1vkjbbgqmYfz1
         MCM782LCUcp1f497CXb+FWxEbwJeBh15xukYmtj+lrot3rJRWGy54GP6MTVkEHtHDNR9
         dTH9ixN/3qVw1sZtmNlPs+xL8atSfYoTd5/4bSnVCU8eGd6iLYfvFLIhqLAnhlr4CZri
         BM7g==
X-Gm-Message-State: AOAM530mx92a1QH0SOW1E+N6pNYHov9yfyw6T0LOKJRBt2C2x61Kjv8d
        3lLk76bNgVNzQn474F//RxV1CNSGwNfp7g==
X-Google-Smtp-Source: ABdhPJxQ79J1d+rmUyVzJ+kCllfnWr/CMU3Uj4oAbZlLhI4ZPlBcg2Ye73gMXrha59hl/uRnO3332g==
X-Received: by 2002:adf:f687:: with SMTP id v7mr13126311wrp.424.1624287820557;
        Mon, 21 Jun 2021 08:03:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y4sm11931939wrw.71.2021.06.21.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:03:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] pack-objects: missing tests & --stdin-packs segfault fix
Date:   Mon, 21 Jun 2021 17:03:36 +0200
Message-Id: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When re-rolling an unrelated series[1] dealing with pack-objects.c and
revision.c I discovered that we have some test blindspots, and that
the newly added --stdin-packs option in v2.32.0 will segfault if fed
garbage data.

This fixes the test blindspots, and 2/2 fixes the segfault.

As discussed in its commit message I'm being lazy about emitting the
error message. If you supply N bogus lines on stdin we'll error on the
first one, since the input is first sorted by the string-list.c
API. The test case for the error message relies on which of two SHA
lines sorts first, and I picked input that happens to sort the same
way under both SHA-1 and SHA-256.

Lazy, but I figured for this use-case it wasn't worth keeping track of
what line we saw when, or to refactor the parsing check on pack names
as we get input lines.

1. https://lore.kernel.org/git/cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  pack-objects tests: cover blindspots in stdin handling
  pack-objects: fix segfault in --stdin-packs option

 builtin/pack-objects.c |  10 ++++
 t/t5300-pack-object.sh | 103 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

-- 
2.32.0.599.g3967b4fa4ac

