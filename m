Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF8C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E1121D91
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPgspRCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgIYMdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYMdm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D78CC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so2893127wmi.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7y6SfRMIjYy4ujvhkikz+HToSCukUb+jEH712wnQgYg=;
        b=TPgspRCHUbaNkhEaxmTH2raUQQrePqikjzZaxey9gOT3s/fXOu48cw3KiDkpEsgSV3
         QkrdlX1fbZGCgAhxRuniHsNsEsamIztgupopZk0o5dzqqRT8ETuB3Mf8+F/CaT2KHhQG
         URVLsZaJypVOFp+Ootw0cRW6dpxEp0RmK3+MRAJjLsWgbJ9aGKzyg1lxRcfOkq/je9hv
         chMVloMVJBTOYxFiNaRSuQ2Ly1UHiKdGS2JXp1Pv5NwBN4R7RpADmnfqmG3kG4LVc9+Z
         CkKraeDVg53LiRI8ommddEegXhL4mtWcUHJOVWGgCMauxvrT2+6QNL93WulY1mC++xoJ
         ABhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7y6SfRMIjYy4ujvhkikz+HToSCukUb+jEH712wnQgYg=;
        b=qJL6iQ/navUkocnfgCHQgwQ7t0UaKiFrHBB0sK2INCBOnn6CTwWaRutuSIqBJzsI4U
         ehndc47lcuRM44wciw+VcxYhXetdRYkQkQdHqaWzEasunNhqDzdp5P2UJT6lFpoHMIaA
         DybWH5cElpExCyk8hDL4vLR6KjuCffHCOwpQOwexFPjAMAn22+fck8aD/d/crTg+UGXg
         Y0CEqkA3Mfb/XiICz2kA+z2RU4oF77w7vHrVIPRoWmtpxT5Pd1hX27zA7q2yYiXxLDEc
         exgs4039XuNFQjC+X7oudn2WAlNcgdxe2rGD+zHUSg1OCjdKj4Z8PoKRuzsMjklem+yM
         HDeg==
X-Gm-Message-State: AOAM530FuCuaYI6qbAM1QCs5PfTZOw2f8K2th1BX559n3JctJjF9MksB
        omRCDJJyVI9jxH9XP7Jl/E71QW1Lb8U=
X-Google-Smtp-Source: ABdhPJwfJQA80XpdZ0ln88iUD3gj5cmkCfCTpU8PzQC3ncuBhThIRFb1IN8a0MQCyQQ/jCXowJ+XkA==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr3092749wmi.121.1601037220390;
        Fri, 25 Sep 2020 05:33:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm2969846wri.45.2020.09.25.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:33:39 -0700 (PDT)
Message-Id: <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 12:33:30 +0000
Subject: [PATCH v4 0/8] Maintenance II: prefetch, loose-objects, incremental-repack tasks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/maintenance-part-1 [2].

This patch series contains 9 patches that were going to be part of v4 of
ds/maintenance [1], but the discussion has gotten really long. To help, I'm
splitting out the portions that create and test the 'maintenance' builtin
from the additional tasks (prefetch, loose-objects, incremental-repack) that
can be brought in later.

[1] 
https://lore.kernel.org/git/pull.671.git.1594131695.gitgitgadget@gmail.com/
[2] 
https://lore.kernel.org/git/pull.695.v3.git.1598380426.gitgitgadget@gmail.com/

As detailed in [2], the 'git maintenance run' subcommand will run certain
tasks based on config options or the --task= arguments. The --auto option
indicates to the task to only run based on some internal check that there
has been "enough" change in that domain to merit the work. In the case of
the 'gc' task, this also reduces the amount of work done. 

The new maintenance tasks in this series are:

 * 'loose-objects' : prune packed loose objects, then create a new pack from
   a batch of loose objects.
 * 'pack-files' : expire redundant packs from the multi-pack-index, then
   repack using the multi-pack-index's incremental repack strategy.
 * 'prefetch' : fetch from each remote, storing the refs in 'refs/prefetch/
   /'.

These tasks are all disabled by default, but can be enabled with config
options or run explicitly using "git maintenance run --task=". 

