Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9AC433E4
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D167B20829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExoMiR+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgG3WY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgG3WYw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491BC061575
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so7006838wme.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PasK1usoUHuqqBJ/4S4gEHtQklNT/S528NCSF7FdP14=;
        b=ExoMiR+z9Asz+riCJ+lGykLmjhR7RUPd1T6ZBHGduC028624Ue4q/STtvWyyOBZ9IE
         Tjt+Stfju9bmfUjgwSAqj2MPk4VV8ibEofDdWz0Ev3g5+4YffKkzwrHJAUAoSuyqUFuZ
         UEjbl5lC+ilPJ/B/yQMPQPO8RS6aJipzm8DeKw5n4mZ3kTaaBofUGERDbyaobpiqQGR6
         WYjNaJPzz6j7eM/1C07QGSduJlSlfvyIBT/9MbRMSh9xBtP1eu/nOkPpO9zdmUp2XjEN
         bGmoBCft/V8N1EYgm9hCuJogqn4erWFWU7BqH5wE48M2IkeSaXyxGm13h1xLN2xaMym7
         513Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PasK1usoUHuqqBJ/4S4gEHtQklNT/S528NCSF7FdP14=;
        b=WsNKFsdmDQzYO/f45F7OeGe9fGJ+5ArLleG0gLXgR5txJYqJbR0S4FbipTbqfD4UFr
         qKNaA1+XAcCCyXCX2XxT0X+LwSakVORJfo9knThoGC3DjvId2rW5v2TgWEsg0PlU+wLK
         a140umV+KXcVfdG6jQxX6s9OVOcMuRL2o+SaH7yrJd7Et5JsJhIFIhYrMkQ/PBj3UgDa
         FzB0uzlJjJzazxe7bHHOdYc30t/F1x6IrBjC5/knOmpqXGk8XoB+c/Z1HhBLuKv+aAxr
         VARQnTpzaQzQljGVUd86Rg6SqPr0P7r9vMX/lg9MIxOJ06g/Rop3Csh80r559EQ91lfQ
         JDlQ==
X-Gm-Message-State: AOAM530i9Foetsvtzn7t0w5ZQQicBm1HssmYcKjclSbpnbWm9qbD1iYE
        iguNHsKt4g/NsSia/0Zyy4MX9xl7
X-Google-Smtp-Source: ABdhPJwlxOb35hDnWiJRMyYb0Ztp/rXMY1faYxhNHaX2wraXgCj21IFJr9dW+3C1fTOqiMmB89svAg==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr1217712wmb.56.1596147889326;
        Thu, 30 Jul 2020 15:24:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o126sm12047706wma.20.2020.07.30.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:48 -0700 (PDT)
Message-Id: <00f47c48484c16987592d8b39fbd70e2744e3d4a.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:18 +0000
Subject: [PATCH v3 12/20] maintenance: add incremental-repack task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
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

Each of the above steps update the multi-pack-index file. After
each step, we verify the new multi-pack-index. If the new
multi-pack-index is corrupt, then delete the multi-pack-index,
rewrite it from scratch, and stop doing the later steps of the
job. This is intended to be an extra-safe check without leaving
a repo with many pack-files without a multi-pack-index.

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
 Documentation/git-maintenance.txt |  15 ++++
 builtin/gc.c                      | 112 ++++++++++++++++++++++++++++++
 midx.c                            |   2 +-
 midx.h                            |   1 +
 t/t5319-multi-pack-index.sh       |   1 +
 t/t7900-maintenance.sh            |  38 ++++++++++
 6 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 077929b691..a598582986 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -87,6 +87,21 @@ loose-objects::
 	thousand objects to prevent the job from taking too long on a
 	repository with many loose objects.
 
