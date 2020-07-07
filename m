Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B41C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D874020771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9Umr+FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGGOVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgGGOVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42038C08C5E1
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so43457326wme.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XmWFtRdGNxbHEFS2zoX/ac+W1i5fsw68dGpbtIZ2T9Q=;
        b=t9Umr+FKbWF1qzL+mb3RjJAV9Mhgv6lcbUoaBaEAlg+XsbMFn+7awZpRX+0f98VHkt
         kbFqubycebBVj2v0UgwssD5+cmlvASOaOn2RyhqLF58u6Sw16vxXkj+QExs3XK9hEaba
         9ukIsCpSs4RL/gyrmo2Ujz0wKN8JYE45BpOo19o/4a/sXtwiyuR21Cpz9GM4V0ngncOU
         AjI+ZUmypwOk6aih0vuL6RnzpEUiHJCtVrm4k3asNyRkegw3s2uCBcuyVTFHzb0w7tY/
         GqpDs4Dx6W/modgrhm/kGv1DmApMHGo95jOJyImE5Apd5gt1R5Ty8Zl025QLtsgxewQg
         QTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XmWFtRdGNxbHEFS2zoX/ac+W1i5fsw68dGpbtIZ2T9Q=;
        b=sPlqXBKLNHvVjcrYX7RZcClNriGbKrzjpZRNK2SSB2u/aInI9nORwAVzni/EUX3oys
         xJH3UFOkM7mBgx70mSyFNxQZ6du0yHiJzPt5HPbiF+1iMyaHiZ+CRKr1vWGeOnmpenmE
         4LdTzsR/vpO4dyXUY+I2dZxarIrCtQB22/zeD9wESTesm+JoCdmxW46q0GjS01md4KG7
         TTRFtEoiKdDldy3oPq66masYkT7042fnnccHs7cI65FdfJLV7XDO2UB52cdIhXtA0eJr
         z7SsA+8wZ44BXdBd7exYQmOzrOm87lQtt1+UV9dXYdumVY6VemxrDEsFb7Ze/UMDmjxV
         8bDw==
X-Gm-Message-State: AOAM531YcT/XvT4bIwUiYvyCyeksbivgU/EBJfqo9tLEMoWNke9FzMeC
        MfvljVpFaMmIYB2oMpTuNbNJNoW0
X-Google-Smtp-Source: ABdhPJy8Wxw+p6CbvXeycZEIbU1p1rjFEFlUd+Mn6OxThP0bgD/sE17bDj50Szdlb6mHvb6A0tjS0Q==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr4706741wmr.133.1594131701779;
        Tue, 07 Jul 2020 07:21:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm1138811wrt.73.2020.07.07.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:41 -0700 (PDT)
Message-Id: <018a9331e204fd6b1b92f5b53f3f373fa9e23bc2.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:20 +0000
Subject: [PATCH 06/21] maintenance: add --quiet option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
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
index 07cc5f46ae..3881a99e9d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -712,6 +712,7 @@ static const char * const builtin_maintenance_usage[] = {
 
 struct maintenance_opts {
 	int auto_flag;
+	int quiet;
 } opts;
 
 static int maintenance_task_gc(struct repository *r)
@@ -723,6 +724,8 @@ static int maintenance_task_gc(struct repository *r)
 
 	if (opts.auto_flag)
 		argv_array_pushl(&cmd, "--auto", NULL);
+	if (opts.quiet)
+		argv_array_pushl(&cmd, "--quiet", NULL);
 
 	close_object_store(r->objects);
 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
@@ -743,6 +746,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 	static struct option builtin_maintenance_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "quiet", &opts.quiet,
+			 N_("do not report progress or other information over stderr")),
 		OPT_END()
 	};
 
@@ -752,6 +757,8 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
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

