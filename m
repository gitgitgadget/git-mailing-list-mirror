Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D10C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D36D613BC
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhDTMWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhDTMWk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040AC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n127so8243110wmb.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ho4XM0oxx/8mtnVT4T+/OMbzeqa+UowThm0Xbb8aBOg=;
        b=so+tZf919A/OZ3R82X+yrCJBoFSPNUCNQiCf44jOKGHtR3UlUiiXE5YEnCRHWFIw/B
         Y356+Jy5MAzh01nDelFvjCx3w8cVLRStaAm2Zw4hF8kftXsR/J9D9bH8Thwsja4KfkNV
         srvR03RHDSU3ab0qgCe91pNPg15RdkmhRhDQgqf/GclLyE3E4n16iftNFoveNbBFgF9j
         rd/Uiety35IGCLc7y7pIEiSXqXFECbf7P/zGkb7MB4x4RPDzUbNpAstGvE9Ez2WObd7P
         qzAnYxq/JhXUVE4XCvPSONVaptjWRhRUroEGu22QY21W0glaHnGbqMcOYTAEBe8wglG6
         WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ho4XM0oxx/8mtnVT4T+/OMbzeqa+UowThm0Xbb8aBOg=;
        b=cH13W7Q3x2FDqtTR+4C7PCeP6uJBmwTC2wa1ot8lfSpakS7anndeQmbKpCXYVsXwYI
         46t0Ek9A7zMv540KRYUuMypm6dZZI5Up3T1l0HC5BWqnJctlNM1B9x8FWUznXap+L6F0
         +aXPtBHbrxkSvMjk9kuYv4HjHGn4vR49TgI/WWDLJU4SFTColhri3XBZWUBwD5sfptPw
         dvU4rBRIZmFr2DcDZSZqlww9MPEAhyn0dKL2PebrZuj5dsfxBEvUSqTtR3e+CEnWpS51
         09RstYCbgWI3sl8FyozV5udS0VHF9hF1vb1Enp7PTsXWXk8xuOoi6FMXlA24SEsT/PVW
         HQEQ==
X-Gm-Message-State: AOAM531nmwoQ8ayyYYZNdzBe4cJ04wGHzEc43PS9Ax9I/dVF5Zu2cJhm
        aMOg5u+Gxw9LanpaDY1A2fOv0Rg+KLGntg==
X-Google-Smtp-Source: ABdhPJyotSSDSDTWOB0lQ6Hn5HfG+Fn/k7XiPXZN57SPSqOSs5Bj/tk26qzwKV4z0ijghRXMIoCXCQ==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr4219935wmq.55.1618921327114;
        Tue, 20 Apr 2021 05:22:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/12] test-lib.sh: new test_commit args, simplification & fixes
Date:   Tue, 20 Apr 2021 14:21:51 +0200
Message-Id: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a "various small fixes" series to test-lib.sh,
test-lib-functions.sh.

Since v2 the only changes are to 12/12, per SZEDER's comments we can
count on $PATH this late in test-lib.sh, so do that, and clarify the
commit message for that change per the discussion on v2.

Ævar Arnfjörð Bjarmason (12):
  check-non-portable-shell: check for "test <cond> -a/-o <cond>"
  test-lib: bring $remove_trash out of retirement
  test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
  test-lib-functions: reword "test_commit --append" docs
  test-lib-functions: document test_commit --no-tag
  test-lib functions: add an --annotated option to "test_commit"
  describe tests: convert setup to use test_commit
  test-lib functions: add --printf option to test_commit
  submodule tests: use symbolic-ref --short to discover branch name
  test-lib: reformat argument list in test_create_repo()
  test-lib: do not show advice about init.defaultBranch under --verbose
  test-lib: split up and deprecate test_create_repo()

 t/check-non-portable-shell.pl       |  2 +
 t/lib-submodule-update.sh           |  3 +-
 t/t0000-basic.sh                    |  4 --
 t/t1307-config-blob.sh              |  4 +-
 t/t1403-show-ref.sh                 |  6 +--
 t/t2030-unresolve-info.sh           |  3 +-
 t/t4006-diff-mode.sh                |  6 +--
 t/t4030-diff-textconv.sh            |  8 +---
 t/t5406-remote-rejects.sh           |  1 -
 t/t5407-post-rewrite-hook.sh        |  2 -
 t/t5409-colorize-remote-messages.sh |  1 -
 t/t5520-pull.sh                     | 10 +----
 t/t6120-describe.sh                 | 58 +++++++---------------------
 t/test-lib-functions.sh             | 60 ++++++++++++++++++-----------
 t/test-lib.sh                       | 39 +++++++++++--------
 15 files changed, 88 insertions(+), 119 deletions(-)

