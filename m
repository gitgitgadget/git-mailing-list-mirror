Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB04C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27922208E4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKX/g5Mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgCJNR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:17:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37417 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbgCJNLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so1290816wme.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xPAvNSy/JO+ApfEIL+TKNP4JWnRTvx1KvqL9PEO8/7o=;
        b=VKX/g5Mo9Kz331HiCZLLeG4OuPbFLtu98fn+UaIEDd9TZMWicU67neRknrlXA3LP8u
         GlU0W9uMesnVXHRCuY3++AD5z/vIvObKF548f9Swk0ZLUowQn9835lJ+Fhs/64TqIBAu
         0mEa7Nv9ZA4mnbrfJxbYDNWISkRECqUDeKu7UixRnB2CqluNhe4e1bGtgFrqTneSR8NL
         4wn5gh1S7ByQOFHCnYmgAKTnimVKXzGc0hqkDSjyyNbh/LuYTC83qI6W12QlqExMdwX2
         H9H8RAz/sJFK9gb5t3Xdc9nCUxTRkPUz/a3fhErsn4P7fQFwDQmav/BEV+mj8LY9b1M8
         legw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xPAvNSy/JO+ApfEIL+TKNP4JWnRTvx1KvqL9PEO8/7o=;
        b=GIrqm6p6CuXeVYN0/RRh49FD+tRzw7KTz23uEBEnh6qAhMcH/bvMxDglspECV69Y8y
         60VtciskLwwyI7H3hTkqxgjJg7zMDguy+qF/vHNbxpuPBufX5/Ey9ur5hKHOGBI3w5Z0
         uYb/r5rj7f6m/s0eA9AW0Lg8IMzjYh3//uOENrC55IujaXj98Ijdk2eqg+rbz21rZy48
         sbLkYrrYuMgLJ+xJNCaGZLanzrj2CJ1mKkAD7ZxzX1I+hNA6Qn96SiHeYUU8Y8m2mOs+
         abVBc+Udk0eFXrOx1tCi1AG30M2qTOT5Rrf4rgC1ZJjXb8Wa8NYPUxrjXNPsZChJkDci
         6JZQ==
X-Gm-Message-State: ANhLgQ2H4nQkXVgolkzTUxEl8KyjXt/W0E+1xXS6V2AGZVVxbLOU0Spq
        brVjF9OGzAqobxZkfVq+jSh2f+z8
X-Google-Smtp-Source: ADFU+vuHiEQiVOKSwGG6I3YDVaSleCaHQwP6RfT2o9jzwhNb5+d+MffqjuxgAOHsLDSAVGI3PynMxA==
X-Received: by 2002:a1c:a70f:: with SMTP id q15mr2235578wme.66.1583845888547;
        Tue, 10 Mar 2020 06:11:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm64062036wrw.2.2020.03.10.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:11:26 -0700 (PDT)
Message-Id: <f7afcb4cc83a955b04283475facc02349207557c.1583845884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 13:11:21 +0000
Subject: [PATCH v2 1/4] set_git_dir: fix crash when used with real_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`real_path()` returns result from a shared buffer, inviting subtle
reentrance bugs. One of these bugs occur when invoked this way:
    set_git_dir(real_path(git_dir))

In this case, `real_path()` has reentrance:
    real_path
    read_gitfile_gently
    repo_set_gitdir
    setup_git_env
    set_git_dir_1
    set_git_dir

Later, `set_git_dir()` uses its now-dead parameter:
    !is_absolute_path(path)

Fix this by using a dedicated `strbuf` to hold `strbuf_realpath()`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 builtin/init-db.c |  4 ++--
 cache.h           |  2 +-
 environment.c     | 11 ++++++++++-
 path.c            |  2 +-
 setup.c           | 18 +++++++++---------
 5 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 944ec77fe10..5bf61a7e056 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -356,12 +356,12 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		if (!exist_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
-		set_git_dir(real_path(real_git_dir));
+		set_git_dir(real_git_dir, 1);
 		git_dir = get_git_dir();
 		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
-		set_git_dir(real_path(git_dir));
+		set_git_dir(git_dir, 1);
 		git_dir = get_git_dir();
 	}
 	startup_info->have_repository = 1;
diff --git a/cache.h b/cache.h
index 37c899b53f7..8cee257d3d7 100644
--- a/cache.h
+++ b/cache.h
@@ -543,7 +543,7 @@ const char *get_git_common_dir(void);
 char *get_object_directory(void);
 char *get_index_file(void);
 char *get_graft_file(struct repository *r);
-void set_git_dir(const char *path);
+void set_git_dir(const char *path, int make_realpath);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
 const char *get_git_namespace(void);
diff --git a/environment.c b/environment.c
index e72a02d0d57..c436de31eef 100644
--- a/environment.c
+++ b/environment.c
@@ -345,11 +345,20 @@ static void update_relative_gitdir(const char *name,
 	free(path);
 }
 
-void set_git_dir(const char *path)
+void set_git_dir(const char *path, int make_realpath)
 {
+	struct strbuf realpath = STRBUF_INIT;
+
+	if (make_realpath) {
+		strbuf_realpath(&realpath, path, 1);
+		path = realpath.buf;
+	}
+
 	set_git_dir_1(path);
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, update_relative_gitdir, NULL);
+
+	strbuf_release(&realpath);
 }
 
 const char *get_log_output_encoding(void)
diff --git a/path.c b/path.c
index 88cf5930073..c5a8fe4f0c3 100644
--- a/path.c
+++ b/path.c
@@ -850,7 +850,7 @@ const char *enter_repo(const char *path, int strict)
 	}
 
 	if (is_git_directory(".")) {
-		set_git_dir(".");
+		set_git_dir(".", 0);
 		check_repository_format();
 		return path;
 	}
diff --git a/setup.c b/setup.c
index 4ea7a0b081b..fa4317e707a 100644
--- a/setup.c
+++ b/setup.c
@@ -725,7 +725,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		}
 
 		/* #18, #26 */
-		set_git_dir(gitdirenv);
+		set_git_dir(gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
@@ -747,7 +747,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	}
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
-		set_git_dir(gitdirenv);
+		set_git_dir(gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
@@ -759,14 +759,14 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 
 	/* both get_git_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
-		set_git_dir(gitdirenv);
+		set_git_dir(gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
 
 	offset = dir_inside_of(cwd->buf, worktree);
 	if (offset >= 0) {	/* cwd inside worktree? */
-		set_git_dir(real_path(gitdirenv));
+		set_git_dir(gitdirenv, 1);
 		if (chdir(worktree))
 			die_errno(_("cannot chdir to '%s'"), worktree);
 		strbuf_addch(cwd, '/');
@@ -775,7 +775,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	}
 
 	/* cwd outside worktree */
-	set_git_dir(gitdirenv);
+	set_git_dir(gitdirenv, 0);
 	free(gitfile);
 	return NULL;
 }
@@ -804,7 +804,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (is_bare_repository_cfg > 0) {
-		set_git_dir(offset == cwd->len ? gitdir : real_path(gitdir));
+		set_git_dir(gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
 		return NULL;
@@ -813,7 +813,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		set_git_dir(gitdir);
+		set_git_dir(gitdir, 0);
 	inside_git_dir = 0;
 	inside_work_tree = 1;
 	if (offset >= cwd->len)
@@ -856,10 +856,10 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 			die_errno(_("cannot come back to cwd"));
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
-		set_git_dir(cwd->buf);
+		set_git_dir(cwd->buf, 0);
 	}
 	else
-		set_git_dir(".");
+		set_git_dir(".", 0);
 	return NULL;
 }
 
-- 
gitgitgadget

