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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B418FC47420
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677C021D91
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5YrNA5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIYMdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIYMdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27EC0613D3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so3125422wmm.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Ngjsw8lFpJbAWCMKSZMZvZholuwlHMRCUkZ+A+ieRo=;
        b=M5YrNA5uTIJt8yEHtjBHAOVsFmotoVz/vdysQ9uGh7G2ha9Wv2+dmMF0HlDk7RZ9ar
         bS02wfBmO7leB9TvxvZ2tSoht2mT/HsA0XcqT8XvgSydRYZy705f4OZsINhkrZBuiI4K
         a10a3cU19micOLtfw6h6EtHN4A7nRr9jaOQoKSMBsSnEaiYolUUBlu5MnUSuAEHNSo/O
         m8ZVBYL5fb4G6XygiCojD5AAhQoxqViCZqBdwSW9JAP7Li7eEIwNuypUOfRvEDh8I0vD
         63Ae2vtjrFXELCFI9y9nhtAts3muWVaLzndg/Rwepio1eTN+rd5NfXC3aTj52y8VX2LF
         UKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Ngjsw8lFpJbAWCMKSZMZvZholuwlHMRCUkZ+A+ieRo=;
        b=sanG8G9JSHikaS/w4BKVOLlsQVkkQ9ucMdaGiTZgKC10x0CdLFMAT11WnX+IBbZmx4
         L+oKyeRnUqBHDb7K0qPT8uTro7ituLz7MhPe/j8sujuOg7EmRLIFvyHM8Ucw6pMRInr/
         BK84iQNPfwHnwE/8XSrvIK4frx43MVk7GGwm6EotBaemnx0Uwfr8hnIIIJs6eGRBTSjL
         Faa5AComfRWBCdlrywuJBiZKLszm59qMSJ2W4B3erxdaXk5mrvJV6oSRwQ4V3HXB4mjC
         /6z1Dzah/3mPlPJWEVuudRYR6oLyJd2xRuFhtOkQwZxZlywH/5tkxer3WLu2lkBSwcYh
         Nydw==
X-Gm-Message-State: AOAM533w27Mju1t26zUmTS2LB1j7IxILqaIap5VXY6nIATGc/ZpTgSGE
        thkxVNdnbrXqziHxKdA4avAD4qe524s=
X-Google-Smtp-Source: ABdhPJx6aGrd1gCou+4No4mEDnKGA5XmGcDLmUcfMEJptv3Ws1wdXlC9tm9IEF8CQ8l4cIUx8BWlbA==
X-Received: by 2002:a7b:ca4a:: with SMTP id m10mr2929422wml.11.1601037222320;
        Fri, 25 Sep 2020 05:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm2790976wrb.28.2020.09.25.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:33:41 -0700 (PDT)
Message-Id: <f3a16fd324a6b74ce93e8b764553ff7f4705b42e.1601037218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
        <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 12:33:32 +0000
Subject: [PATCH v4 2/8] maintenance: add loose-objects task
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
   requires populating a virtual file.

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
index 5e469488f4..c9db8555b9 100644
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
index 045524e6ad..b3fc7c8670 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -88,4 +88,43 @@ test_expect_success 'prefetch multiple remotes' '
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

