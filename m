Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D93FC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43045207DF
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 11:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flngUgcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgH1LWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgH1LFm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 07:05:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12041C06121B
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 04:05:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v12so813605ljc.10
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGNqsiF9wPZYiM5+DmXneypw0EWpY8Nvxe7kion2aW4=;
        b=flngUgcx4ORPT7FzUcO4q6KhQaYMe3VBaJz9V7JJ/lSx+iLzMHuTrS+oxYp0P/nEfp
         E1ck32oBT6yABxlGFljx45zNPD4H6i8ef2dMMl0ahwNFvGcqd0KgZL0NfGroK6W3PugK
         hHZV0eRShLrksuCX1t2UvJv6i30SzQqDZEqnU+oLG75kYt/O+savrOW4rahK8A17ZIER
         xXCqqOmWvuha7Vl3Xf00U06NEUbcX06SzuwzeoLLa5hroGr8tBPw+dZv9v7PkpjDGQ1X
         2fPorv+jwbD+LrcPs9mRGpFpkgKSIGTMz7rM6L8FW17rNqippL2FB9lwCQZ6xWF+6vbW
         aKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGNqsiF9wPZYiM5+DmXneypw0EWpY8Nvxe7kion2aW4=;
        b=lgQYyaMbm9akC6/3K/GvRjnjVK0fxipZsgi36eCJtgCbL2ivYG6iBryLlHvM404pGt
         BfNVnxKCZDFqjfcnVL9TV4U4J/WVmF+3vrQy9HO+iMmzlFmbWCDGA0T7YH7sBgDKceJ3
         C4Xuz1Xf0AEYMBZXhHDJLcAV0CrK6IptOKppwFjLpKUYmPwd53ClC6HlBzRnYmhGIwgj
         7jgdQgmZDD3DzCsOPJJYGXyCy0lbs5jN764fLSCvXOx/nJz04iI6KgCFHDAa/InFvB8O
         DawwF+FDuCCoJB7fxqC3GdcG1sF+VC7cO9dRCDW2XjdABFMWo0WDn8cw37myx66sOjmM
         J1qQ==
X-Gm-Message-State: AOAM531bm+KGFx5gdDKFbAe86YVfkXOFVlpoSw3PS1c3BO/swHrcDI17
        6G5uGoKR0OM4UZEAMdQluOU=
X-Google-Smtp-Source: ABdhPJztfN4FBG1yJmLr4g0rEO269ybFskFBilXrhZeOzUhAQ9qk44swxSe8rV/6SgLZTw5bzyGevw==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr669899ljn.252.1598612739379;
        Fri, 28 Aug 2020 04:05:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e21sm218707lfc.97.2020.08.28.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:05:38 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 1/2] log_tree_diff: get rid of code duplication for first_parent_only
Date:   Fri, 28 Aug 2020 14:05:25 +0300
Message-Id: <20200828110526.21145-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828110526.21145-1-sorganov@gmail.com>
References: <20200828110526.21145-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Handle first_parent_only by breaking from generic loop early
rather than by duplicating (part of) the loop body.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 log-tree.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 55a68d0c6101..c01932fa72bf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -922,21 +922,10 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			return 0;
 		else if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
-		else if (opt->first_parent_only) {
-			/*
-			 * Generate merge log entry only for the first
-			 * parent, showing summary diff of the others
-			 * we merged _in_.
-			 */
-			parse_commit_or_die(parents->item);
-			diff_tree_oid(get_commit_tree_oid(parents->item),
-				      oid, "", &opt->diffopt);
-			log_tree_diff_flush(opt);
-			return !opt->loginfo;
+		else if (!opt->first_parent_only) {
+			/* If we show multiple diffs, show the parent info */
+			log->parent = parents->item;
 		}
-
-		/* If we show individual diffs, show the parent info */
-		log->parent = parents->item;
 	}
 
 	showed_log = 0;
@@ -952,7 +941,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
-		if (!parents)
+		if (!parents || opt->first_parent_only)
 			break;
 		log->parent = parents->item;
 		opt->loginfo = log;
-- 
2.25.1

