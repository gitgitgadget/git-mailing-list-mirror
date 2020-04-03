Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264DC2BA16
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE22220737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6GALd/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDCUsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46348 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgDCUsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id cf14so10862292edb.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6EDvfVR2992sc8KEi8smFmXVBBt2wfqNPRdQbyLCOV8=;
        b=n6GALd/PLHO1p7J/5VepvR2cAz1IF3bwbugTHsQmNqVo2vR23Nfv1LD82pCUNtgF5Y
         S0BvbM3AiB5TwPisvOoIBuHKZ8dL50eeGSTHjenXjlyWzJn6hu2QMBs+EMewNWLmjpCh
         TKlj6s/lf9eHxAp+tG8oOQ2erEuDlHR9RKlo+nYxPFB2/8jLwZIXoHjnuRFrA9xf4N2k
         vv5p1QS6KCENmjswZGcACIjIuhkQLPSynpkB6lLHZvM/3HEMyGNSIAy5BXSQ6VOatYOy
         aS7jbf0nkhvTCRD/ankfXTb5JQwyc1fBLGDAHMd4cdPkULHbhQU2/P56PKQppJHTWfCL
         k4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6EDvfVR2992sc8KEi8smFmXVBBt2wfqNPRdQbyLCOV8=;
        b=BnCvSXpIuuvEecvXjD2FCZ1CMzjtWUICx5DC09rAOzg5t5IwvXzI/ClD/UcD4NWykh
         LgRcA2vjJbfJ7kg+70DTTssLizOfy/hmZUmOvM0tQRxzUhlRxjFLPvSI/JWCaHvNWF+F
         khu2lso7YDsQiAWGI0gKSIdrFqj25pV0kn/rAkIlLWReH0JhWmLkuAgbWhwbb/zxl9at
         yIokZjDmWsrihFzHW1cOEnUOEGA3vf22KKKLJRJuqfwv/iz0ikN+ZPiyi6+nanlCXjL8
         Kkol/dvXVlmUF+VpRRnKT0FibUDB7Fy/6b8aKBdffw9r2jWNcW0dnFbG7/740ae8GxVl
         W4ig==
X-Gm-Message-State: AGi0PuYry3/5TyBnd7XLvAcul0W/PyBsalXsoi2BGyKM8aPKs1n9ZbPY
        o4tNAKR9hvhV8k+82XG/wdQ0qZll
X-Google-Smtp-Source: APiQypK2VL9GGXE3qLIJLokr0JUR7lF58ynf1PO/sygPm7QaJUQ+FEEQW0avsxLdfHf4o0iapnwlMQ==
X-Received: by 2002:a50:c043:: with SMTP id u3mr9685353edd.253.1585946898446;
        Fri, 03 Apr 2020 13:48:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm1590266edw.51.2020.04.03.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:18 -0700 (PDT)
Message-Id: <4c4aeb55dea9dd7b97bd7f08c8a767b498886109.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:03 +0000
Subject: [PATCH 04/15] run-job: implement loose-objects job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
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

Create a 'loose-objects' job for the 'git run-job' command. This
helps clean up loose objects without disrupting concurrent Git
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
 Documentation/git-run-job.txt | 14 ++++-
 builtin/run-job.c             | 97 ++++++++++++++++++++++++++++++++++-
 t/t7900-run-job.sh            | 27 ++++++++++
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
index eb92e891915..43ca1160b5a 100644
--- a/Documentation/git-run-job.txt
+++ b/Documentation/git-run-job.txt
@@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
 SYNOPSIS
 --------
 [verse]
-'git run-job (commit-graph|fetch)'
+'git run-job (commit-graph|fetch|loose-objects)'
 
 
 DESCRIPTION
@@ -59,6 +59,18 @@ This means that foreground fetches are still required to update the
 remote refs, but the users is notified when the branches and tags are
 updated on the remote.
 
+'loose-objects'::
+
+The `loose-objects` job cleans up loose objects and places them into
+pack-files. In order to prevent race conditions with concurrent Git
+commands, it follows a two-step process. First, it deletes any loose
+objects that already exist in a pack-file; concurrent Git processes will
+examine the pack-file for the object data instead of the loose object.
+Second, it creates a new pack-file (starting with "loose-") containing
+a batch of loose objects. The batch size is limited to 50 thousand
+objects to prevent the job from taking too long on a repository with
+many loose objects.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/run-job.c b/builtin/run-job.c
index e59056b2918..cecf9058c51 100644
--- a/builtin/run-job.c
+++ b/builtin/run-job.c
@@ -7,7 +7,7 @@
 #include "run-command.h"
 
 static char const * const builtin_run_job_usage[] = {
-	N_("git run-job (commit-graph|fetch)"),
+	N_("git run-job (commit-graph|fetch|loose-objects)"),
 	NULL
 };
 
@@ -145,6 +145,99 @@ static int run_fetch_job(void)
 	return result;
 }
 
+static int prune_packed(void)
+{
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "prune-packed", NULL);
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
+static int pack_loose(void)
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
+	if (!for_each_loose_file_in_objdir(the_repository->objects->odb->path,
+					   loose_object_exists,
+					   NULL, NULL, NULL))
+		return 0;
+
+	pack_proc = xmalloc(sizeof(*pack_proc));
+
+	child_process_init(pack_proc);
+
+	strbuf_addstr(&prefix, the_repository->objects->odb->path);
+	strbuf_addstr(&prefix, "/pack/loose");
+
+	argv_array_pushl(&pack_proc->args, "git", "pack-objects",
+			 "--quiet", prefix.buf, NULL);
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
+	for_each_loose_file_in_objdir(the_repository->objects->odb->path,
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
+static int run_loose_objects_job(void)
+{
+	return prune_packed() || pack_loose();
+}
+
 int cmd_run_job(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_run_job_options[] = {
@@ -166,6 +259,8 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
 			return run_commit_graph_job();
 		if (!strcmp(argv[0], "fetch"))
 			return run_fetch_job();
+		if (!strcmp(argv[0], "loose-objects"))
+			return run_loose_objects_job();
 	}
 
 	usage_with_options(builtin_run_job_usage,
diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
index d3faeba135b..41da083257b 100755
--- a/t/t7900-run-job.sh
+++ b/t/t7900-run-job.sh
@@ -66,4 +66,31 @@ test_expect_success 'fetch job' '
 	test_line_count = 2 $chain
 '
 
+test_expect_success 'loose-objects job' '
+	ls client/.git/objects >obj-dir-before &&
+	test_file_not_empty obj-dir-before &&
+	ls client/.git/objects/pack/*.pack >packs-before &&
+	test_line_count = 1 packs-before &&
+
+	# The first run creates a pack-file
+	# but does not delete loose objects.
+	git -C client run-job loose-objects &&
+	ls client/.git/objects >obj-dir-between &&
+	test_cmp obj-dir-before obj-dir-between &&
+	ls client/.git/objects/pack/*.pack >packs-between &&
+	test_line_count = 2 packs-between &&
+
+	# The second run deletes loose objects
+	# but does not create a pack-file.
+	git -C client run-job loose-objects &&
+	ls client/.git/objects >obj-dir-after &&
+	cat >expect <<-\EOF &&
+	info
+	pack
+	EOF
+	test_cmp expect obj-dir-after &&
+	ls client/.git/objects/pack/*.pack >packs-after &&
+	test_cmp packs-between packs-after
+'
+
 test_done
-- 
gitgitgadget

