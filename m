From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 06/48] lockfile.c: add a new public function unable_to_lock_message
Date: Thu, 12 Jun 2014 10:20:57 -0700
Message-ID: <1402593699-13983-7-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8ha-00074t-9R
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323AbaFLRVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:53 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:59226 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756208AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so309758iec.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Br+2g9p7bXd7EJ2YqkEo6O9EJDM2MDKQXfOkk7wqnNc=;
        b=GC8r6leyKCjWpbf6HS8RSVVVeAft8sA2rB3ZKMirMktdWMgGIJtSo+ltW3qwKTbOKz
         iHUXTs5LTaX7pMVI7y4uGXUqF3QsQ5OtBVi/b/ZcFHjx0kQalPIjEGYWfMph7FrmOFWG
         fQcE72f8Qm7bZkvrfFhEP7ui2mdo+PzwEoQwGBikGLB/A86BUdDPp/SWBG1AjgCYtw9o
         VEK9Lip6u159UKSa3N8RiZNwLaHqwtxVu/tlX5Y3raylpS3vWWbSyDupre/6Yy841zQr
         cwfALWQ7KUXpyodYptvToNljA+xn6ioIblmTERiuITwjUnEB3DbaYXdpphWloaDMC0df
         +a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Br+2g9p7bXd7EJ2YqkEo6O9EJDM2MDKQXfOkk7wqnNc=;
        b=CH/0POn0pLdxw5XUY2R40N3k+OcroMt/5FSZTZkrUGMqHD6gaTnpf9mlWY/PA9XNFd
         Nd3Ai5zxvRsmGz2+SSKO1MVW6SFSDIh2TS0QhT4LpiC3/agrGHTWVw1pBILU83lTI7G6
         iBJzMns2cYCFBVeCXaC9THjEkJagTZLbhCZmNbygHHx0tIRm01VrmK4oxXqlOVfjON2z
         Vsf17NtoDpfRaS1RgN5U6XJjJOWVPtxokS/YDxRwIc7kcQpbPCcofmvVDQU36p0Yccj1
         5sfV6bS2qlg2ECnVDUp+GQDKKegUzoxMMAm8bnTHxuo76tUwytv84h6vcHaFrJyTrtrS
         WXAw==
X-Gm-Message-State: ALoCoQkh28g/TX3kAY1mfZEB0KWo19U4m3Iw0PeBBiwWhnAFUbQKSqJ34+5RIqaWJNp3NkBZr8Bg
X-Received: by 10.182.51.228 with SMTP id n4mr1525376obo.28.1402593703191;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113141yhg.2.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0A35E5A47F2;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 85868E064C; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251425>

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
2.0.0.599.g83ced0e
