Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A366BC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82875611C3
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhIIJs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhIIJsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:48:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E558C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:47:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso905544wmi.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lRLRAwzz8Uo3OJpONkw1O0Db0i4OOTboCPE1JdXn1zA=;
        b=B2/AyyVc6bJJPjAGwd7Ff3l0/mjptHb6dJLwCqjU6gfWDt6r+jHhCFxq4EFiVVAtUv
         r5txU7rHVTTbmKwDsm7NQ/ThSa96s0HiTqBZkFOt2okRna+18tQdl5h5ag4mnIZnBfGl
         QvtfX7zBMX92IOOdWEU/Ts22h2emU22n/CKGGQYpvN2L+M63mZKjsV+bE0FzUmIhGDUl
         UurF55r/FTAxno8+hQVvfff8Lo0g9qtyOMnom5beI8CoQ2qljmo5RKVyy4B++5QbWpiT
         Jt/n6XoijukY8zjg3ySyaHFEkEHR4mZqagj9PBwHoHam3tS2Dbaug2DAaPlRFHc02Of6
         K8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lRLRAwzz8Uo3OJpONkw1O0Db0i4OOTboCPE1JdXn1zA=;
        b=3Ixf6MEz4JJIsQ4dM7Zty0s5bD/nc/dd0+XHLxTyG38MSn1CjZ0I81o1EDWSXNmJv8
         JjGC1W+7R9tv3pMNRjkih7grtI/PtkbeYX16zYIsJ2jHyVfIUu918FbEWwGgDEJxlQ9p
         1wV1F3/fgyETmlFlhBdZYS0XBBlDsCKakcsPTUMJgJmuoLpIIsngnjd4zBVVG++OSAOW
         n/GQogAtQdhqv4PUZyGURZsbKHaBdgx2XtzUM+date7reK2F/miSVMpP2Ru8agFB/nx+
         smGUbLk2EtXvLg1ZA1A9gWdMK5S2ggQ+VJ8GL/TvlRgmX95c++r3r4ofkJodGHUUAmOp
         lQ5Q==
X-Gm-Message-State: AOAM531ox/+bUUmxzkSClU8MvNnvxWhL1mtYr8JxGYd3Rao2EmZhE4k6
        bz038V4bay2SmQhECtt0+DMhZmtF6mE=
X-Google-Smtp-Source: ABdhPJyCU3e9Jc3yV8dAhLmFdIQm+wKHKemjwLrOYOpoPYFsOuUSb+sELSYj8OKSDChVQ2JARmGiyA==
X-Received: by 2002:a05:600c:4e87:: with SMTP id f7mr2020814wmq.191.1631180833090;
        Thu, 09 Sep 2021 02:47:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15sm1065188wmi.4.2021.09.09.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:47:12 -0700 (PDT)
Message-Id: <dd708c84687b40a5482f4c6ac8a39e23fc59ac3b.1631180828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
References: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 09:47:08 +0000
Subject: [PATCH 4/4] Close object store closer to spawning child processes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In many cases where we spawned child processes that _may_ trigger a
repack, we explicitly closed the object store first (so that the
`repack` process can delete the `.pack` files, which would otherwise not
be possible on Windows since files cannot be deleted as long as they as
still in use).

Wherever possible, we now use the new `close_object_store` bit of the
`run_command()` API, to delay closing the object store even further.
This makes the code easier to maintain because it is now more obvious
that we only release those file handles because of those child
processes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c           | 18 ++++++------------
 builtin/pull.c         |  3 +--
 builtin/receive-pack.c |  3 +--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1ac..ddee9f8324f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -663,8 +663,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	gc_before_repack();
 
 	if (!repository_format_precious_objects) {
-		close_object_store(the_repository->objects);
-		if (run_command_v_opt(repack.v, RUN_GIT_CMD))
+		if (run_command_v_opt(repack.v,
+				      RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE))
 			die(FAILED_RUN, repack.v[0]);
 
 		if (prune_expire) {
@@ -848,7 +848,7 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = 1;
+	child.git_cmd = child.close_object_store = 1;
 	strvec_pushl(&child.args, "commit-graph", "write",
 		     "--split", "--reachable", NULL);
 
@@ -864,7 +864,6 @@ static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
 	if (!the_repository->settings.core_commit_graph)
 		return 0;
 
-	close_object_store(the_repository->objects);
 	if (run_write_commit_graph(opts)) {
 		error(_("failed to write commit-graph"));
 		return 1;
@@ -913,7 +912,7 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = 1;
+	child.git_cmd = child.close_object_store = 1;
 	strvec_push(&child.args, "gc");
 
 	if (opts->auto_flag)
@@ -923,7 +922,6 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts)
 	else
 		strvec_push(&child.args, "--no-quiet");
 
-	close_object_store(the_repository->objects);
 	return run_command(&child);
 }
 
@@ -1097,14 +1095,12 @@ static int multi_pack_index_expire(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = 1;
+	child.git_cmd = child.close_object_store = 1;
 	strvec_pushl(&child.args, "multi-pack-index", "expire", NULL);
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
 
-	close_object_store(the_repository->objects);
-
 	if (run_command(&child))
 		return error(_("'git multi-pack-index expire' failed"));
 
@@ -1155,7 +1151,7 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	child.git_cmd = 1;
+	child.git_cmd = child.close_object_store = 1;
 	strvec_pushl(&child.args, "multi-pack-index", "repack", NULL);
 
 	if (opts->quiet)
@@ -1164,8 +1160,6 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
 				  (uintmax_t)get_auto_pack_size());
 
-	close_object_store(the_repository->objects);
-
 	if (run_command(&child))
 		return error(_("'git multi-pack-index repack' failed"));
 
diff --git a/builtin/pull.c b/builtin/pull.c
index d9f0156d969..751372041c2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -578,7 +578,7 @@ static int run_fetch(const char *repo, const char **refspecs)
 		strvec_pushv(&args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
-	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
+	ret = run_command_v_opt(args.v, RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE);
 	strvec_clear(&args);
 	return ret;
 }
@@ -999,7 +999,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			oidclr(&rebase_fork_point);
 	}
 
-	close_object_store(the_repository->objects);
 	if (run_fetch(repo, refspecs))
 		return 1;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d1f97e1ca7..9d5e0e3d11c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2580,10 +2580,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			proc.no_stdin = 1;
 			proc.stdout_to_stderr = 1;
 			proc.err = use_sideband ? -1 : 0;
-			proc.git_cmd = 1;
+			proc.git_cmd = proc.close_object_store = 1;
 			proc.argv = argv_gc_auto;
 
-			close_object_store(the_repository->objects);
 			if (!start_command(&proc)) {
 				if (use_sideband)
 					copy_to_sideband(proc.err, -1, NULL);
-- 
gitgitgadget
