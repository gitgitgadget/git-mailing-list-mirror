From: David Turner <dturner@twopensource.com>
Subject: [PATCH 13/16] init: allow alternate backends to be set for new repos
Date: Wed,  2 Dec 2015 19:35:18 -0500
Message-ID: <1449102921-7707-14-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Ht4-0007bA-AC
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996AbbLCAgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:23 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34737 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604AbbLCAf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:56 -0500
Received: by ioir85 with SMTP id r85so64751741ioi.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=orGyycXm3RVKdXAdlWm64dS5x0dY8d2sLMxWpsaudhY=;
        b=X8nzrP8blvgf11tpoI6p85tTkxJ6l6nrcUjVD0XSJu+fvBCiRMBkpSAAOBuAElDz0t
         YFYAzP59ypAs6o5TT+G0BJV8yVXHkAyxbJEvrRTdIbZs85SEPAcy/wa5u5T64oDkSL3f
         57mZgvWNgAzoP9Kl1mq8RnnRu2ckrVNeTmU17eLTDMHZIPvW0KOhyEZsiiXDWZT2IoCt
         x7g48kF1uO/2hjMDyw5mof3FFdHqM3Ovwm7TRzbxELzvJq0ULXr3JWzsc/V05ep2O9fy
         GYCVd6W/eI0WALEmOCMkArmonTs7eP4D79yv69/pPLMLNKgIcRMzSz9O0vnmOp+EbUIh
         lG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=orGyycXm3RVKdXAdlWm64dS5x0dY8d2sLMxWpsaudhY=;
        b=NQBBDjGD2EW4fUk46YmB+tnAODk8YTPmiDvfvOCV5TTCLxBAaOBMHOlQtApIWli5ZH
         OPliwP3gHrrHT5TOZrHTqClv/YDPwljGTID+X49sBjazMzR7Z0CnLoRh6ujX3pmKwOSh
         NuLFUsQObO57zGd9VSr+eX4d+YfptyWbddYSefGRDcDL+afCfDA+TXNoOjL0qigHtUvG
         FUSCLXWVrhCYNZes1xMLIwp/ftJd4jCezrv9olM+QOBdO03BUbXHlvTm3peUYJTCBONd
         uoObtLSV6h9wqZFx9HlLNo4PLrGUWF9moOdUqM+z9VnSCShXcMYJra5xJmmYXgfPqaVq
         M+Mw==
X-Gm-Message-State: ALoCoQkIgcSLlD0XU9TpL43T3q9eJcEIGSxkfWqLx2GlRdTo6+Dnokiz/6y572t+HVRrk6Ea3w4K
X-Received: by 10.107.5.144 with SMTP id 138mr6346922iof.161.1449102955557;
        Wed, 02 Dec 2015 16:35:55 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:54 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281933>

git init learns a new argument --refs-backend-type.  Presently, only
"files" is supported, but later we will add other backends.

When this argument is used, the repository's core.refsBackendType
configuration value is set, and the refs backend's initdb function is
used to set up the ref database.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-init-db.txt |  2 +-
 Documentation/git-init.txt    |  6 +++++-
 builtin/init-db.c             | 10 ++++++++++
 cache.h                       |  2 ++
 config.c                      | 20 ++++++++++++++++++++
 environment.c                 |  1 +
 path.c                        | 32 ++++++++++++++++++++++++++++++--
 refs.c                        |  8 ++++++++
 refs.h                        | 12 ++++++++++++
 setup.c                       | 10 ++++++++++
 10 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd..72fbd71 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]] [--refs-backend-type=<name>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..9ea6753 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>]
 	  [--shared[=<permissions>]] [directory]
-
+	  [--refs-backend-type=<name>]
 
 DESCRIPTION
 -----------
@@ -113,6 +113,10 @@ does not exist, it will be created.
 
 --
 
+--refs-backend-type=<name>::
+Type of refs backend. Default is to use the original "files" backend,
+which stores ref data in files in .git/refs and .git/packed-refs.
+
 TEMPLATE DIRECTORY
 ------------------
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4771e7e..44db591 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -204,6 +204,14 @@ static int create_default_files(const char *template_path)
 		adjust_shared_perm(get_git_dir());
 	}
 
+	if (refs_backend_type) {
+		struct refdb_config_data config_data = {NULL};
+		git_config_set("core.refsBackendType", refs_backend_type);
+		config_data.refs_backend_type = refs_backend_type;
+		config_data.refs_base = get_git_dir();
+		set_refs_backend(refs_backend_type, &config_data);
+	}
+
 	if (refs_init_db(&err, shared_repository))
 		die("failed to set up refs db: %s", err.buf);
 
