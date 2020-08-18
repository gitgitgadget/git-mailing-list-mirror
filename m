Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED1C433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EB9207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrWjN+5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHROXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHROXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFA2C061345
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so18478874wrw.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=esQK9tq9GqpY+vSwmwnemBsEpJ5f4uldkNOirXjhIgI=;
        b=qrWjN+5ogl8cDZriT7ERC4fE5lKmiP+Fc4pSK404zOV16eAsePP6FX1aP36yg/dmjW
         okrvGbF/48nwp1vDWYc1SGwkyzJqrD/VXlj6ohr9pY8badaLbY9EOxi8G3Lmo97dPRt7
         XROG6oazA2F+X+niyIL9vg4pxmnCi/gnXHDboIORtKy4dvtHkHB4VIm+YX2akQr6uqtI
         bGLqldOoOOf34iCbVV4UojrWKUPImjBF++GOwMNj+i8nqC5LcNRswNCEeOlE9B71AMz/
         aEpJbmgTzCpq7Os8naaCAJUEd7mQ6uoE9IDJa63FouOpFzuNy4yVZ/6FiqGQqYIIqZAD
         uyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=esQK9tq9GqpY+vSwmwnemBsEpJ5f4uldkNOirXjhIgI=;
        b=pBOlquCLQwJAbmjgaMO20QOssJ4xmvNlSIu1UBuoaKXfQS+pbxyRpzKa8cHquJC9HR
         35Arc5fW5XN03ChsPsmeQWkWvctnhjUvRiYogPuzbLAt7nYyZMT57iF6fsgrlx2cP7la
         2Awbx6dSkWFZT9CUNHVLAocG+c8g6NY3NX98KxZss6PkfQmDZ7jtWhIDIdzms+gyvbUV
         zr1NBd50JZabftrwQlIVm1fk6BpsKwpLHYPB5KQqHvSIbs4VrL3RAGb2+eTE5EsXnHD9
         gGlIvCIRq0FP+Btf2JlI038y6CKoo0YVo1pzhPTD3gbhttTzCNVLVEnHzrGuRS0P12sj
         HgFQ==
X-Gm-Message-State: AOAM533i3uSOhoS8ajKsyrEYazHZVuvdNVKiXirEe53eqjcVvq9eT8dM
        LILzIzQS26QsDDAy11NiCLmGsYjweS8=
X-Google-Smtp-Source: ABdhPJygWgv2CfmwwKOEPU4qHQ8lgcafnYd36OGVXqepdkXBD5j1gNj3y2kgsCeQ53NwYT+l77HJGg==
X-Received: by 2002:adf:d84f:: with SMTP id k15mr19666480wrl.176.1597760594256;
        Tue, 18 Aug 2020 07:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 32sm38180934wrh.18.2020.08.18.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:13 -0700 (PDT)
Message-Id: <1db3b96280d9bf7908b7dc9fa13b80c445164a99.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:23:01 +0000
Subject: [PATCH v2 04/11] maintenance: initialize task array
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
index b75ddb780b..946d871d54 100644
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

