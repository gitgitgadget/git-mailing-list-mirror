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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33691C2BBD1
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0441221EC
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYZ8wysa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIQSNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BAC061352
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so3055091wrs.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tg2/P5yFktfjeIDaIDVS8JrApj3MT0ERiT8uiaZI3wA=;
        b=WYZ8wysaYlwfv1sJK+FunnGGqg8KUKJraCgzZgL2BbLGZWMLMwSODLbn/W4CofFQBV
         pa5/tSjzf6u6WFJZKzU6r5nKwXCyfU4AOsqOnTWPc3PAfuX/CXjYIM/lJN+pkXU95nVY
         ONuwZOCN2FnOxVQBdXz63n1NQiluaaXx9TdGf6QV+NyXZz6VHgtIccApC4yweLPKiKLb
         eMXXJnEYgemTJzTlSdS2piUB0VJ1FxmKDHo8b1fsbw2N2NmirZ9OmimZwSz8sxJHfiCB
         gf2tyDxkTjR95k3PLy7NlVQvodBULzBK+SyAiZVqHPnPBIDWkjgQ6OM0OAdJPor/hc1n
         G8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tg2/P5yFktfjeIDaIDVS8JrApj3MT0ERiT8uiaZI3wA=;
        b=EuyHn0dH6qYLE+jA2K2H4WVe8jZVtKaNxph+laJPMjzRSrIKl1M8tNKsuZg04wa5a7
         nOLln3Nb7Td9dhOM8d2EmdtDfrAmu91l0hkfxNJRzq8dESv/UiHdR7qPATX6z0BJndpi
         BSGQnoS5ZQArvkzp+B3YmEZxM07eTiE8e+qp1oVEg6EIB5onlOTHoiTrUH5dbrmiNW11
         qBkxjs/Ub7PRwR+K60Y2Y07qQHy7V8Edztp2XtAqZCDpcRuC6LE589nJFa274IDTvi+Z
         UZIrj2mIqQFJ3nB7mLzz5HKTaB1nHz2dERsBhuvZtHptPOcQAU90OOX4WAhAXlB5EJV3
         o7sg==
X-Gm-Message-State: AOAM530s5zc2Nb0Em8Q3wLT/JNS42JLWS+gsVezyiemMLegBVywchlcm
        Cvm4XRf69BcNZWCHCuuh8zkRJUIRU3U=
X-Google-Smtp-Source: ABdhPJzAItbs1Syrxn6yrF4nGFK/qnqhWIHQPBS4k7fh+vPMhE+fvqfqYDszURb4MHdEz3cH4fjhvQ==
X-Received: by 2002:a5d:43cb:: with SMTP id v11mr35368844wrr.188.1600366317631;
        Thu, 17 Sep 2020 11:11:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm455034wrt.80.2020.09.17.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:57 -0700 (PDT)
Message-Id: <1d2f2731bd3c206dc53fa2610d901b95e53b6295.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:45 +0000
Subject: [PATCH v5 04/11] maintenance: initialize task array
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

In anticipation of implementing multiple maintenance tasks inside the
'maintenance' builtin, use a list of structs to describe the work to be
done.

The struct maintenance_task stores the name of the task (as given by a
future command-line argument) along with a function pointer to its
implementation and a boolean for whether the step is enabled.

A list these structs are initialized with the full list of implemented
tasks along with a default order. For now, this list only contains the
"gc" task. This task is also the only task enabled by default.

The run subcommand will return a nonzero exit code if any task fails.
However, it will attempt all tasks in its loop before returning with the
failure. Also each failed task will print an error message.

Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bacce0c747..904fb2d9aa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -728,6 +728,47 @@ static int maintenance_task_gc(struct maintenance_run_opts *opts)
 	return run_command(&child);
 }
 
+typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
+
+struct maintenance_task {
+	const char *name;
+	maintenance_task_fn *fn;
+	unsigned enabled:1;
+};
+
+enum maintenance_task_label {
+	TASK_GC,
+
+	/* Leave as final value */
+	TASK__COUNT
+};
+
+static struct maintenance_task tasks[] = {
+	[TASK_GC] = {
+		"gc",
+		maintenance_task_gc,
+		1,
+	},
+};
+
+static int maintenance_run_tasks(struct maintenance_run_opts *opts)
+{
+	int i;
+	int result = 0;
+
+	for (i = 0; i < TASK__COUNT; i++) {
+		if (!tasks[i].enabled)
+			continue;
+
+		if (tasks[i].fn(opts)) {
+			error(_("task '%s' failed"), tasks[i].name);
+			result = 1;
+		}
+	}
+
+	return result;
+}
+
 static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
 	struct maintenance_run_opts opts;
@@ -750,7 +791,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
-	return maintenance_task_gc(&opts);
+	return maintenance_run_tasks(&opts);
 }
 
 static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
-- 
gitgitgadget

