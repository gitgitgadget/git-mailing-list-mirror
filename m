From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 06/48] lockfile.c: add a new public function unable_to_lock_message
Date: Tue, 10 Jun 2014 15:28:54 -0700
Message-ID: <1402439376-25839-7-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUao-00073Y-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbaFJWcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:32:12 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:39371 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so132368oac.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zmWrqKGT7OX9E0XJx9MkS5aiyjxrWSIspEP+D/GdptY=;
        b=NyFRKYLkmbWVi1K14fTkROO/KKc01tSMFv3cU+d76098/e9R2kimJ564QKo3h1bkm6
         xssQmsirOA7n4dhjBFCmPIlzSJN6lIg1Yh51oFxEqhIZDpKWp+xNP27BFgGrSZvqmTWi
         qdVnXXB+IVfmlYwk6JgW02XTHyFehOOc46nSN/UJpZx6YUtQpdMJ1UC/f+4NLpFfNb3G
         vn5l4UTqPw6gwi7s5KCPnit9KfFTIbZgXcqkCyi760wPM/Uo5SPasJ+odWO61nCQp1fw
         ZV50SWclA3EzVOnrk/10Sxo/4HwuzDFgPiOfv42rkSihghe/b9HTDsBRdXo2SgdGxJPN
         nhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zmWrqKGT7OX9E0XJx9MkS5aiyjxrWSIspEP+D/GdptY=;
        b=AbkbyJefcXHkkOCq/UNJf5ObEykSpS/WwSaG8BZsuyJ5qqRRw38x/JqErqP4uYjCct
         YnVSBLdAJpCEr0mRfTT7GGuc22MHerInH0DLxKcJTuOfViIf8VU+xEPR2VpBGGqTOl4U
         UHyf6LHcvqF+VF4wO85ojghJpbGBAcTXL3e8GIEIP6+5nLZjbMD92MjBn2+0teVSuIuH
         emZwtOjlk2jyOpDOR41lCXgi2W6AMnUplRmpZl3bKAPfasVHG3PVj0yawNAZFBQ7pu84
         Kz2PEGasZ3MtZrXGAFevWjqLPSQqxcFHyuIKJXETZ6IJo8G5oB5ayvH4SzE/8KFrsK6P
         e+ow==
X-Gm-Message-State: ALoCoQmrzL/G0MxXQWl2gyKgdHyxSI468ciTkTgTvvohutcO4U3Q4DTn7SPlRLXqvi2oqKUTRWiP
X-Received: by 10.182.128.166 with SMTP id np6mr1564533obb.16.1402439380518;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si1395559yhj.5.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5D0155A47F3;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D9A33E0FEC; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251299>

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
2.0.0.574.g30c2c5e
