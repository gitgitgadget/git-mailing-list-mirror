Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB5AC433E5
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A3206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ5jeTrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgGWR4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgGWR4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70DC0619E2
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so918474wrs.8
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yvp+ThwhNNGXj4tRo41TmDa3Hns/sGK8I20VbFp0Ap8=;
        b=mZ5jeTrW9rZR6kEqeOTXpr9fFslESJ1yPBXi82K3THK9FR7B0PySJY06X+vsl3+JS4
         zSry8UVsGumhi3Ks4Q1Uz5lDJ7jl9onLBMN3y3WHPKoSqcJm2aRdJz3DEieKh+GomnsR
         PZWQ5kOVxTPlf55hXTmG5oaDB2Mf99ooILVAoVUI7cWWeo5uB1WolPsUJ25m+vSw55+h
         q/Rsp2mpSqNsdLTSZVYJ6XKjGV50iv64+p4tMhcHCKn4PcLAvct2ejJQ89j0tFMILYp9
         NuEpR5IVcoz5lsXqzGRtYf8Y7OFGvldlE5K70WfEk8Gy0KkOAWgIPPGH3DkWdXEjy34Y
         O5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yvp+ThwhNNGXj4tRo41TmDa3Hns/sGK8I20VbFp0Ap8=;
        b=LkYT2D20wHgzTXEtJBCjxqa/VGSEHIIlSU5ibxO802s9Hw0zDlDcLo/T89zfVZoLWg
         pq+UyPbDvYpKrX+u0fQuzNL0AytPcbnHQOPoHEkqRDr5PoKsnZxpUT1QN0LB8OY3TSlY
         QJUNNLOqp2SF8ZTvTlW5dZe6pAU6lafMpYAhdlkclKqwdXc+81IW9YrGrlIzI4YSCOhq
         Znp/+KIsHbRKRJ8ZRQ0SBPkkljZ6akRI1ULuLWN4je/VjjsQ1xmbUWo9A21dzCHX12zY
         oZLY33ds/Jozaj6JDOHgXghWN5tYJRqBGQSPcU7MPTHIuXP1LaaeJOmYnXYwGy04MMQB
         HBYA==
X-Gm-Message-State: AOAM532Ih5aTRy1I3s+qjHF+i6HdwUJ2uVvY1xSaHEuvp6Nm537AhDrK
        MTAP5vW3XTuHanrXpt9hJfLTvcne
X-Google-Smtp-Source: ABdhPJyJns398vV2iRuGBhpHEiA7yHtUUX/SuiVHR0qabLomOR6xbPKw+Bwu8hYhQMkKDuvaBboRzQ==
X-Received: by 2002:adf:db86:: with SMTP id u6mr5248512wri.27.1595527008942;
        Thu, 23 Jul 2020 10:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm4476947wru.38.2020.07.23.10.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:48 -0700 (PDT)
Message-Id: <e9260a9c3ffa4791f65a6690112788f681c54a16.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:29 +0000
Subject: [PATCH v2 07/18] maintenance: take a lock on the objects directory
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

Performing maintenance on a Git repository involves writing data to the
.git directory, which is not safe to do with multiple writers attempting
the same operation. Ensure that only one 'git maintenance' process is
running at a time by holding a file-based lock. Simply the presence of
the .git/maintenance.lock file will prevent future maintenance. This
lock is never committed, since it does not represent meaningful data.
Instead, it is only a placeholder.

If the lock file already exists, then fail silently. This will become
very important later when we implement the 'fetch' task, as this is our
stop-gap from creating a recursive process loop between 'git fetch' and
'git maintenance run'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index c58dea6fa5..5d99b4b805 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -826,6 +826,25 @@ static int maintenance_run(void)
 {
 	int i;
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
+		if (!opts.auto_flag && !opts.quiet)
+			error(_("lock file '%s' exists, skipping maintenance"),
+			      lock_path);
+		free(lock_path);
+		return 0;
+	}
+	free(lock_path);
 
 	if (opts.tasks_selected)
 		QSORT(tasks, num_tasks, compare_tasks_by_selection);
@@ -840,6 +859,7 @@ static int maintenance_run(void)
 		result = tasks[i]->fn();
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

