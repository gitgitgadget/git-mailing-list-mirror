Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F9C433EA
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A165C206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY9GFODY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgGWR4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWR4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA77C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so1827471wma.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1tO9a2Ab/ZByi0YCxKb/Dl0qn2scgmm5o+zRFxn6ONc=;
        b=DY9GFODYZz/9XwX1PHvDZTAYUGQ3AuIXgo989viSgsY5lO9AtJEPr0i9dSz380QeEK
         /50jwKxrkOY6nt86IwY2xAKZw7XFjnB7KDMpylKD298IbW9qwZBazmdKThCmvprhYEHn
         DmomZzieJ2KNC5ZvtVtq7KL1FhgGH/u+tcfSggAg6hqko7oIHzl1nDkWNOmU7pTT3rGZ
         RxFJpylJnI8epjxr3iKplqKXcu6n4otG7sjZF9fmeonhx9fgFjFUnwtZjclx54d/lGHR
         Royep4/OTzh5t+s6fmVfTgpU4CXuhSFeKqqWqUX7225jNtWDN/Yeh8ShMrxyGNf6qkCE
         sWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1tO9a2Ab/ZByi0YCxKb/Dl0qn2scgmm5o+zRFxn6ONc=;
        b=QefurJnWKet3tANggFT/P/TRDNTw0HVSxXxkFGzrDoypl8rwCd0SoJcUeqExklEvlM
         9K6mh3RFKCbRnEhfidpUNvB7U9wr0vAHvd3Llo82znyAxCndafiU7Ucyw3VixZ1aMhQ9
         3xcGfT98475Woa/BlaCrvkZwIwfOCHB93xXQjUNISelC0p/VszjyickGkTwyZQOpQd0H
         1tU3Pr08lLVrLm6+HCMuAUWItW5MK1aPBxASbjJHIlH2Bd6yc4+FSv+qcIA/BxkwDeVh
         CzDVLgSf4O/pYeI0DnxU/RlZSisPBQfi+MnzwoKKN6RMb733bZNs8/Z/Kfg2+ZoV01CV
         YRmw==
X-Gm-Message-State: AOAM531Mge3sIBkpNuOkC9VPliwz2+8v9QYcA5aGBnxbj37KQylxgCKD
        QsSpvvUu/dG+AB1I5W4JbUlNLZd7
X-Google-Smtp-Source: ABdhPJxmbh6J2dYMu2B0Z0d/6zfhb7BLFVwU5ab++OxYaY7Hrme50qIpkusI1rMv5l1C1jdpHWjB/g==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr5380923wmj.112.1595527003867;
        Thu, 23 Jul 2020 10:56:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g145sm6648245wmg.23.2020.07.23.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:43 -0700 (PDT)
Message-Id: <1d37e55cb714ea579744d28d1aeb332a63815342.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:24 +0000
Subject: [PATCH v2 02/18] maintenance: add --quiet option
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
index 8d73c77f3a..c8cde28436 100644
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
 		argv_array_pushl(&cmd, "--auto", NULL);
+	if (opts.quiet)
+		argv_array_pushl(&cmd, "--quiet", NULL);
 
 	close_object_store(the_repository->objects);
 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
@@ -736,6 +739,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 	static struct option builtin_maintenance_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "quiet", &opts.quiet,
+			 N_("do not report progress or other information over stderr")),
 		OPT_END()
 	};
 
@@ -745,6 +750,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_maintenance_usage,
 				   builtin_maintenance_options);
 
+	opts.quiet = !isatty(2);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
 			     builtin_maintenance_usage,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d00641c4dd..e4e4036e50 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -12,11 +12,13 @@ test_expect_success 'help text' '
 	test_i18ngrep "usage: git maintenance run" err
 '
 
-test_expect_success 'gc [--auto]' '
-	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
+test_expect_success 'gc [--auto|--quiet]' '
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

