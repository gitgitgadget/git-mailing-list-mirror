Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196A9C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FC62074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIEuuBkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYSgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYSgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:36:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3AC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q14so2715850wrn.9
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F8mU9NKZuA18w5VKz4CodAh6jz8SfLjF086lLOb1XAY=;
        b=aIEuuBkEszHsiR6iGSfSRV2+IQwxvNa2OJGMM3Xm2U0NF8rIDvMZWy+A7e91AJjr4e
         U06s9/ef8BDbFts4JiAnvLtJcfKUJvcjLXz17P1Vbj3e3lsc+Pq2iS32nqQMB8JnZCtU
         qn+WwmYU4vbVTSQ6oXaAaIo+pQxuG5vLlgkOcz67pyC9l5rYfnaQeKFvmwWQwAuzl/DH
         YrO1t2bhXGDIsmeZZuexnQaG7u97NDyPFHRYh/Kzh+uaYrztRMAak8wQWJ+qs0Z91+rz
         LUFl/uveVI8iTUm/KY2knhkCJD16zOU1hLlR/fL1l3QDZBRT0rT4IZc+FFb3bk51DNku
         X+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F8mU9NKZuA18w5VKz4CodAh6jz8SfLjF086lLOb1XAY=;
        b=Z3oNcsKHPYn8bKWZEun9A0qn/fHBod+7VR8wNSAaLQkZ9csef/1/tgirGML9slAz7X
         zT+CDxmbrx1Tw2Zx4g2OKfyjnB1Mz5RtdOcuQrMehoBweeWRQQtSz24W1/GSDqoOy32j
         GxrgGDE8xE6zdrF2za1ks6CJlZ0Tn2+fBB9xqlRtacPSPEDmEchJyPhnOfu+vN33sUCx
         lyTVmvA3tB+YBsTPJQ87W44B+jPYKSSUk/DcGVaLcc4Qb+TfLPIEuQ2ZyZmT8PJ8htVD
         826Tu+yakfHrQzNXtLl75J2uZ3wviIn9Uw8fK62gQdbH2v4wOaII1OZtgCPj7OmUm/RQ
         3FvA==
X-Gm-Message-State: AOAM5303q/TUrt0DziH6hX/gCbNQp352J/3DM7L0Q7AQ7GhSDimo/l+S
        d78KJxBwzFxA/knbUocYZruU/DJ7eWw=
X-Google-Smtp-Source: ABdhPJyL/ahbBxx7141IkeOe8q0bsUFs0FZZzIWd0wD/t8stBspVOmkQBq6W3QkcejkQiCF4bbflKg==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr11238867wrr.323.1598380600516;
        Tue, 25 Aug 2020 11:36:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm6924685wmq.12.2020.08.25.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:36:40 -0700 (PDT)
Message-Id: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:36:31 +0000
Subject: [PATCH v3 0/8] Maintenance II: prefetch, loose-objects, incremental-repack tasks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on v3 of part I (ds/maintenance-part-1) [2].

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
 Documentation/git-maintenance.txt    |  45 ++++
 builtin/gc.c                         | 327 +++++++++++++++++++++++++++
 midx.c                               |  23 +-
 midx.h                               |   1 +
 repo-settings.c                      |   6 +
 repository.h                         |   2 +
 t/t5319-multi-pack-index.sh          |  15 +-
 t/t7900-maintenance.sh               | 191 ++++++++++++++++
 10 files changed, 609 insertions(+), 23 deletions(-)


base-commit: 652a8eac57d04a51820c7a5b45031b50c5188e7b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-696%2Fderrickstolee%2Fmaintenance%2Fgc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-696/derrickstolee/maintenance/gc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/696

