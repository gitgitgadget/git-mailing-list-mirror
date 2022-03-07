Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BCFC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiCGMop (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCGMon (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:43 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5733E37
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j26so12696612wrb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Pu8brQYmW1tM2Tffho4pHVJjml/eM5DOeYex6FNx20=;
        b=FGY8w0stzO2ea5xt9ZRxSQEXUSOsLtKdaWwfCH4emyaS/M5YP8RhmU5c3w1EUcsj6+
         cKWlg3mkB5+j89SXQsd1vMhVQMXw6g1g/65Dw4VOVUPPpHNg6XhK/3Apudz/qZWkXVcr
         lNYS3/bawvn58qxFQMVd5yS/DCKf0rdcReA7HX6S2XwvDMJM9/oS8ruysO/Hoo0Rhpq4
         +713zfXsee86AGAFCtegKEfHdqEtIWAgYy7JHGL2Gw0sNVwAbXn0zYtDoOj4KT0h8cLM
         gala6hkeycp9xGerQOeE4ow9cYZ1OqC8dfUaQA6i143QeLpX4A8xkyNnjO2L57nNlxBX
         oTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Pu8brQYmW1tM2Tffho4pHVJjml/eM5DOeYex6FNx20=;
        b=D3T7rn5hap8t2+P8Z9zivyhqQsyZj5gYpCBUbn7XDfy3Rt/FsSMeFLeBmYR3D4bnhi
         kuyQZLd3VXle+zwBtFNg09rU6KyrWvlJrlyTOgThiycpz6VPCX+9FDq0xROLUNrbZmJT
         0jhu/gWZWnOVzSbD02SY9zNVhSX4AAz+Cl6HjUioLhErI9djpEGI7nm+f54XxQBNoyYa
         0GLjEYBzSqJDhvqIORrcvbXOrfPHXPq36SBfKBAxp1R1P9Hkqge+Vx6/J/T2Qr50IAMQ
         rGB+N6uX91n4gtahXbNO2gSJRYd0on34uHf43+VSv5PfszjDm/Z34GfSBYnGFaU1Jul7
         4ZTA==
X-Gm-Message-State: AOAM530Oj7XBy9fvat3wL1z9HAIKZ1tw+9rIlzPZDA4Y/VCoZEfu08C3
        W90SQzOFp7DlJhFmGvd7uQnIm3z+smfyiQ==
X-Google-Smtp-Source: ABdhPJyPBFqpn78EwCgCq4RZkKG2KlRYJNdTz1GC6o9OpWW/+afe2vfsGzWAbSy+vBaXeNFWbNGDxw==
X-Received: by 2002:a05:6000:188f:b0:1f1:e5da:b116 with SMTP id a15-20020a056000188f00b001f1e5dab116mr6594819wri.467.1646657027373;
        Mon, 07 Mar 2022 04:43:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/10] tests: add and use a "test_hook" wrapper + hook fixes
Date:   Mon,  7 Mar 2022 13:43:31 +0100
Message-Id: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a test-only improvement series split up and adapted
from a previous series of mine to add a "git init --no-template":
https://lore.kernel.org/git/cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com/;
For v1 see:
https://lore.kernel.org/git/cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com/

Changes since v1:

 * Fixed typo/grammer pointed out by Eric Sunshine.
 * Various commit message fixes/clarifications etc. to address Junio's
   comments.
 * Tightened up the "git bugreport test" even more

Junio also suggested re-arranging this to do this migration in fewer
steps. I started doing that but doing so would have taken a lot of
time solving conflicts, re-writing commits etc. I think given that
there's agreement on the end-state that doing so wasn't worth the time
I'd spend on it, or for reviewers in having to review the really large
resulting range-diff. So hopefully this version is acceptable to
advance...

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
 t/t0091-bugreport.sh                |  26 ++--
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
 32 files changed, 325 insertions(+), 347 deletions(-)

Range-diff against v1:
 1:  706460d10b9 =  1:  706460d10b9 hook tests: turn exit code assertions into a loop
 2:  4bee939a894 =  2:  4bee939a894 t5540: don't rely on "hook/post-update.sample"
 3:  0519102edeb !  3:  fc1a9d4d55b tests: assume the hooks are disabled by default
    @@ Commit message
     
         That we can assume that is discussed in point #4 of
         f0d4d398e28 (test-lib: split up and deprecate test_create_repo(),
    -    2021-05-10).
    +    2021-05-10), those parts of this could and should have been done in
    +    that change.
    +
    +    Removing the "mkdir -p" here will then validate that our templates are
    +    being used, since we'd subsequently fail to create a hook in that
    +    directory if it didn't exist. Subsequent commits will have those hooks
    +    created by a "test_hook" wrapper, which will then being doing that
    +    same validation.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 4:  1da2efc9886 !  4:  8dd7b40e510 bugreport tests: tighten up "git bugreport -s hooks" test
    @@ Commit message
         bugreport tests: tighten up "git bugreport -s hooks" test
     
         Amend a test added in 788a776069b (bugreport: collect list of
    -    populated hooks, 2020-05-07) to make more sense. As noted in a
    -    preceding commit our .git/hooks directory already contains *.sample
    -    hooks, so we have no need to clobber the prepare-commit-msg.sample
    -    hook in particular.
    +    populated hooks, 2020-05-07) to "test_cmp" for the expected output,
    +    instead of selectively using "grep" to check for specific things we
    +    either expect or don't expect in the output.
    +
    +    As noted in a preceding commit our .git/hooks directory already
    +    contains *.sample hooks, so we have no need to clobber the
    +    prepare-commit-msg.sample hook in particular.
     
         Instead we should assert that those *.sample hooks are not included in
         the output, and for good measure let's add a new "unknown-hook", to
    @@ Commit message
         cfe853e66be (hook-list.h: add a generated list of hooks, like
         config-list.h, 2021-09-26) for how we generate that data.
     
    +    We're intentionally not piping the "actual" output through "sort" or
    +    similar, we'd also like to check that our reported hooks are sorted.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0091-bugreport.sh ##
    @@ t/t0091-bugreport.sh: test_expect_success 'can create leading directories outsid
     +	true
     +	EOF
      	git bugreport -s hooks &&
    -+
    - 	grep applypatch-msg git-bugreport-hooks.txt &&
    +-	grep applypatch-msg git-bugreport-hooks.txt &&
     -	! grep prepare-commit-msg git-bugreport-hooks.txt
    -+	! grep unknown-hook git-bugreport-hooks.txt &&
    -+	! grep -F .sample git-bugreport-hooks.txt
    ++
    ++	sort >expect <<-\EOF &&
    ++	[Enabled Hooks]
    ++	applypatch-msg
    ++	EOF
    ++
    ++	sed -ne "/^\[Enabled Hooks\]$/,/^$/p" <git-bugreport-hooks.txt >actual &&
    ++	test_cmp expect actual
      '
      
      test_done
 5:  8dc478460ee =  5:  19db5b2d7c2 tests: indent and add hook setup to "test_expect_success"
 6:  d86ee06b46e =  6:  08bd1629d65 hook tests: get rid of unnecessary sub-shells
 7:  7ce22dbe738 !  7:  0ac75ed062f fetch+push tests: have tests clean up their own mess
    @@ Commit message
         leftover data from earlier tests, which may or may not be
         there (e.g. depending on the --run=* option).
     
    +    Before this each test would have been responsible for cleaning up
    +    after a preceding test (which may or may not have run, e.g. if --run
    +    or "GIT_SKIP_TESTS" was used), now each test will instead clean up
    +    after itself.
    +
    +    When doing this split up the "push with negotiation" test, now the
    +    middle of the test doesn't need to "rm event", and since it delimited
    +    two halves that were testing two different things the end-state is
    +    easier to read and reason about.
    +
    +    While changing these lines make the minor change from "-fr" to "-rf"
    +    as the "rm" argument, some of them used it already, it's more common
    +    in the test suite, and it leaves the end-state of the file with more
    +    consistency.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t5516-fetch-push.sh ##
 8:  d4102e9b929 =  8:  1fce2d8855a test-lib-functions: add and use a "test_hook" wrapper
 9:  1802158b14d =  9:  121ca23db37 tests: change "mkdir -p && write_script" to use "test_hook"
10:  7fef92872f3 ! 10:  db27fa32bbd tests: change "cat && chmod +x" to use "test_hook"
    @@ Commit message
     
          - Fixes the long-standing issues with those tests using "#!/bin/sh"
            instead of "#!$SHELL_PATH". Using "#!/bin/sh" here happened to work
    -       because this code was so simply that it e.g. worked on Solaris
    +       because this code was so simple that it e.g. worked on Solaris
            /bin/sh.
     
          - Removes the "mkdir .git/hooks" invocation, as explained in a
-- 
2.35.1.1242.gfeba0eae32b

