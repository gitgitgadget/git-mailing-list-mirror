From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 28/33] refs: register ref storage backends
Date: Mon, 29 Feb 2016 19:53:01 -0500
Message-ID: <1456793586-22082-29-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZr-0007Ie-81
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbcCAAyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:11 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:32778 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbcCAAyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:54:05 -0500
Received: by mail-qg0-f43.google.com with SMTP id d32so74641161qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/AhP8GfbonKljTZsCTMV5DVdL7mXV0AE+8CVN5M3EU=;
        b=AhK9Mj1CvAT0gmNMZB+CsOnjS302o/WDfzMaPkzWU6/H6Bd8jh2rfK6HQW65J5tnJK
         S334iGkXNnVh9VQ2+h+DvFgOZHPbd8qHjASVeYJaZOjYjScq/qqbVb1GIvdyMv7ivSfF
         2GS+cQYLVVpXDy7WaQQvr11sjG3N4kl/4QGICm4xDOxZSBul4YjQBnLTkTYmJJoHmxcD
         ZxAnLVzw0raL6lOD54m7W5Oyzl42BLi2hUnSj+thGzgTMcajOD81C0xJm2HbEA2p4Jn2
         ZiO0Y25gs6g54j+FjkNFe285/0Pay/t8/ciJVixgj7rHBx2Bpjp2pZTeBa9VsXaiOzy5
         OUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/AhP8GfbonKljTZsCTMV5DVdL7mXV0AE+8CVN5M3EU=;
        b=YlhsITIiOq1+2wtBs9cfUd/ihT7StZvAMEPS63tnPza5jCsuAK582ip/2sy/n/IawE
         D05CfgzRQ9kU5c4TButcvgB4rf5P0HM0KYba7CnpO7QYlA/69fLeTMARQCsdfGyFdhGS
         wL2crOn8kwOPE8RcMw1k+o4dPpKHoDKR7BgYtKMhenDJ2lhVOpbU7B5cgA97DcKPCV6E
         2SkRH1mqyaqFa07UJc8Z1+Xn9RQ2phbD2YtFolbWfQ4jBonzjFZT4Y0NnL+W9PI0vnbE
         e46TfbDXNUHS0z3vBCh2QlVqlXfWG5iGKQP0lKxbWdzhqyIpZivOQP9cmQftHn8nQ4Q1
         xYFQ==
X-Gm-Message-State: AD7BkJJwVbadVG7cOOlc+K72vaIY1QsBUF4R8XtuUKebxdTw0w+1bWRgTYww2nI/RmIvhQ==
X-Received: by 10.140.181.130 with SMTP id c124mr24570780qha.75.1456793639566;
        Mon, 29 Feb 2016 16:53:59 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:58 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287963>

Add new function register_ref_storage_backends().  This new function
registers all known ref storage backends... once there are any other
than the default.  For now, it just registers the files backend.

Call the function before calling set_ref_storage_backend.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/init-db.c |  3 +++
 refs.c            | 22 ++++++++++++++++++----
 refs.h            |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index af7fe04..04cc522 100644
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
index 5d69179..5fe0bac 100644
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
+static struct ref_storage_be *refs_backends;
 
 const char *ref_storage_backend = "files";
 
@@ -48,6 +45,23 @@ int ref_storage_backend_exists(const char *name)
 	return find_ref_storage_backend(name) != NULL;
 }
 
+static void register_ref_storage_backend(struct ref_storage_be *be)
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
index 1888ad8..c0964f5 100644
--- a/refs.h
+++ b/refs.h
@@ -523,4 +523,6 @@ int set_ref_storage_backend(const char *name);
 
 int ref_storage_backend_exists(const char *name);
 
+void register_ref_storage_backends(void);
+
 #endif /* REFS_H */
-- 
2.4.2.767.g62658d5-twtrsrc