@@ -469,6 +477,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "refs-backend-type", &refs_backend_type,
+			   N_("name"), N_("name of backend type to use")),
 		OPT_END()
 	};
 
diff --git a/cache.h b/cache.h
index 707455a..d1534db 100644
--- a/cache.h
+++ b/cache.h
@@ -696,6 +696,8 @@ extern enum object_creation_mode object_creation_mode;
 
 extern char *notes_ref_name;
 
+extern const char *refs_backend_type;
+
 extern int grafts_replace_parents;
 
 /*
diff --git a/config.c b/config.c
index 248a21a..210aa08 100644
--- a/config.c
+++ b/config.c
@@ -10,6 +10,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "refs.h"
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
@@ -1207,6 +1208,25 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	}
 
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+		struct refdb_config_data refdb_data = {NULL};
+		char *repo_config_copy;
+
+		/*
+		 * make sure we always read the backend config from the
+		 * core section on startup
+		 */
+		ret += git_config_from_file(refdb_config, repo_config,
+					    &refdb_data);
+
+		repo_config_copy = xstrdup(repo_config);
+		refdb_data.refs_base = xstrdup(dirname(repo_config_copy));
+		free(repo_config_copy);
+
+		if (refdb_data.refs_backend_type &&
+		    strcmp(refdb_data.refs_backend_type, "files")) {
+			die("Unexpected backend %s", refdb_data.refs_backend_type);
+		}
+
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
diff --git a/environment.c b/environment.c
index 2da7fe2..8dbf0ab 100644
--- a/environment.c
+++ b/environment.c
@@ -66,6 +66,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+const char *refs_backend_type;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/path.c b/path.c
index 3cd155e..86a8035 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "refs.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
@@ -510,9 +511,36 @@ int validate_headref(const char *path)
 	unsigned char sha1[20];
 	int fd;
 	ssize_t len;
+	struct refdb_config_data refdb_data = {NULL, NULL};
+
+	if (lstat(path, &st) < 0) {
+		int backend_type_set;
+		struct strbuf config_path = STRBUF_INIT;
+		if (path) {
+			char *pathdup = xstrdup(path);
+			char *git_dir = dirname(pathdup);
+			strbuf_addf(&config_path, "%s/%s", git_dir, "config");
+			free(pathdup);
+		} else {
+			strbuf_addstr(&config_path, "config");
+		}
 
-	if (lstat(path, &st) < 0)
-		return -1;
+		if (git_config_from_file(refdb_config, config_path.buf, &refdb_data)) {
+			strbuf_release(&config_path);
+			return -1;
+		}
+
+		backend_type_set = !!refdb_data.refs_backend_type;
+		free((void *)refdb_data.refs_backend_type);
+		free((void *)refdb_data.refs_base);
+		strbuf_release(&config_path);
+		/*
+		 * Alternate backends are assumed to keep HEAD
+		 * in a valid state, so there's no need to do
+		 * further validation.
+		 */
+		return backend_type_set ? 0 : -1;
+	}
 
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
diff --git a/refs.c b/refs.c
index e48e43a..96e1673 100644
--- a/refs.c
+++ b/refs.c
@@ -24,6 +24,14 @@ struct ref_be *the_refs_backend = &refs_be_files;
  */
 struct ref_be *refs_backends = &refs_be_files;
 
+const char *refs_backend_type;
+
+void register_refs_backend(struct ref_be *be)
+{
+	be->next = refs_backends;
+	refs_backends = be;
+}
+
 /*
  * This function is used to switch to an alternate backend.
  */
diff --git a/refs.h b/refs.h
index c211b9e..c3670e8 100644
--- a/refs.h
+++ b/refs.h
@@ -510,6 +510,18 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+struct refdb_config_data {
+	const char *refs_backend_type;
+	const char *refs_base;
+};
+/*
+ * Read the refdb configuration data out of the config file
+ */
+int refdb_config(const char *var, const char *value, void *ptr);
+
+struct ref_be;
 int set_refs_backend(const char *name, void *data);
 
+void register_refs_backend(struct ref_be *be);
+
 #endif /* REFS_H */
diff --git a/setup.c b/setup.c
index d343725..de6b8ac 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 #include "string-list.h"
 
 static int inside_git_dir = -1;
@@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 	return ret;
 }
 
+int refdb_config(const char *var, const char *value, void *ptr)
+{
+       struct refdb_config_data *cdata = ptr;
+
+       if (!strcmp(var, "core.refsbackendtype"))
+	       cdata->refs_backend_type = xstrdup((char *)value);
+       return 0;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
-- 
2.4.2.749.g0ed01d8-twtrsrc
