Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DCC47423
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F27B21D91
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2SoVgSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgIYMdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgIYMdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01B9C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so2872402wmi.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QIbMubR6XPTcLJCCXZ/cPVJHClgQk4CRkOlHS0Kbmsk=;
        b=g2SoVgSEs8233Fu83xlHiz32UZaClBHgWUN3s94JcY6fOAZHshRDDYFi08KWoGQ7OF
         3YrwkdHZJfu4lJmERfBtNJRS0NQummXbtDMZ/lrX9zpBDBzGDpe4aDCi3+7A0PXbyMTj
         HKbpZC2TefUtOvlpeDSVJIOYmgmGNBWxjh1OIEnJnPsiY22jtpAwJhdJoxjkrRKksmdG
         whmrX+Aw4RfztiA8X/UP7U/lyUPS4EUeELl90ZUruXmqjUSNedQ98M+/kFaG9RMJ1ZQk
         LSjmFRV4rLdLoegIrffh8Luudv7mp9I6Ar/a7ajEVwKoBuIxlV/18ojPwWKIcJ6VvrHh
         Tmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QIbMubR6XPTcLJCCXZ/cPVJHClgQk4CRkOlHS0Kbmsk=;
        b=OU0aax+XYYjNPvUDYe089lBxLIEFPJJjYd+2VmjfukpaacxnVkUEB6nnwBXU6WK5xA
         E/oA+k5R9SuolDIFHxIm0Q/H9N0xZhyXi4Ak7qd81/p23I8oOAyQSSuj1mP6ZG0wmmvg
         SXkX2QN0+O7sRdasvJl1u1FcOW9KnNuIZFHq8cqkECvj5I15N4clh0zvs3D9Etl5rCP3
         YSVqL0w11iWz5sovr4eSVwmpAhIYyFxj9NORnxvNdtjp1vEo6J+PVJgVtWWHKXLENHdw
         g2ALjGLXS2FiHDO78HZJHatFSf8CIFh1ijc8yp7uKtOom4wdfvvteP28HLzAcevzxhC1
         i4aQ==
X-Gm-Message-State: AOAM531lMAlxCep1waPoAKTOORi2UzZU412tLo19sgU4ldeYTt24uCYZ
        Z+E5ItZhr9GAjjQ0/i8iU/eTu+vAnDQ=
X-Google-Smtp-Source: ABdhPJzWuxsdZp7fkkUGgHgyl/BX6ue8ZiMby4tGeXGH99UOKRaYIdO2m1mAVj1+n+dcUUFPidX7Kg==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr2933772wmc.100.1601037226089;
        Fri, 25 Sep 2020 05:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm2713279wrs.48.2020.09.25.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:33:45 -0700 (PDT)
Message-Id: <d934899253c134298e1a9a7e2e0028bccc1c60d0.1601037218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
        <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 12:33:36 +0000
Subject: [PATCH v4 6/8] maintenance: add incremental-repack task
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
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change cleaned up loose objects using the
'loose-objects' that can be run safely in the background. Add a
similar job that performs similar cleanups for pack-files.

One issue with running 'git repack' is that it is designed to
repack all pack-files into a single pack-file. While this is the
most space-efficient way to store object data, it is not time or
memory efficient. This becomes extremely important if the repo is
so large that a user struggles to store two copies of the pack on
their disk.

Instead, perform an "incremental" repack by collecting a few small
pack-files into a new pack-file. The multi-pack-index facilitates
this process ever since 'git multi-pack-index expire' was added in
19575c7 (multi-pack-index: implement 'expire' subcommand,
2019-06-10) and 'git multi-pack-index repack' was added in ce1e4a1
(midx: implement midx_repack(), 2019-06-10).

The 'incremental-repack' task runs the following steps:

1. 'git multi-pack-index write' creates a multi-pack-index file if
   one did not exist, and otherwise will update the multi-pack-index
   with any new pack-files that appeared since the last write. This
   is particularly relevant with the background fetch job.

   When the multi-pack-index sees two copies of the same object, it
   stores the offset data into the newer pack-file. This means that
   some old pack-files could become "unreferenced" which I will use
   to mean "a pack-file that is in the pack-file list of the
   multi-pack-index but none of the objects in the multi-pack-index
   reference a location inside that pack-file."

