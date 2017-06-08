Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC3E1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdFHXlm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:42 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34395 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdFHXla (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:30 -0400
Received: by mail-pg0-f49.google.com with SMTP id v18so20713048pgb.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N2ClxUXSNY1KKprvCjH3C3T/n96ObQJioh7lqQF21fc=;
        b=tGfsYhSeJuIDc4S/ca3GFWS0nm93mzTlmIALPTEfZrzlb2kQCq9PYMpISh9KLNfA39
         f4ygRaLinZ78TGzx3ELyUYr5N/BfERhTOP+yVtvKKBH3uiOk2YJuVSk0qpDO+d4wN2Je
         RnRcimJAS6Crl8+HavWvPNusxOQx48gU0o4252koAloQlFz173DgvB4M137xqRVLP4Sj
         REF9WDR7RHIwROTE3iuOsCgS15iT97kwUoDMNgR2uf9q/ikNaB/LUDi+3Rvf+FUhuCDF
         eQ2mGCdL09Xrt9f/toEaY8bSRkGvsE0qLJPEHnNd68ng1FEvMwyW741+Jdh7B2eeqYjF
         VcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N2ClxUXSNY1KKprvCjH3C3T/n96ObQJioh7lqQF21fc=;
        b=XSBU83p/pIH5KtnAHkgeXmkeHrBWq0gnX9YHq79p8PZ+UhIglG2lBFvxVCRZj6VP/8
         jVXyE/T4NNIfET9Um+YZar9So0HIclbg+bQpDrRwwckKPwERLVcnHY3+czA7iaCKasOD
         z4yDR+YPWc5sK1hvJI/bRw6h6eWyR4PPpzkCEK3iBuud8ryN9A77sqVxrsEaDElpatsA
         WZJ7UwLU30MeC4AWZLHu2C3WYfn7+ys/pK1xfZKbP3wAzn+tZxowr4AGWMN4T2zchpvX
         Ep2rNBqkWWjrI+OOGnKII8zO1MtvaZwGy3M6dmNvGHNe2NJz547NAtf2J009FE2UL25m
         CTFA==
X-Gm-Message-State: AODbwcAMDt8ZnWfLadUbrTYinLfpwbhg1C2F2K7JmUzPhRICPDexTBmv
        12svHJn4DJ/D5x99sPesxQ==
X-Received: by 10.84.232.130 with SMTP id i2mr37723532plk.251.1496965288216;
        Thu, 08 Jun 2017 16:41:28 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:27 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 09/32] environment: store worktree in the_repository
Date:   Thu,  8 Jun 2017 16:40:37 -0700
Message-Id: <20170608234100.188529-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate 'work_tree' to be stored in 'the_repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 environment.c |  9 ++++-----
 repository.c  | 12 ++++++++++++
 repository.h  |  3 +++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index fb52c0daf..e390a6627 100644
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
diff --git a/repository.c b/repository.c
index e952238d1..1b48cc816 100644
--- a/repository.c
+++ b/repository.c
@@ -104,6 +104,16 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	return ret;
 }
 
+void repo_set_worktree(struct repository *repo, const char *path)
+{
+	repo->worktree = real_pathdup(path, 1);
+}
+
+char *repo_worktree_path(struct repository *repo, const char *path)
+{
+	return xstrfmt("%s/%s", repo->worktree, path);
+}
+
 static int verify_repo_format(struct repository_format *format,
 			      const char *commondir)
 {
@@ -166,6 +176,8 @@ static void repo_clear_env(struct repository *repo)
 void repo_clear(struct repository *repo)
 {
 	repo_clear_env(repo);
+	free(repo->worktree);
+	repo->worktree = NULL;
 
 	memset(repo, 0, sizeof(*repo));
 }
diff --git a/repository.h b/repository.h
index 174ab0f2d..a1163ae91 100644
--- a/repository.h
+++ b/repository.h
@@ -9,6 +9,7 @@ struct repository {
 	char *index_file;
 	char *graft_file;
 	char *namespace;
+	char *worktree;
 
 	/* Configurations */
 	unsigned ignore_env:1;
@@ -19,6 +20,8 @@ struct repository {
 extern struct repository *the_repository;
 
 extern void repo_set_gitdir(struct repository *repo, const char *path);
+extern void repo_set_worktree(struct repository *repo, const char *path);
+extern char *repo_worktree_path(struct repository *repo, const char *path);
 extern int repo_init(struct repository *repo, const char *path);
 extern void repo_clear(struct repository *repo);
 
-- 
2.13.1.508.gb3defc5cc-goog

