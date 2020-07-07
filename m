Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B80C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF082073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvOv3mwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGOV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgGGOVy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B54C08C5E1
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so43457993wme.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vFfmOa88QY6yJVxXdM5rOZ1t6kRb9OKTx394W9VVGBY=;
        b=XvOv3mwe3256/LSphtvO1/AMMt53n3b7MmFHve3VHId3NtgRq9DbdOe3dA0vhUwRnx
         +fXzMvE8I8vJYCpVSCkLYOPRBlE99WU6yYCw4fI4GG+6iXg+DBdOB+x1bu6jdH1M4JJ6
         XSE44VgfPnUTo7wXhllTGDngPVegXcNq9hDAo+Hy4UKFF/GHf+dTmCwV/0hjJjWiSkg+
         ARccFeFqVY/u0moUheWuzzCtnIgoRkNbEwWcc9drz7r8RwtaSk07XTlWwS53iFQhAsLN
         6dkagxSkerXsQ2xycEm25zClA+lwIHM1mwbNs3mhDP1Kut01Lzj2ilmD0laMWW6YUgO9
         sYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vFfmOa88QY6yJVxXdM5rOZ1t6kRb9OKTx394W9VVGBY=;
        b=Xph4bpQjIo7Gg+PXRaRUbeO+w7Lsp5cElWIn04CR4RC+fISGmiFU1fECd54H0sIFUn
         jP7C92PT+1JdbwnYxCwq6BAzw2of+BUZzu/iBwCG0s6ajhlROdWEBMqs1g/tJ3obadQl
         aCcwjJNjg07QKQGfofqFOq04EkR+EWOqLuzlV51/NX+teURWrO2GLhWIo9bIABXpTDEr
         ZhrP4Gw2sAiD80/5OVx7ojSLbaQzHMlypE0GF/GrbdFaqOCaVNCpcBeExFdRBDSvPOkS
         njF2oVb0hJxkNeYXGYzTVMfPG2S3/uqWfgUdU1sx6IkENrt4Fcz7z3X/Eel5g0ER/QN9
         fwWw==
X-Gm-Message-State: AOAM531gDlH8cQ6+EVQdfusy2gRfUsnDyWdZzNiHqIAtyxbsqW0T8cPk
        oFW/D16ye1h2NfXSD+1wg5osJh3x
X-Google-Smtp-Source: ABdhPJy6vvclSf0NNgTGCoF1KFDCCMDn8kmEy2kb8fiNUFaXHKG1R+aJsYZaQDI+lX7qn63E8r8Jjw==
X-Received: by 2002:a05:600c:2285:: with SMTP id 5mr4705536wmf.78.1594131712607;
        Tue, 07 Jul 2020 07:21:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s203sm1488590wms.32.2020.07.07.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:52 -0700 (PDT)
Message-Id: <fbe03b9af9a9a1db8d893a09ee3a95be05bd9e46.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:34 +0000
Subject: [PATCH 20/21] maintenance: add pack-files auto condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The pack-files task updates the multi-pack-index by deleting pack-files
that have been replaced with new packs, then repacking a batch of small
pack-files into a larger pack-file. This incremental repack is faster
than rewriting all object data, but is slower than some other
maintenance activities.

The 'maintenance.pack-files.auto' config option specifies how many
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
index a9442dd260..77b255318c 100644
--- a/Documentation/config/maintenance.txt
+++ b/Documentation/config/maintenance.txt
@@ -21,3 +21,12 @@ maintenance.loose-objects.auto::
 	positive value implies the command should run when the number of
 	loose objects is at least the value of `maintenance.loose-objects.auto`.
 	The default value is 100.
+
+maintenance.pack-files.auto::
+	This integer config option controls how often the `pack-files` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `pack-files` task will not run with the `--auto` option. A
+	negative value will force the task to run every time. Otherwise, a
+	positive value implies the command should run when the number of
+	pack-files not in the multi-pack-index is at least the value of
+	`maintenance.pack-files.auto`. The default value is 10.
diff --git a/builtin/gc.c b/builtin/gc.c
index 391e1e2121..c3531561c2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -31,6 +31,7 @@
 #include "remote.h"
 #include "midx.h"
 #include "refs.h"
+#include "object-store.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -1072,6 +1073,35 @@ static int maintenance_task_loose_objects(struct repository *r)
 	return prune_packed(r) || pack_loose(r);
 }
 
+static int pack_files_auto_condition(struct repository *r)
+{
+	struct packed_git *p;
+	int enabled;
+	int pack_files_auto_limit = 10;
+	int count = 0;
+
+	if (repo_config_get_bool(r, "core.multiPackIndex", &enabled) ||
+	    !enabled)
+		return 0;
+
+	repo_config_get_int(r, "maintenance.pack-files.auto",
+			    &pack_files_auto_limit);
+
+	if (!pack_files_auto_limit)
+		return 0;
+	if (pack_files_auto_limit < 0)
+		return 1;
+
+	for (p = get_packed_git(r);
+	     count < pack_files_auto_limit && p;
+	     p = p->next) {
+		if (!p->multi_pack_index)
+			count++;
+	}
+
+	return count >= pack_files_auto_limit;
+}
+
 static int multi_pack_index_write(struct repository *r)
 {
 	int result;
@@ -1345,6 +1375,7 @@ static void initialize_tasks(struct repository *r)
 
 	tasks[num_tasks]->name = "pack-files";
 	tasks[num_tasks]->fn = maintenance_task_pack_files;
+	tasks[num_tasks]->auto_condition = pack_files_auto_condition;
 	num_tasks++;
 
 	tasks[num_tasks]->name = "gc";
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a55c36d249..1714d11bd9 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -178,4 +178,34 @@ test_expect_success 'pack-files task' '
 	test_line_count = 2 packs-after
 '
 
+test_expect_success 'maintenance.pack-files.auto' '
+	git repack -adk &&
+	git config core.multiPackIndex true &&
+	git multi-pack-index write &&
+	GIT_TRACE2_EVENT=1 git -c maintenance.pack-files.auto=1 maintenance \
+		run --auto --task=pack-files >out &&
+	! grep "\"multi-pack-index\"" out &&
+	for i in 1 2
+	do
+		test_commit A-$i &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-A-$i git \
+			-c maintenance.pack-files.auto=2 \
+			maintenance run --auto --task=pack-files &&
+		! grep "\"multi-pack-index\"" trace-A-$i &&
+		test_commit B-$i &&
+		git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
+		HEAD
+		^HEAD~1
+		EOF
+		GIT_TRACE2_EVENT=$(pwd)/trace-B-$i git \
+			-c maintenance.pack-files.auto=2 \
+			maintenance run --auto --task=pack-files >out &&
+		grep "\"multi-pack-index\"" trace-B-$i >/dev/null || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget

