Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B45C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 20:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhLAUPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352805AbhLAUPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 15:15:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7521C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 12:11:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i5so54878532wrb.2
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 12:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JH8jk+nOIaMHih4T9fbfDDOGxwjib557PqleWmzaAr8=;
        b=YdRfzdVGi7QkRYL8Y/uFgljIF67/tawkxa1cR0sZ/5jevG/RYbUqvRORqO3df7QO4s
         xmBbmXt2ELWwKfHQPPxqZRFTvUy/iYnOWT+4/ECaDUDKEVrTUMQnJqhFGKxu4ZS30Los
         9q+SiqpVeQuXP0DuzJyueMWH/T5DYbBSM9nWdaW7/hZgz0ieSb5wtYi/p2MMpJInkqAA
         wKHvON5Tp+fqOpZlyoxTPL2ZqIrAMKjF0glCha5qI4S9cPRnL/t4m1J1h1KiJltq2bk5
         Wi6zAz7TEvJVQ/uw7CByuqpEWsAE8o/Ya11JH9/X+NJhG4f4AWj4vtFciPG6HpK9jzeF
         pGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH8jk+nOIaMHih4T9fbfDDOGxwjib557PqleWmzaAr8=;
        b=7MfX/oT0qUxhEKClO2tUv+l2UfbkL7zkJP83uczOgIuLSYN/E5ArMCvGod//iSIWhc
         o2p5o5LWxuc7zH3xL7vPyPtwSK3Fmk+KRAriEE8gerNet7KCru0Yo0lfgKZw6smO/kmQ
         gU+UCWFA3m6JoDUDg19E7dpNs0pkWi3BBUtrbjmqkmBUzTva+5ypRIgJEI0uyFL8gDBo
         w69r0/Gee6uoCgUCacXH3rI9McAlxsW3jPXm658LtVSsIhnC8BaObzItVJLJe8I+QHZx
         i33PumI/bvaviWlxMgYr76PSvYxx+wR5HKNkmMkX2Fb1VmY5+Ua8EOXo2rFgoc/7E1CN
         0RjQ==
X-Gm-Message-State: AOAM533sDU/gLDellrk4s3B99Kl697JjXlhEPJuw1EiVO0ZxKtvIuyP6
        RXmE7VHXspI2xs5s9hUO8KGeTLwp/eqnug==
X-Google-Smtp-Source: ABdhPJzBUi+piEgLFDgGpmt+zLstlob+pfCMPQ5RxNeV30LSX8yMk/x/EIsFw69h0SfH9W/dgiaWmg==
X-Received: by 2002:adf:c751:: with SMTP id b17mr9532951wrh.560.1638389512712;
        Wed, 01 Dec 2021 12:11:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm660876wrv.94.2021.12.01.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:11:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
Date:   Wed,  1 Dec 2021 21:11:40 +0100
Message-Id: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.876.gdb91009a90c
In-Reply-To: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this v2 should nicely address the outstanding comments on
v1. I.e. v1 made the trade-off of not caring about -x in t1510 for
some of its assertions.

But as noted in the new 1/2 here we can get a much better and easily
debuggable test regardless of which shell we use if we don't use the
pattern that's being worked around by test_untraceable.

Which, is the updated 2/2 notes is mostly what SZEDER was doing in
2018 when "test_untraceable" was introduced, it's just that t1510
wasn't migrated over at the time, as some other tests in the his
series discussed in 2/2 were.

Ævar Arnfjörð Bjarmason (2):
  t1510: remove need for "test_untraceable", retain coverage
  test-lib.sh: remove the now-unused "test_untraceable" facility

 t/README              |  3 --
 t/t1510-repo-setup.sh | 83 +++++++++++++++++++++----------------------
 t/test-lib.sh         | 66 ++++------------------------------
 3 files changed, 47 insertions(+), 105 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  91402624777 t1510: remove need for "test_untraceable", retain coverage
