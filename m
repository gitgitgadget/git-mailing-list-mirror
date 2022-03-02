Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56262C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 13:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiCBNXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiCBNXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 08:23:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A110A6
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 05:22:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1234915wms.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVI3Up8yNwDzDgXxLAgNbCY11GLfjln4Nnf6ISLwllE=;
        b=XwujOKaN1Gn6nhBcmO0Fg2yn1PrBsblkch9gjO7s+3yi5TchH/yiAzR9B5zZGxH6/7
         WCGWm+we3GxqpkscWNkBEDIqIudgqeM4bkAWIStRCmH//hw/HqgcdeHT+zVUhIGt8XWL
         kiVjc+HjEm++jDYqJUbq1DrxbLr0vsPdKUo8HUQRmwevikjisKfnEmsgbtbPcpyBrqDc
         XLcqhP3la9hSxZdp31wK6q6Z2bOoLZihe6iXOcvb/3eXmFr+WtK46d7vwhh12wfLicaT
         F0usTN5CKbz/iqozq+5dYs8oEyE+RJIA4UDzha2qhBwwBCi6Md6sV68uCtMFV770dESz
         Vhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVI3Up8yNwDzDgXxLAgNbCY11GLfjln4Nnf6ISLwllE=;
        b=G7CQLADrk8supLAB5s1kmglZ1eXg+nLsSlcr3Sjnee/Sl9rlFgBOUvnjOzDEK9KFHt
         buNyoX05yUTGnsZx+Azc9xLesAJ1Ta3avvB9dvve55eoomUL9JLmJBl2xkMfIrtUTO5b
         4FrdsR454MBCDBpSgPE7n2nkSkCtm2JiZq5yzFYPG4CHoNmOBZDGbymq8hCLnZ0aGOnq
         b8B06Vfs/D+tkrhO0sK7lPnNGeYM6IqvGxtOTFh31IYygbFyeF0IpM1u5Gc9Oq9lpiOi
         7MfYcOr1jZ4BQkmzqulCU2fI8lTH1znDm4/iDBHKJfFA5Dn4nrQawvNo9I/h0g88YRkF
         0JeQ==
X-Gm-Message-State: AOAM531qvXu8Su/JER6HamrxL3Cc5Y6IzL1348Y+L/fBp9cdl96ZseNB
        MsqPTut+N98B7nwFyCMbbv9MfdQGQzqjKA==
X-Google-Smtp-Source: ABdhPJzM+7RVywpZWTjdWoXTMc2VdcrxqA+qJvKevoKXr8qn0KMVadCRqJdjWP6NFuMbAzuPhyc98w==
X-Received: by 2002:a05:600c:26c6:b0:381:3b1:cea3 with SMTP id 6-20020a05600c26c600b0038103b1cea3mr20705359wmv.172.1646227354331;
        Wed, 02 Mar 2022 05:22:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm10814197wri.111.2022.03.02.05.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:22:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] tests: add and use a "test_hook" wrapper + hook fixes
Date:   Wed,  2 Mar 2022 14:22:19 +0100
Message-Id: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a test-only improvement series split up and adapted
from a previous series of mine to add a "git init --no-template":
https://lore.kernel.org/git/cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com/

As the range-diff to that shows (with --creation-factor=50) all but
one commit changed too much for "range-diff" to show it by default.

At the end of this series we have a "test_hook" that behaves like the
existing "test_config", i.e. cleans up after itself (by default). See
08/10.

As also explained in 08/10 this means that it'll be much easier to
thoroughly test the "config-based hooks" series, as everything that
now writes hooks will go through this wrapper, and can be made to use
the config-based hooks.

Along the way I found various issues in existing tests that tested our
hooks, and fixed those issues.there were variou

