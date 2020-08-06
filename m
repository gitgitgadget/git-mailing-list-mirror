Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA55C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5F8221E2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP6xkdpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgHFR4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgHFQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255ABC002144
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so39385341wrs.8
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ieFpWj9cIIdQEgz9tTei7UAmyp4BbdrmUtoTOZ5t5X0=;
        b=gP6xkdpCeDGqCbeplSvNM9o+Kwz6W0bBcydRQVZY5Lt3IrwxjfFlVH5R/awUZksnBy
         uogQKVAJ3CUQ/llmtgHW3/zp9Obu12FZUNmqNMNJvLxS2fvyiCoONect/Pzq7YKSFmaD
         rKLWTjO5h2RCOx+13hl/t69F6tymuJ65Qrjlp+J/R90LPMKaRa8TKJ+R2Ro3Yl8xKXZK
         GMO5U53x34EI3608YBH/y/ZLkZo1QMb6FLLmp5IvHBZg7furj14bqOwNh2CZ50iVzCrQ
         sj4hpbIza0w5YHX6U0J5cDQ94GRuzGe30LumKuFbPFbzVhxBw5MVSDPkUZJs+fz6fYRT
         /pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ieFpWj9cIIdQEgz9tTei7UAmyp4BbdrmUtoTOZ5t5X0=;
        b=dTLpiE+3s3q9Ntlbzj89TBng+xmXAr4fE35CSt7mK4vH0G853ak93qYY6e3es8sQcC
         x9ix8/v/PHDRMVnIUx06Ez9Uy/Jxu9OsQt4/MfSm/XRCT+nAj2GGooIJfGTDuQyZD9Ui
         s12kFGma5r+FcscT2qDFSjdSy5gobsFai2Jfu1xLHVy7cbKVm63ySs9o/hD6uTeeaet1
         ooHXY3EY3reVuau2T1iMGaBX34jgf5nKMLc1E2vczSjfTwI9F268DRyMSGgdfHd9Ftc3
         46jLUNa6Y/X6C8UAD87Y8OiqUYynJvpWaeLkGToPIYJ1V1mAAHEIiBZYBGk7zcJxnCmW
         vsYg==
X-Gm-Message-State: AOAM531l4bg6YT/HmuJs01nhHOYbbmX+T9cOOCImTIdWwiscQ1KykdCf
        comeRUkTV2gqDi3+yzXinWhL0B/D
X-Google-Smtp-Source: ABdhPJy1OsA4K1NBEiQOfZb74c++x9wWQo/OFnKv4TObSJTJ1f1oxQy+lxlVGM5hT50+eJbzownWqw==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr7905183wrc.257.1596728929745;
        Thu, 06 Aug 2020 08:48:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm6978500wru.55.2020.08.06.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:49 -0700 (PDT)
Message-Id: <79af39be13701267a094362032cbdfa13aa6a6f1.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:37 +0000
Subject: [PATCH 07/11] maintenance: take a lock on the objects directory
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
index 3d50ab7ac9..1b7d502b87 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -830,6 +830,25 @@ static int maintenance_run(struct maintenance_opts *opts)
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
+			error(_("lock file '%s' exists, skipping maintenance"),
+			      lock_path);
+		free(lock_path);
+		return 0;
+	}
+	free(lock_path);
 
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected;
@@ -850,6 +869,7 @@ static int maintenance_run(struct maintenance_opts *opts)
 		}
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

