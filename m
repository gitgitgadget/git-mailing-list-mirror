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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E5EC433E9
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C43D64DA5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBPL7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBPL6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:58:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8BEC06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id x4so14211329wmi.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKSziKNbHq0l5DqWPKPhb3VhTIyc9Vmnkia4FZLYHT4=;
        b=j9FxYDyzkUhpRF4+DldxHItZfA3C/OJWwgQeu4pxx40t7rn2nKDb9TAclTF1odOSMi
         YB+kDJI5leb1kV63AB8LcYlPWtniCwOyAhZqJzKjr3mvdBglSIIyC9JYMO2pWe0gP6HN
         FzPDRRD9NyGEJJVwMv0QNtQha8qyX9b7ZPep3LOh2zktklzROedzh1zsjNkATwt3srnr
         HqHCU40tehbbGj3Pk7JozpciL8hAfwOTUdsJeY0iXl7ZVjCHAiXylDSftbdIctkOBEG9
         UTyZdFXb1aQAE5kkPgDXcL3+0lBgzAi+zwf8oJ8Ls7sTffg8/4EfQtqNUJJUyXaxPlq8
         kpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fKSziKNbHq0l5DqWPKPhb3VhTIyc9Vmnkia4FZLYHT4=;
        b=JXccvbEPtOYhO56clDa78REdG6hj39qlhAcn3YekV6ftrpjvcS3W8JoLYdtvqBAd+E
         V/ny5aQ8rumf26KJS+6geDkY58stlGYbhbOWzgetHtJcHooQi5wjXqHhuSlbkzBDQb5i
         L2mU1/OBCDEoJfbcZqyEADvU2Wtnh3r0WoXucM0cOY85ATk1gy0lijqUFRAfHggj37dW
         qo4Uk6uiwOAglGyvLIbUIubgN+I/eofjoGifVRtxDJRnrsD3n/WXYVFRnw63MZRUUV7w
         pXZkwEqc+7R+D/UoqyDtxFF/hO1fczYW1xVD9mmfFwuI7yERwOqW/WTR5VUcJVDP8VCc
         LD3g==
X-Gm-Message-State: AOAM5339xq7bsRc/TomEGuwKnHogGAwTiKfSU8bc0AKOPgtoB6Og5HF0
        jfLUyrFTu/qBqk52KAQSoIKzqB00+gzCzg==
X-Google-Smtp-Source: ABdhPJzuZHv41yzTXhTUUJCz++arTWrq+1ldu/eVE4ZtQuMO0x51dVyJCMDoZHxC6DYSxxR87JpOTA==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr1887588wmq.159.1613476693140;
        Tue, 16 Feb 2021 03:58:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/22] pickaxe: test and refactoring for follow-up changes
Date:   Tue, 16 Feb 2021 12:57:39 +0100
Message-Id: <20210216115801.4773-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a smaller v2 of the series to remove the kwset backend and
make pickaxe use PCRE v2[1].

That's not being done here yet. These are mostly small
refactoring/test fixes. The most significant work is a new xdiff
interface at the end of the series.

It's based on next where some preparatory work already landed[2].

The endless loop bug in v1 pointed out by René Scharfe[3] is gone. We
should still have a test for that, I didn't have time to do more on
that, and figured this was already getting large enough.

I'll do some more improvements of test coverage in a follow-up
series. I'm aware of various blind spots in pickaxe test coverage, but
none of it should hide a bug in this refactoring from us.

It's things like how we deal with REG_NEWLINE, "^" matches etc., but
all the matching logic for that stays the same in this series.

1. https://lore.kernel.org/git/20210203032811.14979-1-avarab@gmail.com/
2. https://lore.kernel.org/git/20210204210556.25242-1-avarab@gmail.com/
3. https://lore.kernel.org/git/4ef09db7-34f2-2fb5-b9e9-be69c7102787@web.de/

Ævar Arnfjörð Bjarmason (22):
  grep/pcre2 tests: reword comments referring to kwset
  test-lib-functions: document and test test_commit --no-tag
  test-lib-functions: reword "test_commit --append" docs
  test-lib functions: add --printf option to test_commit
  pickaxe tests: refactor to use test_commit --append --printf
  pickaxe tests: add test for diffgrep_consume() internals
  pickaxe tests: add test for "log -S" not being a regex
  pickaxe tests: test for -G, -S and --find-object incompatibility
  pickaxe: die when -G and --pickaxe-regex are combined
  pickaxe: die when --find-object and --pickaxe-all are combined
  diff.h: move pickaxe fields together again
  pickaxe/style: consolidate declarations and assignments
  perf: add performance test for pickaxe
  pickaxe: refactor function selection in diffcore-pickaxe()
  pickaxe: assert that we must have a needle under -G or -S
  pickaxe -S: support content with NULs under --pickaxe-regex
  pickaxe: rename variables in has_changes() for brevity
  pickaxe -S: slightly optimize contains()
  xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
  xdiff-interface: support early exit in xdiff_outf()
  pickaxe -G: terminate early on matching lines
  pickaxe -G: don't special-case create/delete

 combine-diff.c                 |   9 ++-
 diff.c                         |  45 +++++++++------
 diff.h                         |   7 ++-
 diffcore-pickaxe.c             |  99 ++++++++++++++++++--------------
 range-diff.c                   |   8 ++-
 t/perf/p4209-pickaxe.sh        |  70 +++++++++++++++++++++++
 t/t0000-basic.sh               |  19 +++++++
 t/t1307-config-blob.sh         |   4 +-
 t/t2030-unresolve-info.sh      |   3 +-
 t/t4006-diff-mode.sh           |   6 +-
 t/t4030-diff-textconv.sh       |   8 +--
 t/t4209-log-pickaxe.sh         | 100 +++++++++++++++++++++++++++------
 t/t5520-pull.sh                |  10 +---
 t/t7816-grep-binary-pattern.sh |   4 +-
 t/test-lib-functions.sh        |  23 ++++++--
 xdiff-interface.c              |  26 ++++++---
 xdiff-interface.h              |  36 +++++++++---
 17 files changed, 349 insertions(+), 128 deletions(-)
 create mode 100755 t/perf/p4209-pickaxe.sh

-- 
2.30.0.284.gd98b1dd5eaa7

