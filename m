Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03066C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD09B2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd6qQQjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgHYSeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHYSdz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98626C061755
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 83so3567581wme.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vl2kTUl6dSX+CyNd8PSqD1JASPC5be8B3MIBf7geL1k=;
        b=jd6qQQjN2AqRVqXs9ny+/FWPxS/xws/GI+t06iAYfIB4foDpulwmqOTbx/6Qo7aI7A
         fohY4RwtiHVn++G1erUFEhVi4wbE19v8qL5j3CgFakyxr7vLtpTGt44x01bcJdWPfQ7Q
         O4gH5DnP5DTa6Y/8l6kvzsivczNSMlrfhStYw7q9C/Tzqo9cXPB2sZTbdEE9mxZ7f+A1
         fAwJYqbhCnQOXFM1HPMLdZAwYeiepCTkr6/uvTX7cG6G53T9NrHtcvpxCSzAjfVPiy6H
         xuQ35WKMh+z0NepUo0qddPhAWEJqIBvP1imt/RU2u0qx3VXJabV5nUzFoofQPA294t2n
         Me0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vl2kTUl6dSX+CyNd8PSqD1JASPC5be8B3MIBf7geL1k=;
        b=LvOX8vTXFhc3kZorUekHEAE3V8mleh3sBMthl4I4QIVE7XaKUAh2azGiJKNABAxV2r
         0zzPt0Dd4PzS7L9UBr31C0Aw/5x12M8VxxU2nqtPincHac6ErfY6ANw9qQ093vTVSzsB
         ItK2mI1CZleLdy1QgCUTelBaCpaIsnoZfZsVLR3YqJzIYuMh61lxWdCZfrDGWsAfsXNC
         vDV1GDRW0dQyObsjb8OKFHlMkrHh5bDCwnoA5ylezkFf0v5Wevtq4mEwXnFFMJqxTcC8
         L7AztEUwpLp/69keHMydO8i8bTvD9tW5fhlUhS2/v4CMkx11EVGtLhkv9lIzDOQ7zEPR
         2XTA==
X-Gm-Message-State: AOAM530Qgk6C1r1+LWpc6fTE0Hz0qoiHmuI8HzENbuwqn6HmdkKJ8bJN
        aVnSRSc0pkG6RR+VtekKSdnRxlEZ8RY=
X-Google-Smtp-Source: ABdhPJwFWH/upkL81154p79lXpjzycJjHoh+tQb7+NNTVXTWJCJhzmFf3vOcrPP/2RjYGf9nxw3DZg==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr3221665wma.121.1598380432325;
        Tue, 25 Aug 2020 11:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm8758605wme.9.2020.08.25.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:51 -0700 (PDT)
Message-Id: <82326c1c38ca6d7ec71bddb50d33c1e5bc3421fb.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:39 +0000
Subject: [PATCH v3 04/11] maintenance: initialize task array
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

