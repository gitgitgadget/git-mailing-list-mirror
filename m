Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52746C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 01:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhLMBiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 20:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhLMBik (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 20:38:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B196C06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so13084982wme.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 17:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjczrUCMH9n1SauRQdxNmzNVLegJe74+pnFu9VU+YMs=;
        b=Dp1QFn7bziKlO6i0WNRMlUrBG+36Zz4VHyNiWxiaf3u8dIEh0SVlaadlGyP2ghUabU
         o5Ld8r33VwgqUoK3Gb9FRu3I+pJhRIyv/7rt2fOoYHrtTNSfO7SWI1qXR6BI7ClnGxTP
         dyKIP/7ZR/TDzc4KrUzLp1yqLwkCEop9CUTHXQo6T0DYqWITbK/ewPfMm55KMpjg9cx6
         tACAT4fouP+6OS/kKBoKDmlXlKgIuen1XP5Ksf3u2S4xGC20tWxyc7o8QwfRKdgFRS8l
         0ZZ3jNFO8t7Gs8es53TTi2DTR7uR8tPmTiuRDUdlB2wNbHe6bWFIwEsffmdKLIphQsvU
         RtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjczrUCMH9n1SauRQdxNmzNVLegJe74+pnFu9VU+YMs=;
        b=X9qp18tB0fiB3iPEu0LcdYBRD/poiTDffb9riYPpAagRLcxxVtGgBmZEDB6HLEvWsN
         VHCHlTSyfGpJVU/q4WuG30ip1Lr1m9iC/sg/vFV1SZNT30Q4yWy0o+ZpBov8nQzWr3v2
         pEdcfByTvT7Ri0Lzd4S/r+9vYLWd6gFdQ0+0a0YIOzBbdneVZ5mK49Hgljzn43oeseJE
         Myd2gqVDytUWnI1ozdWXU084Sue+K4+J7sIQP9QnCOUVZHxFNL5cmsTamsRH/04KhOVS
         578XTxMYiE6etavGz5St2uflLYVpEOR5tYgXA/Dc3CqYDIGM2u/U6oHPLDEt8uAOKRN7
         i3oA==
X-Gm-Message-State: AOAM531QQxA/BVOjZhiLfPyBVZl8OCGPNGYtKtJ6ANRdu8vIqn3caxuu
        pVCDIW2A2YF4A35+7LMPIY078UaG9zRAgg==
X-Google-Smtp-Source: ABdhPJxVHXeAW/mdMEzslL9isy25NwecNCifGqWAe1V/yyRWcx8pD40sVzeXKB97LEDPahhdkwBoeA==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr34000254wmq.117.1639359518577;
        Sun, 12 Dec 2021 17:38:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm11571303wrs.59.2021.12.12.17.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 17:38:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/3] test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
Date:   Mon, 13 Dec 2021 02:38:33 +0100
Message-Id: <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1024.g573f2f4b767
In-Reply-To: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-arrangement-only change to v3[1]. The previous 2/2 is now split
into two commits, as requested by SZEDER[2] in the removal of
BASH_XTRACEFD is now its own commit & the rationale for doing so is
outlined in detail.

1. https://lore.kernel.org/git/cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com/
2. https://lore.kernel.org/git/20211212201441.GB3400@szeder.dev/

Ævar Arnfjörð Bjarmason (3):
  t1510: remove need for "test_untraceable", retain coverage
  test-lib.sh: remove the now-unused "test_untraceable" facility
  test-lib.sh: remove "BASH_XTRACEFD"

 t/README              |  3 --
 t/t1510-repo-setup.sh | 85 +++++++++++++++++++++----------------------
 t/test-lib.sh         | 66 ++++-----------------------------
 3 files changed, 49 insertions(+), 105 deletions(-)

