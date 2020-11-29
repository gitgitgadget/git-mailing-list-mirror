Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70027C83014
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE32078D
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIRsnKTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgK2HpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK2HpC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:45:02 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D9C061A54
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 64so10808657wra.11
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HAnw3NafiijmKfmnnIszEnLNjmX8+tY7kIWxaN1h+ko=;
        b=vIRsnKTTRSjq1sjNUIRoaT8V3e/kptmdoyTA29180M/Pce4NrTgz653/5vNPIjizzG
         8NJ5zRqVqmtGyrgCgg4yyemtza1cAZIFpFMcKnvnUp2XVdQgzlDF2fUAAUDm7EA4WR8E
         YsEWpc6SzS4y6o9rUe96CuAhCyCYAKK6ojNqxRTOmJqb3qj3Vk+GSw/BbSmsudWh+mSB
         wnqO5TgnbiDmrsgrdjlXocm2M/zpmCjuLy9bLm/5vt04LW1IxOIyTvKYZiODsZsYJbD6
         Od2bfg2jhcRFSgXpf5s+YKhSSzEWsJ0hYROMB2sKJMHBgT+SzJOeREFXlXZn5AzEB2T4
         OOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HAnw3NafiijmKfmnnIszEnLNjmX8+tY7kIWxaN1h+ko=;
        b=SpMHZ6S3JzH8S3v/cnP0wT5J8O/QopwbcKf5f+DpIiISgBXrBxHOkBTcjeAMOXxph9
         1zeb3hlQP5xlAjPAUg/9Us2gu34OYCJnO9/OUyn9wT3bb9D19stWC25dpS1KOJR4Zv9k
         xf+xNPInTjNt2K68DjhT+TnnTUNnGJIeR7ndwobkMLgbeAnyP9vkQUGbvpjL2UfJ0zeN
         Tq97irfxYUlOri7AFnOzw3aWeuFBsvhj9mYgWCDkSc8XwGY/QLAdXurnuo6FCFNg9GuO
         aNLNhElgR2rxixvHG2oGSWvSbZBDjg7H9zEOn6wnwz/iHUtdaG6uRq3WTCGFgkIO3x0Y
         g2Wg==
X-Gm-Message-State: AOAM531Gc+X11hJB/ryrKS1fDsRhtdDQ+zEa3uVmKigPDs5zS33sMeck
        Lk7UmFWcG8LJI7ZPdPf8VCfIyfubqJ0=
X-Google-Smtp-Source: ABdhPJxgl7eMmrus0uSvK90zT++plr40k8UUcRr6PDXRKfp4jLHWlaoVnx/ORs/rS16ybrfwwCBqrg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr20966952wrs.377.1606635818570;
        Sat, 28 Nov 2020 23:43:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm19048289wmh.16.2020.11.28.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:38 -0800 (PST)
Message-Id: <da54fa454a4d966495fd5bb4982457938c285634.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:19 +0000
Subject: [PATCH 16/20] merge-ort: basic outline for merge_switch_to_result()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds a basic implementation for merge_switch_to_result(), though
just in terms of a few new empty functions that will be defined in
subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 65dbdadc5e..1ef32a4053 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -933,13 +933,53 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&dir_metadata.offsets, 0);
 }
 
+static int checkout(struct merge_options *opt,
+		    struct tree *prev,
+		    struct tree *next)
+{
+	die("Not yet implemented.");
+}
+
+static int record_conflicted_index_entries(struct merge_options *opt,
+					   struct index_state *index,
+					   struct strmap *paths,
+					   struct strmap *conflicted)
+{
+	if (strmap_empty(conflicted))
+		return 0;
+
+	die("Not yet implemented.");
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
 			    int update_worktree_and_index,
 			    int display_update_msgs)
 {
-	die("Not yet implemented");
+	assert(opt->priv == NULL);
+	if (result->clean >= 0 && update_worktree_and_index) {
+		struct merge_options_internal *opti = result->priv;
+
+		if (checkout(opt, head, result->tree)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+
+		if (record_conflicted_index_entries(opt, opt->repo->index,
+						    &opti->paths,
+						    &opti->conflicted)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+	}
+
+	if (display_update_msgs) {
+		/* TODO: print out CONFLICT and other informational messages. */
+	}
+
 	merge_finalize(opt, result);
 }
 
-- 
gitgitgadget

