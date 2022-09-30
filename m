Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1714AC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiI3LgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiI3Lf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90BF8C11
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so994336wrr.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YKk049Ax3rbA3lmiVT0hopDirceuswqAQ+tZYa0Gr9Y=;
        b=WEQ+F92vhRMQBm0JX44xCdjIRnyUy2ESt6a7gBi/x7BqOl4N5vcuB6SGArkUMl/F5r
         N2rHClRhcbS1LfH6MsUMRTHKTXqU1TOmhaRdQ/FxDWcmjSCHopJZSopjldNUqH7D50DJ
         KEqLwwnkNBAsnnOUhtO/TJJB/EBwGPVs+Wnq+m6m945BVBY4hV6j2MUKb1xbpx6hFRGK
         jMzrAbK+dXuRaRC9ysuQvBnYArmi/FzfD3UNrWG6OrA7Aw7LJooY1McZgkfbk/1Bvkwz
         SuFOdRVYjFb+wkK+krvJtdG3TxooBxN90dfNRD6yBJ7OK6aROLCo6gz5zuyjoMC4yBvC
         oAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YKk049Ax3rbA3lmiVT0hopDirceuswqAQ+tZYa0Gr9Y=;
        b=VCNoiecWDKW13m/gk7ZSswuFrUZARSyehrOAp1HnpAWRjSTDkl5BTCNcXxpp181Nw/
         w+vPfGZWNMwmSRw3TYTqNrMXPup0NmxJwXU97hI+nxtU7xvl88RkXJfKGgFJhDiJkkmV
         yu3Vp8Xshp1qT9j0eUgWU+GS8xFKDlCE3FQatPvaa6B8rxr8SJ2x0bqprJMwo0+Hw/gD
         54/a9YXGJQwbXppYvSFhOjSNPvMd2ZBb8BsnorWVDIjrRjsftOBmQs0qZUMahUvKW5Zg
         hZbwNNZk2Bu9W4ZBpDyj2vany/0IjIo+3ewBbDVvBMJ+1jWzl0493pzDNghcbOddkY8W
         vkTw==
X-Gm-Message-State: ACrzQf0EmznfpWU2iMgqVaVdRlccf2UWmR56ex2gJLBlrZGSnwI3Z/v7
        7FKDpuxsSwfNZDlLeCySXeLbXkSvcyVRdg==
X-Google-Smtp-Source: AMsMyM4SA4JoQ1OjOerdegbun0eF643Ki34AwwyvQlatEM9xtaV58aV1ycLF1wfYj5A2qza5o8dYKA==
X-Received: by 2002:a05:6000:1cc:b0:22a:e8c6:9f57 with SMTP id t12-20020a05600001cc00b0022ae8c69f57mr5262520wrx.527.1664537295902;
        Fri, 30 Sep 2022 04:28:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/15] run-command API: pass functions & opts via struct
Date:   Fri, 30 Sep 2022 13:27:57 +0200
Message-Id: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the run-command API so that we pass options via a
struct instead of via the argument list, the end result is that an API
user looks like e.g.:
	
	+       const struct run_process_parallel_opts opts = {
	+               .tr2_category = "submodule",
	+               .tr2_label = "parallel/update",
	+
	+               .jobs = update_data->max_jobs,
	+
	+               .get_next_task = update_clone_get_next_task,
	+               .start_failure = update_clone_start_failure,
	+               .task_finished = update_clone_task_finished,
	+               .data = &suc,
	+       };
	[...]
	-       run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
	-                                  update_clone_start_failure,
	-                                  update_clone_task_finished, &suc, "submodule",
	-                                  "parallel/update");
	+       run_processes_parallel(&opts);


These patches are derived from earlier patches I sent for passing the
the "ungroup" parameter to this API[1], that's currently done with a
global variable, because we needed a minimal change for a regression
fix.

I'm submitting this now in the rc phase because there's another
concurrent series that could make use of this[2]. The alternative
would be for it to add an extra parameter to the two functions (one
after this series).

The upcoming migration to the new hook API and config-based hooks[3]
will also benefit significantly from this. I have a version of that
topic rebased on top of this, having this first gets rid of a lot of
churn, adding an optional callback just requires adding things to the
struct introduced here, not changing every single caller.

(Passing) CI at:
https://github.com/avar/git/tree/avar/hook-run-process-parallel-tty-regression-2-argument-passing

1. https://lore.kernel.org/git/cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com/
2. https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/
3. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/

Brief commentary on individual patches below:

Ævar Arnfjörð Bjarmason (15):
  hook tests: fix redirection logic error in 96e7225b310
  submodule tests: reset "trace.out" between "grep" invocations

These bugfixes could be split out I suppose, but since we're changing
this area 1/15 seemed prudent, 2/15 is required for a later test
addition

  run-command tests: test stdout of run_command_parallel()

Tighten up tests, was ejected from the "ungroup" topic.

  run-command test helper: use "else if" pattern
  run-command tests: use "return", not "exit"

Just setup for later changes.

  run-command API: have "run_processes_parallel{,_tr2}()" return void

Turns out we've never used the boilerplate return value for anything
useful ever.

  run-command API: make "jobs" parameter an "unsigned int"
  run-command API: don't fall back on online_cpus()

This allows us to make the "opts" struct "const", which helps a lot in
passing it around later on.

  run-command.c: add an initializer for "struct parallel_processes"
  run-command API: add nascent "struct run_process_parallel_opts"
  run-command API: make run_process_parallel{,_tr2}() thin wrappers
  run-command API: have run_process_parallel() take an "opts" struct
  run-command API: move *_tr2() users to "run_processes_parallel()"

This is arguably one logical change (and at some point I had it as
such), but as the diff would be really large I've tried to split this
into easily digestable steps.

  run-command.c: don't copy *_fn to "struct parallel_processes"
  run-command.c: don't copy "ungroup" to "struct parallel_processes"

The only reason for copying various parameters into "struct
parallel_processes" was because we passed them as positionals, now
that we have an "opts" struct we can just pass that along instead.

This leaves the "struct parallel_processes" in run-command.c purely
for managing our own internal state.

By avoiding this copying we also cut down a lot on the boilerplate
needed to add a new parameter.

 builtin/fetch.c             |  25 +++---
 builtin/submodule--helper.c |  16 +++-
 hook.c                      |  23 +++---
 run-command.c               | 152 ++++++++++++++----------------------
 run-command.h               |  71 ++++++++++++-----
 submodule-config.c          |   2 +
 submodule.c                 |  18 +++--
 t/helper/test-run-command.c |  77 +++++++++++-------
 t/t0061-run-command.sh      |  25 +++---
 t/t1800-hook.sh             |   2 +-
 t/t5526-fetch-submodules.sh |  16 +++-
 11 files changed, 247 insertions(+), 180 deletions(-)

-- 
2.38.0.rc2.935.g6b421ae1592

