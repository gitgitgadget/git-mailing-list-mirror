Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00FFC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B84AD60E77
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhIHNmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhIHNmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:42:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5059C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:41:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v10so3393078wrd.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2iPLUGTOJY4odLXStPmKukFtdEo+mKLcOyoakKL0eR8=;
        b=CGLRhSps+bcKdEzMO96hfwChOvoag7BuH6a55mz0NoeWvaz9dW6DFj0r6s68sGzMYW
         eJzpXSnZLUTIgrRP9vtej+WctGoRlUFI8I6ITiOnmipNluFQo3mcKJYobiKEvbzxySz4
         QMczjTRVMwNq4GDLSPIPVfTsu/j91vjKjjdnAa8ap3c/7Q1DjSc1Rq/WwJHB/qNcuf9B
         bCfOYUE5b/0+UfRldSXMNw7tcqJu50Dh0MxJIWEzS57/j69nsdbqr4NDS8eMyGbnSNIa
         xox3WqSPjC+1nzkbaZmkdW1f/C8YjBnlJIlFuiYn6ArfdF3vTJ1oQWH5BspIoS2Klt1C
         gFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2iPLUGTOJY4odLXStPmKukFtdEo+mKLcOyoakKL0eR8=;
        b=1J17La1R9wKQnkyMJrhXzoUZRFeFo03ewhG5SNwptYAVLtxqM4hgSwQQRSW0ADzGqD
         YTjNQVcI2DRXxdTZhrIsajl/zsQUk4gvTZc0f5xGij6PX1Rlw3vQpXxzMbtdOH+Y/X8t
         wV5DB0h6R2AVOUWGb8GdmwLXYqBa4J0BFm1jxozocM0Z9dpJj9V/n/g2yA093OPltjQU
         5R75r9PIs0GInJuvmC9JzJViraPG2Nv3Fj6oQKdXvxGbUxl6LkW6DoxoPEJITvQsfCu/
         TCXak/R1MelDmiBvBKzDcCGbVs3m3teYDsSa6Poq0R47exzDnvGqdt9vu5UYJvqM6Md8
         UJHA==
X-Gm-Message-State: AOAM532KGXMNfVQRDbIGWSJYCr2b0FoPKCyDBKWyBrTpmRCnmNOEolTd
        VzpqNJzzoHQS3bKPPXG/vsLkOZZEfU4=
X-Google-Smtp-Source: ABdhPJxhdJ898tNjPAso72mkxfeBWhgBRiMBeY6vYY0oy4rqHAQQI9Ee4SFpq7HjMxeN3POQ+st+ZQ==
X-Received: by 2002:a5d:58ef:: with SMTP id f15mr4310257wrd.160.1631108474423;
        Wed, 08 Sep 2021 06:41:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm2207954wrf.3.2021.09.08.06.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:41:14 -0700 (PDT)
Message-Id: <53cde4825b408e5fb893bbd9a222e7387d69a408.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 13:41:08 +0000
Subject: [PATCH 1/5] sequencer.c: factor out a function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This code is heavily indented and obscures the high level logic within
the loop. Lets move it to its own function before modifying it in the
next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..a248c886c27 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4254,6 +4254,27 @@ static int stopped_at_head(struct repository *r)
 
 }
 
+static int reread_todo_if_changed(struct repository *r,
+				  struct todo_list *todo_list,
+				  struct replay_opts *opts)
+{
+	struct stat st;
+
+	if (stat(get_todo_path(opts), &st)) {
+		return error_errno(_("could not stat '%s'"),
+				   get_todo_path(opts));
+	} else if (match_stat_data(&todo_list->stat, &st)) {
+		/* Reread the todo file if it has changed. */
+		todo_list_release(todo_list);
+		if (read_populate_todo(r, todo_list, opts))
+			return -1; /* message was printed */
+		/* `current` will be incremented on return */
+		todo_list->current = -1;
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
@@ -4433,20 +4454,9 @@ static int pick_commits(struct repository *r,
 							item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
-		} else if (is_rebase_i(opts) && check_todo && !res) {
-			struct stat st;
-
-			if (stat(get_todo_path(opts), &st)) {
-				res = error_errno(_("could not stat '%s'"),
-						  get_todo_path(opts));
-			} else if (match_stat_data(&todo_list->stat, &st)) {
-				/* Reread the todo file if it has changed. */
-				todo_list_release(todo_list);
-				if (read_populate_todo(r, todo_list, opts))
-					res = -1; /* message was printed */
-				/* `current` will be incremented below */
-				todo_list->current = -1;
-			}
+		} else if (is_rebase_i(opts) && check_todo && !res &&
+			   reread_todo_if_changed(r, todo_list, opts)) {
+			return -1;
 		}
 
 		todo_list->current++;
-- 
gitgitgadget

