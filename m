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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9FC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E43206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaYQ2WzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgHFRwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgHFQbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF856C0F26C2
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so10277100wmi.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=znxVoAdJfaAN6WSfdYuvp8HvqqaQsi1fwwahAzmgASU=;
        b=CaYQ2WzMw8e72tdjERrik6Y/mKWEDbV+Qr94xpOAyZQZlf1otydEHdSwd3eG10lI2X
         Zb3lCDHiQHLzcm7H8pW0s5Z0wiexuQnYsvLKb5F4ZgInULhKemSL9O3NK2JT+aYmh7pk
         1y+TlQ8xGBXTV9gKRnB4s9j9ejdENl9NuoaC97WVzIufsBnlG4/H4Cunhvd6drQMQAqc
         akIuqHxmtWjArQgJqFwG78kFuo8mX0+Ic/H6EfOxwSlIsY2nYj+ky+89wc4BdpnfGzJs
         3J/ty07QNqumG1175KgITuMUtRZ9cMagyqhkPolNuY9bU3EnO8IGm9JLsbZFHmHgEL4n
         vRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=znxVoAdJfaAN6WSfdYuvp8HvqqaQsi1fwwahAzmgASU=;
        b=DFattL/dk5TI0n2LYiVe1+mCdl80BRobE5O8GUJK4JVGpPGgB8NgrkG84JA7utPTD/
         iL0UGF5I8KVsVgibE8IXk+EdiPDhGlnFzvkZsP4gxf4iPDUHVpsGtg7HNPX4dyfvL5Rr
         wFufpRuGQJkyY/Gquv8LRqhoOFaHrtqGpY2woFD5qxDXaFNsnHwNpwUVXlH0LbbH7SsT
         IjdVMdQGM84Rcbp58786zVE4Ca+Sr3lF5xuTfupDPlrEu3shpD6evSpKqptqRySd4LQZ
         a9GQmo5ToLIHU4lQpU1dbTgjeWdZINLqXpsgY+h6errPaNKkNYRLo17ty0zCoaRuuVF3
         weeA==
X-Gm-Message-State: AOAM533NT5tBDCZU5PKSMAmUfLD+Do0/9iuas8MmT/pD4fmKoVBT5IDE
        UooIwCDGXMvyIOZxeu9lINYmgnXS
X-Google-Smtp-Source: ABdhPJxbfg3zm3sRGg8HMK+hJHxzEWMiHZZvGic04wvQjak4i2dgHMpz2OzrLtI1O5rMdCikxK3dLQ==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr8453180wmb.157.1596731433198;
        Thu, 06 Aug 2020 09:30:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y145sm7245787wmd.48.2020.08.06.09.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:32 -0700 (PDT)
Message-Id: <407c123c519f473f303c5d0316e1b5e67d6b94ad.1596731425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:24 +0000
Subject: [PATCH 9/9] maintenance: add incremental-repack auto condition
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
 builtin/gc.c                         | 31 +++++++++++++++++++++++++++
 t/t7900-maintenance.sh               | 32 ++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

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
index c09bc1381c..dbf8080d3b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "midx.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1030,6 +1031,35 @@ static int maintenance_task_loose_objects(struct maintenance_opts *opts)
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
@@ -1220,6 +1250,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_INCREMENTAL_REPACK] = {
 		"incremental-repack",
 		maintenance_task_incremental_repack,
+		incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		"gc",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1c5f44f2b3..e1e802e543 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -187,6 +187,7 @@ test_expect_success 'incremental-repack task' '
 '
 
 test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
+
 	for i in $(test_seq 1 5)
 	do
 		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
@@ -217,4 +218,35 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
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
