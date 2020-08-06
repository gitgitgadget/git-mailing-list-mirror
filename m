Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C9C433E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397112086A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXauzGEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgHFQwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgHFQvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:51:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFE3C002141
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so44502202wrw.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XnWOKAq/9nd+xoGuHVxK9oDozWhfGFERuP9RHAy5J0s=;
        b=kXauzGEBbzlzsICunbz3vi9vLVesg5rEP+0wz4NP6eSKf2EVZu2bBxdJzMOhIdkoKe
         Vf0ZQyorhB2QTOLPE+KlKcm4Zi85WuS6vWSeIokvAp/1tuv6DT7VRKhfIHoiPMgDVimk
         GB01of+kU5WetPzk3SrJKTtQ+wiEKgxT3S30xiNmZefKLqx7rIyJbZ1zw3FKxFFhoUiy
         b+lcaFxCQ9JGgjNnnk4uP35uRJq3bRrHBCcBpJEcyMX4WMdc8ve3eNpWPe90nUT73yj7
         uXONqoczLzUw7KlpFNYm0WUJU44Tb/hrNOnfG98eC/IUZ8yFmXYgJSeLBNUH543EIKWo
         xAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XnWOKAq/9nd+xoGuHVxK9oDozWhfGFERuP9RHAy5J0s=;
        b=tzhMqvyEzc7Z0SgBVkwDMg32Kre2oDTzRuT7zHJP/qVLiky8r9nGpoWSEUZd/SIKpA
         K+TFL/57gGbUdy/MZwFMOyJD1cqMAQGO9QUqlXsFpAVnSoJ+PU3TuT6z9HFvm6/gXIpj
         oUkKGcnQD1tFqzUpnxGOjGUvpD2BZGFPyDq5OSj7mXjd3bXySYt2pycRVWrvonrkpaMD
         i+b+RdRTmTYCKTP+nyrKDVAGvzbfBcn5RbORySexSgPguVWHzTHjFoBraBoN7WvB4o/4
         ALUN61vqA8hN2r1Tlsw+zPjfqbvmlkkkfTGfQfgmuTdeFx/0lMG+wfidqm7sqSFesHSY
         1vpg==
X-Gm-Message-State: AOAM531/F+DR96A4KCsi5+E/HI6NHtfiVpIwI0vewkL598OcXCJNOE25
        fc36cbbJFYQyAxJ7YxLIF4ozUtxM
X-Google-Smtp-Source: ABdhPJzRpPIHChfaHnLZR8mLd8INA4orY5MJ/87oEsh8uvJxK/nCVyiNDFPHOyICERX081/2ph2t3w==
X-Received: by 2002:adf:e904:: with SMTP id f4mr7978128wrm.300.1596728927078;
        Thu, 06 Aug 2020 08:48:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm7002965wru.64.2020.08.06.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:46 -0700 (PDT)
Message-Id: <7efa23abc85bead9713c34d5f56b2f308dde7bf8.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:34 +0000
Subject: [PATCH 04/11] maintenance: initialize task array
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
failure. Also each failed task will send an error message.

Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a060ba8424..150dce4301 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -728,9 +728,45 @@ static int maintenance_task_gc(struct maintenance_opts *opts)
 	return run_command(&child);
 }
 
+typedef int maintenance_task_fn(struct maintenance_opts *opts);
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
 static int maintenance_run(struct maintenance_opts *opts)
 {
-	return maintenance_task_gc(opts);
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
 }
 
 int cmd_maintenance(int argc, const char **argv, const char *prefix)
-- 
gitgitgadget

