Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB4C433FE
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D85C206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsr59m+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgGWR5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgGWR46 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A198C0619E3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so2443480wrm.12
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZuuyvrOEbYHMb02DAbtMFB0i88wpfAnbSXGTqzJrkUQ=;
        b=Qsr59m+JpTvgS/SCWJS3GSTc8kRioRRTJhkTeSJNGPFRKydIR/1bpMU4645tXkt8RX
         +0KjAZ1nN01iNTvp6TpaTDcsYX0mPlSQKox/MQ/fw3ToBiIxe8lib27Cm+f4yv6YA5I4
         1CGSe2ulDDP6V5WHrR0MGtT2bQhOpYgGmUqj3NCU6NpsTsEC1CdTy2D5fbWz6g7GN2eR
         upXE6jHXVC8DBrTIoGTAmfhSAYR8W5vtOo/4c5BZjOx3bkUYQ78hRbLZ5P/QAeC5G0vV
         81G4Rl570MAfqdmC9FDu3FeI7Y3bRCKVefm76HoX1Qr/PyuERXBzy/YK7FNiUWE21D7q
         eBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZuuyvrOEbYHMb02DAbtMFB0i88wpfAnbSXGTqzJrkUQ=;
        b=eZ003gNwU5VxOlngKIEaUDe8HBTnU7m74DFSUKIZ+NJYbOa/mH2nPQlGcEqe/nDbd6
         pU89yHyTClbpfTKLs8I/iuiGluaEGHLcw6FQ/5Tw1fgYLFFsSTOhtB8htd65TTHS3c2i
         ply5kQvggzzNkljBJ7aQquUrWbgTC/h1PxrZQlrfu8kQMvdaZf21bzUcqvBVKOpgvQqG
         4m/SgQrNdOLzmH1/+blL/O4PF+qPAJ3sI0U9hb8HCAcyWW8UnyTrpHe8hqiGWsei9tHa
         MpOtsef6kUtNRWT8Bi4enmNJQ26gVJ+T3MD6XTVDJW02sZ5zCf5x+rZ2X3If1YK2ibxr
         AciQ==
X-Gm-Message-State: AOAM5305t1if3qZ4gLpmleft8CcQLLIH87t4V9h1G2aoRNxvVmqF6qsv
        7Ca32mf8D+fCBGs/mxB3qdUyPDT4
X-Google-Smtp-Source: ABdhPJzSqa2n8fjJx6lAXLzKOu/c0iKsvjNv31Ebx4spGDP/WrBEhGcXR87BnmQ99Gas0eA/cf+xrA==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr4809629wru.47.1595527016704;
        Thu, 23 Jul 2020 10:56:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm4611325wmb.25.2020.07.23.10.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:56 -0700 (PDT)
Message-Id: <3d527cb0dda20a5b89a9a213fbdd4a28586a4e4f.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:38 +0000
Subject: [PATCH v2 16/18] maintenance: add incremental-repack auto condition
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

The incremental-repack task updates the multi-pack-index by deleting pack-
files that have been replaced with new packs, then repacking a batch of
small pack-files into a larger pack-file. This incremental repack is faster
than rewriting all object data, but is slower than some other
maintenance activities.

The 'maintenance.incremental-repack.auto' config option specifies how many
pack-files should exist outside of the multi-pack-index before running
the step. These pack-files could be created by 'git fetch' commands or
by the loose-objects task. The default value is 10.

Setting the option to zero disables the task with the '--auto' option,
and a negative value makes the task run every time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/maintenance.txt |  9 ++++++++
 builtin/gc.c                         | 31 ++++++++++++++++++++++++++++
 t/t7900-maintenance.sh               | 30 +++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/Documentation/config/maintenance.txt b/Documentation/config/maintenance.txt
index a9442dd260..22229e7174 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -21,3 +21,12 @@ maintenance.loose-objects.auto::
 	positive value implies the command should run when the number of
 	loose objects is at least the value of `maintenance.loose-objects.auto`.
 	The default value is 100.
+
+maintenance.incremental-repack.auto::
+	This integer config option controls how often the `incremental-repack`
+	task should be run as part of `git maintenance run --auto`. If zero,
+	then the `incremental-repack` task will not run with the `--auto`
+	option. A negative value will force the task to run every time.
+	Otherwise, a positive value implies the command should run when the
+	number of pack-files not in the multi-pack-index is at least the value
+	of `maintenance.incremental-repack.auto`. The default value is 10.
diff --git a/builtin/gc.c b/builtin/gc.c
index ae59a28203..b040c7d31d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "remote.h"
 #include "midx.h"
 #include "refs.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1063,6 +1064,35 @@ static int maintenance_task_loose_objects(void)
 	return prune_packed() || pack_loose();
 }
 
+static int incremental_repack_auto_condition(void)
+{
+	struct packed_git *p;
+	int enabled;
+	int incremental_repack_auto_limit = 10;
+	int count = 0;
+
+	if (git_config_get_bool("core.multiPackIndex", &enabled) ||
+	    !enabled)
+		return 0;
+
+	git_config_get_int("maintenance.incremental-repack.auto",
+			   &incremental_repack_auto_limit);
+
+	if (!incremental_repack_auto_limit)
+		return 0;
+	if (incremental_repack_auto_limit < 0)
+		return 1;
+
+	for (p = get_packed_git(the_repository);
+	     count < incremental_repack_auto_limit && p;
+	     p = p->next) {
+		if (!p->multi_pack_index)
+			count++;
+	}
+
+	return count >= incremental_repack_auto_limit;
+}
+
 static int multi_pack_index_write(void)
 {
 	int result;
@@ -1319,6 +1349,7 @@ static void initialize_tasks(void)
 
 	tasks[num_tasks]->name = "incremental-repack";
 	tasks[num_tasks]->fn = maintenance_task_incremental_repack;
+	tasks[num_tasks]->auto_condition = incremental_repack_auto_condition;
 	num_tasks++;
 
 	tasks[num_tasks]->name = "gc";
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e4244d7c3c..0b29674805 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -178,4 +178,34 @@ test_expect_success 'incremental-repack task' '
 	test_line_count = 2 packs-after
 '
 
+test_expect_success 'maintenance.incremental-repack.auto' '
+	git repack -adk &&
+	git config core.multiPackIndex true &&
+	git multi-pack-index write &&
+	GIT_TRACE2_EVENT=1 git -c maintenance.incremental-repack.auto=1 \
+		maintenance run --auto --task=incremental-repack >out &&
+	! grep "\"multi-pack-index\"" out &&
+	for i in 1 2
+	do
+		test_commit A-$i &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack &&
+		! grep "\"multi-pack-index\"" trace-A-$i &&
+		test_commit B-$i &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack >out &&
+		grep "\"multi-pack-index\"" trace-B-$i >/dev/null || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget

