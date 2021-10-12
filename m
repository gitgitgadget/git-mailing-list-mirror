Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5D3C4332F
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6AC60E94
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhJLN6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbhJLN6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C26C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so67303948wrc.10
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+S2MCbqRv6reRNI3rymsl7HkBWOWtPr3LXonVWWPFwc=;
        b=MlOQDaXh7/5i2gYRv+qQuVUSZD+0eYGY2uTbWV83Fe9kS8r7nMR3VQFTBELSdl42ip
         axZJNd2eKI9PTnV3mEYiPDC7ZdZhMrMFa23kB7SDD/IWw00aotFHTScoZHYXkN7r2uc3
         ZcohqZJ0mUi8QjBm7Yn0HVBORZqAcoQZviNkMkHSVGv/kh+apHvE3DLdiKir4XL/yU8K
         +9DGpc45VGlxG+rylVwa2qaUHx13eIyjYL7IPkF+SlI3UjLEsGsErX1CCdnzYqejd3D6
         sB1DaqFlZwOcuDqqWiBjb0SlmMfkTqQAyH3UyrlJ6nDrhrlsTgURVWiLhBMH0T+s7Db6
         Mpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+S2MCbqRv6reRNI3rymsl7HkBWOWtPr3LXonVWWPFwc=;
        b=n3D7VA0YJk3DleuRB9Fdkul/P7EB2ynWZdJVdmMPzlsrvsUXjXnyxEFwB0IlHLhNW6
         cKUu8Z58rMt3WWY1HgZonNj3yDMpJkjBTTZhtr9jUv35Q+2L0TWxQTaXOAsJCGlg2J5d
         xyUU7ILdgYaqcf/4Q0BP+96HsWHtvCwHTvAUFyqdtuRgeoUI/DFPTCeJZLK+wufB2NQB
         Ava4ytjVu8RRH0Tt4ATWQXMf/JgKcaaaUcSTw2F9A2sULXPxggIqp14Qz91Hpd8zRq3M
         mwBUeauRS0Nxe+uIkyjGi8pXohGeye17nfKphYwrepH9wTzfpnVi8aVTeC4J+y3vNwP+
         B28g==
X-Gm-Message-State: AOAM5333sN03aOSsDAUCPzB6NSJ0zQ8uPyo3AVbeqoTUcM3MN4x/uj0h
        SBlQdcPK1MqT7LtCOIgiueXwmCvXVKyOWA==
X-Google-Smtp-Source: ABdhPJxzey6aBgU3nAKIM1U5fRfD2s28gKvYbCy3Szqsn5L8Ac/j2Ov3Tp8KB6OHbNDNAhdVBF9pIw==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr5919214wmd.14.1634047008437;
        Tue, 12 Oct 2021 06:56:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] leak tests: mark more tests as passing
Date:   Tue, 12 Oct 2021 15:56:36 +0200
Message-Id: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of the now-landed ab/sanitize-leak-ci and marks more
tests as passing.

The changes since v1 are to address commit a message nit
(s/whitelisted/listed/g), and I ejected the marking of
"t7812-grep-icase-non-ascii.sh" as passing, since this in combination
with 55dbc6f9987 (grep: fix an edge case concerning ascii patterns and
UTF-8 data, 2021-10-07) in "seen would cause it to fail. I don't think
that's a "real" failure, just a new test using a command that happens
to leak, but let's just skip it for now, we can mark it later after
those leaks are fixed.