Ævar Arnfjörð Bjarmason (10):
  hook tests: turn exit code assertions into a loop
  t5540: don't rely on "hook/post-update.sample"
  tests: assume the hooks are disabled by default
  bugreport tests: tighten up "git bugreport -s hooks" test
  tests: indent and add hook setup to "test_expect_success"
  hook tests: get rid of unnecessary sub-shells
  fetch+push tests: have tests clean up their own mess
  test-lib-functions: add and use a "test_hook" wrapper
  tests: change "mkdir -p && write_script" to use "test_hook"
  tests: change "cat && chmod +x" to use "test_hook"

 t/t0029-core-unsetenvvars.sh        |   3 +-
 t/t0091-bugreport.sh                |  20 +--
 t/t1350-config-hooks-path.sh        |   4 +-
 t/t1416-ref-transaction-hooks.sh    |  27 ++--
 t/t1800-hook.sh                     |  45 +++----
 t/t3404-rebase-interactive.sh       |  10 +-
 t/t3412-rebase-root.sh              |  18 +--
 t/t3413-rebase-hook.sh              |  18 +--
 t/t3430-rebase-merges.sh            |   6 +-
 t/t4150-am.sh                       |  24 +---
 t/t5401-update-hooks.sh             |  62 ++++-----
 t/t5402-post-merge-hook.sh          |  16 ++-
 t/t5403-post-checkout-hook.sh       |   3 +-
 t/t5406-remote-rejects.sh           |   2 +-
 t/t5407-post-rewrite-hook.sh        |  14 +-
 t/t5409-colorize-remote-messages.sh |   2 +-
 t/t5411-proc-receive-hook.sh        |   4 +-
 t/t5510-fetch.sh                    |   6 +-
 t/t5516-fetch-push.sh               | 192 +++++++++++++---------------
 t/t5521-pull-options.sh             |   4 +-
 t/t5534-push-signed.sh              |  26 ++--
 t/t5540-http-push-webdav.sh         |   4 +-
 t/t5541-http-push-smart.sh          |  22 ++--
 t/t5547-push-quarantine.sh          |   4 +-
 t/t5548-push-porcelain.sh           |   2 +-
 t/t5601-clone.sh                    |   4 +-
 t/t6500-gc.sh                       |  18 +--
 t/t7113-post-index-change-hook.sh   |   7 +-
 t/t7519-status-fsmonitor.sh         |  20 ++-
 t/t9001-send-email.sh               |   4 +-
 t/t9800-git-p4-basic.sh             |  23 ++--
 t/test-lib-functions.sh             |  52 ++++++++
 32 files changed, 320 insertions(+), 346 deletions(-)

Range-diff:
 1:  5526d3dc838 <  -:  ----------- t0001: fix gaps in "TEMPLATE DIRECTORY" coverage
 2:  ef2b67768cf <  -:  ----------- init: split out template population from create_default_files()
 3:  784b7947512 <  -:  ----------- init: unconditionally create the "info" directory
 4:  3d4ea5c5d30 <  -:  ----------- t0008: don't rely on default ".git/info/exclude"
 5:  6bbb39f13fc <  -:  ----------- init & clone: add a --no-template option
 6:  2f478f7ba4a <  -:  ----------- init & clone: add init.templateDir=[bool]
 7:  9402fb23b40 <  -:  ----------- test-lib: create test data with "git init --no-template" (almost)
 8:  0c9b953dd43 <  -:  ----------- tests: don't depend on template-created .git/branches
 -:  ----------- >  1:  706460d10b9 hook tests: turn exit code assertions into a loop
 9:  d97122f5fd8 !  2:  4bee939a894 t5540: don't rely on "hook/post-update.sample"
    @@ t/t5540-http-push-webdav.sh: test_expect_success 'setup remote repository' '
      	cd test_repo.git &&
      	git --bare update-server-info &&
     -	mv hooks/post-update.sample hooks/post-update &&
    -+	write_script "hooks/post-update" <<-\EOF &&
    ++	write_script hooks/post-update <<-\EOF &&
     +	exec git update-server-info
     +	EOF
      	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
10:  ca55471d134 <  -:  ----------- test-lib-functions: add and use a "write_hook" wrapper
11:  6f805f7ebac <  -:  ----------- tests: change "cat && chmod +x" to use "write_hook"
12:  2acbaa77f8d <  -:  ----------- tests: migrate miscellaneous "write_script" to "write_hooks"
13:  d021a5981a1 <  -:  ----------- tests: don't depend on template-created .git/hooks
 -:  ----------- >  3:  0519102edeb tests: assume the hooks are disabled by default
 -:  ----------- >  4:  1da2efc9886 bugreport tests: tighten up "git bugreport -s hooks" test
 -:  ----------- >  5:  8dc478460ee tests: indent and add hook setup to "test_expect_success"
 -:  ----------- >  6:  d86ee06b46e hook tests: get rid of unnecessary sub-shells
 -:  ----------- >  7:  7ce22dbe738 fetch+push tests: have tests clean up their own mess
 -:  ----------- >  8:  d4102e9b929 test-lib-functions: add and use a "test_hook" wrapper
 -:  ----------- >  9:  1802158b14d tests: change "mkdir -p && write_script" to use "test_hook"
 -:  ----------- > 10:  7fef92872f3 tests: change "cat && chmod +x" to use "test_hook"
-- 
2.35.1.1228.g56895c6ee86

