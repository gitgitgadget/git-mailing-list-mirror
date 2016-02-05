From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 08/21] refs: add methods to init refs db
Date: Fri,  5 Feb 2016 14:44:09 -0500
Message-ID: <1454701462-3817-9-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJU-0001CI-80
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbcBETo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:58 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32802 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbcBETow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:52 -0500
Received: by mail-qk0-f182.google.com with SMTP id s5so38306274qkd.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1X3Ov+Tuo3dvb0lg5DaCoXllzVqk87Mkaqc245VH3EE=;
        b=C9GjFZC83z9t8sbwirJRfkxdybZQe5B39uEoaby6EB4QlRzkc/dS5r3qvHEEup7PUP
         YX7TwklYFFeeu4yDtAT2zAU0567U/1+f/rUPothF+KivjOdC25cm+sw2Oaay2htAgBQ/
         QqSDLAHLfFxhp0oXom2rcU/br4h9ipobrRGp5gFbZZe3XE80uX4TSXvyiJxbyVcPCbPh
         T5PLMEafozfAiuyp+99jKwukIk8+DYWR4Kf9A+sUuxzYck7Es+Bmbo5s7yS3r35YirfL
         4XFXGiyCdXWqSnfTq957062vb6yD9G1tFMCvqieGA7FUORgChrUlYsvoIQKd9XdZk43s
         bgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1X3Ov+Tuo3dvb0lg5DaCoXllzVqk87Mkaqc245VH3EE=;
        b=chudRyYFiA0xnHQXRZEHCcSY8FpIe8X7w5h4i7FhfJGu0J+jDGkyX7GdDhY4qB7uVA
         qao6mGpkbWZ1qpFMDQrE1zJ9Y77LJYpp6oLrVybsns7LW8hcycuGwch70x4moQ67k7Gh
         iV0acE47hR9HZFo8QAgaYb0JLBQH1NoKrZPYq4lo04TiRuaMGf6PU0+vGyHGrON/amqC
         zAWE2rAKOR7k9Gjjva+BL9DI1PbZcxSkO+JJY5YfeorlBzWYLeoqBl/WMZc25sKdoU5E
         XgXyKceG4ZRDseo+0/gTB1tD654qLScxYr/1oC7/BzMc5zvXE0Yf0RS9m91vYKyEAvQn
         Lr/Q==
X-Gm-Message-State: AG10YORNsW4t2AewZXkugwpAQuqYzI7hm5BKgTHk6aOrduR3k7lBlo5OV6qBHjorjPtFpw==
X-Received: by 10.55.82.137 with SMTP id g131mr18609822qkb.66.1454701491792;
        Fri, 05 Feb 2016 11:44:51 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:51 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285608>

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
index 26e1cc3..801e977 100644
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
@@ -208,12 +202,18 @@ static int create_default_files(const char *template_path)
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
+	if (refs_init_db(&err, shared_repository))
+		die("failed to set up refs db: %s", err.buf);
+
+	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
diff --git a/refs.c b/refs.c
index 5fbe794..7758bdc 100644
--- a/refs.c
+++ b/refs.c
@@ -1117,6 +1117,11 @@ int rename_ref_available(const char *oldname, const char *newname)
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
index 5bc3fbc..c5ecc52 100644
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
index e86849c..45da091 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3558,9 +3558,25 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	return -1;
 }
 
+static int files_init_db(struct strbuf *err, int shared)
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
index 1d9e5e0..5768fee 100644
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
