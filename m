From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 06/19] lockfile.c: add a new public function unable_to_lock_message
Date: Mon, 14 Jul 2014 13:58:48 -0700
Message-ID: <1405371541-32121-7-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLR-0002z1-TT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbaGNU70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:26 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:50963 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756935AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so789649oac.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3qKdG8+dsNXNYv6zzF86W+b2A2WAs9BeFs4XFObFO8w=;
        b=BlF+PDLbuPeJL2KlU1HIhZsvrP1tHfjAjD69sdPfISNJwCOlJM6rHM0KY7kWiRPgTl
         t5l4CSN/OAPLsRMR0LKs1RSNFJ8x+bwPhCfl+LdvdQsYETR8TEODcRBeeUXNLCCPpcJI
         hN3C4WQwseNkWiHSDhU+i4LNtfnTq7YAXLSBfkiDAhyFKLRhtCEY/RHhjYbP0bB/gNoH
         gIb9PmOhOUjn7cU8wGlzvH9WToppgx5fSM9qEMNpDeIvlGOTOx7W9w59/XnqwYRgry8c
         n1r8QGTD1LzS9RsSSvxnQ/I1ufkP/aqHU0AZHq7UtbXhwyc67hLo4qp7nupJYWQpI8At
         B/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3qKdG8+dsNXNYv6zzF86W+b2A2WAs9BeFs4XFObFO8w=;
        b=axPaLiGrn/PR17ng1kxwukvhccPfZhyxDYo/8/ZNWAneS0SSKcVgeG4RlK3OWYn2MV
         qwIA2b2vtsjDSCl1ss9NoBEy6aSVIO8yYJHRcDz3316MA8QXPQcKCXsQKCgkj1YaaR8/
         gz6e8dcMHwpNNrV5Pf6Ydr5daVikOBpWNafMDjGWT+IINZCTVEgcwdTO3n3+Qip1+mCJ
         K95p7CzyAtyYJk8jbKdj14YxmhqQsi9Ha1wp04XHTOJFlp3rRqmtGTCSfQLTSpps57Yi
         BzcI/o7qNorJMu+A/j1CXYUHpvv7m2YIa1ZQqTk/ePUh6oc/mjOdIYuRQ1wTn3dmv60x
         2VAw==
X-Gm-Message-State: ALoCoQkU65SgFFfN2YU4B7r5/r79VvPcXarq/Fc68QtgWN7b/8lHIhk8Kfj6ZKgeoe9WMzQb/Oh3
X-Received: by 10.182.49.136 with SMTP id u8mr8688381obn.32.1405371545732;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si822284yhe.2.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 91B5C5A4309;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 260BFE0952; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253521>

Introducing a new unable_to_lock_message helper, which has nicer
semantics than unable_to_lock_error and cleans up lockfile.c a little.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    |  2 ++
 lockfile.c | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index df65231..8a46294 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,8 @@ struct lock_file {
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
 extern int unable_to_lock_error(const char *path, int err);
+extern void unable_to_lock_message(const char *path, int err,
+				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..464031b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -157,33 +157,35 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
-static char *unable_to_lock_message(const char *path, int err)
+void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
-
 	if (err == EEXIST) {
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
+		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 			    absolute_path(path), strerror(err));
 	} else
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
+		strbuf_addf(buf, "Unable to create '%s.lock': %s",
 			    absolute_path(path), strerror(err));
-	return strbuf_detach(&buf, NULL);
 }
 
 int unable_to_lock_error(const char *path, int err)
 {
-	char *msg = unable_to_lock_message(path, err);
-	error("%s", msg);
-	free(msg);
+	struct strbuf buf = STRBUF_INIT;
+
+	unable_to_lock_message(path, err, &buf);
+	error("%s", buf.buf);
+	strbuf_release(&buf);
 	return -1;
 }
 
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
-	die("%s", unable_to_lock_message(path, err));
+	struct strbuf buf = STRBUF_INIT;
+
+	unable_to_lock_message(path, err, &buf);
+	die("%s", buf.buf);
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
-- 
2.0.1.546.gf603308
