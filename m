From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 24/27] refs: add register_ref_storage_backends()
Date: Thu, 18 Feb 2016 00:17:47 -0500
Message-ID: <1455772670-21142-25-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:19:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzh-0001cT-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424964AbcBRFTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:19:06 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36401 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424957AbcBRFTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:19:01 -0500
Received: by mail-qg0-f43.google.com with SMTP id y9so29821108qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=csfWk4GTz0M+mUkbQmC0/K8R0O2N4kOkG3HrZkneDtU=;
        b=R8khLQb436WKDZBQqxhX9VaOAim9F4l//otcDiUWtaod3CEl4QY3T7N6s4UwgxHFeg
         h0ODRdL7wqTjKCpLp0p+tgaLfEy1pGFLOsG2rrOH056hzJsUylrmbzKYa0It1f/X+KwH
         2M4yqHsOVWNf66FjNJ+vU2ZGc/BB6SM2yuLtfVIJmli2J+Z7pBDNA8n9fD9MwSBtE5nS
         xzLiIPtEiiffDAUp+eOkJOXOyzvz7Ff4yyObR0mMXtoEx0Fqg7u5Fe/Hqytd53o68gAt
         A8WDz+ez7y/2uvKHeBJ80Z9JPRKGTt+AGA7YpA8pmFUAHceqx/7AkgKMGxZ9GuDU16+C
         ML4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=csfWk4GTz0M+mUkbQmC0/K8R0O2N4kOkG3HrZkneDtU=;
        b=d292yoLoqrM0oV3AIXx1UEqK1rgiH4Tk7nYQaPRBKZOdvttZaqfDBRw0VT6ctbZQWC
         mJLvzJJZmkzWgeQmqjbX8YEaOoq9jmPM0YZHfG5dijncKopTMBSrTSua0rqgk3bPOS2T
         2xKhJMh0xjnbWqtYFq5i8cGBD/V49uiu3PC5JQYbKJAq8cO4Z3hla6ULTPuz7HYlIH0E
         yGfdMwbkhSMi92x6KRcKh5J32tiBA79T9S0dEcKHZHKqjJQ+oUEx1U96F/jURFmphSIX
         DHDwXHNM0WSQBA7NgB11ykkvktpvBKsl+Qz3uo5sm6tE2XBbDZww3ggtvcQJAYM7o+RT
         lEAg==
X-Gm-Message-State: AG10YOS1HFznQHGvUK8kFXKU3HEwzMgt4dv7orI10Ug0kOrwU/vRljFKSWx24KQXfN3iFA==
X-Received: by 10.140.107.70 with SMTP id g64mr6565427qgf.75.1455772741312;
        Wed, 17 Feb 2016 21:19:01 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:19:00 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286586>

This new function will register all known ref storage backends... once
there are any other than the default.  For now, it's a no-op.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c |  3 +++
 config.c          | 25 +++++++++++++++++++++++++
 refs.c            | 13 +++++++++----
 refs.h            |  2 ++
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 753cb1c..9bd98eb 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -225,6 +225,7 @@ static int create_default_files(const char *template_path)
 	if (strcmp(ref_storage_backend, "files")) {
 		git_config_set("extensions.refStorage", ref_storage_backend);
 		git_config_set("core.repositoryformatversion", ref_storage_backend);
+		register_ref_storage_backends();
 		if (set_ref_storage_backend(ref_storage_backend))
 			die(_("Unknown ref storage backend %s"),
 			    ref_storage_backend);
@@ -502,6 +503,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
+	register_ref_storage_backends();
+
 	if (requested_ref_storage_backend &&
 	    !ref_storage_backend_exists(requested_ref_storage_backend))
 		die(_("Unknown ref storage backend %s"),
diff --git a/config.c b/config.c
index b95ac3a..025a1ee 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "strbuf.h"
 #include "quote.h"
 #include "hashmap.h"
+#include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
 
@@ -1207,6 +1208,30 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	}
 
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+		char *storage = NULL;
+
+		/*
+		 * make sure we always read the ref storage config
+		 * from the extensions section on startup
+		 */
+		ret += git_config_from_file(ref_storage_backend_config,
+					    repo_config, &storage);
+
+		register_ref_storage_backends();
+		if (!storage)
+			storage = xstrdup("");
+
+		if (!*storage ||
+		    !strcmp(storage, "files")) {
+			/* default backend, nothing to do */
+			free(storage);
+		} else {
+			ref_storage_backend = storage;
+			if (set_ref_storage_backend(ref_storage_backend))
+				die(_("Unknown ref storage backend %s"),
+				    ref_storage_backend);
+		}
+
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
diff --git a/refs.c b/refs.c
index ea7e0eb..dec7b5c 100644
--- a/refs.c
+++ b/refs.c
@@ -14,14 +14,11 @@ static const char split_transaction_fail_warning[] = N_(
 	"transaction succeeded, but then the update to the per-worktree refs "
 	"failed.  Your repository may be in an inconsistent state.");
 
-/*
- * We always have a files backend and it is the default.
- */
 static struct ref_storage_be *the_refs_backend = &refs_be_files;
 /*
  * List of all available backends
  */
-static struct ref_storage_be *refs_backends = &refs_be_files;
+static struct ref_storage_be *refs_backends = NULL;
 
 const char *ref_storage_backend = "files";
 
@@ -1580,3 +1577,11 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	}
 	return the_refs_backend->rename_ref(oldref, newref, logmsg);
 }
+
+void register_ref_storage_backends(void) {
+	/*
+	 * Add register_ref_storage_backend(ptr-to-backend)
+	 * entries below when you add a new backend.
+	 */
+	register_ref_storage_backend(&refs_be_files);
+}
diff --git a/refs.h b/refs.h
index e659882..363c6ee 100644
--- a/refs.h
+++ b/refs.h
@@ -525,4 +525,6 @@ int ref_storage_backend_exists(const char *name);
 
 void register_ref_storage_backend(struct ref_storage_be *be);
 
+void register_ref_storage_backends(void);
+
 #endif /* REFS_H */
-- 
2.4.2.767.g62658d5-twtrsrc
