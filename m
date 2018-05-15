Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CE41F406
	for <e@80x24.org>; Tue, 15 May 2018 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeEOXnZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:43:25 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36038 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeEOXmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:49 -0400
Received: by mail-pf0-f178.google.com with SMTP id w129-v6so824132pfd.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IGNKc+U8ooYAMzwTfvqzezxTepsaHK+HwOEFoRei/C0=;
        b=muYnT+pt6i96pBM3rYEERPT/H9FcUfjeKJjCT++twgNGTJS09tuZmmLWtBJ+Ct00KV
         z3DI0qPmFFOOnB/pMUo+4TklaSSt68PwJY3Xiv1WDNkinx0Z0N8+W0wuRz7ihpaxWhM/
         oksfqRIUMVgu3FdPAafZ1BwA0RkP4lTyjAc1icKPRup/NdyNJSkCyQb5lOPxWhhBiIIk
         rEjMDflZioUSKuAV+JvDPYKpLCPJ+QzcyxkGAE8zX1mK9PMSOlZyPuLKg8COLU/QLKzW
         pIaA+gD95aI4dG+Fob8qEotPhHmoY9XJarh3lx8YRumEbTp7j9QkSeV3SM2+CJi/7nLt
         ggOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IGNKc+U8ooYAMzwTfvqzezxTepsaHK+HwOEFoRei/C0=;
        b=Sevvwt+yfszHcwSA243H3tASe96+dCj2Z6oYqTmD/sHjue9F9iWKhvOspuIvJJn8Ff
         k+qAurZpkoB9bis0h9EBLBUjqik4xYpFOFXYNRRgAhN6ARrA+j2Lkozw9csOXVqxXTPR
         iM7Wqf7U45y1SHe1bE6Yeaevj/YyWdLkmBVDloGBDinN5TuzN31jZs3qzvbXvx8JwlFS
         g64KFkJB4xSrx5rTRxqVW62qa0hH79bF4F8W3HdNWsmYOkgLmbvfBeZGotbStWCK5UdY
         TDdyTp1a8hHNPR8pKv9PszzCpQQxePiKnjDTvT2tAM/jJPrCIcX9AJB9HoY6X+p9mWMC
         JYlQ==
X-Gm-Message-State: ALKqPwe/bicwoWzzKIMHKVXqCiuPgm55aEEjgpYsUsc2AHfwXnp7DzBl
        dZ8ef2i3t0Fqwo0SGUWMrvAT3M+BBYg=
X-Google-Smtp-Source: AB8JxZo+QqVe1F+RqYWksiZtXO/rIGVA6N5iFE9lKcboerjSRQ7EY/2H6CVyXGD8ktbb0yTDPlebQQ==
X-Received: by 2002:a65:6310:: with SMTP id g16-v6mr4601244pgv.135.1526427767796;
        Tue, 15 May 2018 16:42:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x2-v6sm1583140pfk.113.2018.05.15.16.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/19] shallow: add repository argument to set_alternate_shallow_file
Date:   Tue, 15 May 2018 16:42:22 -0700
Message-Id: <20180515234233.143708-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.h      | 3 ++-
 environment.c | 2 +-
 git.c         | 2 +-
 shallow.c     | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.h b/commit.h
index f6746125766..f88c854e2f6 100644
--- a/commit.h
+++ b/commit.h
@@ -199,7 +199,8 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
-extern void set_alternate_shallow_file(const char *path, int override);
+#define set_alternate_shallow_file(r, p, o) set_alternate_shallow_file_##r(p, o)
+extern void set_alternate_shallow_file_the_repository(const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct oid_array *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/environment.c b/environment.c
index b991fc0a87c..87d9e52ffde 100644
--- a/environment.c
+++ b/environment.c
@@ -189,7 +189,7 @@ void setup_git_env(const char *git_dir)
 	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
-		set_alternate_shallow_file(shallow_file, 0);
+		set_alternate_shallow_file(the_repository, shallow_file, 0);
 }
 
 int is_bare_repository(void)
diff --git a/git.c b/git.c
index 3a89893712e..5e8903681e6 100644
--- a/git.c
+++ b/git.c
@@ -207,7 +207,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 		} else if (!strcmp(cmd, "--shallow-file")) {
 			(*argv)++;
 			(*argc)--;
-			set_alternate_shallow_file((*argv)[0], 1);
+			set_alternate_shallow_file(the_repository, (*argv)[0], 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
diff --git a/shallow.c b/shallow.c
index ca360c700c5..73cb11a9162 100644
--- a/shallow.c
+++ b/shallow.c
@@ -19,7 +19,7 @@ static int is_shallow = -1;
 static struct stat_validity shallow_stat;
 static char *alternate_shallow_file;
 
-void set_alternate_shallow_file(const char *path, int override)
+void set_alternate_shallow_file_the_repository(const char *path, int override)
 {
 	if (is_shallow != -1)
 		die("BUG: is_repository_shallow must not be called before set_alternate_shallow_file");
-- 
2.17.0.582.gccdcbd54c44.dirty

