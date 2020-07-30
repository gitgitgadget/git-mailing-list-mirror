Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70FAC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDDF20829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi1N8ue2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgG3WYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730367AbgG3WYn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB6C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so26304377wra.5
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=arQb+rX+4t5Nf6yBzkvbk7cmF+LQ1a/qca9Qa+LsjV0=;
        b=pi1N8ue2a3Z1OTlqkSIKYehU3epbxPDPYigCUSb4n1wBWpaAvSkXwByCoF+YeDKtdk
         fpUGLNH8BUfVaYhOA/l4B6D4sXoqmHVGQeuEFjjxuty4VzMIeyh3n4MqlSGbKHyaftk4
         1+Klf8Hi0RBORxSQuUCuJ25IH+0Vq7vwIhYPO8dre3DhO3d/XKAUku7UA+S600Ge6LEi
         mAHmXZPgwInXr7h9p4mUTvri8sGrjMFi5rZY6rLHdmLHKw/cfseYtl5d29Jrj0LFIKE8
         KGTHqi8Zj9ODcoQKn3c+2va2dq6JzmjvMVaBTctJlV1hAhbCdqpF44Y7UGO09025GLRA
         PX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=arQb+rX+4t5Nf6yBzkvbk7cmF+LQ1a/qca9Qa+LsjV0=;
        b=lpaRD/lGuVTLYCO+Lpt1mgXMw73j56uwQCjSFLFnUgouXy5hHsGCEyih/4ByIYfiPi
         7dhBL8EhImZDiEZUeY3Ywfbrh/msiCQkgMzzBhvAAvyo8amJ5UOOoMKfzs4c6yVq37vN
         Y///JI0jbIRno7MmjCriDV6gNMX6g5b2Zb5N0fOfNsx1rqLLzoX8lWsAXv61LW02lNUY
         KIL1Uztr+hQm3/gKBuINfcLKo0zbMWahQHbCUO4kirmkEczfrCcfHJM0rDRPXR9XPCf0
         9nK8RWOQAQV8XbNC+ZUFLC9MpJRYYdctrGt2rNJikqCM9jFXjGy+gnSKBr9C1nX/4W0t
         qE9Q==
X-Gm-Message-State: AOAM530ieulfreTPs7QAwLKG3lqQ7gRji8jh7I5Byf1PIZjfexOp35U/
        hp852J/J3kjfREHXP3ko+IoWCICZ
X-Google-Smtp-Source: ABdhPJyKRlP5nJSQUPDyRLq0KiuF1nb7oXWCI114mEXzwy4SijbHFYhmsfZYWUfaC/rQjZKNKuGdlQ==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr649753wrj.380.1596147881553;
        Thu, 30 Jul 2020 15:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm1619729wrf.32.2020.07.30.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:41 -0700 (PDT)
Message-Id: <b9332c131863fd8d31924a348b451e03fed880ad.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:10 +0000
Subject: [PATCH v3 04/20] maintenance: initialize task array
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
index 3c277f9f9c..0f15162825 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -726,9 +726,45 @@ static int maintenance_task_gc(void)
 	return run_command(&child);
 }
 
+typedef int maintenance_task_fn(void);
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
 static int maintenance_run(void)
 {
-	return maintenance_task_gc();
+	int i;
+	int result = 0;
+
+	for (i = 0; i < TASK__COUNT; i++) {
+		if (!tasks[i].enabled)
+			continue;
+
+		if (tasks[i].fn()) {
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