Since [2] replaced the 'git gc --auto' calls with 'git maintenance run
--auto' at the end of some Git commands, users could replace the 'gc' task
with these lighter-weight changes for foreground maintenance.

The 'git maintenance' builtin has a 'run' subcommand so it can be extended
later with subcommands that manage background maintenance, such as 'start'
or 'stop'. These are not the subject of this series, as it is important to
focus on the maintenance activities themselves. I have an RFC series for
this available at [3].

[3] 
https://lore.kernel.org/git/pull.680.git.1597857408.gitgitgadget@gmail.com/

Updates in v3
=============

 * Several commit message, documentation, and test updates from Jonathan
   Tan's helpful review!

Updates since v2
================

 * Dropped "fetch: optionally allow disabling FETCH_HEAD update"
   
   
 * A lot of fallout from the change in the option parsing in v3 of
   Maintenance II.
   
   
 * Dropped the "verify, and delete and rewrite on failure" logic from the
   incremental-repack task. This might be added again later after it can be
   tested more thoroughly.
   
   

Updates since v1 (of this series)
=================================

 * PATCH 1 ("fetch: optionally allow disabling FETCH_HEAD update") was
   rewritten on-list. Getting a version out with this patch is the main
   reason for rolling a v2. (That, and Part I is re-rolled with a v2 and I
   want to make sure this series applies cleanly.)
   
   
 * The 'prefetch' and 'loose-objects' tasks had some review, but my proposed
   changes were not acked, so they may need another review.
   
   

UPDATES since v3 of [1]
=======================

 * The biggest change here is the use of "test_subcommand", based on
   Jonathan Nieder's approach. This requires having the exact command-line
   figured out, which now requires spelling out all --no- [quiet%7Cprogress] 
   options. I also added a bunch of "2>/dev/null" checks because of the
   isatty(2) calls. Without that, the behavior will change depending on
   whether the test is run with -x/-v or without.
   
   
 * The 0x7FFF/0x7FFFFFFF constant problem is fixed with an EXPENSIVE test
   that verifies it.
   
   
 * The option parsing has changed to use a local struct and pass that struct
   to the helper methods. This is instead of having a global singleton.
   
   

Thanks, -Stolee

Derrick Stolee (8):
  maintenance: add prefetch task
  maintenance: add loose-objects task
  maintenance: create auto condition for loose-objects
  midx: enable core.multiPackIndex by default
  midx: use start_delayed_progress()
  maintenance: add incremental-repack task
  maintenance: auto-size incremental-repack batch
  maintenance: add incremental-repack auto condition

 Documentation/config/core.txt        |   4 +-
 Documentation/config/maintenance.txt |  18 ++
 Documentation/git-maintenance.txt    |  48 ++++
 builtin/gc.c                         | 326 +++++++++++++++++++++++++++
 midx.c                               |  21 +-
 repo-settings.c                      |   6 +
 repository.h                         |   2 +
 t/t5319-multi-pack-index.sh          |  15 +-
 t/t7900-maintenance.sh               | 185 +++++++++++++++
 9 files changed, 603 insertions(+), 22 deletions(-)


base-commit: 25914c4fdeefd99b06e134496dfb9bbb58a5c417
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-696%2Fderrickstolee%2Fmaintenance%2Fgc-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-696/derrickstolee/maintenance/gc-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/696