Range-diff against v3:
1:  7876202c5b0 = 1:  9e7b089dc50 t1510: remove need for "test_untraceable", retain coverage
-:  ----------- > 2:  60883fd95cb test-lib.sh: remove the now-unused "test_untraceable" facility
2:  a7fc794e20d ! 3:  8b5ae33376e test-lib.sh: remove the now-unused "test_untraceable" facility
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib.sh: remove the now-unused "test_untraceable" facility
    +    test-lib.sh: remove "BASH_XTRACEFD"
     
    -    In the preceding commit the use of "test_untraceable=UnfortunatelyYes"
    -    was removed from "t1510-repo-setup.sh" in favor of more narrow
    -    redirections of the output of specific commands (and not entire
    -    sub-shells or functions).
    +    Stop setting "BASH_XTRACEFD=4" to direct "-x" output to file
    +    descriptor 4 under bash.
     
    -    This is in line with the fixes in the series that introduced the
    -    "test_untraceable" facility. See 571e472dc43 (Merge branch
    -    'sg/test-x', 2018-03-14) for the series as a whole, and
    -    e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
    -    subshell, 2018-02-24) for a commit that's in line with the changes in
    -    the preceding commit.
    +    When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
    +    automatically, 2016-05-11) it was needed as a workaround for various
    +    tests that didn't pass cleanly under "-x".
     
    -    We've thus solved the TODO item noted when "test_untraceable" was
    -    added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
    -    as untraceable with '-x', 2018-02-24).
    +    Most of those were later fixed in 71e472dc43 (Merge branch
    +    'sg/test-x', 2018-03-14), and in the preceding commits we've fixed the
    +    final remaining and removed the "test_untraceable" facility.
     
    -    So let's remove the feature entirely. Not only is it currently unused,
    -    but it actively encourages an anti-pattern in our tests. We should be
    -    testing the output of specific commands, not entire subshells or
    -    functions.
    +    The reason we don't need this anymore is becomes clear from reading
    +    the rationale in d88785e424a and applying those arguments to the
    +    current state of the codebase. In particular it said (with "this" and
    +    "it" referring to the problem of tests failing under "-x"):
     
    -    That the "-x" output had to be disabled as a result is only one
    -    symptom, but even under bash those tests will be harder to debug as
    -    the subsequent check of the redirected file will be far removed from
    -    the command that emitted the output.
    +        "there here isn't a portable or scalable solution to this [...] we
    +        can work around it by pointing the "set -x" output to our
    +        descriptor 4"
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    And finally that:
     
    - ## t/README ##
    -@@ t/README: appropriately before running "make". Short options can be bundled, i.e.
    - -x::
    - 	Turn on shell tracing (i.e., `set -x`) during the tests
    - 	themselves. Implies `--verbose`.
    --	Ignored in test scripts that set the variable 'test_untraceable'
    --	to a non-empty value, unless it's run with a Bash version
    --	supporting BASH_XTRACEFD, i.e. v4.1 or later.
    - 
    - -d::
    - --debug::
    +        "Automatic tests for our "-x" option may be a bit too meta"
    +
    +    Those tests are exactly what we've had since aedffe95250 (travis-ci:
    +    run tests with '-x' tracing, 2018-02-24), so punting on fixing issues
    +    with "-x" by using "BASH_XTRACEFD=4" isn't needed anymore, we're now
    +    committing to maintaining the test suite in a way that won't break
    +    under "-x".
    +
    +    We could retain "BASH_XTRACEFD=4" anyway, but doing so is bad because:
    +
    +     1) Since we're caring about "-x" passing in CI under "dash" on Ubuntu
    +        using "BASH_XTRACEFD=4" will amount to hiding an error we'll run
    +        into eventually. Tests will pass locally with "bash", but fail in
    +        CI with "dash" (or under other non-"bash" shells).
    +
    +     2) As the amended code in "test_eval_" shows (an amended revert to
    +        the pre-image of d88785e424a) it's simpler to not have to take
    +        this "bash" special-case into account.
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib.sh ##
    -@@ t/test-lib.sh: then
    - 	exit
    - fi
    - 
    --if test -n "$trace" && test -n "$test_untraceable"
    --then
    --	# '-x' tracing requested, but this test script can't be reliably
    --	# traced, unless it is run with a Bash version supporting
    --	# BASH_XTRACEFD (introduced in Bash v4.1).
    --	#
    --	# Perform this version check _after_ the test script was
    --	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
    --	# '--verbose-log', so the right shell is checked and the
    --	# warning is issued only once.
    --	if test -n "$BASH_VERSION" && eval '
    --	     test ${BASH_VERSINFO[0]} -gt 4 || {
    --	       test ${BASH_VERSINFO[0]} -eq 4 &&
    --	       test ${BASH_VERSINFO[1]} -ge 1
    --	     }
    --	   '
    --	then
    --		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
    --	else
    --		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
    --		trace=
    --	fi
    --fi
    - if test -n "$trace" && test -z "$verbose_log"
    - then
    - 	verbose=t
     @@ t/test-lib.sh: else
      	exec 4>/dev/null 3>/dev/null
      fi
-- 
2.34.1.1024.g573f2f4b767

