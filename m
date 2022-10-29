Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A88FA3741
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 03:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJ2DCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 23:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ2DCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 23:02:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA3BE1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v27so10416850eda.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YeI833fOQ9ZOpGPVOzgDJambp8FRkc8hJpk0Wjc+eo=;
        b=CtTjhNBVSmMFZCcvEQTYDAWRHAt1hGa18JlHM2Q+E0wJeLewLqKRoeCKZybLtFqU2M
         EikTEjC77n4fc2aZzrcLjBo61OwIOUDCORvuI6+jwY0/PPAFkYSnMN1pcy/tJ1/B+XDr
         gjKhOnTOCejeDLKEZelSOqw3xidfCPAm8LfvLT0MWv5/35F5Ed+W88hgwo7G/ugSucSL
         hjqusyPkfFQofit4alUB/S8wT7rNXypTQxT5e9wbu51Fo4urLw52z1t4KKNcayf6itvu
         ZA7gpPlaI+W+2x9vMKelbbWN3CsUPsMI9an9x8klxG/7o9qaIhs3gr37wnPjsMRMi4Ct
         zmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YeI833fOQ9ZOpGPVOzgDJambp8FRkc8hJpk0Wjc+eo=;
        b=EWrDhyUt6+SchxtOje4FcqgEH0V54ZpNAVfHhCJY2vlL5kSNcDUPwIHa/4I1GDOVJg
         y4Wc0VdedR5/F81kOstjEeK/1B7lUbeLo+Cg61CDfcdlEQpaeD4ZIEyA2NmwGF2wQj27
         zeozMfdWAN8uQIjZNxrpBaiYrr2H4t+7Ajml4bXjBK6YchqCjnIseLDN/fIb7bE10kP3
         v16YiY0qTEB9AmJlet7uvGil4kF+URJf8Yh9JWcI2v9dXpaYL5f7ml2g95GvDNJlHYp1
         CGmi3cLA0cHvc89/MBH/BLZtaBoUN5MciQefsWG99Sk982RBJpNWYj5kINtNeDt/WX4z
         I2ng==
X-Gm-Message-State: ACrzQf36spHu5JwjFFKhW3d+p7/4DblHl0OqxyEAYHR6mzwJVmrYJmh5
        27HOmJbJzcHFDtm8F375UxPk+fJSo8g=
X-Google-Smtp-Source: AMsMyM7gAc8VYuTFWfCglkcnwsWfWMwr5L6NZSAFXne+/45zY3zL6hq7fX7BexG7hlM4dHfj46HxvQ==
X-Received: by 2002:a05:6402:e87:b0:456:c93c:5361 with SMTP id h7-20020a0564020e8700b00456c93c5361mr2347720eda.88.1667012474166;
        Fri, 28 Oct 2022 20:01:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dy14-20020a05640231ee00b00461621cae1fsm195393edb.16.2022.10.28.20.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:01:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] tests: improve misc run-command, hook, submodule tests
Date:   Sat, 29 Oct 2022 04:59:44 +0200
Message-Id: <cover-0.3-00000000000-20221029T025520Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are small tests changes left out of[1], which has since
graduated as 6ae1a6eaf26 (Merge branch 'ab/run-hook-api-cleanup',
2022-10-27). The range-diff is to the relevant part of v2 of that
topic.

I updated the commit message of 2/3, and adjusted 3/3 to make the diff
smaller, but functionally the same as far as how the test works.

These changes have already been reviewed, and the only
(understandable) objection was that they were side-tracks in v2 of [1]
that we could do without in the context of that topic.

1. https://lore.kernel.org/git/cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  hook tests: fix redirection logic error in 96e7225b310
  submodule tests: reset "trace.out" between "grep" invocations
  run-command tests: test stdout of run_command_parallel()

 t/t0061-run-command.sh      | 15 ++++++++++-----
 t/t1800-hook.sh             |  2 +-
 t/t5526-fetch-submodules.sh |  8 ++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

Range-diff:
1:  bc51dfcb1be = 1:  1ba41a5842c hook tests: fix redirection logic error in 96e7225b310
2:  3027f5587a7 ! 2:  708375e3104 submodule tests: reset "trace.out" between "grep" invocations
    @@ Commit message
         not print out a "9 tasks" line, but let's be paranoid and stop
         implicitly assuming that that's the case.
     
    +    This change was originally left out of 51243f9f0f6 (run-command API:
    +    don't fall back on online_cpus(), 2022-10-12), which added the
    +    ">trace.out" seen at the end of the context.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t5526-fetch-submodules.sh ##
    @@ t/t5526-fetch-submodules.sh: test_expect_success "'fetch.recurseSubmodules=on-de
     +		>trace.out &&
     +
      		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
    --		grep "9 tasks" trace.out
    -+		grep "9 tasks" trace.out &&
    -+		>trace.out &&
    - 	)
    - '
    - 
    + 		grep "9 tasks" trace.out &&
    + 		>trace.out &&
3:  c4923358bbd ! 3:  6d6c2241bf2 run-command tests: test stdout of run_command_parallel()
    @@ t/t0061-run-command.sh: World
      
      test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
     -	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    --	test_cmp expect actual
    -+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
     +	test_must_be_empty out &&
    -+	test_cmp expect err
    + 	test_cmp expect actual
      '
      
    - test_expect_success 'run_command runs ungrouped in parallel with more jobs available than tasks' '
     @@ t/t0061-run-command.sh: test_expect_success 'run_command runs ungrouped in parallel with more jobs avail
      '
      
      test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
     -	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    --	test_cmp expect actual
    -+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
     +	test_must_be_empty out &&
    -+	test_cmp expect err
    + 	test_cmp expect actual
      '
      
    - test_expect_success 'run_command runs ungrouped in parallel with as many jobs as tasks' '
     @@ t/t0061-run-command.sh: test_expect_success 'run_command runs ungrouped in parallel with as many jobs as
      '
      
      test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
     -	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    --	test_cmp expect actual
    -+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
     +	test_must_be_empty out &&
    -+	test_cmp expect err
    + 	test_cmp expect actual
      '
      
    - test_expect_success 'run_command runs ungrouped in parallel with more tasks than jobs available' '
     @@ t/t0061-run-command.sh: asking for a quick stop
      EOF
      
      test_expect_success 'run_command is asked to abort gracefully' '
     -	test-tool run-command run-command-abort 3 false 2>actual &&
    --	test_cmp expect actual
    -+	test-tool run-command run-command-abort 3 false >out 2>err &&
    ++	test-tool run-command run-command-abort 3 false >out 2>actual &&
     +	test_must_be_empty out &&
    -+	test_cmp expect err
    + 	test_cmp expect actual
      '
      
    - test_expect_success 'run_command is asked to abort gracefully (ungroup)' '
     @@ t/t0061-run-command.sh: no further jobs available
      EOF
      
      test_expect_success 'run_command outputs ' '
     -	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    --	test_cmp expect actual
    -+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>err &&
    ++	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" >out 2>actual &&
     +	test_must_be_empty out &&
    -+	test_cmp expect err
    + 	test_cmp expect actual
      '
      
    - test_expect_success 'run_command outputs (ungroup) ' '
-- 
2.38.0.1280.g8136eb6fab2