Range-diff against v2:
 -:  ---------- >  1:  a8b483bc77 check-non-portable-shell: check for "test <cond> -a/-o <cond>"
 -:  ---------- >  2:  39759d00ad test-lib: bring $remove_trash out of retirement
 -:  ---------- >  3:  d669ce3196 test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 -:  ---------- >  4:  9313d35bf8 test-lib-functions: reword "test_commit --append" docs
 -:  ---------- >  5:  c916d648e4 test-lib-functions: document test_commit --no-tag
 -:  ---------- >  6:  9b6bf65ce1 test-lib functions: add an --annotated option to "test_commit"
 -:  ---------- >  7:  683b3ba3dd describe tests: convert setup to use test_commit
 -:  ---------- >  8:  dc0a863db7 test-lib functions: add --printf option to test_commit
 -:  ---------- >  9:  90bf55d2d4 submodule tests: use symbolic-ref --short to discover branch name
 -:  ---------- > 10:  e0a1e2fd52 test-lib: reformat argument list in test_create_repo()
 -:  ---------- > 11:  cedf5d383b test-lib: do not show advice about init.defaultBranch under --verbose
 1:  a3e20ef18f ! 12:  0dc0da9490 test-lib: split up and deprecate test_create_repo()
    @@ Commit message
     
         Remove various redundant or obsolete code from the test_create_repo()
         function, and split up its use in test-lib.sh from what tests need
    -    from it, leaving us with a pass-through wrapper for "git init" in
    -    test-lib-functions.sh
    +    from it.
     
    -    Reasons for why we can remove various code from test_create_repo():
    +    This leave us with a pass-through wrapper for "git init" in
    +    test-lib-functions.sh, in test-lib.sh we have the same, except for
    +    needing to redirect stdout/stderr, and emitting an error ourselves if
    +    it fails. We don't need to error() ourselves when test_create_repo()
    +    is invoked, as the invocation will be a part of a test's "&&"-chain.
    +
    +    Everything below this paragraph is a detailed summary of the history
    +    of test_create_repo() explaining why it's safe to remove the various
    +    things it was doing:
     
          1. "mkdir -p" isn't needed because "git init" itself will create
             leading directories if needed.
    @@ Commit message
          5. Since we don't need to move the .git/hooks directory we don't need
             the subshell here either.
     
    -        That wasn't really needed for the .git/hooks either, but was being
    -        done for the convenience of not having to quote the path to the
    -        repository as we moved the hooks.
    +        See 0d314ce834 for when the subshell use got introduced for the
    +        convenience of not having to "cd" back and forth while setting up
    +        the hooks.
     
          6. We can drop the --template argument and instead rely on the
             GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
             8683a45d669 (Introduce GIT_TEMPLATE_DIR, 2006-12-19)
     
          7. We only needed that ">&3 2>&4" redirection when invoked from
    -        test-lib.sh, and the same goes for needing the full path to "git".
    +        test-lib.sh.
    +
    +        We could still invoke test_create_repo() there, but as the
    +        invocation is now trivial and we don't have a good reason to use
    +        test_create_repo() elsewhere let's call "git init" there
    +        ourselves.
     
    -        Let's move that special behavior into test-lib.sh itself.
    +     8. We didn't need to resolve "git" as
    +        "${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" in test_create_repo(),
    +        even for the use of test-lib.sh
     
    -    In the end it turns out that all we needed was a plain "git init"
    -    invocation.
    +        PATH is already set up in test-lib.sh to start with
    +        GIT_TEST_INSTALLED and/or GIT_EXEC_PATH before
    +        test_create_repo() (now "git init") is called.. So we can simply
    +        run "git" and rely on the PATH lookup choosing the right
    +        executable.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/test-lib.sh: rm -fr "$TRASH_DIRECTORY" || {
      if test -z "$TEST_NO_CREATE_REPO"
      then
     -	test_create_repo "$TRASH_DIRECTORY"
    -+	"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" \
    -+		init \
    -+		"$TRASH_DIRECTORY" >&3 2>&4 ||
    ++	git init "$TRASH_DIRECTORY" >&3 2>&4 ||
     +	error "cannot run git init"
      else
      	mkdir -p "$TRASH_DIRECTORY"
-- 
2.31.1.723.gf6bad1b9ba1

