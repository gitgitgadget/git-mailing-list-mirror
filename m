From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 08/21] refs: add methods to init refs db
Date: Mon, 11 Jan 2016 20:22:07 -0500
Message-ID: <1452561740-8668-9-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfd-0003Hj-LR
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761807AbcALBWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:42 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36295 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761337AbcALBWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:39 -0500
Received: by mail-qg0-f42.google.com with SMTP id e32so328823430qgf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QPHH6XMUSgZvosAKikfaaC86uKYCIV9BqhrL4Pmt7s=;
        b=jfAXw3Qt9GKE0yL+M464RWFX6ZQVNJP70FnkUyHKgx+Z2u/D+7Sdp/L9d5Zh5M9xns
         uX6HsyVsbgmYd7LOnCpOL8UPDoyvFQNL1z984TungLzMvjhWgXRwX69wstohJywD5jQv
         AiY4RLH0el+XfmZUw0+h6n39UEI5zTAy6KBzc96R1+j3cf7O27Qs75SKf7PQxBkpc+V/
         kYc8MsvBoUz+00SNdI5Bluc+QHOyEtP4Rc99bW0wXBTQL88mlfUbsf54QnfVt14ONBCb
         kdN4d67GdxkQ30WWSk02FSgbP3taFmrfVtuVf+wSZx7x8tzIcyLhBbdX1CW8VvrGM4dA
         XjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QPHH6XMUSgZvosAKikfaaC86uKYCIV9BqhrL4Pmt7s=;
        b=PzfVAo5QmNl+LSkszeleksj6YBepp/B8drWD+LfP0CX1WtbH1n9KGvHVY/vNatW6pz
         88cgOPfaG/v4QVnF8eUA5YWvLH72S/FtAjQluTvSrhWWKLldB8fI9D58TT5+uQ+53hia
         n/wYbReNir+e37eyexFzH1HcHs2Qk54KakeUIDbReHrLc0tnUrhoLsR5/vsRk4hdwkGn
         9Z/nnQqVzRuKpkYCLDRgmLftUWucWSoA7UHVm8XyAe/RzaPPB6FhR2LqC/NG5PAWu6VU
         xeG1WHiTzrS/WAFjdH77lzi6TfI/y3XeSfQgumBdM8vfbXtOCJ5DuWPPD53X8CtKvs3I
         meLQ==
X-Gm-Message-State: ALoCoQnysCRTXfi7qWsM28pQS7Y9RoKgNhHsZ1MuqTJBK/5Pu0ianehz3C0aq8LroAw0Zwkk34UvcEpsoHYQI9iFlp3UpEK+JA==
X-Received: by 10.140.170.212 with SMTP id q203mr43543633qhq.32.1452561758243;
        Mon, 11 Jan 2016 17:22:38 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:37 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283743>

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
index 0c61be5..af5f7a7 100644
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
index 3464a79..df7bfc4 100644
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
index b9c4604..e8e112c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3534,9 +3534,26 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
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
index c26ce6b..f3c2632 100644
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
