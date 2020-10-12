Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E7C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD7C204EA
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB4+Q0sA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgJLN2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgJLN2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 09:28:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15AFC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 06:28:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so18904238wrm.13
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VICoFfqQLFv+DB1IDAo0gWe+eRGCOr3Q+HM3qJ+ulsU=;
        b=PB4+Q0sAlYgSJRidRExiGMcEheEyv11k8pIQ7DXyKI2Aj4ePUoHIFBTJuRLxSLjS5W
         GhOrDyCHMLxAPR8VHaaVN+JesFGB1kwCUTJVZlqI3mdE6wT140KXeDyk+OP1quqGXOze
         9mRNT85anF8dzBaBzCaHg1YqrrzBKNrmH2rZJ8nc+RUHtJaNg8rAD1yJyocqbM9WApa7
         M3fV6hGqh35E5gqfEcnGRMz9gFxb0muTxG0AUNvZHgM4H3IyTHiX/FY9Bt6YWva9iXr6
         9rksFKQHIMaTMjQllN1NfYRBjECsBgJAaJfi+BaXD8o9JZKznJg3FZkb6RJ8nXixONfQ
         q9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VICoFfqQLFv+DB1IDAo0gWe+eRGCOr3Q+HM3qJ+ulsU=;
        b=ewc4IHKvAeGZI2wpOJyx+aV9ImGZuXQVfO3PKxEumMgmD1ZwHackwfn0k0EMdh0vBY
         d8W9ZRILujDnCTtjh/nXbaJM4UqLsKF6wUsBkXQR8S/VIG6p4r4/vYN4K7ur2wYGfqBh
         kOaiuLE+3BETu0yddVPaWwXjnYDOv36X3TgjsLgllYD0iTN03DPE5l0T2D6vYeNLHmm6
         jB0uElxBPKtSIw0PXrAkIY/SQ9XazghQaEio242WvlZyM8iZCshMbp2ebJ99ffe64yE+
         GHXcmzP1UOaZYoe3Z8OdKUHXxCUaAb48gywDdu/vAYfqTVHdqcV3mBnj9eVvOsFIeyKe
         ztBQ==
X-Gm-Message-State: AOAM532yRdLrJXqMTNYDyddtNpJ7MAFtJvWoKwjySoMeAHWOn0KYZmaW
        ZB9s1pxmd+zzI4pBNVuKUPQdiN9rzKk=
X-Google-Smtp-Source: ABdhPJy1Q0chCR03CLBMLQ4qNdm9fEs4j3qwZXdg59aAt1TdoXBxC653NpHra7vBms0G6rCYu5sDjA==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr30727246wrm.203.1602509315504;
        Mon, 12 Oct 2020 06:28:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm25115999wrm.69.2020.10.12.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:28:35 -0700 (PDT)
Message-Id: <pull.749.git.1602509314545.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 13:28:34 +0000
Subject: [PATCH] maintenance: core.commitGraph=false prevents writes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Recently, a user had an issue due to combining
fetch.writeCommitGraph=true with core.commitGraph=false. The root bug
has been resolved by preventing commit-graph writes when
core.commitGraph is disabled. This happens inside the 'git commit-graph
write' command, but we can be more aware of this situation and prevent
that process from ever starting in the 'commit-graph' maintenance task.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    maintenance: core.commitGraph=false prevents writes
    
    As requested [1], this prevents the extra process when core.commitGraph
    is disabled.
    
    This is based on ds/maintenance-commit-graph-auto-fix.
    
    [1] https://lore.kernel.org/git/xmqqft6nrtlw.fsf@gitster.c.googlers.com/
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-749%2Fderrickstolee%2Fmaintenance-core-commit-graph-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-749/derrickstolee/maintenance-core-commit-graph-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/749

 builtin/gc.c           | 4 ++++
 t/t7900-maintenance.sh | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 12ddb68bba..e80331c4e2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -813,6 +813,10 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 
 static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
 {
+	prepare_repo_settings(the_repository);
+	if (!the_repository->settings.core_commit_graph)
+		return 0;
+
 	close_object_store(the_repository->objects);
 	if (run_write_commit_graph(opts)) {
 		error(_("failed to write commit-graph"));
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ee1f4a7ae4..9776154a2a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -52,6 +52,14 @@ test_expect_success 'run --task=<task>' '
 	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
 '
 
+test_expect_success 'core.commitGraph=false prevents write process' '
+	GIT_TRACE2_EVENT="$(pwd)/no-commit-graph.txt" \
+		git -c core.commitGraph=false maintenance run \
+		--task=commit-graph 2>/dev/null &&
+	test_subcommand ! git commit-graph write --split --reachable --no-progress \
+		<no-commit-graph.txt
+'
+
 test_expect_success 'commit-graph auto condition' '
 	COMMAND="maintenance run --task=commit-graph --auto --quiet" &&
 

base-commit: 8f801804befa12a9c4ddff91275cf03612f1895d
-- 
gitgitgadget
