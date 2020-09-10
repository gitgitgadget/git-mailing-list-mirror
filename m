Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE75C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A92075B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKDtvmrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIJTF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgIJTEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF6C061799
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so625667lfs.13
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnVS8SVkF/VPsWN5tE7dSjuaShxo7UkMgytOJqiyMvM=;
        b=fKDtvmrRZwoWH3z6WU5IbrNSaho5EmXc8olFeUAIogA8d6qOoReL3AGOE7M6s9eIYb
         lD59kjezn7EQnoXz51vdwgIGOB0hB3z4w5DFUcwyZTKShIM4UNoCGhlIk9jpxt36Ot/A
         MlICq8v5xZOyw6laPcnbcA8E2TsM4Im2HCdxB6w8jQHpqFBFaN/sLLK0Z1q6zpPL4gHe
         IVL/oo/NoR5k8wTlbGICIh/wIJaaItv9yocTPNuP7w4tYiEXZ9sVgD7ed/8bhTQXMITs
         Hydbu+D9tnWptrYb/xZ0go5b9s749Zc1JOBNhIpvUERTeZNXKSL50wMcnJt0Uq3o9euc
         ZxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnVS8SVkF/VPsWN5tE7dSjuaShxo7UkMgytOJqiyMvM=;
        b=tL974X5iMIqQwIepdy9umZV/lobj4npcr1muB9nbfZTvUMCSZ0RUYuV9MjnV1N3RHy
         lscmZ2UQ0Gbkf7mhYxCTSFkaiNxu5cjg+jxYFP4c9CsEU57ZoICVfhhNJymJXa4T2Wdc
         kfYdIu4GJlePtIPIyTdKlpHn/05KJMOPw7aLvNI3PXxWVUeWRFResO87z0FsefZ623Qy
         XZoGsoikW8naaQHMnpiJ/5xgVCKac/58xSlVHM0SxfgM1YN/uBVETIZ+tNalj+UpTSad
         FHEqDhW1NUaJEfjcoBQcOwAv060T3OILjAgHWk+k6bFqqJsQ2wS9o3ANzJrBr/cv3BQY
         0eNg==
X-Gm-Message-State: AOAM531fg1VB7pl+OYEgxpzkMhDXHNm3Vl/NDFQI8LC3ohBH5XoFeNfK
        5gOuO6GUCxZRKZhAKWA56QepigDwTGM=
X-Google-Smtp-Source: ABdhPJwKqMrC22brO4mA+oosckNTVl/C6FWqMBgV6+jHjNNedkYmU5C2O4yxRzRfwKVc+2AI+VDpyQ==
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr4870967lfb.98.1599764652243;
        Thu, 10 Sep 2020 12:04:12 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:04:11 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] worktree: use skip_prefix to parse target
Date:   Thu, 10 Sep 2020 21:03:41 +0200
Message-Id: <872dc384c53dac61717639cdeccb44a08d5f024d.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of checking for "refs/heads/" using `starts_with()`, then
skipping past "refs/heads/" using `strlen()`, just use `skip_prefix()`.

In `is_worktree_being_rebased()`, we can adjust the indentation while
we're here and lose a pair of parentheses which isn't needed and which
might even make the reader wonder what they're missing and why that
grouping is there.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/worktree.c b/worktree.c
index a2d0d20564..faac87422c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -364,11 +364,11 @@ int is_worktree_being_rebased(const struct worktree *wt,
 
 	memset(&state, 0, sizeof(state));
 	found_rebase = wt_status_check_rebase(wt, &state) &&
-		((state.rebase_in_progress ||
-		  state.rebase_interactive_in_progress) &&
-		 state.branch &&
-		 starts_with(target, "refs/heads/") &&
-		 !strcmp(state.branch, target + strlen("refs/heads/")));
+		       (state.rebase_in_progress ||
+			state.rebase_interactive_in_progress) &&
+		       state.branch &&
+		       skip_prefix(target, "refs/heads/", &target) &&
+		       !strcmp(state.branch, target);
 	wt_status_state_free_buffers(&state);
 	return found_rebase;
 }
@@ -382,8 +382,8 @@ int is_worktree_being_bisected(const struct worktree *wt,
 	memset(&state, 0, sizeof(state));
 	found_bisect = wt_status_check_bisect(wt, &state) &&
 		       state.branch &&
-		       starts_with(target, "refs/heads/") &&
-		       !strcmp(state.branch, target + strlen("refs/heads/"));
+		       skip_prefix(target, "refs/heads/", &target) &&
+		       !strcmp(state.branch, target);
 	wt_status_state_free_buffers(&state);
 	return found_bisect;
 }
-- 
2.28.0.277.g9b3c35fffd

