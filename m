Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB7C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CB52083B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d41dX1SX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgG3WYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgG3WYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A45C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so23321415wrx.9
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nkDpWha0F8QROGymjtiq9TmTXWR4raEqKPpr+Lp1vOU=;
        b=d41dX1SXBhp5NPv88y1gZcO0VWXsjSFrxDni3vlL6IbSYgp+RYE7xzJvzD/HXdwgFq
         ac5fY37NxsorTvc0yQywSyRg3iA2CWjoKOQ1lzHD2ut6/doBcAgdrTrN00MMt8+lgRnH
         l1uAkmQeGB8vqO04l5WYTSqm5LpyNEEqGnpCRQbXg7L6U9THLHSnJDduVz60C4MiYDEL
         8NXH7LKnPciTG+VqEDt/SwDXBJghfKzS5JNwcGq9TrIEws/Id608YaSfM5qz31fyE3Oj
         IFx9MqtjJK3tQ+IToGC/plDKR0mUqRVFoekfgWpuWc3pvIY5k9+TLt0P1RTSpmTg9Zhl
         4l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nkDpWha0F8QROGymjtiq9TmTXWR4raEqKPpr+Lp1vOU=;
        b=QzKb+pNNwcIBejdUsC1NmbcntisvwCMC6BNxwCgP4rz2MbmRr0EyEKby/TPNQ39USn
         +CbXdOi3B7Vev2w2h/VG+uMSTtichIJpA/yYTLzCvDOS+fftYt/cQJ790ykC5ix0Ok3K
         iJGdR+0CdZG2WnY5A03OVWtlAn8R5hSgQ3MvokJmPo7rgze/2bwg575nqQO09ILUWJU+
         SHC6bhQxhYMXnh1aRAdW/jr0uUNAR051yJrVgdZ1hYTXTtLZjvAD1Qf3GdEzaBZSxJ59
         38k8lOUA1jecyhxCcV1xQ993NUCBMokcTY12m46PUuzlz/l/A2/Ydm9CIaV0cxm6MVMZ
         f0fQ==
X-Gm-Message-State: AOAM531CLtzqkYHACm6aTAVv6QCHyzK8vA601pYskk6vQhuYqzdGbee7
        IJiaiEwtePwBK6tV9RnhBtjv+v2D
X-Google-Smtp-Source: ABdhPJxHNybtoLuEuFSXXsQY78vmJgbc+mJf2TV/1xqPYoJSyLT24pP9OvbmiMOM2SUpTnM3b7fouw==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr678537wrq.11.1596147884412;
        Thu, 30 Jul 2020 15:24:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm10619229wru.47.2020.07.30.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:43 -0700 (PDT)
Message-Id: <1b00524da3c199e833acc8ce400e8ebd332908b0.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:13 +0000
Subject: [PATCH v3 07/20] maintenance: take a lock on the objects directory
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
index b7f64891cd..b57bc7b0ff 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -829,6 +829,25 @@ static int maintenance_run(void)
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
 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
@@ -846,6 +865,7 @@ static int maintenance_run(void)
 		}
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

