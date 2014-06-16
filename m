From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 06/48] lockfile.c: add a new public function unable_to_lock_message
Date: Mon, 16 Jun 2014 11:03:37 -0700
Message-ID: <1402941859-29354-7-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbJY-0006Ud-Ls
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbaFPSHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:23 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:64778 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so766256vcb.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yRowO27PNpGExWalJoFCVT21Rc0RDtlvIWTcLMRqHtg=;
        b=BLUwQJN1ktygl5Yeym4W8hCGOHHQPFw3QzWMoR3k3enw5W8UwbwfR9blp5I2rUdXud
         RNJyqOIFtJiKXh+KC2ynGE2JfArp03p4lUBpRqkozJwJiDHjE/oKaYRn+vvbEYDOO4EA
         W5rGVR4bJvTm/V0d+QthOesN/MTqZ91kl32rt/nH8W9pbWysgBoPSkj64qw4sufAM2Xh
         ifrWP6LWSaO27Dr1VK1QvTRmqI9CE7SYDG5NbB7e/VcSmHq4TWRGCWZmo+5QgX8GCLK9
         TV1bU+qKbHP1L7FUOECEBp8WKvkCTzKohZ4W9yMF4k+JQ819/bpbQR5ox4IZJpXc4TG6
         2Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yRowO27PNpGExWalJoFCVT21Rc0RDtlvIWTcLMRqHtg=;
        b=HcWaFck+Qe/ipH5jXUS5eWufWm8Wj/Bhrvj3HBy97e97lXTXUPEc22sKf4wsQ4hPZy
         AA+Yq1rwNqGoGQgV2+JZyBTb+/pK/jZzuIhMOItS6lz7FMvy5AMtTg+TKG7s7EdD+EiW
         f4O+SGUDUAW6arEvz/Fn43IYa4oc1+QRmM3g3fUJE3tY75JLtuutWrKwnCIFVUrvS4Mc
         emhr9o0WiRwPZSl7FPz8fviGZuARdw1OcwiRqvt/ftR9G878yipmeUjOFouoYSZdmnAd
         zHtt9EItFvOLxOm9JwvANPSPPPUzYTjmvmJIDVkP9plyJFxZh+ffhxg0krAl3Nq9SDge
         zV1A==
X-Gm-Message-State: ALoCoQkKA+OtsUHVnzkSoW4r4J/F2XOUb8+tzJmssrHYqGTvdaI9aoMkyE00CWJNzJCZM+YSrlhW
X-Received: by 10.58.29.67 with SMTP id i3mr1251104veh.3.1402941862624;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si998547yhm.0.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 78F025A490D;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0F16BE0D03; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251767>

Introducing a new unable_to_lock_message helper, which has nicer
semantics than unable_to_lock_error and cleans up lockfile.c a little.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 cache.h    |  2 ++
 lockfile.c | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 1e4b4f0..19b0963 100644
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
2.0.0.282.g3799eda.dirty
