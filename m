Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB3C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A7864DF5
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhA2SZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhA2SXX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:23:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646DC06178A
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d4so5688782plh.5
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKNDGS89h3BP7A+kc9sS7Cfxp6AlmTx76lu6cpG0xto=;
        b=Qgn7ssZ2BBY8dS4gwIhDbX+scMRzK4CukDpuY+9WC6vQvb9FKk4VoGPc229krnjtdB
         ZQBJ+KdBa+MyKyc3WPL1JfpriOswWfRX6TVF+ov5yixow94L2q7SaOqUPsAKMkG6juQ4
         oVHBqrLHKevY2oTkqCo1q2xO7wJJ0ACZe8jvRW4OhSMAPLjXlV2MK6/yHeB3AJIVfn9D
         ugUcmv+wp475rH/d591S0O79XfGZ4PRs9Ek+UP3VVRGm19idkuilf214tIXsxqGtlucY
         zuOfTbhqQw5MA6zyiVz6pVDrQcIZmiBC9QnaTpN8YSRTeyTRM2i5zIur6wJHGf94CJ6h
         4oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKNDGS89h3BP7A+kc9sS7Cfxp6AlmTx76lu6cpG0xto=;
        b=DT/P4kh866bByjGLmqdZ9KVTjlBrnagkR9VeZXhtGRHYLLYdzpsu7CTcMzpyiQmxni
         TvLqmt4Fu3Vuvq1/HHz+WBpvOMkOokjnZ/C0+b9TogCTxU88thiiYCdZKw7b+D7IFmY7
         BcbbE2VUFss+EYnSaxP6qSm1AlpuFtvpz3N9LSO4TVRfea+WcqIf3dOgVqd8v1xRUPcb
         yjEMvGj7nQyHWMoR2fCS9LnNdSNoG78GnztbmgoEOiUnyGQiJuSscHihp8tCg9/Zp5Eu
         CGmK1v4znO9xw3BvgIcG3UJG1BMes7hqbZFAn86GLihJn0SX57co3HT30OYpE/vMQpUF
         WAjw==
X-Gm-Message-State: AOAM532R11U/3pP615Ign32mP8DRN+nEabZiQ8CR58CdKMmn2br6x2D6
        rkOrGds0/D8OkARfNKp2jWJjtGDobzQ=
X-Google-Smtp-Source: ABdhPJydgOxVBnEpIb0T/flaqhQtIL90EeUNGT0QmXp7a2MwZyNn4CpjmrgaiFPU2e5F3zHmm8bNnQ==
X-Received: by 2002:a17:902:9a48:b029:e1:268d:e800 with SMTP id x8-20020a1709029a48b02900e1268de800mr1803179plv.69.1611944539993;
        Fri, 29 Jan 2021 10:22:19 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:22:19 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 4/9] sequencer: pass todo_item to do_pick_commit()
Date:   Fri, 29 Jan 2021 23:50:45 +0530
Message-Id: <20210129182050.26143-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an additional member of the structure todo_item will be required in
future commits pass the complete structure.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 034149f24d..09cbb17f87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1877,8 +1877,7 @@ static void record_in_rewritten(struct object_id *oid,
 }
 
 static int do_pick_commit(struct repository *r,
-			  enum todo_command command,
-			  struct commit *commit,
+			  struct todo_item *item,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
@@ -1891,6 +1890,8 @@ static int do_pick_commit(struct repository *r,
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, reword = 0, allow, drop_commit;
+	enum todo_command command = item->command;
+	struct commit *commit = item->commit;
 
 	if (opts->no_commit) {
 		/*
@@ -4140,8 +4141,8 @@ static int pick_commits(struct repository *r,
 				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
-			res = do_pick_commit(r, item->command, item->commit,
-					     opts, is_final_fixup(todo_list),
+			res = do_pick_commit(r, item, opts,
+					     is_final_fixup(todo_list),
 					     &check_todo);
 			if (is_rebase_i(opts))
 				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
@@ -4603,11 +4604,14 @@ static int single_pick(struct repository *r,
 		       struct replay_opts *opts)
 {
 	int check_todo;
+	struct todo_item item;
+
+	item.command = opts->action == REPLAY_PICK ?
+			TODO_PICK : TODO_REVERT;
+	item.commit = cmit;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(r, opts->action == REPLAY_PICK ?
-			      TODO_PICK : TODO_REVERT, cmit, opts, 0,
-			      &check_todo);
+	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 
 int sequencer_pick_revisions(struct repository *r,
-- 
2.29.0.rc1

