Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8805FC433E1
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EE7221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhZx6IiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHFRxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgHFQbD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F42C00217A
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so10291938wmb.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VLgt0sjh2H1OMcQMfLz0XILuP1Wo6Ta9ToX5MGl65AU=;
        b=RhZx6IiKODd2QfvTMtA6qjKUh2SQDUL/XwapCtSy6dFL4mFH7BowwMIeg+M4Cx2Nb0
         uD/QYpYyXpkcXUBCF+rJ8scZ9RNcD92vnfb5+cDzX1k6QxA+Thdp0jEHVyu8ccDCl0uT
         H+2T1olNpPQNnvSdw+7Mtq0I4Vu0dSj/18nKcKd/eakZoPs53U5/yVIWww9XKpCv0QAc
         MPWl49MCs1ixVrWDNPT+PoX8gLXLTAI2mHotHzlQ208tC9V9hycXxG87/ORy5J/h/9it
         U15P/W4CxgIbylfBYXRa1Yq345sLbFXEPuSEGvC7SaCwRK2kVbWUGl4Em/tdeB4KG0O/
         EN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VLgt0sjh2H1OMcQMfLz0XILuP1Wo6Ta9ToX5MGl65AU=;
        b=ElNrPCkme98crQKLR9kHkyZwj2h8wfb4LrKl1OewIksBatUPF8UH3xe9hFQrVIf34o
         gC2YpX5DXuj92xFQXlkYcii/GB/mIq2AhGs3ProSCCFLqIPQS7FZrz0f6F5piifIVMMC
         ZG84rjAw72/9LKbuysVS8vKopxrMG5dl8f7cR4xc+CzVtgQBa0PTVh71xFWUasMaTiUR
         dJq4I8DUcsdV8jVUIsjaoxDjYk8kSTBLXi1iYlEtUdYxpRI9cc/MYV6C5megKeR2XY/+
         6sZjMBwLHVvu0gAzxN4995nccWJHg3WyXUTjbIttCfAwABiRlb8PKnhFKP8xtE894xQN
         21fg==
X-Gm-Message-State: AOAM533QEWGyrztUJXubvchtn1YIW43i6CrssZZPZS5I2I62d0oiR+Na
        0DPi1p4mG/hSVE/a561AzaJbpwYL
X-Google-Smtp-Source: ABdhPJx2qlpAgY4iMFZgQyMmdYsrn7jBRr+ELwGR7U1hn7HjfoYFNQOhPYubYKU3+kRnIsl8YrKqBQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr8918954wmb.25.1596731426381;
        Thu, 06 Aug 2020 09:30:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm7018413wru.3.2020.08.06.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:25 -0700 (PDT)
Message-Id: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:15 +0000
Subject: [PATCH 0/9] Maintenance II: prefetch, loose-objects, incremental-repack tasks
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

This series is based on part I [2].

This patch series contains 9 patches that were going to be part of v4 of
ds/maintenance [1], but the discussion has gotten really long. To help, I'm
splitting out the portions that create and test the 'maintenance' builtin
from the additional tasks (prefetch, loose-objects, incremental-repack) that
can be brought in later.

[1] 
https://lore.kernel.org/git/pull.671.git.1594131695.gitgitgadget@gmail.com/
[2] 
https://lore.kernel.org/git/pull.695.git.1596728921.gitgitgadget@gmail.com/

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
focus on the maintenance activities themselves. I have a WIP series for this
available at [3].

[3] https://github.com/gitgitgadget/git/pull/680

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

