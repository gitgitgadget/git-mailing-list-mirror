Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290DBC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEE22071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN2gAYfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHYSgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYSgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:36:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14876C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so3128999wmk.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6r2hLeU/nyGmpZiDrr6PAXzoBR1Xz/3XJ77BSywaxfQ=;
        b=TN2gAYfHwu+7s6DVfDCXtIPOU6KyhbtMrzSSKbCgrr/ac+TRGhcyy6q72x3DkSOSmL
         A76T7tkA5jenFedHZGY9ohc7ykIif55p5YsHuPOCX3+UTDwp+bNUCYCSEAS9aooE8qtp
         0PKQq8TVM/5nHcpBJQLCoauyTcwMqaKxytM3Mr3cvhF3lOK44U8qw6I8hL6aKbzWn0p1
         Gq1QofMsLkxeZJ3TclT6JaKISCuzOXc4m3WfRaqDoQMkndLfhhs6eoTmkVwPOGqdSLzm
         /24Sy83ushLHQ3F1f/vz6aG6gWdvexEnEjy5hnTiW79CGkNhr+R1ZTHhyN720Rq9BkHq
         K5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6r2hLeU/nyGmpZiDrr6PAXzoBR1Xz/3XJ77BSywaxfQ=;
        b=gVlJqaaaJ9F5YZgfPTmOa1sfgAAMUoIhUdY/I+Ys1MpfJ7vpfH/m+FvBVKwL/yHwxW
         tMk0c5cDMGl3j+jw8RS10m3yh7/8WMP7EU5Kh8/weaCPi12D+v1hIjs0GIvb52MZe1b2
         Iy13Vx5c1Q+NU8mN4Iiss2eIqs9mfqEXWpZVVJGBb9PK/zYEQgUmPiPinzAT4FYZIPne
         vPZiGTTXTSkgp20DoquDvq0tjouhqoN1MPi+Z/B5LJe2gtqmqMgAg6m+ypkzXZAdRATU
         RCcIKUWuLe9hVaA0ym6YfyaVDOGXE2npWIMP0pvP+4QTpKB5RSzT7Et9yyP788Av45lG
         RNMQ==
X-Gm-Message-State: AOAM530yCAUncBqMa/ctGaaNt75QF8nTbON26zeqh16Enrh+yOvBLYFo
        h/vnMZ+BKQUlevC5xk8SO0JY0HY8xrY=
X-Google-Smtp-Source: ABdhPJzQsdGANBeEI/4TgNHc9KtAq5H5I9bMh/eMCDjBiT2PuBnp0GuGaOO75nBx/USnZ7fb43CZlg==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr3382870wmk.46.1598380602471;
        Tue, 25 Aug 2020 11:36:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm8051471wma.45.2020.08.25.11.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:36:41 -0700 (PDT)
Message-Id: <75e846456b8ac4a3518ecc9051c927539dd7ff08.1598380599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
        <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:36:33 +0000
Subject: [PATCH v3 2/8] maintenance: add loose-objects task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

One goal of background maintenance jobs is to allow a user to
disable auto-gc (gc.auto=0) but keep their repository in a clean
state. Without any cleanup, loose objects will clutter the object
database and slow operations. In addition, the loose objects will
take up extra space because they are not stored with deltas against
similar objects.

Create a 'loose-objects' task for the 'git maintenance run' command.
This helps clean up loose objects without disrupting concurrent Git
commands using the following sequence of events:

1. Run 'git prune-packed' to delete any loose objects that exist
   in a pack-file. Concurrent commands will prefer the packed
   version of the object to the loose version. (Of course, there
   are exceptions for commands that specifically care about the
   location of an object. These are rare for a user to run on
   purpose, and we hope a user that has selected background
   maintenance will not be trying to do foreground maintenance.)

2. Run 'git pack-objects' on a batch of loose objects. These
   objects are grouped by scanning the loose object directories in
   lexicographic order until listing all loose objects -or-
   reaching 50,000 objects. This is more than enough if the loose
   objects are created only by a user doing normal development.
   We noticed users with _millions_ of loose objects because VFS
   for Git downloads blobs on-demand when a file read operation
   requires populating a virtual file. This has potential of
   happening in partial clones if someone runs 'git grep' or
   otherwise evades the batch-download feature for requesting
   promisor objects.

