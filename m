Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D65C433EB
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACD120792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="on8oPCtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGWR4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgGWR4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44247C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so6011761wra.5
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fp8rJJuXnVVn4Jfilg4dxj67dseptukRejeJaQfpoqM=;
        b=on8oPCtQ9y1Uxp1nHgFMOduN/7GFHQkYza0H8ATXdHIIMnctnqTAS31y/R1O5KyWuR
         E+Wri+E912PTAtMcd0Nq90HGXqWDTMFu4eFaQ2ZJj2O4FQJ08fxYfeJSa8y/au3CoXrA
         7NlzPqRYtTOZUorgAqp1mNoBTj7j52PI18BUGDWQzdcC/MqwTZSvY79bZJi2T3lLUnFS
         Bezruxencyi6Pe41TrzW3hkUM/l4rOSms1wMLsW2LJXcvtI2uSnIss5gRMXpkbPTnaYC
         AsoXlPqTnJNhU7BWkmzQlHkvB1XGA4qyu1sE9z02uHX8kOtrac3UIt5cdBzlzHt8ULYw
         5jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fp8rJJuXnVVn4Jfilg4dxj67dseptukRejeJaQfpoqM=;
        b=HSQqh8Ek1btlg3N2mUagFzA94cdv0+CUzcHUotsq0ZSL74oRRMQwab5Ln8XcMflyOp
         R3UlogFf8qiVQWkPnoe3wvUO1lCAE3Eu8iWFBnODViN3EatSJK1FHzOBIVes2SbsHRnP
         ub4Ikvo9CCQsq2mJ99YuNBVeS7/3twrKDwmhzIJIj5iZQLKPdyFM+Llw9tuYUluWY0f+
         dO2NA9YlizdlDeo/8Vr2urYdZy+7UalC4cYNK1T+hsKWrDatpKXi/N4gMJ3AMU2Ia5Pa
         s47FhovQtHOPLidTTIJWwemA0lI6nDUMA2vjPc0O+vqQXkFZ89yLguiWeYKHngvnFnGT
         I3UQ==
X-Gm-Message-State: AOAM533imNZ99pklYqpg7+GzRfW9InepA1nrq199sJ2eX2zvSnTRxL0N
        +/xUEDX5gjXMeFtmO3/dDR3+pyF3
X-Google-Smtp-Source: ABdhPJx5LhsZMdA4p1cs7l7j9FQX/8P/TO+1A4ybZ6iCrj9BagD/NVVdvRogOb1I5QTt3t7XGbXAmQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr337375wro.265.1595527005848;
        Thu, 23 Jul 2020 10:56:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w16sm5465697wrg.95.2020.07.23.10.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:45 -0700 (PDT)
Message-Id: <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:26 +0000
Subject: [PATCH v2 04/18] maintenance: initialize task array
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

In anticipation of implementing multiple maintenance tasks inside the
'maintenance' builtin, use a list of structs to describe the work to be
done.

The struct maintenance_task stores the name of the task (as given by a
future command-line argument) along with a function pointer to its
implementation and a boolean for whether the step is enabled.

A list of pointers to these structs are initialized with the full list
of implemented tasks along with a default order. For now, this list only
contains the "gc" task. This task is also the only task enabled by
default.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c8cde28436..c28fb0b16d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -700,6 +700,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+#define MAX_NUM_TASKS 1
+
 static const char * const builtin_maintenance_usage[] = {
 	N_("git maintenance run [<options>]"),
 	NULL
@@ -729,9 +731,43 @@ static int maintenance_task_gc(void)
 	return result;
 }
 
+typedef int maintenance_task_fn(void);
+
+struct maintenance_task {
+	const char *name;
+	maintenance_task_fn *fn;
+	unsigned enabled:1;
+};
+
+static struct maintenance_task *tasks[MAX_NUM_TASKS];
+static int num_tasks;
+
 static int maintenance_run(void)
 {
-	return maintenance_task_gc();
+	int i;
+	int result = 0;
+
+	for (i = 0; !result && i < num_tasks; i++) {
+		if (!tasks[i]->enabled)
+			continue;
+		result = tasks[i]->fn();
+	}
+
+	return result;
+}
+
+static void initialize_tasks(void)
+{
+	int i;
+	num_tasks = 0;
+
+	for (i = 0; i < MAX_NUM_TASKS; i++)
+		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
+
+	tasks[num_tasks]->name = "gc";
+	tasks[num_tasks]->fn = maintenance_task_gc;
+	tasks[num_tasks]->enabled = 1;
+	num_tasks++;
 }
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
@@ -751,6 +787,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
+	initialize_tasks();
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
-- 
gitgitgadget

