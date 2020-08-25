Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACAAC433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F83A2074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsNOcJr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHYShE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgHYSgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:36:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C822C061786
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q14so2716379wrn.9
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fn6orM8MUDL04lcf1NiBVZ3hpWLI62ppl1T4O7e4T1c=;
        b=fsNOcJr+AaufUPSjcsYMDLmuVHA1tAbLkXzSubAXG51ObHcM3GI/Nfv9lMtfSkQ4tw
         QLQQB3zweKgPglvXMS8wZ3N2oeoA6weE1Vs831ye727OFP2m0xgDnfe7eSMdVP5V6cNO
         gHIADLqKjsyBZ8SDM9N2tV4KJa2u6SKbVagNuA5BGgQtlv9LNELaTg6Q3WfYPwum3Sc7
         5t0BMWU1mlZ2oEBR3cWj1R/+lvALNPr8nK/dJlMM1aGcCeZrO5GsghTv0FjUnLwNwq7X
         CYuv4FTfZ0HXBtMiTR8PBH0PoVrYIGpZeB71Qx7GbUnUUpV4fy6FTl4goKIarCjRVkKE
         6oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fn6orM8MUDL04lcf1NiBVZ3hpWLI62ppl1T4O7e4T1c=;
        b=ZZMri90TWhD9f/IJGXn0E769ygQZAlJcnhxV0saJBbS2amUDbNAs5C/DYjOyhpQxHO
         DCOA0mGCcL0uow/Ze3mBRFdZbDHpEnpBAdUwsM4/Sj1QF3+qL3XpwsRkL2Vzm5zEvknX
         nPpbA2eluT3pUSEgmQQYlv0IfPhcBDDblbYix5QuHmWm3pS9H9vOjKqIaLi52Gd7acsD
         fON08yg0jMsK9rsVvH6vY0zGi37jvVP6sTnL8jhjgCMneCIp9a2fEhghNwV8KZgYLHUe
         9pqRecZZ7/CSBsE+1ZZjkuLtLq+WzB91d26uIXkeb//4IdWu0c/BKTFfWWwL+6ZUAjLq
         i6eQ==
X-Gm-Message-State: AOAM530IYJ9oJNkkmRUuZhil07qhyPg3H5ImxD12+gJR5WJjjM6qLDJj
        QQAxwxlJ3TnvPRfKDFOK25169AZjz40=
X-Google-Smtp-Source: ABdhPJx7lHfiZOGm8/vD6cfx+u+fSuDO2UzA2UwMRY1XMdI4sMb94o92wD0VHdx6wP2HyjYXv4IjJA==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr11915002wrs.361.1598380607808;
        Tue, 25 Aug 2020 11:36:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm7559728wmj.5.2020.08.25.11.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:36:47 -0700 (PDT)
Message-Id: <e9bb32f53ade2067f773bfe6e5c13ed1a5d694a6.1598380599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
References: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
        <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:36:39 +0000
Subject: [PATCH v3 8/8] maintenance: add incremental-repack auto condition
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
index c31613be62..a0706d8f09 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -23,3 +23,12 @@ maintenance.loose-objects.auto::
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
index e043403400..f8459df04c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "midx.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1002,6 +1003,35 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
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
 static int multi_pack_index_write(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1157,6 +1187,7 @@ static struct maintenance_task tasks[] = {
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
