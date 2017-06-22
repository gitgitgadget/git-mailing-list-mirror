Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D6F1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbdFVSoT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:19 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33315 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdFVSoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:17 -0400
Received: by mail-pg0-f49.google.com with SMTP id f127so11354998pgc.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmfIPAfv0vr0+kyCsY3MODQ6B8FEzgHStnL6mFNEOS4=;
        b=b/Hl6r0ZwlAOp88NvJIxHtgklre8DHoETIDIJ6q0imtMzJYca44sJnltERr/ClX6EW
         mAK/VTz3Bz8PDVaSPDVqD6JqkCifJBctA1ppOpSA0C4gYMLr+Ly4U9/b8FFtAd2m7xQJ
         6IkYa2YR3iQddulIyrHAww/VW9WuoV4pIY4kko4cduU9hQG2wm8MLfbGT8h8IsuGOCYg
         EmuIc7fCfQX2X/fToiLszTTqQS1Vy/drCm14W7FTCX2cDbT+kCtjjTEJtfJf+Ws0MeA3
         AuYQFbfDq6kFH7RuxJPz89MKl8U7D37UIOFKbDqTKYTnM+TyIzxG1obhMYv0zMzaaiXd
         VfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmfIPAfv0vr0+kyCsY3MODQ6B8FEzgHStnL6mFNEOS4=;
        b=LrQwA7yAtPXcmVJ4rqr9V+cGGarMSPRr9ZRMZtjA546/ter5eFmh6zLSYfVmFZzNvl
         BNvahaRDytZZxo4EyWCQtOf7LU8ef81XOK7bTbjuuOe4HmGsscEyoriQzvmFOg43J6Iq
         Zmipsh0BRaDaSMR6XszyNPrE2kAIcIse/+JVZk5aFnxtuhx7iYiSADIORavFfdfWx7/u
         24988yKK6PEvP6ApGZ0E8aZA1FsIGDIBhv4ha4coLf6UPTGjfbSih8Z7+rXV5Q5iB0WJ
         xFxDXYh3pX4zO1GXsO4IiE1pljbc7wIrkG/S5tSfX5+oEW9RHCLEzCgHcCV+NJdDIv5+
         djAQ==
X-Gm-Message-State: AKS2vOwoIlLQGYakuv6V7HacOtSkwmGnjt+o2bDnHCeLrMScdHLVFrgJ
        LXwXgQGc9Ear4GaKDlqXog==
X-Received: by 10.99.104.199 with SMTP id d190mr4077871pgc.185.1498157051209;
        Thu, 22 Jun 2017 11:44:11 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 06/20] environment: store worktree in the_repository
Date:   Thu, 22 Jun 2017 11:43:34 -0700
Message-Id: <20170622184348.56497-7-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'work_tree' to be stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index aa79ef83e..3fd4b1084 100644
--- a/environment.c
+++ b/environment.c
@@ -96,7 +96,6 @@ int ignore_untracked_cache_config;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-static char *work_tree;
 
 static const char *namespace;
 
@@ -223,19 +222,19 @@ void set_git_work_tree(const char *new_work_tree)
 {
 	if (git_work_tree_initialized) {
 		new_work_tree = real_path(new_work_tree);
-		if (strcmp(new_work_tree, work_tree))
+		if (strcmp(new_work_tree, the_repository->worktree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
-			    work_tree, new_work_tree);
+			    the_repository->worktree, new_work_tree);
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = real_pathdup(new_work_tree, 1);
+	repo_set_worktree(the_repository, new_work_tree);
 }
 
 const char *get_git_work_tree(void)
 {
-	return work_tree;
+	return the_repository->worktree;
 }
 
 char *get_object_directory(void)
-- 
2.13.1.704.gde00cce3c-goog