Range-diff vs v3:

 1:  da64c51a81 ! 1:  7a62e224cf maintenance: add prefetch task
     @@ Commit message
          of a foreground fetch to make that 'git fetch' command much faster.
      
          However, if we simply ran 'git fetch <remote>' in the background,
     -    then the user running a foregroudn 'git fetch <remote>' would lose
     +    then the user running a foreground 'git fetch <remote>' would lose
          some important feedback when a new branch appears or an existing
          branch updates. This is especially true if a remote branch is
          force-updated and this isn't noticed by the user because it occurred
 2:  75e846456b ! 2:  f3a16fd324 maintenance: add loose-objects task
     @@ Commit message
             objects are created only by a user doing normal development.
             We noticed users with _millions_ of loose objects because VFS
             for Git downloads blobs on-demand when a file read operation
     -       requires populating a virtual file. This has potential of
     -       happening in partial clones if someone runs 'git grep' or
     -       otherwise evades the batch-download feature for requesting
     -       promisor objects.
     +       requires populating a virtual file.
      
          This step is based on a similar step in Scalar [1] and VFS for Git.
          [1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/LooseObjectsStep.cs
 3:  d6e382c43e ! 3:  931fff4883 maintenance: create auto condition for loose-objects
     @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
      +		git -c maintenance.loose-objects.auto=1 maintenance \
      +		run --auto --task=loose-objects 2>/dev/null &&
      +	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
     -+	for i in 1 2
     -+	do
     -+		printf data-A-$i | git hash-object -t blob --stdin -w &&
     -+		GIT_TRACE2_EVENT="$(pwd)/trace-loA-$i" \
     -+			git -c maintenance.loose-objects.auto=2 \
     -+			maintenance run --auto --task=loose-objects 2>/dev/null &&
     -+		test_subcommand ! git prune-packed --quiet <trace-loA-$i &&
     -+		printf data-B-$i | git hash-object -t blob --stdin -w &&
     -+		GIT_TRACE2_EVENT="$(pwd)/trace-loB-$i" \
     -+			git -c maintenance.loose-objects.auto=2 \
     -+			maintenance run --auto --task=loose-objects 2>/dev/null &&
     -+		test_subcommand git prune-packed --quiet <trace-loB-$i &&
     -+		GIT_TRACE2_EVENT="$(pwd)/trace-loC-$i" \
     -+			git -c maintenance.loose-objects.auto=2 \
     -+			maintenance run --auto --task=loose-objects 2>/dev/null &&
     -+		test_subcommand git prune-packed --quiet <trace-loC-$i || return 1
     -+	done
     ++	printf data-A | git hash-object -t blob --stdin -w &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
     ++		git -c maintenance.loose-objects.auto=2 \
     ++		maintenance run --auto --task=loose-objects 2>/dev/null &&
     ++	test_subcommand ! git prune-packed --quiet <trace-loA &&
     ++	printf data-B | git hash-object -t blob --stdin -w &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
     ++		git -c maintenance.loose-objects.auto=2 \
     ++		maintenance run --auto --task=loose-objects 2>/dev/null &&
     ++	test_subcommand git prune-packed --quiet <trace-loB &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace-loC" \
     ++		git -c maintenance.loose-objects.auto=2 \
     ++		maintenance run --auto --task=loose-objects 2>/dev/null &&
     ++	test_subcommand git prune-packed --quiet <trace-loC
      +'
      +
       test_done
 4:  d0f2ec70d9 = 4:  0fe2036aa8 midx: enable core.multiPackIndex by default
 5:  2cd3c803d9 = 5:  ce435bf784 midx: use start_delayed_progress()
 6:  0dd26bb584 ! 6:  d934899253 maintenance: add incremental-repack task
     @@ Documentation/git-maintenance.txt: loose-objects::
      +	The `incremental-repack` job repacks the object directory
      +	using the `multi-pack-index` feature. In order to prevent race
      +	conditions with concurrent Git commands, it follows a two-step
     -+	process. First, it deletes any pack-files included in the
     -+	`multi-pack-index` where none of the objects in the
     -+	`multi-pack-index` reference those pack-files; this only happens
     -+	if all objects in the pack-file are also stored in a newer
     -+	pack-file. Second, it selects a group of pack-files whose "expected
     -+	size" is below the batch size until the group has total expected
     -+	size at least the batch size; see the `--batch-size` option for
     -+	the `repack` subcommand in linkgit:git-multi-pack-index[1]. The
     -+	default batch-size is zero, which is a special case that attempts
     -+	to repack all pack-files into a single pack-file.
     ++	process. First, it calls `git multi-pack-index expire` to delete
     ++	pack-files unreferenced by the `multi-pack-index` file. Second, it
     ++	calls `git multi-pack-index repack` to select several small
     ++	pack-files and repack them into a bigger one, and then update the
     ++	`multi-pack-index` entries that refer to the small pack-files to
     ++	refer to the new pack-file. This prepares those small pack-files
     ++	for deletion upon the next run of `git multi-pack-index expire`.
     ++	The selection of the small pack-files is such that the expected
     ++	size of the big pack-file is at least the batch size; see the
     ++	`--batch-size` option for the `repack` subcommand in
     ++	linkgit:git-multi-pack-index[1]. The default batch-size is zero,
     ++	which is a special case that attempts to repack all pack-files
     ++	into a single pack-file.
      +
       OPTIONS
       -------
       --auto::
      
       ## builtin/gc.c ##
     -@@
     - #include "promisor-remote.h"
     - #include "refs.h"
     - #include "remote.h"
     -+#include "midx.h"
     - 
     - #define FAILED_RUN "failed to run %s"
     - 
      @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
       	return prune_packed(opts) || pack_loose(opts);
       }
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
       		"gc",
       		maintenance_task_gc,
      
     - ## midx.c ##
     -@@
     - 
     - #define PACK_EXPIRED UINT_MAX
     - 
     --static char *get_midx_filename(const char *object_dir)
     -+char *get_midx_filename(const char *object_dir)
     - {
     - 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
     - }
     -
     - ## midx.h ##
     -@@ midx.h: struct multi_pack_index {
     - 
     - #define MIDX_PROGRESS     (1 << 0)
     - 
     -+char *get_midx_filename(const char *object_dir);
     - struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
     - int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
     - int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
     -
       ## t/t5319-multi-pack-index.sh ##
      @@
       test_description='multi-pack-indexes'
     @@ t/t7900-maintenance.sh: test_description='git maintenance builtin'
       test_expect_success 'help text' '
       	test_expect_code 129 git maintenance -h 2>err &&
      @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.loose-objects.auto' '
     - 	done
     + 	test_subcommand git prune-packed --quiet <trace-loC
       '
       
      +test_expect_success 'incremental-repack task' '
 7:  f3b25a9927 = 7:  bade7706d5 maintenance: auto-size incremental-repack batch
 8:  e9bb32f53a ! 8:  f660dd1890 maintenance: add incremental-repack auto condition
     @@ Documentation/config/maintenance.txt: maintenance.loose-objects.auto::
      
       ## builtin/gc.c ##
      @@
     + #include "promisor-remote.h"
       #include "refs.h"
       #include "remote.h"
     - #include "midx.h"
      +#include "object-store.h"
       
       #define FAILED_RUN "failed to run %s"
     @@ t/t7900-maintenance.sh: test_expect_success EXPENSIVE 'incremental-repack 2g lim
      +		-c maintenance.incremental-repack.auto=1 \
      +		maintenance run --auto --task=incremental-repack 2>/dev/null &&
      +	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
     -+	for i in 1 2
     -+	do
     -+		test_commit A-$i &&
     -+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
     -+		HEAD
     -+		^HEAD~1
     -+		EOF
     -+		GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
     -+			-c maintenance.incremental-repack.auto=2 \
     -+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
     -+		test_subcommand ! git multi-pack-index write --no-progress <trace-A-$i &&
     -+		test_commit B-$i &&
     -+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
     -+		HEAD
     -+		^HEAD~1
     -+		EOF
     -+		GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
     -+			-c maintenance.incremental-repack.auto=2 \
     -+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
     -+		test_subcommand git multi-pack-index write --no-progress <trace-B-$i || return 1
     -+	done
     ++	test_commit A &&
     ++	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
     ++	HEAD
     ++	^HEAD~1
     ++	EOF
     ++	GIT_TRACE2_EVENT=$(pwd)/trace-A git \
     ++		-c maintenance.incremental-repack.auto=2 \
     ++		maintenance run --auto --task=incremental-repack 2>/dev/null &&
     ++	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
     ++	test_commit B &&
     ++	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
     ++	HEAD
     ++	^HEAD~1
     ++	EOF
     ++	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
     ++		-c maintenance.incremental-repack.auto=2 \
     ++		maintenance run --auto --task=incremental-repack 2>/dev/null &&
     ++	test_subcommand git multi-pack-index write --no-progress <trace-B
      +'
      +
       test_done

-- 
gitgitgadget
