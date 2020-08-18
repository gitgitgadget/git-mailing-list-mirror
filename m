Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23086C433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5720786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7JCF3BN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHROX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgHROXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB888C061343
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so18432903wrs.11
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/FClNfAsjRYer0xPyUbGOAjl73XOyq8VX1msCNRm+Y=;
        b=P7JCF3BNkGIWrQHqS9r9ne5wYYKGwZD3O1jkmFTTn43+VUf8YRSmsH77vJR0XXs0Ia
         Ldk1BzRLFOwThFvJ8HkIeypaAVHNYGN3zey6TWlyW24WFbZyVNKCUTjwF5tQ8COSahn+
         VohgrlvrUMbZHH7MeXu+qcEqjTA2ms7/eYrZndLFYxYnsGhGOHvpQl8D9evx/SI2tfuG
         pHV54ZSsB/gi4gt4OLrypHom5TenAT0MMDZTRHXRUy4X5R9zLONaR9uoD/YHDc5q0mtt
         cXi6YvBz7Cidvl9EKIpHzGuJ2Z6oQZ036Zk5HF6tKSuWJ96P7jobt56xNp2WM2omtEJk
         z07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L/FClNfAsjRYer0xPyUbGOAjl73XOyq8VX1msCNRm+Y=;
        b=rnA2oQqESntOMjRMKlNI6TcAjaNpkUd7CZ7rxbiLGRL6sGMH4JImTtoBoi9ay6Uowy
         xldy5R3aTBxIYVfUfBXn1xC9vAHgTf2fdP5O7rcTWSoZsIV1+6gvEAVw1w2IRE7xhjqu
         LIx5qb0c4u3fZGWWTNNFKkjhCaA2KB0YQYI6cyRIajENgXwinnerU2sxMmgSx2f4rGkm
         +V1/NhF9jLFeH6sXPHybE6+yLDGq2dWQJ0g4V8FGM08uy0xHjhuxlR9nYq80nvA2pDpQ
         z8T6AojvW5wpQJ8lsLKnXG3BmZta7KnAACnyKbTplmqkvAkXjehZd8izzxVTWqwNID0M
         vD6g==
X-Gm-Message-State: AOAM531LrAePvXShWEVqdHpT4qmV9kxpgiVvKekhOQ79xumXrHUC35WV
        uMEniE7argF0CGfN1MGgGdeCDWY0GDA=
X-Google-Smtp-Source: ABdhPJyxh95jXZNkgdx4eDSCKUhblcOwkVez8zhPwet63+i6vZEyWWnHzDJEMRVvz70VSqgf7zSJGQ==
X-Received: by 2002:adf:c108:: with SMTP id r8mr21153577wre.350.1597760592492;
        Tue, 18 Aug 2020 07:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g188sm174548wma.5.2020.08.18.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:12 -0700 (PDT)
Message-Id: <adae48d235aecf3c2f6e709a2855b9066a9a9e38.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:22:59 +0000
Subject: [PATCH v2 02/11] maintenance: add --quiet option
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
 builtin/gc.c                      |  9 +++++++++
 t/t7900-maintenance.sh            | 15 ++++++++++-----
 3 files changed, 22 insertions(+), 5 deletions(-)

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
index ce91c754ee..b75ddb780b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -707,6 +707,7 @@ static const char * const builtin_maintenance_usage[] = {
 
 struct maintenance_opts {
 	int auto_flag;
+	int quiet;
 };
 
 static int maintenance_task_gc(struct maintenance_opts *opts)
@@ -718,6 +719,10 @@ static int maintenance_task_gc(struct maintenance_opts *opts)
 
 	if (opts->auto_flag)
 		strvec_push(&child.args, "--auto");
+	if (opts->quiet)
+		strvec_push(&child.args, "--quiet");
+	else
+		strvec_push(&child.args, "--no-quiet");
 
 	close_object_store(the_repository->objects);
 	return run_command(&child);
@@ -734,6 +739,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "quiet", &opts.quiet,
+			 N_("do not report progress or other information over stderr")),
 		OPT_END()
 	};
 
@@ -743,6 +750,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_maintenance_usage,
 				   builtin_maintenance_options);
 
+	opts.quiet = !isatty(2);
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
 			     builtin_maintenance_usage,
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