1:  9f735bd0d49 ! 2:  867d18d14bd test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
    +    test-lib.sh: remove the now-unused "test_untraceable" facility
     
    -    Change the "t1510-repo-setup.sh" test to use a new
    -    "test_must_be_empty_trace" wrapper, instead of turning on
    -    "test_untraceable=UnfortunatelyYes".
    +    In the preceding commit the use of "test_untraceable=UnfortunatelyYes"
    +    was removed from "t1510-repo-setup.sh" in favor of more narrow
    +    redirections of the output of specific commands (and not entire
    +    sub-shells or functions).
     
    -    The only reason the test was incompatible with "-x" was because of
    -    these "test_must_be_empty" checks, which we can instead instead skip
    -    if we're running under "set -x".
    +    This is in line with the fixes in the series that introduced the
    +    "test_untraceable" facility. See 571e472dc43 (Merge branch
    +    'sg/test-x', 2018-03-14) for the series as a whole, and
    +    e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
    +    subshell, 2018-02-24) for a commit that's in line with the changes in
    +    the preceding commit.
     
    -    Skipping the tests is preferable to not having the "-x" output at all,
    -    as it's much easier to debug the test. The result loss of test
    -    coverage is minimal. If someone is adjusting a "test_must_be_empty"
    -    test a failure might go away under "-x", but the new "say" we emit
    -    here should highlight that appropriately.
    +    We've thus solved the TODO item noted when "test_untraceable" was
    +    added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
    +    as untraceable with '-x', 2018-02-24).
     
    -    Since the only user of "test_untraceable" is gone, we can remove that,
    -    not only isn't it used now, but I think the rationale for using it in
    -    the future no longer applies.
    +    So let's remove the feature entirely. Not only is it currently unused,
    +    but it actively encourages an anti-pattern in our tests. We should be
    +    testing the output of specific commands, not entire subshells or
    +    functions.
     
    -    We'll be better off by using a simple wrapper like the new
    -    "test_must_be_empty_trace". See 58275069288 (t1510-repo-setup: mark as
    -    untraceable with '-x', 2018-02-24) and 5fc98e79fc0 (t: add means to
    -    disable '-x' tracing for individual test scripts, 2018-02-24) for the
    -    addition of "test_untraceable".
    -
    -    Once that's been removed we can dig deeper and see that we only have
    -    "BASH_XTRACEFD" due to an earlier attempt to work around the same
    -    issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
    -    2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
    -    bash, 2017-12-08) follow-up.
    -
    -    I.e. we had redirection in "test_eval_" to get more relevant trace
    -    output under bash, which in turn was only needed because
    -    BASH_XTRACEFD=1 was set, which in turn was trying to work around test
    -    failures under "set -x".
    -
    -    It's better if our test suite works the same way on all shells, rather
    -    than getting a passing run under "bash", only to have it fail with
    -    "-x" under say "dash". As the deleted code shows this is much simpler
    -    to implement across our supported POSIX shells.
    +    That the "-x" output had to be disabled as a result is only one
    +    symptom, but even under bash those tests will be harder to debug as
    +    the subsequent check of the redirected file will be far removed from
    +    the command that emitted the output.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/README: appropriately before running "make". Short options can be bundled, i.e
      -d::
      --debug::
     
    - ## t/t1510-repo-setup.sh ##
    -@@ t/t1510-repo-setup.sh: A few rules for repo setup:
    -     prefix is NULL.
    - "
    - 
    --# This test heavily relies on the standard error of nested function calls.
    --test_untraceable=UnfortunatelyYes
    -+test_must_be_empty_trace () {
    -+	if want_trace
    -+	then
    -+		say "$TEST_NAME does not check test_must_be_empty on \"$@\" under -x"
    -+		return 0
    -+	fi
    -+	test_must_be_empty "$@"
    -+}
    - 
    - TEST_PASSES_SANITIZE_LEAK=true
    - . ./test-lib.sh
    -@@ t/t1510-repo-setup.sh: test_expect_success '#0: nonbare repo, no explicit configuration' '
    - 	try_repo 0 unset unset unset "" unset \
    - 		.git "$here/0" "$here/0" "(null)" \
    - 		.git "$here/0" "$here/0" sub/ 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
    - 	try_repo 1 "$here" unset unset "" unset \
    - 		"$here/1/.git" "$here" "$here" 1/ \
    - 		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#4: core.worktree without GIT_DIR set is accepted' '
    - 	try_case 4 unset unset \
    - 		.git "$here/4/sub" "$here/4" "(null)" \
    - 		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
    - 	try_repo 5a .. unset "$here/5a" "" unset \
    - 		"$here/5a/.git" "$here" "$here" 5a/ \
    - 		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#9: GIT_WORK_TREE accepted with gitfile' '
    - 	try_repo 9 wt unset unset gitfile unset \
    - 		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
    - 		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#10: GIT_DIR can point to gitfile' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#12: core.worktree with gitfile is accepted' '
    - 	try_repo 12 unset unset "$here/12" gitfile unset \
    - 		"$here/12.git" "$here/12" "$here/12" "(null)" \
    - 		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
    - 	try_repo 13 non-existent-too unset non-existent gitfile unset \
    - 		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
    - 		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - # case #14.
    -@@ t/t1510-repo-setup.sh: test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
    - 	try_repo 17c "$here/17c" unset unset "" true \
    - 		.git "$here/17c" "$here/17c" "(null)" \
    - 		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#20a: core.worktree without GIT_DIR accepted (inside .git)'
    - 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
    - 	try_case 20a/.git/wt/sub unset unset \
    - 		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#20b/c: core.worktree and core.bare conflict' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#21: setup, core.worktree warns before overriding core.bare
    - 		export GIT_WORK_TREE &&
    - 		git status >/dev/null
    - 	) 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - 
    - '
    - run_wt_tests 21
    -@@ t/t1510-repo-setup.sh: test_expect_success '#25: GIT_WORK_TREE accepted if GIT_DIR unset (bare gitfile
    - 	try_repo 25 "$here/25" unset unset gitfile true \
    - 		"$here/25.git" "$here/25" "$here/25" "(null)"  \
    - 		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - 
    - test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
    -@@ t/t1510-repo-setup.sh: test_expect_success '#29: setup' '
    - 		export GIT_WORK_TREE &&
    - 		git status
    - 	) 2>message &&
    --	test_must_be_empty message
    -+	test_must_be_empty_trace message
    - '
    - run_wt_tests 29 gitfile
    - 
    -
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: then
      	exit
-- 
2.34.1.876.gdb91009a90c

