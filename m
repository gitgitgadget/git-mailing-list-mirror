Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9215C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9277B20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFyxp2c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHROZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgHROZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7AC061344
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so15493415wmc.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=85W5dqI78PQ8PaMwFhtO/BYuMbB3AYFrtHNEaBzv2aM=;
        b=CFyxp2c+j4CEmPD+em2RmS88JIM/tY9h8VT44Zp1B9O9p/76a/CHIrT11FNQbZ2T8T
         nYhFY5fhucMSjSaRgHhJHwUsevpXvIu+unXnP6HIpv9rvrelIWal5K4g8NPjOOE6Wh2P
         2qzR63DgfxUyVfhzQnugN1FhTnUsJd2qjjQmH3HjBEToUCpgUb0gVMVjbKf36eXKXQVZ
         GhhQfthO4wwgAg+UZCJdNZJRtoyK+3fquNI0ajq+5u1CSc3KJcjeDGUNfg0lgASPui2e
         R52dH8PskScaHz9SC7FQJ34JlGk7W72jRxn/6HOnxIYTGg2zwasL/u24qKCngaE3sdVC
         OwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=85W5dqI78PQ8PaMwFhtO/BYuMbB3AYFrtHNEaBzv2aM=;
        b=Fjl3X2MoUaA0W3biWDIFFWPw5DT8mL4ZUQO4gEbwvKvp81X1gvp1WpxiAt4IQqKKle
         EuLQ2HodgHU/9Jh5hdM8+UOhVTVZZ6ajaArMBikGLSmqZRVrKFzk5klI+3BJ0CpymAK3
         D2IdkR1XVYpxawpbRA/5A85kfmVkAmxU2cZfbTyQ3Z4Qde4yxbJrXFFS6uRNNS4c3JQ2
         S7q4d/2X5AXyHg5D+vA7V5KlaGm/XY2AKrVYR8ZDYArBSa/SDvMIIUbw96z9q8T/V4BF
         D594qu2sP4YnFUsEqqeqXhCy/og0QRQslOH3kBaIm/ASf6kjtSVmiC5pJ63FXSYHklt4
         UG6Q==
X-Gm-Message-State: AOAM532ZI5vWVXQFQRvcdWP+djWT53xELflMtTwGbWYVOlpnSXAiZSv6
        WmBXpib9T/sdpzUjWVnG5zvqqg3IroI=
X-Google-Smtp-Source: ABdhPJzAEKrk3wJ7RUDDglsAAX2tzr1Ug/431gT97TY7uwWA7UXwTMa1AmtpjVY3USrnR5iNX1didg==
X-Received: by 2002:a1c:98c1:: with SMTP id a184mr202353wme.116.1597760735556;
        Tue, 18 Aug 2020 07:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm38148378wrb.59.2020.08.18.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:34 -0700 (PDT)
Message-Id: <4fa9d298b98fa8b83108d9d9c58aef0eab934ee5.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:24 +0000
Subject: [PATCH v2 3/9] maintenance: add loose-objects task
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
index e82799ccff..85205b5bb9 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -73,6 +73,21 @@ gc::
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
index 2ac08cc740..39ea590b5a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -907,6 +907,98 @@ static int maintenance_task_gc(struct maintenance_opts *opts)
 	return run_command(&child);
 }
 
+static int prune_packed(struct maintenance_opts *opts)
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
+static int pack_loose(struct maintenance_opts *opts)
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
+static int maintenance_task_loose_objects(struct maintenance_opts *opts)
+{
+	return prune_packed(opts) || pack_loose(opts);
+}
+
 typedef int maintenance_task_fn(struct maintenance_opts *opts);
 
 /*
@@ -927,6 +1019,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_PREFETCH,
+	TASK_LOOSE_OBJECTS,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -939,6 +1032,10 @@ static struct maintenance_task tasks[] = {
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

