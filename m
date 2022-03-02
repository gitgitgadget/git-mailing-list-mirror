Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7638C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiCBR2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbiCBR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296EFDF55
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i66so1583069wma.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlX4iNO18wrA7vNf/VAx+NnEb84n5ImR1LbKRxMNmCY=;
        b=YEEPrUAEjgzZxs/mfX78N5irrF9mcgj1vVSmlh4HU20hNU2YDmZJOJWQkwFr/QZpBK
         UA/l4PCZPyZmUcSU3f563S85syHY3WdkyM+5IRm5RTWuOfqWSxtxyW9bDgqpbWrKADzK
         repOGbrK4Sj5mzX0wSl5iVM2EXHdMxIW6kTnvC05lfvmgxM6wXsPM1V9yX8vhRqKVBOg
         Cy+OzhOlOnP7RX6jErlTXSo6Ks/5tO3enpx11gD+R2jaOoU2x8NrBBKTzMLJBBApysAm
         V4EQJxN/QwUnFasTPCxOcUVhr5/kGdXhm1HPy7yJGDXBuYOJRvYg6c1aUm3sa337Odu5
         N2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlX4iNO18wrA7vNf/VAx+NnEb84n5ImR1LbKRxMNmCY=;
        b=w4h2VaLGqDMgLPK9Z9MNa7zxiaQ0Oef2iY3c7JbWrcD9OaL4/kZLBSMcoOz6zvpj7f
         L9mn4AoVDDjaZbt/TeA0jWpgbJ1gv7V1Y184rQG0wPJllRhEqCXX5UmJF2vk68izbp+3
         WZzQT5j1SgbHbLgTMwIbdltCcyg8fXWDV0/WNuiMSaTfxs0ey9D1dFFMGOIt0vW/R4Tm
         XKtn0S3oDoW8S06jz0p0qKclEMEH7U5WneegFaQqjv7LuFjjILqqVY5IJu0VIkY7t/PX
         Ar6uzCYYj8FPYPz2EJYriBZ9YUiJgNXq9kc+qW6M6yltK40e+XTlsfnV/BcZU21JSGpl
         UN/g==
X-Gm-Message-State: AOAM531urDv18J5GC47Z2ZNwG547PMyc+vpldw/AGVgx1AYckSL3+xYG
        IlMPrV+6SiO2sExI/zxDzSDuhmHf2fL0Dg==
X-Google-Smtp-Source: ABdhPJy7DzSkGyY9mf6t3VOGWPMapwySlRl66oPJ5gpeLvUg9EAv90F48YH6A6ozZ7EdhPVVpRMqUQ==
X-Received: by 2002:a05:600c:210e:b0:385:d649:b4ca with SMTP id u14-20020a05600c210e00b00385d649b4camr685296wml.114.1646242050075;
        Wed, 02 Mar 2022 09:27:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/15] tests: don't ignore "git" exit codes
Date:   Wed,  2 Mar 2022 18:27:09 +0100
Message-Id: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes issues where we ignored the exit code of "git" due
to it being on the LHS of a pipe, or because we interpolated its
output with $() in a "test" construct, or had missing &&- chains in
helper functions etc.

This series is not made by string-replacing things in our test suite,
if it was it would be much larger. These are all tests I've seen real
hide real failures under SANITIZE=leak, either on current "master", or
in combination with various local leak fixes I've got unsubmitted.

In cases where I was starting to fix a pattern in a file I'd fix the
rest of the file if it was easy, but otherwise these are all cases
where I ran SANITIZE=leak, had a test pass, but having ASAN_OPTIONS
log to a file revealed that we had memory leaks within that test.

As an aside we still have various potential issues with hidden
segfaults etc. in the test suite after this that are tricked to solve,
because:

 * Our tests will (mostly) catch segfaults and abort(), but if we
   invoke a command that invokes another command it needs to ferry the
   exit code up to us.

 * run-command.c notably does not do that, so for e.g. "git push"
   tests where we expect a failure and an underlying "git" command
   fails we won't ferry up the segfault or abort exit code.

 * We have gitweb.perl and some other perl code ignoring return values
   from close(), i.e. ignoring exit codes from "git rev-parse" et al.

 * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
   git commands, and if they fail returning "1", not ferrying up the
   segfault or abort() exit code.

Ævar Arnfjörð Bjarmason (15):
  tests: change some 'test $(git) = "x"' to test_cmp
  tests: use "test_stdout_line_count", not "test $(git [...] | wc -l)"
  read-tree tests: check "diff-files" exit code on failure
  diff tests: don't ignore "git diff" exit code
  diff tests: don't ignore "git diff" exit code in "read" loop
  apply tests: use "test_must_fail" instead of ad-hoc pattern
  merge tests: use "test_must_fail" instead of ad-hoc pattern
  rev-parse tests: don't ignore "git reflog" exit code
  notes tests: don't ignore "git" exit code
  diff tests: don't ignore "git rev-list" exit code
  rev-list tests: don't hide abort() in "test_expect_failure"
  gettext tests: don't ignore "test-tool regex" exit code
  apply tests: don't ignore "git ls-files" exit code, drop sub-shell
  checkout tests: don't ignore "git <cmd>" exit code
  rev-list simplify tests: don't ignore "git" exit code

 t/t0002-gitfile.sh                     |   6 +-
 t/t1001-read-tree-m-2way.sh            |   6 +-
 t/t1002-read-tree-m-u-2way.sh          |   6 +-
 t/t1503-rev-parse-verify.sh            |   5 +-
 t/t2012-checkout-last.sh               |  51 ++++++---
 t/t2200-add-update.sh                  |  33 ++++--
 t/t3302-notes-index-expensive.sh       |   6 +-
 t/t3303-notes-subtrees.sh              |   9 +-
 t/t3305-notes-fanout.sh                |  14 +--
 t/t4020-diff-external.sh               | 153 ++++++++++++-------------
 t/t4027-diff-submodule.sh              |   7 +-
 t/t4123-apply-shrink.sh                |  18 +--
 t/t4128-apply-root.sh                  |  36 +++---
 t/t6005-rev-list-count.sh              |  43 ++++---
 t/t6012-rev-list-simplify.sh           |  12 +-
 t/t6102-rev-list-unexpected-objects.sh |  13 ++-
 t/t6407-merge-binary.sh                |  22 +---
 t/t7103-reset-bare.sh                  |   7 +-
 t/t7812-grep-icase-non-ascii.sh        |  11 +-
 19 files changed, 240 insertions(+), 218 deletions(-)

-- 
2.35.1.1226.g8b497615d32

