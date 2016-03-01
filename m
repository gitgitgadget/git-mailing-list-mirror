From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 14/33] refs: add methods to init refs db
Date: Mon, 29 Feb 2016 19:52:47 -0500
Message-ID: <1456793586-22082-15-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZS-00073r-KU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcCAAxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:45 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36716 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbcCAAxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:42 -0500
Received: by mail-qk0-f179.google.com with SMTP id s68so63627037qkh.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WSG6O0raeWXA3JK3oUJEjI13ZuyIoUW9VW19Tx5YgVo=;
        b=DSkQ/0KSiL939onot6jbCUTjySruckpYfgrjZdBxf/jp8TwO33Lz1vEwU+XFrQPY4J
         LTEhNZohem62wgPaJVSNh4orPMdM5V02mLOaKIpxOWzVPXzIcjmD6ZT/JU1ZxugZ35De
         LqG0BbtKUl/UzcwMEcRIdCCvOz/4BblOx88ns2WQCrEz2AAbY+/M6KfKrSgLnxrMMLMY
         1UzqWz2zo9WFSRk2jFPzlKSHmvUw6EoaeqSqOYTu6cbgEmX4ZZ90uj4GpKrVmAtFCKXM
         s6cicvInZjmH0VjMCTIFT4Zmlx31AQGVnDN0/CtgVYQorahO79XXPvPm2Tn4jvlZprYU
         Cdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WSG6O0raeWXA3JK3oUJEjI13ZuyIoUW9VW19Tx5YgVo=;
        b=WqYjnK9pVhaC0i9JOlGxvbnZILcoAl4Y0DnEB4Xi0U8TeSKBr+KkfwK7P9yvNDWoN/
         jq8jSrj4LAQsdsgzpgjuiFQHNgLtXKxxJ/8E3nagtJaicIPj582CjWlcGtTJOFxA7omm
         lXZYXfiesux7+oF0GkDIFcfTBPXYTmbsfDL4VRy9PZdlAGQXj16xyoaT9b6issKlsjaA
         G/YPhjGLkupRmTR87FCD9cQcF0ihnfApbfVBFbj1sZnVcDrfoPmzgir7wQeuPzfo1XIA
         982smrkFPo3xxifGVVP2I4dkuoqT0FlWDWA+N79CRF2d8DEE0v/0Rz9daXCovUOSW+9y
         TA/g==
X-Gm-Message-State: AD7BkJIN1U1ry+ULhJc2fwYF92uRhNOhVW8OylvnuLbHSc7AyitCE2HT2g/VbNcjDSWKYA==
X-Received: by 10.55.221.200 with SMTP id u69mr16037741qku.0.1456793621611;
        Mon, 29 Feb 2016 16:53:41 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287953>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/init-db.c    | 20 ++++++++++----------
 refs.c               |  5 +++++
 refs.h               |  2 ++
 refs/files-backend.c | 16 ++++++++++++++++
 refs/refs-internal.h |  2 ++
 5 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6223b7d..e6d4e86 100644
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
index d25eee2..b2697f6 100644
--- a/refs.c
+++ b/refs.c
@@ -1319,6 +1319,11 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
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
index 3405842..13ce2a0 100644
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
index 35328d2..acb4401 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3415,9 +3415,25 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
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
