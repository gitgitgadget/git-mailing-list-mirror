Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC02A1F42D
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeC1R4s (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36044 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeC1R4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id z143-v6so4747434lff.3
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmjW2fzO2Mi+nLopRYsxKAOxppXyu4a1pVwJ6Y7sicE=;
        b=BwnGU3+4SJcpWvk4sYFihDNJ+em5Rli2TK6OYnuUUY71JTwwLipwuLzwyX2o9phtuA
         XPcNeQDVmL8cTt3lg26XfACnW+vF6lCI/hvvIAxa/nTeR8P5MtWAdWFuIYlR0QxYPiyr
         PtiE2aYU626VfbTXlgrkE1RAPEuqm+qClZc2TIWDbyNvLWfA6ditigUs89fobxap+Si7
         Frg/DCnWMWHnP+s9QZO41OAC+Q/Ih/YP4R2Pp+Tb/syDEkZLW8hGpCLiatPzYxyzDQGw
         f8ECUn0GdD0ByOkuDjVE+u4aGqptNQ21CzzYS9/mq25pqUXT4jT1MSD4u7qa+mYG4p6I
         ienw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmjW2fzO2Mi+nLopRYsxKAOxppXyu4a1pVwJ6Y7sicE=;
        b=OmWcoXSx1Z1M6swZz4muZYK0QppOKjuMe26rvvcViApk+B7wvk3MvQKKaMm6GEP7hE
         p+12m46qiHZpxvROciWPSn+w2kwD0U0metxoByOK8MSMDL1VASWOdnQTxN43LjUrLKym
         LHAdAykqwA5w58i5xA5phrRytD98DSXJFgMpEXFKZ4GspXosuAb0vxG7KnxA76kMXWjA
         VeN7JLFno1CGHcVqNP2+SVqzq5WOzwg/+sVEV5bImG6L3y4JfXW+6M8V1kNFAUORihos
         m0+iQvzxHxIv4p4lzvjCd1AbM41ioHty9nYYfdpEVPpT+I8YQzogGtsgdT/Z6BpHzQ7V
         gfLg==
X-Gm-Message-State: AElRT7HDSSB+PQk0hDUdljfa4bBxgKLRrGwTaWYLI1ZRkMJCJNzF4PMN
        VlIuqIaQbQYh27nO2sPTOg1f1Q==
X-Google-Smtp-Source: AIpwx49vKDXZgVDMk6E+fTgK3TrZ1TvvYL/A2aJLdPX3K5eWcNoLge9OpV+VPLpj3S/OhGjrf80BPA==
X-Received: by 10.46.99.93 with SMTP id x90mr3271597ljb.2.1522259796823;
        Wed, 28 Mar 2018 10:56:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 7/8] repository: adjust repo paths when $CWD moves
Date:   Wed, 28 Mar 2018 19:55:36 +0200
Message-Id: <20180328175537.17450-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

As noted in previous and previous patches, when setup_work_tree()
moves $CWD, it calls set_git_dir() with a new path to make sure
relative $GIT_DIR is still correct.

The same problem from the previous patch applies here: if
$GIT_ALTERNATE_OBJECT_DIRECTORIES or $GIT_OBJECT_DIRECTORY are also
relative, the user is screwed.

Fortuntely the previous patch indirectly fixes this as well:
update_path_envs() in environment.c is actually called before
setup_git_env() is indirectly called by setup_work_tree() via
set_git_dir(). At that point, it correctly gets the updated paths from
env and pass them down. This patch is here for another reason.

From the design perspective, calling set_git_dir() the second time [1]
is just bad because it could potentially be used to point repo code to
_another_ repository. The promise that "the new path actually points
to the same place as the old one" is not guaranteed and also hard to
see unless you know setup code well.

This patch avoids this. The second set_git_dir() call is just a
workaround to adjust paths. We can now do it directly from repo code
by subscribing to the "$CWD updated" event and do everything needed by
the repo. After this we could die() on subsequent repo_set_gitdir()
calls because we do not support it (we never did).

[1] The first time is done by setup_git_directory() code, which is
correct: we have just found a repo and we want to initialize our code
to read from that repo.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h |  3 +++
 object.c       | 15 +++++++++++++++
 repository.c   | 28 ++++++++++++++++++++++++++++
 setup.c        |  6 +-----
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/object-store.h b/object-store.h
index fef33f345f..4af2c53bca 100644
--- a/object-store.h
+++ b/object-store.h
@@ -119,6 +119,9 @@ struct raw_object_store {
 };
 
 struct raw_object_store *raw_object_store_new(void);
