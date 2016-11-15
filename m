Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6802021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964863AbcKOXNL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:13:11 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33877 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbcKOXNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:13:10 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Nov 2016 18:13:10 EST
Received: by mail-pg0-f50.google.com with SMTP id x23so68848101pgx.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cfazcFcARVGbtM7HRAhQsDFZNbkDEfjBj16SQuBRKeY=;
        b=VZEoo1+rMQUG8XwKxjxlyG5UeKd/6LU+/tIQIPSthFsprdRf/ZGEj4ulC1hy5QGxBK
         oy2ZKlvvdF3RyGagKsup/Nd/T8TDVn9DTn/OBQmNBeX+FiFCVv2PVX5QYtE8SXmmydZz
         gx6EyQsG+y/nljjW7qKC0fizDvF5CEdsikzpm+RqTdfCiuBx1pE0JZea0R5Cv1u/NxQU
         t1Di+ab0mwzRnQs+WJU02po5+1do5MHSqZaHA7PkgSVTKZ7ruyvwkWhmbScn/L8YRKUN
         XwyBYiGvE1W+saThdV7vQXu9TcaI6qH50XcBFtRmaw4zc8RwrCHk99bJzeVj/NkMSlSQ
         Ux6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cfazcFcARVGbtM7HRAhQsDFZNbkDEfjBj16SQuBRKeY=;
        b=Dy2J0dcUWpQCFV2iE8HJh9z0i2+yuvIZ7WafqvvLUjCtxee63N8yPSDHpwBo86FZ72
         kx9cQeC6WCL+/XLNb8FXu1h+k9EktUO5J/1U2YsX1k6pPE7mf1PYhBrIx2mT+egyEzcP
         K73GrAGCLPdVRWPcFfiyg6MmDEXobnXsLGBUeOoxs+A7kFPR9wn/r9XwM1iNs8bedwYh
         socg2wa0Wpg9V+LoalVOVyaQsOqrjEWBfs9oTMGqUjzFbL8wPUYXPIxVWI99uOoIJW0O
         lhx8RxvKxBXQcgYXbpJOkpY4eUrdCDrbaKAzgdwPNiT+LmINE+7OCkLjcBoQ4D+cauS8
         KvJw==
X-Gm-Message-State: ABUngve+eummosEuFUTAWJQEBC/Mgm0XpxOBRltpEmo51kdtqmLW0551q9M/mY4Sp26H/eSf
X-Received: by 10.99.109.6 with SMTP id i6mr1138037pgc.139.1479251218571;
        Tue, 15 Nov 2016 15:06:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id m19sm13647426pfi.24.2016.11.15.15.06.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:06:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/16] submodule: use absolute path for computing relative path connecting
Date:   Tue, 15 Nov 2016 15:06:38 -0800
Message-Id: <20161115230651.23953-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This addresses a similar concern as in f8eaa0ba98b (submodule--helper,
module_clone: always operate on absolute paths, 2016-03-31)

When computing the relative path from one to another location, we
need to provide both locations as absolute paths to make sure the
computation of the relative path is correct.

While at it, change `real_work_tree` to be non const as we own
the memory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 53a6dbb..c9d22e5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1221,23 +1221,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 {
 	struct strbuf file_name = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	const char *real_work_tree = xstrdup(real_path(work_tree));
+	char *real_git_dir = xstrdup(real_path(git_dir));
+	char *real_work_tree = xstrdup(real_path(work_tree));
 
 	/* Update gitfile */
 	strbuf_addf(&file_name, "%s/.git", work_tree);
 	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, real_work_tree, &rel_path));
+		   relative_path(real_git_dir, real_work_tree, &rel_path));
 
 	/* Update core.worktree setting */
 	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
+	strbuf_addf(&file_name, "%s/config", real_git_dir);
 	git_config_set_in_file(file_name.buf, "core.worktree",
-			       relative_path(real_work_tree, git_dir,
+			       relative_path(real_work_tree, real_git_dir,
 					     &rel_path));
 
 	strbuf_release(&file_name);
 	strbuf_release(&rel_path);
-	free((void *)real_work_tree);
+	free(real_work_tree);
+	free(real_git_dir);
 }
 
 int parallel_submodules(void)
-- 
2.10.1.469.g00a8914