Range-diff vs v2:

  1:  f3bc0b2d92 <  -:  ---------- fetch: optionally allow disabling FETCH_HEAD update
  2:  8779c6c20d !  1:  da64c51a81 maintenance: add prefetch task
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-maintenance.txt ##
     -@@ Documentation/git-maintenance.txt: since it will not expire `.graph` files that were in the previous
     - `commit-graph-chain` file. They will be deleted by a later run based on
     - the expiration delay.
     +@@ Documentation/git-maintenance.txt: commit-graph::
     + 	`commit-graph-chain` file. They will be deleted by a later run based
     + 	on the expiration delay.
       
      +prefetch::
      +	The `prefetch` task updates the object directory with the latest
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *opts)
     - 	return 1;
     +@@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
     + 	return 0;
       }
       
     -+static int fetch_remote(const char *remote, struct maintenance_opts *opts)
     ++static int fetch_remote(const char *remote, struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *
      +	return 0;
      +}
      +
     -+static int maintenance_task_prefetch(struct maintenance_opts *opts)
     ++static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
      +{
      +	int result = 0;
      +	struct string_list_item *item;
     @@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *
      +	return result;
      +}
      +
     - static int maintenance_task_gc(struct maintenance_opts *opts)
     + static int maintenance_task_gc(struct maintenance_run_opts *opts)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
      @@ builtin/gc.c: struct maintenance_task {
  3:  4fa9d298b9 !  2:  75e846456b maintenance: add loose-objects task
     @@ Documentation/git-maintenance.txt: gc::
       --auto::
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts)
       	return run_command(&child);
       }
       
     -+static int prune_packed(struct maintenance_opts *opts)
     ++static int prune_packed(struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
      +	return ++(d->count) > d->batch_size;
      +}
      +
     -+static int pack_loose(struct maintenance_opts *opts)
     ++static int pack_loose(struct maintenance_run_opts *opts)
      +{
      +	struct repository *r = the_repository;
      +	int result = 0;
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
      +	return result;
      +}
      +
     -+static int maintenance_task_loose_objects(struct maintenance_opts *opts)
     ++static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
      +{
      +	return prune_packed(opts) || pack_loose(opts);
      +}
      +
     - typedef int maintenance_task_fn(struct maintenance_opts *opts);
     + typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
       
       /*
      @@ builtin/gc.c: struct maintenance_task {
  4:  3432bc3167 =  3:  d6e382c43e maintenance: create auto condition for loose-objects
  5:  0ee2434bdb =  4:  d0f2ec70d9 midx: enable core.multiPackIndex by default
  6:  e157ea8dd7 =  5:  2cd3c803d9 midx: use start_delayed_progress()
  7:  a8d956dad6 !  6:  0dd26bb584 maintenance: add incremental-repack task
     @@ Commit message
             it requires doing some calculations that are better isolated to
             a separate change.
      
     -    Each of the above steps update the multi-pack-index file. After
     -    each step, we verify the new multi-pack-index. If the new
     -    multi-pack-index is corrupt, then delete the multi-pack-index,
     -    rewrite it from scratch, and stop doing the later steps of the
     -    job. This is intended to be an extra-safe check without leaving
     -    a repo with many pack-files without a multi-pack-index.
     -
          These steps are based on a similar background maintenance step in
          Scalar (and VFS for Git) [1]. This was incredibly effective for
          users of the Windows OS repository. After using the same VFS for Git
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
       	return prune_packed(opts) || pack_loose(opts);
       }
       
     -+static int multi_pack_index_write(struct maintenance_opts *opts)
     ++static int multi_pack_index_write(struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts
      +	return 0;
      +}
      +
     -+static int rewrite_multi_pack_index(struct maintenance_opts *opts)
     -+{
     -+	struct repository *r = the_repository;
     -+	char *midx_name = get_midx_filename(r->objects->odb->path);
     -+
     -+	unlink(midx_name);
     -+	free(midx_name);
     -+
     -+	return multi_pack_index_write(opts);
     -+}
     -+
     -+static int multi_pack_index_verify(struct maintenance_opts *opts,
     -+				   const char *message)
     -+{
     -+	struct child_process child = CHILD_PROCESS_INIT;
     -+
     -+	child.git_cmd = 1;
     -+	strvec_pushl(&child.args, "multi-pack-index", "verify", NULL);
     -+
     -+	if (opts->quiet)
     -+		strvec_push(&child.args, "--no-progress");
     -+
     -+	if (run_command(&child)) {
     -+		warning(_("'git multi-pack-index verify' failed %s"), message);
     -+		return 1;
     -+	}
     -+
     -+	return 0;
     -+}
     -+
     -+static int multi_pack_index_expire(struct maintenance_opts *opts)
     ++static int multi_pack_index_expire(struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts
      +	return 0;
      +}
      +
     -+static int multi_pack_index_repack(struct maintenance_opts *opts)
     ++static int multi_pack_index_repack(struct maintenance_run_opts *opts)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
      +
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts
      +	return 0;
      +}
      +
     -+static int maintenance_task_incremental_repack(struct maintenance_opts *opts)
     ++static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts)
      +{
      +	prepare_repo_settings(the_repository);
      +	if (!the_repository->settings.core_multi_pack_index) {
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts
      +
      +	if (multi_pack_index_write(opts))
      +		return 1;
     -+	if (multi_pack_index_verify(opts, "after initial write"))
     -+		return rewrite_multi_pack_index(opts);
      +	if (multi_pack_index_expire(opts))
      +		return 1;
     -+	if (multi_pack_index_verify(opts, "after expire step"))
     -+		return !!rewrite_multi_pack_index(opts);
      +	if (multi_pack_index_repack(opts))
      +		return 1;
     -+	if (multi_pack_index_verify(opts, "after repack step"))
     -+		return !!rewrite_multi_pack_index(opts);
      +	return 0;
      +}
      +
     - typedef int maintenance_task_fn(struct maintenance_opts *opts);
     + typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
       
       /*
      @@ builtin/gc.c: struct maintenance_task {
  8:  f0e7276755 !  7:  f3b25a9927 maintenance: auto-size incremental-repack batch
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/gc.c ##
     -@@ builtin/gc.c: static int multi_pack_index_expire(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int multi_pack_index_expire(struct maintenance_run_opts *opts)
       	return 0;
       }
       
     @@ builtin/gc.c: static int multi_pack_index_expire(struct maintenance_opts *opts)
      +	return result_size;
      +}
      +
     - static int multi_pack_index_repack(struct maintenance_opts *opts)
     + static int multi_pack_index_repack(struct maintenance_run_opts *opts)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
     -@@ builtin/gc.c: static int multi_pack_index_repack(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int multi_pack_index_repack(struct maintenance_run_opts *opts)
       	if (opts->quiet)
       		strvec_push(&child.args, "--no-progress");
       
  9:  5659a23ad5 !  8:  e9bb32f53a maintenance: add incremental-repack auto condition
     @@ builtin/gc.c
       
       #define FAILED_RUN "failed to run %s"
       
     -@@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts *opts)
     +@@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
       	return prune_packed(opts) || pack_loose(opts);
       }
       
     @@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts
      +	return count >= incremental_repack_auto_limit;
      +}
      +
     - static int multi_pack_index_write(struct maintenance_opts *opts)
     + static int multi_pack_index_write(struct maintenance_run_opts *opts)
       {
       	struct child_process child = CHILD_PROCESS_INIT;
      @@ builtin/gc.c: static struct maintenance_task tasks[] = {

-- 
gitgitgadget
