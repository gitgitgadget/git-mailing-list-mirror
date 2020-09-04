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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70AC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2F4206F2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWCxKm7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgIDNJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgIDNJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08698C061247
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so6650654wrn.13
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vl2kTUl6dSX+CyNd8PSqD1JASPC5be8B3MIBf7geL1k=;
        b=fWCxKm7AWCg764wP4Iml15zyPv3LvHTwNymAZdW8uMNeT205p2rhCXV9u4AqdO6XIA
         poepcIeg03hX/ow+leWyVGg7V6r74gi3sXz6rtYrol3dEIH98UORiTukBZjRs+3vKsyH
         8PQ3P263JZminTJZH046GIWL8qYpzbyrUfO8WhaHubSsMb0cdIO5LK6Fm3GE/eXZgLKV
         ILg27mGjLF0p5+qUHwPUd+HmA7PIHqWolOVnY3cQxAO11OdN5MzWHmpctv2nuAigirWK
         i8BLHvpnzzmRKoExkx90HB3+Qt+nGpYTGzoJKdEEbPoSO2FY8iD4mVmrpyDXxHkbBrfH
         SwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vl2kTUl6dSX+CyNd8PSqD1JASPC5be8B3MIBf7geL1k=;
        b=ggHW9Qc1r9/ZN/FNrgYofOgOUQiXGPMN/0OmmKiBcomkuJe6401cK57YBwjGNEmxHH
         3OiOh4AQ139TaEMneSCFTSyX+QfL9SWH6FPB0JAqCYL3MDqxY5zDtM2aiKEO1lzIRpOa
         LgGkrFHFq0PYKDHcz8VS4jMiv2iOg7iSAQmInHnE9iyGv0pdA/alGQ8sExGU2Egj58cp
         4qhrDjGs3Fv5FYmsseYCY7U3cKaWyXUOW43BqF0oosbeGv6ksrPd18XLAEzCU8blhkJx
         0RblmObR0FY8PMgaZAt7CK8rmk3bQhk6S3Yv8o+1dLaOxQCMGUpQak0G3YUSPVB3LtOA
         w9Hg==
X-Gm-Message-State: AOAM533h19sbdbXtDkdmziLeoqp99Y6eRYD9ckije3Ur7T8OacNKfmlQ
        9XgyX/6P2bU4ZoP84xrSvFxqTr9vpQk=
X-Google-Smtp-Source: ABdhPJyN4fHumoarhV4fzEcp/jyynGr9rMHOFx8Xpx9vVUqQtv+rEbox2N7LAVSieDVY3liSNbEbOA==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr7543872wrq.365.1599224960567;
        Fri, 04 Sep 2020 06:09:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 128sm11128679wmz.43.2020.09.04.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:20 -0700 (PDT)
Message-Id: <82326c1c38ca6d7ec71bddb50d33c1e5bc3421fb.1599224956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
        <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:08 +0000
Subject: [PATCH v4 04/11] maintenance: initialize task array
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
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

A list these structs are initialized with the full list of implemented
tasks along with a default order. For now, this list only contains the
"gc" task. This task is also the only task enabled by default.

The run subcommand will return a nonzero exit code if any task fails.
However, it will attempt all tasks in its loop before returning with the
failure. Also each failed task will print an error message.

Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index da11f1edcd..81643515e5 100644
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