+incremental-repack::
+	The `incremental-repack` job repacks the object directory
+	using the `multi-pack-index` feature. In order to prevent race
+	conditions with concurrent Git commands, it follows a two-step
+	process. First, it deletes any pack-files included in the
+	`multi-pack-index` where none of the objects in the
+	`multi-pack-index` reference those pack-files; this only happens
+	if all objects in the pack-file are also stored in a newer
+	pack-file. Second, it selects a group of pack-files whose "expected
+	size" is below the batch size until the group has total expected
+	size at least the batch size; see the `--batch-size` option for
+	the `repack` subcommand in linkgit:git-multi-pack-index[1]. The
+	default batch-size is zero, which is a special case that attempts
+	to repack all pack-files into a single pack-file.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 96ded73b2f..99ab1f5e9d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -29,6 +29,7 @@
 #include "tree.h"
 #include "promisor-remote.h"
 #include "remote.h"
+#include "midx.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -924,6 +925,112 @@ static int maintenance_task_loose_objects(void)
 	return prune_packed() || pack_loose();
 }
 
+static int multi_pack_index_write(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "write", NULL);
+
+	if (opts.quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	if (run_command(&child))
+		return error(_("failed to write multi-pack-index"));
+
+	return 0;
+}
+
+static int rewrite_multi_pack_index(void)
+{
+	struct repository *r = the_repository;
+	char *midx_name = get_midx_filename(r->objects->odb->path);
+
+	unlink(midx_name);
+	free(midx_name);
+
+	return multi_pack_index_write();
+}
+
+static int multi_pack_index_verify(const char *message)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "verify", NULL);
+
+	if (opts.quiet)
+		strvec_push(&child.args, "--no-progress");
+
+	if (run_command(&child)) {
+		warning(_("'git multi-pack-index verify' failed %s"), message);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int multi_pack_index_expire(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
+
+	if (opts.quiet)
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
+static int multi_pack_index_repack(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
+
+	if (opts.quiet)
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
+static int maintenance_task_incremental_repack(void)
+{
+	prepare_repo_settings(the_repository);
+	if (!the_repository->settings.core_multi_pack_index) {
+		warning(_("skipping incremental-repack task because core.multiPackIndex is disabled"));
+		return 0;
+	}
+
+	if (multi_pack_index_write())
+		return 1;
+	if (multi_pack_index_verify("after initial write"))
+		return rewrite_multi_pack_index();
+	if (multi_pack_index_expire())
+		return 1;
+	if (multi_pack_index_verify("after expire step"))
+		return !!rewrite_multi_pack_index();
+	if (multi_pack_index_repack())
+		return 1;
+	if (multi_pack_index_verify("after repack step"))
+		return !!rewrite_multi_pack_index();
+	return 0;
+}
+
 typedef int maintenance_task_fn(void);
 
 struct maintenance_task {
@@ -937,6 +1044,7 @@ struct maintenance_task {
 enum maintenance_task_label {
 	TASK_PREFETCH,
 	TASK_LOOSE_OBJECTS,
+	TASK_INCREMENTAL_REPACK,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -953,6 +1061,10 @@ static struct maintenance_task tasks[] = {
 		"loose-objects",
 		maintenance_task_loose_objects,
 	},
+	[TASK_INCREMENTAL_REPACK] = {
+		"incremental-repack",
+		maintenance_task_incremental_repack,
+	},
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
diff --git a/midx.c b/midx.c
index ef499cf504..f0ebee34c8 100644
--- a/midx.c
+++ b/midx.c
@@ -37,7 +37,7 @@
 
 #define PACK_EXPIRED UINT_MAX
 
-static char *get_midx_filename(const char *object_dir)
+char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
diff --git a/midx.h b/midx.h
index b18cf53bc4..baeecc70c9 100644
--- a/midx.h
+++ b/midx.h
@@ -37,6 +37,7 @@ struct multi_pack_index {
 
 #define MIDX_PROGRESS     (1 << 0)
 
+char *get_midx_filename(const char *object_dir);
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7214cab36c..2abd29a007 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,6 +3,7 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+GIT_TEST_MULTI_PACK_INDEX=0
 objdir=.git/objects
 
 midx_read_expect () {
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 27a423a4f2..0cc59adb21 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -5,6 +5,7 @@ test_description='git maintenance builtin'
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_MULTI_PACK_INDEX=0
 
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
@@ -106,4 +107,41 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
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

