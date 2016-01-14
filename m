From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 08/20] refs: add methods to init refs db
Date: Thu, 14 Jan 2016 11:26:05 -0500
Message-ID: <1452788777-24954-9-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:26:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkja-0002BJ-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbcANQ0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:47 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33292 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbcANQ0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:41 -0500
Received: by mail-qg0-f46.google.com with SMTP id b35so356508535qge.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AvN/icu4yr1Z5yoRXV8FDcjHADsb+7T9QBBaXwo70yw=;
        b=U+MbVUK1eRFMOAq5ZQf8hYEPVXodx7JSVUEpPubqd/yHXYqrVLIJHcxpYAXj/4auPg
         nH5IlDOkrRKjnl9HYiIn26mBEgp7Wb68fvHJSUsrkYF6S/iwUwOcJG02W06zatbZWGpV
         fzpP/5w2DL6gu0+2vpeI+FQ9U7alrhgstDJtyDKEjdcp72NB+EKohefTZjEq1o0jZdjX
         TdVzacvexVCIWXbvrn8s7tqGU8RtBPhG0W8HlntPNhIYaF99YupyXY8ILyyR5Y4UU5WB
         1zrJhdXWfpIPCh7uKt426zmz7cn82ZL/7SnbIOOWMStqzVaZZSgxv/UjOtLcn40g8Esc
         GZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AvN/icu4yr1Z5yoRXV8FDcjHADsb+7T9QBBaXwo70yw=;
        b=L/PxfApzdVstQ949zNZGqHvPI6T7lv3KfeAVML5Ys/xnec2oU4pElZlknNAJoqZXNg
         uYPOhgly4W+pkDQ1AySoU+u1XLydJ0/zyTB+H+nRdtqO2KjA1vM3h0I4HJwksOq0NPbx
         kOmAfrJk8KIO3if184E2MI5GNt2GshdIHAVYadn8biu40/432WpjeCz4i728VItxC4rO
         Eqk6VWnTEb1AlsNM8CJskbzMhIbf9v5GRb6zlYFSb+aB8/FZD4oO72GeU+6S4vcj8LRH
         kTwbjfqe+EDJ/O7ScoiK2QQht4kX6xdTSLBEGy6+3MS+2j15jcKCtDuphOzfHfYoEO5J
         OrNQ==
X-Gm-Message-State: ALoCoQknc7HkYV6XfCusO+1RcO0Q/DrIFM0ObWTVMeExvNQgGc/FbY2fUFZrh1sAF7KbiHvjR1zRNj+N8gg7rqtSOesrLAx14g==
X-Received: by 10.140.220.207 with SMTP id q198mr7146011qhb.24.1452788800544;
        Thu, 14 Jan 2016 08:26:40 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284039>

Alternate refs backends might not need the refs/heads directory and so
on, so we make ref db initialization part of the backend.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c    | 14 ++++----------
 refs.c               |  5 +++++
 refs.h               |  2 ++
 refs/files-backend.c | 17 +++++++++++++++++
 refs/refs-internal.h |  2 ++
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 26e1cc3..4771e7e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -178,13 +178,7 @@ static int create_default_files(const char *template_path)
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
@@ -208,11 +202,11 @@ static int create_default_files(const char *template_path)
 	 */
 	if (shared_repository) {
 		adjust_shared_perm(get_git_dir());
-		adjust_shared_perm(git_path_buf(&buf, "refs"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
-		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
 	}
 
+	if (refs_init_db(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
diff --git a/refs.c b/refs.c
index f1c0601..b43d9ea 100644
--- a/refs.c
+++ b/refs.c
@@ -1106,6 +1106,11 @@ int rename_ref_available(const char *oldname, const char *newname)
 }
 
 /* backend functions */
+int refs_init_db(struct strbuf *err, int shared)
+{
+	return the_refs_backend->init_db(err, shared);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index c831b8e..4d18886 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
 
 extern int is_branch(const char *refname);
 
+extern int refs_init_db(struct strbuf *err, int shared);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f1cb4c9..7f8c3d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3540,9 +3540,26 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	return -1;
 }
 
+static int files_init_db(struct strbuf *err, int shared)
+{
+	/*
+	 * Create .git/refs/{heads,tags}
+	 */
+	safe_create_dir(git_path("refs"), 1);
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
index b9c9b1d..1373c02 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -208,6 +208,7 @@ const char *find_descendant_ref(const char *dirname,
 int rename_ref_available(const char *oldname, const char *newname);
 
 /* refs backends */
+typedef int ref_init_db_fn(struct strbuf *err, int shared);
 typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
 				      struct strbuf *err);
 
@@ -267,6 +268,7 @@ typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
+	ref_init_db_fn *init_db;
 	ref_transaction_commit_fn *transaction_commit;
 	ref_transaction_commit_fn *initial_transaction_commit;
 
-- 
2.4.2.749.g730654d-twtrsrc