2. 'git multi-pack-index expire' deletes any unreferenced pack-files
   and updaes the multi-pack-index to drop those pack-files from the
   list. This is safe to do as concurrent Git processes will see the
   multi-pack-index and not open those packs when looking for object
   contents. (Similar to the 'loose-objects' job, there are some Git
   commands that open pack-files regardless of the multi-pack-index,
   but they are rarely used. Further, a user that self-selects to
   use background operations would likely refrain from using those
   commands.)

3. 'git multi-pack-index repack --bacth-size=<size>' collects a set
   of pack-files that are listed in the multi-pack-index and creates
   a new pack-file containing the objects whose offsets are listed
   by the multi-pack-index to be in those objects. The set of pack-
   files is selected greedily by sorting the pack-files by modified
   time and adding a pack-file to the set if its "expected size" is
   smaller than the batch size until the total expected size of the
   selected pack-files is at least the batch size. The "expected
   size" is calculated by taking the size of the pack-file divided
   by the number of objects in the pack-file and multiplied by the
   number of objects from the multi-pack-index with offset in that
   pack-file. The expected size approximates how much data from that
   pack-file will contribute to the resulting pack-file size. The
   intention is that the resulting pack-file will be close in size
   to the provided batch size.

   The next run of the incremental-repack task will delete these
   repacked pack-files during the 'expire' step.

   In this version, the batch size is set to "0" which ignores the
   size restrictions when selecting the pack-files. It instead
   selects all pack-files and repacks all packed objects into a
   single pack-file. This will be updated in the next change, but
   it requires doing some calculations that are better isolated to
   a separate change.

