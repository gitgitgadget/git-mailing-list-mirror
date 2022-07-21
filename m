Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821AEC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiGUGvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGUGvv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1C42ADA
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k11so399678wrx.5
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U01dOHqe+06BhgdmPOxTblmxmMdBI/nN5jeht+4phHc=;
        b=fx21Bly40wm4Kjam0sYGpqnBpxJH8YuvFKl8siMybQvb6yPl4HUQP7ocS3eCnmnRqK
         EPlWbKgooUD1Isp3hhzqrq8GcOdcD7EiukdAfGe2zZBZvEovPR/hngaO7kYSJto4cOPW
         70s0cQxeXErbdsAEAMzOUSXnMQxyF8eQLJLeALytnJc5EwhWuJSt6sWbm+i7xnIyGnM2
         sC13XWV+g0JE2msQlSaWFU2ZzEwpC3c1tCJQbAdKmv3gvwRASMRShA82Mz97sxy0WMrO
         3xD86LKji9VolQTrCAlwKBqo/lcTAhQoEizrnMjrtkA13AdOYJm7PJRPIuY/Jjt8D2tG
         n+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U01dOHqe+06BhgdmPOxTblmxmMdBI/nN5jeht+4phHc=;
        b=FkqeapY/wynY1gBWOWVPOkS4kTCHKHXNqGykOLoOd72fHJVCFYui/YVBfpMN0QflM2
         2HOv5C0tY0X450OonDLKg9xuUf0bFLSQ0ReSmiQ5aJEd1GrQrYs2Q1Yfvez7+6Ea3kLU
         I+uN+ZwOXys1quRCHHNitKEoDzH4YmJ8lo5KCVL7bmf1zT/QTTPCkmKLGNVS7LguH+dM
         ANKumDCWTkxdwW6M8NprrLTycVdKST9/O5/a3XQf9ZFH+tquSz/tuw74cJLCjX4YLV/U
         NmPJsjklfd1nyoZjzzv+dZs2nPn7qLrh1+OTTbhkUlBcVc0JZmgkR0siM6L2ALI1BPwo
         V7ZA==
X-Gm-Message-State: AJIora9a2rACR0Hjsw4J8dFQ1wwdpjkJWJEE7Z6soyUYdAVxSej153vt
        GhkX/LY0CUCmeZ3HokIkczK356DinVuBmw==
X-Google-Smtp-Source: AGRyM1s9qD551IJcCoyxiaYHSpXhqLuzKvscGFTSs1WwlAWkN6LOVEeYO1KnbGAsrKnzxMc28m+T9A==
X-Received: by 2002:a05:6000:15c3:b0:21d:9f5a:df83 with SMTP id y3-20020a05600015c300b0021d9f5adf83mr34031176wry.360.1658386308289;
        Wed, 20 Jul 2022 23:51:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] tests: fix ignored & hidden exit codes
Date:   Thu, 21 Jul 2022 08:51:37 +0200
Message-Id: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small set of fixes to correct git on the LHS of a pipe, and in $()
within a "test" expression, or where its exit code is otherwise
hidden.

This also includes a (reworded) version of a case where we exit'd out
of test-lib.sh itself, which Junio requested by spun off in:
https://lore.kernel.org/git/xmqqmtd33e1h.fsf@gitster.g/

As noted in [1] there's no need to rebase the other series on top of
this, it benefits from 6/6 here, but the two can proceed
independently.

This is still just the tip of the iceberg in terms of hidden exit
codes in the test suite, as can be seen with e.g.:

	git grep 'test.*\$\((git|test-tool)' -- 't/*.sh'

But these are all cases I've run into actual issues with, almost all
when testing with SANITIZE=leak. In most cases just with one of the
hunks in a given commit, but then I converted the rest of the file to
fix a similar bad pattern.

That doesn't mean that these are more important than e.g. the output
of the "grep" above, but we've got to start somewhere...

The range-diff below is to the tip of [2], to show how 6/6 was
reworded.

1. https://lore.kernel.org/git/cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  diff tests: fix ignored exit codes in t4023
  t/lib-patch-mode.sh: fix ignored "git" exit codes
  auto-crlf tests: check "git checkout" exit code
  test-lib-functions: add and use test_cmp_cmd
  merge tests: don't ignore "rev-parse" exit code in helper
  log tests: don't use "exit 1" outside a sub-shell

 t/lib-patch-mode.sh               | 13 ++++++---
 t/t0027-auto-crlf.sh              | 14 +++++++---
 t/t0060-path-utils.sh             | 45 +++++++++++++++++--------------
 t/t4023-diff-rename-typechange.sh | 12 ++++-----
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t7600-merge.sh                  |  9 +++----
 t/test-lib-functions.sh           | 18 +++++++++++++
 7 files changed, 74 insertions(+), 39 deletions(-)

Range-diff:
-:  ----------- > 1:  f8a382841d5 diff tests: fix ignored exit codes in t4023
-:  ----------- > 2:  85c6ab40e91 t/lib-patch-mode.sh: fix ignored "git" exit codes
-:  ----------- > 3:  cfc1abbf7e3 auto-crlf tests: check "git checkout" exit code
-:  ----------- > 4:  df1b674b8a7 test-lib-functions: add and use test_cmp_cmd
-:  ----------- > 5:  563666f9426 merge tests: don't ignore "rev-parse" exit code in helper
1:  9cedf0cb0e2 ! 6:  259b4618fcb log tests: don't use "exit 1" outside a sub-shell
    @@ Commit message
         Using "exit 1" outside a sub-shell will cause the test framework
         itself to exit on failure, which isn't what we want to do here.
     
    -    This issue was spotted with the new
    -    "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode, i.e. that "git show"
    -    command leaks memory, and we'd thus "exit 1". Another implementation
    -    of "GIT_TEST_PASSING_SANITIZE_LEAK=check" or "--invert-exit-code"
    -    might have intercepted the "exit 1", and thus hidden the underlying
    -    issue here, but we correctly distinguish the two.
    +    This issue was spotted with the in-flight
    +    "GIT_TEST_PASSING_SANITIZE_LEAK=check" test mode[1]. This "git show"
    +    invocation currently leaks memory, and we'd thus "exit 1". This change
    +    was initially part of that topic[2] to demonstrate the correctness of
    +    the "check" implementation.
    +
    +    1. https://lore.kernel.org/git/patch-07.10-0961df2ab6c-20220719T205710Z-avarab@gmail.com/
    +    2. https://lore.kernel.org/git/patch-10.10-9cedf0cb0e2-20220719T205710Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.37.1.1095.g64a1e8362fd

