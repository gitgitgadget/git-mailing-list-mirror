Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF88C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E74C206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqA1H9zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHFRxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgHFQbT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80226C00217C
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so10279797wmi.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I4BsRg8VbRqX01hCeMTWC2RLQxTHroDQeA7ZHgXeUn0=;
        b=jqA1H9zfO0ilL4aUyWzJSaQ7BWDIToFHvtTxwp3BF7eQMnG37cjIlxcHSAH3khm9Xb
         0gDinP4c/1tNvPPgVAE6IlG3NjUTjmV19EjTzN0wRgfFskGSVni8ZwyBfdaDEa9xX1HH
         IO3Z+OeHbD5Axc/a3m+IhLXnclROqbMaoIw56OQVkroewst6tewM0pnalJ/ycFg81sak
         6CAhDwKNg3FzYZtzYLs/wae9cQeXYQeSbZslD/P98i8fr7pr9finItPoMIfrRt9lGmEk
         weqx/piOnXg6AjMZ5Ci6Dj3MEeiJuV1jUE4qzvS4bojaBF2Zs2u1ZQK/9lbAjirHsvP/
         0X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I4BsRg8VbRqX01hCeMTWC2RLQxTHroDQeA7ZHgXeUn0=;
        b=jjODIR9vZnIVGKgcKLdd/Pk5GQTRgM5+NnLq1VLKfE+lGMt4krwmHyDyOQMsDlAcoW
         ixuu/f+52axg7qIWaOwPV23VfJF2M7vbJhU/LYQX9Q+JV4lcT5XjcJt86gHKeNjwkXnN
         DyvFiN0wzmVaSpfx+mhC5k2c6UfgzUbgL9eiLRSIX7aPCImQ5On6hxfuIfq9O1pmkm0+
         lHdM7iasJOVUjdDqNK5FF4mWQRIXsL8vJW7wkKs9H+JdVh9SrFJL92UNo+fvjBHqOHsh
         P4t8tGAfdsUZwMYetFD9G9Y74M1ggoSg+14QPU/TyCnf8HMkIsVgqLaTIcBGm3KjcHo3
         3gXg==
X-Gm-Message-State: AOAM533sihsLQxzfAgJuZJe2QHZ5TrtaACTVnRCQm0JofJkrTHS58e4N
        SjE46rQK9woo/GJRu4m6zRz+wi1v
X-Google-Smtp-Source: ABdhPJxw9qmsb2DCHK33J93IBR+dJCQDHU53aHthrP6F1SPgimmj+KJYNS2rNn0HWRFOqOGGofGPNQ==
X-Received: by 2002:a1c:3983:: with SMTP id g125mr8207450wma.64.1596731428711;
        Thu, 06 Aug 2020 09:30:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm6665850wrn.95.2020.08.06.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:28 -0700 (PDT)
Message-Id: <621375a3c99014c48568660bde062b7330d5a662.1596731425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:18 +0000
Subject: [PATCH 3/9] maintenance: add loose-objects task
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
 Documentation/git-maintenance.txt | 11 ++++
 builtin/gc.c                      | 97 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 39 +++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index bb0d5eded4..898aff4726 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -80,6 +80,17 @@ gc::
 	It can also be disruptive in some situations, as it deletes stale
 	data.
 
+loose-objects::
+	The `loose-objects` job cleans up loose objects and places them into
+	pack-files. In order to prevent race conditions with concurrent Git
+	commands, it follows a two-step process. First, it deletes any loose
+	objects that already exist in a pack-file; concurrent Git processes
+	will examine the pack-file for the object data instead of the loose
+	object. Second, it creates a new pack-file (starting with "loose-")
+	containing a batch of loose objects. The batch size is limited to 50
+	thousand objects to prevent the job from taking too long on a
+	repository with many loose objects.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 942b7ea535..60261d2647 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -908,6 +908,98 @@ static int maintenance_task_gc(struct maintenance_opts *opts)
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
@@ -928,6 +1020,7 @@ struct maintenance_task {
 
 enum maintenance_task_label {
 	TASK_PREFETCH,
+	TASK_LOOSE_OBJECTS,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -940,6 +1033,10 @@ static struct maintenance_task tasks[] = {
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
index 3dd99ef660..8d54f93a10 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -83,4 +83,43 @@ test_expect_success 'prefetch multiple remotes' '
 	git log prefetch/remote2/two
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

