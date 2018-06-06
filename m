Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96161F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbeFFHke (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46097 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932122AbeFFHkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id j13-v6so7537106lfb.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/lRsaPDbWp7rHm7lOzW9mislfiK4D625RdT4K3DQDc=;
        b=rqBLbp5CmNg2SqezgkbVq6913H+k/tFCcggmSs9xVcghBFiOUsL1tVHuFa7htTzfoI
         ABJ46rX4YyLwQWBRDzKxqq4vaFS7OY69X56vnX81Qb18CwCzNzixRZf/YQfd0VoRmwa5
         +0mfuEU9w8sJ98UwvmQaOO0yAXWqJrRMvB4Rw/duDmVRpVEMcOKLnDPl4noYMvD4qkf0
         /zi6VLZcHES+F/fetb1FwQd8VSIABTLemAd2uV7x8zWNUSN0D+UQHsZkcdOssHqxKob2
         evszPRsCO4DwAGEkfOnE9y0C4tTbyOZOUghcl2oizTB3ioud2WjHTcBAOZYrykQEzbLA
         oHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/lRsaPDbWp7rHm7lOzW9mislfiK4D625RdT4K3DQDc=;
        b=otG6EgYj4xs3tMWxwFwAI8Z+yeT4GzoK1tuP2+8NIMylTx2maPt0RmBXVICDO2G8GV
         MsQtOnZ2qOMdQrY5QCh7ahGm5vdUYdS4VpXJHbm0wazXBNTYto7NPW6QGEoq97YOF0C5
         ulYgR8ZLDmv1K7hKBTqS3JGm5YR+qaHvTRe9Q2OSIY82Au4wXPKMVGGcN0gKslYLEqvy
         YDiaTkYD/5bPiBcO+cOm/btVQBAYrGzGkNyb9Lbt4vURNyVHQdIgsLi91lf8wD2TC35L
         IWsdHCmaDhWocz+SUztdsfyVZIZjQv5Vu6IZLp3mhZzYhO6B+pSkPeNG3nHR4cHjVWA4
         6O+w==
X-Gm-Message-State: APt69E2/SEINRL9GczfnUZ5MJpvqQ4scFNrp6sTa1aXFJASTex6rhXCk
        uH605A1fGDz/NkkR0jnfYzI=
X-Google-Smtp-Source: ADUXVKJLgjpk5FY2sBKK29qfYFSFI1LmIC42mLtvb0kW6VU97aHzvGxR/4aMCpcX53FtCSRma+/7vg==
X-Received: by 2002:a19:8fc7:: with SMTP id s68-v6mr1075899lfk.2.1528270799606;
        Wed, 06 Jun 2018 00:39:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 13/20] submodule.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 09:39:26 +0200
Message-Id: <20180606073933.14755-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 955560bdbb..3aed76e3ee 100644
--- a/submodule.c
+++ b/submodule.c
@@ -93,7 +93,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (is_gitmodules_unmerged(&the_index))
+	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(the_repository, &null_oid, oldpath);
@@ -127,7 +127,7 @@ int remove_path_from_gitmodules(const char *path)
 	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules */
 		return -1;
 
-	if (is_gitmodules_unmerged(&the_index))
+	if (is_gitmodules_unmerged(the_repository->index))
 		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
 
 	submodule = submodule_from_path(the_repository, &null_oid, path);
@@ -188,7 +188,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 		if (ignore)
 			handle_ignore_submodules_arg(diffopt, ignore);
-		else if (is_gitmodules_unmerged(&the_index))
+		else if (is_gitmodules_unmerged(the_repository->index))
 			diffopt->flags.ignore_submodules = 1;
 	}
 }
@@ -258,7 +258,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 		}
 
 		parse_pathspec(&ps, 0, 0, NULL, args.argv);
-		ret = match_pathspec(&the_index, &ps, path, strlen(path), 0, NULL, 1);
+		ret = match_pathspec(repo->index, &ps, path, strlen(path), 0, NULL, 1);
 
 		argv_array_clear(&args);
 		clear_pathspec(&ps);
-- 
2.18.0.rc0.333.g22e6ee6cdf