+void raw_object_store_adjust_paths(struct raw_object_store *o,
+				   const char *old_cwd,
+				   const char *new_cwd);
 void raw_object_store_clear(struct raw_object_store *o);
 
 /*
diff --git a/object.c b/object.c
index a0a756f24f..5318922efd 100644
--- a/object.c
+++ b/object.c
@@ -457,6 +457,21 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
+void raw_object_store_adjust_paths(struct raw_object_store *o,
+				   const char *old_cwd,
+				   const char *new_cwd)
+{
+	/*
+	 * "main repo" is technically wrong because we don't know that
+	 * from here. But it's the only repo that will execute this
+	 * function for now.
+	 */
+	setup_adjust_path("main repo's object dir",
+			  &o->objectdir, old_cwd, new_cwd);
+	setup_adjust_path("main repo's alt dir",
+			  &o->alternate_db, old_cwd, new_cwd);
+}
+
 static void free_alt_odb(struct alternate_object_database *alt)
 {
 	strbuf_release(&alt->scratch);
diff --git a/repository.c b/repository.c
index a4848c1bd0..c2edf227fe 100644
--- a/repository.c
+++ b/repository.c
@@ -8,6 +8,10 @@
 static struct repository the_repo;
 struct repository *the_repository;
 
+static void repo_adjust_paths(const char *old_cwd,
+			      const char *new_cwd,
+			      void *cb_data);
+
 void initialize_the_repository(void)
 {
 	the_repository = &the_repo;
@@ -15,6 +19,11 @@ void initialize_the_repository(void)
 	the_repo.index = &the_index;
 	the_repo.objects = raw_object_store_new();
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
+	/*
+	 * non-main repos probably does not need this since $CWD should
+	 * never change again by the time they are created.
+	 */
+	add_cwd_update_callback(repo_adjust_paths, the_repository);
 }
 
 static void expand_base_dir(char **out, const char *in,
@@ -70,6 +79,25 @@ void repo_set_gitdir(struct repository *repo,
 			repo->gitdir, "index");
 }
 
+static void repo_adjust_paths(const char *old_cwd, const char *new_cwd,
+			      void *cb_data)
+{
+	struct repository *repo = cb_data;
+
+	if (repo != the_repository)
+		die("BUG: this is supposed to happen to main repo only");
+
+	setup_adjust_path("main repo's gitdir",
+			  &repo->gitdir, old_cwd, new_cwd);
+	setup_adjust_path("main repo's commondir",
+			  &repo->commondir, old_cwd, new_cwd);
+	setup_adjust_path("main repo's graft file",
+			  &repo->graft_file, old_cwd, new_cwd);
+	setup_adjust_path("main repo's index file",
+			  &repo->index_file, old_cwd, new_cwd);
+	raw_object_store_adjust_paths(repo->objects, old_cwd, new_cwd);
+}
+
 void repo_set_hash_algo(struct repository *repo, int hash_algo)
 {
 	repo->hash_algo = &hash_algos[hash_algo];
diff --git a/setup.c b/setup.c
index 23b8f89ce2..e364aea7e5 100644
--- a/setup.c
+++ b/setup.c
@@ -417,7 +417,7 @@ void setup_adjust_path(const char *name, char **path,
 void setup_work_tree(void)
 {
 	static int initialized = 0;
-	const char *work_tree, *git_dir;
+	const char *work_tree;
 	struct strbuf old_cwd = STRBUF_INIT;
 	int i;
 
@@ -428,9 +428,6 @@ void setup_work_tree(void)
 		die(_("unable to set up work tree using invalid config"));
 
 	work_tree = get_git_work_tree();
-	git_dir = get_git_dir();
-	if (!is_absolute_path(git_dir))
-		git_dir = real_path(get_git_dir());
 	strbuf_get_pwd_cwd(&old_cwd);
 	if (!work_tree || chdir(work_tree))
 		die(_("this operation must be run in a work tree"));
@@ -439,7 +436,6 @@ void setup_work_tree(void)
 		cwd_callbacks[i].fn(old_cwd.buf, work_tree,
 				    cwd_callbacks[i].cb_data);
 	strbuf_release(&old_cwd);
-	set_git_dir(remove_leading_path(git_dir, work_tree));
 	initialized = 1;
 }
 
-- 
2.17.0.rc1.439.gca064e2955

