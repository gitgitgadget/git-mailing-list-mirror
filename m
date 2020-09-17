Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC9FC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F20622208
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoppPAKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIQSTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CCC061797
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so3077796wrn.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YU0lapaxqCNKFKJgXd3OQC/nTpExucs8BFW6iQQz3ng=;
        b=DoppPAKrgE8yumfwHWKulUckI73/f8i5/PkTpSRnXQGtRGAOQndQ7LFQs0jWy0a7UV
         3SlWLwEZDqGp8rjB8r/Avxcta1MKgQZPUWKxHSyY9jucYV2K6bjE1c3ZbVkByRf20Nzv
         kfQwsKPSmI5KmP8iaAKvw7myq1Vh3/2g6E8X3qH6dsvNjz8l5ljjdJzStbyQGwad3LE7
         yNrw7F7RWpGAJe2F4oNJxwOUL8cIgs/K21OByBUc/jUOu8keHXx0d2qjFefbLFnp3RUF
         W6OIPAJ2mgTf0wgc+LH6QU0vT4hWtYR/2IDi5sAvRxcbPp1SSUHnK9YNPBkwPDDXG2ZZ
         yQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YU0lapaxqCNKFKJgXd3OQC/nTpExucs8BFW6iQQz3ng=;
        b=rftXcThKzegCQezHy1BGaL7OK8WFZjQyoCMc4zTJ2KZePtT1gokY5owNxQnCToPV5l
         TbRdnGjEaUtNZQwRQkqM1aigZX343tqg4Yn57y2uEj9GrzuZ+HHB9EoLnBUVWH/rrkct
         xtPIiGY+41MJtJPeLcshacaI6YvxGa/hcHjcKEUBNlH7yy8vEEIvB9fal/J4PqyBdhqf
         oCMnVGbL96FZT2ofK9hbLtUEGmUbsGqonXF7lf3FgsP4UMHN9HMNaCzaP+mrnzzkkkMC
         oSbb+RkvdQjgS7yB32I+cWeZ9rZjJiS8UjEXoR5tw3zV1TNwq3XPGMTVcbsVMwAaTeLg
         aq2Q==
X-Gm-Message-State: AOAM533A5V9PisymfriQDqpQul8yq4mSxHvkgolZY0eIUat0haCi96ZU
        yNVcwpNQQ3GmudnZoJiRGPPw6yte374=
X-Google-Smtp-Source: ABdhPJxhztcyjUOZnrp/N/Egd61eB6dFHG5DU40h85xBQGitv4qPMG/KG1KkJbGWEWAOADzOu6wRrA==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr28140258wrv.195.1600366315938;
        Thu, 17 Sep 2020 11:11:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm513177wrx.22.2020.09.17.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:55 -0700 (PDT)
Message-Id: <52eb937f49a79dfd985e9c6d237ec022b6290094.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:43 +0000
Subject: [PATCH v5 02/11] maintenance: add --quiet option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index ec064e8686..bacce0c747 100644
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
index c2f0b1d0c0..5637053bf6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -13,11 +13,16 @@ test_expect_success 'help text' '
 	test_i18ngrep "usage: git maintenance" err
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

