Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F5C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7565D221EC
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 12:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUoaD1Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgIYMdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 08:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgIYMdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 08:33:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CFC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so3440950wrt.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ruMiJL9Ly9Neub2HM8SpytEdeFbyLqbh92U2YY1sLdc=;
        b=VUoaD1ZyfyKEKPNKg0JW18Hl/m/wQaGSl8Q04UMss8Yul1xt+EO8Na4QpRZHKhCdxO
         +iJjrhIzyQRrkWokS8UoKvMc+RIcCjdn7fB8kyEhGu04HDK5NSTYsNP8CzYijWDnd01+
         2Zc9yXAjoqiVCQtdn/XlYilKmEdYk0rKGZmHszirX3SmFxI7YhHWavB44/9jdajZnE2a
         Zanahms8K/bC7kH+e0gu6RxaBkx6mwYdj7swcXgpdt0OIAov7C5A2DH3FTfwHoChSvs0
         pY31fcQ9R2RnH0BrYWpJcfkUOb/8pYaQTpsnZUBwtMs6PuDtjINsSGbmTZiJ+oULWGkT
         jAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ruMiJL9Ly9Neub2HM8SpytEdeFbyLqbh92U2YY1sLdc=;
        b=iFz03jIxvQUAE5aw5eZ/IEjmupzLRHNQUHU3EsFBkVQF3dRVnIg8J+UBd88xQ6tpAX
         iWn73GkN95LkZlUCb+YonHfjPrNvfQdW3GWpV/UVcIPVu344DxovFEkFuDQa4Dik3rqP
         UoIKAjPLxmMCDtqLCtSvd7V7n9qbAzYO26qQWR28mNUnbzmx2ClC2x8wPwBrSBNSNpnG
         eWf4wc8LFFu7msRUg0RmbmDvOAlvVj5lyM5WEU7f8476zGSS9OlYCJK/+XRrgtC4zDur
         f8lJoD+n/A0LDs6tKBtbnWsaH8PyRbPwxfhGOlDgp+Ho6LAHPECk9L9I7KWIwvCrtpID
         B74g==
X-Gm-Message-State: AOAM533BzBushx79rfI7F2h5OvKjcNx7hk0JRSkhi+6nef4q6qqqXM5/
        KWMYNbt3IqQjglcjdCuZnl+gHKoiAGw=
X-Google-Smtp-Source: ABdhPJzv7685A/2vLi87e72fL9yZriGxPC8P49y5NoGNZwUIGw7xDwZaNxJU2ihycGRM5A/F3b+24Q==
X-Received: by 2002:adf:b74a:: with SMTP id n10mr4152215wre.140.1601037227872;
        Fri, 25 Sep 2020 05:33:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm2680005wmf.7.2020.09.25.05.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 05:33:47 -0700 (PDT)
Message-Id: <f660dd1890656609dc9ed433579323488a3ca648.1601037218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
References: <pull.696.v3.git.1598380599.gitgitgadget@gmail.com>
        <pull.696.v4.git.1601037218.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 12:33:38 +0000
Subject: [PATCH v4 8/8] maintenance: add incremental-repack auto condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
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
 t/t7900-maintenance.sh               | 28 +++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

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
index 8d22361fa9..2b99596ec8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -30,6 +30,7 @@
 #include "promisor-remote.h"
 #include "refs.h"
 #include "remote.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1001,6 +1002,35 @@ static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
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
@@ -1156,6 +1186,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_INCREMENTAL_REPACK] = {
 		"incremental-repack",
 		maintenance_task_incremental_repack,
+		incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		"gc",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9e6ea23f35..55116c2f04 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -219,4 +219,32 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
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
+	test_commit A &&
+	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+	HEAD
+	^HEAD~1
+	EOF
+	GIT_TRACE2_EVENT=$(pwd)/trace-A git \
+		-c maintenance.incremental-repack.auto=2 \
+		maintenance run --auto --task=incremental-repack 2>/dev/null &&
+	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
+	test_commit B &&
+	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+	HEAD
+	^HEAD~1
+	EOF
+	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
+		-c maintenance.incremental-repack.auto=2 \
+		maintenance run --auto --task=incremental-repack 2>/dev/null &&
+	test_subcommand git multi-pack-index write --no-progress <trace-B
+'
+
 test_done
-- 
gitgitgadget
