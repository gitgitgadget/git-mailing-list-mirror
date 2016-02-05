From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 19/21] refs: add register_ref_storage_backends()
Date: Fri,  5 Feb 2016 14:44:20 -0500
Message-ID: <1454701462-3817-20-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJs-0001hL-1e
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbcBETpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:45:23 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36121 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbcBETpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:45:05 -0500
Received: by mail-qg0-f48.google.com with SMTP id y9so71849896qgd.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MwjLmmy9gKEV+3q+ygKz8tE9TG2j59e9ioRuy/C9hlI=;
        b=nZosQx9NADXmnEdo/3JXmC2Y3qQxZOUTDzGUoi9mFMzC8TasCFhiRF0ifxOnTn8r0e
         6Gb+40ep1KGKo12LaIpo84s/d5T96KRP9SLffP5XaEeCPKuiTCv6bbL/HzHAN+SOY7oc
         RWSIvizQ6GYdpimBOC2Jf78sM3GzI5/oWENPBegXPzk4c0b+RMOEXGV9FmiNVZbEyo9e
         tsse/SGV/V72fWDt97fqzw393e6WF6wyZkImTaBcrK55DF7UHh0A/K6brlq0clID2Bhg
         KWv1QBOnvZ8RfvKquSZRvo8AgKxXGpXe2es39qWJDKsmkhs9LGwkFaBnDmITB9CXBMVp
         QmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MwjLmmy9gKEV+3q+ygKz8tE9TG2j59e9ioRuy/C9hlI=;
        b=fuXJ0L/Lx7dj/b9Oe16gY+oMZFBMOoAJW/TeSX7R8ZAM4r+8nH7ZtGfbfLwEva/GU+
         28wNQtj3MxVssJ0HjpMUggHtmTGXmf4x14ThWW0EUIR03jwKJ6EtI+EwUmyvJsfORNWx
         J5E5Q5/XduWfiZTaLnO0GE/fRe4C5IFVjOA4UJgiCwlt7p5eZtzG57+7GXa7Nm+ThfN6
         cFztlmbiybwAtq7FztBwEK/VMX3rUZRA0X5qJkd6vgLW/XQk5w/YrDIS41E2HBHLJKGR
         An2QfX31KWXSkjzfTOjuYFBGxYz1EYeNmpXBB4SSxGTC5OF4XxFsp6Ezf7mcPTV+wy/8
         9apw==
X-Gm-Message-State: AG10YORWHNKs5s4lO8gpX7P3bNmOmA2ixW7Ln9tdyd/bwX6cbDu+V+EQ9GvvSLB1jH9Xbw==
X-Received: by 10.140.25.169 with SMTP id 38mr18612248qgt.73.1454701504602;
        Fri, 05 Feb 2016 11:45:04 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.45.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:45:03 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285613>

This new function will register all known ref storage backends... once
there are any other than the default.  For now, it's a no-op.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c |  3 +++
 config.c          | 25 +++++++++++++++++++++++++
 refs.c            |  8 ++++++++
 refs.h            |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d331ce8..4209b67 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -226,6 +226,7 @@ static int create_default_files(const char *template_path)
 	if (strcmp(ref_storage_backend, "files")) {
 		git_config_set("extensions.refStorage", ref_storage_backend);
 		git_config_set("core.repositoryformatversion", ref_storage_backend);
+		register_ref_storage_backends();
 		if (set_ref_storage_backend(ref_storage_backend))
 			die(_("Unknown ref storage backend %s"),
 			    ref_storage_backend);
@@ -503,6 +504,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
+	register_ref_storage_backends();
+
 	if (requested_ref_storage_backend &&
 	    !ref_storage_backend_exists(requested_ref_storage_backend))
 		die(_("Unknown ref storage backend %s"),
diff --git a/config.c b/config.c
index b95ac3a..b9ef223 100644
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
+		if ((!*storage) ||
+		    (!strcmp(storage, "files"))) {
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
index 715a492..e50cca0 100644
--- a/refs.c
+++ b/refs.c
@@ -1554,3 +1554,11 @@ done:
 	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
+
+void register_ref_storage_backends(void) {
+	/*
+	 * No need to register the files backend; it's registered by
+	 * default. Add register_ref_storage_backend(ptr-to-backend)
+	 * entries below when you add a new backend.
+	 */
+}
diff --git a/refs.h b/refs.h
index 680a535..81aab6b 100644
--- a/refs.h
+++ b/refs.h
@@ -525,4 +525,6 @@ int ref_storage_backend_exists(const char *name);
 
 void register_ref_storage_backend(struct ref_storage_be *be);
 
+void register_ref_storage_backends(void);
+
 #endif /* REFS_H */
-- 
2.4.2.749.g730654d-twtrsrc
