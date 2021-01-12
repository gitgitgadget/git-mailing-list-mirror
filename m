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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7A8C43331
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E41423125
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437984AbhALVhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436836AbhALUSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C4C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t16so3864319wra.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVm+1332s0ssvcpk/9CfBbFTYxjIJzj6U1Btl9KWkiI=;
        b=PZVt3SvSMN70B5Qny/Zg6wCZbYpb9eyU2LN3wDXqoz2N2smkHLXRzWnpD4z4yafPxd
         cYMoSj46AIifwzno7V3Kq3R1V8vPj16CjhnLfDvCku8uWRdx7RFfIA6CeCbleyrcPyNK
         iperi7i/AB+8NcFQBfFZY0MPAxxce5ScjwSguHmGWmp78otUlN33CG9OYq+PzDxt2+dQ
         NFGMZs+2TB4qnzV/uOevet2i0ydo/SBCeuKzzhPkQxbxSlmCAIT9WqWWe7Ok1aJy1m3f
         EVXBpOSLVMxaxMt8f3j0zn2JHWBVlWQfMfGBLzlNK56MME7UK6uj+m6AsYThKuvSh5sQ
         gDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVm+1332s0ssvcpk/9CfBbFTYxjIJzj6U1Btl9KWkiI=;
        b=R9AD/GI5WwVT2E4OmgPwJqysZ/E5XGDY59zjXUYnc96gMQ3E+wWbX88tYX2oYo9+x6
         +CS8WvVUYofH+2KB21Ebvmn1Wc9RM21n5RK3MN6NtMdh1gc3gJyOBbrKMrzxvoBM2fcw
         Z/fgXBmcPUkzljneXlXmjAh8Qug2qjJ6t3zahqzPfziC8fsoKxZkvq0VAOfUvXtK3gf1
         NKAjrOnIFJl4gqz7CSTqWBCrXBQnkeH3vONvGi7nM7JOozQ8x/KZGv2Z9FzQ/wc0Zvdg
         SK+EG9K4uQI7fOdqOSyk5752ph25fAnmln7xSIP9NEnMlQjRxX/Aa5FwqO696Pup+kpP
         EYQA==
X-Gm-Message-State: AOAM532M0edp9aapDIeA78XPeGDyMn3ukr5WT+BN31Ehpj37mh71BaYG
        cDQtBQPnkp/2Ywz2Bk76E3KylfXoSP5wSQ==
X-Google-Smtp-Source: ABdhPJy8vObP/rFFgLaj6ZRazDe3ngSc+UAreMVmCaKDtbu+UXfMHYpRAwatasSKfq+IMjlrS/7ghQ==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr545958wre.408.1610482692984;
        Tue, 12 Jan 2021 12:18:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/22] mailmap: doc + test fixes
Date:   Tue, 12 Jan 2021 21:17:44 +0100
Message-Id: <20210112201806.13284-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a "small" addition to v1, now with 21 extra patches. While this
is a large series, it should be relatively easy to read and
non-contentious. Mainly

 * We now have a "man 5 gitmailmap", rather than including the format
   description in N places.

 * Lots of extra tests & improvements to modernize existing tests to
   make them more reliable and easier to read.

 * Rewrote the example section in the documentation to be more
   understandable, and you can now follow it along with tests that
   mirror it.

 * Document that mailmap name/email matching is case-insensitive.

 * Document & test for the comment syntax.

 * Add an "--author" and "--append" argument to test_commit, which is
   used by the mailmap tests, but also a few other tests (just as an
   example). This is why the series modifies a few non-mailmap tests.

Ævar Arnfjörð Bjarmason (22):
  mailmap doc: create a new "gitmailmap(5)" man page
  mailmap doc: quote config variables `like.this`
  check-mailmap doc: note config options
  mailmap doc: start by mentioning the comment syntax
  mailmap tests: use our preferred whitespace syntax
  mailmap tests: modernize syntax & test idioms
  mailmap tests: improve --stdin tests
  mailmap tests: remove redundant entry in test
  mailmap tests: add a test for "not a blob" error
  mailmap tests: get rid of overly complex blame fuzzing
  mailmap: test for silent exiting on missing file/blob
  test-lib functions: expand "test_commit" comment template
  test-lib functions: document arguments to test_commit
  test-lib functions: add --author support to test_commit
  test-lib functions: add an --append option to test_commit
  tests: refactor a few tests to use "test_commit --append"
  mailmap doc + tests: add better examples & test them
  mailmap tests: add a test for comment syntax
  mailmap tests: add tests for whitespace syntax
  mailmap tests: add tests for empty "<>" syntax
  mailmap doc + tests: document and test for case-insensitivity
  shortlog: remove unused(?) "repo-abbrev" feature

 Documentation/Makefile              |   1 +
 Documentation/git-blame.txt         |   2 +-
 Documentation/git-check-mailmap.txt |   9 +-
 Documentation/git-shortlog.txt      |   6 +-
 Documentation/gitmailmap.txt        | 123 +++++
 Documentation/mailmap.txt           |  75 ---
 builtin/blame.c                     |   2 +-
 builtin/check-mailmap.c             |   2 +-
 builtin/commit.c                    |   2 +-
 builtin/log.c                       |   2 +-
 builtin/shortlog.c                  |  16 +-
 command-list.txt                    |   1 +
 mailmap.c                           |  48 +-
 mailmap.h                           |   2 +-
 pretty.c                            |   2 +-
 shortlog.h                          |   1 -
 t/t1412-reflog-loop.sh              |   7 +-
 t/t2012-checkout-last.sh            |  12 +-
 t/t4203-mailmap.sh                  | 825 +++++++++++++++++++---------
 t/t7509-commit-authorship.sh        |   7 +-
 t/t7810-grep.sh                     |  18 +-
 t/test-lib-functions.sh             |  37 +-
 22 files changed, 771 insertions(+), 429 deletions(-)
 create mode 100644 Documentation/gitmailmap.txt
 delete mode 100644 Documentation/mailmap.txt

-- 
2.29.2.222.g5d2a92d10f8

