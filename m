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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE72CC433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C7520829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHN+jY7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgG3WZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgG3WY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B42C06179F
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so26265421wrh.10
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IUfoxyu4y2Mnm4a5S+lYZa6c+1Hk1DSww+pfud9VER4=;
        b=OHN+jY7pE99y61aIm/GPk0SEgdTZ9F0mbDle8BRf162hOX9tU3MhhQeATppw30NIS3
         Q4znncnVzGIhhbpIrgVSnSAh/PZOB/g3s67saCbN82JbWTRW4miRYFiYhZAnJn1ybJat
         UhA3DlnbaSR/EEE0DGcDCzgVoAHhvO76w3JW0tnWfRUXc1d8uhZaoedezryNl3gaKTmj
         mZWixv0Y1o0tKmd7vED2G5o9mZIi0AsEHC2cF6qRVfpsu2BTZHbYoT3LlLDFfKShnYFd
         W37LiAZrEKcu7HzNoywsmVHAi0nXC/JpRlMiK8SHF1IyNKys/Lq4M9vcukiISzREKF7S
         J0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IUfoxyu4y2Mnm4a5S+lYZa6c+1Hk1DSww+pfud9VER4=;
        b=g0rKd6fZpS3X8mtSS0fuI5keqWxKQbAYj/y9+yzAHpvLzQyeWODGy2pkeh3WPJt73g
         pfyZDS1yY5Kx6PVTMq/tz8FuY97Jw/8XzHfs8ecG4Qd4fS5W73RcHO3jMGBUTrriuTR+
         fZKdh0L0ypQdgCT45i/9qiUg9XLlrK4lOSDfrmAoaJQWTnJEdexSR8Y2+2jwypEyD8eT
         de3DsaAkI4pAvq888knhLXywsZrsclW594aEvGL5wR5hkrk4lX7DdtsNW7bN5euPl3bI
         Hh6X5m9KMLYsUvPlZ8ewgLJ8cqESZaIJz6URx01qcFRIgM0NogbTVOst/Dx9Pi2PcfWO
         Irwg==
X-Gm-Message-State: AOAM530IgxLnAxLXDXxlys7oFeHfq1D7WFFDpFSSNaIatbioCQXRrmUi
        /JurNFyPSkXZGm+1VIn0TLn57Lm4
X-Google-Smtp-Source: ABdhPJyDRp7iO9rdXgUXGLvt5cPAVTWL+YpVAfvNr6XXp2U9HiCDYjKiY1k+YxSQ5Yqr/zsD5eOsTg==
X-Received: by 2002:adf:8024:: with SMTP id 33mr744325wrk.117.1596147894689;
        Thu, 30 Jul 2020 15:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k62sm11535399wmb.16.2020.07.30.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:54 -0700 (PDT)
Message-Id: <801b262d1c26625d3f174fd80d7ddd336328bdd6.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:24 +0000
Subject: [PATCH v3 18/20] maintenance: add incremental-repack auto condition
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
index 3b27dc7e7f..6ccc0cca19 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "remote.h"
 #include "midx.h"
 #include "refs.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1029,6 +1030,35 @@ static int maintenance_task_loose_objects(void)
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
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1218,6 +1248,7 @@ static struct maintenance_task tasks[] = {
 	[TASK_INCREMENTAL_REPACK] = {
 		"incremental-repack",
 		maintenance_task_incremental_repack,
+		incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		"gc",
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 32ac5c9fb7..c8ccaa0a3d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -182,4 +182,34 @@ test_expect_success 'incremental-repack task' '
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

