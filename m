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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCABC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CC5207DA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFtmX5wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHRO0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHROZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF37C061342
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so18489529wro.2
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AlxW1av9M1vBkJqidOJ5Sl+CxxfUEWK8ggMyZ2oxwuM=;
        b=aFtmX5wfo5qgB8WWxAVDwL0tq4ofb43KNaJN4Zb0o0k7x3I2liHO49qsCJdBiWU6Yw
         qF57oSpjsT3Z/mChm7jIYHtv3Jkg7VynFnXzjcFsipdzZ2nnVcmKMTr3j4OhAh9hv0mO
         fSV2WRby7pNVNqPTJjtX7JalLc5MbPohOPTbL2gfR527hVhAVI1UC9rN380SmOaDu59u
         WH/H4843TXwK9kcUXfC4sCZ1P2htEkIdetq9UJ7h/KNuDsFEnddtIhI8eIn/w/7aQ1Mu
         MKnHIxfh3vj8uhTZ6S8SIvmZn0vAdNvxZPtTFWl2nauQwa2yazpH7kpDowP/cTl1r2Zh
         P2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AlxW1av9M1vBkJqidOJ5Sl+CxxfUEWK8ggMyZ2oxwuM=;
        b=j8LbaUhHrYPvIFZ1ztB+cAj8YihKJAiih1adwhSoYT09ez69SC17fDeafKRCyhJF9x
         cjO8I8dQoEBHi/WILcjUMOkJmp0FN9kBTx1LBMZ3TwHW1NVlfprMlDf6C/SqqpSuVTSy
         0NdIP7jHKLaQIgCg4EF634cl0cAE8KhAV8NiKr48tT16QEYPEZsiErSNwJICpghZ7nzo
         KLsqAgIQ4cxtziOVxQ01nHVIBr2CICpvdiYWsEqrfyET+e5SrvIktosKuVRcdAmdAvlS
         ktXYuPOsIjQU7KzurTLBBSuCFTjjJdihZ9ppOzX5U/1K4n4CbmWVQdaWwrOvUhPrhzh4
         4heg==
X-Gm-Message-State: AOAM53094azhN+xa8v8Pfu7mgSeGPlmcDJ3cdtNBp9syBqxNaGGLk+xm
        Zvck+CeGjRRcL6QuDQplXkUMyYoQl3g=
X-Google-Smtp-Source: ABdhPJz59gtYmWtBb0uHWwf4vL3AOeSIZhNkMevHWnbdoQ5NHeX8YiIUtvmfJ8hS1XdIJiP5bZzKPg==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr20191068wrv.120.1597760740740;
        Tue, 18 Aug 2020 07:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm36689129wrl.7.2020.08.18.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:40 -0700 (PDT)
Message-Id: <5659a23ad578fe58f2f6d6287e59d39b7c8ae9b7.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:30 +0000
Subject: [PATCH v2 9/9] maintenance: add incremental-repack auto condition
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
 t/t7900-maintenance.sh               | 31 ++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

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
index d2f3e27e54..7fa0e2fe97 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "midx.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1029,6 +1030,35 @@ static int maintenance_task_loose_objects(struct maintenance_opts *opts)
 	return prune_packed(opts) || pack_loose(opts);
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
 static int multi_pack_index_write(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1219,6 +1249,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_INCREMENTAL_REPACK] = {
 		"incremental-repack",
 		maintenance_task_incremental_repack,
+		incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		"gc",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 5c08afc19a..6f878b0141 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -220,4 +220,35 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
 		 --no-progress --batch-size=2147483647 <run-2g.txt
 '
 
+test_expect_success 'maintenance.incremental-repack.auto' '
+	git repack -adk &&
+	git config core.multiPackIndex true &&
+	git multi-pack-index write &&
+	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
+		-c maintenance.incremental-repack.auto=1 \
+		maintenance run --auto --task=incremental-repack 2>/dev/null &&
+	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
+	for i in 1 2
+	do
+		test_commit A-$i &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand ! git multi-pack-index write --no-progress <trace-A-$i &&
+		test_commit B-$i &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
+			-c maintenance.incremental-repack.auto=2 \
+			maintenance run --auto --task=incremental-repack 2>/dev/null &&
+		test_subcommand git multi-pack-index write --no-progress <trace-B-$i || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget
