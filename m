Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8E7C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE06222205
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5PJr5wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIQSSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DFC061355
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so2985808wmb.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OOlQZPDcdCQoXOzd9zTrkzh9yuwtcEqPHqn3vRvk/do=;
        b=O5PJr5woLR1fjk3nmzcVRwJ26KDzbsL9ZcNfz4FSo4kOgo3Z/3oqubbNNEUcVHBMAr
         +DIP286w5ielXYss8vGFTvbHg9Q9r688aY7nIMd8tjsMlO6TzMe5cSaIj1X/juOIKIsL
         OJKB87XXRxfzBHaZaWz6tzc548q9Q25VFZxX49iD3c3zdyJ1CSM3AAxjpktLuaUfDJdW
         AOgRQM0ftHSWd/yP6rvFeeIv3eTOpKk24fXlUCStfi0ubdMZZ7RPmL89uy82sI7CejRk
         PjPEQB6IZ+xtBS4lUrsWoZ7N4K556C53sUIyzkYT0wSyM8gu4Co9mP7U+F9ZpPEG0mWE
         2+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OOlQZPDcdCQoXOzd9zTrkzh9yuwtcEqPHqn3vRvk/do=;
        b=pJOy9l+pqh74Ciq6kNXwDUiNlf5oWHCO3biKIwLZarHUHRsDPx+kqkDH0kbe0prOQ/
         uwrjIllpKImoR0bgYjjrV+kN76dTNsbVM/ufnY1GsHyVQ4JJSVHVHD8O5hX0hvd8y05s
         aEXc8gZJlp9CNR991sc9RPNXc1x1uKV7W79q2+5bDNzQXqzc+8J+zJcBHRrN8fpNSghq
         PFSU23/mEPwVjyoIVs0wDbAquqJLS//4uCmwrowgTa8UUe08cLdwfGI9bLGAUjbJYSJl
         3IjC+8GfnDZOT04DcDhK/Cz4STqrTSbh8vwCH54OQHez/9voom5VJ81/GMgNjLOHlizB
         u5gw==
X-Gm-Message-State: AOAM530bOYOCXgs1Tn+KBju/ylcH9RmyqvcCO9qYnkQCeIU26oSQ6zsT
        GYoAtmYHrFJqVKzKc50U8dxaZ4nL5ME=
X-Google-Smtp-Source: ABdhPJy8T283o7xAlKSLKQbf6dkoOH8C3G90XRfIqOk4NxrUTd0oaDQOFX0Ng8cxvad8jxTfBSrp0g==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr10885711wmc.127.1600366320175;
        Thu, 17 Sep 2020 11:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm572805wrm.54.2020.09.17.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:59 -0700 (PDT)
Message-Id: <1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:48 +0000
Subject: [PATCH v5 07/11] maintenance: take a lock on the objects directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Performing maintenance on a Git repository involves writing data to the
.git directory, which is not safe to do with multiple writers attempting
the same operation. Ensure that only one 'git maintenance' process is
running at a time by holding a file-based lock. Simply the presence of
the .git/maintenance.lock file will prevent future maintenance. This
lock is never committed, since it does not represent meaningful data.
Instead, it is only a placeholder.

If the lock file already exists, then no maintenance tasks are
attempted. This will become very important later when we implement the
'prefetch' task, as this is our stop-gap from creating a recursive process
loop between 'git fetch' and 'git maintenance run --auto'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 00fff59bdb..7ba9c6f7c9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -798,6 +798,25 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
 	int i, found_selected = 0;
 	int result = 0;
+	struct lock_file lk;
+	struct repository *r = the_repository;
+	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
+
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+		/*
+		 * Another maintenance command is running.
+		 *
+		 * If --auto was provided, then it is likely due to a
+		 * recursive process stack. Do not report an error in
+		 * that case.
+		 */
+		if (!opts->auto_flag && !opts->quiet)
+			warning(_("lock file '%s' exists, skipping maintenance"),
+				lock_path);
+		free(lock_path);
+		return 0;
+	}
+	free(lock_path);
 
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected_order >= 0;
@@ -818,6 +837,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		}
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

