Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8166C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7971E20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brt7Vx6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgDCUsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgDCUs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so10138093wrl.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uaA66BdJ4rQYa191bEp+z8INgPrbZtjrQ6daT6uI/iA=;
        b=brt7Vx6EgDk1DRdI9dGWSNgsrqOl4Z+nSgsj88o/k2agVrFwwJStDeXIGSDmUlMNyD
         epmzuZEK9h8fx2QqS5sLIpFtXIvtlqf3E+NxXosfER7IIxkvUh7kYmTNklYnXqz0GkSw
         5u3WJC7HpHgbIb9SiD/P9q5UxEF22cs9r2hT66I47Hhi+herP+EBEzcFe9pwbtW8ghAC
         mj8c0Bg5nZ0JT3V7/R4XqJJAaB0QXtXJMrEj+/pmTGVcyPYyb4COk7iPSHkkaP3n9dxc
         r5vvGB8eh1FuOVsXDGa3fMf5mNXOl20pgl/U8sg+Uj+2O3UFlvRhA7rvrGk5j34mGtxm
         m5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uaA66BdJ4rQYa191bEp+z8INgPrbZtjrQ6daT6uI/iA=;
        b=NqzyQDwqh/FjJdhz3W15zgxPAYXvO7wjoNyIrzGKcN8+CdtZn4tQMWICgra20J0tEs
         gXGMUd9XH7PAJk+DZCFoKCPG7SxWVTJFtl4DtgOMWcTx3pDXePvofEm252tPyGR4S8SL
         CDp0WW855hBytZhydP6dae1L3s3Vmo58PUNqP27xZQxy6S8DKbJzaLHD23GxuFc9kWjl
         M71AE0zvYaDn+X4yOLzM/e4aCuEZm65wMpg/Vv5fylzSIXALEhRJP13VqlnyU1Cg5boO
         heeCM5NM3X8f4Kvq5jaO095u6RaKkNF8RReTOq5guYhIRY1og0+QG51MFrPmc6Tfhbl7
         U2lg==
X-Gm-Message-State: AGi0PuYH6S/iNjRvuCSbv0bmcdisyHZ8q/HrD4Dg63lEMSkUc5vh++aL
        3HygR/M1qn+wxXEBGk7aGpOw02Fa
X-Google-Smtp-Source: APiQypIjqu6/cyX1KiHWTpUejBgYcrbNVCLO62aupHGo2j3FqQi+o0CCIeXfBqLKt6w2GgNiq68FoQ==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr9814486wrq.412.1585946907249;
        Fri, 03 Apr 2020 13:48:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm12636814wmc.6.2020.04.03.13.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:26 -0700 (PDT)
Message-Id: <84cab34e8f26cca7eedd07e58b99bd2152d90a7d.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:14 +0000
Subject: [PATCH 15/15] runjob: customize the loose-objects batch size
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

Allow a user to override the default number of loose objects to
place into a new pack-file as part of the loose-objects job. This
can be done via the job.loose-objects.batchSize config option or
the --batch-size=<count> option in the 'git run-job' command. The
config value is checked once per run of 'git run-job loose-objects'
so an instance started by 'git job-runner' will use new values
automatically without restarting the 'git job-runner' process.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/job.txt  |  6 ++++++
 Documentation/git-run-job.txt |  8 +++++---
 builtin/run-job.c             | 31 ++++++++++++++++++++++++++-----
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
index 6c22a40dd36..baa5b927e14 100644
--- a/Documentation/config/job.txt
+++ b/Documentation/config/job.txt
@@ -16,6 +16,12 @@ job.<job-name>.lastRun::
 	can manually update this to a later time to delay a specific
 	job on this repository.
 
+job.loose-objects.batchSize::
+	This string value `<count>` limits the number of loose-objects
+	collected into a single pack-file during the `loose-objects`
+	job. Default batch size is fifty thousand. See linkgit:git-run-job[1]
+	for more details.
+
 job.pack-files.batchSize::
 	This string value `<size>` will be passed to the
 	`git multi-pack-index repack --batch-size=<size>` command as
diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
index c6d5674d699..73210791533 100644
--- a/Documentation/git-run-job.txt
+++ b/Documentation/git-run-job.txt
@@ -67,9 +67,11 @@ commands, it follows a two-step process. First, it deletes any loose
 objects that already exist in a pack-file; concurrent Git processes will
 examine the pack-file for the object data instead of the loose object.
 Second, it creates a new pack-file (starting with "loose-") containing
-a batch of loose objects. The batch size is limited to 50 thousand
-objects to prevent the job from taking too long on a repository with
-many loose objects.
+a batch of loose objects.
++
+By default, the batch size is limited to 50 thousand objects to prevent
+the job from taking too long on a repository with many loose objects.
+This can be overridden with the `--batch-size=<count>` option.
 
 'pack-files'::
 
diff --git a/builtin/run-job.c b/builtin/run-job.c
index 76765535e09..b7c5a74cdbb 100644
--- a/builtin/run-job.c
+++ b/builtin/run-job.c
@@ -13,6 +13,11 @@ static char const * const builtin_run_job_usage[] = {
 	NULL
 };
 
+static char const * const builtin_run_job_loose_objects_usage[] = {
+	N_("git run-job loose-objects [--batch-size=<count>]"),
+	NULL
+};
+
 static char const * const builtin_run_job_pack_file_usage[] = {
 	N_("git run-job pack-files [--batch-size=<size>]"),
 	NULL
@@ -183,7 +188,7 @@ static int write_loose_object_to_stdin(const struct object_id *oid,
 	return ++(d->count) > d->batch_size;
 }
 
-static int pack_loose(void)
+static int pack_loose(int batch_size)
 {
 	int result = 0;
 	struct write_loose_object_data data;
@@ -219,7 +224,7 @@ static int pack_loose(void)
 
 	data.in = xfdopen(pack_proc->in, "w");
 	data.count = 0;
-	data.batch_size = 50000;
+	data.batch_size = batch_size;
 
 	for_each_loose_file_in_objdir(the_repository->objects->odb->path,
 				      write_loose_object_to_stdin,
@@ -240,9 +245,25 @@ static int pack_loose(void)
 	return result;
 }
 
-static int run_loose_objects_job(void)
+static int run_loose_objects_job(int argc, const char **argv)
 {
-	return prune_packed() || pack_loose();
+	static int batch_size;
+	static struct option builtin_run_job_loose_objects_options[] = {
+		OPT_INTEGER(0, "batch-size", &batch_size,
+			    N_("specify the maximum number of loose objects to store in a pack-file")),
+		OPT_END(),
+	};
+
+	if (repo_config_get_int(the_repository,
+				"job.loose-objects.batchsize",
+				&batch_size))
+		batch_size = 50000;
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_run_job_loose_objects_options,
+			     builtin_run_job_loose_objects_usage, 0);
+
+	return prune_packed() || pack_loose(batch_size);
 }
 
 static int multi_pack_index_write(void)
@@ -427,7 +448,7 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "fetch"))
 			return run_fetch_job();
 		if (!strcmp(argv[0], "loose-objects"))
-			return run_loose_objects_job();
+			return run_loose_objects_job(argc, argv);
 		if (!strcmp(argv[0], "pack-files"))
 			return run_pack_files_job(argc, argv);
 	}
-- 
gitgitgadget
