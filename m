Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF5EC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiCGMuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiCGMuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA34DF72
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:23 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so10756351wmj.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Dj0VA9aMm31hU8kdtChxba4uoq3oSO4kDdOlUNVeOY=;
        b=YfV2KVGr+21igtFVYEQAo+FtHac7pr4xq2oG4qhQcqn3QB46h+J4ihYbPIhDKMterD
         2ilWNTv5Q+JHIjsNpXRYkVORHG8mtyHhBCUxNlSoNgo21aDNJfLJ6TgAGnepjDTGzAMV
         KjARq9wWCbfqQIIfzWhZVXObVbp2bdtZ3s2xfS22M/wp2/DiRFj+Ep9TaasmQaM5EQ4O
         jK6NWn/iH4pg/ul8B/YP7fbclFFNUqeSdVvU0yUptR+lMsZisbLZdnPty0t+Mfpk2Cw6
         aQqk/qm7yeKLOCq6xDwY5MHDdb7ZHzoI8VEHTfMtPGx7XsZ4ataqgtNFi6Q0DdTbElJI
         iJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Dj0VA9aMm31hU8kdtChxba4uoq3oSO4kDdOlUNVeOY=;
        b=20FAXD7M7D+lI0QZMi2m9eo5UTeouioKVfsA6feaeo4wNAbDdBYdckI60fktZEJFwm
         MfUcKb9DMPbMJG69C9hgi19aMCYnjcpTT1Bg7qO3Bfks6+SX+wSXEYU9Hg5wy3uLT3rG
         nAklAp/xlpoWOx/Zz6h/e67kAg2f3K2aA0B9RZP2YWwofXe8w84ScbvvfrgfPB6cLaru
         4QH8/zUT9Hxt5xPus6wLuPq9hL+wIr/RBMPytupvdBjxKcFEh4JpHgI3cPGveT2Y1SRU
         hZYnrTnHxJFu6bu1u1rerkY5CK9Pvd59op3xTcPhmkEHmKYtWTCPDApRPG+uowv2z5TN
         oXsQ==
X-Gm-Message-State: AOAM531/sPN9IQVz38h3tO83CF8lK01bGV2d9TjCot+abpvj9FDIa7el
        qTVW+/u1yaKB3LLQo/A16Gjr3E9Fo2zEcw==
X-Google-Smtp-Source: ABdhPJxr8D/VR94wguGVlcHziFC4YQQC+dpaiaIwM0hiHfKjFhroxXB6hbNUuXRS24zuwe2uMMwJvQ==
X-Received: by 2002:a7b:c38f:0:b0:385:e56c:8624 with SMTP id s15-20020a7bc38f000000b00385e56c8624mr18578161wmj.19.1646657361389;
        Mon, 07 Mar 2022 04:49:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/15] tests: don't ignore "git" exit codes
Date:   Mon,  7 Mar 2022 13:48:51 +0100
Message-Id: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes issues where we ignored the exit code of "git" due
to it being on the LHS of a pipe, or because we interpolated its
output with $() in a "test" construct, or had missing &&- chains in
helper functions etc.

