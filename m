Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8786C433E3
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E162073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPNRL9T9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGGOVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgGGOVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917EC08C5EE
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so17351532wrp.7
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XsGkEDg9GOcanbtBoBUWHaQE5FhwuiP3WKkBctYvyo4=;
        b=oPNRL9T9ldutAcxT/+QNEZuoX/L3EmzDCZIIjgQcESBT71lNx8Fe4GccwhHpaxw5UP
         WKpmp/yKZ3L7Q1PaS5HX0EHBHCEuFQ5SZtLdF0YEI02CRoE9aA5uHgXRVssg10JX9Ays
         CJDjDz4bOv4/5B9eiFBUUrImVhdTBM83dR1TSwEMBIN+eqn1XPmx5LJr5Cx00zNUv/3N
         wXoXtwf6pfKihouAABI5+IlMnD8mqzWD6Wd9xZB9EkEIOPpzrSgPpoCbwiPBJMk+ov4m
         UJgIIWQfgHnivQHcynNER+8cqCNoqU6qdgYSNWYVC5+DC9S3pSD/v+3hlW1gd4+Khixz
         8hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XsGkEDg9GOcanbtBoBUWHaQE5FhwuiP3WKkBctYvyo4=;
        b=V8abDoc4QX9ct4qpjtCqWh6WB8Cz6cFCzeFA8ZCjkFEOVrDbAKGUoE9qJVB6ZKmaq3
         FGyumJziY26LlPD4vGcvs7xkVBzpcln06o/UhjC7Bf2b9mi4/Q+Sbt22h2GrEObzz0zQ
         cZCWtY4oSZntmhDlr2rlc8hhiF7KQlbShG3pYAQzjI6Ltc3buQ5/xIpzpwBGAHsUugRe
         cLDdCSHb/oXqhwPJE17V0OiZkD3NEn4Wb6NCJ9KQkUJrhz5/EojwWu7SWJNGpvLlyc4a
         l4/ZXPjj6+Rn1Wo0yGWtKk38bbR4YY44uy6tJIwzLj5Vvf61lhsAQbwOQJHH9Y5eGJNp
         ykWA==
X-Gm-Message-State: AOAM531Rl2Vmjs+XNk1EcpuRodtObbvityHatU/FN7xO/AxJ+X6lRAsR
        X7Ht3Vb7ASUeXvmRopN0Q97VS3TF
X-Google-Smtp-Source: ABdhPJxw31zXTFmRNc+WD+CFCGra621SxKevUWstVHBI5Wn0ZjISSZ9OERavWRDTcoXngQekx2kRvA==
X-Received: by 2002:adf:e948:: with SMTP id m8mr55485580wrn.398.1594131703470;
        Tue, 07 Jul 2020 07:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm1425062wra.42.2020.07.07.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:42 -0700 (PDT)
Message-Id: <5cdd38afa60cdf768dd194f90ae0b2190123fdea.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:22 +0000
Subject: [PATCH 08/21] maintenance: initialize task array and hashmap
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

In anticipation of implementing multiple maintenance tasks inside the
'maintenance' builtin, use a list and hashmap of structs to describe the
work to be done.

The struct maintenance_task stores the name of the task (as given by a
future command-line argument) along with a function pointer to its
implementation and a boolean for whether the step is enabled.

A list of pointers to these structs are initialized with the full list
of implemented tasks along with a default order. For now, this list only
contains the "gc" task. This task is also the only task enabled by
default.

This list is also inserted into a hashmap. This allows command-line
arguments to quickly find the tasks by name, not sensitive to case. To
ensure this list and hashmap work well together, the list only contains
pointers to the struct information. This will allow a sort on the list
while preserving the hashmap data.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3881a99e9d..c143bf50df 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -705,6 +705,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+#define MAX_NUM_TASKS 1
+
 static const char * const builtin_maintenance_usage[] = {
 	N_("git maintenance run [<options>]"),
 	NULL
@@ -734,9 +736,67 @@ static int maintenance_task_gc(struct repository *r)
 	return result;
 }
 
+typedef int maintenance_task_fn(struct repository *r);
+
+struct maintenance_task {
+	struct hashmap_entry ent;
+	const char *name;
+	maintenance_task_fn *fn;
+	unsigned enabled:1;
+};
+
+static int task_entry_cmp(const void *unused_cmp_data,
+			  const struct hashmap_entry *eptr,
+			  const struct hashmap_entry *entry_or_key,
+			  const void *keydata)
+{
+	const struct maintenance_task *e1, *e2;
+	const char *name = keydata;
+
+	e1 = container_of(eptr, const struct maintenance_task, ent);
+	e2 = container_of(entry_or_key, const struct maintenance_task, ent);
+
+	return strcasecmp(e1->name, name ? name : e2->name);
+}
+
+struct maintenance_task *tasks[MAX_NUM_TASKS];
+int num_tasks;
+struct hashmap task_map;
+
 static int maintenance_run(struct repository *r)
 {
-	return maintenance_task_gc(r);
+	int i;
+	int result = 0;
+
+	for (i = 0; !result && i < num_tasks; i++) {
+		if (!tasks[i]->enabled)
+			continue;
+		result = tasks[i]->fn(r);
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
+
+	hashmap_init(&task_map, task_entry_cmp, NULL, MAX_NUM_TASKS);
+
+	for (i = 0; i < num_tasks; i++) {
+		hashmap_entry_init(&tasks[i]->ent,
+				   strihash(tasks[i]->name));
+		hashmap_add(&task_map, &tasks[i]->ent);
+	}
 }
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
@@ -758,6 +818,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 				   builtin_maintenance_options);
 
 	opts.quiet = !isatty(2);
+	initialize_tasks();
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_options,
-- 
gitgitgadget

