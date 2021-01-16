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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FDC43381
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ACE227BF
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbhAPRGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbhAPQaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:30:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED34C061346
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h17so9685052wmq.1
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwXXkIfiUoGJkiPLoADdMZmke/tBLDdqGIqqI29hMRY=;
        b=eNOHBHhtdWeV6cX0wxv2YLKvmKSYdJ1W+Ve8lX3+Dd2KzhTKrwFeHeZ3AHV8TeYSXn
         36N4ckeS2XzRFxssmzR5bqNitTPPGcahswpXwZR34SQ/uFgT9yQOOH+AcHjDbfXh0TvK
         QHhomZ29HURw6rOl1QMvkl68fMxR+uNRqGH995SAK9XskRqKniE6Nu6TJ2i1v/rE76LL
         tQUBMctd1rIeepRfX1i1amJ+ow4hmeSZmVStOgkxLBMq155rvkUizCXxMhpVF0SOC2PW
         UDB+NBU7PVkxchm2Q1fk8mRHGek8bw0KHSnNEDWldav7hTuI0yP0b+RsrQQPuGm+A+qu
         yJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwXXkIfiUoGJkiPLoADdMZmke/tBLDdqGIqqI29hMRY=;
        b=kUcvcYO812uwAJrH+spwrqVnQrCAryz8dqiBu2hTbEmTsxRlC1mx/2Kj/klqt56nx7
         1Qr2f/hVqzN/YOoloS1zEL9Kkr/36c9lsOmm8IrGYKZnEmdQ58LT8fJCmj7efThiuJJy
         7RIJwIotTpKS9yE2GalBmdecCLaWV6uPIef1U7pM+SCK8wt8ILmne5zB1eukXGOS0ALX
         An2UzhYvG1SIV3w0CVf+HnpfQB7djbTKd4qBFOsrdVxNJ+KUVZOjqV/UrNIwYcF+QsGc
         WXEi5WHvI9D2l2ZKXp9SdkzO43uV0qUJrFHuWG3nUye6qgNzdTU/hrTuKkrRMj4DxtzW
         EOHQ==
X-Gm-Message-State: AOAM531qdpakS+EceXM7sMn/OAjF4MFNHCkknFJmsrbVmOpKZmoAwrCF
        vU9RBKJlHzlSLHabzCvyHeyw6okXZYON9w==
X-Google-Smtp-Source: ABdhPJwOOYZ3P9qsg6FcbuecVv9/PCqDC1ERs60DDrqlDXGkeOSpr39PhHusQ6WqGagUFIUffukBxA==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr9378961wmb.98.1610811358999;
        Sat, 16 Jan 2021 07:35:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:35:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] tests: add a bash "set -o pipefail" test mode
Date:   Sat, 16 Jan 2021 16:35:43 +0100
Message-Id: <20210116153554.12604-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An unstated aim of v1 of this series was to fix up the tests on
vanilla bash's "set -o pipefail" enough that the test suite would have
some failures, but wouldn't look like a complete dumpster fire.

But this was confusing and relied on a side-quest to change the
test_{must,might}_fail helpers. See
https://lore.kernel.org/git/YAFntgQE3NZ3yQx5@coredump.intra.peff.net/