Ævar Arnfjörð Bjarmason (9):
  leak tests: run various built-in tests in t00*.sh SANITIZE=leak
  leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
  leak tests: mark all ls-tree tests as passing with SANITIZE=leak
  leak tests: mark all trace2 tests as passing with SANITIZE=leak
  leak tests: mark all checkout-index tests as passing with
    SANITIZE=leak
  leak tests: mark some ls-files tests as passing with SANITIZE=leak
  leak tests: mark some read-tree tests as passing with SANITIZE=leak
  leak tests: mark various "generic" tests as passing with SANITIZE=leak
  leak tests: mark some misc tests as passing with SANITIZE=leak

 t/t0001-init.sh                         | 1 +
 t/t0002-gitfile.sh                      | 1 +
 t/t0003-attributes.sh                   | 1 +
 t/t0005-signals.sh                      | 2 ++
 t/t0007-git-var.sh                      | 2 ++
 t/t0008-ignores.sh                      | 1 +
 t/t0010-racy-git.sh                     | 1 +
 t/t0013-sha1dc.sh                       | 2 ++
 t/t0022-crlf-rename.sh                  | 1 +
 t/t0024-crlf-archive.sh                 | 1 +
 t/t0025-crlf-renormalize.sh             | 1 +
 t/t0026-eol-config.sh                   | 1 +
 t/t0029-core-unsetenvvars.sh            | 1 +
 t/t0052-simple-ipc.sh                   | 1 +
 t/t0055-beyond-symlinks.sh              | 1 +
 t/t0061-run-command.sh                  | 1 +
 t/t0065-strcmp-offset.sh                | 1 +
 t/t0066-dir-iterator.sh                 | 1 +
 t/t0067-parse_pathspec_file.sh          | 1 +
 t/t0210-trace2-normal.sh                | 2 ++
 t/t0211-trace2-perf.sh                  | 2 ++
 t/t0212-trace2-event.sh                 | 2 ++
 t/t1000-read-tree-m-3way.sh             | 2 ++
 t/t1003-read-tree-prefix.sh             | 1 +
 t/t1009-read-tree-new-index.sh          | 1 +
 t/t1010-mktree.sh                       | 1 +
 t/t1012-read-tree-df.sh                 | 1 +
 t/t1014-read-tree-confusing.sh          | 2 ++
 t/t1100-commit-tree-options.sh          | 1 +
 t/t1430-bad-ref-name.sh                 | 1 +
 t/t1504-ceiling-dirs.sh                 | 2 ++
 t/t1510-repo-setup.sh                   | 1 +
 t/t2002-checkout-cache-u.sh             | 1 +
 t/t2003-checkout-cache-mkdir.sh         | 1 +
 t/t2004-checkout-cache-temp.sh          | 1 +
 t/t2005-checkout-index-symlinks.sh      | 1 +
 t/t2050-git-dir-relative.sh             | 1 +
 t/t2081-parallel-checkout-collisions.sh | 1 +
 t/t2300-cd-to-toplevel.sh               | 1 +
 t/t3000-ls-files-others.sh              | 2 ++
 t/t3002-ls-files-dashpath.sh            | 2 ++
 t/t3003-ls-files-exclude.sh             | 2 ++
 t/t3004-ls-files-basic.sh               | 1 +
 t/t3006-ls-files-long.sh                | 2 ++
 t/t3008-ls-files-lazy-init-name-hash.sh | 1 +
 t/t3070-wildmatch.sh                    | 1 +
 t/t3100-ls-tree-restrict.sh             | 2 ++
 t/t3101-ls-tree-dirname.sh              | 2 ++
 t/t3102-ls-tree-wildcards.sh            | 1 +
 t/t3103-ls-tree-misc.sh                 | 1 +
 t/t3205-branch-color.sh                 | 1 +
 t/t3211-peel-ref.sh                     | 1 +
 t/t3300-funny-names.sh                  | 1 +
 t/t3601-rm-pathspec-file.sh             | 1 +
 t/t3902-quoted.sh                       | 1 +
 t/t4002-diff-basic.sh                   | 2 ++
 t/t4016-diff-quote.sh                   | 1 +
 t/t4019-diff-wserror.sh                 | 1 +
 t/t4025-hunk-header.sh                  | 1 +
 t/t4026-color.sh                        | 2 ++
 t/t4300-merge-tree.sh                   | 2 ++
 t/t5580-unc-paths.sh                    | 1 +
 t/t5615-alternate-env.sh                | 2 ++
 t/t7518-ident-corner-cases.sh           | 2 ++
 t/t7813-grep-icase-iso.sh               | 1 +
 t/t7816-grep-binary-pattern.sh          | 1 +
 66 files changed, 86 insertions(+)

