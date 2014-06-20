From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 06/48] lockfile.c: add a new public function unable_to_lock_message
Date: Fri, 20 Jun 2014 07:42:47 -0700
Message-ID: <1403275409-28173-7-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02i-00017d-MV
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbaFTOnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:47 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:50442 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbaFTOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:32 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so448569pab.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkuCM8XteSTr++Ap3y/lGauyrHGGh/5X9bS4nXU+eVQ=;
        b=aV3aV+5XUx4nq4kD2dW5gLlUnqRREpcH5xu/BQalIEd1a60ndLIbT02NcVzgpKKLdO
         R3s3tzWqjhi/jJjHXGUC/Wm/ikV0XwrCadKUEEjNiHgHMxRoLyxxlyNdHosdrp2s227U
         3dlUymR/93D9FRvP3ahRQTVe0tnHsREl3dXfM7ki21ubJwNQ23FBrnl87TeRzo5AVXWI
         vaAh7qAdJKmGL/z9rGecdkem1o/1sXf5ZWXPGWeysvUSPWONf0xe4lppevyAbUWM237R
         MXurMuuiufD/7xENx2fq4EKpqejeO4NCuLSabmbZhppZldQ5+YlQrLaaWPpd4WhOG1tE
         fStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkuCM8XteSTr++Ap3y/lGauyrHGGh/5X9bS4nXU+eVQ=;
        b=dEAl9/fgCeeCvnmRgFV0DHr31Qz14jTTpn1LN9MY2eke/OU40SP6VqT6SNCrZDIz9z
         NvM68sofWENJOx9djXOTjR7QoIKK5ogMVwsv6bO71vhnQsY0YxNSS0rqIL/bgPCTKpa4
         MFJus3rp6H1jCfA1V8QNal68E1A0GS3UuXA5HoshT0566Ok13wGbtf8PG310hbfwFUxW
         FMQpsiO7dXM4Sig5dd/iQWnShrgXCxDexJK75QdIANsdM1Tuqzx4NSLedlZV7WvJHQ31
         RfbwdRiEVh4BD/Fc3tCv840Il1GTRBr/2IiDvlC9tt0SoW5vejTEMaf45bGs569yad2/
         EYZg==
X-Gm-Message-State: ALoCoQkE1F+LHMfCJ12ClgkUEf2Ht+Gh0h0GJBk7uQgBAHjkgD9c4+XclnFYaQ1JBr+gXWBuffXa
X-Received: by 10.66.220.34 with SMTP id pt2mr1471842pac.8.1403275412378;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si664348yhk.4.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 33BF831C6B4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B4C8EE0A04; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252231>

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
2.0.0.420.g181e020.dirty