I've now ejected all of that, in favor of just fixing some of the
tests instead as Jeff suggested. Jeff, I added your Signed-off-by to
06/11 which you're mostly the author of. Please Ack that you're OK
with that (the original diff-for-discussin didn't have a SOB).

Jeff King (1):
  git-svn tests: rewrite brittle tests to use "--[no-]merges".

Ævar Arnfjörð Bjarmason (10):
  cache-tree tests: remove unused $2 parameter
  cache-tree tests: use a sub-shell with less indirection
  cache-tree tests: refactor overly complex function
  git svn mergeinfo tests: modernize redirection & quoting style
  git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
  rm tests: actually test for SIGPIPE in SIGPIPE test
  upload-pack tests: avoid a non-zero "grep" exit status
  archive tests: use a cheaper "zipinfo -h" invocation to get header
  tests: split up bash detection library
  tests: add a "set -o pipefail" for a patched bash

 t/README                           |  5 ++++
 t/lib-bash-detection.sh            |  8 ++++++
 t/lib-bash.sh                      |  4 ++-
 t/t0000-basic.sh                   |  4 +++
 t/t0005-signals.sh                 |  4 +--
 t/t0090-cache-tree.sh              | 31 +++++++--------------
 t/t3600-rm.sh                      |  7 +++--
 t/t5000-tar-tree.sh                |  2 +-
 t/t5004-archive-corner-cases.sh    |  3 ++-
 t/t5703-upload-pack-ref-in-want.sh |  6 ++++-
 t/t9151-svn-mergeinfo.sh           | 43 ++++++++++++++----------------
 t/t9902-completion.sh              |  5 ++++
 t/test-lib.sh                      | 29 ++++++++++++++++++++
 13 files changed, 99 insertions(+), 52 deletions(-)
 create mode 100644 t/lib-bash-detection.sh

Range-diff:
 1:  d950fbb967 <  -:  ---------- test-lib: add tests for test_might_fail
 2:  1a0ffb1159 <  -:  ---------- test-lib: add ok=* support to test_might_fail
 3:  f7eaceeb3e <  -:  ---------- test_lib: allow test_{must,might}_fail to accept non-git on "sigpipe"
 4:  0e77779947 <  -:  ---------- tests: use "test_might_fail ok=sigpipe grep" when appropriate
 -:  ---------- >  1:  8e8e03fa3d cache-tree tests: remove unused $2 parameter
 -:  ---------- >  2:  828d25533c cache-tree tests: use a sub-shell with less indirection
 -:  ---------- >  3:  fefdc570a5 cache-tree tests: refactor overly complex function
 -:  ---------- >  4:  a16938e58d git svn mergeinfo tests: modernize redirection & quoting style
 -:  ---------- >  5:  b520656240 git svn mergeinfo tests: refactor "test -z" to use test_must_be_empty
 -:  ---------- >  6:  f2e70ac911 git-svn tests: rewrite brittle tests to use "--[no-]merges".
 -:  ---------- >  7:  dcf001e165 rm tests: actually test for SIGPIPE in SIGPIPE test
 -:  ---------- >  8:  2212fa65eb upload-pack tests: avoid a non-zero "grep" exit status
 -:  ---------- >  9:  8167c2e346 archive tests: use a cheaper "zipinfo -h" invocation to get header
 5:  c3916b8e7b = 10:  30c454ae7c tests: split up bash detection library
 6:  4a988d1c73 ! 11:  6f290f850c tests: add a "set -o pipefail" for a patched bash
    @@ Commit message
         wind with current bash semantics of failing on SIGPIPE.
     
         This series relies on a patch of mine to bash, which I'm submitting
    -    upstream. Vanilla bash ignores SIGPIPE under "set -e" since version
    -    3.1. It's only under "set -o pipefail" (added in 3.2) that it doesn't
    -    take account of SIGPIPE, in a seeming omission nobody bothered to fix
    -    yet.
    +    upstream, while not breaking anything for vanilla bash users. They
    +    won't have GIT_TEST_PIPEFAIL turned on for them, and will only get
    +    breakages if they turn it on explicitly with "GIT_TEST_PIPEFAIL=true".
    +
    +    Vanilla bash ignores SIGPIPE under "set -e" since version 3.1. It's
    +    only under "set -o pipefail" (added in 3.2) that it doesn't take
    +    account of SIGPIPE, in a seeming omission nobody bothered to fix yet.
     
         Patching bash[4] with:
     
    @@ Commit message
                 }
                    while (p != jobs[job]->pipe);
     
    -    Makes it useful for something like the git test suite. With vanilla
    -    bash and GIT_TEST_PIPEFAIL=true we'll fail 4 tests in my one-off test.
    +    Makes it useful for something like the git test suite.
     
    -    With my patched bash the only tests we need to skip are those that are
    -    explicitly testing that a piped command returned SIGPIPE.
    +    Under this test mode we only tests we need to skip those tests which
    +    are explicitly testing that a piped command returned SIGPIPE. Those
    +    tests will now return 0 instead of an exit code indicating SIGPIPE.
     
    -    As Jeff noted in [3] that count isn't reliable, as more will fail in a
    -    way that's hard to reproduce due to the racy nature of vanilla "set -o
    -    pipefail"
    +    Forcing the mode to run under vanilla bash with
    +    "GIT_TEST_PIPEFAIL=true" doesn't fail any tests for me, except the
    +    test in t0000-basic.sh which explicitly checks for the desired
    +    pipefail semantics. However, as Jeff noted in [3] that absence of
    +    failure isn't reliable. I might not see some of the failures due to
    +    the racy nature of how vanilla "set -o pipefail" interacts with *nix
    +    pipe semantics.
     
         1. a378fee5b0 (Documentation: add shell guidelines, 2018-10-05)
         2. https://lore.kernel.org/git/cover.1573779465.git.liu.denton@gmail.com/
    @@ t/README: GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
     +GIT_TEST_PIPEFAIL=<boolean>, when true, run 'set -o pipefail' to catch
     +failures in commands that aren't the last in a pipe. Defaults to true
     +on bash versions which know how to ignore SIGPIPE failures under the
    -+'set -o pipefail' mode (as of 2021-01-14 only in an out-of-tree patch
    -+to bash).
    ++'set -o pipefail' mode.
     +
      Naming Tests
      ------------
      
     
      ## t/t0000-basic.sh ##
    -@@ t/t0000-basic.sh: test_expect_success 'test_{must,might}_fail accept non-git on "sigpipe"' '
    - 	test_cmp badobjects out
    +@@ t/t0000-basic.sh: test_expect_success 'test_must_fail rejects a non-git command with env' '
    + 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
      '
      
    -+test_expect_failure BASH_SET_O_PIPEFAIL 'test_{must,might}_fail ok=sigpipe under bash "set -o pipefail"' '
    -+	grep string </dev/null | true
    -+'
    -+
    -+test_expect_failure BASH_SET_O_PIPEFAIL 'test_{must,might}_fail ok=sigpipe under bash "set -o pipefail"' '
    -+	test_must_fail grep string </dev/null | true &&
    -+	test_might_fail grep string </dev/null | true
    -+'
    -+
    -+test_expect_success BASH_SET_O_PIPEFAIL 'test_{must,might}_fail ok=sigpipe under bash "set -o pipefail"' '
    -+	test_must_fail ok=sigpipe grep string </dev/null | true &&
    -+	test_might_fail ok=sigpipe grep string </dev/null | true
    ++test_expect_success BASH_SET_O_PIPEFAIL 'our bash under "set -o pipefail" mode ignores SIGPIPE failures' '
    ++	yes | head -n 1 | true
     +'
     +
      test_done
    @@ t/t0005-signals.sh: test_expect_success 'create blob' '
      	test_match_signal 13 "$OUT"
      '
     
    + ## t/t3600-rm.sh ##
    +@@ t/t3600-rm.sh: test_expect_success 'choking "git rm" should not let it die with cruft' '
    + 		i=$(( $i + 1 ))
    + 	done | git update-index --index-info &&
    + 	OUT=$( ((trap "" PIPE; git rm -n "some-file-*"; echo $? 1>&3) | :) 3>&1 ) &&
    +-	test_match_signal 13 "$OUT" &&
    ++	if ! test_have_prereq BASH_SET_O_PIPEFAIL
    ++	then
    ++		test_match_signal 13 "$OUT"
    ++	fi &&
    + 	test_path_is_missing .git/index.lock
    + '
    + 
    +
      ## t/t5000-tar-tree.sh ##
     @@ t/t5000-tar-tree.sh: test_expect_success LONG_IS_64BIT 'set up repository with huge blob' '
      
-- 
2.29.2.222.g5d2a92d10f8

