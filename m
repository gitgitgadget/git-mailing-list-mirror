Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A49C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B960A61409
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhEJPNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhEJPNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F4C0515E0
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o26-20020a1c4d1a0000b0290146e1feccdaso9820873wmh.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/nbI8Us/VeDPqcACJFUCaJwPXznkZqG+mFCRHn0zF4=;
        b=s1pBxpQBMhgUEn2315eAs6yT7WPq55KpqPy5dSVIWrVQXL5Shx7eCx5iTqoHFP5ciZ
         RZf6NAJAvMn+fciY9ljd1JHFpxSeHRLGCdmCmSWfmKyFuDXRgLqk1W7uVF8OrPMmvOmU
         VcOG3VVayNQ4TqCs1ulg3HmCqoVeKSj89swpgmrLUH+HQaUTqjzrYNVXAmBHKfvyd0Ol
         Er5A95HXYoneYhqQalefJD/1yZr/NdX+X4OwQN/uncOqU2+7sYWFUxoUY/hGtXXDxCVG
         gEcRq2zUnoOzu5FY6x/GidpzOjzyBl5oIG4w2Px5F4qIZ2UokIwwlymRd8gSV6Js+HkF
         uFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/nbI8Us/VeDPqcACJFUCaJwPXznkZqG+mFCRHn0zF4=;
        b=FPz4C5u6YWavKAZ7JR+Nf+GSBGqOZre4QbRusGCxCcgDuk5DQBJAxCTIDx/yNgL7vU
         CTKNvtw+E82FOBcHFe7+t1e59V7/Z+hxufkI4coeBsAXbypVRv1lrHCcqVdeNJbJW3C5
         coaIcgpXED3ww81+4cPDeSE6BibwUXCK1rN26q58d5bn2Xa+qkXxRw4az8mikQUDRQUN
         7YItaa2dXvg9M37XsOPVaxoaOQq0NESIkN3CdxkxDK9etwdTBhtrhcJc1zc966ABryOz
         Twwv1wFwJxryaex8zAmew9HmYQLqYiuP6WltpNMxmFwY26/ES0xtsH/2FloVS/dwWASe
         as4g==
X-Gm-Message-State: AOAM532znGDqw/8oWjcffcrqXKNIv0cLDvJtAkGTg5labpDSQFw+nTo4
        0rhmHEE1u4ikjJ7ZVn/6iSPUH7tOkzlihw==
X-Google-Smtp-Source: ABdhPJwSZhHle0OoNy2Xw+xcw2bsxodXC2atDmJfjByRHvNO9ExFbDlwfLvPu8XBJVYclycA4+H32w==
X-Received: by 2002:a1c:7d09:: with SMTP id y9mr26823387wmc.7.1620657133753;
        Mon, 10 May 2021 07:32:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:13 -0700 (PDT)
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
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/11] test-lib.sh: new test_commit args, simplification & fixes
Date:   Mon, 10 May 2021 16:18:59 +0200
Message-Id: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v5 only trivial commit message / comment fixes suggested
by Đoàn Trần Công Danh. Thanks! Link to v5:
http://lore.kernel.org/git/cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (11):
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
 t/t6120-describe.sh                 | 58 ++++++---------------------
 t/test-lib-functions.sh             | 62 ++++++++++++++++++-----------
 t/test-lib.sh                       | 40 ++++++++++++-------
 14 files changed, 89 insertions(+), 119 deletions(-)

Range-diff against v5:
 1:  75667f98f3a !  1:  febf98e87a1 test-lib: bring $remove_trash out of retirement
    @@ Commit message
         case.
     
         We carry around the "$remove_trash" variable because if the directory
    -    is unexpectedly gone at test_done time we'll hit the error about it
    -    being unexpectedly gone added in df4c0d1a792 (test-lib: abort when
    -    can't remove trash directory, 2017-04-20).
    +    is unexpectedly gone at test_done time we'll still want to hit the
    +    "trash directory already removed" error, but not if we never created
    +    the trash directory. See df4c0d1a792 (test-lib: abort when can't
    +    remove trash directory, 2017-04-20) for the addition of that error.
     
         So let's partially revert 06478dab4c (test-lib: retire $remove_trash
         variable, 2017-04-23) and move the decision about whether to skip all
    @@ Commit message
         under --debug at the end of the test, 2017-04-24) for a bug we don't
         want to re-introduce.
     
    -    While I'm at it let's move the HOME assignment to just before
    +    While I'm at it, let's move the HOME assignment to just before
         test_create_repo, it could be lower, but it seems better to set it
         before calling anything in test-lib-functions.sh
     
 2:  55c9413f9cd =  2:  6f360e37e84 test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 3:  361e34654e9 =  3:  c2a0140fcd9 test-lib-functions: reword "test_commit --append" docs
 4:  2db68a4ac7c =  4:  1a675a6cfe5 test-lib-functions: document test_commit --no-tag
 5:  4ceba3d404b =  5:  2e0d69209e9 test-lib functions: add an --annotated option to "test_commit"
 6:  589eaf7a078 !  6:  07e8b63596b describe tests: convert setup to use test_commit
    @@ Commit message
         describe tests: convert setup to use test_commit
     
         Convert the setup of the describe tests to use test_commit when
    -    possible. This makes use of the new --annotated-tag option to
    -    test_commit.
    +    possible. This makes use of the new --annotate option to test_commit.
     
         Some of the setup here could simply be removed since the data being
         created wasn't important to any of the subsequent tests, so I've done
 7:  a0fe0640148 !  7:  5aaeadf01ff test-lib functions: add --printf option to test_commit
    @@ t/test-lib-functions.sh: debug () {
      #	Use ">>" instead of ">" when writing "<contents>" to "<file>"
     +#   --printf
     +#       Use "printf" instead of "echo" when writing "<contents>" to
    -+#       "<file>". You will need to provide your own trailing "\n". You
    -+#       can only supply the FORMAT for the printf(1), not its ARGUMENT(s).
    ++#       "<file>", use this to write escape sequences such as "\0", a
    ++#       trailing "\n" won't be added automatically. This option
    ++#       supports nothing but the FORMAT of printf(1), i.e. no custom
    ++#       ARGUMENT(s).
      #   --signoff
      #	Invoke "git commit" with --signoff
      #   --author <author>
 8:  7fb8849ce66 =  8:  0b31b1ffeff submodule tests: use symbolic-ref --short to discover branch name
 9:  f67245ba40d =  9:  c806f3888c5 test-lib: reformat argument list in test_create_repo()
10:  37338c88300 = 10:  105a95fb7a0 test-lib: do not show advice about init.defaultBranch under --verbose
11:  7793311e5f1 = 11:  217c5aed491 test-lib: split up and deprecate test_create_repo()
-- 
2.31.1.838.g924d365b763