This step is based on a similar step in Scalar [1] and VFS for Git.
[1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/LooseObjectsStep.cs

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 15 +++++
 builtin/gc.c                      | 97 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 39 +++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 12668fccf7..fc95eb594f 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -70,6 +70,21 @@ gc::
 	be disruptive in some situations, as it deletes stale data. See
 	linkgit:git-gc[1] for more details on garbage collection in Git.
 
+loose-objects::
+	The `loose-objects` job cleans up loose objects and places them into
+	pack-files. In order to prevent race conditions with concurrent Git
+	commands, it follows a two-step process. First, it deletes any loose
+	objects that already exist in a pack-file; concurrent Git processes
+	will examine the pack-file for the object data instead of the loose
+	object. Second, it creates a new pack-file (starting with "loose-")
+	containing a batch of loose objects. The batch size is limited to 50
+	thousand objects to prevent the job from taking too long on a
+	repository with many loose objects. The `gc` task writes unreachable
+	objects as loose objects to be cleaned up by a later step only if
+	they are not re-added to a pack-file; for this reason it is not
+	advisable to enable both the `loose-objects` and `gc` tasks at the
+	same time.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index eb9c4d6147..248ccde3c3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -880,6 +880,98 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts)
 	return run_command(&child);
 }
 
+static int prune_packed(struct maintenance_run_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_push(&child.args, "prune-packed");
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--quiet");
+
+	return !!run_command(&child);
+}
+
+struct write_loose_object_data {
+	FILE *in;
+	int count;
+	int batch_size;
+};
+
+static int bail_on_loose(const struct object_id *oid,
+			 const char *path,
+			 void *data)
+{
+	return 1;
+}
+
+static int write_loose_object_to_stdin(const struct object_id *oid,
+				       const char *path,
+				       void *data)
+{
+	struct write_loose_object_data *d = (struct write_loose_object_data *)data;
+
+	fprintf(d->in, "%s\n", oid_to_hex(oid));
+
+	return ++(d->count) > d->batch_size;
+}
+
+static int pack_loose(struct maintenance_run_opts *opts)
+{
+	struct repository *r = the_repository;
+	int result = 0;
+	struct write_loose_object_data data;
+	struct child_process pack_proc = CHILD_PROCESS_INIT;
+
+	/*
+	 * Do not start pack-objects process
+	 * if there are no loose objects.
+	 */
+	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
+					   bail_on_loose,
+					   NULL, NULL, NULL))
+		return 0;
+
+	pack_proc.git_cmd = 1;
+
+	strvec_push(&pack_proc.args, "pack-objects");
+	if (opts->quiet)
+		strvec_push(&pack_proc.args, "--quiet");
+	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
+
+	pack_proc.in = -1;
+
+	if (start_command(&pack_proc)) {
+		error(_("failed to start 'git pack-objects' process"));
+		return 1;
+	}
+
+	data.in = xfdopen(pack_proc.in, "w");
+	data.count = 0;
+	data.batch_size = 50000;
+
+	for_each_loose_file_in_objdir(r->objects->odb->path,
+				      write_loose_object_to_stdin,
+				      NULL,
+				      NULL,
+				      &data);
+
+	fclose(data.in);
+
+	if (finish_command(&pack_proc)) {
+		error(_("failed to finish 'git pack-objects' process"));
+		result = 1;
+	}
+
+	return result;
+}
+
+static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
+{
+	return prune_packed(opts) || pack_loose(opts);
+}
+
 typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
 
 /*
@@ -901,6 +993,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_PREFETCH,
+	TASK_LOOSE_OBJECTS,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -913,6 +1006,10 @@ static struct maintenance_task tasks[] = {
 		"prefetch",
 		maintenance_task_prefetch,
 	},
+	[TASK_LOOSE_OBJECTS] = {
+		"loose-objects",
+		maintenance_task_loose_objects,
+	},
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0bade09c43..2e9e369786 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -86,4 +86,43 @@ test_expect_success 'prefetch multiple remotes' '
 	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
 '
 
+test_expect_success 'loose-objects task' '
+	# Repack everything so we know the state of the object dir
+	git repack -adk &&
+
+	# Hack to stop maintenance from running during "git commit"
+	echo in use >.git/objects/maintenance.lock &&
+
+	# Assuming that "git commit" creates at least one loose object
+	test_commit create-loose-object &&
+	rm .git/objects/maintenance.lock &&
+
+	ls .git/objects >obj-dir-before &&
+	test_file_not_empty obj-dir-before &&
+	ls .git/objects/pack/*.pack >packs-before &&
+	test_line_count = 1 packs-before &&
+
+	# The first run creates a pack-file
+	# but does not delete loose objects.
+	git maintenance run --task=loose-objects &&
+	ls .git/objects >obj-dir-between &&
+	test_cmp obj-dir-before obj-dir-between &&
+	ls .git/objects/pack/*.pack >packs-between &&
+	test_line_count = 2 packs-between &&
+	ls .git/objects/pack/loose-*.pack >loose-packs &&
+	test_line_count = 1 loose-packs &&
+
+	# The second run deletes loose objects
+	# but does not create a pack-file.
+	git maintenance run --task=loose-objects &&
+	ls .git/objects >obj-dir-after &&
+	cat >expect <<-\EOF &&
+	info
+	pack
+	EOF
+	test_cmp expect obj-dir-after &&
+	ls .git/objects/pack/*.pack >packs-after &&
+	test_cmp packs-between packs-after
+'
+
 test_done
-- 
gitgitgadget

