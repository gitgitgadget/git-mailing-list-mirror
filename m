Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36450C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124A82250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8DsnpnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHEWIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHEWIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:08:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBA1C061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:08:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z14so11879615ljm.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3LsXQ9b+cfP0m/U6/17TmTy1eO1QlDuLXuobi/FId0=;
        b=G8DsnpnD+3DiESiqD8GuFg6qQXeBxawQ/nVM49L7qvOvAA0KBsX9M1VHTJoQ7PvCpF
         Pu1lSlIvdEdVNjYQJqNTSw0bZhxKE9ckC5b94lu9jQRyUqsqWwmRyGCs65iFrHZne0yb
         gNrWc89zBv9izZrffv54pI6uMNC8hk85ij/G5tYtRlWFkAo79dntuA9IaZRfAsYofGvc
         BWStZWp67Nx5ohtZttRUyC6tpihd0LNhdVqSnn5K2hUgwbmc8oPeOUf6brHEHi0A3JGQ
         IhMffI8g7JONh0o4V9kdFRneJfTRm/12bN12vnE8g+sXHHldaxSc4ZzgrWuNYdmE7xEN
         Ci3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3LsXQ9b+cfP0m/U6/17TmTy1eO1QlDuLXuobi/FId0=;
        b=R4GGsItgKvn6obmHgzMYdT0NdVlFq+8x9RsjMVG/1Wcvzw1fbOm3mhO/XVReLjsAAG
         v76AvJ6dOj0gs90LFDm8uCflcxw8s3hYjHTzCnNlCGyUppMu38zaB2kqnQI0RqdIvIGz
         6MTuB9/i6vvH5kfkiV5NF/2DOmsmK87Z4RhKzsjYIjDj2AYyKP5BTmr+TAUGKWfTKJ9q
         8s7Sxy9NS0lInKL+RbwjBQp9p7gVgxhw2EO09SYoCH8TENhPJEKpyVX1K9Gt6m4bO9Dm
         NKHIK9CJY+U4MtUEYCr+4X36nAnCOr8bD2TK73ogbc11KdD4wLB3Ht2+R4ZMuo9ka7Nv
         eZKw==
X-Gm-Message-State: AOAM531W0m1M7QcYefemULQRHOAcx74cC0/FUyoq18YOgnTmnN0Ppqix
        DrhjROuu4fh9NDpKUz9QC1mdZroM
X-Google-Smtp-Source: ABdhPJy0DspIgktWU8aeXlZmyrBq3aGm8/XFM0ODq7Lu3S4avCCNxXqUjyDUy6W52N07lrK9YRLR9Q==
X-Received: by 2002:a2e:9882:: with SMTP id b2mr2322731ljj.93.1596665329022;
        Wed, 05 Aug 2020 15:08:49 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g18sm1544183ljk.27.2020.08.05.15.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:08:48 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH  1/3] revision: change "--diff-merges" option to require parameter
Date:   Thu,  6 Aug 2020 01:08:30 +0300
Message-Id: <20200805220832.3800-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200805220832.3800-1-sorganov@gmail.com>
References: <20200805220832.3800-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--diff-merges=off is the only accepted form for now, a synonym for
--no-diff-merges.

This patch is a preparation for adding more values, as well as supporting
--diff-merges=<parent>, where <parent> is single parent number to output diff
against.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 669bc856694f..417659cfcb10 100644
--- a/revision.c
+++ b/revision.c
@@ -2323,8 +2323,15 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
 		revs->diffopt.flags.tree_in_recursive = 1;
-	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
+	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else {
+			die(_("unknown value for --diff-merges: %s"), optarg);
+		}
+		return argcount;
 	} else if (!strcmp(arg, "--no-diff-merges")) {
 		revs->ignore_merges = 1;
 	} else if (!strcmp(arg, "-c")) {
-- 
2.20.1

