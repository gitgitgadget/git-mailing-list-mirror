Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B6B20705
	for <e@80x24.org>; Thu,  8 Sep 2016 13:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758193AbcIHNrr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 09:47:47 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33467 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbcIHNrq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 09:47:46 -0400
Received: by mail-pa0-f68.google.com with SMTP id h5so2448818pao.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/OT9XN3jDB6Sp2MxbBG18v8MSywUyAlGaunXnChsM8=;
        b=gbfRrHOeiLmdhzOk0EaglwYWM+Nc+cG5nxcawMOf1tLVNRLvxzcemXHfZWzgskuz9B
         cPn8a9TyWhez4LPFV4HA4HXSykm0EksgFHmKP6pN6nmWNSG5U4idQXJmXjXIhfkfmnzL
         OuqcNlaJjJQ0EvT7P48eS285YBWza0ahszjlWgcOihPCKBmZxR2eBZZInaM6Vu4A9q7W
         BaaR8DFYk7EPlMYF6k93wVxya0RYYFwpeJScSezLGGgYTfvPYtYMn2/uCwvyw1Y+eAsb
         vl/Hnf9mWrGISWYtba+y80+aGOG12KFAWXa4v1E52PHiANGcr5XSrk50FQ0Q539eFcLG
         OukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/OT9XN3jDB6Sp2MxbBG18v8MSywUyAlGaunXnChsM8=;
        b=hg8RAg6xwK23mB+xH+YXyDiQZ/NNb6oZHh1SFQMm5mNY4tHIj/sim3hVEldB3xEbGA
         63SMilkdO7+lestuwV4HB5gcIL/N+S4dM6+HHyytgSjJTw2TTvk/phu1WrWFE3T5C4HY
         42gC1jv1o8YB6TjFEFEMMOij7na+RXsFjaZj77SIy/RPkPlH8E478heulr2MS7cmUDY6
         mka+qa5Vkme9csJVQoQ77PtNojf0xdfXLqC11/R/CYSZRfFMFVKwmvbZ6KZbEmSCzXJb
         4HP0SIo482oapbfKFbvlaAax1uUH6wlwGLqCDxBJof49t8ELEs142EQx+a0uhP4b3u6L
         LpMw==
X-Gm-Message-State: AE9vXwNpmQSo6fXdq9YJbrPfeHk7r5flKB9zLad/tOQG7j3xieVHfCoFovXXmTRr0q149g==
X-Received: by 10.66.194.196 with SMTP id hy4mr58645823pac.63.1473342465979;
        Thu, 08 Sep 2016 06:47:45 -0700 (PDT)
Received: from ash ([27.77.242.225])
        by smtp.gmail.com with ESMTPSA id x9sm54912945pfd.70.2016.09.08.06.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 06:47:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Sep 2016 20:47:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     git@drmicha.warpmail.net, max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] init: do not set core.worktree more often than necessary
Date:   Thu,  8 Sep 2016 20:47:19 +0700
Message-Id: <20160908134719.27955-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160908134719.27955-1-pclouds@gmail.com>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git init" is called with GIT_WORK_TREE environment set, we want to
keep this worktree's location in core.worktree so the user does not have
to set the environment again and again. See ef6f0af (git-init: set
core.worktree if GIT_WORK_TREE is specified - 2007-07-04)

We detect that by this logic (in needs_work_tree_config): normally
worktree's top dir would contains ".git" directory, if this is not true,
worktree is probably set to elsewhere by the user.

Unfortunately when it calls get_git_dir() it does not take ".git" files
into account. When we find a .git file, we immediately follow the file
until we find the real ".git" directory. The location of this first
".git" file is lost.

The .git file would satisfy the logic above and not create
core.worktree (correct). But because the final .git's location is used,
needs_work_tree_config() is misled and creates core.worktree anyway.

This would not be a huge deal normally. But if this happens in a
multiple worktree setup it becomes a real problem because up until now,
core.worktree will be applied to the main worktree only. If you
accidentally do "git init" from a linked worktree, you set
core.worktree (for the main repo) pointing to the _linked_ worktree.
After that point, may you live in interesting times.

Record the .git file location and use it here.

Noticed-by: Max Nordlund <max.nordlund@sqore.com>
Helped-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c |  2 +-
 cache.h           |  1 +
 environment.c     | 16 +++++++++++++++-
 t/t0001-init.sh   |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6d9552e..36255f2 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -254,7 +254,7 @@ static int create_default_files(const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 			git_config_set("core.logallrefupdates", "true");
-		if (needs_work_tree_config(get_git_dir(), work_tree))
+		if (needs_work_tree_config(get_first_git_dir(), work_tree))
 			git_config_set("core.worktree", work_tree);
 	}
 
diff --git a/cache.h b/cache.h
index b780a91..e6c05f8 100644
--- a/cache.h
+++ b/cache.h
@@ -460,6 +460,7 @@ extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern const char *get_git_common_dir(void);
+extern const char *get_first_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
diff --git a/environment.c b/environment.c
index ca72464..8cfb8f3 100644
--- a/environment.c
+++ b/environment.c
@@ -100,7 +100,7 @@ static char *work_tree;
 static const char *namespace;
 static size_t namespace_len;
 
-static const char *git_dir, *git_common_dir;
+static const char *git_dir, *git_common_dir, *first_git_dir;
 static char *git_object_dir, *git_index_file, *git_graft_file;
 int git_db_env, git_index_env, git_graft_env, git_common_dir_env;
 
@@ -168,6 +168,8 @@ static void setup_git_env(void)
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	gitfile = read_gitfile(git_dir);
+	if (gitfile && !first_git_dir)
+		first_git_dir = xstrdup(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
 	if (get_common_dir(&sb, git_dir))
 		git_common_dir_env = 1;
@@ -203,6 +205,18 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+/*
+ * Return the first ".git" that we have encountered.
+ * FIXME this function for not entirely correct because
+ * setup_git_directory() and enter_repo() do not update first_git_dir
+ * when they follow .git files. The function in its current state is
+ * only suitable for "git init".
+ */
+const char *get_first_git_dir(void)
+{
+	return first_git_dir ? first_git_dir : git_dir;
+}
+
 const char *get_git_common_dir(void)
 {
 	return git_common_dir;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 393c940..d59669a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -393,9 +393,11 @@ test_expect_success 're-init from a linked worktree' '
 		test_commit first &&
 		git worktree add ../linked-worktree &&
 		mv .git/info/exclude expected-exclude &&
+		cp .git/config expected-config &&
 		find .git/worktrees -print | sort >expected &&
 		git -C ../linked-worktree init &&
 		test_cmp expected-exclude .git/info/exclude &&
+		test_cmp expected-config .git/config &&
 		find .git/worktrees -print | sort >actual &&
 		test_cmp expected actual
 	)
-- 
2.8.2.524.g6ff3d78

