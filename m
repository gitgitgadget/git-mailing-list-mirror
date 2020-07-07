Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB0C433E3
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19AE2073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qO1+y2wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgGGOWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGGOVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEBC08C5E3
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so43479779wmg.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cn7iyirg747zHkIaNK/XiKwYcUeQHNfHYuiko/e8JMI=;
        b=qO1+y2wmJ2ryBAlxJ+Vb1nWfeAdNYgNlv+LksdfDVmoTkx9LwPbW49oD7FVbj0crzF
         2Djj3FQYbFmTbxROTkhkfWRQ9Ukdt8p5JvY2hoeuux6HysR97NWeD9H/+WQrlWPiJx/e
         n4wJvHujp1dTyE2AQMwQbq4YfXMzrFoMoUq4nZKA6OTWHU7p/7eAdUTlhbfqJ0fDW9JJ
         UyQ1ldYhbVZqB6gt8poy8s2q7inDgg+EG3x7x31jjycFOfAJ/ynBZ3CSTaWlCUzqOJKb
         oJnLvRKYhUZOoIZQ+nloSx89oPkx5GfJTsw9PJ+iQg60lN8W0Mug5J8POtzCoBM9+VXD
         /NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cn7iyirg747zHkIaNK/XiKwYcUeQHNfHYuiko/e8JMI=;
        b=lCvBckq74jwd7QPvl+DgXpQmvPfcqHII+RJ3XN3eYfokgwSlu6t1uuSakjFZeVab30
         ePd6txMCzs7lALU+pGUd3llGRchdmKd9hAjvOHAfsAoJgKjcG8HbBI8p19Siw1qSqDv8
         n3yt49vG2DxcffGpi2x5qnyphgemvPZzgK5NfFXxfZs/LQOKWQ4DPniPYfRLZhCdx9sd
         WTPfhCgNi2zVVb4pyPn3k3aRjjd8giv+mY+fpIa/fIRgS6qSY+gDRpuGyBYRD5XbVrPR
         HGUaPSO/PPcPFb/HUSLnXFigTixZ/pqAU634sh4VqKb32CXW42NDMlFJBHZTyZ0uZ+h+
         3LJg==
X-Gm-Message-State: AOAM533nHVt+7dkOwXLrPitMqTMIEUh4B+miRT4O/LI7xHknbeGU0x8X
        Ecc46RFPtOerZDtZghOZCYwgp7Ut
X-Google-Smtp-Source: ABdhPJyuAtfkgd8em4WyyEQIwCiJ05usrgY3dNU5uEjdnCXJjDnoqWMHaEgwbrK5YSXWqhGmeWZp3w==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr4670570wmk.21.1594131707976;
        Tue, 07 Jul 2020 07:21:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm1280672wrx.63.2020.07.07.07.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:47 -0700 (PDT)
Message-Id: <f98790024f10b70cbd2d88cb09126c5a83c9c400.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:28 +0000
Subject: [PATCH 14/21] maintenance: add pack-files task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
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

The 'pack-files' job runs the following steps:

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
   pack-file. The expected size approximats how much data from that
   pack-file will contribute to the resulting pack-file size. The
   intention is that the resulting pack-file will be close in size
   to the provided batch size.

   The next run of the pack-files job will delete these repacked
   pack-files during the 'expire' step.

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
 builtin/gc.c                      | 124 +++++++++++++++++++++++++++++-
 midx.c                            |   2 +-
 midx.h                            |   1 +
 t/t7900-maintenance.sh            |  37 +++++++++
 5 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index bf792d446f..945fda368b 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -84,6 +84,21 @@ loose-objects::
 	thousand objects to prevent the job from taking too long on a
 	repository with many loose objects.
 
+pack-files::
+	The `pack-files` job incrementally repacks the object directory
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
index dda71fe39c..259b0475c0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -29,6 +29,7 @@
 #include "tree.h"
 #include "promisor-remote.h"
 #include "remote.h"
+#include "midx.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -706,7 +707,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-#define MAX_NUM_TASKS 4
+#define MAX_NUM_TASKS 5
 
 static const char * const builtin_maintenance_usage[] = {
 	N_("git maintenance run [<options>]"),
@@ -967,6 +968,123 @@ static int maintenance_task_loose_objects(struct repository *r)
 	return prune_packed(r) || pack_loose(r);
 }
 
