Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68484C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADE2611BF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhIIJsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhIIJsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:48:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E1EC061757
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:47:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q26so1630364wrc.7
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=No0m+FC8vTeDAjRvJpQi7E/Q85MXPRqDHqXhZ+8Yp1Q=;
        b=jfxLwPEQ40gUU7k/Pnm4B/hmRbBT8uclPUmN1bKK905pxaoJiLSOGUL3hREAoLmXfT
         Hafm4hQ2ZGCGZKNIYmueBSzHiw1T4EAetz8s1HTlvPyfYcZ7k+O7ycCmsUgcVIQTCQZd
         F92fuAc0kqgpQ3k3Ucjs3Bfkeqr4GmL1qF8v/dzQxHcPPiOqMgpkhlu3kQOigtBcELvw
         vqIMk2h3HIcVJr006iB9GeOcezXlmcEbe+N0d4bjeMplDD9fyMOaIi8hfEBQmY677TVH
         P2RnBxtKfKoWtN3kp2s7CvcoiTuy6GfXzZSY8s9iHN6VR7Bw6bjL6XpSiUvgtZtkPhzW
         8zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=No0m+FC8vTeDAjRvJpQi7E/Q85MXPRqDHqXhZ+8Yp1Q=;
        b=O1nF75Bbvuh641zvmMr91QQDot7WsUV/Q6AgwL9PO1RnDBu5jbAJSd+p22kPFuMkBt
         c3brcvaEeTagP+udPBVwgwZmr8mWnB79bDGuO9/5lSl5JE2S/6gXInYL1kkCpAP1/rYU
         BsOydrt2MXooUT4Z+gj7MHm9EWD7HwOaUkA0StDvStr/opjRRjjR9LlEa3x2OLrRqE2w
         970p5dp3NZwkiYu+FCRoLwfiBcEnZxA8B32pTfVdmtJfmy7G86ANKrRsn/EBf3zD7FUS
         ujdb7RA40wa2cbe7DYy0u0YVr3YvYWyK/p7wNjQ7GjCBuSlechuCIqJpT7dKxZG10SQc
         3sMw==
X-Gm-Message-State: AOAM531H2zDDKr8tS8DkG39siEKpZ5EnarhyFuNXRUEYwIso6kGBcHXe
        a/wbuD8Qp3vR2hUdgZr/kxdGMLOMHC8=
X-Google-Smtp-Source: ABdhPJyDHW4kKAubpjYK4bj+v0DrLlZ8aemGhm7e6Y6Ke6XjoE6uEqzOmt+c3hAPDssw8gCUGLgCQg==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr2516817wrz.139.1631180832415;
        Thu, 09 Sep 2021 02:47:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm1292542wmk.2.2021.09.09.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:47:12 -0700 (PDT)
Message-Id: <990d4ca934862845429506583b73bc2fd4ad2405.1631180828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
References: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 09:47:07 +0000
Subject: [PATCH 3/4] run_auto_maintenance(): implicitly close the object store
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Before spawning the auto maintenance, we need to make sure that we
release all open file handles to all the `.pack` files (and MIDX files
and commit-graph files and...) so that the maintenance process has the
freedom to delete those files.

So far, we did this manually every time before calling
`run_auto_maintenance()`. With the new `close_object_store` flag, we can
do that implicitly in that function, which is more robust because future
callers won't be able to forget to close the object store.

Note: this changes behavior slightly, as we previously _always_ closed
the object store, but now we only close the object store when actually
running the auto maintenance. In practice, this should not matter (if
anything, it might speed up operations where auto maintenance is
disabled).

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c     | 1 -
 builtin/fetch.c  | 2 --
 builtin/merge.c  | 1 -
 builtin/rebase.c | 1 -
 run-command.c    | 1 +
 5 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0c2ad96b70e..f239e4ddde0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1848,7 +1848,6 @@ next:
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		close_object_store(the_repository->objects);
 		run_auto_maintenance(state->quiet);
 	}
 }
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 25740c13df1..c9ac8664e18 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2133,8 +2133,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 					     NULL);
 	}
 
-	close_object_store(the_repository->objects);
-
 	if (enable_auto_gc)
 		run_auto_maintenance(verbosity < 0);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 22f23990b37..e4994e369af 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -469,7 +469,6 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			close_object_store(the_repository->objects);
 			run_auto_maintenance(verbosity < 0);
 		}
 	}
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 33e09619005..ba09ebb9e66 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -740,7 +740,6 @@ static int finish_rebase(struct rebase_options *opts)
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 	unlink(git_path_auto_merge(the_repository));
 	apply_autostash(state_dir_path("autostash", opts));
-	close_object_store(the_repository->objects);
 	/*
 	 * We ignore errors in 'git maintenance run --auto', since the
 	 * user should see them.
diff --git a/run-command.c b/run-command.c
index e2dc6243774..229bdff9971 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1891,6 +1891,7 @@ int run_auto_maintenance(int quiet)
 		return 0;
 
 	maint.git_cmd = 1;
+	maint.close_object_store = 1;
 	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
 
-- 
gitgitgadget

