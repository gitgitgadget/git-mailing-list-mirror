Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B9C2D0A7
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6742074D
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZRQB1Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgIDPmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIDPmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 11:42:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50480C061245
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 08:42:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so7228461wrn.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=aZRQB1PxmQsA/FU+R2amwiO5sdpE+IL2S5xeT2QU+3McJep9Y09sQf97/QNn/Kod9O
         6h6gcSM3YFqEoiAQnrEC1226t+3H6NbFNNo7zJV2s1IiInyL1ueKc9/6C3dAHFv8c/+R
         9sTaTbRyIreiH7igcQVURostmDCKUXPKZMK/Bw6csMekaaqlGUBewlJq4Jb5d1hh4qgV
         hST0NczuLK2YflDyODm3dlrj6mk6KzItudDXKf5ka4cU1TuzIdfzUxL+Q2H4flO6JlsD
         M4DKNUAjKyAzekTQpoXNbpWl9KX7sbpEd69j9NDVHHxCe9S0922ihFIpQYRXbwKgXVoh
         V5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5lURrJo2phQFyTaCa9VzL15Edu5uwyU3aVspJO/+d8Q=;
        b=mpJuoOpuMdEsz8UPtLJf4eX/fZoXef+8iJCi8Vyxg9ZQtPFMsldEzQbc429/pwMOCC
         wf4Y2og9wXNCNrnckCYFsgVxDc/lbNf1nu8VTFDoC6ELQS1GxlpxQWW9a2QYQf1vaKYo
         FL89jrySqml9PSUopmWr9EQY7Pzi5O+dm0FqrTpsTckhLZuZyvv3Dj4CbXUtBaAFJ43w
         8T50+Kt9k4JshLBgFmRQi2i0w1sVuzhyTZcG3WHtsIcwJg+5GV5QAp0e7YMMBO5wsp7D
         aYUMV7+XET2iNwbV37L2SrjOymhulnHT3KJCvdvYJMsPk8+n1trwAK7HzM+Okp3B0liw
         0uDA==
X-Gm-Message-State: AOAM530Hn9P5VlL4WMHyzWmAF8GHzM5dBV45Z6+WcwNM3cNYADyZsvJl
        q1FOL5SUs7tk14jLjLs2rEc7MP28TXc=
X-Google-Smtp-Source: ABdhPJxucGO2elPvwSjX0EFxYrFh3PFJ0EFp91ltLShVzvMZktXXs1jgSijkTZdKLKzrr7NRxmWnwg==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr8113876wrr.167.1599234128854;
        Fri, 04 Sep 2020 08:42:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm11871430wmq.12.2020.09.04.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:42:08 -0700 (PDT)
Message-Id: <bd957290094351f42939e3607453ff3882b659d8.1599234126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.git.1599234126.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 15:42:00 +0000
Subject: [PATCH 1/7] maintenance: optionally skip --auto process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some commands run 'git maintenance run --auto --[no-]quiet' after doing
their normal work, as a way to keep repositories clean as they are used.
Currently, users who do not want this maintenance to occur would set the
'gc.auto' config option to 0 to avoid the 'gc' task from running.
However, this does not stop the extra process invocation. On Windows,
this extra process invocation can be more expensive than necessary.

Allow users to drop this extra process by setting 'maintenance.auto' to
'false'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  5 +++++
 run-command.c                        |  6 ++++++
 t/t7900-maintenance.sh               | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index a0706d8f09..06db758172 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -1,3 +1,8 @@
+maintenance.auto::
+	This boolean config option controls whether some commands run
+	`git maintenance run --auto` after doing their normal work. Defaults
+	to true.
+
 maintenance.<task>.enabled::
 	This boolean config option controls whether the maintenance task
 	with name `<task>` is run when no `--task` option is specified to
diff --git a/run-command.c b/run-command.c
index 2ee59acdc8..ea4d0fb4b1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "quote.h"
+#include "config.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -1868,8 +1869,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 
 int run_auto_maintenance(int quiet)
 {
+	int enabled;
 	struct child_process maint = CHILD_PROCESS_INIT;
 
+	if (!git_config_get_bool("maintenance.auto", &enabled) &&
+	    !enabled)
+		return 0;
+
 	maint.git_cmd = 1;
 	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6f878b0141..e0ba19e1ff 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -26,6 +26,19 @@ test_expect_success 'run [--auto|--quiet]' '
 	test_subcommand git gc --no-quiet <run-no-quiet.txt
 '
 
+test_expect_success 'maintenance.auto config option' '
+	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand git maintenance run --auto --quiet <default &&
+	GIT_TRACE2_EVENT="$(pwd)/true" \
+		git -c maintenance.auto=true \
+		commit --quiet --allow-empty -m 2 &&
+	test_subcommand git maintenance run --auto --quiet  <true &&
+	GIT_TRACE2_EVENT="$(pwd)/false" \
+		git -c maintenance.auto=false \
+		commit --quiet --allow-empty -m 3 &&
+	test_subcommand ! git maintenance run --auto --quiet  <false
+'
+
 test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
-- 
gitgitgadget

