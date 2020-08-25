Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D14C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4EE2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBi6UTBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHYSeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHYSdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B767FC061757
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x9so3102917wmi.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TNkZA0YzlqgpbaFMJJADNK04OIR3HUTxPD/4oyKldqI=;
        b=CBi6UTBFA+OOn+WezSOLvG6/V8IUtOxlPKH8n+NwhUtL9Q2XRlT51r+mRwrNFwWnQD
         lplNJ7JeFpDddVABZqe7OpPdlZ0Wl+Stoxjz+SIXJGaAnawiJ9TJNEMD8+R4+EbJzbeN
         9fuOGxeKvOIQRPMYDXm+nsLIfU29UYEzpAtcedotQZauwnjmK/B77Ds+ZQyLdvnc6Pbz
         cdoKO3kznIDC6C7HZRWFEbmi92/72/vLEYYRK/ka8HgxzdEyFKYyD7Zez/C0YIHiDuhp
         iNMgOW+LYVRpwiEiD/IY4XnGGX7gnUl3gxTRbBhpVQyyVk+n8YPgjSXoQ2/ZzUo0kijH
         uWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TNkZA0YzlqgpbaFMJJADNK04OIR3HUTxPD/4oyKldqI=;
        b=R2CQd9TGRsL1XVbeHgkcoaKudbQkNSSSd42ZVRv47Btl9T6aUDH0049tcns+pJ9Llw
         twZT3SJ6x1wwAgKM8M7Xr2AfPGbSJev5L/RBbwX99H+6YDQMNdfqSjzfURo/DdsQO9Nl
         PRFtb1ZYeFTS9diQe3KjEv/rY8QzNqocL3EBPmT3iK+Q9+Xi4TT9qxw6zxbmE860Dj5d
         N0enDtoaA4ZWvazxTgUTczjGV03TBHwTXCdUpKYaHQ9H1vFeY4SBCCp70no/0hE504CV
         Vvh+GUUm8adH3/YLER2trSdT2r+8cdrCMXN3ja5qfhqpu9zD6blA7/CjBlfxsG9sdj93
         Amtw==
X-Gm-Message-State: AOAM532XQTUH9luwyk1HA5Do4oVNuuoTRclXusITIrjLPnOsDIZbUMds
        OrWeEIiIFf1bKdY1ch5A+zyAiXx3mx0=
X-Google-Smtp-Source: ABdhPJyxWt1+KcQQSEWy/RUPycsydFKdxxCfWrjiXSFunKEdas8RgyieG19sJ3K8eCtbrXKDQA/zNA==
X-Received: by 2002:a05:600c:22d6:: with SMTP id 22mr3178790wmg.120.1598380430382;
        Tue, 25 Aug 2020 11:33:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm7615589wmj.14.2020.08.25.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:49 -0700 (PDT)
Message-Id: <5386d8a6283d814c0d0d2b7a180409f064cea709.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:37 +0000
Subject: [PATCH v3 02/11] maintenance: add --quiet option
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

Maintenance activities are commonly used as steps in larger scripts.
Providing a '--quiet' option allows those scripts to be less noisy when
run on a terminal window. Turn this mode on by default when stderr is
not a terminal.

Pipe the option to the 'git gc' child process.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  3 +++
 builtin/gc.c                      | 11 ++++++++++-
 t/t7900-maintenance.sh            | 15 ++++++++++-----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index ff47fb3641..04fa0fe329 100644
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
index 7f2771e786..da11f1edcd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -701,12 +701,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 }
 
 static const char * const builtin_maintenance_run_usage[] = {
-	N_("git maintenance run [--auto]"),
+	N_("git maintenance run [--auto] [--[no-]quiet]"),
 	NULL
 };
 
 struct maintenance_run_opts {
 	int auto_flag;
+	int quiet;
 };
 
 static int maintenance_task_gc(struct maintenance_run_opts *opts)
@@ -718,6 +719,10 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts)
 
 	if (opts->auto_flag)
 		strvec_push(&child.args, "--auto");
+	if (opts->quiet)
+		strvec_push(&child.args, "--quiet");
+	else
+		strvec_push(&child.args, "--no-quiet");
 
 	close_object_store(the_repository->objects);
 	return run_command(&child);
@@ -729,10 +734,14 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "quiet", &opts.quiet,
+			 N_("do not report progress or other information over stderr")),
 		OPT_END()
 	};
 	memset(&opts, 0, sizeof(opts));
 
+	opts.quiet = !isatty(2);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_run_options,
 			     builtin_maintenance_run_usage,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 14aa691f19..47d512464c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -11,11 +11,16 @@ test_expect_success 'help text' '
 	test_i18ngrep "invalid subcommand: barf" err
 '
 
-test_expect_success 'run [--auto]' '
-	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
-	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
-	test_subcommand git gc <run-no-auto.txt &&
-	test_subcommand git gc --auto <run-auto.txt
+test_expect_success 'run [--auto|--quiet]' '
+	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" \
+		git maintenance run 2>/dev/null &&
+	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" \
+		git maintenance run --auto 2>/dev/null &&
+	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
+		git maintenance run --no-quiet 2>/dev/null &&
+	test_subcommand git gc --quiet <run-no-auto.txt &&
+	test_subcommand git gc --auto --quiet <run-auto.txt &&
+	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
 test_done
-- 
gitgitgadget

