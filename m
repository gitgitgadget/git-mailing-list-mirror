Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255A91F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeFFRDP (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:15 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:40230 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbeFFRDH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:07 -0400
Received: by mail-lf0-f41.google.com with SMTP id q11-v6so10219442lfc.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/lRsaPDbWp7rHm7lOzW9mislfiK4D625RdT4K3DQDc=;
        b=DZjCYv5BMba9sLnzK08aiQ6+N/3t0ChJGg7yKV42VT8OrXGtu5U6yVEa8UI4lMbhwF
         dmHhNfOp1EPCX7c45TVo7tLHixRDbp3vducSTsgJgL7/V9e+0U/EGVxuq0cVrz0Y1z+n
         A6nwPDa5yU12FX0mRejm9ZLnxZ6hIVkwT8WEZwHnQighBqmvLy5p06v8AgcIVejjAzON
         ssHZPNUrx/9tgSAY6Jmlg59hxje8KCo2NBymkwWP7xe0V2cDceHc49A9pa5wdEQAUbZ2
         OeYtSX4eOWnMHOTOzAWOnDRZA52xK3avGwj2nOdZ49Yk1BpW1TlMrHX8LYoDQ5wH/qWy
         hHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/lRsaPDbWp7rHm7lOzW9mislfiK4D625RdT4K3DQDc=;
        b=J/wGQv4eU/ljse9H7DI00fLb7ZKqkNw+thS7tKiF+/zmuCVW9NABeB31yZq3+HzmzT
         ou4nVzzc7BZOjzvbXuYFaWSvyWDf/U3i40ZmijTgV6RbwCKYEEhDMBj2HeNptAsX37g0
         mL+8j4m27pKixfijVXLkChFv6HGuCrD9SasHob/EyiaawqeZR3IUHeGGVYOOXBA9DzUb
         kWNjGTwq/8gLHMBRwRtsilQaiNb8KXNzXKjLCSir6LrV24oA26tw30nm4zMYqkoRLZNF
         0mYMKG4o1dFNY2M9/oTU/S06PQzQBRr7cglnS8ab70ZJokvdZFNaXHaFDFaZ2Mx1wGc/
         ibwg==
X-Gm-Message-State: APt69E1glvkjPRODMwUb/hqtW2MyzHjvarwdkQtQG70LctmR055pfm/Z
        ZjQ8DnzngMJ2F2Rogul0S6Y=
X-Google-Smtp-Source: ADUXVKKAbPSZ3D5CYFHTaMJry+SG5Yj5BThSkFzfpTFzC5jXQH0OFVwO7tnadV8EZ7nlnU5/IKy5tw==
X-Received: by 2002:a19:d046:: with SMTP id h67-v6mr2341829lfg.52.1528304585984;
        Wed, 06 Jun 2018 10:03:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 13/23] submodule.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:33 +0200
Message-Id: <20180606170243.4169-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
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