Range-diff against v1:
 1:  67fbd70c55a !  1:  4a426acf701 leak tests: run various built-in tests in t00*.sh SANITIZE=leak
    @@ Commit message
         TEST_PASSES_SANITIZE_LEAK=true as passing when git is compiled with
         SANITIZE=leak.
     
    -    They'll now be whitelisted as running under the
    +    They'll now be listed as running under the
         "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
         target).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## t/t0001-init.sh ##
    +@@
    + 
    + test_description='git init'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + check_config () {
    +
      ## t/t0002-gitfile.sh ##
     @@ t/t0002-gitfile.sh: Verify that plumbing commands work when .git is a file
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 2:  9a8804e1d9a !  2:  6c868ae4ae1 leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
    @@ Commit message
         Mark various existing tests in t00*.sh that invoke a "test-tool" with
         as passing when git is compiled with SANITIZE=leak.
     
    -    They'll now be whitelisted as running under the
    +    They'll now be listed as running under the
         "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
         target).
     
 3:  3a7dd917d9f <  -:  ----------- leak tests: mark t0000-init.sh as passing with SANITIZE=leak
 4:  e18b5093a52 !  3:  dab4752680c leak tests: mark all ls-tree tests as passing with SANITIZE=leak
    @@ Commit message
         leak tests: mark all ls-tree tests as passing with SANITIZE=leak
     
         Mark those tests that match "*ls-tree*" as passing when git is
    -    compiled with SANITIZE=leak. They'll now be whitelisted as running
    -    under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
    -    "linux-leaks" CI target).
    +    compiled with SANITIZE=leak. They'll now be listed as running under
    +    the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
    +    CI target).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 5:  da2631ce626 !  4:  df235c1dc68 leak tests: mark all trace2 tests as passing with SANITIZE=leak
    @@ Metadata
      ## Commit message ##
         leak tests: mark all trace2 tests as passing with SANITIZE=leak
     
    -    Mark all tests that match "*trace2*" as passing when git is
    -    compiled with SANITIZE=leak. They'll now be whitelisted as running
    -    under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
    -    "linux-leaks" CI target).
    +    Mark all tests that match "*trace2*" as passing when git is compiled
    +    with SANITIZE=leak. They'll now be listed as running under the
    +    "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
    +    target).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 6:  7ab1583c77d !  5:  39a0199d5c6 leak tests: mark all checkout-index tests as passing with SANITIZE=leak
    @@ Metadata
      ## Commit message ##
         leak tests: mark all checkout-index tests as passing with SANITIZE=leak
     
    -    Mark some tests that match "*{checkout,switch}*" as passing when git is
    -    compiled with SANITIZE=leak. They'll now be whitelisted as running
    -    under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
    -    "linux-leaks" CI target).
    +    Mark some tests that match "*{checkout,switch}*" as passing when git
    +    is compiled with SANITIZE=leak. They'll now be listed as running under
    +    the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
    +    CI target).
     
         Unfortunately almost all of those tests fail when compiled with
         SANITIZE=leak, these only pass because they run "checkout-index", not
 7:  b913feca9d8 !  6:  45d3f07cd15 leak tests: mark some ls-files tests as passing with SANITIZE=leak
    @@ Commit message
         leak tests: mark some ls-files tests as passing with SANITIZE=leak
     
         Mark some tests that match "*ls-files*" as passing when git is
    -    compiled with SANITIZE=leak. They'll now be whitelisted as running
    -    under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
    -    "linux-leaks" CI target). We still have others that match '*ls-files*"
    -    that fail under SANITIZE=leak.
    +    compiled with SANITIZE=leak. They'll now be listed as running under
    +    the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
    +    CI target). We still have others that match '*ls-files*" that fail
    +    under SANITIZE=leak.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 8:  d2d7f9f9f8c !  7:  889e7227abf leak tests: mark some read-tree tests as passing with SANITIZE=leak
    @@ Commit message
         leak tests: mark some read-tree tests as passing with SANITIZE=leak
     
         Mark some tests that match "*read-tree*" as passing when git is
    -    compiled with SANITIZE=leak. They'll now be whitelisted as running
    -    under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
    -    "linux-leaks" CI target). We still have around half the tests that
    -    match "*read-tree*" failing, but let's whitelist those that don't.
    +    compiled with SANITIZE=leak. They'll now be listed as running under
    +    the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
    +    CI target). We still have around half the tests that match
    +    "*read-tree*" failing, but let's whitelist those that don't.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 9:  9299634b932 =  8:  a4843f35004 leak tests: mark various "generic" tests as passing with SANITIZE=leak
10:  1b68890f614 !  9:  ba30265cb72 leak tests: mark some misc tests as passing with SANITIZE=leak
    @@ Commit message
     
         Mark some tests that match "*{mktree,commit,diff,grep,rm,merge,hunk}*"
         as passing when git is compiled with SANITIZE=leak. They'll now be
    -    whitelisted as running under the "GIT_TEST_PASSING_SANITIZE_LEAK=true"
    -    test mode (the "linux-leaks" CI target).
    +    listed as running under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test
    +    mode (the "linux-leaks" CI target).
     
         These were picked because we still have a lot of failures in adjacent
         areas, and we didn't have much if any coverage of e.g. grep and diff
    @@ t/t4300-merge-tree.sh
      
      test_expect_success setup '
     
    - ## t/t7812-grep-icase-non-ascii.sh ##
    -@@
    - 
    - test_description='grep icase on non-English locales'
    - 
    -+TEST_PASSES_SANITIZE_LEAK=true
    - . ./lib-gettext.sh
    - 
    - test_expect_success GETTEXT_LOCALE 'setup' '
    -
      ## t/t7813-grep-icase-iso.sh ##
     @@
      
-- 
2.33.0.1567.g7b23ce7ed9e

