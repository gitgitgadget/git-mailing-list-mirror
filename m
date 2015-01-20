From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] move MAXDEPTH definition to the cache.h
Date: Wed, 21 Jan 2015 00:16:37 +0600
Message-ID: <1421777797-14781-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 19:17:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDdMI-0001sZ-Lh
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 19:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbbATSQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 13:16:51 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39699 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbATSQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 13:16:48 -0500
Received: by mail-lb0-f178.google.com with SMTP id u10so4498062lbd.9
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=osXYDdXF5UIOQ4Gt4ZgovC1fNX70m8+eOJd3WdAUPhA=;
        b=Ww2bkDCjHZj++IpaMB+OqqkNASh5ko6k/JMTT+skIQ74E7BnXMBpnfW24kAgcG84jI
         uUkfrs1Vc7a/d5H+yS61J5N/hWUBpYb7yTbVes0BGdmW45D+grcwgw6LFIjeiPHr4jQd
         BYqNGD8ZMIZJxSzAaq0SJZIRSimzF67KHEDn7uBKVeG60VBoH5QFgs3E6F5KUykK9XZ8
         B6icX9J+tCB3BppqBFknJ/TqH7GZnkApRTSa8vnJ4NkfCA4z4ibiUSXDFtzDUVw4juCS
         2m1pzSznI91WYmDDWgpcQzwzhqTwRYZsfUvTC2+KH7sodGEls4/PG6X7eoiGf4wcJ4pv
         ygwg==
X-Received: by 10.112.44.171 with SMTP id f11mr39809146lbm.65.1421777807253;
        Tue, 20 Jan 2015 10:16:47 -0800 (PST)
Received: from localhost.localdomain ([5.251.238.70])
        by mx.google.com with ESMTPSA id wq1sm4194338lbb.24.2015.01.20.10.16.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jan 2015 10:16:46 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.286.ga3dc223.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262679>

There are a couple of source code files as abspath.c, lockfile.c and etc...,
which defines MAXDEPTH macro. All of these definitions are the same, so let's
move MAXDEPTH definition to the <cache.h> instead of directly declaration of
this macro in all these files.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 abspath.c   | 3 ---
 cache.h     | 1 +
 http-push.c | 3 ---
 lockfile.c  | 4 ----
 refs.c      | 2 --
 5 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/abspath.c b/abspath.c
index 5edb4e7..9209522 100644
--- a/abspath.c
+++ b/abspath.c
@@ -11,9 +11,6 @@ int is_directory(const char *path)
 	return (!stat(path, &st) && S_ISDIR(st.st_mode));
 }
 
-/* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXDEPTH 5
-
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
  * and extra slashes removed) equivalent to the specified path.  (If
diff --git a/cache.h b/cache.h
index 64aa287..cac85b7 100644
--- a/cache.h
+++ b/cache.h
@@ -1010,6 +1010,7 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * Caps and underscores refers to the special refs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
  */
+#define MAXDEPTH 5
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
diff --git a/http-push.c b/http-push.c
index 0beb7ab..bb1f82e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -70,9 +70,6 @@ enum XML_Status {
 #define FETCHING (1u<<18)
 #define PUSHING  (1u<<19)
 
-/* We allow "recursive" symbolic refs. Only within reason, though */
-#define MAXDEPTH 5
-
 static int pushing;
 static int aborted;
 static signed char remote_dir_exists[256];
diff --git a/lockfile.c b/lockfile.c
index 9889277..88d0102 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -59,10 +59,6 @@ static void trim_last_path_component(struct strbuf *path)
 	strbuf_setlen(path, i);
 }
 
-
-/* We allow "recursive" symbolic links. Only within reason, though */
-#define MAXDEPTH 5
-
 /*
  * path contains a path that might be a symlink.
  *
diff --git a/refs.c b/refs.c
index 872cb26..c37879f 100644
--- a/refs.c
+++ b/refs.c
@@ -1335,8 +1335,6 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
-/* We allow "recursive" symbolic refs. Only within reason, though */
-#define MAXDEPTH 5
 #define MAXREFLEN (1024)
 
 /*
-- 
2.3.0.rc0.286.ga3dc223.dirty
