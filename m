Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0FAC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E392073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+hbC2UV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGGOWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGOVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B56C08C5E2
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so43479678wmg.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4lNQ9p+kRBFUS25p25FlN+qS1yhHsgvMuLEYIXJlSLk=;
        b=S+hbC2UVS95VM6j+FlE4ecGxVvFj6wHInlXoMJ3XrGQQ2fgZe5YK7MgwKGbSlJND6X
         5dRH+RUMcuoe5zDaD+QvWiNr8ZKzV1kROumjhH5xhU7ce0jJuJYWg9G/cEtWA5VzOT4r
         M0L9SGCb0PyF9++a585Qi3fN3o3n9wUoj3s8UUqnlNE53ecV8WsJETya5sTui8IoWDrI
         ZfcUwCtnbYqY1L9BJfyBp3JaiHcNF7yB0D/Yoj502Zen3SNLf11OGsvC1KojO5FEA4nS
         5DrICrlFXMpegfERjrSgcpZX+wX+5F4glUE5bb7b0/v98CQSzkJjWy7YOve7kjNY+MsZ
         noZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4lNQ9p+kRBFUS25p25FlN+qS1yhHsgvMuLEYIXJlSLk=;
        b=PXZ3DDtFf/TuX0jxpTpY8DDnWnzme7Hk0SfnF6+Avc3sF/QrI2g1zF7jkYMwgBEG24
         jP9F/m55J3c2HjjHLx4HjYLDjW33tSfRHr8gS8EUYU2/Tr8MGgmv0/QTlgo1zzEPKYqD
         zy8rg+23LUEB7XOnR2gSSQnpeRss6DDNOEk30wZEn98wMpIMLbWroea2wreEpJJUcpEG
         TporAAITjX3VLdDLgBDPTGpLdXmJF1Z1h9LFDih0RqkK2yD/AfhOQibO+93bpVGXf0lD
         1V8agd/IEulcCG0KDfPQ8fyhR9Ev6AyT4c9Ap0t51W69KCmR3kNeAskYU9BQBMhcwUxH
         VbhA==
X-Gm-Message-State: AOAM532D1QSBnsYj8H4c6BsXkFoD0gTCzNTQvWp77c3KoKB9xvIowwUr
        Br1Bz3WvNsMWzLJkKnw954DeyP2D
X-Google-Smtp-Source: ABdhPJzL0upztJ7QOJb0/GcbyR+tVU7sMn9snVCkODob2U4V/GGp6588809sh9DV601tcV/UvbnCsg==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr4225206wmb.112.1594131707020;
        Tue, 07 Jul 2020 07:21:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k126sm1392375wme.17.2020.07.07.07.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:46 -0700 (PDT)
Message-Id: <66a1f662cee7a1ae18df6e93c70b481157eb2494.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:27 +0000
Subject: [PATCH 13/21] maintenance: add loose-objects task
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
 Documentation/git-maintenance.txt |  11 +++
 builtin/gc.c                      | 107 +++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            |  35 ++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index e0be3f520f..bf792d446f 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -73,6 +73,17 @@ gc::
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
index 2d30ae758c..dda71fe39c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -706,7 +706,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-#define MAX_NUM_TASKS 3
+#define MAX_NUM_TASKS 4
 
 static const char * const builtin_maintenance_usage[] = {
 	N_("git maintenance run [<options>]"),
@@ -866,6 +866,107 @@ static int maintenance_task_gc(struct repository *r)
 	return result;
 }
 
+
+static int prune_packed(struct repository *r)
+{
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "-C", r->worktree, "prune-packed", NULL);
+
+	if (opts.quiet)
+		argv_array_push(&cmd, "--quiet");
+
+	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+}
+
+struct write_loose_object_data {
+	FILE *in;
+	int count;
+	int batch_size;
+};
+
+static int loose_object_exists(const struct object_id *oid,
+			       const char *path,
+			       void *data)
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
+static int pack_loose(struct repository *r)
+{
+	int result = 0;
+	struct write_loose_object_data data;
+	struct strbuf prefix = STRBUF_INIT;
+	struct child_process *pack_proc;
+
+	/*
+	 * Do not start pack-objects process
+	 * if there are no loose objects.
+	 */
+	if (!for_each_loose_file_in_objdir(r->objects->odb->path,
+					   loose_object_exists,
+					   NULL, NULL, NULL))
+		return 0;
+
+	pack_proc = xmalloc(sizeof(*pack_proc));
+
+	child_process_init(pack_proc);
+
+	strbuf_addstr(&prefix, r->objects->odb->path);
+	strbuf_addstr(&prefix, "/pack/loose");
+
+	argv_array_pushl(&pack_proc->args, "git", "-C", r->worktree,
+			 "pack-objects", NULL);
+	if (opts.quiet)
+		argv_array_push(&pack_proc->args, "--quiet");
+	argv_array_push(&pack_proc->args, prefix.buf);
+
+	pack_proc->in = -1;
+
+	if (start_command(pack_proc)) {
+		error(_("failed to start 'git pack-objects' process"));
+		result = 1;
+		goto cleanup;
+	}
+
+	data.in = xfdopen(pack_proc->in, "w");
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
+	if (finish_command(pack_proc)) {
+		error(_("failed to finish 'git pack-objects' process"));
+		result = 1;
+	}
+
+cleanup:
+	strbuf_release(&prefix);
+	free(pack_proc);
+	return result;
+}
+
+static int maintenance_task_loose_objects(struct repository *r)
+{
+	return prune_packed(r) || pack_loose(r);
+}
+
 typedef int maintenance_task_fn(struct repository *r);
 
 struct maintenance_task {
@@ -956,6 +1057,10 @@ static void initialize_tasks(void)
 	tasks[num_tasks]->fn = maintenance_task_fetch;
 	num_tasks++;
 
+	tasks[num_tasks]->name = "loose-objects";
+	tasks[num_tasks]->fn = maintenance_task_loose_objects;
+	num_tasks++;
+
 	tasks[num_tasks]->name = "gc";
 	tasks[num_tasks]->fn = maintenance_task_gc;
 	tasks[num_tasks]->enabled = 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0abfc4a9da..8cb33624c6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -68,4 +68,39 @@ test_expect_success 'fetch multiple remotes' '
 	git log hidden/remote2/two
 '
 
+test_expect_success 'loose-objects task' '
+	# Repack everything so we know the state of the object dir
+	git repack -adk &&
+
+	# Hack to stop maintenance from running during "git commit"
+	echo in use >.git/objects/maintenance.lock &&
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

