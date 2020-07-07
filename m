Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416DC433E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59C12073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSKzHTPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgGGOVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgGGOVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB4C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so45358842wrn.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bR6PmxMFQBD9DX/axhGoG6uDdYZ8MNRKjMfdlcsxBSo=;
        b=PSKzHTPSFJmS5EGy423ehcUheSm5TilTiTBTy3s2AJlOKkZV0gyJ9AaJ29TSa3QYN3
         hP795vjTQFRzcLHz0jR8z7Aos3Uc03hV0jgaFcj+6Lweog6UvZSIm8HJuchgHKTgQ2LT
         zt0m6JIHmy6PakpwJ1+zvDFCnF9jslPt6qC4Tlj1FdZKRbPdry5ksPOwz7KC+woq8SSN
         vhRsCW3oLW5fDMAki68muepzeBfzML3LPMK5hxPqPr52WGHxCc5j1HJV2z2c02wjQAit
         Jdt2OC3Qv+1SKTgmxfzH8++lf9Ah1OiXOD4tyWUkw80CxfprUooZEF1yr9+m5LP3L2uO
         epVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bR6PmxMFQBD9DX/axhGoG6uDdYZ8MNRKjMfdlcsxBSo=;
        b=g6o6jddG4XwFwbn9AnMJ6cffD3irJJ+p8sGuVQcLn+CT3SlDh2Zu4dwYhxPfYF91Pt
         1e/F/PK68EnLmKv2rliib4AxbILTWZ5H9EDG9HtM99bgMzJ+nZdvvA0+0qvE7A5FHu0e
         go5qwjaG+uWl2ZEUgzfagmXecxzpPkcm7lgCeyr7tBuE+DKg+CNAlL9iu8iMiQnlw1or
         z4Twjrtpy7WXAmhn4Uy6sm1yZebFvyTzbU9+B2x1lXL2uj7QGPkUNzJOEVIXV70sGtVF
         olkNeDfVNI8Lx22IgaM08pqM6SFzuzNSixOs0ll4EhB1z7DoiLJRwJa9OCIZNjCLgLdD
         yQlw==
X-Gm-Message-State: AOAM533xXCz3QkihN8qvo6YUBuHdJCp1UMPu5US/tLFYNqibIEDf7Lw6
        xVlVFJqQAjVBuo8JYtPA6HywzwAl
X-Google-Smtp-Source: ABdhPJwrWiTzwGmDDCutCU3gFJCpTQ/P8jqjnMbFn9jJXkRKILTN0WLSqChujUC3CuU8UDQFmXgC1Q==
X-Received: by 2002:adf:e908:: with SMTP id f8mr53054741wrm.3.1594131705494;
        Tue, 07 Jul 2020 07:21:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u186sm1313058wmu.10.2020.07.07.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:45 -0700 (PDT)
Message-Id: <fc1fb5f3cceef894e44b3c6d4010e1bac1e7e284.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:25 +0000
Subject: [PATCH 11/21] maintenance: take a lock on the objects directory
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
 builtin/gc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8f2143862c..e3c634fc3b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -849,6 +849,24 @@ static int maintenance_run(struct repository *r)
 {
 	int i;
 	int result = 0;
+	struct lock_file lk;
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
@@ -863,6 +881,7 @@ static int maintenance_run(struct repository *r)
 		result = tasks[i]->fn(r);
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