As noted in v1
(https://lore.kernel.org/git/cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com/)
this is not a general search/replacement, but fixes real issues we run
into with SANITIZE=leak.

Changes since v1:

 * Minor commit message improvement for 11/15
 * Added a comment for some non-obvious prereq setup code, as
   suggested by Junio.

Ævar Arnfjörð Bjarmason (15):
  tests: change some 'test $(git) = "x"' to test_cmp
  tests: use "test_stdout_line_count", not "test $(git [...] | wc -l)"
  read-tree tests: check "diff-files" exit code on failure
  diff tests: don't ignore "git diff" exit code
  diff tests: don't ignore "git diff" exit code in "read" loop
  apply tests: use "test_must_fail" instead of ad-hoc pattern
  merge tests: use "test_must_fail" instead of ad-hoc pattern
  rev-parse tests: don't ignore "git reflog" exit code
  notes tests: don't ignore "git" exit code
  diff tests: don't ignore "git rev-list" exit code
  rev-list tests: don't hide abort() in "test_expect_failure"
  gettext tests: don't ignore "test-tool regex" exit code
  apply tests: don't ignore "git ls-files" exit code, drop sub-shell
  checkout tests: don't ignore "git <cmd>" exit code
  rev-list simplify tests: don't ignore "git" exit code

 t/t0002-gitfile.sh                     |   6 +-
 t/t1001-read-tree-m-2way.sh            |   6 +-
 t/t1002-read-tree-m-u-2way.sh          |   6 +-
 t/t1503-rev-parse-verify.sh            |   5 +-
 t/t2012-checkout-last.sh               |  51 ++++++---
 t/t2200-add-update.sh                  |  33 ++++--
 t/t3302-notes-index-expensive.sh       |   6 +-
 t/t3303-notes-subtrees.sh              |   9 +-
 t/t3305-notes-fanout.sh                |  14 +--
 t/t4020-diff-external.sh               | 153 ++++++++++++-------------
 t/t4027-diff-submodule.sh              |   7 +-
 t/t4123-apply-shrink.sh                |  18 +--
 t/t4128-apply-root.sh                  |  36 +++---
 t/t6005-rev-list-count.sh              |  43 ++++---
 t/t6012-rev-list-simplify.sh           |  12 +-
 t/t6102-rev-list-unexpected-objects.sh |  13 ++-
 t/t6407-merge-binary.sh                |  22 +---
 t/t7103-reset-bare.sh                  |   7 +-
 t/t7812-grep-icase-non-ascii.sh        |  16 ++-
 19 files changed, 245 insertions(+), 218 deletions(-)

Range-diff against v1:
 1:  78b9c52551f =  1:  78b9c52551f tests: change some 'test $(git) = "x"' to test_cmp
 2:  e1105b029d6 =  2:  e1105b029d6 tests: use "test_stdout_line_count", not "test $(git [...] | wc -l)"
 3:  5f02e30d1ab =  3:  5f02e30d1ab read-tree tests: check "diff-files" exit code on failure
 4:  a425ced5609 =  4:  a425ced5609 diff tests: don't ignore "git diff" exit code
 5:  b1aeac3f68e =  5:  b1aeac3f68e diff tests: don't ignore "git diff" exit code in "read" loop
 6:  7952ae1f3b5 =  6:  7952ae1f3b5 apply tests: use "test_must_fail" instead of ad-hoc pattern
 7:  276be19e35e =  7:  276be19e35e merge tests: use "test_must_fail" instead of ad-hoc pattern
 8:  dca2ac3a171 =  8:  dca2ac3a171 rev-parse tests: don't ignore "git reflog" exit code
 9:  ca9e12f2bac =  9:  ca9e12f2bac notes tests: don't ignore "git" exit code
10:  946397033d4 = 10:  946397033d4 diff tests: don't ignore "git rev-list" exit code
11:  26c838f0560 ! 11:  52397b3575a rev-list tests: don't hide abort() in "test_expect_failure"
    @@ Commit message
         "test_expect_success", but would allow us say "test_todo" here (and
         "success" would emit a "not ok [...] # TODO", not "ok [...]".
     
    -    In lieu of those larger changes let's more narrowly fix the problem at
    +    So even though using "test_expect_success" here comes with its own
    +    problems[2], let's use it as a narrow change to fix the problem at
         hand here and stop conflating the current "success" with actual
         SANITIZE=leak failures.
     
         1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/xmqq4k9kj15p.fsf@gitster.g/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
12:  f3cc5bc7eb9 ! 12:  552dcac705d gettext tests: don't ignore "test-tool regex" exit code
    @@ t/t7812-grep-icase-non-ascii.sh: test_expect_success GETTEXT_LOCALE 'setup' '
     -test-tool regex "HALLÓ" "Halló" ICASE &&
     -test_set_prereq REGEX_LOCALE
     +test_expect_success GETTEXT_LOCALE 'setup REGEX_LOCALE prerequisite' '
    ++	# This "test-tool" invocation is identical...
     +	if test-tool regex "HALLÓ" "Halló" ICASE
     +	then
     +		test_set_prereq REGEX_LOCALE
     +	else
    ++
    ++		# ... to this one, but this way "test_must_fail" will
    ++		# tell a segfault or abort() from the regexec() test
    ++		# itself
     +		test_must_fail test-tool regex "HALLÓ" "Halló" ICASE
     +	fi
     +'
13:  834809b1b8a = 13:  dbe8d168401 apply tests: don't ignore "git ls-files" exit code, drop sub-shell
14:  34cada14fec = 14:  22b81d7f93a checkout tests: don't ignore "git <cmd>" exit code
15:  4ee216711cf = 15:  16889ed154f rev-list simplify tests: don't ignore "git" exit code
-- 
2.35.1.1242.gfeba0eae32b

