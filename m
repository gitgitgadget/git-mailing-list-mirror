Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7878AC433E3
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A6220829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0Xgcqyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgG3WYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgG3WYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43958C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so16313977wrm.6
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BxgGmFppPriwJ2GMFVHvVQxCmv9jc2jpc3eg6BVfn/0=;
        b=R0Xgcqybf5TIQx1ReuUy1RPq7qMw7QmAZ8WxAxKP6ICsnUzCRMqScUYf0hBhDHNK/j
         Qb7p7u8Ndb2nEXVap1+/qvVzNbzDD2RMMBLcBU7RkTNNRkV9410OW5RR01ozu1LHP/mU
         Gz+o7gsPu+r2B9B1L04mbQt0FtRgLoodr6rHt6TAICgkGsM3yHLRBNwMoJ+qc/cBNzGY
         6riBnEFfHOu6naDULJ5ITrqGLIaT58Cnlibt/GZC7yrEF/qrejiYqEVTVth5wzlR0up7
         31skruM8LOrK3dRyq62RtxSCg+QeYlU2BMspNHH+hSMVm3PhiidEuTBnIJ9eHLEH6lUj
         1kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BxgGmFppPriwJ2GMFVHvVQxCmv9jc2jpc3eg6BVfn/0=;
        b=p/i7ytu8Cr4RhVuGoVzm0BuG4XqfYelPVUN0rb3ShgQze9sliRNrx9Gez3HRmKt3Ez
         x7gBx9Iq23BZRYrE9YwHNXT/vuoGGzRjM9FbhqFyN+mtXj33lisfEq8pucRTvBudLpI/
         pGCIOtKkb9TCJgKsuD95FBUIqhxx7rfj7NExYnKKVil/O86XVNPCJrj37giAqAGtIhXk
         hkKOHgQxmKv5tRWZ9pE32c7YEqSa75fqZTtMNYSJ/vavQPKBrouOYoQeKTMDN75cTvnn
         ZTd50ROpY24m13cVbxefUpu6V3flTi+lQMjdc9zKmUKvGrwIVHTWWzMH6eOMr2pc9YX7
         /rQw==
X-Gm-Message-State: AOAM531jw2s9FCoG8Z1caEWdS7r8FNnfCuelo2QSzRZETBhaC74pgoRO
        ABMRU9edY8BmRP+4xAfR2SNAOoVP
X-Google-Smtp-Source: ABdhPJzs1Ptyg4VtTWY7/YicqIp/94BxIBQ2q+fTn5KIYY2LIdzyTAnzGpUlSsFHCrHu5gv+urJMew==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr643730wrq.327.1596147879974;
        Thu, 30 Jul 2020 15:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm10422848wmb.11.2020.07.30.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:38 -0700 (PDT)
Message-Id: <6e533e43d71580d3cd81f9b0ae2c5884a7d3ac2a.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:08 +0000
Subject: [PATCH v3 02/20] maintenance: add --quiet option
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

Maintenance activities are commonly used as steps in larger scripts.
Providing a '--quiet' option allows those scripts to be less noisy when
run on a terminal window. Turn this mode on by default when stderr is
not a terminal.

Pipe the option to the 'git gc' child process.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 3 +++
 builtin/gc.c                      | 7 +++++++
 t/t7900-maintenance.sh            | 8 +++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 34cd2b4417..089fa4cedc 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -52,6 +52,9 @@ OPTIONS
 	in the `gc.auto` config setting, or when the number of pack-files
 	exceeds the `gc.autoPackLimit` config setting.
 
+--quiet::
+	Do not report progress or other information over `stderr`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/gc.c b/builtin/gc.c
index be9557452e..3c277f9f9c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -707,6 +707,7 @@ static const char * const builtin_maintenance_usage[] = {
 
 static struct maintenance_opts {
 	int auto_flag;
+	int quiet;
 } opts;
 
 static int maintenance_task_gc(void)
@@ -718,6 +719,8 @@ static int maintenance_task_gc(void)
 
 	if (opts.auto_flag)
 		strvec_push(&child.args, "--auto");
+	if (opts.quiet)
+		strvec_push(&child.args, "--quiet");
 
 	close_object_store(the_repository->objects);
 	return run_command(&child);
@@ -733,6 +736,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 	static struct option builtin_maintenance_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "quiet", &opts.quiet,
+			 N_("do not report progress or other information over stderr")),
 		OPT_END()
 	};
 
@@ -742,6 +747,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_maintenance_usage,
 				   builtin_maintenance_options);
 
+	opts.quiet = !isatty(2);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
 			     builtin_maintenance_usage,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0e864eaaed..f08eee0977 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -9,11 +9,13 @@ test_expect_success 'help text' '
 	test_i18ngrep "usage: git maintenance run" err
 '
 
-test_expect_success 'run [--auto]' '
-	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
+test_expect_success 'run [--auto|--quiet]' '
+	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run --no-quiet &&
 	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
+	GIT_TRACE2_EVENT="$(pwd)/run-quiet.txt" git maintenance run --quiet &&
 	grep ",\"gc\"]" run-no-auto.txt  &&
-	grep ",\"gc\",\"--auto\"]" run-auto.txt
+	grep ",\"gc\",\"--auto\"" run-auto.txt &&
+	grep ",\"gc\",\"--quiet\"" run-quiet.txt
 '
 
 test_done
-- 
gitgitgadget