These steps are based on a similar background maintenance step in
Scalar (and VFS for Git) [1]. This was incredibly effective for
users of the Windows OS repository. After using the same VFS for Git
repository for over a year, some users had _thousands_ of pack-files
that combined to up to 250 GB of data. We noticed a few users were
running into the open file descriptor limits (due in part to a bug
in the multi-pack-index fixed by af96fe3 (midx: add packs to
packed_git linked list, 2019-04-29).

These pack-files were mostly small since they contained the commits
and trees that were pushed to the origin in a given hour. The GVFS
protocol includes a "prefetch" step that asks for pre-computed pack-
files containing commits and trees by timestamp. These pack-files
were grouped into "daily" pack-files once a day for up to 30 days.
If a user did not request prefetch packs for over 30 days, then they
would get the entire history of commits and trees in a new, large
pack-file. This led to a large number of pack-files that had poor
delta compression.

By running this pack-file maintenance step once per day, these repos
with thousands of packs spanning 200+ GB dropped to dozens of pack-
files spanning 30-50 GB. This was done all without removing objects
from the system and using a constant batch size of two gigabytes.
Once the work was done to reduce the pack-files to small sizes, the
batch size of two gigabytes means that not every run triggers a
repack operation, so the following run will not expire a pack-file.
This has kept these repos in a "clean" state.

[1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/PackfileMaintenanceStep.cs

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 18 ++++++++
 builtin/gc.c                      | 76 +++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh       |  1 +
 t/t7900-maintenance.sh            | 38 ++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index fc95eb594f..3f5d8946b4 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -85,6 +85,24 @@ loose-objects::
 	advisable to enable both the `loose-objects` and `gc` tasks at the
 	same time.
 
+incremental-repack::
+	The `incremental-repack` job repacks the object directory
+	using the `multi-pack-index` feature. In order to prevent race
+	conditions with concurrent Git commands, it follows a two-step
+	process. First, it calls `git multi-pack-index expire` to delete
+	pack-files unreferenced by the `multi-pack-index` file. Second, it
+	calls `git multi-pack-index repack` to select several small
+	pack-files and repack them into a bigger one, and then update the
+	`multi-pack-index` entries that refer to the small pack-files to
+	refer to the new pack-file. This prepares those small pack-files
+	for deletion upon the next run of `git multi-pack-index expire`.
+	The selection of the small pack-files is such that the expected
+	size of the big pack-file is at least the batch size; see the
+	`--batch-size` option for the `repack` subcommand in
+	linkgit:git-multi-pack-index[1]. The default batch-size is zero,
+	which is a special case that attempts to repack all pack-files
+	into a single pack-file.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 4403827481..5f877b097a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1001,6 +1001,77 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
 	return prune_packed(opts) || pack_loose(opts);
 }
 
+static int multi_pack_index_write(struct maintenance_run_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "write", NULL);
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	if (run_command(&child))
+		return error(_("failed to write multi-pack-index"));
+
+	return 0;
+}
+
+static int multi_pack_index_expire(struct maintenance_run_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	close_object_store(the_repository->objects);
+
+	if (run_command(&child))
+		return error(_("'git multi-pack-index expire' failed"));
+
+	return 0;
+}
+
+static int multi_pack_index_repack(struct maintenance_run_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	strvec_push(&child.args, "--batch-size=0");
+
+	close_object_store(the_repository->objects);
+
+	if (run_command(&child))
+		return error(_("'git multi-pack-index repack' failed"));
+
+	return 0;
+}
+
+static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts)
+{
+	prepare_repo_settings(the_repository);
+	if (!the_repository->settings.core_multi_pack_index) {
+		warning(_("skipping incremental-repack task because core.multiPackIndex is disabled"));
+		return 0;
+	}
+
+	if (multi_pack_index_write(opts))
+		return 1;
+	if (multi_pack_index_expire(opts))
+		return 1;
+	if (multi_pack_index_repack(opts))
+		return 1;
+	return 0;
+}
+
 typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
 
 /*
@@ -1023,6 +1094,7 @@ struct maintenance_task {
 enum maintenance_task_label {
 	TASK_PREFETCH,
 	TASK_LOOSE_OBJECTS,
+	TASK_INCREMENTAL_REPACK,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -1040,6 +1112,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_loose_objects,
 		loose_object_auto_condition,
 	},
+	[TASK_INCREMENTAL_REPACK] = {
+		"incremental-repack",
+		maintenance_task_incremental_repack,
+	},
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ec87f616c6..2f942ee1fa 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,6 +3,7 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+GIT_TEST_MULTI_PACK_INDEX=0
 objdir=.git/objects
 
 midx_read_expect () {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 27565c55a2..a2db2291b0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -5,6 +5,7 @@ test_description='git maintenance builtin'
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_MULTI_PACK_INDEX=0
 
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
@@ -149,4 +150,41 @@ test_expect_success 'maintenance.loose-objects.auto' '
 	test_subcommand git prune-packed --quiet <trace-loC
 '
 
+test_expect_success 'incremental-repack task' '
+	packDir=.git/objects/pack &&
+	for i in $(test_seq 1 5)
+	do
+		test_commit $i || return 1
+	done &&
+
+	# Create three disjoint pack-files with size BIG, small, small.
+	echo HEAD~2 | git pack-objects --revs $packDir/test-1 &&
+	test_tick &&
+	git pack-objects --revs $packDir/test-2 <<-\EOF &&
+	HEAD~1
+	^HEAD~2
+	EOF
+	test_tick &&
+	git pack-objects --revs $packDir/test-3 <<-\EOF &&
+	HEAD
+	^HEAD~1
+	EOF
+	rm -f $packDir/pack-* &&
+	rm -f $packDir/loose-* &&
+	ls $packDir/*.pack >packs-before &&
+	test_line_count = 3 packs-before &&
+
+	# the job repacks the two into a new pack, but does not
+	# delete the old ones.
+	git maintenance run --task=incremental-repack &&
+	ls $packDir/*.pack >packs-between &&
+	test_line_count = 4 packs-between &&
+
+	# the job deletes the two old packs, and does not write
+	# a new one because only one pack remains.
+	git maintenance run --task=incremental-repack &&
+	ls .git/objects/pack/*.pack >packs-after &&
+	test_line_count = 1 packs-after
+'
+
 test_done
-- 
gitgitgadget

