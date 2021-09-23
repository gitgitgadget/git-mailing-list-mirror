Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC53AC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9319661152
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbhIWKc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhIWKcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC465C0613CF
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so15810533wrq.4
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQWrYLzj2d5GeGu3YE80um1v+yox8KcuyVEL+NubuHw=;
        b=YsKDAkANmwmOnc+x9hJeeJtA0i1uPgRsY1FYLj5hmPXQsCYySb2OqDDiZyhkvfE19H
         ypC8yP2KyN8qv5D6c2FwBHeGcEEFIphTDNTCUOvja3SSv3+E27wQ839I0ZZDOYOhr3Qp
         exzhGMd0NYGFMmpP/dJmvWwHD71URIGMm6u2jiVTHMLupUpIdGP1IRzTZTpSwhjllDcM
         Avihvpto1jotmokPGjtfcJnvrnKGdo+FkLekh9t6/tKjl05cRg6Xwc6B0uVRpM7Q8AcO
         Zaugh3BWzF1bim8cxUY1cO7HWRaTCCTPn8qm7arwpz5tmlccv3XIQM4ZNWmXmClkbrON
         rFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQWrYLzj2d5GeGu3YE80um1v+yox8KcuyVEL+NubuHw=;
        b=5o6EOE9qGrVP2Y1BelORXv4n0+oeFhJOQCtaj7FMG3DilWotg5KITtn5Gem/C/1UMG
         RANPAi63DhWJjgn054R3oOy5Fm6L7b3Oc9e/e4p6v2+wnZ88b3abaSVuREetRNgdUNNN
         r5qidF/ZsrYmU6i+XuQ4mSZPSb5ZlgM2cfqt0HRoZz/wvh0Cu2vOyW6CQrl8Oj47GxXQ
         2yVZ4bfC/+oqKytEN7gNwO6k2s0+2Fsx2BSyPSjfEjLrYj86o0qcbSPbVcIDh6mFj79i
         bjMSbfbKL8vdb2c7i0NABgAVS31AxbEVEnSDb6qyv+KrLe0nVnbvFX7bXyFoVtqySmxk
         8xRA==
X-Gm-Message-State: AOAM533YNST0O0UETvNOPofp8/W8tavfIkeNjDLg8Sa/UR8oiBkYW9rU
        F8HVrac5Cq4dt2mHP9Hf6ZbIA9Ga3zb3xg==
X-Google-Smtp-Source: ABdhPJwsMDfTT0RMmoQzs1OrLIRxtedbrF7XR7w8va2ZQdTpQrurL/0XJfLQHlLoDQrRXWdLEr9ynA==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr14941472wmo.39.1632393076237;
        Thu, 23 Sep 2021 03:31:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] hook.c users: use "hook_exists()" instead of "find_hook()"
Date:   Thu, 23 Sep 2021 12:30:02 +0200
Message-Id: <patch-7.8-b61130dee5b-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new hook_exists() function instead of find_hook() where the
latter was called in boolean contexts. This make subsequent changes in
a series where we further refactor the hook API clearer, as we won't
conflate wanting to get the path of the hook with checking for its
existence.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 2 +-
 builtin/merge.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 sequencer.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5359d961d22..883c16256c8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1052,7 +1052,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/merge.c b/builtin/merge.c
index fe664f6a863..956b6259f21 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -849,7 +849,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit"))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3895aec622..25cc0c907e1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
diff --git a/sequencer.c b/sequencer.c
index 8ee6c4ac240..e501945796d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1460,7 +1460,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
-- 
2.33.0.1229.g0a86d28df49

