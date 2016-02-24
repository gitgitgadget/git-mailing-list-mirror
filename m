From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 13/32] refs: add methods to init refs db
Date: Wed, 24 Feb 2016 17:58:45 -0500
Message-ID: <1456354744-8022-14-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPK-0003fn-SK
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759144AbcBXW7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:31 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34567 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759066AbcBXW72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:28 -0500
Received: by mail-qg0-f48.google.com with SMTP id b67so27011490qgb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A7LiWze/Isqd4T/Eorw/ObUaSYH9F1vgaFxhYMgL0x0=;
        b=w7ODGJYS6YH1MA2ifguQh2o6TtImuXKNrfbpMklZ8cPr5xFULaF/4ixsBv213P113R
         eMNv7Fy37H3/ZmR6s9/dTiMdRdzPWDguTEP2V4U56pWpvoYnl8I9r/XATFXrHraSckZJ
         bmknpJ5y7n0HYXTVacHVpqRfXqUcexKNYgQOa4EwCRk2t2x/P9IzjGDS7Fvn41dgy+HZ
         LbAjoPq6TfWvDV2NNoH0TSj/vslfhpCfGL91Jc4bsYtY1SX54IEXhGzqqNv4Te6+MgwZ
         hMEcmRnRfi+mpRfCCOO0j96Ti4TMfVG9qlUExMCmGDOumzASOtm/PjqQWaK+V+oSQ7pt
         4hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A7LiWze/Isqd4T/Eorw/ObUaSYH9F1vgaFxhYMgL0x0=;
        b=D4//CNaiJ+ZtzvdoTfAUrus3dZhCxGEX9K+Q1QUkPMzlt+hK1SJ1iw9clId23lOz6h
         TyUctsCtesOuOKlrzsUcVjAt6UfOgMPqoyff5VF22R97J0OsmOPNOl8AQ8xskPTOSKFB
         muUp5p/dWqXX8aY0HyVe2PCXOgDGIESOEqr2TD9go6z/d6yqkhYoMcmlHDn6GerpnyDE
         rLRfFyRGl/MNf74RuqpMHfX2F1/gRTM7S5OX3UO0hUm1jibCT0jXZRNgvlr99TYZEV7g
         kNVwIqgqqs7B7jz7xacUiYE21/KHLnW3er5IoFHswJxQnMMUFk3SUv6qaVPCqluD7rnC
         tWdg==
X-Gm-Message-State: AG10YOQH3yaGVyqdZWTlx24XE56w6+pUAwMnW6XkDIuCfx0lK0gJEZC5EI1wJqoca6/eKA==
X-Received: by 10.140.195.203 with SMTP id q194mr55233265qha.45.1456354767599;
        Wed, 24 Feb 2016 14:59:27 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:26 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287254>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    | 20 ++++++++++----------
 refs.c               |  5 +++++
 refs.h               |  2 ++
 refs/files-backend.c | 16 ++++++++++++++++
 refs/refs-internal.h |  2 ++
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 07229d6..0c8f4ac 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -177,13 +177,7 @@ static int create_default_files(const char *template_path)
 	char junk[2];
 	int reinit;
 	int filemode;
-
-	/*
-	 * Create .git/refs/{heads,tags}
-	 */
-	safe_create_dir(git_path_buf(&buf, "refs"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/heads"), 1);
-	safe_create_dir(git_path_buf(&buf, "refs/tags"), 1);
+	struct strbuf err = STRBUF_INIT;
 
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -207,12 +201,18 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path_buf(&buf, "refs"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
 	/*
+	 * We need to create a "refs" dir in any case so that older
+	 * versions of git can tell that this is a repository.
+	 */
+	safe_create_dir(git_path("refs"), 1);
+
+	if (refs_init_db(shared_repository, &err))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
diff --git a/refs.c b/refs.c
index 21b103c..baf83ac 100644
--- a/refs.c
+++ b/refs.c
@@ -1316,6 +1316,11 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 }
 
 /* backend functions */
+int refs_init_db(int shared, struct strbuf *err)
+{
+	return the_refs_backend->init_db(shared, err);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index 5bc3fbc..feff82e 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
+extern int refs_init_db(int shared, struct strbuf *err);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6b15a2e..67ba4c2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3424,9 +3424,25 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	return -1;
 }
 
+static int files_init_db(int shared, struct strbuf *err)
+{
+	/*
+	 * Create .git/refs/{heads,tags}
+	 */
+	safe_create_dir(git_path("refs/heads"), 1);
+	safe_create_dir(git_path("refs/tags"), 1);
+	if (shared) {
+		adjust_shared_perm(git_path("refs"));
+		adjust_shared_perm(git_path("refs/heads"));
+		adjust_shared_perm(git_path("refs/tags"));
+	}
+	return 0;
+}
+
 struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
+	files_init_db,
 	files_transaction_commit,
 	files_initial_transaction_commit,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index beef457..dfd0326 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -211,6 +211,7 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
 				 void *cb_data);
 
 /* refs backends */
+typedef int ref_init_db_fn(int shared, struct strbuf *err);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
@@ -255,6 +256,7 @@ typedef int do_for_each_ref_fn(const char *submodule, const char *base,
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
+	ref_init_db_fn *init_db;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
-- 
2.4.2.767.g62658d5-twtrsrc