Here is the range-diff from the v3 of [1].

 1:  12fe73bb72 <  -:  ---------- maintenance: create basic maintenance runner
 2:  6e533e43d7 <  -:  ---------- maintenance: add --quiet option
 3:  c4674fc211 <  -:  ---------- maintenance: replace run_auto_gc()
 4:  b9332c1318 <  -:  ---------- maintenance: initialize task array
 5:  a4d9836bed <  -:  ---------- maintenance: add commit-graph task
 6:  dafb0d9bbc <  -:  ---------- maintenance: add --task option
 7:  1b00524da3 <  -:  ---------- maintenance: take a lock on the objects directory
 8:  0e94e04dcd =  1:  83401c5200 fetch: optionally allow disabling FETCH_HEAD update
 9:  9e38ade15c !  2:  85118ed5f1 maintenance: add prefetch task
    @@ Documentation/git-maintenance.txt: since it will not expire `.graph` files that

      ## builtin/gc.c ##
     @@
    - #include "blob.h"
      #include "tree.h"
      #include "promisor-remote.h"
    + #include "refs.h"
     +#include "remote.h"

      #define FAILED_RUN "failed to run %s"

    -@@ builtin/gc.c: static int maintenance_task_commit_graph(void)
    +@@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_opts *opts)
          return 1;
      }

    -+static int fetch_remote(const char *remote)
    ++static int fetch_remote(const char *remote, struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
    @@ builtin/gc.c: static int maintenance_task_commit_graph(void)
     +    strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
     +             "--no-write-fetch-head", "--refmap=", NULL);
     +
    -+    strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
    -+
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--quiet");
     +
    ++    strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
    ++
     +    return !!run_command(&child);
     +}
     +
    @@ builtin/gc.c: static int maintenance_task_commit_graph(void)
     +    return 0;
     +}
     +
    -+static int maintenance_task_prefetch(void)
    ++static int maintenance_task_prefetch(struct maintenance_opts *opts)
     +{
     +    int result = 0;
     +    struct string_list_item *item;
    @@ builtin/gc.c: static int maintenance_task_commit_graph(void)
     +    for (item = remotes.items;
     +         item && item < remotes.items + remotes.nr;
     +         item++)
    -+        result |= fetch_remote(item->string);
    ++        result |= fetch_remote(item->string, opts);
     +
     +cleanup:
     +    string_list_clear(&remotes, 0);
     +    return result;
     +}
     +
    - static int maintenance_task_gc(void)
    + static int maintenance_task_gc(struct maintenance_opts *opts)
      {
          struct child_process child = CHILD_PROCESS_INIT;
     @@ builtin/gc.c: struct maintenance_task {
    @@ t/t7900-maintenance.sh: test_expect_success 'run --task duplicate' '
     +    git -C clone2 switch -c two &&
     +    test_commit -C clone1 one &&
     +    test_commit -C clone2 two &&
    -+    GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch &&
    -+    grep ",\"fetch\",\"remote1\"" run-prefetch.txt &&
    -+    grep ",\"fetch\",\"remote2\"" run-prefetch.txt &&
    ++    GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
    ++    fetchargs="--prune --no-tags --no-write-fetch-head --refmap= --quiet" &&
    ++    test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
    ++    test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
     +    test_path_is_missing .git/refs/remotes &&
     +    test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
     +    test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&
10:  0128fdfd1a !  3:  621375a3c9 maintenance: add loose-objects task
    @@ Documentation/git-maintenance.txt: gc::
      --auto::

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int maintenance_task_gc(void)
    +@@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_opts *opts)
          return run_command(&child);
      }

    -+static int prune_packed(void)
    ++static int prune_packed(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
     +    child.git_cmd = 1;
     +    strvec_push(&child.args, "prune-packed");
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--quiet");
     +
     +    return !!run_command(&child);
    @@ builtin/gc.c: static int maintenance_task_gc(void)
     +    return ++(d->count) > d->batch_size;
     +}
     +
    -+static int pack_loose(void)
    ++static int pack_loose(struct maintenance_opts *opts)
     +{
     +    struct repository *r = the_repository;
     +    int result = 0;
    @@ builtin/gc.c: static int maintenance_task_gc(void)
     +    pack_proc.git_cmd = 1;
     +
     +    strvec_push(&pack_proc.args, "pack-objects");
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&pack_proc.args, "--quiet");
     +    strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
     +
    @@ builtin/gc.c: static int maintenance_task_gc(void)
     +    return result;
     +}
     +
    -+static int maintenance_task_loose_objects(void)
    ++static int maintenance_task_loose_objects(struct maintenance_opts *opts)
     +{
    -+    return prune_packed() || pack_loose();
    ++    return prune_packed(opts) || pack_loose(opts);
     +}
     +
    - typedef int maintenance_task_fn(void);
    + typedef int maintenance_task_fn(struct maintenance_opts *opts);

    - struct maintenance_task {
    + /*
     @@ builtin/gc.c: struct maintenance_task {

      enum maintenance_task_label {
17:  6ac3a58f2f !  4:  e787403ea7 maintenance: create auto condition for loose-objects
    @@ builtin/gc.c: static struct maintenance_task tasks[] = {
              maintenance_task_loose_objects,
     +        loose_object_auto_condition,
          },
    -     [TASK_INCREMENTAL_REPACK] = {
    -         "incremental-repack",
    +     [TASK_GC] = {
    +         "gc",

      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
    @@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
     +    git repack -adk &&
     +    GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
     +        git -c maintenance.loose-objects.auto=1 maintenance \
    -+        run --auto --task=loose-objects &&
    -+    ! grep "\"prune-packed\"" trace-lo1.txt &&
    ++        run --auto --task=loose-objects 2>/dev/null &&
    ++    test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
     +    for i in 1 2
     +    do
     +        printf data-A-$i | git hash-object -t blob --stdin -w &&
     +        GIT_TRACE2_EVENT="$(pwd)/trace-loA-$i" \
     +            git -c maintenance.loose-objects.auto=2 \
    -+            maintenance run --auto --task=loose-objects &&
    -+        ! grep "\"prune-packed\"" trace-loA-$i &&
    ++            maintenance run --auto --task=loose-objects 2>/dev/null &&
    ++        test_subcommand ! git prune-packed --quiet <trace-loA-$i &&
     +        printf data-B-$i | git hash-object -t blob --stdin -w &&
     +        GIT_TRACE2_EVENT="$(pwd)/trace-loB-$i" \
     +            git -c maintenance.loose-objects.auto=2 \
    -+            maintenance run --auto --task=loose-objects &&
    -+        grep "\"prune-packed\"" trace-loB-$i &&
    ++            maintenance run --auto --task=loose-objects 2>/dev/null &&
    ++        test_subcommand git prune-packed --quiet <trace-loB-$i &&
     +        GIT_TRACE2_EVENT="$(pwd)/trace-loC-$i" \
     +            git -c maintenance.loose-objects.auto=2 \
    -+            maintenance run --auto --task=loose-objects &&
    -+        grep "\"prune-packed\"" trace-loC-$i || return 1
    ++            maintenance run --auto --task=loose-objects 2>/dev/null &&
    ++        test_subcommand git prune-packed --quiet <trace-loC-$i || return 1
     +    done
     +'
     +
    - test_expect_success 'incremental-repack task' '
    -     packDir=.git/objects/pack &&
    -     for i in $(test_seq 1 5)
    + test_done
11:  c2baf6e119 =  5:  37e59b1a8d midx: enable core.multiPackIndex by default
19:  9b4cef7635 =  6:  aba087f663 midx: use start_delayed_progress()
12:  00f47c4848 !  7:  68727c555b maintenance: add incremental-repack task
    @@ Documentation/git-maintenance.txt: loose-objects::

      ## builtin/gc.c ##
     @@
    - #include "tree.h"
      #include "promisor-remote.h"
    + #include "refs.h"
      #include "remote.h"
     +#include "midx.h"

      #define FAILED_RUN "failed to run %s"

    -@@ builtin/gc.c: static int maintenance_task_loose_objects(void)
    -     return prune_packed() || pack_loose();
    +@@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts *opts)
    +     return prune_packed(opts) || pack_loose(opts);
      }

    -+static int multi_pack_index_write(void)
    ++static int multi_pack_index_write(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
     +    child.git_cmd = 1;
     +    strvec_pushl(&child.args, "multi-pack-index", "write", NULL);
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--no-progress");
     +
     +    if (run_command(&child))
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +    return 0;
     +}
     +
    -+static int rewrite_multi_pack_index(void)
    ++static int rewrite_multi_pack_index(struct maintenance_opts *opts)
     +{
     +    struct repository *r = the_repository;
     +    char *midx_name = get_midx_filename(r->objects->odb->path);
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +    unlink(midx_name);
     +    free(midx_name);
     +
    -+    return multi_pack_index_write();
    ++    return multi_pack_index_write(opts);
     +}
     +
    -+static int multi_pack_index_verify(const char *message)
    ++static int multi_pack_index_verify(struct maintenance_opts *opts,
    ++                   const char *message)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
     +    child.git_cmd = 1;
     +    strvec_pushl(&child.args, "multi-pack-index", "verify", NULL);
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--no-progress");
     +
     +    if (run_command(&child)) {
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +    return 0;
     +}
     +
    -+static int multi_pack_index_expire(void)
    ++static int multi_pack_index_expire(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
     +    child.git_cmd = 1;
     +    strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--no-progress");
     +
     +    close_object_store(the_repository->objects);
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +    return 0;
     +}
     +
    -+static int multi_pack_index_repack(void)
    ++static int multi_pack_index_repack(struct maintenance_opts *opts)
     +{
     +    struct child_process child = CHILD_PROCESS_INIT;
     +
     +    child.git_cmd = 1;
     +    strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
     +
    -+    if (opts.quiet)
    ++    if (opts->quiet)
     +        strvec_push(&child.args, "--no-progress");
     +
     +    strvec_push(&child.args, "--batch-size=0");
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +    return 0;
     +}
     +
    -+static int maintenance_task_incremental_repack(void)
    ++static int maintenance_task_incremental_repack(struct maintenance_opts *opts)
     +{
     +    prepare_repo_settings(the_repository);
     +    if (!the_repository->settings.core_multi_pack_index) {
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +        return 0;
     +    }
     +
    -+    if (multi_pack_index_write())
    ++    if (multi_pack_index_write(opts))
     +        return 1;
    -+    if (multi_pack_index_verify("after initial write"))
    -+        return rewrite_multi_pack_index();
    -+    if (multi_pack_index_expire())
    ++    if (multi_pack_index_verify(opts, "after initial write"))
    ++        return rewrite_multi_pack_index(opts);
    ++    if (multi_pack_index_expire(opts))
     +        return 1;
    -+    if (multi_pack_index_verify("after expire step"))
    -+        return !!rewrite_multi_pack_index();
    -+    if (multi_pack_index_repack())
    ++    if (multi_pack_index_verify(opts, "after expire step"))
    ++        return !!rewrite_multi_pack_index(opts);
    ++    if (multi_pack_index_repack(opts))
     +        return 1;
    -+    if (multi_pack_index_verify("after repack step"))
    -+        return !!rewrite_multi_pack_index();
    ++    if (multi_pack_index_verify(opts, "after repack step"))
    ++        return !!rewrite_multi_pack_index(opts);
     +    return 0;
     +}
     +
    - typedef int maintenance_task_fn(void);
    + typedef int maintenance_task_fn(struct maintenance_opts *opts);

    - struct maintenance_task {
    + /*
     @@ builtin/gc.c: struct maintenance_task {
      enum maintenance_task_label {
          TASK_PREFETCH,
    @@ builtin/gc.c: struct maintenance_task {
          TASK_COMMIT_GRAPH,

     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
    -         "loose-objects",
              maintenance_task_loose_objects,
    +         loose_object_auto_condition,
          },
     +    [TASK_INCREMENTAL_REPACK] = {
     +        "incremental-repack",
    @@ t/t7900-maintenance.sh: test_description='git maintenance builtin'

      test_expect_success 'help text' '
          test_expect_code 129 git maintenance -h 2>err &&
    -@@ t/t7900-maintenance.sh: test_expect_success 'loose-objects task' '
    -     test_cmp packs-between packs-after
    +@@ t/t7900-maintenance.sh: test_expect_success 'maintenance.loose-objects.auto' '
    +     done
      '

     +test_expect_success 'incremental-repack task' '
13:  ef2a231956 !  8:  c3487fb8e3 maintenance: auto-size incremental-repack batch
    @@ Commit message
         truly want to optimize for space and performance (and are willing to pay
         the upfront cost of a full repack) can use the 'gc' task to do so.

    +    Create a test for this two gigabyte limit by creating an EXPENSIVE test
    +    that generates two pack-files of roughly 2.5 gigabytes in size, then
    +    performs an incremental repack. Check that the --batch-size argument in
    +    the subcommand uses the hard-coded maximum.
    +
    +    Helped-by: Chris Torek <chris.torek@gmail.com>
         Reported-by: Son Luong Ngoc <sluongng@gmail.com>
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

      ## builtin/gc.c ##
    -@@ builtin/gc.c: static int multi_pack_index_expire(void)
    +@@ builtin/gc.c: static int multi_pack_index_expire(struct maintenance_opts *opts)
          return 0;
      }

    -+#define TWO_GIGABYTES (0x7FFF)
    ++#define TWO_GIGABYTES (INT32_MAX)
     +
     +static off_t get_auto_pack_size(void)
     +{
    @@ builtin/gc.c: static int multi_pack_index_expire(void)
     +    return result_size;
     +}
     +
    - static int multi_pack_index_repack(void)
    + static int multi_pack_index_repack(struct maintenance_opts *opts)
      {
          struct child_process child = CHILD_PROCESS_INIT;
    -@@ builtin/gc.c: static int multi_pack_index_repack(void)
    -     if (opts.quiet)
    +@@ builtin/gc.c: static int multi_pack_index_repack(struct maintenance_opts *opts)
    +     if (opts->quiet)
              strvec_push(&child.args, "--no-progress");

     -    strvec_push(&child.args, "--batch-size=0");
    @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
          ls .git/objects/pack/*.pack >packs-after &&
     -    test_line_count = 1 packs-after
     +    test_line_count = 2 packs-after
    ++'
    ++
    ++test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
    ++    for i in $(test_seq 1 5)
    ++    do
    ++        test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
    ++        return 1
    ++    done &&
    ++    git add big &&
    ++    git commit -m "Add big file (1)" &&
    ++
    ++    # ensure any possible loose objects are in a pack-file
    ++    git maintenance run --task=loose-objects &&
    ++
    ++    rm big &&
    ++    for i in $(test_seq 6 10)
    ++    do
    ++        test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
    ++        return 1
    ++    done &&
    ++    git add big &&
    ++    git commit -m "Add big file (2)" &&
    ++
    ++    # ensure any possible loose objects are in a pack-file
    ++    git maintenance run --task=loose-objects &&
    ++
    ++    # Now run the incremental-repack task and check the batch-size
    ++    GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
    ++        --task=incremental-repack 2>/dev/null &&
    ++    test_subcommand git multi-pack-index repack \
    ++         --no-progress --batch-size=2147483647 <run-2g.txt
      '

      test_done
14:  99840c4b8f <  -:  ---------- maintenance: create maintenance.<task>.enabled config
15:  a087c63572 <  -:  ---------- maintenance: use pointers to check --auto
16:  ef3a854508 <  -:  ---------- maintenance: add auto condition for commit-graph task
18:  801b262d1c !  9:  407c123c51 maintenance: add incremental-repack auto condition
    @@ Documentation/config/maintenance.txt: maintenance.loose-objects.auto::

      ## builtin/gc.c ##
     @@
    + #include "refs.h"
      #include "remote.h"
      #include "midx.h"
    - #include "refs.h"
     +#include "object-store.h"

      #define FAILED_RUN "failed to run %s"

    -@@ builtin/gc.c: static int maintenance_task_loose_objects(void)
    -     return prune_packed() || pack_loose();
    +@@ builtin/gc.c: static int maintenance_task_loose_objects(struct maintenance_opts *opts)
    +     return prune_packed(opts) || pack_loose(opts);
      }

     +static int incremental_repack_auto_condition(void)
    @@ builtin/gc.c: static int maintenance_task_loose_objects(void)
     +    return count >= incremental_repack_auto_limit;
     +}
     +
    - static int multi_pack_index_write(void)
    + static int multi_pack_index_write(struct maintenance_opts *opts)
      {
          struct child_process child = CHILD_PROCESS_INIT;
     @@ builtin/gc.c: static struct maintenance_task tasks[] = {
    @@ builtin/gc.c: static struct maintenance_task tasks[] = {

      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
    -     test_line_count = 2 packs-after
    + '
    + 
    + test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
    ++
    +     for i in $(test_seq 1 5)
    +     do
    +         test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
    +@@ t/t7900-maintenance.sh: test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
    +          --no-progress --batch-size=2147483647 <run-2g.txt
      '

     +test_expect_success 'maintenance.incremental-repack.auto' '
     +    git repack -adk &&
     +    git config core.multiPackIndex true &&
     +    git multi-pack-index write &&
    -+    GIT_TRACE2_EVENT=1 git -c maintenance.incremental-repack.auto=1 \
    -+        maintenance run --auto --task=incremental-repack >out &&
    -+    ! grep "\"multi-pack-index\"" out &&
    ++    GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
    ++        -c maintenance.incremental-repack.auto=1 \
    ++        maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++    test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
     +    for i in 1 2
     +    do
     +        test_commit A-$i &&
    @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
     +        EOF
     +        GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
     +            -c maintenance.incremental-repack.auto=2 \
    -+            maintenance run --auto --task=incremental-repack &&
    -+        ! grep "\"multi-pack-index\"" trace-A-$i &&
    ++            maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++        test_subcommand ! git multi-pack-index write --no-progress <trace-A-$i &&
     +        test_commit B-$i &&
     +        git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
     +        HEAD
    @@ t/t7900-maintenance.sh: test_expect_success 'incremental-repack task' '
     +        EOF
     +        GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
     +            -c maintenance.incremental-repack.auto=2 \
    -+            maintenance run --auto --task=incremental-repack >out &&
    -+        grep "\"multi-pack-index\"" trace-B-$i >/dev/null || return 1
    ++            maintenance run --auto --task=incremental-repack 2>/dev/null &&
    ++        test_subcommand git multi-pack-index write --no-progress <trace-B-$i || return 1
     +    done
     +'
     +
20:  39eb83ad1e <  -:  ---------- maintenance: add trace2 regions for task execution

Derrick Stolee (8):
  maintenance: add prefetch task
  maintenance: add loose-objects task
  maintenance: create auto condition for loose-objects
  midx: enable core.multiPackIndex by default
  midx: use start_delayed_progress()
  maintenance: add incremental-repack task
  maintenance: auto-size incremental-repack batch
  maintenance: add incremental-repack auto condition

Junio C Hamano (1):
  fetch: optionally allow disabling FETCH_HEAD update

 Documentation/config/core.txt        |   4 +-
 Documentation/config/fetch.txt       |   7 +
 Documentation/config/maintenance.txt |  18 ++
 Documentation/fetch-options.txt      |  10 +
 Documentation/git-maintenance.txt    |  41 +++
 builtin/fetch.c                      |  19 +-
 builtin/gc.c                         | 364 +++++++++++++++++++++++++++
 builtin/pull.c                       |   3 +-
 midx.c                               |  23 +-
 midx.h                               |   1 +
 repo-settings.c                      |   6 +
 repository.h                         |   2 +
 t/t5319-multi-pack-index.sh          |  15 +-
 t/t5510-fetch.sh                     |  39 ++-
 t/t5521-pull-options.sh              |  16 ++
 t/t7900-maintenance.sh               | 191 ++++++++++++++
 16 files changed, 730 insertions(+), 29 deletions(-)


base-commit: a5d19148460decaf08e0e6293e996d42ff3f2d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-696%2Fderrickstolee%2Fmaintenance%2Fgc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-696/derrickstolee/maintenance/gc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/696
-- 
gitgitgadget
