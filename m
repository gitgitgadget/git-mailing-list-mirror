Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20778C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A63B23119
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVUV9IVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgHFQyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgHFQun (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:50:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB0FC0F26CE
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so33935959wrc.7
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RwtwfO3iJG5DwWl3yJq5hteOnX7vVssVEJSokU49/uk=;
        b=jVUV9IVk8jh1pAxCp1NX6X2P3ewg/qVCpRpll8+9tE1VHmukQG0dOtzoKBNtmf7Qf3
         j4V6WZpUD20fwqKcYudmTYY7mahSUqceDjyfsBprLmlFQNO6k84UFhiuf84TeaN879vB
         PxItYZwXNK2+T9U1zKwrIKE4HotU4FfPIVFg54rmeJqQuJEn5jTLRIUVIz2HBrFsA7bi
         D29b8BWPFS59C/zjTnYs1XY1XX0DW1VWoa6qE7x6MmtZ8ft4jC2eQ44aEJDN5MN8fVWp
         BNFVcC9/PPoNlqYQ3Y51PCCJkZstEodlCa5wIskd4DXFrwAgqyJUoK9guh8U4PU6G2o2
         +PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RwtwfO3iJG5DwWl3yJq5hteOnX7vVssVEJSokU49/uk=;
        b=QN4Oe005Ns8MFvA2r4XFMa3ZO0Fgn6+IKGUA8sgWcBBpvf81JVSxkMmA8rDcYfwtFl
         pOI/XNNshvUISkpYRM+7HCUmiPOaIcy4JXpE1To2/TBE5FfE74NVNODWcw34KY+x4KAk
         qT3SDz8R1m85TjDI0yUfJbO0JeKGue1Z5ZKpn4+cnwVmAX2GWDNC170ZG2b/F5mk5jBl
         d5Ovm6YbH3K6MxgT66S1nMkgkO4pEWP3UudEExTggY4vfesdzhp7wASEFSF/MOh8yXxW
         T9xwYOX1pckBS2ZBAvTrEBtvPNzdgiDMf2NELNi8AMNFS5jHy0ENx1ZVNDQou6V6054Y
         AW6A==
X-Gm-Message-State: AOAM532+aUhB9XnjecpJgzpg/yEYXoSeVam6H5iT8KoZLiPNtJzRa+b8
        9r0CBwCKwGvuTxIwON8hTFATrkkc
X-Google-Smtp-Source: ABdhPJyv9vIShaz6cA3v7wRSQaC4jdMLbDfvNvCIIqsnn31OgJnqBE8GmhBF0mHZKl1gG96EXJOyMg==
X-Received: by 2002:adf:812a:: with SMTP id 39mr7728430wrm.137.1596728924986;
        Thu, 06 Aug 2020 08:48:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r22sm7142436wmh.45.2020.08.06.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:44 -0700 (PDT)
Message-Id: <d5faef26af8896dc7a82c2b809a3af2724da8afd.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:32 +0000
Subject: [PATCH 02/11] maintenance: add --quiet option
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
index e4f0ce1c86..a060ba8424 100644
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
 	static struct option builtin_maintenance_options[] = {
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
index c4b9b4a6fe..7b63b4ec0c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -9,11 +9,16 @@ test_expect_success 'help text' '
 	test_i18ngrep "usage: git maintenance run" err
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

