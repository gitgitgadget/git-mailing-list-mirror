From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 06/48] lockfile.c: add a new public function unable_to_lock_message
Date: Thu, 19 Jun 2014 08:52:48 -0700
Message-ID: <1403193210-6028-7-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxehd-0001G2-1S
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077AbaFSP4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:31 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:40322 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so693191ieb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pyX8TGRcLOKJhWi6Fe0LDsQpuUkWreByXYU5ywid528=;
        b=PqiuoJ6Qrx5dQwdQezV2kmueenRcQxgAk2VOxjFywPQ/UO5SDfPFfFviXBQlGEX6ji
         XrWroK/RPWExrU/pLpupdHSzmrQa/H7AiwcnzplNOojBWW+Wo4GflHHnC58vJ+uVBm9D
         17r9u5Q2ZWTQ0fCbMk9LO4P3T0VbemGhFgxpKDM7GostWMEwXMqtTp636js5uHCT2IKb
         sbLtlTks6hmAniAtZb2LrXzjxMe+Fr4+oSTh12Wwsma/eEzIvZYjfHex51fyQvZIJJFn
         7rLVaYKgkrF9mxPrCvsitoyAyS0IdLvgSyP3O14kLigzIQ3V+C2e86l2z+yedOm2wKEg
         cFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pyX8TGRcLOKJhWi6Fe0LDsQpuUkWreByXYU5ywid528=;
        b=IxFXNyNTtqlVuDyF1EeiZVxeBP9Wdx5QhoddxYE+cWeuh86RG0kyNQKhlyjqhUBLcQ
         uH4IeYMqW8JSwDc1+20OU4XVMYI4u2CXRmeiMNlU7NRNgFNROihvd+j1BdFlDqz7M9SQ
         ms8MTaRUXHCSVTvpmu0PgyncUD1msqvev+B1zPdyrg73XnbER5yRQ4hUFP7VWIctqq8s
         HIHtFfDEYh35XlIoaZrCPJJxRcNBeUwerkwIWEP+ZB1EeFHhcDkRfXx30Ne9bBWbPwD5
         jswsuFhm96690/LYRe5bkPfktNLu/SoTiE+wuB3l2CShPHcjmmj8N9gLvWdZ7HU+c8vs
         rw0g==
X-Gm-Message-State: ALoCoQkT+1VcIAFL0JEc04s2X3SGsHU+hHTjF8VOHMlc0bTaqZN5fbEXPW0WA9Q4iQ7ihZLF3Uqu
X-Received: by 10.42.12.74 with SMTP id x10mr2253277icx.20.1403193213153;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si420403yhi.1.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 03DAD31C3F5;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9F1D4E115F; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252162>

Introducing a new unable_to_lock_message helper, which has nicer
semantics than unable_to_lock_error and cleans up lockfile.c a little.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 cache.h    |  2 ++
 lockfile.c | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index cbe1935..8b12aa8 100644
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
2.0.0.438.g337c581