+static int multi_pack_index_write(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "-C", r->worktree,
+			 "multi-pack-index", "write", NULL);
+
+	if (opts.quiet)
+		argv_array_push(&cmd, "--no-progress");
+
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	argv_array_clear(&cmd);
+
+	return result;
+}
+
+static int rewrite_multi_pack_index(struct repository *r)
+{
+	char *midx_name = get_midx_filename(r->objects->odb->path);
+
+	unlink(midx_name);
+	free(midx_name);
+
+	if (multi_pack_index_write(r)) {
+		error(_("failed to rewrite multi-pack-index"));
+		return 1;
+	}
+
+	return 0;
+}
+
+static int multi_pack_index_verify(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "-C", r->worktree,
+			 "multi-pack-index", "verify", NULL);
+
+	if (opts.quiet)
+		argv_array_push(&cmd, "--no-progress");
+
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	argv_array_clear(&cmd);
+
+	return result;
+}
+
+static int multi_pack_index_expire(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "-C", r->worktree,
+			 "multi-pack-index", "expire", NULL);
+
+	if (opts.quiet)
+		argv_array_push(&cmd, "--no-progress");
+
+	close_object_store(r->objects);
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	argv_array_clear(&cmd);
+
+	return result;
+}
+
+static int multi_pack_index_repack(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "-C", r->worktree,
+			 "multi-pack-index", "repack", NULL);
+
+	if (opts.quiet)
+		argv_array_push(&cmd, "--no-progress");
+
+	argv_array_push(&cmd, "--batch-size=0");
+
+	close_object_store(r->objects);
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+
+	if (result && multi_pack_index_verify(r)) {
+		warning(_("multi-pack-index verify failed after repack"));
+		result = rewrite_multi_pack_index(r);
+	}
+
+	return result;
+}
+
+static int maintenance_task_pack_files(struct repository *r)
+{
+	if (multi_pack_index_write(r)) {
+		error(_("failed to write multi-pack-index"));
+		return 1;
+	}
+
+	if (multi_pack_index_verify(r)) {
+		warning(_("multi-pack-index verify failed after initial write"));
+		return rewrite_multi_pack_index(r);
+	}
+
+	if (multi_pack_index_expire(r)) {
+		error(_("multi-pack-index expire failed"));
+		return 1;
+	}
+
+	if (multi_pack_index_verify(r)) {
+		warning(_("multi-pack-index verify failed after expire"));
+		return rewrite_multi_pack_index(r);
+	}
+
+	if (multi_pack_index_repack(r)) {
+		error(_("multi-pack-index repack failed"));
+		return 1;
+	}
+
+	return 0;
+}
+
 typedef int maintenance_task_fn(struct repository *r);
 
 struct maintenance_task {
@@ -1061,6 +1179,10 @@ static void initialize_tasks(void)
 	tasks[num_tasks]->fn = maintenance_task_loose_objects;
 	num_tasks++;
 
+	tasks[num_tasks]->name = "pack-files";
+	tasks[num_tasks]->fn = maintenance_task_pack_files;
+	num_tasks++;
+
 	tasks[num_tasks]->name = "gc";
 	tasks[num_tasks]->fn = maintenance_task_gc;
 	tasks[num_tasks]->enabled = 1;
diff --git a/midx.c b/midx.c
index 6d1584ca51..57a8a00082 100644
--- a/midx.c
+++ b/midx.c
@@ -36,7 +36,7 @@
 
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
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8cb33624c6..a6be8456aa 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -103,4 +103,41 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'pack-files task' '
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
+	git maintenance run --task=pack-files &&
+	ls $packDir/*.pack >packs-between &&
+	test_line_count = 4 packs-between &&
+
+	# the job deletes the two old packs, and does not write
+	# a new one because only one pack remains.
+	git maintenance run --task=pack-files &&
+	ls .git/objects/pack/*.pack >packs-after &&
+	test_line_count = 1 packs-after
+'
+
 test_done
-- 
gitgitgadget

