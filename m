Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A5E1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdEaVou (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:50 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33411 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdEaVop (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so18618068pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rpL9keHeye2gXI/3BxxWlGA/mFlNcybysBYpSZvIm0Q=;
        b=pK9/tqOCLxZEWJ0UtSPJYyEvYbAWm/xB4MyMQpSbB57TVv9GgPg42c1N6nWYsarLY0
         lHJQ0WUyfnr09pTx2xAVDNllxbHFkiufeBHcIs0+1sVlvCEMNHSfoO3czMEA2HWIjcdm
         TuPGKLJDLcYRtAqEAlKZOXu2/E3aHLV1A8XlFBXJQjWvqANkNGbxhhQxrYCjBhws9QRA
         lNPk7/Fjtd5Jfj64WLG9jhDQHh5j0+IFtUr/7p9kxMJ+vpgg4ozBuJz0yraD5B17kWlK
         EGaRf397p1pB1QEIfiE3qKTsW8WBMG9C9egxPCQg4TAR08nzHdYCI5DFtUvgPlGz1KL4
         mPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rpL9keHeye2gXI/3BxxWlGA/mFlNcybysBYpSZvIm0Q=;
        b=dRiYjuBgAS/M/0ehKdXhSYSNoRox0mhE3S/JRUDXFz6kKo0MStWIZRC/F9CQbzdJ9Z
         gwmvzzh4Uq5Jv6VaFUw31pdyAcNdgJURi7AedtQWGIXD06zMES5Er57maG1Bb/NHbnoa
         id0qSU0y5tibetBqwrgcsrmpSRPuAI/rd8KK82oarLi8LexdBG6nBpcBRwKuAiRikqEw
         VuYodpldi0o7hgQRBCX372FKmPUKzyPweMW23cj9kUhEzQJfrvOG6Ruy05C2MUH4/0+v
         OlwGKgyuvddCAoqjOKxuGJfyWOj6ucsd+HcDlJ1tBeJj8kXTikAVnuS5o0S+2fVAinUP
         cnLQ==
X-Gm-Message-State: AODbwcAhL9taqL2YY31gJiOlHRFX9P0PPmn2ExcbbbptT7w1xIOtZK7K
        VLiukoSCWwVZGLfM
X-Received: by 10.84.174.193 with SMTP id r59mr44293486plb.34.1496267084596;
        Wed, 31 May 2017 14:44:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/31] environment: store worktree in the_repository
Date:   Wed, 31 May 2017 14:43:54 -0700
Message-Id: <20170531214417.38857-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'work_tree' to be stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c | 9 ++++-----
 repo.c        | 7 +++++++
 repo.h        | 2 ++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index a0519f4f3..2722ebb9f 100644
--- a/environment.c
+++ b/environment.c
@@ -96,7 +96,6 @@ int ignore_untracked_cache_config;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
-static char *work_tree;
 
 static const char *super_prefix;
 
@@ -220,19 +219,19 @@ void set_git_work_tree(const char *new_work_tree)
 {
 	if (git_work_tree_initialized) {
 		new_work_tree = real_path(new_work_tree);
-		if (strcmp(new_work_tree, work_tree))
+		if (strcmp(new_work_tree, the_repository.worktree))
 			die("internal error: work tree has already been set\n"
 			    "Current worktree: %s\nNew worktree: %s",
-			    work_tree, new_work_tree);
+			    the_repository.worktree, new_work_tree);
 		return;
 	}
 	git_work_tree_initialized = 1;
-	work_tree = real_pathdup(new_work_tree, 1);
+	repo_set_worktree(&the_repository, new_work_tree);
 }
 
 const char *get_git_work_tree(void)
 {
-	return work_tree;
+	return the_repository.worktree;
 }
 
 char *get_object_directory(void)
diff --git a/repo.c b/repo.c
index f7c3617a9..789ffdd78 100644
--- a/repo.c
+++ b/repo.c
@@ -84,6 +84,11 @@ void repo_set_gitdir(struct repo *repo, const char *path)
 	repo_setup_env(repo);
 }
 
+void repo_set_worktree(struct repo *repo, const char *path)
+{
+	repo->worktree = real_pathdup(path, 1);
+}
+
 int repo_init(struct repo *repo, const char *gitdir)
 {
 	int error = 0;
@@ -121,4 +126,6 @@ int repo_init(struct repo *repo, const char *gitdir)
 void repo_clear(struct repo *repo)
 {
 	repo_clear_env(repo);
+	free(repo->worktree);
+	repo->worktree = NULL;
 }
diff --git a/repo.h b/repo.h
index 453049e67..95d021049 100644
--- a/repo.h
+++ b/repo.h
@@ -9,6 +9,7 @@ struct repo {
 	char *index_file;
 	char *graft_file;
 	char *namespace;
+	char *worktree;
 
 	/* Configurations */
 	unsigned ignore_env:1;
@@ -19,6 +20,7 @@ struct repo {
 extern struct repo the_repository;
 
 extern void repo_set_gitdir(struct repo *repo, const char *path);
+extern void repo_set_worktree(struct repo *repo, const char *path);
 extern int repo_init(struct repo *repo, const char *path);
 extern void repo_clear(struct repo *repo);
 
-- 
2.13.0.506.g27d5fe0cd-goog

