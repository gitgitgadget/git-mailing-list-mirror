From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 27/32] refs: register ref storage backends
Date: Wed, 24 Feb 2016 17:58:59 -0500
Message-ID: <1456354744-8022-28-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQ5-0004K3-VS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215AbcBXW7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:49 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34722 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759157AbcBXW7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:45 -0500
Received: by mail-qg0-f44.google.com with SMTP id b67so27016096qgb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oa6HGaGuFwGBvGAEsaX1he6yVgBhPIp+81lc56FSYVY=;
        b=Eu4AjGOG9bzAxFHbVFd4JnMZDyYJqmPDYGu1e8JFaiC2pCyQhKqEeNvluLoWvew2YO
         eq1M/1mVvCcQGeMVCVExopDVZwgneaM4qo9+x5xw/JSju8NP6L0EcPxgq5As2ClzuPnl
         g5GHmv9al4YApW+qEpSW6IcRAOPzcANUvpva/uacWVLMWAUEI6r7bpFaQhzsefi0NWBA
         A3SO2F8DQac7l8+k1kzVjRDIxCGzOqOxH2kxhHjE1Uke/2TPu4dj71exO4s3NmcwLOZJ
         ZQ+SZr3hBxBqkLPvuJ1Ni4naX623yPT1mrfjsfgV0RW99bIudVkkldrwR6ydZF2YlnuM
         cXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oa6HGaGuFwGBvGAEsaX1he6yVgBhPIp+81lc56FSYVY=;
        b=L/872LhMLVnAiN/nhcPJu+OpE/tFnVe3vq6z6zA85X6Rb0eNGs8kEaBNs9oUXOaPln
         fZYa/ii55js7jl8SLhfYJFrnk2bbPIQ0q3CEUVQaYsySpJQK/sZI+xr7+yAenAi0diSd
         KwchzJ/fi56to/Shyy1yxR0Jw/dIRg05BOti0pvomXxpNIceU0UsCGXxpMiWEpRIc8vu
         8yXBWGvd4cniStOyvMn6yrYpaP604CgbGPPthbH/JRmyqqvEx66LQ0H0MBCQSKvRTSNz
         NeMrekSz1gWA7OS4zd0IUhiFk92ideWEzdbKXOHt8IvSX3fQemZJWHlTWjFwEQN3IfwI
         4EeA==
X-Gm-Message-State: AG10YOQ3h6colZAR0AGCQb4ZL3hfRbyL+pPelXcMejE2sh0U8dtwVTHvx/SCeUhzXf2fTw==
X-Received: by 10.140.167.135 with SMTP id n129mr52824272qhn.73.1456354784492;
        Wed, 24 Feb 2016 14:59:44 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287258>

Add new function register_ref_storage_backends().  This new function
registers all known ref storage backends... once there are any other
than the default.  For now, it just registers the files backend.

Call the function before calling set_ref_storage_backend.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/init-db.c |  3 +++
 refs.c            | 22 ++++++++++++++++++----
 refs.h            |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 753cb1c..ddb4c6c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -220,6 +220,7 @@ static int create_default_files(const char *template_path)
 			      requested_ref_storage_backend);
 	}
 
+	register_ref_storage_backends();
 	if (requested_ref_storage_backend)
 		ref_storage_backend = requested_ref_storage_backend;
 	if (strcmp(ref_storage_backend, "files")) {
@@ -502,6 +503,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
+	register_ref_storage_backends();
+
 	if (requested_ref_storage_backend &&
 	    !ref_storage_backend_exists(requested_ref_storage_backend))
 		die(_("Unknown ref storage backend %s"),
diff --git a/refs.c b/refs.c
index 27c82ec..90de086 100644
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
 
@@ -49,6 +46,23 @@ int ref_storage_backend_exists(const char *name)
 	return 0;
 }
 
+void register_ref_storage_backend(struct ref_storage_be *be)
+{
+	be->next = refs_backends;
+	refs_backends = be;
+}
+
+void register_ref_storage_backends(void)
+{
+	if (refs_backends)
+		return;
+	/*
+	 * Add register_ref_storage_backend(ptr-to-backend)
+	 * entries below when you add a new backend.
+	 */
+	register_ref_storage_backend(&refs_be_files);
+}
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 456e729..9cc3a37 100644
--- a/refs.h
+++ b/refs.h
@@ -522,4 +522,6 @@ int set_ref_storage_backend(const char *name);
 
 int ref_storage_backend_exists(const char *name);
 
+void register_ref_storage_backends(void);
+
 #endif /* REFS_H */
-- 
2.4.2.767.g62658d5-twtrsrc
